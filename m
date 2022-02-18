Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2ED4BBFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiBRSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:43:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiBRSmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:42:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FD1833B8;
        Fri, 18 Feb 2022 10:42:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id BF00F1F46EEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645209753;
        bh=+6AyqGud0mOdo8VJ0ubLM2SGybUR+8DMpSAenbbvUO8=;
        h=From:To:Cc:Subject:Date:From;
        b=ABy9GOmtXTNkUXkWmkaTpEthH/4nyreBfV7LkExY0JIzpVzreThZlcDiUvPxQxJhz
         qIsaD0LsyVutZUd8CS9hHUK8gyOuCLpvuEQVqhwD2Yhuof3OB1y3mmJCW2EpvVPJGd
         9RJAy1Uyu+WW2g9jftXP8sFcj6bCaiQvk9efKaRumvAQT5J268l9CYYrf2FdYasp0V
         5L6K2In2n2A4BuafslS/EAqctEXq/DJLkmGJxGP5fXbuThY7GxGfdN0jLJrv/SBwxd
         ch13HTwv+VAkxhRpAEZZoaN6cJ7Porc0ps5Rh175rfjqiY3Q+GJjw5QDm3cl3g7hjV
         mFm4K8j/hPcoA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, yunfei.dong@mediatek.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] media: v4l2-core: Initialize h264 scaling matrix
Date:   Fri, 18 Feb 2022 13:42:07 -0500
Message-Id: <20220218184208.455488-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the final H264 API, it is not required to set scaling matrix if
they are not present in the bitstream. A flag was added in order to let
the driver know. The downside is that it leaves the default control
value to 0, which isn't valid. As per the spec (see formulas 7-8/7-9),
when the scaling matrix are absent from the bitstream, flat values
of 16 should be used. This improves this control semantic in a way
that the control value are always valid. Drivers can then use
the scaling_matrix control values without having to check its presence.
Same method was employed for MPEG2_QUANTISATION.

This fixes issues with MTK VCODEC H264 decoder when using GStreamer.
GStreamer does not set this control if its not present in the bitstream.
As MTK VDCODEC was using the initialized to 0 values, the frames ended
up completely gray.

Fixes: 54889c51b833d236 ("media: uapi: h264: Rename and clarify PPS_FLAG_SCALING_MATRIX_PRESENT")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 76e919b71a35..b950675b1db1 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -114,6 +114,7 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 	struct v4l2_ctrl_vp8_frame *p_vp8_frame;
 	struct v4l2_ctrl_vp9_frame *p_vp9_frame;
 	struct v4l2_ctrl_fwht_params *p_fwht_params;
+	struct v4l2_ctrl_h264_scaling_matrix *p_h264_scaling_matrix;
 	void *p = ptr.p + idx * ctrl->elem_size;
 
 	if (ctrl->p_def.p_const)
@@ -168,6 +169,15 @@ static void std_init_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 		p_fwht_params->flags = V4L2_FWHT_FL_PIXENC_YUV |
 			(2 << V4L2_FWHT_FL_COMPONENTS_NUM_OFFSET);
 		break;
+	case V4L2_CTRL_TYPE_H264_SCALING_MATRIX:
+		p_h264_scaling_matrix = p;
+		/*
+		 * The default (flat) H.264 scaling matrix when none are
+		 * specified in the bitstream, this is according to formulas
+		 *  (7-8) and (7-9) of the specification.
+		 */
+		memset(p_h264_scaling_matrix, 16, sizeof(*p_h264_scaling_matrix));
+		break;
 	}
 }
 
-- 
2.35.1

