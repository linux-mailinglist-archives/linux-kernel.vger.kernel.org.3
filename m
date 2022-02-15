Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1504B776E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbiBORhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:37:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiBORg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:36:59 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E708A377CB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:36:48 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id p19so58293257ybc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrR5WCAO0CRZ2vCEx1r3Ybu82+2jAjXxVmd/1/6WZlM=;
        b=H5fPtKTJb8vweJOAGRFdVZaPvwFvRMsFttoSvX4Z8BKvU8jX2SOBuLuer4V/BiUfzu
         XAX6CxwSRtbdu2rCDS0SYuZRw2VxdsHuTSofEZnTRiVC9eH6H4rK1qNEDZKZlimhbQYu
         6nm0eTSpg0X/uzr2HSlamyiGClz2kGlfSCct8MwLzca0OJbmIk7PiXL2sDRYAqgeG5Kk
         iQlohqwUpJhyat0GuKMwShR2cEu5ZDwHqBPrEAhJwCAxTAO7aSor6IYHsd/jEuGPQPMM
         kFQTWgAa2tJ9c+XqwgLdYpkJYUnJy6V+n05SJ0ZK+2oKpXhcHIkASOxJIxBEOXSnf/Cx
         ZHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrR5WCAO0CRZ2vCEx1r3Ybu82+2jAjXxVmd/1/6WZlM=;
        b=wm2zeqfFm5PBKgBF4bcrBHJvnHF+Luc09z1ywfyKZjsim+SZmGD0+PsOZIsTFY7qD3
         4qvJJHNXCX+BGv7dIFcSR+ApGRvnzn0x3TWWLdM4KJmiPTmIigtUGVc0p+W3CUCAnqB0
         Wlcw8S0pGOr0m+emBvYy+NxYrY2h0Rwe5ofohwiblVnaqedejxWBJ9ap89Rd36itQJ+M
         Y9giGntOTJJGwt50gXARIMF97AIHKO293HrXdaBIoFrOtWhM7Aek0p2LQVTngTLHzx7U
         SC9s4DsW++w8tpBgOHXVdW+V3XV6ra/R5xBCZi3vzDqBaeH40qMXaTjlrzumZXosvs4a
         Qu8g==
X-Gm-Message-State: AOAM531SWbuADKvaXb9bDCxuc0e97R8+8FRi2NbILkiPJNpkUdoy2GlS
        6NiaP81avCQQQTcSjeXTHMo0rLLplLqv5oWy+YMjbA==
X-Google-Smtp-Source: ABdhPJyeC9nF/2ZyabtOCf8T+GUz/M1bWzwydQyVx6U1wGUShjW0Uobq/2B9smXUTchlpuA+p/CwPvJIVX1rRm3VJa8=
X-Received: by 2002:a25:d212:: with SMTP id j18mr3380032ybg.243.1644946607476;
 Tue, 15 Feb 2022 09:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20220211013032.623763-1-surenb@google.com> <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
In-Reply-To: <YgvONKdZ2T0PB2/0@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 15 Feb 2022 09:36:36 -0800
Message-ID: <CAJuCfpGrJFeZ06_h6n-UpBTbnvoK=6p3Uv4Ly=9mjWKgowYY+g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] mm: fix use-after-free when anon vma name is used
 after vma is freed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>, legion@kernel.org,
        ran.xiaokai@zte.com.cn, sashal@kernel.org,
        Chris Hyser <chris.hyser@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Collingbourne <pcc@google.com>, caoxiaofeng@yulong.com,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

On Tue, Feb 15, 2022 at 8:00 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 10-02-22 17:30:32, Suren Baghdasaryan wrote:
> [...]
> > +struct anon_vma_name *vma_anon_name_get(struct vm_area_struct *vma)
> > +{
> > +     if (!has_vma_anon_name(vma))
> > +             return NULL;
> > +
> > +     mmap_assert_locked(vma->vm_mm);
> > +
> > +     kref_get(&vma->anon_name->kref);
> > +     return vma->anon_name;
> > +}
> > +
> > +void vma_anon_name_put(struct anon_vma_name *anon_name)
> > +{
> > +     if (anon_name)
> > +             kref_put(&anon_name->kref, vma_anon_name_free);
> > +}
> > +
> >  void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> >                      struct vm_area_struct *new_vma)
> >  {
> > @@ -126,33 +146,34 @@ void free_vma_anon_name(struct vm_area_struct *vma)
> >  }
> >
> >  /* mmap_lock should be write-locked */
> > -static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> > +static int replace_vma_anon_name(struct vm_area_struct *vma,
> > +                              struct anon_vma_name *anon_name)
> >  {
> > -     const char *anon_name;
> > +     const char *orig_name;
> >
> > -     if (!name) {
> > +     if (!anon_name) {
> >               free_vma_anon_name(vma);
> >               return 0;
> >       }
> >
> > -     anon_name = vma_anon_name(vma);
> > -     if (anon_name) {
> > +     orig_name = vma_anon_name(vma);
> > +     if (orig_name) {
> >               /* Same name, nothing to do here */
> > -             if (!strcmp(name, anon_name))
> > +             if (!strcmp(anon_name->name, orig_name))
> >                       return 0;
> >
> >               free_vma_anon_name(vma);
> >       }
> > -     vma->anon_name = anon_vma_name_alloc(name);
> > -     if (!vma->anon_name)
> > -             return -ENOMEM;
> > +     kref_get(&anon_name->kref);
> > +     vma->anon_name = anon_name;
>
> I really have to say that this is still confusing and potentially error
> prone. I haven't really dived deeply in the early break out from strcmp
> because I find your mixing strings and their referenced pointers rather
> confusing in principle. I still do not see why you are avoiding a
> relatively straighforward pattern.
>
> All you need is a shared pointer for your string and share
> it as much as possible, no? Sharing means that you elevate the reference
> counter whenever you assign to a vma and unshare when you are replacing
> the shared pointer by a different one or when vma is freed. In other
> words something like the following (pls note I have only compile tested
> it and it very likely needs tweaks here and there I just wanted to point
> the idea):

Thanks for looking into this! Let me digest the proposal and will get
back with questions or a refactoring patch.

>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 213cc569b192..689971696864 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2626,7 +2626,7 @@ static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  extern struct vm_area_struct *vma_merge(struct mm_struct *,
>         struct vm_area_struct *prev, unsigned long addr, unsigned long end,
>         unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
> -       struct mempolicy *, struct vm_userfaultfd_ctx, const char *);
> +       struct mempolicy *, struct vm_userfaultfd_ctx, struct anon_vma_name *);
>  extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
>  extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
>         unsigned long addr, int new_below);
> @@ -3372,11 +3372,11 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
>
>  #ifdef CONFIG_ANON_VMA_NAME
>  int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> -                         unsigned long len_in, const char *name);
> +                         unsigned long len_in, struct anon_vma_name *name);
>  #else
>  static inline int
>  madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> -                     unsigned long len_in, const char *name) {
> +                     unsigned long len_in, struct anon_vma_name *name) {
>         return 0;
>  }
>  #endif
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index b725839dfe71..cff619f762d0 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -145,45 +145,48 @@ static __always_inline void del_page_from_lru_list(struct page *page,
>   */
>  extern const char *vma_anon_name(struct vm_area_struct *vma);
>
> -/*
> - * mmap_lock should be read-locked for orig_vma->vm_mm.
> - * mmap_lock should be write-locked for new_vma->vm_mm or new_vma should be
> - * isolated.
> - */
> -extern void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> -                             struct vm_area_struct *new_vma);
> +static inline void anon_vma_name_get(struct anon_vma_name *name)
> +{
> +       if (!name)
> +               return;
>
> -/*
> - * mmap_lock should be write-locked or vma should have been isolated under
> - * write-locked mmap_lock protection.
> - */
> -extern void free_vma_anon_name(struct vm_area_struct *vma);
> +       kref_get(&name->kref);
> +}
>
> -/* mmap_lock should be read-locked */
> -static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
> -                                        const char *name)
> +void vma_anon_name_free(struct kref *kref);
> +static inline void anon_vma_name_put(struct anon_vma_name *name)
>  {
> -       const char *vma_name = vma_anon_name(vma);
> +       if (!name)
> +               return;
>
> -       /* either both NULL, or pointers to same string */
> -       if (vma_name == name)
> +       kref_put(&name->kref, vma_anon_name_free);
> +}
> +
> +static inline bool anon_vma_name_eq(struct anon_vma_name *name1, struct anon_vma_name *name2)
> +{
> +       if (name1 == name2)
>                 return true;
>
> -       return name && vma_name && !strcmp(name, vma_name);
> +       return name1 && name2 && !strcmp(name1->name, name2->name);
> +}
> +
> +static inline void free_vma_anon_name(struct vm_area_struct *vma)
> +{
> +       anon_vma_name_put(vma->anon_name);
>  }
> +
>  #else /* CONFIG_ANON_VMA_NAME */
>  static inline const char *vma_anon_name(struct vm_area_struct *vma)
>  {
>         return NULL;
>  }
> -static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> -                             struct vm_area_struct *new_vma) {}
> -static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
> -static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
> -                                        const char *name)
> +static inline bool anon_vma_name_eq(struct anon_vma_name *name1, struct anon_vma_name *name2)
>  {
>         return true;
>  }
> +static inline void free_vma_anon_name(struct vm_area_struct *vma)
> +{
> +}
>  #endif  /* CONFIG_ANON_VMA_NAME */
>
>  static inline void init_tlb_flush_pending(struct mm_struct *mm)
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ecc4cf019242..662a0c8b4ceb 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2278,7 +2278,8 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
>  {
>         struct mm_struct *mm = current->mm;
>         const char __user *uname;
> -       char *name, *pch;
> +       char *uname, *pch;
> +       struct anon_vma_name *vma_name = NULL;
>         int error;
>
>         switch (opt) {
> @@ -2296,15 +2297,17 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
>                                         return -EINVAL;
>                                 }
>                         }
> -               } else {
> -                       /* Reset the name */
> -                       name = NULL;
> +
> +                       /* anon_vma has its own copy */
> +                       vma_name = anon_vma_name_alloc(name);
> +                       kfree(name);
> +                       if (!vma_name)
> +                               return PTR_ERR(vma_name);
>                 }
>
>                 mmap_write_lock(mm);
> -               error = madvise_set_anon_name(mm, addr, size, name);
> +               error = madvise_set_anon_name(mm, addr, size, vma_name);
>                 mmap_write_unlock(mm);
> -               kfree(name);
>                 break;
>         default:
>                 error = -EINVAL;
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 5604064df464..f2f8065f67c1 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -65,7 +65,7 @@ static int madvise_need_mmap_write(int behavior)
>  }
>
>  #ifdef CONFIG_ANON_VMA_NAME
> -static struct anon_vma_name *anon_vma_name_alloc(const char *name)
> +struct anon_vma_name *anon_vma_name_alloc(const char *name)
>  {
>         struct anon_vma_name *anon_name;
>         size_t count;
> @@ -81,7 +81,7 @@ static struct anon_vma_name *anon_vma_name_alloc(const char *name)
>         return anon_name;
>  }
>
> -static void vma_anon_name_free(struct kref *kref)
> +void vma_anon_name_free(struct kref *kref)
>  {
>         struct anon_vma_name *anon_name =
>                         container_of(kref, struct anon_vma_name, kref);
> @@ -103,54 +103,25 @@ const char *vma_anon_name(struct vm_area_struct *vma)
>         return vma->anon_name->name;
>  }
>
> -void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> -                      struct vm_area_struct *new_vma)
> -{
> -       if (!has_vma_anon_name(orig_vma))
> -               return;
> -
> -       kref_get(&orig_vma->anon_name->kref);
> -       new_vma->anon_name = orig_vma->anon_name;
> -}
> -
> -void free_vma_anon_name(struct vm_area_struct *vma)
> -{
> -       struct anon_vma_name *anon_name;
> -
> -       if (!has_vma_anon_name(vma))
> -               return;
> -
> -       anon_name = vma->anon_name;
> -       vma->anon_name = NULL;
> -       kref_put(&anon_name->kref, vma_anon_name_free);
> -}
> -
>  /* mmap_lock should be write-locked */
> -static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> +static int replace_vma_anon_name(struct vm_area_struct *vma, struct anon_vma_name *name)
>  {
> -       const char *anon_name;
> -
>         if (!name) {
> -               free_vma_anon_name(vma);
> +               anon_vma_name_put(vma->anon_name);
> +               vma->anon_name = NULL;
>                 return 0;
>         }
>
> -       anon_name = vma_anon_name(vma);
> -       if (anon_name) {
> -               /* Same name, nothing to do here */
> -               if (!strcmp(name, anon_name))
> -                       return 0;
> -
> -               free_vma_anon_name(vma);
> -       }
> -       vma->anon_name = anon_vma_name_alloc(name);
> -       if (!vma->anon_name)
> -               return -ENOMEM;
> +       if (anon_vma_name_eq(vma->anon_name, name))
> +               return 0;
>
> +       anon_vma_name_put(vma->anon_name);
> +       anon_vma_name_get(name);
> +       vma->anon_name = name;
>         return 0;
>  }
>  #else /* CONFIG_ANON_VMA_NAME */
> -static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
> +static int replace_vma_anon_name(struct vm_area_struct *vma, struct anon_vma_name *name)
>  {
>         if (name)
>                 return -EINVAL;
> @@ -165,13 +136,13 @@ static int replace_vma_anon_name(struct vm_area_struct *vma, const char *name)
>  static int madvise_update_vma(struct vm_area_struct *vma,
>                               struct vm_area_struct **prev, unsigned long start,
>                               unsigned long end, unsigned long new_flags,
> -                             const char *name)
> +                             struct anon_vma_name *name)
>  {
>         struct mm_struct *mm = vma->vm_mm;
>         int error;
>         pgoff_t pgoff;
>
> -       if (new_flags == vma->vm_flags && is_same_vma_anon_name(vma, name)) {
> +       if (new_flags == vma->vm_flags && anon_vma_name_eq(vma->anon_name, name)) {
>                 *prev = vma;
>                 return 0;
>         }
> @@ -1041,7 +1012,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>         }
>
>         error = madvise_update_vma(vma, prev, start, end, new_flags,
> -                                  vma_anon_name(vma));
> +                                  vma->anon_name);
>
>  out:
>         /*
> @@ -1234,7 +1205,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
>                 return -EBADF;
>
>         error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
> -                                  (const char *)name);
> +                                  (struct anon_vma_name *)name);
>
>         /*
>          * madvise() returns EAGAIN if kernel resources, such as
> @@ -1246,7 +1217,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
>  }
>
>  int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> -                         unsigned long len_in, const char *name)
> +                         unsigned long len_in, struct anon_vma_name *name)
>  {
>         unsigned long end;
>         unsigned long len;
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 8f584eddd305..e992755e8ffb 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -512,7 +512,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>         pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>         *prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
>                           vma->vm_file, pgoff, vma_policy(vma),
> -                         vma->vm_userfaultfd_ctx, vma_anon_name(vma));
> +                         vma->vm_userfaultfd_ctx, vma->anon_name);
>         if (*prev) {
>                 vma = *prev;
>                 goto success;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1e8fdb0b51ed..c3b2e73d9c9a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1031,7 +1031,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  static inline int is_mergeable_vma(struct vm_area_struct *vma,
>                                 struct file *file, unsigned long vm_flags,
>                                 struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -                               const char *anon_name)
> +                               struct anon_vma_name *anon_name)
>  {
>         /*
>          * VM_SOFTDIRTY should not prevent from VMA merging, if we
> @@ -1049,7 +1049,7 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
>                 return 0;
>         if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
>                 return 0;
> -       if (!is_same_vma_anon_name(vma, anon_name))
> +       if (!anon_vma_name_eq(vma->anon_name, anon_name))
>                 return 0;
>         return 1;
>  }
> @@ -1084,7 +1084,7 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
>                      struct anon_vma *anon_vma, struct file *file,
>                      pgoff_t vm_pgoff,
>                      struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -                    const char *anon_name)
> +                    struct anon_vma_name *anon_name)
>  {
>         if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
>             is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> @@ -1106,7 +1106,7 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>                     struct anon_vma *anon_vma, struct file *file,
>                     pgoff_t vm_pgoff,
>                     struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -                   const char *anon_name)
> +                   struct anon_vma_name *anon_name)
>  {
>         if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name) &&
>             is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> @@ -1167,7 +1167,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>                         struct anon_vma *anon_vma, struct file *file,
>                         pgoff_t pgoff, struct mempolicy *policy,
>                         struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -                       const char *anon_name)
> +                       struct anon_vma_name *anon_name)
>  {
>         pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>         struct vm_area_struct *area, *next;
> @@ -3255,7 +3255,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>                 return NULL;    /* should never get here */
>         new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
>                             vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -                           vma->vm_userfaultfd_ctx, vma_anon_name(vma));
> +                           vma->vm_userfaultfd_ctx, vma->anon_name);
>         if (new_vma) {
>                 /*
>                  * Source vma may have been merged into new_vma
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0138dfcdb1d8..dae529d24fa3 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -464,7 +464,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>         pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>         *pprev = vma_merge(mm, *pprev, start, end, newflags,
>                            vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -                          vma->vm_userfaultfd_ctx, vma_anon_name(vma));
> +                          vma->vm_userfaultfd_ctx, vma->anon_name);
>         if (*pprev) {
>                 vma = *pprev;
>                 VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
> --
> Michal Hocko
> SUSE Labs
