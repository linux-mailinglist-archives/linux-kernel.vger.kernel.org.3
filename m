Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A1464631
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhLAFBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLAFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:01:29 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE336C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:58:09 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s137so22323374pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BizBr/A581O9n/gIvtU8qTlKDXl55iiKCB6Dy84QDA=;
        b=clU7i/camFVJZzsS3CjXXn1hk/Of4pS9COTdBwKNHs0F7FIj+sEB5F/xvu/C343KBu
         ywALuc8zZMMHW1CAaX4jj7fkRAsFM71PFUv27QKVRsMYX8Ebbi6BipnfCM8BOEZ2mAPY
         sQnOt6JLy4y+ggGIxgsFykLPW43TNpz5oWEr1BRVT7AHYr9LVkTxLqNNuH+udMw70y+R
         lgJWc9m2dAI3Qt3ZlNL9tYRIGRoNHxqbnBcH3LYne22d//Gaav+t/wo/ZTP9Lc9tylbT
         yZBkugj0ennmTR60eq+5GaF7KUtkwe/Jb9NnwR9H/rzgq8nUFEZOVAx0rWsfOp1ibWE6
         KtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5BizBr/A581O9n/gIvtU8qTlKDXl55iiKCB6Dy84QDA=;
        b=L2cQrjU/d/IHa2swCMjev1PNYBw8i1fIrem0xfkuXMpMqSfj/vRZPQS0cPB/XYxKcc
         c8mUQs1kSjow5FmF3oG4uJnDK8pKalJdDoXa1VXZRK9OqztnWVOK0xG2zkns2DRN76yS
         4xhOTYkeg0Z84Gux08wsBq2McIj4uwngO2vu7oJ0WwdrajdTrcll249Zt5Oun4fpCCfc
         mf/zh4mNmQiD1jub2GsZzwL+L+0yJmHlp6sfM4nW3Xn/AyC9ShodlnOjEXc345nKSqQz
         uAqjKzjK+YjPI/5A/6D90Tj6NIOU5a9tWSa0C4TMpd0ZACSqZLIhCiRDh7SQaBNTWnZk
         rtgA==
X-Gm-Message-State: AOAM532R+kRArJjHqZuduJKOwK6t7NJmVDEe17yvPt4eQGy1XPjjXC5s
        9XOGVIyA84jmzgfkmFj0KKg=
X-Google-Smtp-Source: ABdhPJzZJ1fOzSTlrMo/+B45snIi6kCz9QbXZ2CpFudop6MHKbnEkvB9bIesBmuaG6CcEI3lr3byuw==
X-Received: by 2002:a65:4785:: with SMTP id e5mr2994406pgs.405.1638334689167;
        Tue, 30 Nov 2021 20:58:09 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b4dd:60ee:5575:5214])
        by smtp.gmail.com with ESMTPSA id g22sm23931487pfj.29.2021.11.30.20.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 20:58:08 -0800 (PST)
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
        Namhyung Kim <namhyung@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2] perf/core: Set event shadow time for inactive events too
Date:   Tue, 30 Nov 2021 20:58:07 -0800
Message-Id: <20211201045807.1223200-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@google.com>

While f79256532682 ("perf/core: fix userpage->time_enabled of inactive
events") fixed this problem for user rdpmc usage, bperf (perf stat
with BPF) still has the same problem that accessing inactive perf
events from BPF using bpf_perf_event_read_value().

You can reproduce this problem easily.  As this is about a small
window with multiplexing, we need a large number of events and short
duration like below:

  # perf stat -a -v --bpf-counters -e instructions,branches,branch-misses \
    -e cache-references,cache-misses,bus-cycles,ref-cycles,cycles sleep 0.1

  Control descriptor is not initialized
  instructions: 19616489 431324015 360374366
  branches: 3685346 417640114 344175443
  branch-misses: 75714 404089360 336145421
  cache-references: 438667 390474289 327444074
  cache-misses: 49279 349333164 272835067
  bus-cycles: 631887 283423953 165164214
  ref-cycles: 2578771111104847872 18446744069443110306 182116355
  cycles: 1785221016051271680 18446744071682768912 115821694

   Performance counter stats for 'system wide':

          19,616,489      instructions              #    0.00  insn per cycle           ( 83.55%)
           3,685,346      branches                                                      ( 82.41%)
              75,714      branch-misses             #    2.05% of all branches          ( 83.19%)
             438,667      cache-references                                              ( 83.86%)
              49,279      cache-misses              #   11.234 % of all cache refs      ( 78.10%)
             631,887      bus-cycles                                                    ( 58.27%)
  2,578,771,111,104,847,872      ref-cycles                                                     (0.00%)
  1,785,221,016,051,271,680      cycles                                                         (0.00%)

       0.010824702 seconds time elapsed

As you can see, it shows invalid values for the last two events.
The -v option shows that the enabled time is way bigger than the
running time.  So it scaled the counter values using the ratio
between the two and resulted in that.  This problem can get worse
if users want no-aggregation or cgroup aggregation with a small
interval.

Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
have a negative enabled time.  In fact, bperf keeps values returned by
bpf_perf_event_read_value() which calls perf_event_read_local(), and
accumulates delta between two calls.  When event->shadow_ctx_time is
not set, it'd return invalid enabled time which is bigger than normal.
Later, the shadow time is set and the function starts to return a
valid time.  At the moment, the recent value is smaller than before so
the delta in the bperf can be negative.

I think we need to set the shadow time even the events are inactive so
that BPF programs (or other potential users) can see valid time values
anytime.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) rebased to tip/perf/core

 kernel/events/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3b3297a57228..be37f830f51c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3707,27 +3707,26 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
-static inline bool event_update_userpage(struct perf_event *event)
+static inline void group_update_event_time(struct perf_event *group_event)
 {
-	if (likely(!atomic_read(&event->mmap_count)))
-		return false;
-
-	perf_event_update_time(event);
-	perf_set_shadow_time(event, event->ctx);
-	perf_event_update_userpage(event);
+	struct perf_event *event;
+	struct perf_event_context *ctx = group_event->ctx;
 
-	return true;
-}
+	perf_event_update_time(group_event);
+	perf_set_shadow_time(group_event, ctx);
 
-static inline void group_update_userpage(struct perf_event *group_event)
-{
-	struct perf_event *event;
+	for_each_sibling_event(event, group_event) {
+		perf_event_update_time(event);
+		perf_set_shadow_time(event, ctx);
+	}
 
-	if (!event_update_userpage(group_event))
+	if (likely(!atomic_read(&group_event->mmap_count)))
 		return;
 
+	perf_event_update_userpage(group_event);
+
 	for_each_sibling_event(event, group_event)
-		event_update_userpage(event);
+		perf_event_update_userpage(event);
 }
 
 static int merge_sched_in(struct perf_event *event, void *data)
@@ -3755,7 +3754,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		} else {
 			ctx->rotate_necessary = 1;
 			perf_mux_hrtimer_restart(cpuctx);
-			group_update_userpage(event);
+			group_update_event_time(event);
 		}
 	}
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

