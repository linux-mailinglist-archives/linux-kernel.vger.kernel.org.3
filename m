Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C624F4764
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354248AbiDEVKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387700AbiDENP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:15:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD1612F156
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:21:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08866D6E;
        Tue,  5 Apr 2022 05:21:14 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2881B3F5A1;
        Tue,  5 Apr 2022 05:21:12 -0700 (PDT)
Message-ID: <f71d132d-02a0-918c-ab2b-3234d0d492a4@arm.com>
Date:   Tue, 5 Apr 2022 14:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Linux 5.18-rc1] WARNING: CPU: 1 PID: 0 at
 kernel/sched/fair.c:3355 update_blocked_averages
Content-Language: en-US
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <b86541ea-7d96-5a24-1b65-37c24c70d3ff@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2022 08:19, Ammar Faizi wrote:
> 
> Hello scheduler maintainers,
> 
> I got the following warning in Linux 5.18-rc1, I don't have the
> reproducer yet,
> it happens randomly. Please shed some light.

Tried to recreate the issue but no success so far. I used you config
file, clang-14 and a Xeon CPU E5-2690 v2 (2 sockets 40 CPUs) with 20
two-level cgoupv1 taskgroups '/X/Y' with 'hackbench (10 groups, 40 fds)
+ idling' running in all '/X/Y/'.

What userspace are you running?

There seemed to be some pressure on your machine when it happened?

> <6>[13420.623334][    C7] perf: interrupt took too long (2530 > 2500),
> lowering kernel.perf_event_max_sample_rate to 78900

Maybe you could split the SCHED_WARN_ON so we know which signal causes this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..0d45e09e5bfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3350,9 +3350,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq
*cfs_rq)
         * Make sure that rounding and/or propagation of PELT values never
         * break this.
         */
-       SCHED_WARN_ON(cfs_rq->avg.load_avg ||
-                     cfs_rq->avg.util_avg ||
-                     cfs_rq->avg.runnable_avg);
+       SCHED_WARN_ON(cfs_rq->avg.load_avg);
+       SCHED_WARN_ON(cfs_rq->avg.util_avg);
+       SCHED_WARN_ON(cfs_rq->avg.runnable_avg);

        return true;
 }

[...]
