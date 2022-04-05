Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489664F5210
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388760AbiDFCey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444214AbiDEWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:21:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58689BAD4;
        Tue,  5 Apr 2022 13:45:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id C469B1F44840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191506;
        bh=sDJRbDHtwMEd4Z1AC3fnth9aVik8zbzUMGexAc+afw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DPvz1ZbvaFugvYyOfrcTyPIuHXXuFXkDY7tNFLOh6LnAEsLHeMoMJkDDqTI3gi17U
         EHrVNOHmlXL+3kshMEXe/cWztY9kf6lIUtLvjFdi8afLlam5jFnF3hBss3bE4iGXqB
         Cpn5V0Sf8udrgkU6uvEfixu5gljp5r7VZ7Cn1TddHlQx3YqPyXwOFbm/YmEJsbpjzy
         wr7pFKSl1KVPuxX8xu4HHk6D73iThiRqBBXwsolwF31hrYJEWzDdkad2yAPkCOhEW2
         Ea67FGWiWHf5BKs4tOlVeU9xcl1xEhb+vjkJVs3GhcZK7uZjpYjVwJFRZ5btbgXQXR
         UEZ+WS8AgXYyw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 15/24] media: rkvdec: Move H264 SPS validation in rkvdec-h264
Date:   Tue,  5 Apr 2022 16:44:16 -0400
Message-Id: <20220405204426.259074-16-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
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

No function change, this moves H264 specific validation into the H264
specific code. This is in preparation of improving this validation and
reusing at streamone.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 23 ++++++++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec.c      | 23 ++++++----------------
 drivers/staging/media/rkvdec/rkvdec.h      |  1 +
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 8d44a884a52e..0dcbcb1bac80 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1137,9 +1137,32 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 	return 0;
 }
 
+static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
+{
+	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
+		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
+		/*
+		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
+		 * but it's currently broken in the driver.
+		 * Reject them for now, until it's fixed.
+		 */
+		if (sps->chroma_format_idc > 1)
+			/* Only 4:0:0 and 4:2:0 are supported */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
+			/* Luma and chroma bit depth mismatch */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != 0)
+			/* Only 8-bit is supported */
+			return -EINVAL;
+	}
+	return 0;
+}
+
 const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt_ops = {
 	.adjust_fmt = rkvdec_h264_adjust_fmt,
 	.start = rkvdec_h264_start,
 	.stop = rkvdec_h264_stop,
 	.run = rkvdec_h264_run,
+	.try_ctrl = rkvdec_h264_try_ctrl,
 };
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 2df8cf4883e2..e3d44d5b35f3 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -29,23 +29,12 @@
 
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
-	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
-		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
-		/*
-		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
-		 * but it's currently broken in the driver.
-		 * Reject them for now, until it's fixed.
-		 */
-		if (sps->chroma_format_idc > 1)
-			/* Only 4:0:0 and 4:2:0 are supported */
-			return -EINVAL;
-		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-			/* Luma and chroma bit depth mismatch */
-			return -EINVAL;
-		if (sps->bit_depth_luma_minus8 != 0)
-			/* Only 8-bit is supported */
-			return -EINVAL;
-	}
+	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
+	const struct rkvdec_coded_fmt_desc *desc = ctx->coded_fmt_desc;
+
+	if (desc->ops->try_ctrl)
+		return desc->ops->try_ctrl(ctx, ctrl);
+
 	return 0;
 }
 
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 2f4ea1786b93..9df0fba799a4 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -72,6 +72,7 @@ struct rkvdec_coded_fmt_ops {
 	void (*done)(struct rkvdec_ctx *ctx, struct vb2_v4l2_buffer *src_buf,
 		     struct vb2_v4l2_buffer *dst_buf,
 		     enum vb2_buffer_state result);
+	int (*try_ctrl)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
 };
 
 struct rkvdec_coded_fmt_desc {
-- 
2.34.1

