Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098DE552339
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiFTRzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbiFTRzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:55:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E719C13;
        Mon, 20 Jun 2022 10:55:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g27so9043791wrb.10;
        Mon, 20 Jun 2022 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+lhmhRazPbCiO0ZinItgn/yvpq/qsLzRHWrKJfMBAU=;
        b=ij7bpM7fYgafh4dGUzxUNkZ8mBe+1r3nO44hxCPnlMgcixxMJdfdSiXAdXE15WMCLM
         AyrqEh6M+p4d899WbwMSR4K1RQjNL5aRVO7l3tv9cR9JLGot1WiSXOLEbiRltLC+RO2+
         PjAB3k7Kmhb4cHJueB/5F93qKDW8F4c03ykyisyEAs0apL6U6sI8E697cwDod0mwN3OB
         iRbkQyuE5SLRr75UEpV1KHoFr/k0KJfHAUBxKLMz0XPxkZG6MRWzsCvWcR+/uX+N8LLy
         qmR7mEMzZ6RcUeYBNDp1NSaL/BxEowh8eAc0djSZXcY/U+/uqkn9eEPONFRPL2r8jtTR
         L0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+lhmhRazPbCiO0ZinItgn/yvpq/qsLzRHWrKJfMBAU=;
        b=RlMnclPRKBJmTu00EWc16JwvaIG76LnKWvApYm8kKlMbt/eJFsKJg1Pqm/y+0HXvWr
         W43gpdJygwsxPTgxeKsjcUeoNSYZYv7LQ50Wk3C3PPkjSRSdMzyhb25696zWTWNeOFA/
         LnW0Rj7fMr4LNfS8oh5gZUPKzHogfMJT45nJQYsyF3kGcKIUwYk3VKzXJ0SN77pm/QvU
         3teZg6qqPEG6lxaZIXf02MuA2Yun7iRhHIcM9yZPEjAG6FBN+nkWUgO1nxekuAWfd22A
         UpolPidNM3wQeF3K60h7QMjxUogpVOt0eaOlFmJ10/158AD+VCLySPiYXQybniUkqs4j
         hSOg==
X-Gm-Message-State: AJIora/ExAKe9pazhBYTbMmaqRBaNePVCJqOu3c7KsdNTV0eD7MCb35A
        a5XgwhYxFPBGpGILeuDbzO0=
X-Google-Smtp-Source: AGRyM1ugVC+G+EV+zF7RaG1caUz4KMQyumBWu+cN6/oYPJe14QiJ+H9HFyA6JwaBXtZLXPwI5NYlbw==
X-Received: by 2002:adf:f84b:0:b0:21b:8e43:b8ba with SMTP id d11-20020adff84b000000b0021b8e43b8bamr7141670wrq.155.1655747732210;
        Mon, 20 Jun 2022 10:55:32 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039db31f6372sm19620752wmc.2.2022.06.20.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:55:31 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/7] media: cedrus: h265: Fix logic for not low delay flag
Date:   Mon, 20 Jun 2022 19:55:12 +0200
Message-Id: <20220620175517.648767-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620175517.648767-1-jernej.skrabec@gmail.com>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we know real purpose of "not low delay" flag, logic for
applying this flag should be fixed too. According to vendor and
reference implementation, low delay is signaled when POC of current
frame is lower than POC of at least one reference of a slice.

Implement mentioned logic and invert it to conform to flag meaning. Also
don't apply flag for I frames. They don't have any reference.

This fixes decoding of 3 reference bitstreams.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 9ee6f0f111e5..46119912c387 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -301,6 +301,31 @@ static void cedrus_h265_write_scaling_list(struct cedrus_ctx *ctx,
 		}
 }
 
+static int cedrus_h265_is_low_delay(struct cedrus_run *run)
+{
+	const struct v4l2_ctrl_hevc_slice_params *slice_params;
+	const struct v4l2_hevc_dpb_entry *dpb;
+	s32 poc;
+	int i;
+
+	slice_params = run->h265.slice_params;
+	poc = run->h265.decode_params->pic_order_cnt_val;
+	dpb = run->h265.decode_params->dpb;
+
+	for (i = 0; i < slice_params->num_ref_idx_l0_active_minus1 + 1; i++)
+		if (dpb[slice_params->ref_idx_l0[i]].pic_order_cnt_val > poc)
+			return 1;
+
+	if (slice_params->slice_type != V4L2_HEVC_SLICE_TYPE_B)
+		return 0;
+
+	for (i = 0; i < slice_params->num_ref_idx_l1_active_minus1 + 1; i++)
+		if (dpb[slice_params->ref_idx_l1[i]].pic_order_cnt_val > poc)
+			return 1;
+
+	return 0;
+}
+
 static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 			      struct cedrus_run *run)
 {
@@ -588,7 +613,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 				V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED,
 				slice_params->flags);
 
-	if (decode_params->num_poc_st_curr_after == 0)
+	if (slice_params->slice_type != V4L2_HEVC_SLICE_TYPE_I && !cedrus_h265_is_low_delay(run))
 		reg |= VE_DEC_H265_DEC_SLICE_HDR_INFO1_FLAG_SLICE_NOT_LOW_DELAY;
 
 	cedrus_write(dev, VE_DEC_H265_DEC_SLICE_HDR_INFO1, reg);
-- 
2.36.1

