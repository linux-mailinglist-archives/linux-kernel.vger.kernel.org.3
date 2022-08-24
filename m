Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48DF5A0250
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiHXTwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiHXTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:52:43 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46FD7A535
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:52:42 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id w129so9172163vkg.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5v6zgADbMr24n8fV0jwjZRV/AkJnuUZcb43PNpXVT3w=;
        b=dSRug86uywNlsUblWhHTLy9YgfNRuWxXFfMOEsk9nbMifb9nKh5sfeCYXmEm/q8SDv
         Dio6NBEgWWMx8+D21U58VKh8xsdghr2P0t5sZWoBQ/prFHJxcedRGAfIT71f60mrO+d2
         wti4qAvFXJBNfFicNiRZSaMmUVuEiwpXJroilKYarJ6a5EoT9UU+M6sAyXFGPvfoOvZq
         2kyh9gD8Sl66P+gPqn4qw5UAZkA2rA+xtkDGKyoKbnTscIeAOf4G9W5+adhuUan0STHx
         R9cO0yWG+p3Js0A4rGGbxBYUkITP9BkuRdKFpsOrjbHIzeb+MD2GmIUjQH5exrJbwaU1
         93oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5v6zgADbMr24n8fV0jwjZRV/AkJnuUZcb43PNpXVT3w=;
        b=rNYhS38xfkT6kVo3wH05Viaf/QnCzv8H738kqTVMJg178JYynedsYDXX1Qa4RhVY9B
         RGB6APSLOhPWanndGHDtMaKfrirGt+utj71pPfA9HnMPqlkdYSF7dlZBhIWEtaPhRWvz
         r63UVZV6mPKFIMo0gwzy+Aeuh+5YamY08mrs91zpUzfwMyTXOKYbuLTmwtWnwTjFyhOc
         dWVp/kUdIjtbRFdq7w1GOzu1Q3rPI+czX0oHsxqov/ObU2sld1WFEgxuGnlESzMkU4AY
         XL/craYW0N0OT+0lVEheOp30mvE/uZiXTzwJZHAt3gMbRKUbhmemH4TnTVOL/hmu4kw1
         rdig==
X-Gm-Message-State: ACgBeo2tOS9jOq32/Ix6k/auJ11RiXogVtJvl0fhQ4noC/DUWmEwZ3BE
        l3EK82onYAE9u/vAvTgHMZm7zSoM40bf8U9zli6gdQ==
X-Google-Smtp-Source: AA6agR65MLTaZlz6aqEpkUxFTPibgUpyIADDkVz2g/yS8YLx3bU/sSScUSZKO1klJB8gKqSD7UfKc2Aspnnq6TNCYFU=
X-Received: by 2002:a1f:1c06:0:b0:387:e3a:5d35 with SMTP id
 c6-20020a1f1c06000000b003870e3a5d35mr244070vkc.8.1661370761924; Wed, 24 Aug
 2022 12:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
 <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com> <YwXvGe4/QdgGYOKJ@worktop.programming.kicks-ass.net>
 <3afbcd46-0b29-605d-66d0-7f8b6b22332a@linux.intel.com>
In-Reply-To: <3afbcd46-0b29-605d-66d0-7f8b6b22332a@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 24 Aug 2022 12:52:29 -0700
Message-ID: <CABPqkBSQNR2ipokyepa0J=0sTyBmEmzx0reNTMEMMR6x7RDdQg@mail.gmail.com>
Subject: Re: [BUG] perf/x86/intel/pebs: PEBS timestamps overwritten
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com
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

On Wed, Aug 24, 2022 at 12:14 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-08-24 5:27 a.m., Peter Zijlstra wrote:
> >
> > Should be 3 patches at the very least I think, the first one introducing
> > the new field and then follow up patches making use of it.
> >
> > And yes as Ravi mentions there's the CALLCHAIN_EARLY hack that could be
> > cleaned up as well, making it 4 or something.
> >
> > On Fri, Aug 05, 2022 at 09:36:37AM -0400, Liang, Kan wrote:
> >
> >> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> >> index 34be3bc5151a..a2c26eaeb0d9 100644
> >> --- a/arch/x86/events/intel/ds.c
> >> +++ b/arch/x86/events/intel/ds.c
> >> @@ -1687,8 +1687,10 @@ static void setup_pebs_fixed_sample_data(struct
> >> perf_event *event,
> >>       * We can only do this for the default trace clock.
> >>       */
> >>      if (x86_pmu.intel_cap.pebs_format >= 3 &&
> >> -            event->attr.use_clockid == 0)
> >> +            event->attr.use_clockid == 0) {
> >
> > Indent fail; please add: 'set cino=(0:0' to your .vimrc or figure out
> > the equivalent for your editor of choice.
> >
> >>              data->time = native_sched_clock_from_tsc(pebs->tsc);
> >> +            data->flags |= PERF_SAMPLE_DATA_TIME;
> >> +    }
> >>
> >>      if (has_branch_stack(event))
> >>              data->br_stack = &cpuc->lbr_stack;
> >
> >> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >> index da759560eec5..33054bf31fc1 100644
> >> --- a/include/linux/perf_event.h
> >> +++ b/include/linux/perf_event.h
> >> @@ -999,6 +999,7 @@ int perf_event_read_local(struct perf_event *event,
> >> u64 *value,
> >>  extern u64 perf_event_read_value(struct perf_event *event,
> >>                               u64 *enabled, u64 *running);
> >>
> >> +#define PERF_SAMPLE_DATA_TIME               0x1
> >>
> >>  struct perf_sample_data {
> >>      /*
> >> @@ -1012,6 +1013,7 @@ struct perf_sample_data {
> >>      union perf_sample_weight        weight;
> >>      u64                             txn;
> >>      union  perf_mem_data_src        data_src;
> >> +    u64                             flags;
> >>
> >>      /*
> >>       * The other fields, optionally {set,used} by
> >
> > How about we call that 'sample_flags' instead and use PERF_SAMPLE_* as
> > we already have, something like so:
>
> True, I think we can use PERF_SAMPLE_* and avoid adding more flags.
>
> I will implement some patches based on the suggestion.
>
I agree with the approach as well. We reuse the PERF_SAMPLE. That
means it automatically
adjusts as we add more PERF_SAMPLE*.

> Thanks,
> Kan
>
> >
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index ee8b9ecdc03b..b0ebbb1377b9 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1007,6 +1007,7 @@ struct perf_sample_data {
> >        * Fields set by perf_sample_data_init(), group so as to
> >        * minimize the cachelines touched.
> >        */
> > +     u64                             sample_flags;
> >       u64                             addr;
> >       struct perf_raw_record          *raw;
> >       struct perf_branch_stack        *br_stack;
> > @@ -1056,6 +1057,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
> >                                        u64 addr, u64 period)
> >  {
> >       /* remaining struct members initialized in perf_prepare_sample() */
> > +     data->sample_flags = 0;
> >       data->addr = addr;
> >       data->raw  = NULL;
> >       data->br_stack = NULL;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 2621fd24ad26..fed447f59024 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6792,15 +6792,21 @@ static void perf_aux_sample_output(struct perf_event *event,
> >       ring_buffer_put(rb);
> >  }
> >
> > -static void __perf_event_header__init_id(struct perf_event_header *header,
> > -                                      struct perf_sample_data *data,
> > -                                      struct perf_event *event)
> > +static u64 __perf_event_header__init_id(struct perf_event_header *header,
> > +                                     struct perf_sample_data *data,
> > +                                     struct perf_event *event)
> >  {
> >       u64 sample_type = event->attr.sample_type;
> >
> >       data->type = sample_type;
> >       header->size += event->id_header_size;
> >
> > +     /*
> > +      * Clear the sample flags that have already been done by the
> > +      * PMU driver.
> > +      */
> > +     sample_type &= ~data->sample_flags;
> > +
> >       if (sample_type & PERF_SAMPLE_TID) {
> >               /* namespace issues */
> >               data->tid_entry.pid = perf_event_pid(event, current);
> > @@ -6820,6 +6826,8 @@ static void __perf_event_header__init_id(struct perf_event_header *header,
> >               data->cpu_entry.cpu      = raw_smp_processor_id();
> >               data->cpu_entry.reserved = 0;
> >       }
> > +
> > +     return sample_type;
> >  }
> >
> >  void perf_event_header__init_id(struct perf_event_header *header,
> > @@ -7302,7 +7310,7 @@ void perf_prepare_sample(struct perf_event_header *header,
> >                        struct perf_event *event,
> >                        struct pt_regs *regs)
> >  {
> > -     u64 sample_type = event->attr.sample_type;
> > +     u64 sample_type;
> >
> >       header->type = PERF_RECORD_SAMPLE;
> >       header->size = sizeof(*header) + event->header_size;
> > @@ -7310,7 +7318,7 @@ void perf_prepare_sample(struct perf_event_header *header,
> >       header->misc = 0;
> >       header->misc |= perf_misc_flags(regs);
> >
> > -     __perf_event_header__init_id(header, data, event);
> > +     sample_type = __perf_event_header__init_id(header, data, event);
> >
> >       if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
> >               data->ip = perf_instruction_pointer(regs);
