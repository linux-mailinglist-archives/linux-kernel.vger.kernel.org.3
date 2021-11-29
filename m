Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731384622D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhK2VFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhK2VDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:03:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F3CC125302;
        Mon, 29 Nov 2021 10:26:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so38778516wru.13;
        Mon, 29 Nov 2021 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a0+nTL0DN+mXlurHwon8EeRIBZDbCYqkIIB67asrkdI=;
        b=D9jg0iWuc1rjMrQWm7gWT/0O2pTEON1NW4/9pTdoqwKfyfG/eOpujQLPHTZvi0UWFD
         BeRngYZOam5f2lmLVwtMDAo2NO03+jsHYgYFmTrYlFh7gHK5+mSXzZOU9OdDKxqrjP2A
         Yg+gRPXi8vL3b2J9zgkFOJAnhh8FAy3YTQJoqifET/UT4OXiX8dZA8ajHApAupsPjrs8
         1muu+0iGJdHC1z85ozo83O5n14AFAi00BQmdjbqGWKMAPpr3Ycj1yqOd4O/N/bmrz9b1
         mi5g2pILmEdIiwdlUlPUpt7MjndDbma/75rmPqjlcSq9TwjFfPwjRAgwXo/GwME9njiY
         P/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a0+nTL0DN+mXlurHwon8EeRIBZDbCYqkIIB67asrkdI=;
        b=l0gqxjPM62O094Vg79hjI5w9X/1zYUKCl8iEWyJevlZUuuIc+BcN40cLCQ79Mxq2dV
         xmteYlt7h8ea4g5D21JfExu2Vtc+6R/xl07Wk0ydXBtqS+OkBGriHdW8dkukOyCt1o0D
         s+gRbEa/8R2ZZgPIi3ugRQVGZ7LXeCNuFS5Gzd6R2IeKwAhWFh/OOtbluwVTKxSyMxKf
         c/NAe/gbRWALDKnFfwH0AL2fL2+hlFlONDYmhveZXH1x6iDYNoOHLZjurSVjnq0gJJUR
         b6w8Tjba2Bw5mnBLgMaNgorGYASdo3HGoY5HmNleWvnVOtHmXB71j8MfVXle0dtgbnhg
         1sfg==
X-Gm-Message-State: AOAM531xukGCNa/znGR1+lynfKEs7uC3ULmh3hlvjvzvf6zGbSRvVAOQ
        jPTji4dY7Co3b6w4xUVXAHbhghSGfpffmw==
X-Google-Smtp-Source: ABdhPJxwEk4PeOYew3lrBCgfb3LuSgZ+3uNJEjxF89OkToMSqyoueFPcPM44bzY/pA8nWtal5C+UuA==
X-Received: by 2002:adf:a48e:: with SMTP id g14mr35615932wrb.474.1638210405319;
        Mon, 29 Nov 2021 10:26:45 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:45 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 5/9] media: hantro: move postproc enablement for old cores
Date:   Mon, 29 Nov 2021 19:26:29 +0100
Message-Id: <20211129182633.480021-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older G2 cores, like that in Allwinner H6, seem to have issue with
latching postproc register values if this is first thing done in job.
Moving that to the end solves the issue.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro.h     | 2 ++
 drivers/staging/media/hantro/hantro_drv.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 83ed25d9657b..06d0f3597694 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -75,6 +75,7 @@ struct hantro_irq {
  * @num_regs:			number of register range names in the array
  * @double_buffer:		core needs double buffering
  * @legacy_regs:		core uses legacy register set
+ * @late_postproc:		postproc must be set up at the end of the job
  */
 struct hantro_variant {
 	unsigned int enc_offset;
@@ -98,6 +99,7 @@ struct hantro_variant {
 	int num_regs;
 	unsigned int double_buffer : 1;
 	unsigned int legacy_regs : 1;
+	unsigned int late_postproc : 1;
 };
 
 /**
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 770f4ce71d29..33bf78be145b 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -130,7 +130,7 @@ void hantro_start_prepare_run(struct hantro_ctx *ctx)
 	v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
 				&ctx->ctrl_handler);
 
-	if (!ctx->is_encoder) {
+	if (!ctx->is_encoder && !ctx->dev->variant->late_postproc) {
 		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
 			hantro_postproc_enable(ctx);
 		else
@@ -142,6 +142,13 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
 {
 	struct vb2_v4l2_buffer *src_buf;
 
+	if (!ctx->is_encoder && ctx->dev->variant->late_postproc) {
+		if (hantro_needs_postproc(ctx, ctx->vpu_dst_fmt))
+			hantro_postproc_enable(ctx);
+		else
+			hantro_postproc_disable(ctx);
+	}
+
 	src_buf = hantro_get_src_buf(ctx);
 	v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
 				   &ctx->ctrl_handler);
-- 
2.34.1

