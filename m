Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3251E47C9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhLUX5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:57:05 -0500
Received: from mx1.riseup.net ([198.252.153.129]:35650 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhLUX5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:57:03 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4JJYKB4HYyzDs8x;
        Tue, 21 Dec 2021 15:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1640131022; bh=hPL9XrwxyAvqWoaPPeDQV6HVhQKo58lzzdfpX5klCQU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h5/3v+j4rshd3xdJQHc3yfuNjHZuKapY8tzcCWA8lt7aklYBKNrCAw39xV5eZXwyt
         X4n6WYk0YomoNiNpwjJFRIAhhr8wrVRqBer2GJ/36/cmGT3u/aJBZklNmNMG3a6gBI
         /U7NZ6C3q0NZj2e/6Ys3n1VsraJh3TLcNX/z9F5c=
X-Riseup-User-ID: E390E7649A9FC2C022021D4D55EA595B565F50E20EC628618F78C2257AC81052
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4JJYK96T29z5vkM;
        Tue, 21 Dec 2021 15:57:01 -0800 (PST)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
In-Reply-To: <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien>
 <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien>
 <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien>
 <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien>
 <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien>
 <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
Date:   Tue, 21 Dec 2021 15:56:51 -0800
Message-ID: <878rwdse9o.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Sun, Dec 19, 2021 at 11:10 PM Francisco Jerez <currojerez@riseup.net> wrote:
>>
>> Julia Lawall <julia.lawall@inria.fr> writes:
>>
>> > On Sat, 18 Dec 2021, Francisco Jerez wrote:
>
> [cut]
>
>> > I did some experiements with forcing different frequencies.  I haven't
>> > finished processing the results, but I notice that as the frequency goes
>> > up, the utilization (specifically the value of
>> > map_util_perf(sg_cpu->util) at the point of the call to
>> > cpufreq_driver_adjust_perf in sugov_update_single_perf) goes up as well.
>> > Is this expected?
>> >
>>
>> Actually, it *is* expected based on our previous hypothesis that these
>> workloads are largely latency-bound: In cases where a given burst of CPU
>> work is not parallelizable with any other tasks the thread needs to
>> complete subsequently, its overall runtime will decrease monotonically
>> with increasing frequency, therefore the number of instructions executed
>> per unit of time will increase monotonically with increasing frequency,
>> and with it its frequency-invariant utilization.
>
> But shouldn't these two effects cancel each other if the
> frequency-invariance mechanism works well?

No, they won't cancel each other out under our hypothesis that these
workloads are largely latency-bound, since the performance of the
application will increase steadily with increasing frequency, and with
it the amount of computational resources it utilizes per unit of time on
the average, and therefore its frequency-invariant utilization as well.

If you're not convinced by my argument, consider a simple latency-bound
application that repeatedly blocks for t0 on some external agent and
then requires the execution of n1 CPU clocks which cannot be
parallelized with any of the operations occurring during that t0 idle
time.  The runtime of a single cycle of that application will be,
assuming that the CPU frequency is f:

T = t0 + n1/f

Its frequency-invariant utilization will approach on the average:

u = (T-t0) / T * f / f1 = n1/f / (t0 + n1/f) * f / f1 = (n1 / f1) / (t0 + n1/f)

with f1 a constant with units of frequency.  As you can see the
denominator of the last expression above decreases with frequency,
therefore the frequency-invariant utilization increases, as expected for
an application whose performance is increasing.
