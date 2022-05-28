Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B63536ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiE1XXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 19:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE1XXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 19:23:38 -0400
X-Greylist: delayed 1704 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 May 2022 16:23:36 PDT
Received: from rome.phoronix.com (rome.phoronix.com [192.211.48.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8298595
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 16:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rSkQingUjf0hyflP8WuA7Yt4okTQlQXsse1eci3zb2Y=; b=RYbFrKcbGCbNnF4uJU970TaQKP
        /4iiKFnpuXCa51gGO0jPpteZTpHlXzJk6p3Pn7PfX4skjbsPFjE72+XSCFSXLKeSON/7JGSQbI5p9
        h1eDWvfklSAbHWYk39B68dM+yocZ3WiGdMOzlsM6CKf5C+r1JKXy76ruA2kMq6LVmDmVgDEjlQoDO
        LA+N79/GMCQMASLJDKZa0v9XFVSUkqobsOnXO/DMA6owOje+h6Ybl6cb9kCieyaaBwoq6eAWERJ7o
        +LlA61ixjhb4HSJlhmeYDCH94rrLH1K1cgoSJ5ZVP53mAC29mp9SNti3elCsE3nhVA+xdM8O5nruA
        wmajwwlQ==;
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:44418 helo=[192.168.1.42])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1nv5Kv-0005AW-7i;
        Sat, 28 May 2022 18:55:08 -0400
Message-ID: <134065a4-0446-bbbc-fca8-59f32798cf08@MichaelLarabel.com>
Date:   Sat, 28 May 2022 17:54:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Content-Language: en-CA
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
From:   Michael Larabel <Michael@MichaelLarabel.com>
In-Reply-To: <20220528141809.732788db257253396462c79e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/28/22 16:18, Andrew Morton wrote:
> On Thu, 28 Apr 2022 15:00:11 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
>> On Thu, Mar 31, 2022 at 03:52:45PM +0200, Borislav Petkov wrote:
>>> On Thu, Mar 10, 2022 at 10:22:12AM -0300, Marcelo Tosatti wrote:
>> ...
>>
>>> Someone pointed me at this:
>>>
>>> https://www.phoronix.com/scan.php?page=news_item&px=Linux-518-Stress-NUMA-Goes-Boom
>>>
>>> which says this one causes a performance regression with stress-ng's
>>> NUMA test...
>> Michael,
>>
>> This is probably do_migrate_pages that is taking too long due to
>> synchronize_rcu().
>>
>> Switching to synchronize_rcu_expedited() should probably fix it...
>> Can you give it a try, please?
> I guess not.
>
> Is anyone else able to demonstrate a stress-ng performance regression
> due to ff042f4a9b0508?  And if so, are they able to try Marcelo's
> one-liner?


Apologies I don't believe I got the email previously (or if it ended up 
in spam or otherwise overlooked) so just noticed this thread now...

I have the system around and will work on verifying it can reproduce 
still and can then test the patch, should be able to get it tomorrow.

Thanks and sorry about the delay.

Michael



>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index bceff0cb559c..04a8bbf9817a 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -879,7 +879,7 @@ void lru_cache_disable(void)
>>   	 * lru_disable_count = 0 will have exited the critical
>>   	 * section when synchronize_rcu() returns.
>>   	 */
>> -	synchronize_rcu();
>> +	synchronize_rcu_expedited();
>>   #ifdef CONFIG_SMP
>>   	__lru_add_drain_all(true);
>>   #else
>>
>>
