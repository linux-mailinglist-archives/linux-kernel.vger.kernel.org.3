Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5004B50E177
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbiDYNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiDYNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5559925284
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650892864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWPdlEtujqDVnC2G/s71rNJHwIOuYSpZ3ESF7eW67PI=;
        b=FiqKQuCDQE62+Iv1WXYSSHhG6MmjTTsUtGK41lOKF0COMNm7Cy/pCC23LSxOAKwye2JLjr
        vUJtsJOPR0sAzZlGNkEvB5EHpPNtCjP1Y9Tru4shr/5f4jpRAGXjrzphJck25r2MTXTMS8
        ZrH1LnSrJhf5AaPTQ5pEIjGIuseVzhk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-2OgsJ4YQNdu5vbpu5R6emg-1; Mon, 25 Apr 2022 09:21:01 -0400
X-MC-Unique: 2OgsJ4YQNdu5vbpu5R6emg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BC7B833962;
        Mon, 25 Apr 2022 13:21:00 +0000 (UTC)
Received: from [10.22.9.66] (unknown [10.22.9.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 452404087D8B;
        Mon, 25 Apr 2022 13:20:59 +0000 (UTC)
Message-ID: <4f02fe46-b253-2809-0af7-f2e9da091fe9@redhat.com>
Date:   Mon, 25 Apr 2022 09:20:59 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87levx8kou.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 06:41, Thomas Gleixner wrote:
> On Mon, Apr 18 2022 at 11:41, Waiman Long wrote:
>> On 4/3/22 06:03, Thomas Gleixner wrote:
>> [    0.008815] TSC ADJUST compensate: CPU36 observed 86056 warp
>> (overhead 150). Adjust: 86206
>> [    0.008815] TSC ADJUST compensate: CPU54 observed 86148 warp
>> (overhead 158). Adjust: 86306
>>
>>> Also if the compensation value is at the upper end and the real overhead
>>> is way lower then the validation run might end up with the opposite
>>> result. I'm a bit worried about this variation.
>> I also have a little concern about that. That is why I add patch 1 to
>> minimize as much external interference as possible. For the TSC
>> adjustment samples that I got so far, I have never seen one that need a
>> 2nd adjustment to go backward.
> I did some experiments and noticed that the boot time overhead is
> different from the overhead when doing the sync check after boot
> (offline a socket and on/offline the first CPU of it several times).
>
> During boot the overhead is lower on this machine (SKL-X), during
> runtime it's way higher and more noisy.
>
> The noise can be pretty much eliminated by running the sync_overhead
> measurement multiple times and building the average.
>
> The reason why it is higher is that after offlining the socket the CPU
> comes back up with a frequency of 700Mhz while during boot it runs with
> 2100Mhz.
>
> Sync overhead: 118
> Sync overhead:  51 A: 22466 M: 22448 F: 2101683
One explanation of the sync overhead difference (118 vs 51) here is 
whether the lock cacheline is local or remote. My analysis the 
interaction between check_tsc_sync_source() and check_tsc_sync_target() 
is that real overhead is about locking with remote cacheline (local to 
source, remote to target). When you do a 256 loop of locking, it is all 
local cacheline. That is why the overhead is lower. It also depends on 
if the remote cacheline is in the same socket or a different socket.
>
> Sync overhead: 178
> Sync overhead: 152 A: 22477 M: 67380 F:  700529
>
> Sync overhead: 212
> Sync overhead: 152 A: 22475 M: 67380 F:  700467
>
> Sync overhead: 153
> Sync overhead: 152 A: 22497 M: 67452 F:  700404
>
> Can you try the patch below and check whether the overhead stabilizes
> accross several attempts on that copperlake machine and whether the
> frequency is always the same or varies?
Yes, I will try that experiment and report back the results.
>
> Independent of the outcome on that, I think have to take the actual CPU
> frequency into account for calculating the overhead.

Assuming that the clock frequency remains the same during the 
check_tsc_warp() loop and the sync overhead computation time, I don't 
think the actual clock frequency matters much. However, it will be a 
different matter if the frequency does change. In this case, it is more 
likely the frequency will go up than down. Right? IOW, we may 
underestimate the sync overhead in this case. I think it is better than 
overestimating it.

Cheers,
Longman

>
> Thanks,
>
>          tglx
> ---
> --- a/arch/x86/kernel/tsc_sync.c
> +++ b/arch/x86/kernel/tsc_sync.c
> @@ -446,7 +446,8 @@ void check_tsc_sync_target(void)
>   	unsigned int cpu = smp_processor_id();
>   	cycles_t cur_max_warp, gbl_max_warp;
>   	cycles_t start, sync_overhead;
> -	int cpus = 2;
> +	u64 ap1, ap2, mp1, mp2;
> +	int i, cpus = 2;
>   
>   	/* Also aborts if there is no TSC. */
>   	if (unsynchronized_tsc())
> @@ -514,6 +515,23 @@ void check_tsc_sync_target(void)
>   	arch_spin_lock(&sync.lock);
>   	arch_spin_unlock(&sync.lock);
>   	sync_overhead = rdtsc_ordered() - start;
> +	pr_info("Sync overhead: %lld\n", sync_overhead);
> +
> +	sync_overhead = 0;
> +	rdmsrl(MSR_IA32_APERF, ap1);
> +	rdmsrl(MSR_IA32_MPERF, mp1);
> +	for (i = 0; i < 256; i++) {
> +		start = rdtsc_ordered();
> +		arch_spin_lock(&sync.lock);
> +		arch_spin_unlock(&sync.lock);
> +		sync_overhead += rdtsc_ordered() - start;
> +	};
> +	rdmsrl(MSR_IA32_APERF, ap2);
> +	rdmsrl(MSR_IA32_MPERF, mp2);
> +	ap2 -= ap1;
> +	mp2 -= mp1;
> +	pr_info("Sync overhead: %lld A: %llu M: %llu F: %llu\n", sync_overhead >> 8,
> +		ap2, mp2, mp2 ? div64_u64((cpu_khz * ap2), mp2) : 0);
>   
>   	/*
>   	 * If the warp value of this CPU is 0, then the other CPU
>

