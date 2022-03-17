Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24E4DCCBB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiCQRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiCQRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:47:01 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082713508D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:45:42 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id b190so6304577vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJC749JOe7I90/lVVKBYlNIBirJ/7ws7bUfBK1kajWI=;
        b=hGbq++vNY0ATZznXCcjcwbOkcmjRxxpZhmOMfpPm/yRx5FqZI111fTotlpSyn/CdcO
         7l3ElPlXHH6BwDZo+8mU81mlv2jbKGK7CIxI5lwZdD7AcxOm8p/GkmYSVeDGBvihYGeb
         Kb0XvywsC/ZchoHy2d++5wnmfNs3wCzH44+n+WFkMo5kDd7mMVBxKckPCEMaozDsGlfM
         JbDQQNjP5aWWYYzfz1/qTr3SuIQE4tDcJazloYZ2bP/2nPRzquTnR8Q1lU/5EpS0LL+H
         OVZcmmsOpFy+mU7DFTGEUuPwuA5qnZS2KA+uvQHb0YvCsAaGDS7pC4bwsQh2/U2hUtp3
         0GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJC749JOe7I90/lVVKBYlNIBirJ/7ws7bUfBK1kajWI=;
        b=JWuf7Vc6F8tyLqstfmlOxaa/cEBez1cHEXbdti0vWuYXIX86OxuYuXOGmGCqcckGML
         Ta9oWzNfjzbmeX84vdsyeEyvcUEADtORzwDb8a3omd2Xt5VQjL0ezHlvzoksDZalKlX1
         bMpeBfpUBN1IHm8berKpL27Q7m2MI3XJDp07eTVCnPWavBwZMOWUNE4Fgbw5oU/DL3zQ
         stbNACnn5ymBDNGWpw1gGALjfTBgcHm5x6DnmIzehy0JGQXLV6Y4yeOBfPUufO8aN5RF
         /LQnG1cCPfSB5gm7rciIMpTMgXb5F5CEIbgq7+mRY5Q4d+CIrm8RwFMutt5FcI4R+6nB
         lD/g==
X-Gm-Message-State: AOAM533CvLqefMfD1af7L46IXOml6N8J0wAA0IapKAIGtyv8pXrFLqyZ
        eo/XpPyYwpcs9LEMq7fXDhDBlkdOHMUQjieRTfYqRs9DtIc=
X-Google-Smtp-Source: ABdhPJy4Y4fW3GgejnniiHiQi1beP4dgdMsSUpFZ8WdwH+pwRYjgt6pxjlWkk8Ul9/U9XaWNC/0bmB8JQ3ERCaA3OyA=
X-Received: by 2002:a67:c09b:0:b0:322:9ac9:4b2e with SMTP id
 x27-20020a67c09b000000b003229ac94b2emr2643795vsi.11.1647539141809; Thu, 17
 Mar 2022 10:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647498015.git.sandipan.das@amd.com> <7d43b4ba8a7c3c0833495f3fabfcfc6df8db3732.1647498015.git.sandipan.das@amd.com>
 <YjMjNvrGa7ZK/x3H@hirez.programming.kicks-ass.net>
In-Reply-To: <YjMjNvrGa7ZK/x3H@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 17 Mar 2022 10:45:30 -0700
Message-ID: <CABPqkBTPkUtkAyh7+_51L83UA=AUjoU_KQqRVKyd7hLhapqHZg@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf/x86/amd/core: Add PerfMonV2 overflow handling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sandipan Das <Sandipan.Das@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        pbonzini@redhat.com, jmattson@google.com, like.xu.linux@gmail.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 5:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Mar 17, 2022 at 11:58:35AM +0530, Sandipan Das wrote:
>
> > +static inline u64 amd_pmu_get_global_overflow(void)
> > +{
> > +     u64 status;
> > +
> > +     /* PerfCntrGlobalStatus is read-only */
> > +     rdmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, status);
> > +
> > +     return status & amd_pmu_global_cntr_mask;
> > +}
> > +
> > +static inline void amd_pmu_ack_global_overflow(u64 status)
> > +{
> > +     /*
> > +      * PerfCntrGlobalStatus is read-only but an overflow acknowledgment
> > +      * mechanism exists; writing 1 to a bit in PerfCntrGlobalStatusClr
> > +      * clears the same bit in PerfCntrGlobalStatus
> > +      */
> > +
> > +     /* Only allow modifications to PerfCntrGlobalStatus.PerfCntrOvfl */
> > +     status &= amd_pmu_global_cntr_mask;
> > +     wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, status);
> > +}
> > +
> > +static bool amd_pmu_legacy_has_overflow(int idx)
> > +{
> > +     u64 counter;
> > +
> > +     rdmsrl(x86_pmu_event_addr(idx), counter);
> > +
> > +     return !(counter & BIT_ULL(x86_pmu.cntval_bits - 1));
> > +}
> > +
> > +static bool amd_pmu_global_has_overflow(int idx)
> > +{
> > +     return amd_pmu_get_global_overflow() & BIT_ULL(idx);
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pmu_has_overflow, amd_pmu_legacy_has_overflow);
> > +
> >  /*
> >   * When a PMC counter overflows, an NMI is used to process the event and
> >   * reset the counter. NMI latency can result in the counter being updated
> > @@ -613,7 +653,6 @@ static inline void amd_pmu_set_global_ctl(u64 ctl)
> >  static void amd_pmu_wait_on_overflow(int idx)
> >  {
> >       unsigned int i;
> > -     u64 counter;
> >
> >       /*
> >        * Wait for the counter to be reset if it has overflowed. This loop
> > @@ -621,8 +660,7 @@ static void amd_pmu_wait_on_overflow(int idx)
> >        * forever...
> >        */
> >       for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
> > -             rdmsrl(x86_pmu_event_addr(idx), counter);
> > -             if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
> > +             if (!static_call(amd_pmu_has_overflow)(idx))
> >                       break;
> >
> >               /* Might be in IRQ context, so can't sleep */
>
> This scares me... please tell me you fixed that mess.
>
> > @@ -718,6 +756,83 @@ static void amd_pmu_enable_event(struct perf_event *event)
> >       static_call(amd_pmu_enable_event)(event);
> >  }
> >
> > +static int amd_pmu_global_handle_irq(struct pt_regs *regs)
> > +{
> > +     struct perf_sample_data data;
> > +     struct cpu_hw_events *cpuc;
> > +     struct hw_perf_event *hwc;
> > +     struct perf_event *event;
> > +     u64 val, status, mask;
> > +     int handled = 0, idx;
> > +
> > +     status = amd_pmu_get_global_overflow();
> > +
> > +     /* Check if any overflows are pending */
> > +     if (!status)
> > +             return 0;
> > +
> > +     /* Stop counting */
> > +     amd_pmu_global_disable_all();
>
>
> This seems weird to me, I'd first disable it, then read status. MSR
> access is expensive, you want to shut down the PMU asap.
>
> Also, this is written like PMI would not be the primary NMI source,
> which seems somewhat unlikely.
>
> > +
> > +     cpuc = this_cpu_ptr(&cpu_hw_events);
> > +
> > +     /*
> > +      * Some chipsets need to unmask the LVTPC in a particular spot
> > +      * inside the nmi handler.  As a result, the unmasking was
> > +      * pushed into all the nmi handlers.
> > +      *
> > +      * This generic handler doesn't seem to have any issues where
> > +      * the unmasking occurs so it was left at the top.
> > +      *
> > +      * N.B. Taken from x86_pmu_handle_irq()
> > +      */
>
> Please write an AMD specific comment here. Note how 'recent' Intel chips
> ended up pushing this to the end of the handler. Verify with your
> hardware team where they want this and write as much of the rationale as
> you're allowed to share in the comment.
>
> > +     apic_write(APIC_LVTPC, APIC_DM_NMI);
> > +
> > +     for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> > +             if (!test_bit(idx, cpuc->active_mask))
> > +                     continue;
> > +
> > +             event = cpuc->events[idx];
> > +             hwc = &event->hw;
> > +             val = x86_perf_event_update(event);
> > +             mask = BIT_ULL(idx);
> > +
> > +             if (!(status & mask))
> > +                     continue;
> > +
> > +             /* Event overflow */
> > +             handled++;
> > +             perf_sample_data_init(&data, 0, hwc->last_period);
> > +
> > +             if (!x86_perf_event_set_period(event))
> > +                     continue;
> > +
> > +             if (perf_event_overflow(event, &data, regs))
> > +                     x86_pmu_stop(event, 0);
> > +
> > +             status &= ~mask;
> > +     }
> > +
> > +     /*
> > +      * It should never be the case that some overflows are not handled as
> > +      * the corresponding PMCs are expected to be inactive according to the
> > +      * active_mask
> > +      */
> > +     WARN_ON(status > 0);
> > +
> > +     /* Clear overflow bits */
> > +     amd_pmu_ack_global_overflow(~status);
> > +
> > +     inc_irq_stat(apic_perf_irqs);
> > +
> > +     /* Resume counting */
> > +     amd_pmu_global_enable_all(0);
>
> I think this is broken vs perf_pmu_{dis,en}able(), note how
> intel_pmu_handle_irq() saves/restores the enable state.
>
> > +
> > +     return handled;
> > +}
> > +
> > +DEFINE_STATIC_CALL(amd_pmu_handle_irq, x86_pmu_handle_irq);
> > +
> >  /*
> >   * Because of NMI latency, if multiple PMC counters are active or other sources
> >   * of NMIs are received, the perf NMI handler can handle one or more overflowed
> > @@ -741,7 +856,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
> >       int handled;
> >
> >       /* Process any counter overflows */
> > -     handled = x86_pmu_handle_irq(regs);
> > +     handled = static_call(amd_pmu_handle_irq)(regs);
> >
> >       /*
> >        * If a counter was handled, record a timestamp such that un-handled
> > @@ -1041,6 +1156,8 @@ static int __init amd_core_pmu_init(void)
> >               static_call_update(amd_pmu_enable_all, amd_pmu_global_enable_all);
> >               static_call_update(amd_pmu_disable_all, amd_pmu_global_disable_all);
> >               static_call_update(amd_pmu_enable_event, amd_pmu_global_enable_event);
> > +             static_call_update(amd_pmu_has_overflow, amd_pmu_global_has_overflow);
> > +             static_call_update(amd_pmu_handle_irq, amd_pmu_global_handle_irq);
> >       }
>
> Same, all this static_call() stuff is misguided.
>
> Also, if you feel like it, you can create amd_pmu_v2.

Given the number of overrides, that would also make more sense to me.
