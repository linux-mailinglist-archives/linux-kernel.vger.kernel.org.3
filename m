Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413D52010A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiEIPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbiEIPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:25:14 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BB02EA33
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:21:17 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id v59so25528092ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zaAWdxVu5Fr71J2oZSU+b4Ome9y73tKH9DImdDWYsZc=;
        b=QL8bYHc1QXipF7t604OSiMfXWCJdpszpMUKKwHj9vf9flAqj8W0fJezQjeM6cDI6At
         nx648FAs0LSB6TP/uA/davKQeJEEeCnZ0HUoVuEjEms904mGN7T0jEC1pqoxsDZK9xH9
         BYGlHSFZ1b0lZeHNbWtgkviCqEB4UVfm+KZsihBLWqwGBibmm8e/sT+UtwAJnYk7s+aN
         3Mh+B0pDINmHd8ewKqkof03ZMeZHXo1zHueUBkpaRTZ7qcW9XKTl5lk4hLYtc3IhRagN
         uunAG/NLeqTkc57V28oMMHJwy7IQLxoJz/L4sl+mfQUE+dge1dDL3umnFMsjWcm73vOf
         RVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaAWdxVu5Fr71J2oZSU+b4Ome9y73tKH9DImdDWYsZc=;
        b=fXVkRXKKPmvWwdIO23G/Y/KXn47VHJrN1pYDiZxpsIUlvfEVZD1n4EYVprSc7fQY8q
         lv3TreIl7eNyPE3no/igp6zqewFXUTom3x5+lFP4+SYubm7L6koQGkxsovRiwkOgna3w
         WrM+GcbzKg1lcM8QLYJ7QWckTMeBcffVhdN52vUe2kMQdHapxdQRaduUDSEmPtCMfUbA
         iAGKCkjaZD5R+pjszWT4Ifxs4C0TPt7skLeQA8RB60PzBE0DQxX4RDlBzfMkDitj4RZa
         xtQ6pVBdMS5yFb8Zn5Kp2SIIAUUBzO1W0kOwY0G1Q9+IGrbyHRsZOUcC7Tq50SpmApwE
         YnpQ==
X-Gm-Message-State: AOAM532NY//TngVB+7SDo2RHVJC0WqOC+ATsyqcwMr9GlyJkzwbuZwvJ
        +r/0sFcgYp/wREzFhKEosPuhfzj+D6QRLpLvUQLb/VoR56U=
X-Google-Smtp-Source: ABdhPJx1nixHCqOOmwrmHPUaeMv+NrJ/xLapCTRx+/IdOzOwCi14y4gjZvHBQy7TxaB+P0797R2yso2rz2xkR8hHuI0=
X-Received: by 2002:a25:bcc7:0:b0:648:d728:d39 with SMTP id
 l7-20020a25bcc7000000b00648d7280d39mr14257952ybm.514.1652109676974; Mon, 09
 May 2022 08:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <CADjb_WTRYjSD8z0BCE=u322iJmQVuEq5cUMTZO6ij9V-=ViY-w@mail.gmail.com> <53fcde27-7dd2-5150-633b-4e2acc37bb6f@bytedance.com>
In-Reply-To: <53fcde27-7dd2-5150-633b-4e2acc37bb6f@bytedance.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Mon, 9 May 2022 23:21:05 +0800
Message-ID: <CADjb_WRmXh0tj7nZZR3QybhLxtoxZBy6OMKRNygtKOx-wUPxZA@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 1:50 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Chen,
>
> On 5/8/22 12:09 AM, Chen Yu Wrote:
[cut]
> >> @@ -81,8 +81,20 @@ struct sched_domain_shared {
> >>          atomic_t        ref;
> >>          atomic_t        nr_busy_cpus;
> >>          int             has_idle_cores;
> >> +
> >> +       /*
> >> +        * Tracking of the overloaded cpus can be heavy, so start
> >> +        * a new cacheline to avoid false sharing.
> >> +        */
> > Although we put the following items into different cache line compared to
> > above ones, is it possible that there is still cache false sharing if
> > CPU1 is reading nr_overloaded_cpus while
> > CPU2 is updating overloaded_cpus?
>
> I think it's not false sharing, it's just cache contention. But yes,
> it is still possible if the two items mixed with others (by compiler)
> in one cacheline, which seems out of our control..
>
My understanding is that, since nr_overloaded_cpus starts with a new
cache line,  overloaded_cpus is very likely to be in the same cache line.
Only If the write to nr_overloaded_cpus mask is not frequent(maybe tick based
update is not frequent), the read of nr_overloaded_cpus can survive from cache
false sharing, which is mainly read by SIS.  I have a stupid thought
that if nr_overloaded_cpus
mask and nr_overloaded_cpus could be put to 2 cache lines.
> >> +       atomic_t        nr_overloaded_cpus ____cacheline_aligned;
> > ____cacheline_aligned seems to put nr_overloaded_cpus into data section, which
> > seems to be unnecessary. Would ____cacheline_internodealigned_in_smp
> > be more lightweight?
>
> I didn't see the difference of the two macros, it would be appreciate
> if you can shed some light.
>
Sorry I mistook  ____cacheline_aligned for __cacheline_aligned which is
put into a data section. Please ignore my previous comment.
> >> +       unsigned long   overloaded_cpus[]; /* Must be last */
> >>   };
> >>
[cut]
> >> +       /*
> >> +        * It's unlikely to find an idle cpu if the system is under
> >> +        * heavy pressure, so skip searching to save a few cycles
> >> +        * and relieve cache traffic.
> >> +        */
> >> +       if (weight - nro < (nr >> 4) && !has_idle_core)
> >> +               return -1;
> > In [1] we used util_avg to check if the domain is overloaded and quit
> > earlier, since util_avg would be
> > more stable and contains historic data. But I think nr_running in your
> > patch could be used as
> > complementary metric and added to update_idle_cpu_scan() in [1] IMO.
> >> +
> >>          cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >> +       if (nro > 1)
> >> +               cpumask_andnot(cpus, cpus, sdo_mask(sds));
> > If I understand correctly, this is the core of the optimization: SIS
> > filters out the busy cores. I wonder if it
> > is possible to save historic h_nr_running/idle_h_nr_running and use
> > the average value? (like the calculation
> > of avg_scan_cost).
>
> Yes, I have been already working on that for several days, and
> along with some improvement on load balance (group_has_spare).
> Ideally we can finally get rid out of the cache issues.
>
Ok, could you please also Cc me in the next version? I'd like to have
a try.

-- 
Thanks,
Chenyu
