Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3855AF2B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbiIFRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiIFRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:30:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F75F7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:24:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 62so9485999iov.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Ld2JxcymypOPOgywLT44PW2Ikbrb1VzeoM48fRlHsTI=;
        b=heO9Twwqp33yzFcE5GLSFZY/U8zaJZ4J28uFyeewexljvXECNpeJ2YeThC56sC2T1Z
         FSkdQqIVbh/cqsKT5Y0t8iIePnxPuCevJ8ZrOfdNvQiWBmPcnuOTAMMzUWnWFRjh069U
         2SXZ6m6FQBjFi6mdlCo7dKjS53jGhfxzzRBbp3o0goQTVEZefTtFJinepqc7gwdA76Zn
         wWWp4f8k5XGZje2LlOIKk4oVmjduAoZAwWtXy3GPKeN4mt5BZrcg7cPtj/js/QvqGJHf
         DTscr+is3SnIENf6zzTDVRxrFNZQ12O+RxDP9vtCrN8voGYy2HMXqkCLYp+loBr1u5fW
         yK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ld2JxcymypOPOgywLT44PW2Ikbrb1VzeoM48fRlHsTI=;
        b=M5eSuHU2Wpsfa9RDkn56bLQuYSlC5eOJSmGj4S3zNijA8D//01TQMWQfn9vpqK7iQ1
         VPRnkkJPTH52g363wkf/vFt84Sc/yrAN2pVCLD26YUloQLbITz+oygLd6cx9GrciO403
         uzxvSkZPY9P4YqqWDy6SFkF1QDgZ6AmWxrrDhRP1ZH2dR3/A9pNCdUcYLJ/GOJYVpzxf
         qyFTnYNMzy3XoqAAmMupwnr+Sbth/tr2HMQ2SfO6GDLE3KR/flZp1fdchl3xnqQrsniW
         wN54IGisgsUfmR335FiHBDNw1fgvLXztQ0Ykg9T5kzd/yulyWt3o52q3/VdFvc/BDHFm
         52nw==
X-Gm-Message-State: ACgBeo3GzhaFdP7Nm5QGhG/JqRXszdJd2qcSlnaB8E71jgGOZAPmnI60
        7c17YGQMLyj7QWyjC0DekrEom9kmuAIMqj12ME/M1AQkXRhjMJIkfd3cxyXeKIYplU46cTDiTP9
        OD9Ril6MspwVuKXLJjW3cm512gOINYEk=
X-Google-Smtp-Source: AA6agR44YTmLzCV+I+JaNpT4N0gLu2+UsZktpd1YNE7QssF1dAl8b+3/7PUu8k7UutO/GpnVhbMgZRcHYblP//qHDQY=
X-Received: by 2002:a02:740b:0:b0:349:bcdd:ca20 with SMTP id
 o11-20020a02740b000000b00349bcddca20mr30908418jac.110.1662485080617; Tue, 06
 Sep 2022 10:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-6-surenb@google.com>
 <c84136d3-703a-0e57-20ce-59f6b5823999@linux.ibm.com>
In-Reply-To: <c84136d3-703a-0e57-20ce-59f6b5823999@linux.ibm.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Sep 2022 10:24:29 -0700
Message-ID: <CAJuCfpFZ_E0wuA+0Xsavk+hnGDA-H0SdcZGUr31_u-cXyR6b7Q@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 05/28] mm: add per-VMA lock and helper
 functions to control it
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ccpol: medium
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

On Tue, Sep 6, 2022 at 6:47 AM Laurent Dufour <ldufour@linux.ibm.com> wrote=
:
>
> Le 01/09/2022 =C3=A0 19:34, Suren Baghdasaryan a =C3=A9crit :
> > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > instead of mmap_lock. Because there are cases when multiple VMAs need
> > to be exclusively locked during VMA tree modifications, instead of the
> > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > mmap_write_lock holder is done with all modifications and drops mmap_lo=
ck,
> > it will increment mm->lock_seq, effectively unlocking all VMAs marked a=
s
> > locked.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Despite a minor comment below,
>
> Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>

Thanks for the reviews Laurent! I'll need some time to double-check
all the VMA locking locations that you spotted as potentially
unnecessary. Admittedly I was a bit paranoid when writing this
patchset and trying not to miss any potential race, so some of them
might indeed be unnecessary. Will reply to each of your comments once
I confirm the need for locking in each case.
Thanks,
Suren.

>
> > ---
> >  include/linux/mm.h        | 78 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/mm_types.h  |  7 ++++
> >  include/linux/mmap_lock.h | 13 +++++++
> >  kernel/fork.c             |  4 ++
> >  mm/init-mm.c              |  3 ++
> >  5 files changed, 105 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7d322a979455..476bf936c5f0 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -611,6 +611,83 @@ struct vm_operations_struct {
> >                                         unsigned long addr);
> >  };
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static inline void vma_init_lock(struct vm_area_struct *vma)
> > +{
> > +     init_rwsem(&vma->lock);
> > +     vma->vm_lock_seq =3D -1;
> > +}
> > +
> > +static inline void vma_mark_locked(struct vm_area_struct *vma)
> > +{
> > +     int mm_lock_seq;
> > +
> > +     mmap_assert_write_locked(vma->vm_mm);
> > +
> > +     /*
> > +      * current task is holding mmap_write_lock, both vma->vm_lock_seq=
 and
> > +      * mm->mm_lock_seq can't be concurrently modified.
> > +      */
> > +     mm_lock_seq =3D READ_ONCE(vma->vm_mm->mm_lock_seq);
> > +     if (vma->vm_lock_seq =3D=3D mm_lock_seq)
> > +             return;
> > +
> > +     down_write(&vma->lock);
> > +     vma->vm_lock_seq =3D mm_lock_seq;
> > +     up_write(&vma->lock);
> > +}
> > +
> > +static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > +{
> > +     if (unlikely(down_read_trylock(&vma->lock) =3D=3D 0))
> > +             return false;
> > +
> > +     /*
> > +      * Overflow might produce false locked result but it's not critic=
al.
>
> It might be good to precise here that in the case of false locked, the
> caller is assumed to fallback read locking the mm entirely before doing i=
ts
> change relative to that VMA.

Ack.

>
> > +      * False unlocked result is critical but is impossible because we
> > +      * modify and check vma->vm_lock_seq under vma->lock protection a=
nd
> > +      * mm->mm_lock_seq modification invalidates all existing locks.
> > +      */
> > +     if (vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_lock_seq)) {
> > +             up_read(&vma->lock);
> > +             return false;
> > +     }
> > +     return true;
> > +}
> > +
> > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > +{
> > +     up_read(&vma->lock);
> > +}
> > +
> > +static inline void vma_assert_locked(struct vm_area_struct *vma)
> > +{
> > +     lockdep_assert_held(&vma->lock);
> > +     VM_BUG_ON_VMA(!rwsem_is_locked(&vma->lock), vma);
> > +}
> > +
> > +static inline void vma_assert_write_locked(struct vm_area_struct *vma,=
 int pos)
> > +{
> > +     mmap_assert_write_locked(vma->vm_mm);
> > +     /*
> > +      * current task is holding mmap_write_lock, both vma->vm_lock_seq=
 and
> > +      * mm->mm_lock_seq can't be concurrently modified.
> > +      */
> > +     VM_BUG_ON_VMA(vma->vm_lock_seq !=3D READ_ONCE(vma->vm_mm->mm_lock=
_seq), vma);
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> > +
> > +static inline void vma_init_lock(struct vm_area_struct *vma) {}
> > +static inline void vma_mark_locked(struct vm_area_struct *vma) {}
> > +static inline bool vma_read_trylock(struct vm_area_struct *vma)
> > +             { return false; }
> > +static inline void vma_read_unlock(struct vm_area_struct *vma) {}
> > +static inline void vma_assert_locked(struct vm_area_struct *vma) {}
> > +static inline void vma_assert_write_locked(struct vm_area_struct *vma,=
 int pos) {}
> > +
> > +#endif /* CONFIG_PER_VMA_LOCK */
> > +
> >  static inline void vma_init(struct vm_area_struct *vma, struct mm_stru=
ct *mm)
> >  {
> >       static const struct vm_operations_struct dummy_vm_ops =3D {};
> > @@ -619,6 +696,7 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
> >       vma->vm_mm =3D mm;
> >       vma->vm_ops =3D &dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > +     vma_init_lock(vma);
> >  }
> >
> >  static inline void vma_set_anonymous(struct vm_area_struct *vma)
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index bed25ef7c994..6a03f59c1e78 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -486,6 +486,10 @@ struct vm_area_struct {
> >       struct mempolicy *vm_policy;    /* NUMA policy for the VMA */
> >  #endif
> >       struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     struct rw_semaphore lock;
> > +     int vm_lock_seq;
> > +#endif
> >  } __randomize_layout;
> >
> >  struct kioctx_table;
> > @@ -567,6 +571,9 @@ struct mm_struct {
> >                                         * init_mm.mmlist, and are prote=
cted
> >                                         * by mmlist_lock
> >                                         */
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +             int mm_lock_seq;
> > +#endif
> >
> >
> >               unsigned long hiwater_rss; /* High-watermark of RSS usage=
 */
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index e49ba91bb1f0..a391ae226564 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -72,6 +72,17 @@ static inline void mmap_assert_write_locked(struct m=
m_struct *mm)
> >       VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> >  }
> >
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +static inline void vma_mark_unlocked_all(struct mm_struct *mm)
> > +{
> > +     mmap_assert_write_locked(mm);
> > +     /* No races during update due to exclusive mmap_lock being held *=
/
> > +     WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > +}
> > +#else
> > +static inline void vma_mark_unlocked_all(struct mm_struct *mm) {}
> > +#endif
> > +
> >  static inline void mmap_init_lock(struct mm_struct *mm)
> >  {
> >       init_rwsem(&mm->mmap_lock);
> > @@ -114,12 +125,14 @@ static inline bool mmap_write_trylock(struct mm_s=
truct *mm)
> >  static inline void mmap_write_unlock(struct mm_struct *mm)
> >  {
> >       __mmap_lock_trace_released(mm, true);
> > +     vma_mark_unlocked_all(mm);
> >       up_write(&mm->mmap_lock);
> >  }
> >
> >  static inline void mmap_write_downgrade(struct mm_struct *mm)
> >  {
> >       __mmap_lock_trace_acquire_returned(mm, false, true);
> > +     vma_mark_unlocked_all(mm);
> >       downgrade_write(&mm->mmap_lock);
> >  }
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 614872438393..bfab31ecd11e 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -475,6 +475,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_s=
truct *orig)
> >                */
> >               *new =3D data_race(*orig);
> >               INIT_LIST_HEAD(&new->anon_vma_chain);
> > +             vma_init_lock(new);
> >               new->vm_next =3D new->vm_prev =3D NULL;
> >               dup_anon_vma_name(orig, new);
> >       }
> > @@ -1130,6 +1131,9 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >       seqcount_init(&mm->write_protect_seq);
> >       mmap_init_lock(mm);
> >       INIT_LIST_HEAD(&mm->mmlist);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     WRITE_ONCE(mm->mm_lock_seq, 0);
> > +#endif
> >       mm_pgtables_bytes_init(mm);
> >       mm->map_count =3D 0;
> >       mm->locked_vm =3D 0;
> > diff --git a/mm/init-mm.c b/mm/init-mm.c
> > index fbe7844d0912..8399f90d631c 100644
> > --- a/mm/init-mm.c
> > +++ b/mm/init-mm.c
> > @@ -37,6 +37,9 @@ struct mm_struct init_mm =3D {
> >       .page_table_lock =3D  __SPIN_LOCK_UNLOCKED(init_mm.page_table_loc=
k),
> >       .arg_lock       =3D  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
> >       .mmlist         =3D LIST_HEAD_INIT(init_mm.mmlist),
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     .mm_lock_seq    =3D 0,
> > +#endif
> >       .user_ns        =3D &init_user_ns,
> >       .cpu_bitmap     =3D CPU_BITS_NONE,
> >  #ifdef CONFIG_IOMMU_SVA
>
