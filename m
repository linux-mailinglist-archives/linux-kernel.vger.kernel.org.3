Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F11570C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiGKVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiGKVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:11:59 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D1777A4F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:56 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10c0e6dd55eso8172127fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAr/6Y2JT0X2q9f8RcMvQYEj4YgACkIpvESpYtDF704=;
        b=oo9nuFNkl/BWxzgOPw9R+S9JOZ16DZ/KWAf1Hord1PvcSj9WhiXhVhWtrQOxGS75D2
         Mj7max0alIsH4nYmBjSPC8zD74BgxSL1yVqL5ei9alY2YbJB+e2z29bOBKB+deGEc6pB
         +0DkwAyML6Dn9uzmaNI/X3vwdkkqJamuOLrF0Mft5PN5oFp5z6QA1t+EPnU+lEbB4dfB
         HvtlMnd0h16JNSdv2XrfhHvG+QMXeLpoxzblinEkbdib+hR30TBttsLRip5K37YtrHBm
         cdaqaxbFIYn9CmnNcGihP5WpTutM/GZl+RpVEF7GC9h949P6oNrrAuHLhRehPAZPqT7x
         Wipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAr/6Y2JT0X2q9f8RcMvQYEj4YgACkIpvESpYtDF704=;
        b=gYe7KtXIwS+MigG/MJlolD/fkhwwinSRr8f9lzJr9eyJ+JA/cH242UEfxGmgh2s3lf
         qWqoAiIw9l7EgWPvJO/JPhWuc5tIv9Th7j13JtrECehyydEcsV7GFD0fFgc7iw7Ksh1K
         3CXF14Vz7IRdq93xFpcryuD2plDUdqNWtSNRjAh8dS2ER6e92b18cT/Jkud/Geg3ZUlu
         lMDkJkhc3Fx753LcU7TGNwhKcZJvERKllWfkSo4JJkUT8In1nkwn6gja3+0cbBHnxnM2
         t+qIDglb0dCVh+sC93tF+JbssIT2cjjuI97DCdx6h+Sc0M0ZkgsTpek3NC9AVIWhUKl0
         hq7g==
X-Gm-Message-State: AJIora/UADudIf2qUySEYT4I1fpMj38GUiMOMZRfFbTiShIoYAplbniK
        VqLou4ESzY7t0byw0GmXkY416w==
X-Google-Smtp-Source: AGRyM1tg9hSwfZP1V+ywQGku8lFPrIMMij6ay1NeYFRjGah8M74Hnvs/PFKI2zbqt59QbCXF29x1vQ==
X-Received: by 2002:a05:6870:17a7:b0:10b:af88:599e with SMTP id r39-20020a05687017a700b0010baf88599emr181289oae.18.1657573916107;
        Mon, 11 Jul 2022 14:11:56 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c128-20020aca3586000000b00338869042fdsm3198817oia.32.2022.07.11.14.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:11:55 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 3/8] tegra-vde: Use vb2_find_buffer
Date:   Mon, 11 Jul 2022 18:11:36 -0300
Message-Id: <20220711211141.349902-4-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced vb2_find_buffer API to get a vb2_buffer
given a buffer timestamp.

Cc: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/nvidia/tegra-vde/h264.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/nvidia/tegra-vde/h264.c b/drivers/media/platform/nvidia/tegra-vde/h264.c
index 88f81a134ba0..204e474d57f7 100644
--- a/drivers/media/platform/nvidia/tegra-vde/h264.c
+++ b/drivers/media/platform/nvidia/tegra-vde/h264.c
@@ -659,20 +659,19 @@ static struct vb2_buffer *get_ref_buf(struct tegra_ctx *ctx,
 {
 	const struct v4l2_h264_dpb_entry *dpb = ctx->h264.decode_params->dpb;
 	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
-	int buf_idx = -1;
+	struct vb2_buffer *vb = NULL;
 
 	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
-		buf_idx = vb2_find_timestamp(cap_q,
-					     dpb[dpb_idx].reference_ts, 0);
+		vb = vb2_find_buffer(cap_q, dpb[dpb_idx].reference_ts);
 
 	/*
 	 * If a DPB entry is unused or invalid, address of current destination
 	 * buffer is returned.
 	 */
-	if (buf_idx < 0)
+	if (!vb)
 		return &dst->vb2_buf;
 
-	return vb2_get_buffer(cap_q, buf_idx);
+	return vb;
 }
 
 static int tegra_vde_validate_vb_size(struct tegra_ctx *ctx,
-- 
2.34.3

