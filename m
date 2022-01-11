Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4A48BB88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiAKXig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbiAKXic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:38:32 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A3C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:38:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e198so1503210ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95SGhqOm0RccSxJd03GJ+P09jT1muY8YMjYut8pvtqA=;
        b=oh8SsVjgy0iZTdFo6YzyNVUqT1q/qdQHbxYWVkHGO7CG64yrC1aFcOfJBL7xrSAlY+
         RVtvIjA/p2bWEp6apmi/M0sDnT83FLIUvq78MpV8sZy9vtQVY5tqeJrpJDEedtQvx9OZ
         MPw4nuikifUlivgQBD+7FjtvuZo7nc2CwEX8orNj2/Slu0GJ9e+69x01Jxsz2wlPaobq
         U/dF8X2zhedHCjjLSMl/qZhQ3HFa55fhGCf8qofKVe0BQLTWNijS9GIv/O/GHgBhOrHJ
         SgzyS93ujsrXUWxfD97cq7se0IRa35hwt980hfCuYJyr39pl1Jc8wlvTcVIIk5iE4kLR
         eGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95SGhqOm0RccSxJd03GJ+P09jT1muY8YMjYut8pvtqA=;
        b=DbbbiFxsIpbgAyNcS0PDgsk89WsURugqcuDS6EjUzaWS9DhWZrcBsZebJvE+6lK/Ld
         ii3G88CVpQIZnAdd00aY4Ohtv9D5tf0pStppmVgno4O2Eovqn69/9gVM/5ehw2bCDPO0
         8k4vAZ+sMuIvEevVzKsfROoH2PWERWOS/BUMZsR2sx4XGxYnkVp+XgVVBywCU5ypSNoP
         VswS1kGXihZR81F/3EKZUEQFF0l9tHHyeomtpAqEd7LaQ1EtjJAS+QlYbUbtmNliGL+V
         /vHs4Ng99x0pm091F9K+tYTHElXs93Czck0E3bnqd5+ZCj+JYNTAG78NQ48pXVpO8I6q
         wAvA==
X-Gm-Message-State: AOAM531efpJ5EgTh9drouZ18vfDSQDJZGfCAdk7gkLajv8L/fKNwMWIq
        tt1e4BNPz69l5V1SmEC73xgrQp+RrH/tAfHAvfveyA==
X-Google-Smtp-Source: ABdhPJymtneO7XZ322JsP6ScH1vz+nxafPzDb/8P3vFGru+YCwIQAx2X7BIG31eVsRLKMY8+ovsKJfxSCiVJ37kJwjg=
X-Received: by 2002:a25:fc27:: with SMTP id v39mr10217685ybd.9.1641944311344;
 Tue, 11 Jan 2022 15:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20220107234138.1765668-1-joshdon@google.com> <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
In-Reply-To: <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 11 Jan 2022 15:38:20 -0800
Message-ID: <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: add cpu.stat_percpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 4:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 07, 2022 at 03:41:37PM -0800, Josh Don wrote:
>
> > +     seq_puts(seq, "usage_usec");
> > +     for_each_possible_cpu(cpu) {
> > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > +             val = cached_bstat->cputime.sum_exec_runtime;
> > +             do_div(val, NSEC_PER_USEC);
> > +             seq_printf(seq, " %llu", val);
> > +     }
> > +     seq_puts(seq, "\n");
> > +
> > +     seq_puts(seq, "user_usec");
> > +     for_each_possible_cpu(cpu) {
> > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > +             val = cached_bstat->cputime.utime;
> > +             do_div(val, NSEC_PER_USEC);
> > +             seq_printf(seq, " %llu", val);
> > +     }
> > +     seq_puts(seq, "\n");
> > +
> > +     seq_puts(seq, "system_usec");
> > +     for_each_possible_cpu(cpu) {
> > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > +             val = cached_bstat->cputime.stime;
> > +             do_div(val, NSEC_PER_USEC);
> > +             seq_printf(seq, " %llu", val);
> > +     }
> > +     seq_puts(seq, "\n");
>
> This is an anti-pattern; given enough CPUs (easy) this will trivially
> overflow the 1 page seq buffer.
>
> People are already struggling to fix existing ABI, lets not make the
> problem worse.

Is the concern there just the extra overhead from making multiple
trips into this handler and re-allocating the buffer until it is large
enough to take all the output? In that case, we could pre-allocate
with a size of the right order of magnitude, similar to /proc/stat.

Lack of per-cpu stats is a gap between cgroup v1 and v2, for which v2
can easily support this interface given that it already tracks the
stats percpu internally. I opted to dump them all in a single file
here, to match the consolidation that occurred from cpuacct->cpu.stat.
