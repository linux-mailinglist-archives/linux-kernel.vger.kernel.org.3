Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC35373A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 04:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiE3C6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiE3C6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 22:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6A6013EA9
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 19:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653879482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0F2iM93pAQScZ6IrDR6JIapWv5t22dzOEWiab/LiU0=;
        b=WxnuVd1Pit/FxLQ3hNqaZCs2ZMJt7KjHOLZdTac05913n2pw5cxIF/6wN38bDMWCBmn+PC
        u4lick5Zze0rSJVYGko1NxrSMuSUtIZPcASkzSQcDQ4Dhmw6QG+pVCUJYAeorPUOUZjC3f
        AoFwwF9CscJfGGyOM62PVO7DJqvO3Ig=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-7FcdjyB4NUaNhDA1BfwMig-1; Sun, 29 May 2022 22:57:50 -0400
X-MC-Unique: 7FcdjyB4NUaNhDA1BfwMig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 792A21C05143;
        Mon, 30 May 2022 02:57:50 +0000 (UTC)
Received: from [10.22.32.73] (unknown [10.22.32.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05FF240F9D42;
        Mon, 30 May 2022 02:57:49 +0000 (UTC)
Message-ID: <220cde85-d932-6b26-5fca-9880f8a2de08@redhat.com>
Date:   Sun, 29 May 2022 22:57:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clocksource: Make clocksource watchdog check with
 WATCHDOG_INTERVAL period
Content-Language: en-US
To:     Michael Larabel <Michael@phoronix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        John Stultz <jstultz@google.com>
Cc:     linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Michey Mehta <mimehta@redhat.com>
References: <20220528015714.109442-1-longman@redhat.com>
 <fa2d516e-70b5-3012-9134-5ca325282bc4@redhat.com>
 <6a5b80e8-a614-5452-4cf0-b636fa9b23cc@phoronix.com>
 <b8ae204b-0e92-a87e-5ae0-0b38d2adb33a@redhat.com>
 <15f9bf67-8ee4-9ade-987b-78c20966edc1@phoronix.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <15f9bf67-8ee4-9ade-987b-78c20966edc1@phoronix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/22 20:43, Michael Larabel wrote:
>
> On 5/29/22 19:16, Waiman Long wrote:
>> On 5/29/22 18:16, Michael Larabel wrote:
>>> On 5/27/22 21:07, Waiman Long wrote:
>>>> On 5/27/22 21:57, Waiman Long wrote:
>>>>> Since commit c86ff8c55b8a ("clocksource: Avoid accidental unstable
>>>>> marking of clocksource"), a new WD_READ_SKIP value was introduced
>>>>> as a possible return value of cs_watchdog_read() to skip the current
>>>>> check. However, this has an undesriable side effect of extending the
>>>>> time gap between csnow and cs_last to more than one WATCHDOG_INTERVAL
>>>>> (0.5s) in case of intermittent WD_READ_SKIP's.
>>>>>
>>>>> There was an instance of reported clocksource watchdog failure with
>>>>> the time skew of 485us where the uncertainly threshold is 400us. In
>>>>> that particular case, the (now - last) gap was about 2s. Looking at
>>>>> the dmesg log, it was clear there was a successful cs_watchdog_read()
>>>>> followed by 3 skips and then another successful cs_watchdog_read().
>>>>>
>>>>> If there is an existing skew between the hpet (watchdog) and tsc
>>>>> clocksource, enlarging the period by 4x will certainly increase the
>>>>> measured skew causing it to exceed the threshold in this case. Fix
>>>>> this variable period problem by resetting the 
>>>>> CLOCK_SOURCE_WATCHDOG bit
>>>>> after each WD_READ_SKIP to force the reloading of wd_last and cs_last
>>>>> in the next round. This ensures that we have two consecutive 
>>>>> successful
>>>>> cs_watchdog_read()'s before checking the clock skew.
>>>>>
>>>>> Fixes: c86ff8c55b8a ("clocksource: Avoid accidental unstable 
>>>>> marking of clocksource")
>>>>> Reported-by: Michael Larabel <Michael@phoronix.com>
>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>> ---
>>>>>   kernel/time/clocksource.c | 11 ++++++++++-
>>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>>>>> index cee5da1e54c4..173e052c12b6 100644
>>>>> --- a/kernel/time/clocksource.c
>>>>> +++ b/kernel/time/clocksource.c
>>>>> @@ -411,9 +411,18 @@ static void clocksource_watchdog(struct 
>>>>> timer_list *unused)
>>>>>           read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
>>>>>             if (read_ret != WD_READ_SUCCESS) {
>>>>> -            if (read_ret == WD_READ_UNSTABLE)
>>>>> +            if (read_ret == WD_READ_UNSTABLE) {
>>>>>                   /* Clock readout unreliable, so give it up. */
>>>>>                   __clocksource_unstable(cs);
>>>>> +            } else { /* WD_READ_SKIP */
>>>>> +                /*
>>>>> +                 * Watchdog clock unstable at the moment,
>>>>> +                 * discard the stored wd_last and cs_last to
>>>>> +                 * make sure the gap between now and last
>>>>> +                 * is always one WATCHDOG_INTERVAL.
>>>>> +                 */
>>>>> +                cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
>>>>> +            }
>>>>>               continue;
>>>>>           }
>>>>
>>>> Sorry, I accidentally use the old email address for John.
>>>>
>>>> Cheers,
>>>> Longman
>>>
>>>
>>> I've tested this patch on the affected Daytona + Milan-X system and 
>>> can confirm it does fix the performance problem that led to this 
>>> issue. Though it is spamming the kernel log now every half-second 
>>> with clocksource messages,  not sure if that is intended/desirable 
>>> behavior?
>>>
>>>
>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>> [    0.000000] tsc: Detected 2195.990 MHz processor
>>> [    1.238759] clocksource: tsc-early: mask: 0xffffffffffffffff 
>>> max_cycles: 0x1fa766bc6ba, max_idle_ns: 440795275714 ns
>>> [    2.769608] clocksource: Switched to clocksource tsc-early
>>> [    3.263925] clocksource: wd-tsc-early-wd read-back delay of 
>>> 292215ns, clock-skew test skipped!
>>> [    3.743804] clocksource: wd-tsc-early-wd read-back delay of 
>>> 268469ns, clock-skew test skipped!
>>> [    3.935663] tsc: Refined TSC clocksource calibration: 2195.274 MHz
>>> [    3.935844] clocksource: tsc: mask: 0xffffffffffffffff 
>>> max_cycles: 0x1fa4c255513, max_idle_ns: 440795289702 ns
>>> [    3.936449] clocksource: Switched to clocksource tsc
>>> [    4.255932] clocksource: wd-tsc-wd read-back delay of 260228ns, 
>>> clock-skew test skipped!
>>> [    4.767892] clocksource: wd-tsc-wd read-back delay of 272520ns, 
>>> clock-skew test skipped!
>>> [    5.247581] clocksource: wd-tsc-wd read-back delay of 200444ns, 
>>> clock-skew test skipped!
>>> [    5.759560] clocksource: wd-tsc-wd read-back delay of 165942ns, 
>>> clock-skew test skipped!
>>> [    6.239687] clocksource: wd-tsc-wd read-back delay of 232222ns, 
>>> clock-skew test skipped!
>>> [    7.264014] clocksource: wd-tsc-wd read-back delay of 282927ns, 
>>> clock-skew test skipped!
>>> [    7.743864] clocksource: wd-tsc-wd read-back delay of 288374ns, 
>>> clock-skew test skipped!
>>> [    8.255590] clocksource: wd-tsc-wd read-back delay of 206730ns, 
>>> clock-skew test skipped!
>>> [    8.767778] clocksource: wd-tsc-wd read-back delay of 267771ns, 
>>> clock-skew test skipped!
>>> [    9.247870] clocksource: wd-tsc-wd read-back delay of 224469ns, 
>>> clock-skew test skipped!
>>> [   10.239340] clocksource: wd-tsc-wd read-back delay of 109720ns, 
>>> clock-skew test skipped!
>>> [   12.255276] clocksource: wd-tsc-wd read-back delay of 104692ns, 
>>> clock-skew test skipped!
>>> [   16.255362] clocksource: wd-tsc-wd read-back delay of 122780ns, 
>>> clock-skew test skipped!
>>> [   17.759335] clocksource: wd-tsc-wd read-back delay of 155885ns, 
>>> clock-skew test skipped!
>>> [   18.239500] clocksource: wd-tsc-wd read-back delay of 176558ns, 
>>> clock-skew test skipped!
>>> [   18.751341] clocksource: wd-tsc-wd read-back delay of 157352ns, 
>>> clock-skew test skipped!
>>> [   19.263618] clocksource: wd-tsc-wd read-back delay of 177606ns, 
>>> clock-skew test skipped!
>>> [   19.743487] clocksource: wd-tsc-wd read-back delay of 157841ns, 
>>> clock-skew test skipped!
>>> [   20.255482] clocksource: wd-tsc-wd read-back delay of 157701ns, 
>>> clock-skew test skipped!
>>> [   20.767634] clocksource: wd-tsc-wd read-back delay of 173136ns, 
>>> clock-skew test skipped!
>>> [   21.247405] clocksource: wd-tsc-wd read-back delay of 175441ns, 
>>> clock-skew test skipped!
>>> ...
>>>
>>> Thanks,
>>> Michael
>>>
>> Thanks for the testing. Did the spamming stop after a while?
>>
>> It does show that your particular Milan-X CPU(s) have unreliable 
>> hpet. The only way to stop the spamming is to build a kernel with a 
>> larger CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US. By default, it is 
>> 100us. The allowable hpet-hpet delay is only half of that. In this 
>> particular case, it will have to be set to at least 500 or maybe even 
>> 600.
>>
>> Thanks,
>> Longman
>>
>
> No, the spamming hadn't stopped. At least as of one hour into the 
> uptime it was still spewing every half second. Can confirm tomorrow if 
> it ever stops after a longer duration but at least as of one hour of 
> running the benchmarks to verify the performance was back to 
> expectations, I had shut down that server to move onto other work.

With my past experience, hpet read will slow down significantly when the 
system is running a very cpu intensive workload leading to cpu being 
under thermal stress. Benchmarking is certainly an activity that may 
trigger this problem. However, they usually go away when the cpus are 
not at 100% load anymore and the system can cool down.

If this still happens at idle, there is definitely something wrong with 
the cpus. I don't think we have Milan system internally that can 
reproduce this problem at the moment. However Milan-X has HBM memory 
chiplets on top of the cpu chiplets. That may make heat dissipation 
harder and exacerbate this hpet problem.

Thanks,
Longman

