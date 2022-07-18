Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C69578D38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiGRWCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:02:24 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342003057D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:02:23 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10c0119dd16so27583177fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdBFHF56DJCJ7TVTujTvKpBH89sBJrOSHbI3IjUu/5k=;
        b=wTFG8JWjShO5RNne+JFekypG5Jun3Z5JIEH+vyfzhLBlGdU3IBQsxWmjzY9A//MPbd
         rbrty3FJrIcYAIe4+QpZ+Jw8usCg0M1t/NQ6SaJZfehWJ8pL9kQL3jea1SnWkYzIlwJn
         k6gemebyT1TUIP+p7XkvwQKCKbomhP+6ECd4p5gkhBYU5TuLASId3JFpmQYgYQrJeiIZ
         OFgUDSxDA/A0v0eFvkvAhGhE6oHgUsjR2MjGx53TGIvCR7jOOF7jk9AhVTpQlflXTYmK
         tAm6l0alQnFFnPmqHezfvMTknOoT9vWuAImEcXQf0hz5DKT1vmwD/HN70lEffAi6OWKb
         oiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdBFHF56DJCJ7TVTujTvKpBH89sBJrOSHbI3IjUu/5k=;
        b=R3ZN+lrpFJGQiYXnQp14w2t28zKkGYYXMQ6Ftges29e7TtW4Ne0VWEKBUaZKw1JcIj
         kmTk3RpEUKoQt0SmDeodK2sXjkxxT9FVxEqYRVik8o2Wu7tSaKTK6dxL1oSYgBC1ZR6+
         OBZY/LizNgqNXoA9bZh+53UpRG+VpkepmkdZ3n0Dg0s4efJku2UE4cQwMDrw5x4wyS4b
         OcZpJLx0L507/pkXp1+2lT+cofpp6NYbo5Fse6qNLIYZtShqCBIl/P9ykbuYyEJlFx20
         tEhvj6YIl0ZrZ7OzfJCUswvjJlf/i/sLmw7nyj8NEL+8bsCOfAX3JcX7gs8/qsSQL/s2
         l+pA==
X-Gm-Message-State: AJIora8BZnJ7ADF/qHBo16omhq5TmusotldWkWgU74GVxwoj1bR5uiv4
        aj7OU0/yV3HaxcIiRpQMbSBqi+1w2G3OPq6f
X-Google-Smtp-Source: AGRyM1vB/B9eryf5swntZ6a7FaXZ/PDoV23ychjM/n23I/soPsdtUbR9hUTrm9sjNJ8atxYP1gPpYw==
X-Received: by 2002:a05:6870:2186:b0:10b:f3fa:a07b with SMTP id l6-20020a056870218600b0010bf3faa07bmr18360882oae.266.1658181742537;
        Mon, 18 Jul 2022 15:02:22 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id x27-20020a9d459b000000b0061c68a35fdfsm3793183ote.9.2022.07.18.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:02:22 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v3 2/2] videobuf2: Remove vb2_find_timestamp()
Date:   Mon, 18 Jul 2022 19:02:11 -0300
Message-Id: <20220718220211.97995-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220718220211.97995-1-ezequiel@vanguardiasur.com.ar>
References: <20220718220211.97995-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've transitioned all users to vb2_find_buffer API,
remove the unused vb2_find_timestamp().

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 13 -------------
 include/media/videobuf2-v4l2.h                  | 16 ----------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index f26cb8586bd4..4e84a0e1aca2 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -625,19 +625,6 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
 	.copy_timestamp		= __copy_timestamp,
 };
 
-int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
-		       unsigned int start_idx)
-{
-	unsigned int i;
-
-	for (i = start_idx; i < q->num_buffers; i++)
-		if (q->bufs[i]->copied_timestamp &&
-		    q->bufs[i]->timestamp == timestamp)
-			return i;
-	return -1;
-}
-EXPORT_SYMBOL_GPL(vb2_find_timestamp);
-
 struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
 {
 	unsigned int i;
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index 76e405c0b003..5a845887850b 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -62,22 +62,6 @@ struct vb2_v4l2_buffer {
 #define to_vb2_v4l2_buffer(vb) \
 	container_of(vb, struct vb2_v4l2_buffer, vb2_buf)
 
-/**
- * vb2_find_timestamp() - Find buffer with given timestamp in the queue
- *
- * @q:		pointer to &struct vb2_queue with videobuf2 queue.
- * @timestamp:	the timestamp to find.
- * @start_idx:	the start index (usually 0) in the buffer array to start
- *		searching from. Note that there may be multiple buffers
- *		with the same timestamp value, so you can restart the search
- *		by setting @start_idx to the previously found index + 1.
- *
- * Returns the buffer index of the buffer with the given @timestamp, or
- * -1 if no buffer with @timestamp was found.
- */
-int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
-		       unsigned int start_idx);
-
 /**
  * vb2_find_buffer() - Find a buffer with given timestamp
  *
-- 
2.34.3

