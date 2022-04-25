Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E450E970
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbiDYT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDYT1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:27:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F211096F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:24:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650914657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMuVGZ7h1QoUJ4va6wNNmnpP17xgFPbWbZ/C8iuGD9U=;
        b=N1u8Vv9EVmywzK1EKtOUjXD/LhtlntOVbRRRbSTD5AO7P7CAX9wVOkgcB/kWaV71GUkRNg
        TusScbEOJT/5ktTEOytA07XO7k4wSj5q5qXdQwNNI5BGlD2uUG1igMrmCzuvrgifwl1LeW
        nbWVHXMUMKq+qbs1Wc2HCCAcgrXC2xHwuvYlpoM3r39HQKoNBl8LXFqdoCo4sQtjCvWxmW
        bjV/kTRqPAFjkcV765J4jXHwPPp0awlNxpPsqQB5wjllC1zDdD6zLmdrhkSaqVpAqQho0Y
        dFpbcbykqbqFV+8cyQvDmyGrL9vujnlO8WSQf2Cu3FdUX0VwWUEMB0mFSU8uXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650914657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tMuVGZ7h1QoUJ4va6wNNmnpP17xgFPbWbZ/C8iuGD9U=;
        b=xHBElZxnbSIEctA7njop2ZbL+MIieXeLiIQwhMElCryfRERlLvZq4k9tx51FTLRNZHqqJl
        KYCTYC2eGHHsQACA==
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>, Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc
 adjustment
In-Reply-To: <4f02fe46-b253-2809-0af7-f2e9da091fe9@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
 <20220314194630.1726542-3-longman@redhat.com> <87czhymql2.ffs@tglx>
 <d1a04785-4822-3a3f-5c37-81329a562364@redhat.com> <87levx8kou.ffs@tglx>
 <4f02fe46-b253-2809-0af7-f2e9da091fe9@redhat.com>
Date:   Mon, 25 Apr 2022 21:24:16 +0200
Message-ID: <87czh50xwf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25 2022 at 09:20, Waiman Long wrote:
> On 4/22/22 06:41, Thomas Gleixner wrote:
>> I did some experiments and noticed that the boot time overhead is
>> different from the overhead when doing the sync check after boot
>> (offline a socket and on/offline the first CPU of it several times).
>>
>> During boot the overhead is lower on this machine (SKL-X), during
>> runtime it's way higher and more noisy.
>>
>> The noise can be pretty much eliminated by running the sync_overhead
>> measurement multiple times and building the average.
>>
>> The reason why it is higher is that after offlining the socket the CPU
>> comes back up with a frequency of 700Mhz while during boot it runs with
>> 2100Mhz.
>>
>> Sync overhead: 118
>> Sync overhead:  51 A: 22466 M: 22448 F: 2101683
> One explanation of the sync overhead difference (118 vs 51) here is 
> whether the lock cacheline is local or remote. My analysis the 
> interaction between check_tsc_sync_source() and check_tsc_sync_target() 
> is that real overhead is about locking with remote cacheline (local to 
> source, remote to target). When you do a 256 loop of locking, it is all 
> local cacheline. That is why the overhead is lower. It also depends on 
> if the remote cacheline is in the same socket or a different socket.

Yes. It's clear that the initial sync overhead is due to the cache line
being remote, but I rather underestimate the compensation. Aside of that
it's not guaranteed that the cache line is actually remote on the first
access. It's by chance, but not by design.

>> Sync overhead: 178
>> Sync overhead: 152 A: 22477 M: 67380 F:  700529
>>
>> Sync overhead: 212
>> Sync overhead: 152 A: 22475 M: 67380 F:  700467
>>
>> Sync overhead: 153
>> Sync overhead: 152 A: 22497 M: 67452 F:  700404
>>
>> Can you try the patch below and check whether the overhead stabilizes
>> accross several attempts on that copperlake machine and whether the
>> frequency is always the same or varies?
> Yes, I will try that experiment and report back the results.
>>
>> Independent of the outcome on that, I think have to take the actual CPU
>> frequency into account for calculating the overhead.
>
> Assuming that the clock frequency remains the same during the 
> check_tsc_warp() loop and the sync overhead computation time, I don't 
> think the actual clock frequency matters much. However, it will be a 
> different matter if the frequency does change. In this case, it is more 
> likely the frequency will go up than down. Right? IOW, we may 
> underestimate the sync overhead in this case. I think it is better than 
> overestimating it.

The question is not whether the clock frequency changes during the loop.
The point is:

    start = rdtsc();
    do_stuff();
    end = rdtsc();
    compensation = end - start;
    
do_stuff() executes a constant number of instructions which are executed
in a constant number of CPU clock cycles, let's say 100 for simplicity.
TSC runs with 2000MHz.

With a CPU frequency of 1000 MHz the real computation time is:

   100/1000MHz = 100 nsec = 200 TSC cycles

while with a CPU frequency of 2000MHz it is obviously:

   100/2000MHz =  50 nsec = 100 TSC cyles

IOW, TSC runs with a constant frequency independent of the actual CPU
frequency, ergo the CPU frequency dependent execution time has an
influence on the resulting compensation value, no?

On the machine I tested on, it's a factor of 3 between the minimal and
the maximal CPU frequency, which makes quite a difference, right?

Thanks,

        tglx


