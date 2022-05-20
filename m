Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFB52E2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbiETDEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiETDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:04:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EC63BD0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:03:57 -0700 (PDT)
X-UUID: 1298b89a944d442a916f18bf3db86044-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:db155855-e169-45a1-bccd-5a115a95ca12,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:833ae1e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 1298b89a944d442a916f18bf3db86044-20220520
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 395612703; Fri, 20 May 2022 11:03:54 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 11:03:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 11:03:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 11:03:41 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Min Guo <min.guo@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [v3 PATCH] soc: mediatek: Add support always on flag
Date:   Fri, 20 May 2022 11:03:40 +0800
Message-ID: <20220520030340.25444-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a t-phy shared by PCIe and USB3 on mt8195, if the t-phy is
used by PCIe, when power off its mtcmos, need software reset it
(workaround way, usually hardware do it, but has an issue on mt8195),
but it has side effect to USB2 phy(works with USB3 phy to support
USB3.2 Gen1), so add support GENPD_FLAG_ALWAYS_ON flag, and make its
power always on;
Another reason is that USB3.2 Gen1/2 need keep power always on when
support runtime-pm due to hardware limitation until now;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: make always-on flag exclusive with defualt-off flag

v2: keep active_wakeup flag for mt8195
---
 drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
 drivers/soc/mediatek/mtk-pm-domains.c    | 3 +++
 drivers/soc/mediatek/mtk-pm-domains.h    | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/soc/mediatek/mt8195-pm-domains.h
index 938f4d51f5ae..0529d130b675 100644
--- a/drivers/soc/mediatek/mt8195-pm-domains.h
+++ b/drivers/soc/mediatek/mt8195-pm-domains.h
@@ -67,7 +67,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 		.ctl_offs = 0x334,
 		.pwr_sta_offs = 0x174,
 		.pwr_sta2nd_offs = 0x178,
-		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_ALWAYS_ON,
 	},
 	[MT8195_POWER_DOMAIN_CSI_RX_TOP] = {
 		.name = "csi_rx_top",
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 5ced254b082b..a3dae391a38a 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -428,6 +428,9 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 			dev_err(scpsys->dev, "%pOF: failed to power on domain: %d\n", node, ret);
 			goto err_put_subsys_clocks;
 		}
+
+		if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
+			pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 	}
 
 	if (scpsys->domains[id]) {
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index daa24e890dd4..7d3c0c36316c 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -8,6 +8,8 @@
 #define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
 #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
+/* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
+#define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.18.0

