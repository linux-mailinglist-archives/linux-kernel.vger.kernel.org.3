Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1AE50E2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiDYOSW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 10:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiDYOST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:18:19 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A513F70
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:15:13 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 09C6DCAA6A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:07:52 +0000 (UTC)
Received: (Authenticated sender: christophe@dinechin.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A4E41C0007;
        Mon, 25 Apr 2022 14:07:44 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
From:   Christophe de Dinechin <christophe@dinechin.org>
In-Reply-To: <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
Date:   Mon, 25 Apr 2022 16:07:43 +0200
Cc:     Christophe de Dinechin <dinechin@redhat.com>, trivial@kernel.org,
        Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5AEAD35F-10E2-41A3-8269-E8358160D33B@dinechin.org>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 14 Apr 2022, at 17:21, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Apr 14, 2022 at 05:08:53PM +0200, Christophe de Dinechin wrote:
>> With gcc version 12.0.1 20220401 (Red Hat 12.0.1-0) (GCC), the following
>> errors are reported in sched.h when building after `make defconfig`:
> 
> <snip tons of noise>

I don’t mind removing the detailed error message.
What do others think?

> 
>> Rewrite the definitions of sched_class_highest and for_class_range to
>> avoid this error as follows:
>> 
>> 1/ The sched_class_highest is rewritten to be relative to
>>  __begin_sched_classes, so that GCC sees it as being part of the
>>  __begin_sched_classes array and not a distinct __end_sched_classes
>>  array.
>> 
>> 2/ The for_class_range macro is modified to replace the comparison with
>>  an out-of-bound pointer __begin_sched_classes - 1 with an equivalent,
>>  but in-bounds comparison.
>> 
>> In that specific case, I believe that the GCC analysis is correct and
>> potentially valuable for other arrays, so it makes sense to keep it
>> enabled.
>> 
>> Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>> kernel/sched/sched.h | 11 +++++++++--
>> 1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 8dccb34eb190..6350fbc7418d 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -2193,11 +2193,18 @@ const struct sched_class name##_sched_class \
>> extern struct sched_class __begin_sched_classes[];
>> extern struct sched_class __end_sched_classes[];
>> 
>> -#define sched_class_highest (__end_sched_classes - 1)
>> +/*
>> + * sched_class_highests is really __end_sched_classes - 1, but written in a way
>> + * that makes it clear that it is within __begin_sched_classes[] and not outside
>> + * of __end_sched_classes[].
>> + */
>> +#define sched_class_highest (__begin_sched_classes + \
>> +			     (__end_sched_classes - __begin_sched_classes - 1))
>> #define sched_class_lowest  (__begin_sched_classes - 1)
>> 
>> +/* The + 1 below places the pointers within the range of their array */
>> #define for_class_range(class, _from, _to) \
>> -	for (class = (_from); class != (_to); class--)
>> +	for (class = (_from); class + 1 != (_to) + 1; class--)
> 
> Urgh, so now we get less readable code,

You consider the original code readable? It actually relies on a
precise layout that is not enforced in this code, not even documented,
but actually enforced by the linker script.

> just because GCC is being
> stupid?

I think that GCC is actually remarkably smart there. It tells you
that you are building pointers to A[] from B[], when there is a legit
way to say that the pointer is in A[] (which is what my patch does)

> What's wrong with negative array indexes? memory is memory, stuff works.

What’s wrong is that the compiler cannot prove theorems anymore.
These theorems are used to optimise code. When you write -1[B], the
compiler cannot optimise based on knowing this refers to A[B-A-1].

While at first, you might think that disabling a warning is a win, what comes next
is the compiler optimizing in a way you did not anticipate, mysterious bugs showing up,
and/or having to turn off some potentially useful optimisation.


