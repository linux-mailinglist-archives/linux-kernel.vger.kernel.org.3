Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D058C5BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiHHJj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiHHJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:39:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE613D5B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:39:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c17so11851445lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wW9IqhKPya86Ne3kZ8W5Px3+wqvxjBbUcrSQT3T4dg=;
        b=a5yopIAy9kR8vRJlLjjVB/b3JFrdKEiOl1LXNHsZWQEZQ7CtXgLbcICnqWkKujmAHq
         05o71oKxa2k5A8j4aprmUr1Hn8fDaXrN17Fg1uQqkR0t9B5BTvqn+NDqrBBNwrRoryT5
         QKxsu+DhijXkvc7zcjvSo3DRYx55VKV0GjEuj+WN/zhy4DUmJ1fugfy76JOBIqLhLXDf
         eefrS1NRbOkn+/n89qggUJgaoM2l+J8eW7LSxfBlftFachh1Q2Bex4+atnGJzY2VBr/6
         7DWMADSq7fqayAs/E0ugrAQzMoUwXfSdyhbVBu6VFlYbM7XCXqQgaM38nSzDaIFX5uop
         DBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wW9IqhKPya86Ne3kZ8W5Px3+wqvxjBbUcrSQT3T4dg=;
        b=KdgNwrn3w3tWtd1TI6zsqQsbyJZDnheoDj1mx72gaWz1I6WjI+uB62QXvJVyjOIuMQ
         liH9lRipRVCJZN7g3yROA0GL0vjGm5hxX++PpCFhwvMaASKsJA7q5NheWRqZEe244Kse
         t71CVI/TdEGRGezy/27RNhAlNlaX737VQ/rgETOI7j/72DbmDyBYHRnGzmRNrfZx8o0G
         TE6PyCx/JpWFvWXHy+nT3Noih6O54bgiJB5VSHfnbO1B0wsM1xNbputlVKMSVGrwh3Jc
         /EcjaUriT0jLXfNJKiyPl76feJgQT5ovAlGZP4l9RlqtTVDZwJbxHvmN/W4gUy2RhanV
         yGlA==
X-Gm-Message-State: ACgBeo1PUW++Tl0f6QfRi9wQVg6VRrAGCgjMQnkumSeskSfrnTjfyXoW
        Z3+F2Kf+BWgagjHZLuMDdc5L83Xw4LiTkGVyWSi7pLfZBjA=
X-Google-Smtp-Source: AA6agR4ZIXhQ+P2OA/QwwL6nwJo/rXDB5NYw54d5gwukVqnFl6OKzfVoJx3e7bcWtiTw76Xm6p3TWOMIgWGYm+W3wf4=
X-Received: by 2002:ac2:4e4f:0:b0:48c:e6b6:9d7e with SMTP id
 f15-20020ac24e4f000000b0048ce6b69d7emr1509155lfr.128.1659951591486; Mon, 08
 Aug 2022 02:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <1659939208-22454-1-git-send-email-zhaoyang.huang@unisoc.com> <cb20ece8-3053-1b6c-5820-08663e5c1acc@bytedance.com>
In-Reply-To: <cb20ece8-3053-1b6c-5820-08663e5c1acc@bytedance.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 8 Aug 2022 17:39:39 +0800
Message-ID: <CAGWkznEFEiV4xchHCKTh39zKbpgGR_vSZw_R1KgTiEDaQ6E-Rg@mail.gmail.com>
Subject: Re: [RFC PATCH] psi: introduce PSI UNINTERRUPTIBLE
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, xuewen.yan@unisoc.com
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

On Mon, Aug 8, 2022 at 5:12 PM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/8/8 14:13, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Uninterruptible sleep has not been monitored as an important system status yet.
> > Imagin that a set of psi triggers are created for monitoring a special group, while
> > get nothing high for none of the pressures, which could be the processes within
> > are stock in some given resources and turn to be UN status. Introduce PSI_UN as
> > a sub-type among PSI system here.
>
> Hello,
>
> The problem is that not all TASK_UNINTERRUPTIBLE task means stalled on some
> shared resource, like many schedule_timeout() paths.
Thanks for heads up. The aim is to distinguish where the processes go
(on or off cpu? waiting for anything?). It could be deemed as PSI_MEM
like property which is not a precise running time for memory things.
Furthermore, we do have method to make it be precise.
>
> Thanks.
>
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/psi_types.h | 11 ++++++++---
> >  kernel/sched/psi.c        | 10 ++++++++++
> >  kernel/sched/stats.h      |  6 +++++-
> >  3 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index c7fe7c0..8cc1979 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -15,6 +15,7 @@ enum psi_task_count {
> >       NR_IOWAIT,
> >       NR_MEMSTALL,
> >       NR_RUNNING,
> > +     NR_UNINTERRUPTIBLE,
> >       /*
> >        * This can't have values other than 0 or 1 and could be
> >        * implemented as a bit flag. But for now we still have room
> > @@ -32,7 +33,7 @@ enum psi_task_count {
> >        * threads and memstall ones.
> >        */
> >       NR_MEMSTALL_RUNNING,
> > -     NR_PSI_TASK_COUNTS = 5,
> > +     NR_PSI_TASK_COUNTS = 6,
> >  };
> >
> >  /* Task state bitmasks */
> > @@ -41,13 +42,15 @@ enum psi_task_count {
> >  #define TSK_RUNNING  (1 << NR_RUNNING)
> >  #define TSK_ONCPU    (1 << NR_ONCPU)
> >  #define TSK_MEMSTALL_RUNNING (1 << NR_MEMSTALL_RUNNING)
> > +#define TSK_UNINTERRUPTIBLE  (1 << NR_UNINTERRUPTIBLE)
> >
> >  /* Resources that workloads could be stalled on */
> >  enum psi_res {
> >       PSI_IO,
> >       PSI_MEM,
> >       PSI_CPU,
> > -     NR_PSI_RESOURCES = 3,
> > +     PSI_UN,
> > +     NR_PSI_RESOURCES = 4,
> >  };
> >
> >  /*
> > @@ -63,9 +66,11 @@ enum psi_states {
> >       PSI_MEM_FULL,
> >       PSI_CPU_SOME,
> >       PSI_CPU_FULL,
> > +     PSI_UN_SOME,
> > +     PSI_UN_FULL,
> >       /* Only per-CPU, to weigh the CPU in the global average: */
> >       PSI_NONIDLE,
> > -     NR_PSI_STATES = 7,
> > +     NR_PSI_STATES = 9,
> >  };
> >
> >  enum psi_aggregators {
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index a337f3e..a37b4a4 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -231,6 +231,10 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
> >               return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
> >       case PSI_CPU_FULL:
> >               return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
> > +     case PSI_UN_SOME:
> > +             return unlikely(tasks[NR_UNINTERRUPTIBLE]);
> > +     case PSI_UN_FULL:
> > +             return unlikely(tasks[NR_UNINTERRUPTIBLE] && !tasks[NR_RUNNING]);
> >       case PSI_NONIDLE:
> >               return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
> >                       tasks[NR_RUNNING];
> > @@ -683,6 +687,12 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> >                       groupc->times[PSI_CPU_FULL] += delta;
> >       }
> >
> > +     if (groupc->state_mask & (1 << PSI_UN_SOME)) {
> > +             groupc->times[PSI_UN_SOME] += delta;
> > +             if (groupc->state_mask & (1 << PSI_UN_FULL))
> > +                     groupc->times[PSI_UN_FULL] += delta;
> > +     }
> > +
> >       if (groupc->state_mask & (1 << PSI_NONIDLE))
> >               groupc->times[PSI_NONIDLE] += delta;
> >  }
> > diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> > index baa839c..bf98829 100644
> > --- a/kernel/sched/stats.h
> > +++ b/kernel/sched/stats.h
> > @@ -132,6 +132,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
> >               if (p->in_iowait)
> >                       clear |= TSK_IOWAIT;
> >       }
> > +     clear |= TSK_UNINTERRUPTIBLE;
> >
> >       psi_task_change(p, clear, set);
> >  }
> > @@ -139,6 +140,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
> >  static inline void psi_dequeue(struct task_struct *p, bool sleep)
> >  {
> >       int clear = TSK_RUNNING;
> > +     int set = 0;
> >
> >       if (static_branch_likely(&psi_disabled))
> >               return;
> > @@ -154,8 +156,10 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
> >
> >       if (p->in_memstall)
> >               clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
> > +     if (READ_ONCE(p->__state) & TASK_UNINTERRUPTIBLE)
> > +             set = TSK_UNINTERRUPTIBLE;
> >
> > -     psi_task_change(p, clear, 0);
> > +     psi_task_change(p, clear, set);
> >  }
> >
> >  static inline void psi_ttwu_dequeue(struct task_struct *p)
