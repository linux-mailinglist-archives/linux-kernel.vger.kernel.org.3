Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8832D530203
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbiEVJKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiEVJKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 05:10:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C81344EB
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:10:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u7so13291360ljd.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RfSWWgeHsSKnInAmE9ydokTwPC5z1NwcZ/X1GRR3Bu4=;
        b=o7BG0fMwT+64ovPccV8ill6gWNelCW95XRx+fcwgvCw756+TU7M47ubFXXESnv/QNK
         DfL2d+jruwiUnDxd+W2AAWwYAMwOB6t7YnuIvEIQ7XS9LziXoxKxp0xR5AJAYuL8o8SY
         nc/Y6AHV8ugoqRA9p8EWNXyVn8ScjS+E2BKvwbOiIvvZ4r7phpFaMbjgQiIaMTf520n/
         St1dRe0O6J0cepRh5maYiqZ7ege4o8dQH72D0/ihY42uSKH6ZB6lYqf0s5OMyIdil9sF
         Tf08Tx8DyQbohE5W48ixrY4z6GKu1ZFXM66qESsBW40IFGonF2T17+EOZmlBF79yAIw3
         vp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfSWWgeHsSKnInAmE9ydokTwPC5z1NwcZ/X1GRR3Bu4=;
        b=VQmH/RZ45tW8cvQW7S58adIyVMJ5d5hnKn6tAl0V+lYMwGfov5rIu2IQkYE2Q3sLft
         TZHBkFqhbrz7riWj/7HdAYjFeY5vPqO6L0T98BHlXTd68I5UOglgb/fgRMNE6h7GaQDA
         KrGTBqtL2fqd0caSQy1mlMSeVHB1tjonyupp2F5BOSrpP6BLCyp68EwBrHULWShrVF47
         9EJTeS2CsDkJiAMeOK5m+v75hJ4IEYmmOFRIy+kSNrKqqplRl/eZuLMy/99nt5Pk2VOL
         DmwkwLcfr30AZDL1xUNIuUynu/6JbA+99XwxVl8XseqepAcnAn9Wb5FZOBDlpifixQo4
         vd1A==
X-Gm-Message-State: AOAM532HkmA62XVIMQNygrCHNlZWWNoBcawY6Xf/GX3FK9CWSa7CJoKB
        LRKUHaLFCeb0MUrR2hyDtiCMa+6rMZcJS4BG4Vc+xQ==
X-Google-Smtp-Source: ABdhPJyDrdSQJBfjbvV5WxDCCEW6IEke18V0uptTaw8o7oncV3Cu8MflQXmsAsLD3e4WYTH5IsGIyR7LQByIH/156JA=
X-Received: by 2002:a2e:9f52:0:b0:253:e17c:f0cb with SMTP id
 v18-20020a2e9f52000000b00253e17cf0cbmr4239860ljk.92.1653210605645; Sun, 22
 May 2022 02:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220517210532.1506591-1-liu3101@purdue.edu> <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
 <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com>
 <MWHPR2201MB10724669E6D80EDFDB749478D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
 <CACT4Y+bXyiwEznZkAH5vRNd6YK3gi4aCncQLYt3iMWy43+T4EQ@mail.gmail.com> <MWHPR2201MB10723CCBB4869738E4BDFC36D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB10723CCBB4869738E4BDFC36D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 22 May 2022 11:09:53 +0200
Message-ID: <CACT4Y+Y_iHMn=EB=uBUopQ_5k4btJGAd-TR7Mo-DnUqquUcvng@mail.gmail.com>
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

On Sat, 21 May 2022 at 19:01, Liu, Congyu <liu3101@purdue.edu> wrote:
>
> I just collected some call stacks when `__sanitizer_cov_trace_pc` is recu=
rsively invoked by checking `kcov_writing` flag.
>
> Here are some examples:

Thanks for collecting these.
This is early interrupt code.

I would like to avoid adding more overhead to
__sanitizer_cov_trace_pc() function if possible since it's called for
every basic block.

One alternative is to rearrange irq entry/exit code so that in_task()
starts returning false for all that code. However, this may be tricky
since the irq entry/exit code are subtle beasts.

trace_hardirqs_off_finish() is defined in trace_preemptirq.c:
https://elixir.bootlin.com/linux/v5.18-rc7/source/kernel/trace/trace_preemp=
tirq.c#L61
I think we could mark this file as KCOV_SANITIZE :=3D n in the Makefile.
This would be good for other reasons: currently this code still adds
random coverage pieces at random places even with your patch (it only
prevents overwriting but not adding).

However, this will not work for _find_first_zero_bit() since it's a
very common function used in lots of places.
So what do you think if we additionally swap the order of writing
pc/incrementing pos? It would need some explanatory comment as to why
we are doing this.


> __sanitizer_cov_trace_pc+0xe4/0x100
> trace_hardirqs_off_finish+0x21f/0x270
> irqentry_enter+0x2b/0x50
> sysvec_apic_timer_interrupt+0xb/0xc0
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> __sanitizer_cov_trace_pc+0x91/0x100
> file_update_time+0x68/0x520
> pipe_write+0x1279/0x1ac0
> new_sync_write+0x421/0x650
> vfs_write+0x7ae/0xa60
> ksys_write+0x1ee/0x250
> do_syscall_64+0x3a/0xb0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> __sanitizer_cov_trace_pc+0xe4/0x100
> _find_first_zero_bit+0x52/0xb0
> __lock_acquire+0x1ac2/0x4f70
> lock_acquire+0x1ab/0x4f0
> _raw_spin_lock+0x2a/0x40
> rcu_note_context_switch+0x299/0x16e0
> __schedule+0x1fd/0x2320
> preempt_schedule_irq+0x4e/0x90
> irqentry_exit+0x31/0x80
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> __sanitizer_cov_trace_pc+0x75/0x100
> xas_descend+0x16b/0x340
> xas_load+0xe5/0x140
> pagecache_get_page+0x179/0x18d0
> __find_get_block+0x478/0xd00
> __getblk_gfp+0x32/0xb40
> ext4_getblk+0x1cf/0x680
> ext4_bread_batch+0x80/0x5a0
> __ext4_find_entry+0x460/0xfc0
> ext4_lookup+0x4fc/0x730
> __lookup_hash+0x117/0x180
> filename_create+0x186/0x490
> unix_bind+0x322/0xbc0
> __sys_bind+0x20c/0x260
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x3a/0xb0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
> __sanitizer_cov_trace_pc+0xe4/0x100
> prandom_u32+0xd/0x460
> trace_hardirqs_off_finish+0x60/0x270
> irqentry_enter+0x2b/0x50
> sysvec_apic_timer_interrupt+0xb/0xc0
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> __sanitizer_cov_trace_pc+0x9a/0x100
> __es_remove_extent+0x726/0x15e0
> ext4_es_insert_delayed_block+0x216/0x580
> ext4_da_get_block_prep+0x88f/0x1180
> __block_write_begin_int+0x3ef/0x1630
> block_page_mkwrite+0x223/0x310
> ext4_page_mkwrite+0xbf7/0x1a30
> do_page_mkwrite+0x1a7/0x530
> __handle_mm_fault+0x2c71/0x5240
> handle_mm_fault+0x1bc/0x7b0
> do_user_addr_fault+0x59b/0x1200
> exc_page_fault+0x9e/0x170
> asm_exc_page_fault+0x1e/0x30
>
> Looks like `asm_sysvec_apic_timer_interrupt` is culprit.
>
> ________________________________________
> From: Dmitry Vyukov <dvyukov@google.com>
> Sent: Saturday, May 21, 2022 4:45
> To: Liu, Congyu
> Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.k=
ernel.org
> Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
>
> On Sat, 21 May 2022 at 05:59, Liu, Congyu <liu3101@purdue.edu> wrote:
> >
> > Hi Dmitry,
> >
> > Sorry for the late reply. I did some experiments and hopefully they cou=
ld be helpful.
> >
> > To get the PC of the code that tampered with the buffer, I added some c=
ode between `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`: First, som=
e code to delay for a while (e.g. for loop to write something). Then read `=
area[0]` and compare it with `pos`. If they are different, then `area[pos]`=
 is tampered. A mask is then added to `area[pos]` so I can identify and ret=
rieve it later.
> >
> > In this way, I ran some test cases then get a list of PCs that tampered=
 with the kcov buffer, e.g., ./include/linux/rcupdate.h:rcu_read_lock, arch=
/x86/include/asm/current.h:get_current, include/sound/pcm.h:hw_is_interval,=
 net/core/neighbour.c:neigh_flush_dev, net/ipv6/addrconf.c:__ipv6_dev_get_s=
addr, mm/mempolicy.c:__get_vma_policy...... It seems that they are not from=
 the early interrupt code. Do you think they should not be instrumented?
>
> Humm... these look strange. They don't look like early interrupt code,
> but they also don't look like interrupt code at all. E.g.
> neigh_flush_dev looks like a very high level function that takes some
> mutexes:
> https://elixir.bootlin.com/linux/v5.18-rc7/source/net/core/neighbour.c#L3=
20
>
> It seems that there is something happening that we don't understand.
>
> Please try to set t->kcov_writing around the task access, and then if
> you see it recursively already set print the current pc/stack trace.
> That should give better visibility into what code enters kcov
> recursively.
>
> If you are using syzkaller tools, you can run syz-execprog with -cover
> flag on some log file, or run some program undef kcovtrace:
> https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace=
.c
>
>
>
> > I think reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);` =
is also a smart solution since PC will be written to buffer only after the =
buffer is reserved.
> >
> > Thanks,
> > Congyu
> >
> > ________________________________________
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Sent: Wednesday, May 18, 2022 4:59
> > To: Liu, Congyu
> > Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger=
.kernel.org
> > Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
> >
> > On Wed, 18 May 2022 at 10:56, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:
> > > >
> > > > Some code runs in interrupts cannot be blocked by `in_task()` check=
.
> > > > In some unfortunate interleavings, such interrupt is raised during
> > > > serializing trace data and the incoming nested trace functionn coul=
d
> > > > lead to loss of previous trace data. For instance, in
> > > > `__sanitizer_cov_trace_pc`, if such interrupt is raised between
> > > > `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`, then trace dat=
a in
> > > > `area[pos]` could be replaced.
> > > >
> > > > The fix is done by adding a flag indicating if the trace buffer is =
being
> > > > updated. No modification to trace buffer is allowed when the flag i=
s set.
> > >
> > > Hi Congyu,
> > >
> > > What is that interrupt code? What interrupts PCs do you see in the tr=
ace.
> > > I would assume such early interrupt code should be in asm and/or not
> > > instrumented. The presence of instrumented traced interrupt code is
> > > problematic for other reasons (add random stray coverage to the
> > > trace). So if we make it not traced, it would resolve both problems a=
t
> > > once and without the fast path overhead that this change adds.
> >
> > Also thinking if reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0]=
, pos);`
> > will resolve the problem without adding fast path overhead.
> > However, not instrumenting early interrupt code still looks more prefer=
able.
> >
> >
> >  > Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> > > > ---
> > > >  include/linux/sched.h |  3 +++
> > > >  kernel/kcov.c         | 16 ++++++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > > >
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index a8911b1f35aa..d06cedd9595f 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -1408,6 +1408,9 @@ struct task_struct {
> > > >
> > > >         /* Collect coverage from softirq context: */
> > > >         unsigned int                    kcov_softirq;
> > > > +
> > > > +       /* Flag of if KCOV area is being written: */
> > > > +       bool                            kcov_writing;
> > > >  #endif
> > > >
> > > >  #ifdef CONFIG_MEMCG
> > > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > > index b3732b210593..a595a8ad5d8a 100644
> > > > --- a/kernel/kcov.c
> > > > +++ b/kernel/kcov.c
> > > > @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_m=
ode needed_mode, struct task_stru
> > > >          */
> > > >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq=
))
> > > >                 return false;
> > > > +       if (READ_ONCE(t->kcov_writing))
> > > > +               return false;
> > > >         mode =3D READ_ONCE(t->kcov_mode);
> > > >         /*
> > > >          * There is some code that runs in interrupts but for which
> > > > @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
> > > >                 return;
> > > >
> > > >         area =3D t->kcov_area;
> > > > +
> > > > +       /* Prevent race from unblocked interrupt. */
> > > > +       WRITE_ONCE(t->kcov_writing, true);
> > > > +       barrier();
> > > > +
> > > >         /* The first 64-bit word is the number of subsequent PCs. *=
/
> > > >         pos =3D READ_ONCE(area[0]) + 1;
> > > >         if (likely(pos < t->kcov_size)) {
> > > >                 area[pos] =3D ip;
> > > >                 WRITE_ONCE(area[0], pos);
> > > >         }
> > > > +       barrier();
> > > > +       WRITE_ONCE(t->kcov_writing, false);
> > > >  }
> > > >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> > > >
> > > > @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, =
u64 arg1, u64 arg2, u64 ip)
> > > >         area =3D (u64 *)t->kcov_area;
> > > >         max_pos =3D t->kcov_size * sizeof(unsigned long);
> > > >
> > > > +       /* Prevent race from unblocked interrupt. */
> > > > +       WRITE_ONCE(t->kcov_writing, true);
> > > > +       barrier();
> > > > +
> > > >         count =3D READ_ONCE(area[0]);
> > > >
> > > >         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
> > > > @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u=
64 arg1, u64 arg2, u64 ip)
> > > >                 area[start_index + 3] =3D ip;
> > > >                 WRITE_ONCE(area[0], count + 1);
> > > >         }
> > > > +       barrier();
> > > > +       WRITE_ONCE(t->kcov_writing, false);
> > > >  }
> > > >
> > > >  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> > > > @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, s=
truct kcov *kcov,
> > > >         t->kcov_size =3D size;
> > > >         t->kcov_area =3D area;
> > > >         t->kcov_sequence =3D sequence;
> > > > +       t->kcov_writing =3D false;
> > > >         /* See comment in check_kcov_mode(). */
> > > >         barrier();
> > > >         WRITE_ONCE(t->kcov_mode, mode);
> > > > --
> > > > 2.34.1
> > > >
