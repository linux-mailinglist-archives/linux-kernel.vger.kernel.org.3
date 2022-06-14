Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0054B2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbiFNORZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbiFNORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4933884;
        Tue, 14 Jun 2022 07:17:05 -0700 (PDT)
X-UUID: fe6df8552cc243309f6df746366e65c4-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:64430d55-9727-45af-880e-9720538b26b6,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:48766cc5-c67b-4a73-9b18-726dd8f2eb58,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: fe6df8552cc243309f6df746366e65c4-20220614
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1586316781; Tue, 14 Jun 2022 22:16:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 22:16:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Jun 2022 22:16:57 +0800
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
Subject: [PATCH v3 10/10] scsi: ufs-mediatek: Support multiple VCC sources
Date:   Tue, 14 Jun 2022 22:16:55 +0800
Message-ID: <20220614141655.14409-11-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614141655.14409-1-stanley.chu@mediatek.com>
References: <20220614141655.14409-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple VCC source in MediaTek UFS platforms.

Two options are provided and distinguished by specific
device tree attributes as below examples,

[Option 1: By numbering]
mediatek,ufs-vcc-by-num;
vcc-opt1-supply = <&mt6373_vbuck4_ufs>;
vcc-opt2-supply = <&mt6363_vemc>;

[Option 2: By UFS version]
mediatek,ufs-vcc-by-ver;
vcc-ufs3-supply = <&mt6373_vbuck4_ufs>;

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/host/ufs-mediatek.c | 46 +++++++++++++++++++++++++++++++++
 drivers/ufs/host/ufs-mediatek.h | 14 ++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 2c1e55f8d7c6..a029ec2fc971 100755
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -669,6 +669,50 @@ static u32 ufs_mtk_get_ufs_hci_version(struct ufs_hba *hba)
 	return hba->ufs_version;
 }
 
+#define MAX_VCC_NAME 30
+static int ufs_mtk_vreg_fix_vcc(struct ufs_hba *hba)
+{
+	struct ufs_vreg_info *info = &hba->vreg_info;
+	struct device_node *np = hba->dev->of_node;
+	struct device *dev = hba->dev;
+	char vcc_name[MAX_VCC_NAME];
+	struct arm_smccc_res res;
+	int err = 0;
+	int ver;
+
+	if (hba->vreg_info.vcc)
+		return 0;
+
+	if (of_property_read_bool(np, "mediatek,ufs-vcc-by-num")) {
+		ufs_mtk_get_vcc_num(res);
+		if (res.a1 > UFS_VCC_NONE && res.a1 < UFS_VCC_MAX)
+			snprintf(vcc_name, MAX_VCC_NAME, "vcc-opt%u", res.a1);
+		else
+			return -ENODEV;
+	} else if (of_property_read_bool(np, "mediatek,ufs-vcc-by-ver")) {
+		ver = (hba->dev_info.wspecversion & 0xF00) >> 8;
+		snprintf(vcc_name, MAX_VCC_NAME, "vcc-ufs%u", ver);
+	} else {
+		return 0;
+	}
+
+	err = ufshcd_populate_vreg(dev, vcc_name, &info->vcc);
+	if (err)
+		return err;
+
+	err = ufshcd_get_vreg(dev, info->vcc);
+	if (err)
+		return err;
+
+	err = regulator_enable(info->vcc->reg);
+	if (!err) {
+		info->vcc->enabled = true;
+		dev_info(dev, "%s: %s enabled\n", __func__, vcc_name);
+	}
+
+	return err;
+}
+
 /**
  * ufs_mtk_init - find other essential mmio bases
  * @hba: host controller instance
@@ -1179,6 +1223,8 @@ static int ufs_mtk_apply_dev_quirks(struct ufs_hba *hba)
 		ufs_mtk_setup_ref_clk_wait_us(hba,
 					      REFCLK_DEFAULT_WAIT_US);
 
+	ufs_mtk_vreg_fix_vcc(hba);
+
 	return 0;
 }
 
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index eb26306a719f..b72007ecba05 100755
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -83,6 +83,7 @@ enum {
 #define UFS_MTK_SIP_DEVICE_RESET          BIT(1)
 #define UFS_MTK_SIP_CRYPTO_CTRL           BIT(2)
 #define UFS_MTK_SIP_REF_CLK_NOTIFICATION  BIT(3)
+#define UFS_MTK_SIP_GET_VCC_NUM           BIT(6)
 #define UFS_MTK_SIP_DEVICE_PWR_CTRL       BIT(7)
 
 /*
@@ -144,6 +145,16 @@ struct ufs_mtk_host {
 	u32 ip_ver;
 };
 
+/*
+ * Multi-VCC by Numbering
+ */
+enum ufs_mtk_vcc_num {
+	UFS_VCC_NONE = 0,
+	UFS_VCC_1,
+	UFS_VCC_2,
+	UFS_VCC_MAX
+};
+
 /*
  * SMC call wapper function
  */
@@ -200,6 +211,9 @@ struct ufs_mtk_host {
 #define ufs_mtk_device_reset_ctrl(high, res) \
 	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_RESET, res, high)
 
+#define ufs_mtk_get_vcc_num(res) \
+	ufs_mtk_smc(UFS_MTK_SIP_GET_VCC_NUM, res)
+
 #define ufs_mtk_device_pwr_ctrl(on, ufs_ver, res) \
 	ufs_mtk_smc(UFS_MTK_SIP_DEVICE_PWR_CTRL, res, on, ufs_ver)
 
-- 
2.18.0

