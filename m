Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A352D519FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349822AbiEDMnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245654AbiEDMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:42:57 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AB32EE1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:39:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ebf4b91212so13584227b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIRWsrtQMQJmxVZKJdEApR7ea2YJQu7cRItS3a5Vwg8=;
        b=MFnT0W+63TtrQlSSrKtXilZLFxNUx+Q8TiJJDLulh1w4MPXUB1PfyUGT1MBQjNjkfX
         LAEPoEB0mVbyfibLfVHyWibxOscAvmfQV8HNzveVqeYDTkyccD7KMNyQekHZji1fdri8
         eD7HoNPPvyvHhfi6WFQDK5sQ5qHZR4tgwf8tzXOGDT0waevOpjgrdret/w2Jgr7QNNoU
         XRagWEYbr1G+084KAREQc/PP4tjaGutCbBoqcAwgiISS4dSCVSmbQ4TrcBjkj68N5FGh
         5dd5HVGI8DEXwTvw7WmhllOJyA0jAFOomQ+4GRbay/n1ATaVRgHWqUYUXDisHlIlCyg7
         ofIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIRWsrtQMQJmxVZKJdEApR7ea2YJQu7cRItS3a5Vwg8=;
        b=ej39eWqqOgjLKFl9l8hhqI3FbwERlMGABPQmKa4KkX/wuIVJiHyDC8Zpz8yPz0Yqir
         Dj0ktB9jl3MmZJxZaMbGfS99w2hE7294+152Dd3jnQDgX9zy//DPRjF/xWcsLtnNBMax
         uo1pQKeDQ2Y9qttRD3DvCZu6mkBrHhUlycbod9xAHnzlwdnbVRdt5NENUl5/kY/PWKuN
         SOpSMEzL+UGNM+t9rghG11Ck8biN9WAXVVLQxriYWmjzDQPl7rvENHEGUylhIx873njc
         vduK5ryxU2TXlMqg2g/H9x2A7k2DWVpp8m1rfLec8fMUzPYBt4yJo77Q5Tdj60ox7o/o
         y6zQ==
X-Gm-Message-State: AOAM530tV6dR5OxyMYcD25mpNq7ctsQ4lfyr02uOGTc9hFzf5A5bY3zB
        a3jF/SI3A/rVkcCN520/yXbpiMUWKT5v8SOTYu95+Q==
X-Google-Smtp-Source: ABdhPJxD+SYxs+WzJEEILaJBEpt48d7nqLW4DQhFFf8eBFPbo6d0UDg2sMNz/9Td9eN3Zz5QzyBQ319RxtPeL5amV9M=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr19427974ywf.86.1651667961309; Wed, 04
 May 2022 05:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org> <CADjb_WTYPqenF_BhuiDyLduxpaHWCigg-jxAE3FYKTNkWvVz=Q@mail.gmail.com>
In-Reply-To: <CADjb_WTYPqenF_BhuiDyLduxpaHWCigg-jxAE3FYKTNkWvVz=Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 May 2022 14:39:10 +0200
Message-ID: <CAKfTPtCUxZVHOrj+1YTZ+z__HC53by=8X6Bxt1NeGJc2prqdzw@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, Pavel Machek <pavel@ucw.cz>,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
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

On Wed, 4 May 2022 at 13:15, Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> On Sat, Mar 12, 2022 at 7:11 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Take into account the nice latency priority of a thread when deciding to
> > preempt the current running thread. We don't want to provide more CPU
> > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > task first whenever possible.
> >
> ---------->8-------------------
> >  #endif /* CONFIG_SMP */
> >
> > +static long wakeup_latency_gran(int latency_weight)
> > +{
> > +       long thresh = sysctl_sched_latency;
> If I understood correctly, this is to consider the latency weight and
> 'shrink/expand'
> current task's time slice thus to facilitate preemption. And may I
> know why don't we use
> __sched_period() but to use sysctl_sched_latency directly? Is it
> possible the rq has
> more than 8(sched_nr_latency) tasks thus the period is longer than
> sysctl_sched_latency?

Main reason is to be aligned with place_entity which also uses
sysctl_sched_latency to cap entity's vruntime to be higher than
min_vruntime-sysctl_sched_latency

>
> Thanks,
> Chenyu
> > +
> > +       if (!latency_weight)
> > +               return 0;
> > +
> > +       if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > +               thresh >>= 1;
> > +
> > +       /*
> > +        * Clamp the delta to stay in the scheduler period range
> > +        * [-sysctl_sched_latency:sysctl_sched_latency]
> > +        */
> > +       latency_weight = clamp_t(long, latency_weight,
> > +                               -1 * NICE_LATENCY_WEIGHT_MAX,
> > +                               NICE_LATENCY_WEIGHT_MAX);
> > +
> > +       return (thresh * latency_weight) >> NICE_LATENCY_SHIFT;
> > +}
> > +
