Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF8510200
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352411AbiDZPjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346484AbiDZPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE969FD25
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650987371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8AmeN8RpBY4e3ayXE6Cdv4nV3vc/H97hfTWXfNO5Peg=;
        b=EeME7h8H+om1nNqU2FiwM2LUlejtE/GS2MfQYZSTdZHjmc10efznogUTBImcmnyaJIyWW8
        B/xW55y2px/0HtNRBfZ4Zq09RTSpeQRuFcz3X3guuUGO31gxi5v3buQI3eWlAsNPTJFE35
        Y0FtWIFdd7h1OKZgEeZAVbO8FmxoCxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-In9jslCTPza-1M1SukVc9g-1; Tue, 26 Apr 2022 11:36:09 -0400
X-MC-Unique: In9jslCTPza-1M1SukVc9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CF9280005D;
        Tue, 26 Apr 2022 15:36:08 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 235F654E895;
        Tue, 26 Apr 2022 15:36:08 +0000 (UTC)
Message-ID: <68837b1a-f85b-e842-f8c0-1cad162856f4@redhat.com>
Date:   Tue, 26 Apr 2022 11:36:07 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <87czh50xwf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 15:24, Thomas Gleixner wrote:
> On Mon, Apr 25 2022 at 09:20, Waiman Long wrote:
>> On 4/22/22 06:41, Thomas Gleixner wrote:
>>> I did some experiments and noticed that the boot time overhead is
>>> different from the overhead when doing the sync check after boot
>>> (offline a socket and on/offline the first CPU of it several times).
>>>
>>> During boot the overhead is lower on this machine (SKL-X), during
>>> runtime it's way higher and more noisy.
>>>
>>> The noise can be pretty much eliminated by running the sync_overhead
>>> measurement multiple times and building the average.
>>>
>>> The reason why it is higher is that after offlining the socket the CPU
>>> comes back up with a frequency of 700Mhz while during boot it runs with
>>> 2100Mhz.
>>>
>>> Sync overhead: 118
>>> Sync overhead:  51 A: 22466 M: 22448 F: 2101683
>> One explanation of the sync overhead difference (118 vs 51) here is
>> whether the lock cacheline is local or remote. My analysis the
>> interaction between check_tsc_sync_source() and check_tsc_sync_target()
>> is that real overhead is about locking with remote cacheline (local to
>> source, remote to target). When you do a 256 loop of locking, it is all
>> local cacheline. That is why the overhead is lower. It also depends on
>> if the remote cacheline is in the same socket or a different socket.
> Yes. It's clear that the initial sync overhead is due to the cache line
> being remote, but I rather underestimate the compensation. Aside of that
> it's not guaranteed that the cache line is actually remote on the first
> access. It's by chance, but not by design.

In check_tsc_warp(), the (unlikely(prev > now) check may only be 
triggered to record the possible wrap if last_tsc was previously written 
to by another cpu. That requires the transfer of lock cacheline from the 
remote cpu to local cpu as well. So sync overhead with remote cacheline 
is what really matters here. I had actually thought about just measuring 
local cacheline sync overhead so as to underestimate it and I am fine 
about doing it.

>>> Sync overhead: 178
>>> Sync overhead: 152 A: 22477 M: 67380 F:  700529
>>>
>>> Sync overhead: 212
>>> Sync overhead: 152 A: 22475 M: 67380 F:  700467
>>>
>>> Sync overhead: 153
>>> Sync overhead: 152 A: 22497 M: 67452 F:  700404
>>>
>>> Can you try the patch below and check whether the overhead stabilizes
>>> accross several attempts on that copperlake machine and whether the
>>> frequency is always the same or varies?
>> Yes, I will try that experiment and report back the results.
>>> Independent of the outcome on that, I think have to take the actual CPU
>>> frequency into account for calculating the overhead.
>> Assuming that the clock frequency remains the same during the
>> check_tsc_warp() loop and the sync overhead computation time, I don't
>> think the actual clock frequency matters much. However, it will be a
>> different matter if the frequency does change. In this case, it is more
>> likely the frequency will go up than down. Right? IOW, we may
>> underestimate the sync overhead in this case. I think it is better than
>> overestimating it.
> The question is not whether the clock frequency changes during the loop.
> The point is:
>
>      start = rdtsc();
>      do_stuff();
>      end = rdtsc();
>      compensation = end - start;
>      
> do_stuff() executes a constant number of instructions which are executed
> in a constant number of CPU clock cycles, let's say 100 for simplicity.
> TSC runs with 2000MHz.
>
> With a CPU frequency of 1000 MHz the real computation time is:
>
>     100/1000MHz = 100 nsec = 200 TSC cycles
>
> while with a CPU frequency of 2000MHz it is obviously:
>
>     100/2000MHz =  50 nsec = 100 TSC cyles
>
> IOW, TSC runs with a constant frequency independent of the actual CPU
> frequency, ergo the CPU frequency dependent execution time has an
> influence on the resulting compensation value, no?
>
> On the machine I tested on, it's a factor of 3 between the minimal and
> the maximal CPU frequency, which makes quite a difference, right?

Yes, I understand that. The measurement of sync_overhead is for 
estimating the delay (in TSC cycles) that the locking overhead 
introduces. With 1000MHz frequency, the delay in TSC cycle will be 
double that of a cpu running at 2000MHz. So you need more compensation 
in this case. That is why I said that as long as clock frequency doesn't 
change in the check_tsc_wrap() loop and the sync_overhead measurement 
part of the code, the actual cpu frequency does not matter here.

However about we half the measure sync_overhead as compensation to avoid 
over-estimation, but probably increase the chance that we need a second 
adjustment of TSC wrap.

Cheers,
Longman

