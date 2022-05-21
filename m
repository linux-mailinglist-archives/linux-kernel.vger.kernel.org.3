Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D788952FA19
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiEUIpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 04:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiEUIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 04:45:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0B24ECF4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 01:45:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e4so11321483ljb.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=itZAhxeCXbb0Z6+Q7+j5JbM+lNNa9CxSXTcydNGHMws=;
        b=bIBjcUhdxgLXEuo/IQn+9x+2Coz5rSDsdHefO+2g1srnGro9bVQtX6+9UqVxFxdZxI
         z1OJxF+nMXfq96ZbJPgGjAOlcNyY0njLVbLoVpvbEU7EHs28c2F/Yf/kc1MpjCEjSoWk
         M8q57JXov+GCOOHprbF71PxqcA4DqgdQYrPnrjdSf1G7B8saE4gGBPtYcE90iqt+kiOe
         fdz+kk3IZXdfJv4RIvF6bKfie2JV6yOUPY59u3yJCJh59Cg0oSRSnBJHWo8NzEYmAsjI
         QUgnXGLPmXOOXFXLS38V/TrB9JQvZRI3r+/IFsyjzi8ptJIhK25OSqwu9w/4orl7FIj2
         0jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=itZAhxeCXbb0Z6+Q7+j5JbM+lNNa9CxSXTcydNGHMws=;
        b=XG1wx8/tIWH72E3B90QqSnOWbqAcOVySsjThShrO57QgM9MF+EY52TtItwaSzJEe3k
         Z94OUKzB9xgWLdJ12DbsBhJbR7yxRu1lULANdD2GmDaNApMt+DUMpSaJCnCRvdK8JEPX
         SE7hS2t1ibULjCEZNBRZUxxouTBCAkCa5U465LVYPPl9+zFyXr64OZ0dp9tgtgEdv0iQ
         iz9W1cndwD2ScqixWGqxvWCoPBHfv04r2bIBNxuQJWihSCzIqTAgfH+aogZdFmHOMBiA
         /s6vHcuOKjUSlnKsPR2XQG1G/00EuLMwNO3HBT6/cU5rd6FuCIm8uQ7GEJscqYTXr4RY
         cMkw==
X-Gm-Message-State: AOAM5333FiB8fZsqhpWSOgsiZIIdl9gDdcrNfi3y2mTyfNfpF+ZkKQrv
        fBdmAT/+Sy1G8XMYBBd7nj67rMrMY0UBziuDwc7v9A==
X-Google-Smtp-Source: ABdhPJzBjKvANKkDsLpDJQxs6lx8hWUNA5vzmVjfR/le6CfD2sa+gzAKz+6AT2QSbOzF8jBecMbfQI7ZB7LtANaULXM=
X-Received: by 2002:a05:651c:19a3:b0:24f:4ed0:588 with SMTP id
 bx35-20020a05651c19a300b0024f4ed00588mr7903221ljb.465.1653122716474; Sat, 21
 May 2022 01:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220517210532.1506591-1-liu3101@purdue.edu> <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
 <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com> <MWHPR2201MB10724669E6D80EDFDB749478D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB10724669E6D80EDFDB749478D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 21 May 2022 10:45:05 +0200
Message-ID: <CACT4Y+bXyiwEznZkAH5vRNd6YK3gi4aCncQLYt3iMWy43+T4EQ@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
To:     "Liu, Congyu" <liu3101@purdue.edu>
Cc:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 21 May 2022 at 05:59, Liu, Congyu <liu3101@purdue.edu> wrote:
>
> Hi Dmitry,
>
> Sorry for the late reply. I did some experiments and hopefully they could=
 be helpful.
>
> To get the PC of the code that tampered with the buffer, I added some cod=
e between `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`: First, some =
code to delay for a while (e.g. for loop to write something). Then read `ar=
ea[0]` and compare it with `pos`. If they are different, then `area[pos]` i=
s tampered. A mask is then added to `area[pos]` so I can identify and retri=
eve it later.
>
> In this way, I ran some test cases then get a list of PCs that tampered w=
ith the kcov buffer, e.g., ./include/linux/rcupdate.h:rcu_read_lock, arch/x=
86/include/asm/current.h:get_current, include/sound/pcm.h:hw_is_interval, n=
et/core/neighbour.c:neigh_flush_dev, net/ipv6/addrconf.c:__ipv6_dev_get_sad=
dr, mm/mempolicy.c:__get_vma_policy...... It seems that they are not from t=
he early interrupt code. Do you think they should not be instrumented?

Humm... these look strange. They don't look like early interrupt code,
but they also don't look like interrupt code at all. E.g.
neigh_flush_dev looks like a very high level function that takes some
mutexes:
https://elixir.bootlin.com/linux/v5.18-rc7/source/net/core/neighbour.c#L320

It seems that there is something happening that we don't understand.

Please try to set t->kcov_writing around the task access, and then if
you see it recursively already set print the current pc/stack trace.
That should give better visibility into what code enters kcov
recursively.

If you are using syzkaller tools, you can run syz-execprog with -cover
flag on some log file, or run some program undef kcovtrace:
https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c



> I think reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);` is=
 also a smart solution since PC will be written to buffer only after the bu=
ffer is reserved.
>
> Thanks,
> Congyu
>
> ________________________________________
> From: Dmitry Vyukov <dvyukov@google.com>
> Sent: Wednesday, May 18, 2022 4:59
> To: Liu, Congyu
> Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.k=
ernel.org
> Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
>
> On Wed, 18 May 2022 at 10:56, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:
> > >
> > > Some code runs in interrupts cannot be blocked by `in_task()` check.
> > > In some unfortunate interleavings, such interrupt is raised during
> > > serializing trace data and the incoming nested trace functionn could
> > > lead to loss of previous trace data. For instance, in
> > > `__sanitizer_cov_trace_pc`, if such interrupt is raised between
> > > `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`, then trace data =
in
> > > `area[pos]` could be replaced.
> > >
> > > The fix is done by adding a flag indicating if the trace buffer is be=
ing
> > > updated. No modification to trace buffer is allowed when the flag is =
set.
> >
> > Hi Congyu,
> >
> > What is that interrupt code? What interrupts PCs do you see in the trac=
e.
> > I would assume such early interrupt code should be in asm and/or not
> > instrumented. The presence of instrumented traced interrupt code is
> > problematic for other reasons (add random stray coverage to the
> > trace). So if we make it not traced, it would resolve both problems at
> > once and without the fast path overhead that this change adds.
>
> Also thinking if reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], =
pos);`
> will resolve the problem without adding fast path overhead.
> However, not instrumenting early interrupt code still looks more preferab=
le.
>
>
>  > Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> > > ---
> > >  include/linux/sched.h |  3 +++
> > >  kernel/kcov.c         | 16 ++++++++++++++++
> > >  2 files changed, 19 insertions(+)
> > >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index a8911b1f35aa..d06cedd9595f 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1408,6 +1408,9 @@ struct task_struct {
> > >
> > >         /* Collect coverage from softirq context: */
> > >         unsigned int                    kcov_softirq;
> > > +
> > > +       /* Flag of if KCOV area is being written: */
> > > +       bool                            kcov_writing;
> > >  #endif
> > >
> > >  #ifdef CONFIG_MEMCG
> > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > index b3732b210593..a595a8ad5d8a 100644
> > > --- a/kernel/kcov.c
> > > +++ b/kernel/kcov.c
> > > @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_mod=
e needed_mode, struct task_stru
> > >          */
> > >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
> > >                 return false;
> > > +       if (READ_ONCE(t->kcov_writing))
> > > +               return false;
> > >         mode =3D READ_ONCE(t->kcov_mode);
> > >         /*
> > >          * There is some code that runs in interrupts but for which
> > > @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
> > >                 return;
> > >
> > >         area =3D t->kcov_area;
> > > +
> > > +       /* Prevent race from unblocked interrupt. */
> > > +       WRITE_ONCE(t->kcov_writing, true);
> > > +       barrier();
> > > +
> > >         /* The first 64-bit word is the number of subsequent PCs. */
> > >         pos =3D READ_ONCE(area[0]) + 1;
> > >         if (likely(pos < t->kcov_size)) {
> > >                 area[pos] =3D ip;
> > >                 WRITE_ONCE(area[0], pos);
> > >         }
> > > +       barrier();
> > > +       WRITE_ONCE(t->kcov_writing, false);
> > >  }
> > >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> > >
> > > @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, u6=
4 arg1, u64 arg2, u64 ip)
> > >         area =3D (u64 *)t->kcov_area;
> > >         max_pos =3D t->kcov_size * sizeof(unsigned long);
> > >
> > > +       /* Prevent race from unblocked interrupt. */
> > > +       WRITE_ONCE(t->kcov_writing, true);
> > > +       barrier();
> > > +
> > >         count =3D READ_ONCE(area[0]);
> > >
> > >         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
> > > @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u64=
 arg1, u64 arg2, u64 ip)
> > >                 area[start_index + 3] =3D ip;
> > >                 WRITE_ONCE(area[0], count + 1);
> > >         }
> > > +       barrier();
> > > +       WRITE_ONCE(t->kcov_writing, false);
> > >  }
> > >
> > >  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> > > @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, str=
uct kcov *kcov,
> > >         t->kcov_size =3D size;
> > >         t->kcov_area =3D area;
> > >         t->kcov_sequence =3D sequence;
> > > +       t->kcov_writing =3D false;
> > >         /* See comment in check_kcov_mode(). */
> > >         barrier();
> > >         WRITE_ONCE(t->kcov_mode, mode);
> > > --
> > > 2.34.1
> > >
