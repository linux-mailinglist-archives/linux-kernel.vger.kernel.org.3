Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D512581E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbiG0Dyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbiG0DyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:54:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF913DF19;
        Tue, 26 Jul 2022 20:54:22 -0700 (PDT)
X-UUID: a5d29b56fcb24cbb81ef92c2520ae17b-20220727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:5e34e552-86d7-4eff-9415-93bf06860530,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:d43e9ab3-06d2-48ef-b2dd-540836705165,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a5d29b56fcb24cbb81ef92c2520ae17b-20220727
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1275095412; Wed, 27 Jul 2022 11:54:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 27 Jul 2022 11:54:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 27 Jul 2022 11:54:12 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <mason.zhang@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <eddie.huang@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <cc.chou@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v2 5/5] scsi: ufs: ufs-medaitek: Support clk-scaling to optimize power consumption
Date:   Wed, 27 Jul 2022 11:44:54 +0800
Message-ID: <20220727034454.31892-6-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220727034454.31892-1-stanley.chu@mediatek.com>
References: <20220727034454.31892-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Po-Wen Kao <powen.kao@mediatek.com>

Provide clk-scaling feature in MediaTek UFS platforms.

MediaTek platform supports clk-scaling by switching parent clock
mux of UFSHCI main clocks: ufs_sel.

The driver needs to prevent changing the rate of ufs_sel because
its parent PLL clock may be shared between multiple IPs. In order
to achieve this goal, the maximum and minimum clock rates of ufs_sel
defined in dts should match the rate of "ufs_sel_max_src" and
"ufs_sel_min_src" respectively.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek-trace.h |  25 +++++-
 drivers/ufs/host/ufs-mediatek.c       | 118 ++++++++++++++++++++++++++
 drivers/ufs/host/ufs-mediatek.h       |   7 ++
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-mediatek-trace.h b/drivers/ufs/host/ufs-mediatek-trace.h
index 7e010848dc99..2e68c7dbc624 100644
--- a/drivers/ufs/host/ufs-mediatek-trace.h
+++ b/drivers/ufs/host/ufs-mediatek-trace.h
@@ -26,7 +26,30 @@ TRACE_EVENT(ufs_mtk_event,
 
 	TP_printk("ufs:event=%u data=%u",
 		  __entry->type, __entry->data)
-	);
+);
+
+TRACE_EVENT(ufs_mtk_clk_scale,
+	TP_PROTO(const char *name, bool scale_up, uint64_t clk_rate),
+	TP_ARGS(name, scale_up, clk_rate),
+
+	TP_STRUCT__entry(
+		__field(const char*, name)
+		__field(bool, scale_up)
+		__field(uint64_t, clk_rate)
+	),
+
+	TP_fast_assign(
+		__entry->name = name;
+		__entry->scale_up = scale_up;
+		__entry->clk_rate = clk_rate;
+	),
+
+	TP_printk("ufs: clk (%s) scaled %s @%d",
+		  __entry->name,
+		  __entry->scale_up ? "up" : "down",
+		  __entry->clk_rate)
+);
+
 #endif
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index b2e4a9fd4be8..ba068f4c5519 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -700,6 +700,46 @@ static u32 ufs_mtk_get_ufs_hci_version(struct ufs_hba *hba)
 	return hba->ufs_version;
 }
 
+/**
+ * ufs_mtk_init_clocks - Init mtk driver private clocks
+ *
+ * @hba: per adapter instance
+ */
+static void ufs_mtk_init_clocks(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+	struct list_head *head = &hba->clk_list_head;
+	struct ufs_mtk_clk *mclk = &host->mclk;
+	struct ufs_clk_info *clki, *clki_tmp;
+
+	/*
+	 * Find private clocks and store them in struct ufs_mtk_clk.
+	 * Remove "ufs_sel_min_src" and "ufs_sel_min_src" from list to avoid
+	 * being switched on/off in clock gating.
+	 */
+	list_for_each_entry_safe(clki, clki_tmp, head, list) {
+		if (!strcmp(clki->name, "ufs_sel")) {
+			host->mclk.ufs_sel_clki = clki;
+		} else if (!strcmp(clki->name, "ufs_sel_max_src")) {
+			host->mclk.ufs_sel_max_clki = clki;
+			clk_disable_unprepare(clki->clk);
+			list_del(&clki->list);
+		} else if (!strcmp(clki->name, "ufs_sel_min_src")) {
+			host->mclk.ufs_sel_min_clki = clki;
+			clk_disable_unprepare(clki->clk);
+			list_del(&clki->list);
+		}
+	}
+
+	if (!mclk->ufs_sel_clki || !mclk->ufs_sel_max_clki ||
+	    !mclk->ufs_sel_min_clki) {
+		hba->caps &= ~UFSHCD_CAP_CLK_SCALING;
+		dev_info(hba->dev,
+			 "%s: Clk-scaling not ready. Feature disabled.",
+			 __func__);
+	}
+}
+
 #define MAX_VCC_NAME 30
 static int ufs_mtk_vreg_fix_vcc(struct ufs_hba *hba)
 {
@@ -820,12 +860,18 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 
 	/* Enable WriteBooster */
 	hba->caps |= UFSHCD_CAP_WB_EN;
+
+	/* Enable clk scaling*/
+	hba->caps |= UFSHCD_CAP_CLK_SCALING;
+
 	hba->quirks |= UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL;
 	hba->vps->wb_flush_threshold = UFS_WB_BUF_REMAIN_PERCENT(80);
 
 	if (host->caps & UFS_MTK_CAP_DISABLE_AH8)
 		hba->caps |= UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
 
+	ufs_mtk_init_clocks(hba);
+
 	/*
 	 * ufshcd_vops_init() is invoked after
 	 * ufshcd_setup_clock(true) in ufshcd_hba_init() thus
@@ -1346,6 +1392,76 @@ static void ufs_mtk_event_notify(struct ufs_hba *hba,
 	}
 }
 
+static void ufs_mtk_config_scaling_param(struct ufs_hba *hba,
+				struct devfreq_dev_profile *profile,
+				struct devfreq_simple_ondemand_data *data)
+{
+	/* Customize min gear in clk scaling */
+	hba->clk_scaling.min_gear = UFS_HS_G4;
+
+	hba->vps->devfreq_profile.polling_ms = 200;
+	hba->vps->ondemand_data.upthreshold = 50;
+	hba->vps->ondemand_data.downdifferential = 20;
+}
+
+/**
+ * ufs_mtk_clk_scale - Internal clk scaling operation
+ *
+ * MTK platform supports clk scaling by switching parent of ufs_sel(mux).
+ * The ufs_sel downstream to ufs_ck which feeds directly to UFS hardware.
+ * Max and min clocks rate of ufs_sel defined in dts should match rate of
+ * "ufs_sel_max_src" and "ufs_sel_min_src" respectively.
+ * This prevent changing rate of pll clock that is shared between modules.
+ *
+ * @hba: per adapter instance
+ * @scale_up: True for scaling up and false for scaling down
+ */
+static void ufs_mtk_clk_scale(struct ufs_hba *hba, bool scale_up)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+	struct ufs_mtk_clk *mclk = &host->mclk;
+	struct ufs_clk_info *clki = mclk->ufs_sel_clki;
+	int ret = 0;
+
+	ret = clk_prepare_enable(clki->clk);
+	if (ret) {
+		dev_info(hba->dev,
+			 "clk_prepare_enable() fail, ret: %d\n", ret);
+		return;
+	}
+
+	if (scale_up) {
+		ret = clk_set_parent(clki->clk, mclk->ufs_sel_max_clki->clk);
+		clki->curr_freq = clki->max_freq;
+	} else {
+		ret = clk_set_parent(clki->clk, mclk->ufs_sel_min_clki->clk);
+		clki->curr_freq = clki->min_freq;
+	}
+
+	if (ret) {
+		dev_info(hba->dev,
+			 "Failed to set ufs_sel_clki, ret: %d\n", ret);
+	}
+
+	clk_disable_unprepare(clki->clk);
+
+	trace_ufs_mtk_clk_scale(clki->name, scale_up, clk_get_rate(clki->clk));
+}
+
+static int ufs_mtk_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
+				    enum ufs_notify_change_status status)
+{
+	if (status == PRE_CHANGE) {
+		/* Switch parent before clk_set_rate() */
+		ufs_mtk_clk_scale(hba, scale_up);
+	} else {
+		/* Request interrupt latency QoS accordingly */
+		ufs_mtk_scale_perf(hba, scale_up);
+	}
+
+	return 0;
+}
+
 /*
  * struct ufs_hba_mtk_vops - UFS MTK specific variant operations
  *
@@ -1367,6 +1483,8 @@ static const struct ufs_hba_variant_ops ufs_hba_mtk_vops = {
 	.dbg_register_dump   = ufs_mtk_dbg_register_dump,
 	.device_reset        = ufs_mtk_device_reset,
 	.event_notify        = ufs_mtk_event_notify,
+	.config_scaling_param = ufs_mtk_config_scaling_param,
+	.clk_scale_notify    = ufs_mtk_clk_scale_notify,
 };
 
 /**
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index 9017ab8f9867..c7ab9971b550 100644
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -162,6 +162,12 @@ struct ufs_mtk_crypt_cfg {
 	int vcore_volt;
 };
 
+struct ufs_mtk_clk {
+	struct ufs_clk_info *ufs_sel_clki; /* Mux */
+	struct ufs_clk_info *ufs_sel_max_clki; /* Max src */
+	struct ufs_clk_info *ufs_sel_min_clki; /* Min src */
+};
+
 struct ufs_mtk_hw_ver {
 	u8 step;
 	u8 minor;
@@ -177,6 +183,7 @@ struct ufs_mtk_host {
 	struct reset_control *crypto_reset;
 	struct ufs_hba *hba;
 	struct ufs_mtk_crypt_cfg *crypt;
+	struct ufs_mtk_clk mclk;
 	struct ufs_mtk_hw_ver hw_ver;
 	enum ufs_mtk_host_caps caps;
 	bool mphy_powered_on;
-- 
2.18.0

