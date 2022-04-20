Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD214509012
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354704AbiDTTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbiDTTO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:14:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B94D845054
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:12:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BF81477;
        Wed, 20 Apr 2022 12:12:09 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29213F766;
        Wed, 20 Apr 2022 12:12:07 -0700 (PDT)
Message-ID: <df0c4d87-68be-7aef-597f-043b3c7fea59@arm.com>
Date:   Wed, 20 Apr 2022 21:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [External] Re: [PATCH] sched/core: Avoid obvious double
 update_rq_clock warning
To:     Hao Jia <jiahao.os@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
 <20220419104828.GQ2731@worktop.programming.kicks-ass.net>
 <c1e7fc17-b091-1da1-7fa8-0490cc7f7e4b@bytedance.com>
Content-Language: en-US
In-Reply-To: <c1e7fc17-b091-1da1-7fa8-0490cc7f7e4b@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 10:29, Hao Jia wrote:
> On 4/19/22 6:48 PM, Peter Zijlstra wrote:
>> On Mon, Apr 18, 2022 at 05:09:29PM +0800, Hao Jia wrote:

[...]

>> I'm really not sure about this part though. This is a bit of a mess. The
>> balancer doesn't really need the pinning stuff. I realize you did that
>> because we got the clock annotation mixed up with that, but urgh.
>>
>> Basically we want double_rq_lock() / double_lock_balance() to clear
>> RQCF_UPDATED, right? Perhaps do that directly?
>>
>> (maybe with an inline helper and a wee comment?)
>>
>> The only immediate problem with this would appear to be that
>> _double_rq_lock() behaves differently when it returns 0. Not sure that
>> matters.
>>
>> Hmm?
> 
> Thanks for your review comments.
> As you have prompted, the WARN_DOUBLE_CLOCK warning is still triggered
> when _double_rq_lock() returns 0.
> Please review the solution below, and based on your review, I will
> submit the v2 patch as soon as possible.
> Thanks.


[...]

Maybe something like this:

-->8--

From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Wed, 20 Apr 2022 11:12:10 +0200
Subject: [PATCH] sched/core: Clear RQCF_UPDATED in _double_lock_balance() &
 double_rq_lock()

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |  6 +++---
 kernel/sched/sched.h | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 068c088e9584..f4cfe7eea861 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -610,10 +610,10 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 		swap(rq1, rq2);
 
 	raw_spin_rq_lock(rq1);
-	if (__rq_lockp(rq1) == __rq_lockp(rq2))
-		return;
+	if (__rq_lockp(rq1) != __rq_lockp(rq2))
+		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
 
-	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+	rq_clock_clear_update(rq1, rq2);
 }
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58263f90c559..3a77b10d7cc4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2515,6 +2515,16 @@ static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 
 extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
 
+#ifdef CONFIG_SCHED_DEBUG
+static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
+{
+	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+}
+#else
+static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
+#endif
+
 #ifdef CONFIG_PREEMPTION
 
 /*
@@ -2549,14 +2559,15 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
-		return 0;
-
-	if (likely(raw_spin_rq_trylock(busiest)))
+	if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
+	    likely(raw_spin_rq_trylock(busiest))) {
+		rq_clock_clear_update(this_rq, busiest);
 		return 0;
+	}
 
 	if (rq_order_less(this_rq, busiest)) {
 		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
+		rq_clock_clear_update(this_rq, busiest);
 		return 0;
 	}
 
@@ -2650,6 +2661,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	BUG_ON(rq1 != rq2);
 	raw_spin_rq_lock(rq1);
 	__acquire(rq2->lock);	/* Fake it out ;) */
+	rq_clock_clear_update(rq1, rq2);
 }
 
 /*
-- 
2.25.1
