Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819D54893AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiAJIhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:37:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52888 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241439AbiAJIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:35:03 -0500
X-UUID: 729c5679abef4e63b0293f366668b2ba-20220110
X-UUID: 729c5679abef4e63b0293f366668b2ba-20220110
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 475782770; Mon, 10 Jan 2022 16:34:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 10 Jan 2022 16:34:57 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 16:34:56 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
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
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4, 08/15] media: mtk-vcodec: Add format to support MT21C
Date:   Mon, 10 Jan 2022 16:34:35 +0800
Message-ID: <20220110083442.32604-9-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110083442.32604-1-yunfei.dong@mediatek.com>
References: <20220110083442.32604-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needs to use mediatek compressed mode for mt8192 decoder.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c   | 7 ++++++-
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h         | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
index 01bb96f3b30e..21895fbed4c5 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
@@ -81,7 +81,7 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
 
 #define NUM_CTRLS ARRAY_SIZE(mtk_stateless_controls)
 
-static struct mtk_video_fmt mtk_video_formats[2];
+static struct mtk_video_fmt mtk_video_formats[3];
 static struct mtk_codec_framesizes mtk_vdec_framesizes[1];
 
 static struct mtk_video_fmt default_out_format;
@@ -361,6 +361,7 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 		num_framesizes++;
 		break;
 	case V4L2_PIX_FMT_MM21:
+	case V4L2_PIX_FMT_MT21C:
 		mtk_video_formats[count_formats].fourcc = fourcc;
 		mtk_video_formats[count_formats].type = MTK_FMT_FRAME;
 		mtk_video_formats[count_formats].num_planes = 2;
@@ -387,6 +388,10 @@ static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
 		mtk_vcodec_add_formats(V4L2_PIX_FMT_MM21, ctx);
 		cap_format_count++;
 	}
+	if (ctx->dev->dec_capability & MTK_VDEC_FORMAT_MT21C) {
+		mtk_vcodec_add_formats(V4L2_PIX_FMT_MT21C, ctx);
+		cap_format_count++;
+	}
 	if (ctx->dev->dec_capability & MTK_VDEC_FORMAT_H264_SLICE) {
 		mtk_vcodec_add_formats(V4L2_PIX_FMT_H264_SLICE, ctx);
 		out_format_count++;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index cdc0a53eee4e..12a2baaf9e81 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -353,6 +353,7 @@ enum mtk_vdec_hw_arch {
  */
 enum mtk_vdec_format_types {
 	MTK_VDEC_FORMAT_MM21 = 0x20,
+	MTK_VDEC_FORMAT_MT21C = 0x40,
 	MTK_VDEC_FORMAT_H264_SLICE = 0x100,
 };
 
-- 
2.25.1

