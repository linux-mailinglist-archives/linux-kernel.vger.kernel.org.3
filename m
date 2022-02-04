Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD054A9B86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355195AbiBDO5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBDO5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:57:07 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193EC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:57:06 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v190so3289761ybv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SwumegfjcMitZ0X6YmiKd4footM3jVcdRJ4mMFkS/fo=;
        b=FeSXlIchl3LMLRNfp6XpPBmVxCVn0cWAFIk76DLWuKOvXKUS2+6hHbcgUx4/GB7zxH
         EjE9TiduTNkDTPRhv5Y+T6YWWg1f9rdj7cbThPdTL05obG+buR5cD6WnKEeskv3Q+2JB
         VEli8A7Z0wD3AU5KHrQWY8gLaIgZ/JeAvTjGId+PJj6smLgqzHAFDOwz2QoY234Pv+h8
         sJ2xQRExKQarAGj5LOG/MojCxfTh+n7hcepeB6A1h/AM0LbXqkdOMvjXypYHEzr95S3s
         j0DsFD4FGaLaIqsUFuuTlct5Bdy721euWkO8uNgep9hG9qC3W0wu62//qtYNKe/303Lb
         HNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SwumegfjcMitZ0X6YmiKd4footM3jVcdRJ4mMFkS/fo=;
        b=qtBktVrdOdAMJy3vI36ItoR5/9A3nyoQk7GT/rZMbbyvKEaMK5odmwLAUpunPHFX83
         pVl3hY23tyB/bEdo2KnOR1xF2XN4j611VDqAb1CygXXbTvInZEwIF0oGJD5sDqNf0wkM
         39uC7LkdXIS4Na/hzhJK2YRjipHSJN5uFjfSZOxziUWF5rQCI5I2mi7TV4E8tE6fQY4T
         baYrrVH/cNK5w2vxEBabtxw81PWYJGP1D5ciJrnswvEfGjLZPBkiKRqF8vrhndY8hp7K
         aTUZL4kCWa3Np/s8ZfPVnDowy07dt4x8Lvg7nYUtDAs9cDeI4GbMDCAOL+3XwU34Kd+P
         LJgQ==
X-Gm-Message-State: AOAM533EPKzp3DjeCzmBsp49GuThPLqPNSYYAiGOVLaKI/SPf54Ct6xE
        QNwasvWnm1xaETm+1eMfYq4TY8xpPShug3NdLQ9NUA==
X-Google-Smtp-Source: ABdhPJx0wlgvm3LhvjuHzsZsTbue3KBcLwFrjNrYsuS7hrDIcoqZ1Kg9WQsut6pe6ysBOXbwWB6/jw5FTDPSoyHsbV0=
X-Received: by 2002:a25:d4c7:: with SMTP id m190mr3092852ybf.375.1643986625183;
 Fri, 04 Feb 2022 06:57:05 -0800 (PST)
MIME-Version: 1.0
References: <20220204073940.1258263-1-eranian@google.com> <Yf0Sk5dT4HXviI+M@FVFF77S0Q05N>
In-Reply-To: <Yf0Sk5dT4HXviI+M@FVFF77S0Q05N>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 4 Feb 2022 06:56:53 -0800
Message-ID: <CABPqkBQ9ObFv+gc8Oo5OTuSMduj_jqYqPt98Uks_gGTYtmRg2Q@mail.gmail.com>
Subject: Re: [PATCH] perf/arm64: fix mapping for HW_BRANCH_INSTRUCTIONS on PMUv3
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, ashoks@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 3:48 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Stephane,
>
> On Thu, Feb 03, 2022 at 11:39:40PM -0800, Stephane Eranian wrote:
> > With the existing code, the following command:
> >
> > $ perf stat -e branches sleep 0
> >  Performance counter stats for 'sleep 0':
> >    <not supported>      branches
> >
> > on N1 core (pmuv3).
>
> This is definitely not ideal. :(
>
> > This is due to the fact that the mapping for the generic event is wrong.
>
> I don't think that's quite true; more detail below. This is certainly *messy*
> though.
>
> > It is using ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED which is not implemented
> > on N1 (and most likely on any PMUv3 implementations). However, there is
> > another supported event ARMV8_PMUV3_PERFCTR_BR_RETIRED measuring the same
> > condition.
>
> I have a couple of concerns here:
>
> 1) Both PC_WRITE_RETIRED and BR_RETIRED are OPTIONAL (though the Arm strongly
>    recommends that BR_RETIRED is implemented), so CPUs may exist which only
>    support one of the two, or both.
>
That was my fear here.

>    So as-is, this patch may break working support for CPUs which have
>    PC_WRITE_RETIRED but not BR_RETIRED.
>
>    IIUC we should be able to detect whether either are implemented by looking
>    at PMCEID, and we could take that into account when mapping the event.
>
> 2) IIUC (even with ARMv8.6) there is a potential semantic difference between
>    PC_WRITE_RETIRED and BR_RETIRED, in that e.g. PC_WRITE_RETIRED must include
>    exception returns while this is IMPLEMENTATION DEFINED for BR_RETIRED.
>
>    I guess this might not matter all that much given the precise definition of
>    "Software change of the PC" is IMPLEMENTATION DEFINED, but I don't think
>    it's true that the two events count "the same condition", and we should be
>    more explicit about that.
>
It also depends on the Linux definition for "branches" which I have never seen.
So all we can do is look at the x86 variants and check on the
exception return case.
I will do that.

> > This patch switches the mapping to ARMV8_PMUV3_PERFCTR_BR_RETIRED so that
> > the perf stat command above works.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index cab678ed6618..ec2b98343a0b 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -45,7 +45,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
> >       [PERF_COUNT_HW_INSTRUCTIONS]            = ARMV8_PMUV3_PERFCTR_INST_RETIRED,
> >       [PERF_COUNT_HW_CACHE_REFERENCES]        = ARMV8_PMUV3_PERFCTR_L1D_CACHE,
> >       [PERF_COUNT_HW_CACHE_MISSES]            = ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
> > -     [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
> > +     [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = ARMV8_PMUV3_PERFCTR_BR_RETIRED,
>
> As above, I don't think we can unconditionally make this change, and instead
> should have the mapping function take PMCEID into account to map the event (or
> bail out if we don't know a suitable event is implemented).
>
The PMCEID does contains what's implemented and that it why the event
disappears on some implementation.
So instead we could use it to adjust the mapping. Let me try to do
that instead at least for this event given there is
a choice of mapping. And yes, if neither of these exist then the event
does not exist.

There is always the possibility to use an actual event code and that
bypasses the PMCEID check.


> Thanks,
> Mark.
>
> >       [PERF_COUNT_HW_BRANCH_MISSES]           = ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
> >       [PERF_COUNT_HW_BUS_CYCLES]              = ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
> >       [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
> > --
> > 2.35.0.263.gb82422642f-goog
> >
