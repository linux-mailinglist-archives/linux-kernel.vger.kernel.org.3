Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8247D3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbhLVOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:55:02 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37485 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbhLVOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:55:01 -0500
Received: by mail-qk1-f182.google.com with SMTP id m186so2519770qkb.4;
        Wed, 22 Dec 2021 06:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nzVW9fS8lVq4A7s+LleLBNZjpuppm4Z5+9u/hx4F4M=;
        b=kwSnQ44f1ozuIEFYOUypgo9Pe+mqqQ1Uo8TJ/cQ0WrsNJZuBmiwphTpMy/Z67K7Ww0
         Pgtx+eUYiBsX2+GhJSdjyFkrEzq6907AWm+IeQCbqlB1rtWw/K8JlFqKRb7dtyXKEATN
         2WwuQp8mmfNoIXnPD2Eul7X94KAxc+0yHL5GUq0PBbp9t5dFsy1G0vIS11xJ7MzXCCFL
         dHKsxUmlo+jBg8S5yhwdxhPaYJVC2Kjr42Jiz9qUrPnZR2SK59KUe9781q9eq5etxrKb
         5N0eQvFqUTOijb7QVxNt/+awdof6JlWVUbeg86oMq8rnyI2E2uX2jGqtLcyT6SspKxCx
         MbLA==
X-Gm-Message-State: AOAM532cf2h+JFH23yf84eoTuPZLKqMcSEST8IIjfgfnGCgLskQis+2k
        PMVdAeyWBEgDLNoqGzfCEz+bgBZn0xZ8mmJhTGk=
X-Google-Smtp-Source: ABdhPJxu4y5AWPkYpGQLKns+2Ooj7oRBJ8xa5ngpaxS0tHENl0qV83deqMOYvle2DP4D8tywrxLcdWrtsuYu8Gz4wLM=
X-Received: by 2002:a05:620a:706:: with SMTP id 6mr2223347qkc.374.1640184900377;
 Wed, 22 Dec 2021 06:55:00 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien> <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com> <878rwdse9o.fsf@riseup.net>
In-Reply-To: <878rwdse9o.fsf@riseup.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Dec 2021 15:54:48 +0100
Message-ID: <CAJZ5v0jyusD4r1eK_hv8CXuaoOXZ6gY8TVdomW5q75dS3wNq5A@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Francisco Jerez <currojerez@riseup.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:57 AM Francisco Jerez <currojerez@riseup.net> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Sun, Dec 19, 2021 at 11:10 PM Francisco Jerez <currojerez@riseup.net> wrote:
> >>
> >> Julia Lawall <julia.lawall@inria.fr> writes:
> >>
> >> > On Sat, 18 Dec 2021, Francisco Jerez wrote:
> >
> > [cut]
> >
> >> > I did some experiements with forcing different frequencies.  I haven't
> >> > finished processing the results, but I notice that as the frequency goes
> >> > up, the utilization (specifically the value of
> >> > map_util_perf(sg_cpu->util) at the point of the call to
> >> > cpufreq_driver_adjust_perf in sugov_update_single_perf) goes up as well.
> >> > Is this expected?
> >> >
> >>
> >> Actually, it *is* expected based on our previous hypothesis that these
> >> workloads are largely latency-bound: In cases where a given burst of CPU
> >> work is not parallelizable with any other tasks the thread needs to
> >> complete subsequently, its overall runtime will decrease monotonically
> >> with increasing frequency, therefore the number of instructions executed
> >> per unit of time will increase monotonically with increasing frequency,
> >> and with it its frequency-invariant utilization.
> >
> > But shouldn't these two effects cancel each other if the
> > frequency-invariance mechanism works well?
>
> No, they won't cancel each other out under our hypothesis that these
> workloads are largely latency-bound, since the performance of the
> application will increase steadily with increasing frequency, and with
> it the amount of computational resources it utilizes per unit of time on
> the average, and therefore its frequency-invariant utilization as well.

OK, so this is a workload in which the maximum performance is only
achieved at the maximum available frequency.  IOW, there's no
performance saturation point and increasing the frequency (if
possible) will always cause more work to be done per unit of time.

For this type of workloads, requirements regarding performance (for
example, upper bound on the expected time of computations) need to be
known in order to determine the "most suitable" frequency to run them
and I agree that schedutil doesn't help much in that respect.

It is probably better to run them with intel_pstate in the active mode
(ie. "pure HWP") or decrease EPP via sysfs to allow HWP to ramp up
turbo more aggressively.
