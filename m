Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE8480C26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhL1Rka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:40:30 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:36840 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbhL1Rk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:40:29 -0500
Received: by mail-qt1-f180.google.com with SMTP id m18so16353622qtk.3;
        Tue, 28 Dec 2021 09:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpIt/KkHMu0SIyyjZZ5x+BvfMAgC7OjRkMa12P89ld8=;
        b=qp1kPfupa7omhhnDEbuRFynyLMv6lwcykNMdCoyYWg9qmlvKUdlVKB6Lml2jdr4U9Q
         bEyNkoaw+3cSmE9SxjRjpbgqjFc/4OFLqNhMS5k+LNT2s0CmfqnR/sRynBU7HkHbLGMJ
         OMkii17QL5YLE1tCPllCld69pVGYafl3dstAnOkH+cRXCDj4L9+7amUYZFbXVCo5SbWD
         dkk8jEtUNzrl0ONz8GbzNsu725mgLGTZVzHsWgnMVGhhndFYElqfgFTO3CeybmngAZ8r
         0YoVxaOCcYBKlRGwR9T5StqaNmD34zlQ4AAp8CWtkbcIjRmm23u2kM2eGMz3MCEHkJbD
         Fo3g==
X-Gm-Message-State: AOAM530A16j8Mub9IWLAKnd3GP/GEN4B5t6HhqjOCh0BHdJ1ZVvo5RQn
        y2ZTKNQBJClJSkUoVDmAHPV35Y9M+57LzYSXxGY=
X-Google-Smtp-Source: ABdhPJyBDJuUY5W2ozHeSK8MRo7+JgTMrpM7bGcNovNGkmrdsWqH0ZLKaFqxd6lLNlPHlWoLQPSP9WvbN01hzao6LJI=
X-Received: by 2002:ac8:5c91:: with SMTP id r17mr20179194qta.18.1640713228862;
 Tue, 28 Dec 2021 09:40:28 -0800 (PST)
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
In-Reply-To: <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Dec 2021 18:40:18 +0100
Message-ID: <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Francisco Jerez <currojerez@riseup.net>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 5:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> I looked a bit more into why pstate 20 is always using the least energy. I
> have just one thread spinning for 10 seconds, I use a fixed value for the
> pstate, and I measure the energy usage with turbostat.

How exactly do you fix the pstate?

> I tried this on a
> 2-socket Intel 6130 and a 4-socket Intel 6130.  The experiment runs 40
> times.
>
> There seem to be only two levels of CPU energy usage.  On the 2-socket
> machine the energy usage is around 600J up to pstate 20 and around 1000J
> after that.  On the 4-socket machine it is twice that.

These are the package power numbers from turbostat, aren't they?

> The change in RAM energy usage is similar, eg around 320J for the 2-socket
> machine up to pstate 20, and around 460J for higher pstates.
>
> On the 6130, pstate 21 is 2.1GHz, which is the nominal frequency of the
> machine.  So it seems that the most efficient thing is to be just below
> that.  The reduced execution time with pstate 20 as compared to pstate 10
> greatly outweighs any small increase in the energy usage due to changing
> the frequency.
>
> Perhaps there is something abnormal in how the machines are configured?
