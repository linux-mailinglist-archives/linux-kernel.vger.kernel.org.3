Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D774ED63C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiCaIwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiCaIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:52:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28A251E48
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:50:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s11so21310165pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmETTELnRIWESWzCmxyQQPXgzdSMTuocRhFOdMSDk/Q=;
        b=N8UOq4XlKC6Pvq9feS8cvlwsJcFO5abBAV5xcECxDuiHt5s+Gj1PcCQ3PjJDL9c8Kk
         kRYAzJpSgUl0i26Jzj/sFD1b4bHr2eepw61jY4y6Qp2QsfifedVZrns/OBIK/URkP0K0
         xzSEMHgHKkn0b/fgw5wBW5yYURTArA+PiMRao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zmETTELnRIWESWzCmxyQQPXgzdSMTuocRhFOdMSDk/Q=;
        b=dmnzToGpmIHo6Cglnq8v2FB00DjMPUCWNSI16SRBx8s9PP4XjKQvVNxFM2gFGFTwbM
         vEh5I+v24XlZoAooq3fsZVO6A1WTUTooeEWuxVcmq8mxb94eHzxcU3930LbkWxxeaP6t
         YhwpN/NDwQOQX9QG9EVsBE1BOrpl5qs9aOzXGqXhviQL69YMcCUfzl0YnlS8VYG0ifnn
         wqGp/XWbujn2sjC1rHOqvDSCIxqErhPAPO5ThrX8lVM/PpXUJ+5Ld1UMCvS1VJ3R4ORJ
         /B5ftU2aQQPAtyG5XBBIYFnqHpR+Tx8DWcTdkGWkdyb7m6FWyI5StasVXAKl9Z4abqro
         xyQA==
X-Gm-Message-State: AOAM533i1IxfNwKWIC7wxCrAGZiJ0PYxEV4yUAyg4pwP2V3cHjCyxExU
        8smzjxliUXGl8ohl8N2pPrjEFnGB1iI7iw==
X-Google-Smtp-Source: ABdhPJwVwXUoO431BcVLb0tOHXefIHgUz2q1IMYqU7sepGupqBF46XjO+9lO8BjZPbciQz1sj0837w==
X-Received: by 2002:aa7:8b14:0:b0:4f7:83b1:2e0b with SMTP id f20-20020aa78b14000000b004f783b12e0bmr4358912pfd.37.1648716624212;
        Thu, 31 Mar 2022 01:50:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:deb3:b2d3:c33d:e877])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a00114d00b004c122b90703sm26805921pfm.27.2022.03.31.01.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 01:50:24 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFT] media: vicodec: Fix encoder has stopped condition check in encoder_cmd
Date:   Thu, 31 Mar 2022 16:50:16 +0800
Message-Id: <20220331085016.628747-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit d4d137de5f31 ("media: vicodec: use v4l2-mem2mem draining,
stopped and next-buf-is-last states handling"), the vicoded tracked the
"has stopped" condition itself, and only updated it after checks and
actions were done.

With the move to v4l2-mem2mem helpers, the state tracking moved into
the mem2mem context, and was updated by v4l2_m2m_ioctl_encoder_cmd()
before checks and actions were done in vicodec. As a result, the
has_stopped condition is now always false.

In the original code, vb2_clear_last_buffer_dequeued() is called if
the stream is successfully started. Since this is now always the case
if the callback did not error out at v4l2_m2m_ioctl_encoder_cmd(),
we can drop the "has stopped" condition check. This restores the
original behavior.

Fixes: d4d137de5f31 ("media: vicodec: use v4l2-mem2mem draining, stopped and next-buf-is-last states handling")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

This arose from the review of my Hantro encoder cmd support patch [1].

I haven't used vicodec before, so this is only compile tested. Actual
testing requested.

[1] https://lore.kernel.org/linux-media/YjcbnmTUaWDtkIb%2F@eze-laptop/

 drivers/media/test-drivers/vicodec/vicodec-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index be43f7d32df9..898fa8e284f7 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1231,8 +1231,7 @@ static int vicodec_encoder_cmd(struct file *file, void *fh,
 	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
 		v4l2_event_queue_fh(&ctx->fh, &vicodec_eos_event);
 
-	if (ec->cmd == V4L2_ENC_CMD_START &&
-	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
+	if (ec->cmd == V4L2_ENC_CMD_START)
 		vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
 
 	return 0;
-- 
2.35.1.1021.g381101b075-goog

