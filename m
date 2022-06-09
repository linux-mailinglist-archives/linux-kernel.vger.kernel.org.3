Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01610544E4F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242695AbiFIOBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243902AbiFIOA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:00:56 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB0F17B852
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:00:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r1so13330370ybd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqhwYhya53Ub6ysqItH4y8unqJO0QhApIrC1/649j54=;
        b=fGOxnn0AqIvYwnlMzEqVt2e8++kIdmsh79Hl2DvxieLeED7eK+Cc6fsvF3UcIM7nvV
         U6qYnDICRLaiJkcwGKsasTPP4dcUwp7ITGHcGUdzJbJ8XAdlN+CfDvbYsEEYdhNCguKp
         qrmjHuQfrNYXGZI7AQQUGhB5jI3Ohh6mOo6mNsG6wFsuSMNQsColJNkAh9OU2W0FTQu9
         97lskwpM1QSWrTR6eivnxWbhCLpJWZiObbiCq9FVCyouTtaF/acGBdX0fS3Vud/WQuAj
         W7TsxsE+YptpX2ec1uuqVrpEk7dxtnqbEDCuGXPJTv/VSfFSwn5pcF4M2++C0viTCSTA
         xSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqhwYhya53Ub6ysqItH4y8unqJO0QhApIrC1/649j54=;
        b=ZBmyWFkPpSx5EmYr7ppSNUHTRvkl37yd47wwwohycSfFmZvhOuac2XlhJMSQgPbQ9y
         gzt9BTE7SGckDDQ0LabPXn9iNJGrJZ42JdMqqLAeD1h0V4FPmDLKOlm4/XT6dqklLYr9
         Q2JOTOe0QV0QiMSTlGDZErufd9ApIW0ZkYtF8gtpVQ32CgIhRPEoWH6PwSEmQ977iddE
         daM8oL41SAr8XTIlN6elKuO/ZSVHKWsF4RFVCUWik0zi0f4VpdMhwzQBigeVcyYrxuTU
         r0ZSp953LVN1G1Pmqy70jwSuVfTcoPcy8Ed926NqizPEFS2Ckp3PeDB2npdXbDeHN7Fd
         TcSQ==
X-Gm-Message-State: AOAM533/hHDihcIcCC3PXeIKXdS4MQo9kYA2fgfNT3/wD91GGarGdaik
        GZG+HMaXScxna8wcOXSF8u5L3In250Iux2uNtVOlRA==
X-Google-Smtp-Source: ABdhPJzTt5jB8Al00H/AKfb9WPbMyvnzrSMN+GZ+fLZlVKzwpmwSjeqTtUGB58clLqpL/2r6TUP1/Fvy9ZWcKb1JHso=
X-Received: by 2002:a25:780b:0:b0:664:3e22:3368 with SMTP id
 t11-20020a25780b000000b006643e223368mr2020008ybc.625.1654783254347; Thu, 09
 Jun 2022 07:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-6-elver@google.com>
 <CACT4Y+Zd0Zd_66DZ-f2HG4tR6ZdraFe9b4iEBJmG9p72+7RMWQ@mail.gmail.com> <CACT4Y+appPi5YAdKFB-2caO6xkg89FmV1_4532u7Jx_5CAX9xw@mail.gmail.com>
In-Reply-To: <CACT4Y+appPi5YAdKFB-2caO6xkg89FmV1_4532u7Jx_5CAX9xw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 16:00:16 +0200
Message-ID: <CANpmjNP7pUYY7T1pCOVCJ_WaomdeuQzcLin46VVtyEmT4pQ4iA@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Thu, 9 Jun 2022 at 15:41, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 14:04, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> > >
> > > Flexible breakpoints have never been implemented, with
> > > bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
> > > bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
> > > flexible count in fetch_bp_busy_slots().
> > >
> > > This again causes suboptimal code generation, when we always know that
> > > `!!slots.flexible` will be 0.
> > >
> > > Just get rid of the flexible "placeholder" and remove all real code
> > > related to it. Make a note in the comment related to the constraints
> > > algorithm but don't remove them from the algorithm, so that if in future
> > > flexible breakpoints need supporting, it should be trivial to revive
> > > them (along with reverting this change).
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Was added in 2009.
> >
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > > ---
> > >  kernel/events/hw_breakpoint.c | 12 +++---------
> > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > > index 5f40c8dfa042..afe0a6007e96 100644
> > > --- a/kernel/events/hw_breakpoint.c
> > > +++ b/kernel/events/hw_breakpoint.c
> > > @@ -46,8 +46,6 @@ struct bp_cpuinfo {
> > >  #else
> > >         unsigned int    *tsk_pinned;
> > >  #endif
> > > -       /* Number of non-pinned cpu/task breakpoints in a cpu */
> > > -       unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
> > >  };
> > >
> > >  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> > > @@ -71,7 +69,6 @@ static bool constraints_initialized __ro_after_init;
> > >  /* Gather the number of total pinned and un-pinned bp in a cpuset */
> > >  struct bp_busy_slots {
>
> Do we also want to remove this struct altogether? Now it becomes just
> an int counter.

Yes, that actually can simplify a bunch of things, including
fetch_bp_busy_slots() just returning an int and fetch_this_slot() can
be removed (it'll be even cleaner if we remove the overridable
weight).

I'll simplify unless I hear objections.
