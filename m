Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675BE4BFDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiBVPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiBVPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:52:42 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2685546AE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:52:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e140so42005833ybh.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bYjmhx1dIEovqTGgIHykW6nX9h6MrPuQINKyLEameI=;
        b=tXSIQUiF/CxevTit9jx3dJc5mHySn1eKhLjN310ZMV/83g/imfmrg+gt9jZUoQMwS3
         nb1d5g1rs+7RUi8CP9RBKAPwXmrViriV0GUEaAFC43VrdNtWNk173Jv/lhdYVqFIkx8+
         d4YobvNpcfZ2c7GG0YRuHhxVlq/SC/XtezFrnwMpgBp+C3tky612yZnExTm9ur7LUB5Z
         GbflCK99dUAZsxQ3rdWhK8dvKnb9gO1AtNLlpxQ+CJ29AzYdYPr4GBWCCJHdkoVJFjUZ
         MXJxJa9xYG6zY1jPgW/c4foBTGTU48QhppB5aXATJ2B+aS+t4cCUoD5D/iX06gCFB3PO
         FA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bYjmhx1dIEovqTGgIHykW6nX9h6MrPuQINKyLEameI=;
        b=XnNBXeWU65vMCICkcgMqmc64upRmDvxoiOfHXkdt1XaZl9NS/EnxcC3qMpsFTt/Iq8
         vfH1SdHbk+Nii6N9S00I3KbJacbsBeOV/CZ2tAyEW7+osNZttgtd4swKnEjhp5Tc0EPB
         A1IaDjZFBxHWxNNMHU7irIhIjcWNE0j0M4+4LJ/E9qmNSDvvblEnDoNKLWM5JgYIosKW
         rkDxvNaWR5gy56rRKKDf0icUxhevC0RbIgwIIfthCt9VitJKai0ch+7cT4m/wRmsqOCs
         PD04AchkTswNDpfm7qi2oZw4fZOwFWid40ihwuLp6/VO1oQuJUxbM/8LBAjXO0NLS0lv
         jO5g==
X-Gm-Message-State: AOAM531duMsH/nDKptP1/rDjpv38NlP6aQkxTDH5Xl/UwIKKJFOBLo8v
        qhtFhxTXzJZPsgqNtd1SvlwroLJexySG5tYT75F2aQ==
X-Google-Smtp-Source: ABdhPJxnmN5p8srp5zSY/jHpCqZC5V1KZbBl2UFdcKwA1gD9+5RFLGe6Uk98IsGPowEZn3WiPgIRuFj3/ipdaDWZG8U=
X-Received: by 2002:a25:2693:0:b0:624:50a8:fee9 with SMTP id
 m141-20020a252693000000b0062450a8fee9mr17019086ybm.348.1645545127624; Tue, 22
 Feb 2022 07:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com> <YhSj/WOM++/9CEA6@dhcp22.suse.cz>
In-Reply-To: <YhSj/WOM++/9CEA6@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Feb 2022 07:51:56 -0800
Message-ID: <CAJuCfpGsDOewHUEK4R11hTxMTh_QE0MPQno2C+E_WMCScTsqcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: refactor vm_area_struct::anon_vma_name usage code
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Tue, Feb 22, 2022 at 12:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 21-02-22 21:40:23, Suren Baghdasaryan wrote:
> > Avoid mixing strings and their anon_vma_name referenced pointers
> > by using struct anon_vma_name whenever possible. This simplifies
> > the code and allows easier sharing of anon_vma_name structures when
> > they represent the same name.
>
> I just diffed this to my half baked proposal to see for changes. Let me
> comment on those as this will be very likely easier to review than
> looking at the new code.

Thanks for the effort!

>
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 17c20597e244..70b619442d56 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -140,61 +140,73 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> >
> >  #ifdef CONFIG_ANON_VMA_NAME
> >  /*
> > - * mmap_lock should be read-locked when calling vma_anon_name() and while using
> > - * the returned pointer.
> > + * mmap_lock should be read-locked when calling vma_anon_name(). Caller should
> > + * either keep holding the lock while using the returned pointer or it should
> > + * raise anon_vma_name refcount before releasing the lock.
> >   */
> > -extern const char *vma_anon_name(struct vm_area_struct *vma);
> > +extern struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma);
>
> OK, I can see some reason to force final users of the name to dig it out
> of the struct but I would recommend unifying the naming. vma_anon_name
> makes sense if you are providing the real name. But for all functions
> which operate on anon_vma_name I would stick with anon_vma_$FOO.
> You seem to be inconsistent in that regards. E.g. dup_vma_anon_name
> but anon_vma_name_{get,put}. I do not really care one way or the other
> but please make then consistent.

Ack. Will change the names the way you suggested.

>
> > +extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
> >
> > -static inline void anon_vma_name_get(struct anon_vma_name *name)
> > +/* mmap_lock should be read-locked */
> > +static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
> >  {
> > -     if (!name)
> > -             return;
> > -
> > -     kref_get(&name->kref);
> > +     if (anon_name)
> > +             kref_get(&anon_name->kref);
> >  }
> >
> > -void vma_anon_name_free(struct kref *kref);
> > -static inline void anon_vma_name_put(struct anon_vma_name *name)
> > -{
> > -     if (!name)
> > -             return;
> > -
> > -     kref_put(&name->kref, vma_anon_name_free);
> > -}
> > +extern void anon_vma_name_put(struct anon_vma_name *anon_name);
>
> I would keep get and put close together. It is just easier to follow the
> code that way. But no strong preference here.

Ack.

>
> > -static inline bool anon_vma_name_eq(struct anon_vma_name *name1, struct anon_vma_name *name2)
> > +static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
>
> dup_anon_vma_name
>
> >  static inline void free_vma_anon_name(struct vm_area_struct *vma)
>
> free_anon_vma_name
>
> >  {
> > -     anon_vma_name_put(vma->anon_name);
> > +     /* Can't use vma_anon_name because vma->vm_mm might not be held */
>
> I do not follow. I guess you meant to say that mmap_lock might not be
> held but why is that important in this context when the vma goes away?
> Nobody can be copying anon_name from it?

I wanted to explain why I can't use vma_anon_name and have to check
vma->vm_file directly instead. vma_anon_name has
mmap_assert_locked(vma->vm_mm) and will generate a warning if called
without mmap_lock being held. I will write a more descriptive comment
here.

>
> > +     if (!vma->vm_file)
> > +             anon_vma_name_put(vma->anon_name);
> >  }
>
> [...]
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f2f8065f67c1..f81d62d8ce9b 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -70,6 +70,9 @@ struct anon_vma_name *anon_vma_name_alloc(const char *name)
> >       struct anon_vma_name *anon_name;
> >       size_t count;
> >
> > +     if (!name)
> > +             return NULL;
> > +
>
> This is not really needed.

True. Will remove.

>
> >       /* Add 1 for NUL terminator at the end of the anon_name->name */
> >       count = strlen(name) + 1;
> >       anon_name = kmalloc(struct_size(anon_name, name, count), GFP_KERNEL);
>
> [...]
> > @@ -947,6 +956,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >  {
> >       int error;
> >       unsigned long new_flags = vma->vm_flags;
> > +     struct anon_vma_name *anon_name;
> >
> >       switch (behavior) {
> >       case MADV_REMOVE:
> > @@ -1011,8 +1021,9 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >               break;
> >       }
> >
> > +     anon_name = vma_anon_name(vma);
> >       error = madvise_update_vma(vma, prev, start, end, new_flags,
> > -                                vma->anon_name);
> > +                                anon_name);
> >
> >  out:
>
> You can use vma_anon_name directly, no need to add 2 more lines of code
> ;)

Ack.

>
> > @@ -1237,8 +1248,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> >       if (end == start)
> >               return 0;
> >
> > -     return madvise_walk_vmas(mm, start, end, (unsigned long)name,
> > -                              madvise_vma_anon_name);
> > +     return  madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
> > +                               madvise_vma_anon_name);
>
> whitespace noise

Ack.

>
> Other that that nothing else really jumped at me. Here is a diff I
> propose on top of this patch. Mostly naming unification and you will get
> 8 less lines in the end ;)

Thanks. Will be incorporated into the next revision.

> ---
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5bfcf24493ac..2c48b1eaaa9c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -327,7 +327,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
>                         goto done;
>                 }
>
> -               anon_name = vma_anon_name(vma);
> +               anon_name = anon_vma_name(vma);
>                 if (anon_name) {
>                         seq_pad(m, ' ');
>                         seq_printf(m, "[anon:%s]", anon_name->name);
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e26b10132d47..8e03b3d3f5fa 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -878,7 +878,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
>                                  new_flags, vma->anon_vma,
>                                  vma->vm_file, vma->vm_pgoff,
>                                  vma_policy(vma),
> -                                NULL_VM_UFFD_CTX, vma_anon_name(vma));
> +                                NULL_VM_UFFD_CTX, anon_vma_name(vma));
>                 if (prev)
>                         vma = prev;
>                 else
> @@ -1438,7 +1438,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>                                  vma->anon_vma, vma->vm_file, vma->vm_pgoff,
>                                  vma_policy(vma),
>                                  ((struct vm_userfaultfd_ctx){ ctx }),
> -                                vma_anon_name(vma));
> +                                anon_vma_name(vma));
>                 if (prev) {
>                         vma = prev;
>                         goto next;
> @@ -1615,7 +1615,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>                 prev = vma_merge(mm, prev, start, vma_end, new_flags,
>                                  vma->anon_vma, vma->vm_file, vma->vm_pgoff,
>                                  vma_policy(vma),
> -                                NULL_VM_UFFD_CTX, vma_anon_name(vma));
> +                                NULL_VM_UFFD_CTX, anon_vma_name(vma));
>                 if (prev) {
>                         vma = prev;
>                         goto next;
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 70b619442d56..60b48e4a5560 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -140,11 +140,11 @@ static __always_inline void del_page_from_lru_list(struct page *page,
>
>  #ifdef CONFIG_ANON_VMA_NAME
>  /*
> - * mmap_lock should be read-locked when calling vma_anon_name(). Caller should
> + * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
>   * either keep holding the lock while using the returned pointer or it should
>   * raise anon_vma_name refcount before releasing the lock.
>   */
> -extern struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma);
> +extern struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
>  extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
>
>  /* mmap_lock should be read-locked */
> @@ -156,10 +156,10 @@ static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
>
>  extern void anon_vma_name_put(struct anon_vma_name *anon_name);
>
> -static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> +static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
>                                      struct vm_area_struct *new_vma)
>  {
> -       struct anon_vma_name *anon_name = vma_anon_name(orig_vma);
> +       struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
>
>         if (anon_name) {
>                 anon_vma_name_get(anon_name);
> @@ -167,7 +167,7 @@ static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
>         }
>  }
>
> -static inline void free_vma_anon_name(struct vm_area_struct *vma)
> +static inline void free_anon_vma_name(struct vm_area_struct *vma)
>  {
>         /* Can't use vma_anon_name because vma->vm_mm might not be held */
>         if (!vma->vm_file)
> @@ -185,7 +185,7 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
>  }
>
>  #else /* CONFIG_ANON_VMA_NAME */
> -static inline struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma)
> +static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
>         return NULL;
>  }
> @@ -197,9 +197,9 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
>
>  static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
>  static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
> -static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
> +static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
>                                      struct vm_area_struct *new_vma) {}
> -static inline void free_vma_anon_name(struct vm_area_struct *vma) {}
> +static inline void free_anon_vma_name(struct vm_area_struct *vma) {}
>
>  static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
>                                     struct anon_vma_name *anon_name2)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d75a528f7b21..e7dc5c29212c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -366,14 +366,14 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>                 *new = data_race(*orig);
>                 INIT_LIST_HEAD(&new->anon_vma_chain);
>                 new->vm_next = new->vm_prev = NULL;
> -               dup_vma_anon_name(orig, new);
> +               dup_anon_vma_name(orig, new);
>         }
>         return new;
>  }
>
>  void vm_area_free(struct vm_area_struct *vma)
>  {
> -       free_vma_anon_name(vma);
> +       free_anon_vma_name(vma);
>         kmem_cache_free(vm_area_cachep, vma);
>  }
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 60c3f9eac9eb..c150aa335eeb 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2279,7 +2279,7 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
>  {
>         struct mm_struct *mm = current->mm;
>         const char __user *uname;
> -       struct anon_vma_name *anon_name;
> +       struct anon_vma_name *anon_name = NULL;
>         int error;
>
>         switch (opt) {
> @@ -2304,9 +2304,6 @@ static int prctl_set_vma(unsigned long opt, unsigned long addr,
>                         if (!anon_name)
>                                 return -ENOMEM;
>
> -               } else {
> -                       /* Reset the name */
> -                       anon_name = NULL;
>                 }
>
>                 mmap_write_lock(mm);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f81d62d8ce9b..f23c66d15bd5 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -70,9 +70,6 @@ struct anon_vma_name *anon_vma_name_alloc(const char *name)
>         struct anon_vma_name *anon_name;
>         size_t count;
>
> -       if (!name)
> -               return NULL;
> -
>         /* Add 1 for NUL terminator at the end of the anon_name->name */
>         count = strlen(name) + 1;
>         anon_name = kmalloc(struct_size(anon_name, name, count), GFP_KERNEL);
> @@ -84,7 +81,7 @@ struct anon_vma_name *anon_vma_name_alloc(const char *name)
>         return anon_name;
>  }
>
> -struct anon_vma_name *vma_anon_name(struct vm_area_struct *vma)
> +struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
>         mmap_assert_locked(vma->vm_mm);
>
> @@ -108,10 +105,10 @@ void anon_vma_name_put(struct anon_vma_name *anon_name)
>  }
>
>  /* mmap_lock should be write-locked */
> -static int replace_vma_anon_name(struct vm_area_struct *vma,
> +static int replace_anon_vma_name(struct vm_area_struct *vma,
>                                  struct anon_vma_name *anon_name)
>  {
> -       struct anon_vma_name *orig_name = vma_anon_name(vma);
> +       struct anon_vma_name *orig_name = anon_vma_name(vma);
>
>         if (!anon_name) {
>                 vma->anon_name = NULL;
> @@ -129,7 +126,7 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
>         return 0;
>  }
>  #else /* CONFIG_ANON_VMA_NAME */
> -static int replace_vma_anon_name(struct vm_area_struct *vma,
> +static int replace_anon_vma_name(struct vm_area_struct *vma,
>                                  struct anon_vma_name *anon_name)
>  {
>         if (anon_name)
> @@ -151,7 +148,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>         int error;
>         pgoff_t pgoff;
>
> -       if (new_flags == vma->vm_flags && anon_vma_name_eq(vma_anon_name(vma), anon_name)) {
> +       if (new_flags == vma->vm_flags && anon_vma_name_eq(anon_vma_name(vma), anon_name)) {
>                 *prev = vma;
>                 return 0;
>         }
> @@ -189,7 +186,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
>          */
>         vma->vm_flags = new_flags;
>         if (!vma->vm_file) {
> -               error = replace_vma_anon_name(vma, anon_name);
> +               error = replace_anon_vma_name(vma, anon_name);
>                 if (error)
>                         return error;
>         }
> @@ -956,7 +953,6 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>  {
>         int error;
>         unsigned long new_flags = vma->vm_flags;
> -       struct anon_vma_name *anon_name;
>
>         switch (behavior) {
>         case MADV_REMOVE:
> @@ -1021,9 +1017,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>                 break;
>         }
>
> -       anon_name = vma_anon_name(vma);
>         error = madvise_update_vma(vma, prev, start, end, new_flags,
> -                                  anon_name);
> +                                  anon_vma_name(vma));
>
>  out:
>         /*
> @@ -1248,8 +1243,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
>         if (end == start)
>                 return 0;
>
> -       return  madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
> -                                 madvise_vma_anon_name);
> +       return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
> +                                madvise_vma_anon_name);
>  }
>  #endif /* CONFIG_ANON_VMA_NAME */
>  /*
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 028e8dd82b44..69284d3b5e53 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -814,7 +814,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
>                 prev = vma_merge(mm, prev, vmstart, vmend, vma->vm_flags,
>                                  vma->anon_vma, vma->vm_file, pgoff,
>                                  new_pol, vma->vm_userfaultfd_ctx,
> -                                vma_anon_name(vma));
> +                                anon_vma_name(vma));
>                 if (prev) {
>                         vma = prev;
>                         next = vma->vm_next;
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 8f584eddd305..25934e7db3e1 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -512,7 +512,7 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
>         pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>         *prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
>                           vma->vm_file, pgoff, vma_policy(vma),
> -                         vma->vm_userfaultfd_ctx, vma_anon_name(vma));
> +                         vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>         if (*prev) {
>                 vma = *prev;
>                 goto success;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 80d2ae204a98..ad6a1fffee91 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1049,7 +1049,7 @@ static inline int is_mergeable_vma(struct vm_area_struct *vma,
>                 return 0;
>         if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
>                 return 0;
> -       if (!anon_vma_name_eq(vma_anon_name(vma), anon_name))
> +       if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
>                 return 0;
>         return 1;
>  }
> @@ -3255,7 +3255,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>                 return NULL;    /* should never get here */
>         new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
>                             vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -                           vma->vm_userfaultfd_ctx, vma_anon_name(vma));
> +                           vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>         if (new_vma) {
>                 /*
>                  * Source vma may have been merged into new_vma
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0138dfcdb1d8..9fce6860cdab 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -464,7 +464,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
>         pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
>         *pprev = vma_merge(mm, *pprev, start, end, newflags,
>                            vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -                          vma->vm_userfaultfd_ctx, vma_anon_name(vma));
> +                          vma->vm_userfaultfd_ctx, anon_vma_name(vma));
>         if (*pprev) {
>                 vma = *pprev;
>                 VM_WARN_ON((vma->vm_flags ^ newflags) & ~VM_SOFTDIRTY);
> --
> Michal Hocko
> SUSE Labs
