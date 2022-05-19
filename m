Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878C52DE15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiESUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbiESUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:07:04 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88766CF60
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:07:03 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o80so10931089ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52C20B+8gbwxQF6BDXyzLNS02ew4KrKkcGEKezw9U0A=;
        b=E2JTeUYz0n7HcjHBEhh/veveLtUx7MavE0E5iZ+1nCTPEszGGFlPKMRj3USgK1Ym2+
         5bVPjS3BhIprvzRl/9hU9NybMtR7ysEFb+9cb9t57NHwnH6fHyLtoK5owmzVvgnif8aj
         O7e8L9g74DbPySl2y8VIYZ6LPL54CWUJTd60OJxPOPOpYgw02sndw8ykc7HI92x2c2T+
         F+VCTS6z2VDXmsSW+s5V+iJiNaxNW2bnWAOsCMVdd6hx9lvre8axv1UR7fvBuSHizUmD
         NCIYxDTlCf4tOB1juDAsWI4R0w+iT4NKso3EyOv6RMHD3mC1N96FpHElBUUZMaQees+1
         LGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52C20B+8gbwxQF6BDXyzLNS02ew4KrKkcGEKezw9U0A=;
        b=OX5+usnuFCtGCWbRGYCHaew5VWLM3ZWDnOiacgx/OXRaSntVxd/0Q1R73nFJhxsQ4t
         aYz17nvsVE2sKIEfojSiaI0smOCVwcKthoWGaXqiLHRV/Pb94IknrzzdA7wzBt/XaLZV
         l+BQ1A4BbGzjiTeVxshTb/BQcS0WlU7OoUCi2er9ygaXFYGBJcHZ1A0k3oIjV2Fcz5Vy
         XZjPS3I+H14Q/H1YRYfuQL3ASnLGUNsFIAtJ8iZNbYeng+MNdQI4/XO480NVU0lx+qMa
         rpaXFQxFEshPFc3JTdGp6VrUMq7W0GzCYKBVE7rQM6D0VFL6v22feL0hGtCnczTkEKbd
         J0Dw==
X-Gm-Message-State: AOAM531A/2An4EhJiXPeVnXOTCEGJxLnSepqu/9kZq7HzvlMC8hU+vj1
        jD0rUQAvllLpIgP1iLuOCMtpQEirdcLQR6BT7AHxVA==
X-Google-Smtp-Source: ABdhPJwnYRyenpj4lpr2tGGC7fDmhdOu8sFy4Q/00KX1fXp0DUR7o5TcfEr7P+XCTGButNrZzQ+juX1rs4gt4s7EEhI=
X-Received: by 2002:a25:47c1:0:b0:64a:9f13:61c7 with SMTP id
 u184-20020a2547c1000000b0064a9f1361c7mr6455006yba.464.1652990822403; Thu, 19
 May 2022 13:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
 <20220512163534.2572-6-vincent.guittot@linaro.org> <CABk29Ns-3L1S2xuRg15VxzcXJyNpA6nB2A4jdM9eyx0jiWjn+Q@mail.gmail.com>
 <CAKfTPtCx_fhud-VsxCi9jS==yGavn7zgRBQyUfzXgbTiX2+77g@mail.gmail.com>
In-Reply-To: <CAKfTPtCx_fhud-VsxCi9jS==yGavn7zgRBQyUfzXgbTiX2+77g@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 19 May 2022 13:06:51 -0700
Message-ID: <CABk29NvF2H2oSAw806tUQjj39TWNa57bEcbA0ao+qyk5ZgV9Kg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] sched/fair: Take into account latency nice at wakeup
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
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

On Thu, May 19, 2022 at 6:57 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 17 May 2022 at 02:54, Josh Don <joshdon@google.com> wrote:
> >
> > Hi Vincent,
> >
> > On Thu, May 12, 2022 at 9:36 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Take into account the nice latency priority of a thread when deciding to
> > > preempt the current running thread. We don't want to provide more CPU
> > > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > > task first whenever possible.
> > >
> > > As long as a thread didn't use its bandwidth, it will be able to preempt
> > > the current thread.
> > >
> > > At the opposite, a thread with a low latency priority will preempt current
> > > thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> > > wait for the tick to get its sched slice.
> >
> > Following up from the discussion on the prior series, I'm still not
> > sure why this approach is exclusive of extending the entity placement
> > code; I think both changes together would be useful.
> >
> > By only changing the wakeup preemption decision, you're only
> > guaranteeing that the latency-sensitive thing on cpu won't be
> > preempted until the next sched tick, which can occur at any time
> > offset from the wakeup, from 0ns to the length of one tick. If a
>
> In fact, you are ensured to run a minimum time of 3ms at least on >=8
> cores system before tick can preempt you. I considered updating this
> part as well to increase the value for negative weight but didn't do
> it for now. I can have a look

If the latency sensitive thing on cpu has already been running close
to or greater than that min granularity, that doesn't apply; can still
get preempted pretty quickly from the tick by the newly woken task.

A possible change would be to reduce the sleeper credit when the
waking entity has lower latency priority than the current entity (ie.
similar to the se_is_idle() check already being made in
place_entity()).

> > latency-tolerant task wakes up with a lot of sleeper credit, it would
> > pretty quickly preempt a latency-sensitive task on-cpu, even if it
> > doesn't initially do so due to the above changes to wakeup preemption.
> >
> > Adjusting place_entity wouldn't impact cpu bandwidth in steady-state
> > competition between threads of different latency prio, it would only
> > impact slightly at wakeup, in a similar but more consistent manner to
> > the changes above to wakeup_preempt_entity (ie. a task that is not
> > latency sensitive might have to wait a few ticks to preempt a latency
> > sensitive task, even if it was recently sleeping for a while).
