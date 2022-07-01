Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC256297A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 05:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiGADQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 23:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiGADP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:15:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED943ADF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 20:15:57 -0700 (PDT)
X-UUID: 598743e7a79249159b42a0a1608b3810-20220701
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:dea7567e-2b3c-4f95-a3cb-a5094238ecf8,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.7,REQID:dea7567e-2b3c-4f95-a3cb-a5094238ecf8,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:87442a2,CLOUDID:34ab1d63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:8b87758a67c3,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 598743e7a79249159b42a0a1608b3810-20220701
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 746255461; Fri, 01 Jul 2022 11:15:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 1 Jul 2022 11:15:53 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 11:15:52 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <yongqiang.niu@mediatek.com>, <enric.balletbo@collabora.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH 1/2] soc: mediatek: Add mmsys func to adapt to dpi output for MT8186
Date:   Fri, 1 Jul 2022 11:15:43 +0800
Message-ID: <1656645344-12062-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1656645344-12062-1-git-send-email-xinlei.lee@mediatek.com>
References: <1656645344-12062-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Add mmsys func to manipulate dpi output format config for MT8186.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h    | 1 +
 drivers/soc/mediatek/mtk-mmsys.c       | 8 ++++++++
 include/linux/soc/mediatek/mtk-mmsys.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
index eb1ad9c37a9c..0b450b00b829 100644
--- a/drivers/soc/mediatek/mt8186-mmsys.h
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -3,6 +3,7 @@
 #ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
 #define __SOC_MEDIATEK_MT8186_MMSYS_H
 
+#define MT8186_MMSYS_DUMMY0			0X400
 #define MT8186_MMSYS_OVL_CON			0xF04
 #define MT8186_MMSYS_OVL0_CON_MASK			0x3
 #define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 2b0b805c65dd..de3f11cb931f 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -252,6 +252,14 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+void mtk_mmsys_ddp_dpi_confing(struct device *dev, u32 mask, u32 val,
+			       struct cmdq_pkt *cmdq_pkt)
+{
+	mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DUMMY0, mask,
+			      val, cmdq_pkt);
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_confing);
+
 void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width, int height,
 				  struct cmdq_pkt *cmdq_pkt)
 {
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 343e093f0fc3..40c538c0664b 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -90,4 +90,6 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
 void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap,
 				     struct cmdq_pkt *cmdq_pkt);
 
+void mtk_mmsys_ddp_dpi_confing(struct device *dev, u32 mask, u32 val,
+			       struct cmdq_pkt *cmdq_pkt);
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

