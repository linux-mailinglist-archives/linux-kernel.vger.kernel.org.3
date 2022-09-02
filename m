Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32F05AB81D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiIBSTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIBSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:19:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DB28725
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:19:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x23so2624468pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=pkzozNDbYl6NpGwUKSsZU7To06Oiuq+iWn/wCVhM32g=;
        b=qveGZcnGVrS4X5Rcuo/ECZFOACBvjqddw0mNk6bbA1FpeeBQQw+YnkJBlUJWxmmxr8
         bMyOKruoFHCTO3feBTr61CdAf0orD/a0EM5ynBG63tqicHBHzDJlSDrIeJKfq2cTh+RH
         NZ6kEIb7KDwN4NtPa3G+lIL7yQJuxnENhKg4iEB2cl9j3tRz8A17Ko/HhF5ZaZHofAsl
         kxdY8FMLKtx9xvaOkDHSmBk/vcoC2a5WD1yG8clgpoEPjAGE6o/4ECH8EcL3V0NLEYYj
         edeFA1Fw94HCpP/1ImeZvwVhnvlJRRelAqF85BpEYZUSOvNiXRxR49M1UJhL9OtOKspY
         l7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=pkzozNDbYl6NpGwUKSsZU7To06Oiuq+iWn/wCVhM32g=;
        b=r8E1LG6jPNFdmzQPbqEqE1uqU5Eis9Ki5E2tsTlhGPOQdQRIvpOrqK5LRJR3gVF1+O
         pL+5pUufnIvJAVBC2XJRBAnUBCQGoWr9SuamDoz1HXqH1cQahXf6HYxBeeS4iv6x4L8c
         JXg/D+coVY4o2UX4JKY1hkt8dX9hPdEvoD+CxzE4wp1XKS5VtJ11bO39z2y40XKi/ezL
         VXdSj6F6pm7rGzVRY7G66sYmZ+/j5w7w174eJb35jye/YmMbQ1u2xYLC4txcHVWAy3hW
         yTb+zyGQaleT2AWn8/HRFTW85HA44RVRZrewAnkJvekzm9GllK6QfJVkXZY5jH1qA6mh
         viCg==
X-Gm-Message-State: ACgBeo0zUw5Alxuzo4859026Br0PreUmqsTLZEdlTntR5ZjSdgnteTdo
        iYYCqAjnWVNVQuHOG0NTq4U=
X-Google-Smtp-Source: AA6agR54zkmDc2b/Gsn6E4o7yujoDU075BmjJ7MmgaC7Xfi7rRTjVuQmDI7vNxC3YRZncYyq+LoUrw==
X-Received: by 2002:a17:902:c40f:b0:175:3c1e:8493 with SMTP id k15-20020a170902c40f00b001753c1e8493mr15220821plk.19.1662142776975;
        Fri, 02 Sep 2022 11:19:36 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:2c7b:afb2:51ea:2c4])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902da8400b0017297a6b39dsm1987074plx.265.2022.09.02.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:19:36 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf/core: Increase lost_samples count only for samples
Date:   Fri,  2 Sep 2022 11:19:34 -0700
Message-Id: <20220902181934.1082647-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event->lost_samples count is intended to count (lost) sample records
but it's also counted for non-sample records like PERF_RECORD_MMAP etc.
This can be a problem when a sampling event tracks those side-band
events together.

As overflow handler for user events only calls perf_output_begin_
{for,back}ward() before writing to the ring buffer, we can pass an
additional flag to indicate that it's writing a sample record.

Fixes: 119a784c8127 ("perf/core: Add a new read format to get a number of lost samples")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/ring_buffer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 726132039c38..5f38ee4edbdb 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -149,7 +149,7 @@ static __always_inline int
 __perf_output_begin(struct perf_output_handle *handle,
 		    struct perf_sample_data *data,
 		    struct perf_event *event, unsigned int size,
-		    bool backward)
+		    bool backward, bool sample)
 {
 	struct perf_buffer *rb;
 	unsigned long tail, offset, head;
@@ -174,7 +174,8 @@ __perf_output_begin(struct perf_output_handle *handle,
 	if (unlikely(rb->paused)) {
 		if (rb->nr_pages) {
 			local_inc(&rb->lost);
-			atomic64_inc(&event->lost_samples);
+			if (sample)
+				atomic64_inc(&event->lost_samples);
 		}
 		goto out;
 	}
@@ -256,7 +257,8 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
-	atomic64_inc(&event->lost_samples);
+	if (sample)
+		atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
@@ -268,14 +270,14 @@ int perf_output_begin_forward(struct perf_output_handle *handle,
 			      struct perf_sample_data *data,
 			      struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, data, event, size, false);
+	return __perf_output_begin(handle, data, event, size, false, true);
 }
 
 int perf_output_begin_backward(struct perf_output_handle *handle,
 			       struct perf_sample_data *data,
 			       struct perf_event *event, unsigned int size)
 {
-	return __perf_output_begin(handle, data, event, size, true);
+	return __perf_output_begin(handle, data, event, size, true, true);
 }
 
 int perf_output_begin(struct perf_output_handle *handle,
@@ -284,7 +286,7 @@ int perf_output_begin(struct perf_output_handle *handle,
 {
 
 	return __perf_output_begin(handle, data, event, size,
-				   unlikely(is_write_backward(event)));
+				   unlikely(is_write_backward(event)), false);
 }
 
 unsigned int perf_output_copy(struct perf_output_handle *handle,
-- 
2.37.2.789.g6183377224-goog

