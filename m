Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7330572B15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiGMBxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 21:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGMBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8520D4469
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE24618E2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF779C3411C;
        Wed, 13 Jul 2022 01:53:00 +0000 (UTC)
Date:   Tue, 12 Jul 2022 21:52:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: schedstat false counting of domain load_balance() tried to move one
 or more tasks failed
Message-ID: <20220712215259.6cb28bed@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been tasked to analyze the /proc/schedstat file to determine
appropriate metrics to look after in production. So I'm looking at both the
documentation and the code that generates it.

From the documentation at https://docs.kernel.org/scheduler/sched-stats.html

(and Documentation/scheduler/sched-stats.rst for those of you that are
allergic to html)

   Domain statistics
   -----------------
   One of these is produced per domain for each cpu described. (Note that if
   CONFIG_SMP is not defined, *no* domains are utilized and these lines
   will not appear in the output.)

   domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36

   The first field is a bit mask indicating what cpus this domain operates over.

   The next 24 are a variety of load_balance() statistics in grouped into types
   of idleness (idle, busy, and newly idle):

       1)  # of times in this domain load_balance() was called when the
           cpu was idle
       2)  # of times in this domain load_balance() checked but found
           the load did not require balancing when the cpu was idle
       3)  # of times in this domain load_balance() tried to move one or
           more tasks and failed, when the cpu was idle

I was looking at this #3 (which is also #11 and #19 for CPU_BUSY and
CPU_NEW_IDLE respectively). It states that it gets incremented when one or
more tasks were tried to be moved but failed. I found this is not always
the case.

We have:

	ld_moved = 0;
	/* Clear this flag as soon as we find a pullable task */
	env.flags |= LBF_ALL_PINNED;
	if (busiest->nr_running > 1) {
[..]
	}

	if (!ld_moved) {
		schedstat_inc(sd->lb_failed[idle]);

Where the lb_failed[] is that counter. I added the following code:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..4835ea4d9d01 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9865,6 +9865,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	struct rq *busiest;
 	struct rq_flags rf;
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+	bool redo = false;
 
 	struct lb_env env = {
 		.sd		= sd,
@@ -10012,11 +10013,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = sched_nr_migrate_break;
+				redo = true;
 				goto redo;
 			}
 			goto out_all_pinned;
 		}
-	}
+	} else if (!redo)
+		trace_printk("Did not try to move! %d\n", idle);
 
 	if (!ld_moved) {
 		schedstat_inc(sd->lb_failed[idle]);


And sure enough that triggers on CPU_IDLE and CPU_NEW_IDLE calls (I haven't
seen it for CPU_BUSY yet, but I didn't try).

Thus, if we get to that check for (busiest->nr_running > 1) and fail, then
we will increment that counter incorrectly.

Do we care? Should it be fixed? Should it be documented?

Thoughts?

-- Steve

