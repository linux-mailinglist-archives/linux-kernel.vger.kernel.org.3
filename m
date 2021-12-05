Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60484468DBF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbhLEWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbhLEWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:52:13 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CCC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 14:48:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r138so8655109pgr.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7MK0qgu+jx+Ly9rFkROV3Iep3bBgTueVRa2u5ntgItk=;
        b=J5X3IT1fH3rmJbG3NsBxCA7OXU3MeFqUVqusHAsmUR0zyom1hNIBvDt5Zb8NAXRKRC
         XDzKZ7U5RsLvNsHxn0Hzwqy2MJrm+okaoYgol0lXnW8t4+VhgZraQAQtJCcwSuaLV/HB
         xQYLDc1I8haOyCWloM27hoJtjySY+bYH8NQ+fT++FCmE53kEO+LZLbS5nlFsYkVxXnAh
         0oK7P/xdVXIcPcBJwhkmD88LF4Oo46rlJJLCDECswxAlKrtq4uAW1XhMOmG9imiI1u22
         prP2PvH/W4Ik9nUj7x/iu5RLwKfT4K2CDaGiNNLtIHpJ9HJy6U8twwJEpDxE0mVKTCt+
         i8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7MK0qgu+jx+Ly9rFkROV3Iep3bBgTueVRa2u5ntgItk=;
        b=Y8iBgwPxwUCLDM05qZvisJSpgOMAdPv3cTGEM8fVqFWMDgRRxwuccQLWaZZLGyd+Cb
         yYVofo5fYc679+wJGaivFqZe7qphn22BsyFQm6gWszBq3T+JFnZT78LMExX3Iq8eX9lG
         KdRkOXeBLZKKYJjD959DhTzVUqDFzYaUXSWd4Hn9CyoRNs1zM1GlRpZBrJXayPSx1y/t
         ZFo/oQU31CqnJ/6o9jEvlKV+9OhbPcEBe7lFH/KGmlg/dDfGyAjb9Nm2/b14E5xkbnAc
         mQRJndtfPhnXM/NZ8+wTnUh/HNBSWa8VaByKge+MSDi0tdOkQDUnOPH4kZskjGcd70/f
         j/Fg==
X-Gm-Message-State: AOAM532AZFw4K3vXylZDWwJ5lCS8cHG5k9gf/F9LCvTna0SPR6WPu/RG
        QaD624T039TXp5IPFFBF27Q=
X-Google-Smtp-Source: ABdhPJzZ4WrKI4nfHZLPTM7bnUh2nHyY37IcVpXnz6UN+ah6BjNuHpOSIhmUVfxa+An+QAM02Ca2nQ==
X-Received: by 2002:a63:554:: with SMTP id 81mr15883211pgf.298.1638744525603;
        Sun, 05 Dec 2021 14:48:45 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:1eb9:c30a:63ef:a12a])
        by smtp.gmail.com with ESMTPSA id z8sm7790984pgc.53.2021.12.05.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:48:44 -0800 (PST)
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
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3] perf/core: Set event shadow time for inactive events too
Date:   Sun,  5 Dec 2021 14:48:43 -0800
Message-Id: <20211205224843.1503081-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While commit f79256532682 ("perf/core: fix userpage->time_enabled of
inactive events") fixed this problem for user rdpmc usage, bperf (perf
stat with BPF) still has the same problem that accessing inactive perf
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
 kernel/events/core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3b3297a57228..682408ca3413 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3707,27 +3707,23 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
-static inline bool event_update_userpage(struct perf_event *event)
+static inline void update_event_time(struct perf_event *event)
 {
-	if (likely(!atomic_read(&event->mmap_count)))
-		return false;
-
 	perf_event_update_time(event);
 	perf_set_shadow_time(event, event->ctx);
-	perf_event_update_userpage(event);
 
-	return true;
+	if (unlikely(atomic_read(&event->mmap_count)))
+		perf_event_update_userpage(event);
 }
 
-static inline void group_update_userpage(struct perf_event *group_event)
+static inline void group_update_event_time(struct perf_event *group_event)
 {
 	struct perf_event *event;
 
-	if (!event_update_userpage(group_event))
-		return;
+	update_event_time(group_event);
 
 	for_each_sibling_event(event, group_event)
-		event_update_userpage(event);
+		update_event_time(event);
 }
 
 static int merge_sched_in(struct perf_event *event, void *data)
@@ -3755,7 +3751,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		} else {
 			ctx->rotate_necessary = 1;
 			perf_mux_hrtimer_restart(cpuctx);
-			group_update_userpage(event);
+			group_update_event_time(event);
 		}
 	}
 
-- 
2.34.1.400.ga245620fadb-goog

