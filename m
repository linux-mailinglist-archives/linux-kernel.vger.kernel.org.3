Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DB549F1C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbiA1DXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:23:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46482 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345661AbiA1DXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:23:39 -0500
X-UUID: fd7f82c684c845a486f90e22294f715f-20220128
X-UUID: fd7f82c684c845a486f90e22294f715f-20220128
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1175534248; Fri, 28 Jan 2022 11:23:35 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 28 Jan 2022 11:23:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 Jan
 2022 11:23:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 11:23:31 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] media: uapi: Init VP9 stateless decode params
Date:   Fri, 28 Jan 2022 11:23:30 +0800
Message-ID: <20220128032330.24045-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init some of VP9 frame decode params to default value.

Fixes: b88dbe38dca8 ("media: uapi: Add VP9 stateless decoder controls")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 54abe5245dcc..b25c77b8a445 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -112,6 +112,7 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	struct v4l2_ctrl_mpeg2_picture *p_mpeg2_picture;
 	struct v4l2_ctrl_mpeg2_quantisation *p_mpeg2_quant;
 	struct v4l2_ctrl_vp8_frame *p_vp8_frame;
+	struct v4l2_ctrl_vp9_frame *p_vp9_frame;
 	struct v4l2_ctrl_fwht_params *p_fwht_params;
 	void *p = ptr.p + idx * ctrl->elem_size;
 
@@ -152,6 +153,13 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		p_vp8_frame = p;
 		p_vp8_frame->num_dct_parts = 1;
 		break;
+	case V4L2_CTRL_TYPE_VP9_FRAME:
+		p_vp9_frame = p;
+		p_vp9_frame->profile = 0;
+		p_vp9_frame->bit_depth = 8;
+		p_vp9_frame->flags |= V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING |
+			V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
+		break;
 	case V4L2_CTRL_TYPE_FWHT_PARAMS:
 		p_fwht_params = p;
 		p_fwht_params->version = V4L2_FWHT_VERSION;
-- 
2.25.1

