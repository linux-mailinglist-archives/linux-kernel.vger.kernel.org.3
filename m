Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883984FAF05
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiDJQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiDJQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:44:06 -0400
Received: from euporie.uberspace.de (euporie.uberspace.de [185.26.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6512C4B421
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:41:53 -0700 (PDT)
Received: (qmail 23627 invoked by uid 989); 10 Apr 2022 16:41:50 -0000
Authentication-Results: euporie.uberspace.de;
        auth=pass (plain)
Date:   Sun, 10 Apr 2022 18:41:36 +0200
From:   Florian Fischer <florian.fischer@muhq.space>
To:     Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Schmaus <flow@cs.fau.de>
Subject: Re: [PATCH v3 2/3] perf stat: add rusage utime and stime events
Message-ID: <20220410164136.bxqtpbrmfbqxdx4n@pasture>
References: <69656438-8b9a-000b-0702-02dc480639f9@linux.intel.com>
 <20220407085721.3289414-1-florian.fischer@muhq.space>
 <20220407085721.3289414-3-florian.fischer@muhq.space>
 <CAP-5=fWC5e9PTs9PVttVDdNbCzYQVeqyuf95q181Vkg4NqJxqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWC5e9PTs9PVttVDdNbCzYQVeqyuf95q181Vkg4NqJxqg@mail.gmail.com>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1) MID_RHS_NOT_FQDN(0.5) BAYES_HAM(-0.040238)
X-Rspamd-Score: 0.359761
Received: from unknown (HELO unkown) (::1)
        by euporie.uberspace.de (Haraka/2.8.28) with ESMTPSA; Sun, 10 Apr 2022 18:41:48 +0200
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FROM_SUSPICIOUS_NTLD,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch adds two new tool internal events 'rusage_user_time'
> > and 'rusage_system_time' as well as their aliases 'ru_utime' and
> > 'ru_stime', similarly to the already present 'duration_time' event.
> >
> > Both events use the already collected rusage information obtained by wait4
> > and tracked in the global ru_stats.
> >
> > Examples presenting cache-misses and rusage information in both human and
> > machine-readable form:
> >
> > $ ./perf stat -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> >
> >  Performance counter stats for 'grep -q -r duration_time .':
> >
> >         67,422,542 ns   duration_time:u
> >         50,517,000 ns   ru_utime:u
> >         16,839,000 ns   ru_stime:u
> >             30,937      cache-misses:u
> >
> >        0.067422542 seconds time elapsed
> >
> >        0.050517000 seconds user
> >        0.016839000 seconds sys
> >
> > $ ./perf stat -x, -e duration_time,ru_utime,ru_stime,cache-misses -- grep -q -r duration_time .
> > 72134524,ns,duration_time:u,72134524,100.00,,
> > 65225000,ns,ru_utime:u,65225000,100.00,,
> > 6865000,ns,ru_stime:u,6865000,100.00,,
> > 38705,,cache-misses:u,71189328,100.00,,
> 
> This is really nice. For metric code we currently handle duration_time
> in a special way, for example:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n745
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/metricgroup.c?h=perf/core#n1131
> We will need to do something similar with these tool events, but I'm
> happy that it can be follow-up work.
> 
> I'm not a huge fan of the names ru_utime and ru_stime, two thoughts
> here we could do duration_time:u and duration_time:k but I don't think
> that really makes sense. My preference would be to just call ru_utime
> user_time and ru_stime system_time.

I considered ru_{u,s}_time only as aliases because those are the field names in
the rusage struct filled by wait4 and are probably known by perf users.
The "official" names are currently rusage_{user,system}_time.
I could change them to only {user,system}_time because those names are more in line
with the already present duration_time and are independent of the rusage
implementation detail.

What do you think of?

---
 tools/perf/util/parse-events.c | 4 ++--
 tools/perf/util/parse-events.l | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c232ab79d434..afcba6671748 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -160,11 +160,11 @@ struct event_symbol event_symbols_tool[PERF_TOOL_LAST] = {
 		.alias  = "",
 	},
 	[PERF_TOOL_RU_UTIME] = {
-		.symbol = "rusage_user_time",
+		.symbol = "user_time",
 		.alias  = "ru_utime",
 	},
 	[PERF_TOOL_RU_STIME] = {
-		.symbol = "rusage_system_time",
+		.symbol = "system_time",
 		.alias  = "ru_stime",
 	},
 };
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 3c7227b8035c..7ee8613b6011 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -353,8 +353,8 @@ alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_AL
 emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
 duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
-rusage_user_time|ru_utime	{ return tool(yyscanner, PERF_TOOL_RU_UTIME); }
-rusage_system_time|ru_stime	{ return tool(yyscanner, PERF_TOOL_RU_STIME); }
+user_time|ru_utime	{ return tool(yyscanner, PERF_TOOL_RU_UTIME); }
+system_time|ru_stime	{ return tool(yyscanner, PERF_TOOL_RU_STIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
 cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
-- 
2.35.1

Florian Fischer
