Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B59568127
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiGFIWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiGFIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98D23BEF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so5136348pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDZsBKJCrPvrRed10JTTLn5RY5HzOJYgNfc59ZsTy1o=;
        b=BG33RCKbSZjiCGlqGQwuXJB4QMtQuJ7poldXwAhU5R2EBuTZJsWxFs/9j0HX0ebrrE
         Musc2wXQ/Faa2gc25JxI+ZQNzyi27DPVm/JxnTfKz9VAhLczwQxc2pOmWo6i586+H3XX
         +sA9CCVEEmJu4mdI272CRC6MAu8UH9CzMtcao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDZsBKJCrPvrRed10JTTLn5RY5HzOJYgNfc59ZsTy1o=;
        b=EfZAcmJC+oYJ57Ryj5VwzuFfUV1v/2gFkSIVvb8LBX701iXUQczKWdvRg+pYWd9Jbs
         ThHJanVYytrtlr9EbVRh6bcGWfSj5JZD/IIMwfHG+Ojuh8NpkKUnF6BNirY2kR7F3YRb
         vidPJaFLUbgo3TSjB3j4PP/K4f4dETcm90ct5F1oSMqPYRMz2CzTSBfasYkbfFPUQ2rb
         fIWB1yNUKncxzD6TBJc4iw+qniJWV0OzTySv/EyFhGQAg5BdJ9Tkv9yDLBIOOQ89dJX+
         OkIL5PbnB6n2xJ5EThzcjOB86tiFPZfSs5uqpYz/xndGkmNGYKEzKtUZ1mp5AaLqHxEf
         8p7Q==
X-Gm-Message-State: AJIora+5o2OK4BOgOb7pRIG1tr+gVzJlb0PixD3qKpZbTmbtkxHvd8LX
        kAFbBDBmZvi88pZGC9pa0IWqOQ==
X-Google-Smtp-Source: AGRyM1u8CxD0ORsdxHN8AhIq+XV1uXWF78ZIBZA3x9laIWEkb3wQRviHyBH0bTlGFY6NfylpUhWjiw==
X-Received: by 2002:a17:902:ab1b:b0:16b:e155:f32c with SMTP id ik27-20020a170902ab1b00b0016be155f32cmr17034027plb.104.1657095729035;
        Wed, 06 Jul 2022 01:22:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:22:08 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v2 5/6] media: mediatek: vcodec: decoder: Drop max_{width,height} from mtk_vcodec_ctx
Date:   Wed,  6 Jul 2022 16:21:37 +0800
Message-Id: <20220706082138.2668163-6-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706082138.2668163-1-wenst@chromium.org>
References: <20220706082138.2668163-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit b018be06f3c7 ("media: mediatek: vcodec:
Read max resolution from dec_capability").

After the previous patches:

  - media: mediatek: vcodec: decoder: Fix 4K frame size enumeration
  - media: mediatek: vcodec: decoder: Skip alignment for default resolution
  - media: mediatek: vcodec: decoder: Fix resolution clamping in TRY_FMT

the max_{width,height} fields in |struct mtk_vcodec_ctx| no longer have
any real users. Remove them.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 9 ---------
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 4 ----
 2 files changed, 13 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index cdd07fa612ee..2d370e8041c1 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -177,8 +177,6 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
 	q_data->coded_height = DFT_CFG_HEIGHT;
 	q_data->fmt = ctx->dev->vdec_pdata->default_cap_fmt;
 	q_data->field = V4L2_FIELD_NONE;
-	ctx->max_width = MTK_VDEC_MAX_W;
-	ctx->max_height = MTK_VDEC_MAX_H;
 
 	q_data->sizeimage[0] = q_data->coded_width * q_data->coded_height;
 	q_data->bytesperline[0] = q_data->coded_width;
@@ -514,13 +512,6 @@ static int vidioc_vdec_s_fmt(struct file *file, void *priv,
 	if (fmt == NULL)
 		return -EINVAL;
 
-	if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
-	    fmt->fourcc != V4L2_PIX_FMT_VP8_FRAME) {
-		mtk_v4l2_debug(3, "4K is enabled");
-		ctx->max_width = VCODEC_DEC_4K_CODED_WIDTH;
-		ctx->max_height = VCODEC_DEC_4K_CODED_HEIGHT;
-	}
-
 	q_data->fmt = fmt;
 	vidioc_try_fmt(ctx, f, q_data->fmt);
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 4140b4dd85bf..4f15f5f60e40 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -286,8 +286,6 @@ struct vdec_pic_info {
  *	  mtk_video_dec_buf.
  * @hw_id: hardware index used to identify different hardware.
  *
- * @max_width: hardware supported max width
- * @max_height: hardware supported max height
  * @msg_queue: msg queue used to store lat buffer information.
  */
 struct mtk_vcodec_ctx {
@@ -334,8 +332,6 @@ struct mtk_vcodec_ctx {
 	struct mutex lock;
 	int hw_id;
 
-	unsigned int max_width;
-	unsigned int max_height;
 	struct vdec_msg_queue msg_queue;
 };
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

