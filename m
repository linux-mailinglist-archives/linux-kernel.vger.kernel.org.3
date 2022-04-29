Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30237515275
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379747AbiD2Ros (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344462AbiD2Rom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 597E8A27D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651254082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=im4QOF5nYM34MhWui5A0Wn5VHnCk0xBtM/XyQoOETCQ=;
        b=Ydo+4rMVrZyNL/E/34GrAD3p/uRxwjFBuekFs0hABF2E07i8zoOIG6HPQ3g5m55nGT205k
        VEo3k2UWw8Xo175SUxDjbzypVrpRdUAl00VviGnnG5ZFZ+41QUEBkruuxpfXPLY9jiBbZb
        MSNc7SFqQX81llqqRxEbwhr/QuIsrJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-YVQXGINUNxqDtzn6LZDB3g-1; Fri, 29 Apr 2022 13:41:17 -0400
X-MC-Unique: YVQXGINUNxqDtzn6LZDB3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E58E811E76;
        Fri, 29 Apr 2022 17:41:16 +0000 (UTC)
Received: from [10.22.34.10] (unknown [10.22.34.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E768240D2828;
        Fri, 29 Apr 2022 17:41:15 +0000 (UTC)
Message-ID: <b86038fe-43f8-4e16-f57d-8283b7da0bb4@redhat.com>
Date:   Fri, 29 Apr 2022 13:41:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc
 adjustment
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>, Jirka Hladky <jhladky@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
 <20220314194630.1726542-3-longman@redhat.com> <87czhymql2.ffs@tglx>
 <d1a04785-4822-3a3f-5c37-81329a562364@redhat.com> <87levx8kou.ffs@tglx>
 <4f02fe46-b253-2809-0af7-f2e9da091fe9@redhat.com> <87czh50xwf.ffs@tglx>
 <68837b1a-f85b-e842-f8c0-1cad162856f4@redhat.com> <87h76ew3sb.ffs@tglx>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87h76ew3sb.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 18:38, Thomas Gleixner wrote:
> On Tue, Apr 26 2022 at 11:36, Waiman Long wrote:
>> On 4/25/22 15:24, Thomas Gleixner wrote:
>>> Yes. It's clear that the initial sync overhead is due to the cache line
>>> being remote, but I rather underestimate the compensation. Aside of that
>>> it's not guaranteed that the cache line is actually remote on the first
>>> access. It's by chance, but not by design.
>> In check_tsc_warp(), the (unlikely(prev > now) check may only be
>> triggered to record the possible wrap if last_tsc was previously written
>> to by another cpu. That requires the transfer of lock cacheline from the
>> remote cpu to local cpu as well. So sync overhead with remote cacheline
>> is what really matters here. I had actually thought about just measuring
>> local cacheline sync overhead so as to underestimate it and I am fine
>> about doing it.
> Fair enough, but what I meant is that when estimating the actual sync
> overhead then there is no guarantee that the cache line is remote.
>
> The CPU which does that estimation might have been the last to lock,
> there is no guarantee that the reference CPU locked last or wrote to the
> cache line last.
>
>>> IOW, TSC runs with a constant frequency independent of the actual CPU
>>> frequency, ergo the CPU frequency dependent execution time has an
>>> influence on the resulting compensation value, no?
>>>
>>> On the machine I tested on, it's a factor of 3 between the minimal and
>>> the maximal CPU frequency, which makes quite a difference, right?
>> Yes, I understand that. The measurement of sync_overhead is for
>> estimating the delay (in TSC cycles) that the locking overhead
>> introduces. With 1000MHz frequency, the delay in TSC cycle will be
>> double that of a cpu running at 2000MHz. So you need more compensation
>> in this case. That is why I said that as long as clock frequency doesn't
>> change in the check_tsc_wrap() loop and the sync_overhead measurement
>> part of the code, the actual cpu frequency does not matter here.
> I grant you that it does not matter for the loop under the assumption
> that the loop runs at constant frequency, but is that a guarantee that
> it does not matter later on?
Yes, that is my point that frequency doesn't matter if frequency remain 
the same. Of course, all bets are off if frequency really change.
>
> If you overcompensate by a factor of 3 because the upcoming CPU ran at
> the lowest frequency, then it might become visible later when everything
> runs at full speed.
I don't think the overhead will be directly proportional to the cpu 
frequency. A 3X increase in frequency will certainly cause the overhead 
to be lowered, but it won't be 1/3. Maybe 1/2 at most.
>
>> However about we half the measure sync_overhead as compensation to avoid
>> over-estimation, but probably increase the chance that we need a second
>> adjustment of TSC wrap.
> Half of what?

What I mean is

@@ -533,7 +551,7 @@ void check_tsc_sync_target(void)
          * really depends on CPU, node distance and frequency. Add the
          * estimated sync overhead to the adjustment value.
          */
-       cur->adjusted += cur_max_warp + sync_overhead;
+       cur->adjusted += cur_max_warp + sync_overhead/2;

         pr_warn("TSC ADJUST compensate: CPU%u observed %lld warp 
(overhead %lld>
                 cpu, cur_max_warp, sync_overhead, cur->adjusted);

>> With this patch applied, the measured overhead on the same CooperLake
>> system on different reboot runs varies from 104 to 326.
> Half of something which jumps around? Not convinced. :)
>
> Btw:
>>> Yes, I will try that experiment and report back the results.
> Could you please do that? I really like to see the data points.

I have applied your patch with some modification and below was the 
relevant part of the boot up log on a Cooperlake system with this TSC 
sync problem.

[    0.008858] smpboot: CPU 36 Converting physical 0 to logical die 2
[    0.008858] Sync overhead: 230
[    0.008858] Sync overhead: 547 A: 149597 M: 149596 F: 2500016
[    0.008858] TSC ADJUST compensate: CPU36 observed 76342 warp 
(overhead 230). Adjust: 76457
[    0.008858] smpboot: CPU 54 Converting physical 0 to logical die 3
[    0.008858] Sync overhead: 178
[    0.008858] Sync overhead: 658 A: 177970 M: 177968 F: 2500028
[    0.008858] TSC ADJUST compensate: CPU54 observed 76568 warp 
(overhead 178). Adjust: 76657

BTW, CPUs 36 and 54 are the first CPU of socket 2 and 3 respectively. It 
is always these CPUs that need TSC adjustment.

I have no idea why the sync overhead actually increase in the subsequent 
measurement as the frequency was set at 2.5GHz, I think.

I tried to offline all the CPUs in a socket and then online the first 
CPU as suggested. However, I was not able to cause the tsc_sync loop to run.

BTW, without my patch the same system will boot up with the following log:

[    0.008823] TSC ADJUST compensate: CPU36 observed 86036 warp. Adjust: 
86036
[    0.008823] TSC ADJUST compensate: CPU36 observed 122 warp. Adjust: 86158
[    0.923620] Measured 2 cycles TSC warp between CPUs, turning off TSC 
clock.
[    0.923620] tsc: Marking TSC unstable due to check_tsc_sync_source failed

How about we add the full sync_overhead at bootup stage, but then half 
sync_overhead after boot in case the tsc_sync loop is run again for new 
online CPUs? Or any other scheme that you think is appropriate.

Cheers,
Longman

