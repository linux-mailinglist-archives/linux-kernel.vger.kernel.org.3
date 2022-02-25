Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D394C4024
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiBYIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbiBYIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:30:27 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157E2399C4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:29:55 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id w27so8131917lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huECegT9lSfFlpWj2sPhekhQo9gmLtfEtcXYqnOdZog=;
        b=VPPvw6YeYfI2MB9UcdZZ0heL4JATmvyko8jZQmB3rYO9ym8kUkgajDJO7EfvLllXnX
         gEuMPlqq2X8YEirwshvnKnuFPA1X7e+Fy8t5zb3f7SAzs4RQGXWeP+AafBoD2Ti5yAXv
         BkZosOHP/Ekl+DDrfCwIQuA9RGLm1urKduLWzQdfFcDf+qKI7Zg3VFbdend+m2xn2Prp
         4fyOB0UWR9gy16wXVu19vruhsGGcQ138t3Xl1YSVuJAZFVxGLLD/aqfM3bksQN9z/L1k
         AxM6GniAmw1dWSfwg2zhWBCLPBt5sno10veDUguank3Y/SrLN58zeORhPa6jO42nAQ1j
         Om3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huECegT9lSfFlpWj2sPhekhQo9gmLtfEtcXYqnOdZog=;
        b=T+XL84IPzubvnrggIkEwfox55SWgB7eZdvl3nKMAJXCwnkGxbquVD0NhAujv8TcKbv
         AVZltzkhZK8PuevEE6/B5NdYAAcJmsVQZoK0qSWuxQWTiSkMUbOGhs+ICWFcX20wWO9x
         eq1O46TKOmlOoIdG1rWXEKIbvzFZqHsRXF8Bmz/DNJ7nXnfClUtj5+gRsS5i1L4zuHB5
         fNnDXy5k/3dUhYp5zSVGK6oyozJZyBG16Fa4ddZtB9v9U/OJkH1NbBOlP1XB2T6DaYY7
         2Q8yOfvgfi3vp/a2eNK//MUIHhjz+1KvLs6uhkyp1H3oNt+oulR7/oN3dchNmfH1MWey
         TURg==
X-Gm-Message-State: AOAM533BkUqx1BVCLQoA9uQuV25PM2WpvXw4lZnha0OWkwxf4P8HtORs
        P1CgwxutPXsDbZK5lflxBk/bPwoemqVTPGJWuwYATg==
X-Google-Smtp-Source: ABdhPJwpHrijgaHoGPXBcAdjmamGn9/YOkJzeG5+BqiI7tHQDnq2SP0B1ah1jpVdApkLMfDWo8Jl45+1hyHGhLvLu1Y=
X-Received: by 2002:ac2:5cc8:0:b0:443:770f:a7 with SMTP id f8-20020ac25cc8000000b00443770f00a7mr4170300lfq.18.1645777793719;
 Fri, 25 Feb 2022 00:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <YheiT2pGNDggdFSu@hirez.programming.kicks-ass.net> <9fe00f72-4e2e-38ff-d64a-4ae41e683316@bytedance.com>
In-Reply-To: <9fe00f72-4e2e-38ff-d64a-4ae41e683316@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 25 Feb 2022 09:29:41 +0100
Message-ID: <CAKfTPtD7U7=C8MTLLMtUrGxJFCjpxtU7a_S=HaBhCsZ6SBbVFA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 at 07:46, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Peter,
>
> On 2/24/22 11:20 PM, Peter Zijlstra Wrote:
> > On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
> >> Current load balancing is mainly based on cpu capacity
> >> and task util, which makes sense in the POV of overall
> >> throughput. While there still might be some improvement
> >> can be done by reducing number of overloaded cfs rqs if
> >> sched-idle or idle rq exists.
> >
> > I'm much confused, there is an explicit new-idle balancer and a periodic
> > idle balancer already there.
>
> The two balancers are triggered on the rqs that have no tasks on them,
> and load_balance() seems don't show a preference for non-idle tasks so

The load balance will happen at the idle pace if a sched_idle task is
running on the cpu so you will have an ILB on each cpu that run a
sched-idle task

> there might be possibility that only idle tasks are pulled during load
> balance while overloaded rqs (rq->cfs.h_nr_running > 1) exist. As a

There is a LB_MIN feature (disable by default) that filters task with
very low load ( < 16) which includes sched-idle task which has a max
load of 3

> result the normal tasks, mostly latency-critical ones in our case, on
> that overloaded rq still suffer waiting for each other. I observed this
> through perf sched.
>
> IOW the main difference from the POV of load_balance() between the
> latency-critical tasks and the idle ones is load.
>
> The sched-idle balancer is triggered on the sched-idle rqs periodically
> and the newly-idle ones. It does a 'fast' pull of non-idle tasks from
> the overloaded rqs to the sched-idle/idle ones to let the non-idle tasks
> make full use of cpu resources.
>
> The sched-idle balancer only focuses on non-idle tasks' performance, so
> it can introduce overall load imbalance, and that's why I put it before
> load_balance().

According to the very low weight of a sched-idle task, I don't expect
much imbalance because of sched-idle tasks. But this also depends of
the number of sched-idle task.


>
> Best Regards,
>         Abel
