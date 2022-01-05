Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A58484BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiAEAio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:38:44 -0500
Received: from mx1.riseup.net ([198.252.153.129]:43244 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236357AbiAEAio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:38:44 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4JT9Zq3YwVzDyXD;
        Tue,  4 Jan 2022 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1641343123; bh=DDkKGAY1Dh/tVjBGIUbPo7PZ6K4eU0YUwEB1vCmFKNY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oGCyEJfJ/XLqkrhpr/e4UkJ03IFSO6hgnUaStI1gjbltc+2KdD5pLqfD30laAva9b
         63SrfAIr007vcVhsKmlI/iVo39+fBUP5Eya4NYfAMCnxJfrRCnWNZai3c0BMBivBkv
         h+XMMSYcrCFEMKa83KiqrIJqi9RqTZeiRMu3WD/s=
X-Riseup-User-ID: 4745BA22B1F566D4939DA54541CECD38D2D66252716D913E671AF2D6A2BFC8F3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4JT9Zp5DKBz5vcG;
        Tue,  4 Jan 2022 16:38:42 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Julia Lawall <julia.lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <878rwdse9o.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
 <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien>
 <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
 <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301919240.15550@hadrien>
 <CAJZ5v0haa5QWvTUUg+wwSHvuWyk8pic1N0kox=E1ZKNrHSFuzw@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301942360.15550@hadrien>
 <CAJZ5v0im+Cke7tcNRav2VCyf5Qvi7qC29aF+9A1kVZZmt7cu6g@mail.gmail.com>
 <alpine.DEB.2.22.394.2201031922110.3020@hadrien>
 <CAJZ5v0hsCjKA3EisK9s_S8Vb9Tgm4eps1FTKvUSfd9_JPh5wBQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2201032110590.3020@hadrien>
Date:   Tue, 04 Jan 2022 16:38:22 -0800
Message-ID: <87h7ajqao1.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <julia.lawall@inria.fr> writes:

> On Mon, 3 Jan 2022, Rafael J. Wysocki wrote:
>
>> On Mon, Jan 3, 2022 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>> >
>> > > > > Can you please run the 32 spinning threads workload (ie. on one
>> > > > > package) and with P-state locked to 10 and then to 20 under turbostat
>> > > > > and send me the turbostat output for both runs?
>> > > >
>> > > > Attached.
>> > > >
>> > > > Pstate 10: spin_minmax_10_dahu-9_5.15.0freq_schedutil_11.turbo
>> > > > Pstate 20: spin_minmax_20_dahu-9_5.15.0freq_schedutil_11.turbo
>> > >
>> > > Well, in  both cases there is only 1 CPU running and it is running at
>> > > 1 GHz (ie. P-state 10) all the time as far as I can say.
>> >
>> > It looks better now.  I included 1 core (core 0) for pstates 10, 20, and
>> > 21, and 32 cores (socket 0) for the same pstates.
>>
>> OK, so let's first consider the runs where 32 cores (entire socket 0)
>> are doing the work.
>>
>> This set of data clearly shows that running the busy cores at 1 GHz
>> takes less energy than running them at 2 GHz (the ratio of these
>> numbers is roughly 2/3 if I got that right).  This means that P-state
>> 10 is more energy efficient than P-state 20, as expected.

Uhm, that's not what I'm seeing Rafael.

>
> Here all the threads always spin for 10 seconds.  But if they had a fixed
> amount of work to do, they should finish twice as fast at pstate 20.
> Currently, we have 708J at pstate 10 and 905J at pstate 20, but if we can
> divide the time at pstate 20 by 2, we should be around 450J, which is much
> less than 708J.
>

I agree with Julia on this: According to the last turbostat logs
attached to this thread, CPU package #0 consumes 618 J for 32 threads
spinning at 2GHz for 10s, and 421 J for the same number of threads
spinning at 1GHz for roughly the same time, therefore at P-state 10 we
observe an energy efficiency (based on Rafael's own definition of energy
efficiency elsewhere in this thread) of 1GHz*10s/421J = 24 Mclocks/J,
while at P-state 20 we observe an energy efficiency of 2GHz*10s/618J =
32 Mclocks/J, so P-state 20 is clearly the most energy-efficient in
Julia's setup, even if we only consider one of the CPU packages in her
system (considering the effect of the second CPU package would further
bias the result in favor of P-state 20).

Since her latest experiment is utilizing all 16 cores of the package
close to 100% of the time, I think this rules out our earlier theory of
this being the result of broken idle management, two alternative
explanations I can think of:

 - Voltage scaling isn't functioning as expected, your CPU's reported
   maximum efficiency ratio may be calculated based on the assumption
   that your CPU would be running at a lower voltage around P-state 10,
   which for some reason isn't the case in your system.

 - MSR_PLATFORM_INFO is misreporting the maximum efficiency ratio as
   suggested earlier.

> turbostat -J sleep 5 shows 105J, so we're still ahead.
>
> I haven't yet tried the actual experiment of spinning for 5 seconds and
> then sleeping for 5 seconds, though.
>
>>
>> However, the cost of running at 2.1 GHz is much greater than the cost
>> of running at 2 GHz and I'm still thinking that this is attributable
>> to some kind of voltage increase between P-state 20 and P-state 21
>> (which, interestingly enough, affects the second "idle" socket too).
>>
>> In the other set of data, where only 1 CPU is doing the work, P-state
>> 10 is still more energy-efficient than P-state 20,
>
> Actually, this doesn't seem to be the case.  It's surely due to the
> approximation of the result, but the consumption is slightly lower for
> pstate 20.  With more runs it probably averages out to around the same.
>

Yeah, I agree that the data seems to confirm P-state 20 being truly more
efficient than P-state 10, whether 1 or 16 cores are in use.

> julia
>
>> but it takes more
>> time to do the work at 1 GHz, so the energy lost due to leakage
>> increases too and it is "leaked" by all of the CPUs in the package
>> (including the idle ones in core C-states), so overall this loss
>> offsets the gain from using a more energy-efficient P-state.  At the
>> same time, socket 1 can spend more time in PC2 when the busy CPU is
>> running at 2 GHz (which means less leakage in that socket), so with 1
>> CPU doing the work the total cost of running at 2 GHz is slightly
>> smaller than the total cost of running at 1 GHz.  [Note how important
>> it is to take the other CPUs in the system into account in this case,
>> because there are simply enough of them to affect one-CPU measurements
>> in a significant way.]
>>
>> Still, when going from 2 GHz to 2.1 GHz, the voltage jump causes the
>> energy to increase significantly again.
>>
