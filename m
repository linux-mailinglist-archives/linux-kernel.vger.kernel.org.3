Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE1492C01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347040AbiARRLH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jan 2022 12:11:07 -0500
Received: from foss.arm.com ([217.140.110.172]:33658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243715AbiARRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:11:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0A5D6E;
        Tue, 18 Jan 2022 09:11:05 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A1B3F774;
        Tue, 18 Jan 2022 09:11:04 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Again ignore percpu threads for imbalance pulls
In-Reply-To: <81d85a50-e54e-e74a-14a9-348413850f73@linux.alibaba.com>
References: <20211211094808.109295-1-wuyihao@linux.alibaba.com> <87k0g48kyp.mognet@arm.com> <5f8497cd-aeaf-906d-a2d8-2e0a752fed4b@linux.alibaba.com> <87ee56705h.mognet@arm.com> <81d85a50-e54e-e74a-14a9-348413850f73@linux.alibaba.com>
Date:   Tue, 18 Jan 2022 17:10:59 +0000
Message-ID: <87bl096kbg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/22 16:11, Yihao Wu wrote:
> On 2022/1/18 1:16 am, Valentin Schneider wrote:
>> On 17/01/22 22:50, Yihao Wu wrote:
>>> wakeup balance keeps doing this until another NUMA node becomes so busy.
>>> And another periodic load balance just shifts it around, makeing the
>>> previously overloaded node completely idle now.
>>>
>> 
>> Oooh, right, I came to the same conclusion when I got that stress-ng
>> regression report back then:
>> 
>> https://lore.kernel.org/all/871rajkfkn.mognet@arm.com/
>> 
>
> Shocked! I wasted weeks to locate almost the same regression. Why on
> earth haven't I read your discussion of half a year ago?
>

I've been there too :) It's a tricky thing, you have to at least do a
bisection to find some commit, and then look up the ML if there's been any
further discussion / report on it...

>> I pretty much gave up on that as the regression we caused by removing an
>> obscure/accidental balance which I couldn't properly codify. I can give it
>
> Strange, the regression reported to me says differently from yours.
>
>                   4.19.91      before_2f5f4      after_2f5f4
>    my_report         good          bad               bad
> your_report          N/A         good               bad
>
> your_report says 2f5f4 introduces new regression. While
> my_report says 2f5f4 fails and leaves the old regression be ...
>
> Maybe that's the reason why you give up on fixing it, yet I came to make 
> can_migrate_task cover more cases (kernel_thread).
>

Huh; 2f5f4cce496e is actually a 5.10-stable backport of 9bcb959d05ee; what
was the first bad commit for you?

>
>> another shot, but AFAICT that only affects fork/exec heavy workloads (that
>> -13% was on something doing almost only forks) which is an odd case to
>> support.
>>
> Yes. They're indeed quite odd workloads.
> - Apps with massive shortlived threads better change runtime model, or
> use a thread pool.
> - Massive different apps on the same machine are even odder.
>
> But I guess this problem affects normal workloads too, more or less but
> not significantly. Hard to tell exactly how much influence it has.
>

Looking at my notes for the regression on that particular machine for that particular
benchmark, the group_imbalanced logic triggers for ~1% of the forks, and
the avg task lifespan was 6µs. IMO that's pretty extreme, fork-time balance
becomes the only available balance point for the child tasks (IIRC
benchmark has N stressors forking one child each) - as you said above a
more realistic approach here should use a thread pool of some sort.
