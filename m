Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568D6536EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiE2AsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 20:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiE2AsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 20:48:19 -0400
Received: from rome.phoronix.com (rome.phoronix.com [192.211.48.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC04AE09
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 17:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bv4ctk2wOB3a6MaSBmKnYZVDVHvcziEuha9CgdDBEWs=; b=DJanTn/QOTp6PI2o6esHyJGtc2
        yP9SoySPi2FsnqDd9GAO7fD2hMlitgIfEmis8cWeXBOTitfUWMhA33eM2T53eqV1zAdwuqahAmQRG
        do3diXomYRhwtLbWoyvHGixQsx1UNZbB0Qe4X4CJ5JXvbPqwhsgMKFFJjjHbcHBH9CZpIN7isdynQ
        +CpYhkJyYMx7Y8BNlB0MeNjWvgvMATkNq9fnMN2QcJBS3YBzSe44XALQ/9hQM8amXRItdPqEDnoRo
        3tVOHJAXuLWoRRt6Q9OmpXFlw2lOxbCid/FL6RgvyrAY6Z/dVC4fbRF/Fa7MMh3+5QNiSaPN4nwcq
        H/N+s3pw==;
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:44420 helo=[192.168.1.42])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1nv76N-0001v0-2P;
        Sat, 28 May 2022 20:48:14 -0400
Message-ID: <0ce05ce7-1a00-82df-f37a-bf7f9e216504@MichaelLarabel.com>
Date:   Sat, 28 May 2022 19:48:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Content-Language: en-CA
From:   Michael Larabel <Michael@MichaelLarabel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <YhUI1wUtV8yguijO@fuller.cnet> <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
 <Yin7hDxdt0s/x+fp@fuller.cnet> <YkWyLaom/r7jXgbA@zn.tnic>
 <YmrWK/KoU1zrAxPI@fuller.cnet>
 <20220528141809.732788db257253396462c79e@linux-foundation.org>
 <134065a4-0446-bbbc-fca8-59f32798cf08@MichaelLarabel.com>
In-Reply-To: <134065a4-0446-bbbc-fca8-59f32798cf08@MichaelLarabel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - MichaelLarabel.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@michaellarabel.com
X-Authenticated-Sender: rome.phoronix.com: michael@michaellarabel.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/22 17:54, Michael Larabel wrote:
> On 5/28/22 16:18, Andrew Morton wrote:
>> On Thu, 28 Apr 2022 15:00:11 -0300 Marcelo Tosatti 
>> <mtosatti@redhat.com> wrote:
>>
>>> On Thu, Mar 31, 2022 at 03:52:45PM +0200, Borislav Petkov wrote:
>>>> On Thu, Mar 10, 2022 at 10:22:12AM -0300, Marcelo Tosatti wrote:
>>> ...
>>>
>>>> Someone pointed me at this:
>>>>
>>>> https://www.phoronix.com/scan.php?page=news_item&px=Linux-518-Stress-NUMA-Goes-Boom 
>>>>
>>>>
>>>> which says this one causes a performance regression with stress-ng's
>>>> NUMA test...
>>> Michael,
>>>
>>> This is probably do_migrate_pages that is taking too long due to
>>> synchronize_rcu().
>>>
>>> Switching to synchronize_rcu_expedited() should probably fix it...
>>> Can you give it a try, please?
>> I guess not.
>>
>> Is anyone else able to demonstrate a stress-ng performance regression
>> due to ff042f4a9b0508?  And if so, are they able to try Marcelo's
>> one-liner?
>
>
> Apologies I don't believe I got the email previously (or if it ended 
> up in spam or otherwise overlooked) so just noticed this thread now...
>
> I have the system around and will work on verifying it can reproduce 
> still and can then test the patch, should be able to get it tomorrow.
>
> Thanks and sorry about the delay.
>
> Michael
>
>

Had a chance to look at it today still. I was able to reproduce the 
regression still on that 5950X system going from v5.17 to v5.18 (using 
newer stress-ng benchmark and other system changes since the prior 
tests). Confirmed it also still showed slower as of today's Git.

I can confirm with Marcelo's patch below that the stress-ng NUMA 
performance is back to the v5.17 level of performance (actually, faster) 
and certainly not like what I was seeing on v5.18 or Git to this point.

So all seems to be good with that one-liner for the stress-ng NUMA test 
case. All the system details and results for those interested is 
documented @ https://openbenchmarking.org/result/2205284-PTS-NUMAREGR17 
but basically amounts to:

     Stress-NG 0.14
     Test: NUMA
     Bogo Ops/s > Higher Is Better
     v5.17: 412.88
     v5.18: 49.33
     20220528 Git: 49.66
     20220528 Git + sched-rcu-exped patch: 468.81

Apologies again about the delay / not seeing the email thread earlier.

Thanks,

Michael


Tested-by: Michael Larabel <Michael@MichaelLarabel.com>



>
>>
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index bceff0cb559c..04a8bbf9817a 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -879,7 +879,7 @@ void lru_cache_disable(void)
>>>        * lru_disable_count = 0 will have exited the critical
>>>        * section when synchronize_rcu() returns.
>>>        */
>>> -    synchronize_rcu();
>>> +    synchronize_rcu_expedited();
>>>   #ifdef CONFIG_SMP
>>>       __lru_add_drain_all(true);
>>>   #else
>>>
>>>
