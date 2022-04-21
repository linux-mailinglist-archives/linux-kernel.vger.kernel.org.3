Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D949509DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388412AbiDUKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiDUKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:35:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59D9E237F8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:32:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56CA1477;
        Thu, 21 Apr 2022 03:32:34 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 626363F5A1;
        Thu, 21 Apr 2022 03:32:33 -0700 (PDT)
Message-ID: <4b2af80f-a6d6-30b3-11f2-8f5e3e6e5c5f@arm.com>
Date:   Thu, 21 Apr 2022 12:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [External] Re: [PATCH] sched/core: Avoid obvious double
 update_rq_clock warning
Content-Language: en-US
To:     Hao Jia <jiahao.os@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
 <20220419104828.GQ2731@worktop.programming.kicks-ass.net>
 <c1e7fc17-b091-1da1-7fa8-0490cc7f7e4b@bytedance.com>
 <df0c4d87-68be-7aef-597f-043b3c7fea59@arm.com>
 <84f61791-8cf2-b955-5d71-1cab15129ab2@bytedance.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <84f61791-8cf2-b955-5d71-1cab15129ab2@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2022 09:24, Hao Jia wrote:
> On 2022/4/21 Dietmar Eggemann wrote:
>> On 20/04/2022 10:29, Hao Jia wrote:
>>> On 4/19/22 6:48 PM, Peter Zijlstra wrote:
>>>> On Mon, Apr 18, 2022 at 05:09:29PM +0800, Hao Jia wrote:

[...]

> Thanks for your review.
> This is very helpful to me.
> If CONFIG_SMP is not enabled, should we just clear the RQCF_UPDATED of
> one of rq1 and q2?
> 
> like this:
> rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);

[...]

We could take care of that within rq_clock_clear_update() if really
needed?
Anyway, for !CONFIG_SMP builds rq_clock_clear_update() has to be defined
outside #ifdef CONFIG_SMP.

-->8--

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3a77b10d7cc4..614b822c667c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2484,6 +2484,17 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_DEBUG
+static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
+{
+	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#ifdef CONFIG_SMP
+	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
+}
+#else
+static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
+#endif
 
 #ifdef CONFIG_SMP
 
@@ -2515,16 +2526,6 @@ static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 
 extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
 
-#ifdef CONFIG_SCHED_DEBUG
-static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
-{
-	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
-	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
-}
-#else
-static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
-#endif
-
 #ifdef CONFIG_PREEMPTION
 
 /*
