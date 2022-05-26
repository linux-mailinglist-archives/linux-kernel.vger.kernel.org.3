Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF686534CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346603AbiEZJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbiEZJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:57:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF0BC967F;
        Thu, 26 May 2022 02:57:50 -0700 (PDT)
X-UUID: a4eab63d2ff046e2bea7a3e9ff2a5e94-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:272e1aa1-cd5a-4d31-9715-0a34bda81cf8,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:272e1aa1-cd5a-4d31-9715-0a34bda81cf8,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:939657b8-3c45-407b-8f66-25095432a27a,C
        OID:c4d81cfbf3df,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: a4eab63d2ff046e2bea7a3e9ff2a5e94-20220526
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 484470111; Thu, 26 May 2022 17:57:46 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 17:57:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 May 2022 17:57:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 26 May 2022 17:57:42 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 3/4] media: mediatek: vcodec: Fix encoder v4l2 bus_info not correctly
Date:   Thu, 26 May 2022 17:57:36 +0800
Message-ID: <20220526095737.21118-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526095737.21118-1-yunfei.dong@mediatek.com>
References: <20220526095737.21118-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix v4l2 capability bus_info value with correct chip name according to compatible.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index c21367038c34..8ece3596081a 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -204,11 +204,30 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *priv,
 			       pdata->num_output_formats);
 }
 
+static int mtk_vcodec_enc_get_chip_name(void *priv)
+{
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct device *dev = &ctx->dev->plat_dev->dev;
+
+	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-enc"))
+		return 8173;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-enc"))
+		return 8183;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-enc"))
+		return 8192;
+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-enc"))
+		return 8195;
+	else
+		return 8173;
+}
+
 static int vidioc_venc_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
+	int platform_name = mtk_vcodec_enc_get_chip_name(priv);
+
 	strscpy(cap->driver, MTK_VCODEC_ENC_NAME, sizeof(cap->driver));
-	strscpy(cap->bus_info, MTK_PLATFORM_STR, sizeof(cap->bus_info));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d", platform_name);
 	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
 
 	return 0;
-- 
2.18.0

