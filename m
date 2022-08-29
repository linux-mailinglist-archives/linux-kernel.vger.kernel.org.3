Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405E05A4170
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiH2DWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiH2DWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:22:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C43F337
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:22:17 -0700 (PDT)
X-UUID: 543e037b0d4345218f0e89905f668876-20220829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wiLVJAwGQhwMt7MB3fwCSUOLx+Ww3tVxdxRlhzFknHM=;
        b=XNaugJvRF0bXtSO0g9dc0Nc2nxN1upIb5vTorHifxRopYV8mJ+3VMcXZkb8lRLzlNEQh+B4jDPGbbnSSWWKl/oUuE0we91/yhinF2UbUTWVSGSk01rQVs31qPPjevz7+vTFLPUYJuVJ5julsbnIuv+Bn+8za0PCShSp6utYe5xU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:e46f1715-5f36-4c78-8fa2-475a9ec07f3f,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:e46f1715-5f36-4c78-8fa2-475a9ec07f3f,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:ef085f20-1c20-48a5-82a0-25f9c331906d,C
        OID:7950123255f7,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 543e037b0d4345218f0e89905f668876-20220829
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 713171173; Mon, 29 Aug 2022 11:22:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 29 Aug 2022 11:22:08 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 29 Aug 2022 11:22:07 +0800
From:   <xinlei.lee@mediatek.com>
To:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <rex-bc.chen@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <enric.balletbo@collabora.com>, <yongqiang.niu@mediatek.com>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <jitao.shi@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v4,1/2] soc: mediatek: Add mmsys func to adapt to dpi output for MT8186
Date:   Mon, 29 Aug 2022 11:21:47 +0800
Message-ID: <1661743308-29120-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1661743308-29120-1-git-send-email-xinlei.lee@mediatek.com>
References: <1661743308-29120-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Add mmsys func to manipulate dpi output format config for MT8186.

Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h    | 1 +
 drivers/soc/mediatek/mtk-mmsys.c       | 8 ++++++++
 include/linux/soc/mediatek/mtk-mmsys.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
index eb1ad9c37a9c..6eca3445bea3 100644
--- a/drivers/soc/mediatek/mt8186-mmsys.h
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -3,6 +3,7 @@
 #ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
 #define __SOC_MEDIATEK_MT8186_MMSYS_H
 
+#define MT8186_DPI_OUTPUT_FORMAT		0x400
 #define MT8186_MMSYS_OVL_CON			0xF04
 #define MT8186_MMSYS_OVL0_CON_MASK			0x3
 #define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 9bbf0103b225..d5305cff51cc 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -252,6 +252,14 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 mask, u32 val,
+				   struct cmdq_pkt *cmdq_pkt)
+{
+	mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_DPI_OUTPUT_FORMAT, mask,
+			      val, cmdq_pkt);
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_fmt_config);
+
 void mtk_mmsys_merge_async_config(struct device *dev, int idx, int width, int height,
 				  struct cmdq_pkt *cmdq_pkt)
 {
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 7a73305390ba..70bb58fbd837 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -89,4 +89,7 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
 void mtk_mmsys_mixer_in_channel_swap(struct device *dev, int idx, bool channel_swap,
 				     struct cmdq_pkt *cmdq_pkt);
 
+void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 mask, u32 val,
+				   struct cmdq_pkt *cmdq_pkt);
+
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

