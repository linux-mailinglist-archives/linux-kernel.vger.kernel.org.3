Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8D550A89
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiFSMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiFSMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:14:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015CB86A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:14:08 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1o2toa-0007gd-H3; Sun, 19 Jun 2022 14:14:04 +0200
Message-ID: <67d39f78-8eed-f49a-b3b0-18f77f9821cd@leemhuis.info>
Date:   Sun, 19 Jun 2022 14:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Content-Language: en-US
To:     Michael Larabel <Michael@MichaelLarabel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <YhUI1wUtV8yguijO@fuller.cnet> <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
 <Yin7hDxdt0s/x+fp@fuller.cnet> <YkWyLaom/r7jXgbA@zn.tnic>
 <YmrWK/KoU1zrAxPI@fuller.cnet>
 <20220528141809.732788db257253396462c79e@linux-foundation.org>
 <134065a4-0446-bbbc-fca8-59f32798cf08@MichaelLarabel.com>
 <0ce05ce7-1a00-82df-f37a-bf7f9e216504@MichaelLarabel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <0ce05ce7-1a00-82df-f37a-bf7f9e216504@MichaelLarabel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1655640848;5a151fbe;
X-HE-SMSGID: 1o2toa-0007gd-H3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 29.05.22 02:48, Michael Larabel wrote:
> On 5/28/22 17:54, Michael Larabel wrote:
>> On 5/28/22 16:18, Andrew Morton wrote:
>>> On Thu, 28 Apr 2022 15:00:11 -0300 Marcelo Tosatti
>>> <mtosatti@redhat.com> wrote:
>>>> On Thu, Mar 31, 2022 at 03:52:45PM +0200, Borislav Petkov wrote:
>>>>> On Thu, Mar 10, 2022 at 10:22:12AM -0300, Marcelo Tosatti wrote:
>>>>> Someone pointed me at this:
>>>>> https://www.phoronix.com/scan.php?page=news_item&px=Linux-518-Stress-NUMA-Goes-Boom
>>>>>
>>>>> which says this one causes a performance regression with stress-ng's
>>>>> NUMA test...
>>>>
>>>> This is probably do_migrate_pages that is taking too long due to
>>>> synchronize_rcu().
>>>>
>>>> Switching to synchronize_rcu_expedited() should probably fix it...
>>>> Can you give it a try, please?
>>> I guess not.
>>>
>>> Is anyone else able to demonstrate a stress-ng performance regression
>>> due to ff042f4a9b0508?  And if so, are they able to try Marcelo's
>>> one-liner?
>>
>> Apologies I don't believe I got the email previously (or if it ended
>> up in spam or otherwise overlooked) so just noticed this thread now...
>>
>> I have the system around and will work on verifying it can reproduce
>> still and can then test the patch, should be able to get it tomorrow.
>>
>> Thanks and sorry about the delay.
> 
> Had a chance to look at it today still. I was able to reproduce the
> regression still on that 5950X system going from v5.17 to v5.18 (using
> newer stress-ng benchmark and other system changes since the prior
> tests). Confirmed it also still showed slower as of today's Git.
> 
> I can confirm with Marcelo's patch below that the stress-ng NUMA
> performance is back to the v5.17 level of performance (actually, faster)
> and certainly not like what I was seeing on v5.18 or Git to this point.
> 
> So all seems to be good with that one-liner for the stress-ng NUMA test
> case. All the system details and results for those interested is
> documented @ https://openbenchmarking.org/result/2205284-PTS-NUMAREGR17
> but basically amounts to:
> 
>     Stress-NG 0.14
>     Test: NUMA
>     Bogo Ops/s > Higher Is Better
>     v5.17: 412.88
>     v5.18: 49.33
>     20220528 Git: 49.66
>     20220528 Git + sched-rcu-exped patch: 468.81
> 
> Apologies again about the delay / not seeing the email thread earlier.
>lru_cache_disable: replace work queue synchronization with synchronize_rcu 
> Thanks,
> 
> Michael
> 
> Tested-by: Michael Larabel <Michael@MichaelLarabel.com>

Andrew, is there a reason why this patch afaics isn't mainlined yet and
lingering in linux-next for so long? Michael confirmed that this patch
fixes a regression three weeks ago and a few days later Stefan confirmed
that his problem was solved as well:
https://lore.kernel.org/regressions/79bb603e-37cb-d1dd-1e12-7ce28d7cfdae@i2se.com/

Reminder: unless there are good reasons it shouldn't take this long to
for reason explained in
https://docs.kernel.org/process/handling-regressions.html

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

>>>> diff --git a/mm/swap.c b/mm/swap.c
>>>> index bceff0cb559c..04a8bbf9817a 100644
>>>> --- a/mm/swap.c
>>>> +++ b/mm/swap.c
>>>> @@ -879,7 +879,7 @@ void lru_cache_disable(void)
>>>>        * lru_disable_count = 0 will have exited the critical
>>>>        * section when synchronize_rcu() returns.
>>>>        */
>>>> -    synchronize_rcu();
>>>> +    synchronize_rcu_expedited();
>>>>   #ifdef CONFIG_SMP
>>>>       __lru_add_drain_all(true);
>>>>   #else
>>>>
>>>>

