Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4A5242FA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiELDF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbiELDFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:05:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D141FD866
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:05:18 -0700 (PDT)
X-UUID: a4224918e2cc4fe893c3005113a37708-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:332f6d3b-872d-4b82-b2e7-2a7c552e3db3,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:85
X-CID-INFO: VERSION:1.1.4,REQID:332f6d3b-872d-4b82-b2e7-2a7c552e3db3,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:85
X-CID-META: VersionHash:faefae9,CLOUDID:19314325-b432-452e-9e03-2bf3148aed85,C
        OID:909057ca2822,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: a4224918e2cc4fe893c3005113a37708-20220512
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1235345875; Thu, 12 May 2022 11:05:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 11:05:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 12 May 2022 11:05:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        <chun-jie.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH v2] soc: mediatek: Add support always on flag
Date:   Thu, 12 May 2022 11:05:10 +0800
Message-ID: <20220512030510.29787-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
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
v2: keep active_wakeup flag for mt8195
---
 drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
 drivers/soc/mediatek/mtk-pm-domains.c    | 2 ++
 drivers/soc/mediatek/mtk-pm-domains.h    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

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
index 5ced254b082b..7ae43a29fb8d 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -447,6 +447,8 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_ACTIVE_WAKEUP))
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+	if (MTK_SCPD_CAPS(pd, MTK_SCPD_ALWAYS_ON))
+		pd->genpd.flags |= GENPD_FLAG_ALWAYS_ON;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_KEEP_DEFAULT_OFF))
 		pm_genpd_init(&pd->genpd, NULL, true);
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index daa24e890dd4..419d23d5e394 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -8,6 +8,7 @@
 #define MTK_SCPD_SRAM_ISO		BIT(2)
 #define MTK_SCPD_KEEP_DEFAULT_OFF	BIT(3)
 #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
+#define MTK_SCPD_ALWAYS_ON		BIT(5)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
 
 #define SPM_VDE_PWR_CON			0x0210
-- 
2.18.0

