Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3924B5E78
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiBNX5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:57:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiBNX5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:57:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572375FB9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:57:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k60-20020a17090a4cc200b001b932781f3eso919228pjh.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXjDrv5uEfaLPNIeos7lmODCsgdXrIHIxdqkM1uiR6M=;
        b=M7dwsMjSN3cVVk2U1XKyRyNzKBD4tQUrtGAf+u1V8YDsnkalGgDsRa0YKLmZ0nnb9x
         oYIJkzgOH4otpONhB9ac9JqCkTl2WIuLr4LhUmxMqEworBJ0sTOuKXmAwOXWouKRtt0p
         Dk3R+gO59ggfo36U0T5CLvQP7HofkjUq478KDCL1d656SxlulkDtejDICuy2f5PAGytE
         iSiGgvso/f7RfMVCMbJ51qxH1xh+ZHWvoSCCQr5JVEjpUhcodupGFWHx14mWFWQpofv2
         MRPY2ZnJMgsIWoqV7tZvS0f/04Rip9tr1IIOd2pO5qyZGHEHKbk4zbrjubH0fohLTl9K
         0N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JXjDrv5uEfaLPNIeos7lmODCsgdXrIHIxdqkM1uiR6M=;
        b=4LRBUq8wJpA+AHnDHQCGOgoOsBB0+2/7QC9QwR6hxnd/r6k+EfUXbOOzXa0CHG8J+H
         puD9QwPkEX9wseb3oWarcI9UzAYyg5Daew0fSt9OhMadJuEqet/nz22ACjtgUdcZ5meE
         4eBk2OvsQsEK0pmFb8fg+Fj6XviUKrBp8U1GESUpKRozLbqljxptTwbZyLcFdtZBEhbR
         WqEVJprX+N0Mj+eNiwlNAzs7V4fXf0GuCvg65f1tXHTXKTh3LBQSKR1/XR7bFLXeLBC3
         IqQl2f+YMN8+JlDsHkp3vcdrP/+IHXhpquOy3dimMWNNjaZe304U3S7IP9OVpFSOxpYX
         XM/w==
X-Gm-Message-State: AOAM532O8QTv6YFw7xMYwqMz1V7fB4s/YYCwyUZ7413XbhdO+oWcI4go
        pnTgjh62gG4X1O7zLkICIPSONtgmaa8=
X-Google-Smtp-Source: ABdhPJyLKXTk5KvHpWV/M4S6xtTeAf2IWQFdoF4u0/BmSSBUc2M4n/Ev4ddZzQzsd3Zlld2S590EtA==
X-Received: by 2002:a17:902:780d:: with SMTP id p13mr1390855pll.32.1644883056682;
        Mon, 14 Feb 2022 15:57:36 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:e6b9:838c:97e9:17b8])
        by smtp.gmail.com with ESMTPSA id k5sm6223611pfu.180.2022.02.14.15.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:57:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v3] perf/core: Add a new read format to get a number of lost samples
Date:   Mon, 14 Feb 2022 15:57:28 -0800
Message-Id: <20220214235728.40159-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
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

Sometimes we want to know an accurate number of samples even if it's
lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
might be shared with other events.  So it's hard to know per-event
lost count.

Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
userspace.

Original-patch-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 * rebase to tip/perf/core
 * fix copy-n-paste errors

 include/linux/perf_event.h      |  2 ++
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 21 ++++++++++++++++++---
 kernel/events/ring_buffer.c     |  5 ++++-
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 733649184b27..1debe51cb736 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -759,6 +759,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 1b65042ab1db..08220748fa9f 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -299,6 +299,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -306,6 +307,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -315,8 +317,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index afbf388a5176..3f3a029c81c4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1910,6 +1910,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 	if (event->attr.read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
+	if (event->attr.read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
 	if (event->attr.read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
@@ -5350,11 +5353,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
@@ -5411,7 +5418,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5421,6 +5428,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6951,7 +6960,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6965,6 +6974,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6975,7 +6986,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6993,6 +7004,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -7006,6 +7019,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..727ca8f4caad 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
-- 
2.35.1.265.g69c8d7142f-goog

