Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450E5495DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiAUKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiAUKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:51:41 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5758C061574;
        Fri, 21 Jan 2022 02:51:40 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n8so17134908wmk.3;
        Fri, 21 Jan 2022 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7spPZrufXw4sf1roZSdir53an3GNlXPUdV7xMDTORmE=;
        b=WX7I0gy8D0IJYOXvF2aChYR+3mR4ETAnJQlro1TUA8aIXGOc/YiHizXLlJ7fgWst/E
         6UbeqfgaahUdKD5E4I2i/uGZVzShz7xeVDqbM6YOvKd41kg3JGS7UNq6tzGSR6fLCAS0
         s+ar5K4bvD0r41ph1RlysUCBQmFxUItycWh/LYomwVf7pJV6SJWhI2tiQBsJ7up3n30z
         Ctsacxv+TuK6a3cZjRbQoegvV7y0tl3oUOv7Ysm7iIi0oiFDo+IR0JiH//fb/LVcIXpK
         Qyy8YWCyHZE+EXlnHOEv9z5thzOA2KlCViyFwklm0qnTRqOxgBUSLtrifpzNty+KFsaw
         hSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7spPZrufXw4sf1roZSdir53an3GNlXPUdV7xMDTORmE=;
        b=RRZvVC2oMk6EM2q5ILS3r/Flev8d+L2CzcaIHJNWqR70XPXzkFcA0ceutrJzp6IAvF
         vLzbjFmvpHaqJcYpGIFb9t71dIDUVOLYqDKVuxkZKN5RllYj/E0DWt9bvg+kadYP81cM
         eB+olZIEp25sj68R92WLiwgJF+iwEDvfhBsAQWiDH88w6ZBR0KbwQGHxCT4ysLKNlEAv
         6J/ry/z9PBOH0nkvuJzyP5hD71TAMLPXncbALoVgctCGycK0b1TrlpgOQF2EmvJSXdA8
         tSUVkdn4xOqAPlwn/MESdbNJQYL1BZek0os4U+8O+Tub5I88BVbW4ChnwMpo0Lw3j6HJ
         yrRA==
X-Gm-Message-State: AOAM531e2h+q8+N4drrfNKSaAFtclbGhfpr/2YWUwrPywoia43GaXse3
        +wMVMqCrt5HqXo/CARbtWH8=
X-Google-Smtp-Source: ABdhPJxH9fuDLmee6jplGsAtCTa4HiUxWetXO2h6TOrKdp7ZKDUViWTXNvKov37kTzEMiMtJNzBHnA==
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr3324208wrr.372.1642762299281;
        Fri, 21 Jan 2022 02:51:39 -0800 (PST)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id n8sm4794532wmq.43.2022.01.21.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 02:51:38 -0800 (PST)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mosescb.dev@gmail.com
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] drivers: staging: media: omap4iss: Use BIT macro instead of left shifting
Date:   Fri, 21 Jan 2022 11:51:11 +0100
Message-Id: <20220121105111.2651-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121100837.337094-2-mosescb.dev@gmail.com>
References: <20220121100837.337094-2-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a BIT(nr) macro available in Linux Kernel,
which does the same thing.

Example:  1 << 7  is same as BIT(7)

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 V2 -> V3: Add Dan's Reviewed-by tag to commit message
 V1 -> V2: Use BIT(0) instead of 1

 drivers/staging/media/omap4iss/iss_video.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/omap4iss/iss_video.h b/drivers/staging/media/omap4iss/iss_video.h
index 526281bf0051..1724ed03ce9d 100644
--- a/drivers/staging/media/omap4iss/iss_video.h
+++ b/drivers/staging/media/omap4iss/iss_video.h
@@ -53,19 +53,19 @@ enum iss_pipeline_stream_state {
 
 enum iss_pipeline_state {
 	/* The stream has been started on the input video node. */
-	ISS_PIPELINE_STREAM_INPUT = 1,
+	ISS_PIPELINE_STREAM_INPUT = BIT(0),
 	/* The stream has been started on the output video node. */
-	ISS_PIPELINE_STREAM_OUTPUT = (1 << 1),
+	ISS_PIPELINE_STREAM_OUTPUT = BIT(1),
 	/* At least one buffer is queued on the input video node. */
-	ISS_PIPELINE_QUEUE_INPUT = (1 << 2),
+	ISS_PIPELINE_QUEUE_INPUT = BIT(2),
 	/* At least one buffer is queued on the output video node. */
-	ISS_PIPELINE_QUEUE_OUTPUT = (1 << 3),
+	ISS_PIPELINE_QUEUE_OUTPUT = BIT(3),
 	/* The input entity is idle, ready to be started. */
-	ISS_PIPELINE_IDLE_INPUT = (1 << 4),
+	ISS_PIPELINE_IDLE_INPUT = BIT(4),
 	/* The output entity is idle, ready to be started. */
-	ISS_PIPELINE_IDLE_OUTPUT = (1 << 5),
+	ISS_PIPELINE_IDLE_OUTPUT = BIT(5),
 	/* The pipeline is currently streaming. */
-	ISS_PIPELINE_STREAM = (1 << 6),
+	ISS_PIPELINE_STREAM = BIT(6),
 };
 
 /*
@@ -119,9 +119,9 @@ struct iss_buffer {
 
 enum iss_video_dmaqueue_flags {
 	/* Set if DMA queue becomes empty when ISS_PIPELINE_STREAM_CONTINUOUS */
-	ISS_VIDEO_DMAQUEUE_UNDERRUN = (1 << 0),
+	ISS_VIDEO_DMAQUEUE_UNDERRUN = BIT(0),
 	/* Set when queuing buffer to an empty DMA queue */
-	ISS_VIDEO_DMAQUEUE_QUEUED = (1 << 1),
+	ISS_VIDEO_DMAQUEUE_QUEUED = BIT(1),
 };
 
 #define iss_video_dmaqueue_flags_clr(video)	\
-- 
2.30.2

