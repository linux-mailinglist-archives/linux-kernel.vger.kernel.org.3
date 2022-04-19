Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42B507969
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355078AbiDSSwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbiDSSwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:52:14 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC33286FB;
        Tue, 19 Apr 2022 11:49:30 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id f17so32676759ybj.10;
        Tue, 19 Apr 2022 11:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhjpBBfz4E8wq4JHV+jYI7JBT0oR89J1H0yd8J1mbNk=;
        b=fSA3fFdyoiwJbd5JM6bnAoa2ctke4ulhwV+uOzEGUfs1EQMpb1zt50F5qZYpfuFS2v
         2fE4I8X0G7NQDfwxaixDsl4gCZv+NZKBTvo9zspcjw9B8j2mjRDqmFvcMBwt2h/7RJ8y
         msI+X3YVLF9BwGP+v78ITUArohg/O0rlHdZYq59vr8zUmEr9sXtiSVO/671kX78Iqwlb
         YtydrmyIbRdOYUKxLZ9xuUwdNwetLTwwJTpopKB98O2mf50mJBir0jd3b67Gz7H/sNfw
         hkbJ6CKL9yNdaP1S6FBL4nO+otnIwyVdvQTG/9LfLt+JCRYOX85i3sFu/tzQQJ2wIt3O
         qQBg==
X-Gm-Message-State: AOAM533ePYxHeCA/N6mGr4CPdVGgZ1d4bbe3xH4Fk/O8RUp5HKViiy2T
        0f4iPsiPdvA6WE73A45JVtYhcrU5nDv8IULy9zhFCXnTLwA=
X-Google-Smtp-Source: ABdhPJz9MuGNDNBtVQddnxVFldziLq9pVeODLTyCCt1OFqXGy3Aq+THnhbrP2OQbo9i/a5pkqkJI4j+LEg2+YU6rOXU=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr16202111ybj.137.1650394170180; Tue, 19
 Apr 2022 11:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <005001d85413$75e5dce0$61b196a0$@telus.net>
In-Reply-To: <005001d85413$75e5dce0$61b196a0$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 20:49:19 +0200
Message-ID: <CAJZ5v0jf-NGa4-xaNaxehkLGPVqwhZrUhLXw2cJ1avtjgT5yPA@mail.gmail.com>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:32 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Thomas,
>
> On 2022.04.15 12:20 Thomas Gleixner wrote:
>
> > APERF/MPERF is utilized in two ways:
> >
> >  1) Ad hoc readout of CPU frequency which requires IPIs
> >
> >  2) Frequency scale calculation for frequency invariant scheduling which
> >     reads APERF/MPERF on every tick.
> >
> > These are completely independent code parts. Eric observed long latencies
> > when reading /proc/cpuinfo which reads out CPU frequency via #1 and
> > proposed to replace the per CPU single IPI with a broadcast IPI.
> >
> > While this makes the latency smaller, it is not necessary at all because #2
> > samples APERF/MPERF periodically, except on idle or isolated NOHZ full CPUs
> > which are excluded from IPI already.
> >
> > It could be argued that not all APERF/MPERF capable systems have the
> > required BIOS information to enable frequency invariance support, but in
> > practice most of them do. So the APERF/MPERF sampling can be made
> > unconditional and just the frequency scale calculation for the scheduler
> > excluded.
> >
> > The following series consolidates that.
>
> I have used this patch set with the acpi-cpufreq, intel_cpufreq (passive),
> and intel_pstate (active) CPU frequency scaling drivers and various
> governors. Additionally, with HWP both enabled and disabled.
>
> For intel_pstate (active), both HWP enabled or disabled, the behaviour
> of scaling_cur_freq is inconsistent with prior to this patch set and other
> scaling driver governor combinations.
>
> Note there is no issue with " grep MHz /proc/cpuinfo" for any
> combination.
>
> Examples:
>
> No-HWP:
>
> active/powersave:
> doug@s19:~/freq-scalers/trace$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:2300418
> /sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:0
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:2300006
> /sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:2300005
> /sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:0

That's because after the changes in this series scaling_cur_freq
returns 0 if the given CPU is idle.

I guess it could return the last known result, but that wouldn't be
more meaningful.
