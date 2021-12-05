Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0519468A71
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhLELLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbhLELLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:11:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A260C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 03:08:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so31155123edv.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 03:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6ZKOIP1nqt6ONWieZTdyi4dNJ7yQUwdEIYSMHMmqtWw=;
        b=PsAJEMlr1qqhz/HiwKpE25zyOn8bByBFTdyJhLzF380yq908K5hvg4RIOmBhhgRYkk
         JNqoEfV7F90P6n7Wwgj8xnMRmJ46vGl4O5aiArO/2zmajoNsyeM3uK5o/SkQH0ViwevE
         6yzoCZ6Y7TpfZRIecReWpXN3JjxGrp+/AgQYsP8kqwiQT5IyAobax2Xng+xPdOk0ISs9
         7lvrzl+OnlzNyXbg3n9gjZl8sKUizL+Hgr8MLuVQWZ8TNylAbPzx55uLD0uNJC1Yqdni
         CIJKS+zWLuUuo1lFGMFXCVE4RgyiknbcD2nFM1sQ8aKWQrm2eCe2tSA5X6leJGCOCm1n
         rdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ZKOIP1nqt6ONWieZTdyi4dNJ7yQUwdEIYSMHMmqtWw=;
        b=NfuhVPOlu7G6DKy5x61urV4r5g3f6CWg+jcneNKJP/5Kl/Lcor3v6ESOSFrDkYCSwh
         iBC8o+/Z90E+Pz19tmuj996GyKfYTtvS0KZlFdjMkuUragCuIL+HRlH21I7orPYfeOGB
         7Hl8oeqZJTlwR/i6kdCBf29NGkG75OA5flliTxZWRXU4UVzZZZRmAL3B7rvYA44MGHYE
         uRgwN5uSpn2oCW4SI7cQ9pxBB9KKsvWmyJuWFB4vGUKhHGKou7164TNTcp2QWCiD4rfh
         ftVAgMfOjS2xsm8olTXEBkoAN+RJPRhKcprlbTjLwoXsXAI3ysgAnSbFHpzz3pGQodZr
         5KfA==
X-Gm-Message-State: AOAM530xf5zvMzpVQzAHmrEKbq+/1L6omVYLK7nJNo3kdDFO7pd4oXj9
        Ud4k8/pAB2Co4SoanBqIu6IeGTRokfkVbDPo2xU=
X-Google-Smtp-Source: ABdhPJzHfJGqNo0zk8ZC/Un5H7b5X8EqgM8ZX1hKxSej7z7ZODhc/gtFTsQ156WH8DZYxQlTBDYOeyUDoLcp+OIPkrw=
X-Received: by 2002:a05:6402:710:: with SMTP id w16mr44528848edx.218.1638702496422;
 Sun, 05 Dec 2021 03:08:16 -0800 (PST)
MIME-Version: 1.0
References: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn> <Yax01zjuzmNyyJK/@balbir-desktop>
In-Reply-To: <Yax01zjuzmNyyJK/@balbir-desktop>
From:   yong w <yongw.pur@gmail.com>
Date:   Sun, 5 Dec 2021 19:08:02 +0800
Message-ID: <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
Subject: Re: [PATCH v2 linux-next] delayacct: track delays from memory compact
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=885=E6=
=97=A5=E5=91=A8=E6=97=A5 16:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Dec 04, 2021 at 04:09:55AM -0800, yongw.pur@gmail.com wrote:
> > From: wangyong <wang.yong12@zte.com.cn>
> >
> > Delay accounting does not track the delay of memory compact.
> > When there is not enough free memory, tasks can spend
> > a amount of their time waiting for compact.
> >
> > To get the impact of tasks in direct memory compact, measure
> > the delay when allocating memory through memory compact.
> >
>
> Should we call this DIRECT_COMPACT and through documentation
> or name change imply that this won't work for kcompactd the
> kernel thread - based on my reading of the patches.
>
Using DIRECT_COMPACT is a little redundant=EF=BC=8Cbecause the
delayacct stats of delay accounting is specific to tasks, it has
nothing to do with kcompactd, which is similar to the RECLAIM field.

As for the document, consider submitting a separate patch with
the thrashing delay description added.

> > Also update tools/accounting/getdelays.c:
> > / # ./getdelays_next  -di -p 304
> > print delayacct stats ON
> > printing IO accounting
> > PID     304
> >
> > CPU             count     real total  virtual total    delay total  del=
ay average
> >                   277      780000000      849039485       18877296     =
     0.068ms
> > IO              count    delay total  delay average
> >                     0              0              0ms
> > SWAP            count    delay total  delay average
> >                     0              0              0ms
> > RECLAIM         count    delay total  delay average
> >                     5    11088812685           2217ms
> > THRASHING       count    delay total  delay average
> >                     0              0              0ms
> > COMPACT         count    delay total  delay average
> >                     3          72758              0ms
> > watch: read=3D0, write=3D0, cancelled_write=3D0
> >
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Reviewed-by: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> > Reviewed-by: Zhang Wenya <zhang.wenya1@zte.com.cn>
> > Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >
> > Changes since v1:
> > -fixed duplicate member freepages_start.
> >
> >  include/linux/delayacct.h      | 28 ++++++++++++++++++++++++++++
> >  include/uapi/linux/taskstats.h |  6 +++++-
> >  kernel/delayacct.c             | 15 +++++++++++++++
> >  mm/page_alloc.c                |  3 +++
> >  tools/accounting/getdelays.c   |  8 +++++++-
> >  5 files changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
> > index 435c365..3e03d01 100644
> > --- a/include/linux/delayacct.h
> > +++ b/include/linux/delayacct.h
> > @@ -42,8 +42,12 @@ struct task_delay_info {
> >       u64 thrashing_start;
> >       u64 thrashing_delay;    /* wait for thrashing page */
> >
> > +     u64 compact_start;
> > +     u64 compact_delay;      /* wait for memory compact */
> > +
> >       u32 freepages_count;    /* total count of memory reclaim */
> >       u32 thrashing_count;    /* total count of thrash waits */
> > +     u32 compact_count;      /* total count of memory compact */
> >  };
> >  #endif
> >
> > @@ -72,6 +76,8 @@ extern void __delayacct_thrashing_start(void);
> >  extern void __delayacct_thrashing_end(void);
> >  extern void __delayacct_swapin_start(void);
> >  extern void __delayacct_swapin_end(void);
> > +extern void __delayacct_compact_start(void);
> > +extern void __delayacct_compact_end(void);
> >
> >  static inline void delayacct_tsk_init(struct task_struct *tsk)
> >  {
> > @@ -170,6 +176,24 @@ static inline void delayacct_swapin_end(void)
> >               __delayacct_swapin_end();
> >  }
> >
> > +static inline void delayacct_compact_start(void)
> > +{
> > +     if (!static_branch_unlikely(&delayacct_key))
> > +             return;
> > +
> > +     if (current->delays)
> > +             __delayacct_compact_start();
> > +}
> > +
> > +static inline void delayacct_compact_end(void)
> > +{
> > +     if (!static_branch_unlikely(&delayacct_key))
> > +             return;
> > +
> > +     if (current->delays)
> > +             __delayacct_compact_end();
> > +}
> > +
> >  #else
> >  static inline void delayacct_init(void)
> >  {}
> > @@ -200,6 +224,10 @@ static inline void delayacct_swapin_start(void)
> >  {}
> >  static inline void delayacct_swapin_end(void)
> >  {}
> > +static inline void delayacct_compact_start(void)
> > +{}
> > +static inline void delayacct_compact_end(void)
> > +{}
> >
> >  #endif /* CONFIG_TASK_DELAY_ACCT */
> >
> > diff --git a/include/uapi/linux/taskstats.h b/include/uapi/linux/taskst=
ats.h
> > index ccbd087..12327d3 100644
> > --- a/include/uapi/linux/taskstats.h
> > +++ b/include/uapi/linux/taskstats.h
> > @@ -34,7 +34,7 @@
> >   */
> >
> >
> > -#define TASKSTATS_VERSION    10
> > +#define TASKSTATS_VERSION    11
> >  #define TS_COMM_LEN          32      /* should be >=3D TASK_COMM_LEN
> >                                        * in linux/sched.h */
> >
> > @@ -172,6 +172,10 @@ struct taskstats {
> >
> >       /* v10: 64-bit btime to avoid overflow */
> >       __u64   ac_btime64;             /* 64-bit begin time */
> > +
> > +     /* Delay waiting for memory compact */
> > +     __u64   compact_count;
> > +     __u64   compact_delay_total;
> >  };
> >
> >
> > diff --git a/kernel/delayacct.c b/kernel/delayacct.c
> > index 11f3cd8..c5e8cea 100644
> > --- a/kernel/delayacct.c
> > +++ b/kernel/delayacct.c
> > @@ -155,10 +155,13 @@ int delayacct_add_tsk(struct taskstats *d, struct=
 task_struct *tsk)
> >       d->freepages_delay_total =3D (tmp < d->freepages_delay_total) ? 0=
 : tmp;
> >       tmp =3D d->thrashing_delay_total + tsk->delays->thrashing_delay;
> >       d->thrashing_delay_total =3D (tmp < d->thrashing_delay_total) ? 0=
 : tmp;
> > +     tmp =3D d->compact_delay_total + tsk->delays->compact_delay;
> > +     d->compact_delay_total =3D (tmp < d->compact_delay_total) ? 0 : t=
mp;
> >       d->blkio_count +=3D tsk->delays->blkio_count;
> >       d->swapin_count +=3D tsk->delays->swapin_count;
> >       d->freepages_count +=3D tsk->delays->freepages_count;
> >       d->thrashing_count +=3D tsk->delays->thrashing_count;
> > +     d->compact_count +=3D tsk->delays->compact_count;
> >       raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
> >
> >       return 0;
> > @@ -214,3 +217,15 @@ void __delayacct_swapin_end(void)
> >                     &current->delays->swapin_count);
> >  }
> >
> > +void __delayacct_compact_start(void)
> > +{
> > +     current->delays->compact_start =3D local_clock();
> > +}
> > +
> > +void __delayacct_compact_end(void)
> > +{
> > +     delayacct_end(&current->delays->lock,
> > +                   &current->delays->compact_start,
> > +                   &current->delays->compact_delay,
> > +                   &current->delays->compact_count);
> > +}
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index edfd6c8..6430226 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -74,6 +74,7 @@
> >  #include <linux/padata.h>
> >  #include <linux/khugepaged.h>
> >  #include <linux/buffer_head.h>
> > +#include <linux/delayacct.h>
> >  #include <asm/sections.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/div64.h>
> > @@ -4363,6 +4364,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsi=
gned int order,
> >               return NULL;
> >
> >       psi_memstall_enter(&pflags);
> > +     delayacct_compact_start();
> >       noreclaim_flag =3D memalloc_noreclaim_save();
> >
> >       *compact_result =3D try_to_compact_pages(gfp_mask, order, alloc_f=
lags, ac,
> > @@ -4370,6 +4372,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsi=
gned int order,
> >
> >       memalloc_noreclaim_restore(noreclaim_flag);
> >       psi_memstall_leave(&pflags);
> > +     delayacct_compact_end();
> >
> >       if (*compact_result =3D=3D COMPACT_SKIPPED)
> >               return NULL;
> > diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.=
c
> > index 5ef1c15..11e8673 100644
> > --- a/tools/accounting/getdelays.c
> > +++ b/tools/accounting/getdelays.c
> > @@ -205,6 +205,8 @@ static void print_delayacct(struct taskstats *t)
> >              "RECLAIM  %12s%15s%15s\n"
> >              "      %15llu%15llu%15llums\n"
> >              "THRASHING%12s%15s%15s\n"
> > +            "      %15llu%15llu%15llums\n"
> > +            "COMPACT  %12s%15s%15s\n"
> >              "      %15llu%15llu%15llums\n",
> >              "count", "real total", "virtual total",
> >              "delay total", "delay average",
> > @@ -228,7 +230,11 @@ static void print_delayacct(struct taskstats *t)
> >              "count", "delay total", "delay average",
> >              (unsigned long long)t->thrashing_count,
> >              (unsigned long long)t->thrashing_delay_total,
> > -            average_ms(t->thrashing_delay_total, t->thrashing_count));
> > +            average_ms(t->thrashing_delay_total, t->thrashing_count),
> > +            "count", "delay total", "delay average",
> > +            (unsigned long long)t->compact_count,
> > +            (unsigned long long)t->compact_delay_total,
> > +            average_ms(t->compact_delay_total, t->compact_count));
> >  }
> >
> >  static void task_context_switch_counts(struct taskstats *t)
> > --
> > 2.7.4
> >
>
> At some point we should make the user space tool version aware.
>
I think this tool is generally used with the corresponding kernel, and
TASKSTATS_VERSION is used to indicate that the structure has
changed which has been modified in this patch.
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Thanks for your reply!
