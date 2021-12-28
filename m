Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D28480C59
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhL1SG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:06:57 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:34394 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhL1SG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:06:56 -0500
Received: by mail-qv1-f48.google.com with SMTP id ke6so17111323qvb.1;
        Tue, 28 Dec 2021 10:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IixkIj8VLjoN9oUoTOb8f3m78BDJTxJXp1D9ACSWpzs=;
        b=pw29L7U2hAa+2XXZnOv3ReADCOA9caem3YyaTu0mD54h7LvItcmPkwVtymjt6wPOUy
         g9+hD1UMIVv16rycp9tUrzYg1nevsGoJhIWuwqABLCZbXXXFv1W7LFuG3UzC3jBR0F4I
         46b+eEDt+DfArRRBRnnypIdrfSi2CaryWyG/2ouUvq5PUVxqQfwlhMh7VzYZcrTaUTDp
         P3uI7cexGAwfwH7K79nK41QYGtZNecIDZ6MFkuSjBXMyWXY8xYojp/Tiys40ULnz7iwC
         FsNPh9VmFytpVXGEgn4Zv+nUCDOR8UE7len7X6Eg8jheelrI5JmSNtisvmuY/HMKsM3q
         HuaQ==
X-Gm-Message-State: AOAM5309iPo6zG9r7pk6TlBthTR5xmtiby7mIY4GwrhjBVmhdKzXoL/9
        mD1aI9lHWyr34Grll5/K+4PObgiREITM/G+RLgw2pRxw
X-Google-Smtp-Source: ABdhPJxB8Rb0q509CdDhET7PyMcrffi1zi36bynVmn2FN/8+J1VoQ0yoleoR4l76GYzhYeyaFnF4b6Typ6WHPuEXfO0=
X-Received: by 2002:ad4:5c8b:: with SMTP id o11mr19643551qvh.130.1640714815640;
 Tue, 28 Dec 2021 10:06:55 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien> <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
 <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com> <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2112281845180.24929@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Dec 2021 19:06:44 +0100
Message-ID: <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Francisco Jerez <currojerez@riseup.net>,
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

On Tue, Dec 28, 2021 at 6:46 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 28 Dec 2021, Rafael J. Wysocki wrote:
>
> > On Tue, Dec 28, 2021 at 5:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > > I looked a bit more into why pstate 20 is always using the least energy. I
> > > have just one thread spinning for 10 seconds, I use a fixed value for the
> > > pstate, and I measure the energy usage with turbostat.
> >
> > How exactly do you fix the pstate?
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e7af18857371..19440b15454c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -400,7 +402,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
>                 sg_cpu->util = prev_util;
>
>         cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> -                                  map_util_perf(sg_cpu->util), sg_cpu->max);
> +                                  sysctl_sched_fixedfreq, sg_cpu->max);

This is just changing the "target" hint given to the processor which
may very well ignore it, though.

>
>         sg_cpu->sg_policy->last_freq_update_time = time;
>  }
>
> ------------------------------
>
> sysctl_sched_fixedfreq is a variable that I added to sysfs.

If I were trying to fix a pstate, I would set scaling_max_freq and
scaling_min_freq in sysfs for all CPUs to the same value.

That would cause intel_pstate to set HWP min and max to the same value
which should really cause the pstate to be fixed, at least outside the
turbo range of pstates.

> >
> > > I tried this on a
> > > 2-socket Intel 6130 and a 4-socket Intel 6130.  The experiment runs 40
> > > times.
> > >
> > > There seem to be only two levels of CPU energy usage.  On the 2-socket
> > > machine the energy usage is around 600J up to pstate 20 and around 1000J
> > > after that.  On the 4-socket machine it is twice that.
> >
> > These are the package power numbers from turbostat, aren't they?
>
> Yes.

OK
