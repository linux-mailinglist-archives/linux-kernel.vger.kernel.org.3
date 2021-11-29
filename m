Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E654625E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhK2Woc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbhK2Wn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E9C09B13F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:08:10 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x6so23338725iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+jIHWKDUtLPLAejvY1XbR8dU+L1MB4rcmxtV1IeEuY=;
        b=V+yKPYdvuj696Ta6zyYOcn+f0c0BzWekcMpmdQ69GctwJOqQHUDdzEwbqwwQN8mWqV
         S8rPb/cwHQnRPIy7t6i0o/dYsFziFrNytuvfuqdVjl11c352gWEmm3/gv9K1FNmNZ5X8
         sw2bpVXe1Z4WbLz4WfJnetW5KF7al4dDyao89BcxTUduZhoVJJ7i0M4RSlYs1eDfwhF/
         pJkfc3cCq3Jt+RHb6ZSG4CJTo9dYP1kyNak2Ur7OkvmVhVtEn/0bKFrh3NuNveTMtG1i
         rzoHTnjPlqw4wPLgr2LO8Lf8Hi0+uibZSNHFe3yp1HbiQ0loEKxOzRrOU/l4kvsL8vFj
         3akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+jIHWKDUtLPLAejvY1XbR8dU+L1MB4rcmxtV1IeEuY=;
        b=rsL/KEw+2lq7bRhmp+ntnioya8LKOe6DVYrU1WNtLC8hQPaslfPcA/8n3e+H/IMnap
         zEvzw5HVpUoKr9merHkWDJLuBk/5LaNsqMRP88RFcWdJRAkx4kbfajf6LjYOAxQ3sv3C
         70trUfQvI8qoSW5kR1G605EreMQRNPUsL2vxpKUJgII8xoJ/F6K6SqW9qVqJVOcH5ceA
         4cfkHEVDUuuoKmg1CafqGRoS0WBIYz9soR6lkDH6MRi3YoYNjuDUJdmtTtB9cZxM1onO
         V4a0ADc7FfIlO17ogXPuU9f8gBUidbtK83hubqRkeD/D3YsrIA19i22bAkx4TbbVtF/1
         xtPg==
X-Gm-Message-State: AOAM532WKkkE761idVvE7dzAmL81TqJLonxFP9A3Zly6ZNItRhqKDMHL
        R0Dyj3O4jMHRZ6zzv0XGEW1pYdLL4gbUS1+liz5s/A==
X-Google-Smtp-Source: ABdhPJwL/34AIU3jTwVbWsXe7uJGE4ODaX5MKmuUAfV1ENY1b+/qVIq81GEvQFt0u3k8b09bSBXrryXy1nRtdyOT8E8=
X-Received: by 2002:a05:6638:1311:: with SMTP id r17mr68875045jad.69.1638223689760;
 Mon, 29 Nov 2021 14:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com> <20211111084415.663951-4-eranian@google.com>
 <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net> <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
 <20211116082923.GX174703@worktop.programming.kicks-ass.net>
 <CABPqkBQ4BCswvNPpkO79dBamhudikz1cGCXFpwAp9xsTb3F8xQ@mail.gmail.com>
 <YZZE+bPCokVrTARM@hirez.programming.kicks-ass.net> <YZZH+5odIawPQtgJ@hirez.programming.kicks-ass.net>
In-Reply-To: <YZZH+5odIawPQtgJ@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 29 Nov 2021 14:07:58 -0800
Message-ID: <CABPqkBSLHS82MM9f9jcLNfYDAR7+j4h2ztm22wjMH11=FM8FcA@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Back from a vacation break. Comments below.

On Thu, Nov 18, 2021 at 4:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 18, 2021 at 01:20:09PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 16, 2021 at 11:23:39PM -0800, Stephane Eranian wrote:
>
> > > Ok, I made the changes you suggested. It looks closer to the way LBR is handled.
> > > However, this means that there is no path by which you can get to
> > > amd_pmu_disable_event()
> > > without having gone through amd_pmu_disable_all(). Is that always the
> > > case? And same thing
> > > on the enable side.
> >
> > So that's true for ->add() and ->del(), those cannot be called without
> > being wrapped in ->pmu_disable(), ->pmu_enable().
> >
> > There is however the ->stop() and ->start() usage for throttling, which
> > can stop an individual event (while leaving the event scheduled on the
> > PMU). Now, I think the ->stop() gets called with the PMU enabled, but
> > the ->start() is with it disabled again.
>
> I just looked, and the throttling depends on the PMU's PMI handler
> implementation, for Intel it will have the PMU disabled, for generic and
> AMD it has it enabled (see x86_pmu_handle_irq -- also these are really
> NMIs but lets not do a mass rename just now).
>
Yes, I see that too. It has to do with the __perf_event_overflow()
-> __perf_event_account_interrupt() code path which does not call
perf_pmu_disable().
And that's because it knows it is called from PMI and let's the PMI
code decide the state
of the PMU. Unfortunately, on AMD, the PMU is not stopped fully on PMI
and that is because
there is no centralized way of doing this, so you'd have 6 wrmsr x 2
to disable/enable. OTOH,
I don't see the point of monitoring in the PMI code. So there is a
discrepancy between Intel and
AMD here. I think we should fix it.

> > The ramification would be that we'd stop the event, but leave BRS
> > enabled for a throttled event. Which should be harmless, no?

Well, the risk here is that if BRS is left enabled, it may hold the
NMI for up to 16 taken branches.
If the associated event is disabled, then cpuc->events[idx] = NULL.
The BRS drain function checks
for that and does not capture any sample. The brs_drain() function is
called from the PMI handler if
cpuc->lbr_users > 0 which would be the case on the stop() path. I
think this is the only risk we have
on the throttling code path.

There would be no problem if we were to stop/start the PMU in the AMD
PMI handler.

Thanks.
