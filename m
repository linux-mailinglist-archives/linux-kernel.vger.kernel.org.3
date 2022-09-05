Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21145AD3FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiIENeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIENen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:34:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FCCB7C2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:36 -0700 (PDT)
X-UUID: 5df4823749a54531b4be9bec8cf41677-20220905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sL9kXrTMDCO4yvK2qt/npaInteWU0HXqLCHCfKa0eqk=;
        b=a7jXxT4Lf6AVUQL38GUCh7ilgyhJU+RCRuxIweHew8vfnj+4aeZZtoHgbYqBv7Upz+9dVVh7xvOqf52G0rVV6MNGHOadrp7qziI3jipdf1hcyXA0oRp5K2+Fzy6P//Z5mcOAz2t4VLGxylVQiDKqokwgawM2PsXsUhCHNaC7UnU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:777e01d5-ab63-4b66-8ff2-0c3b9c314404,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.10,REQID:777e01d5-ab63-4b66-8ff2-0c3b9c314404,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:90
X-CID-META: VersionHash:84eae18,CLOUDID:2de63b21-1c20-48a5-82a0-25f9c331906d,C
        OID:b9f9e2cb8ea3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5df4823749a54531b4be9bec8cf41677-20220905
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1899255352; Mon, 05 Sep 2022 21:34:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 5 Sep 2022 21:34:28 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 5 Sep 2022 21:34:28 +0800
From:   <xinlei.lee@mediatek.com>
To:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <rex-bc.chen@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <chunkuang.hu@kernel.org>, <yongqiang.niu@mediatek.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v5,1/2] soc: mediatek: Add mmsys func to adapt to dpi output for MT8186
Date:   Mon, 5 Sep 2022 21:34:22 +0800
Message-ID: <1662384863-17281-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1662384863-17281-1-git-send-email-xinlei.lee@mediatek.com>
References: <1662384863-17281-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Nílas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h    |  1 +
 drivers/soc/mediatek/mtk-mmsys.c       | 16 ++++++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
index eb1ad9c37a9c..3db0806647c3 100644
--- a/drivers/soc/mediatek/mt8186-mmsys.h
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -3,6 +3,7 @@
 #ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
 #define __SOC_MEDIATEK_MT8186_MMSYS_H
 
+#define MT8186_MMSYS_DPI_OUTPUT_FORMAT		0x400
 #define MT8186_MMSYS_OVL_CON			0xF04
 #define MT8186_MMSYS_OVL0_CON_MASK			0x3
 #define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 06d8e83a2cb5..d7d17d4a9a5d 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -227,6 +227,22 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
+{
+	u32 tmp;
+
+	tmp = readl_relaxed(mmsys->regs + offset);
+	tmp = (tmp & ~mask) | val;
+	writel_relaxed(tmp, mmsys->regs + offset);
+}
+
+void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 mask, u32 val)
+{
+	mtk_mmsys_update_bits(dev_get_drvdata(dev), MT8186_MMSYS_DPI_OUTPUT_FORMAT, mask,
+			      val);
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_fmt_config);
+
 static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
 				  bool assert)
 {
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 59117d970daf..7a378d247505 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -65,4 +65,6 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
 
+void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 mask, u32 val);
+
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

