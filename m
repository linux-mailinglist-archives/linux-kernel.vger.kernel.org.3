Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732094C3C68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiBYDZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiBYDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:25:36 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B621F768C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:25:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x5so5558723edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m000wI7i2UmGdWbDCZ4p5lg5I3VWqDOEyB+1KtY/uQ0=;
        b=nxvEPT/oqTauPakx5v9D5whwO1QnmkZSsFCLNBYFPpMwmJ5CMBCz/mQKMHYbjN3YyS
         Vj9XswIqA0IxH80aCO0mxn15C38McK4WqIhoVOJcIuOA0jy2mXeA4+GPV1vg1gRUr4au
         9lB2nkWdHrJ3HNCSpUawZQbkgusW7JIjFlnSeD/DToOzZV6ltKiJgxBM2645NlkU8Bzh
         2H67MkkAx2lGVm+sqlb5/q+TRXFWS54fTz8G73zN/qgF2dYBjR32rntrFu7juV044aW6
         Pt6CGMIAHchrGyhk5SiE8vDhWK1TsMUIA43196CvJyZp7S+MgvJwFUWc4lELT5vn9vF3
         ndzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m000wI7i2UmGdWbDCZ4p5lg5I3VWqDOEyB+1KtY/uQ0=;
        b=sq3x4FGYB/qNyhECBSV1wSsy7n8umAxQuizzzOK7IIy/bY0V/PoNdRXxfvrNo7+WU5
         iVtPEGVExXqxzVfsa3XXLY84XjTg0j4B0CL6gYJrRREOCUeb+ey6l3ahus2TQnfFumNu
         TBUC81ECsBz9Euh2Y0zONQLDDfUiIFn+OGtXYYSnAWuNT8IkQI/llrOb3c8a2TaLDnYL
         Zeg/Xh6EitqmFPTqk85iYsT7hdLhX3NmMNhn/ysDo/S5g1/g+tKTCRiaEtlVMLAWRweX
         Tf28M2T0xbb35MiBicvcYAPC50eg1H/zIPE0e/jrRw0tvwrMvPi+nminmb/A32OV1Wyh
         tzxw==
X-Gm-Message-State: AOAM530fNPrEJ5Qw9RzcMYWJ4wTvT7AOsKMLsYCqScVA6wrwb0GSAOKy
        yzKfduB7hEIXKWB6Q0E24rOMrniwKF+6hWvQFXo=
X-Google-Smtp-Source: ABdhPJyK+0BX25raVzvyJ6tLNMJy54pc7zF4B6akoP7PY9iaU6+1T0cxKdKsd4yMP/lxhbBCQvMqTZ+69nbQXDg60Rc=
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id
 v7-20020a056402348700b0040ffa53956cmr5117388edc.22.1645759503221; Thu, 24 Feb
 2022 19:25:03 -0800 (PST)
MIME-Version: 1.0
References: <20210514093007.4117906-1-linmiaohe@huawei.com>
 <00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz> <CAHbLzko+Hicj30VhMbNqB8da2paWdcL=YKJ5E=ESfmtraNCqRQ@mail.gmail.com>
 <CAHbLzkqtOa61w4CQEXPsVa_JiUvMji9PdVF1BA_XW6LJ4RA_iw@mail.gmail.com> <2ec38e11-0158-5342-d229-de02f7772f3f@huawei.com>
In-Reply-To: <2ec38e11-0158-5342-d229-de02f7772f3f@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 24 Feb 2022 19:24:51 -0800
Message-ID: <CAHbLzkpfN+4uN6za=it4oXWU1ySKMKad3mXMqdcuTVWyyXpSPA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/huge_memory.c: add missing read-only THP checking
 in transparent_hugepage_enabled()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 6:38 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/2/25 5:56, Yang Shi wrote:
> > On Thu, Feb 24, 2022 at 1:29 PM Yang Shi <shy828301@gmail.com> wrote:
> >>
> >> On Thu, Feb 24, 2022 at 10:51 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>>
> >>> On 5/14/21 11:30, Miaohe Lin wrote:
> >>>> Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
> >>>> (non-shmem) FS"), read-only THP file mapping is supported. But it
> >>>> forgot to add checking for it in transparent_hugepage_enabled().
> >>>> To fix it, we add checking for read-only THP file mapping and also
> >>>> introduce helper transhuge_vma_enabled() to check whether thp is
> >>>> enabled for specified vma to reduce duplicated code. We rename
> >>>> transparent_hugepage_enabled to transparent_hugepage_active to make
> >>>> the code easier to follow as suggested by David Hildenbrand.
> >>>>
> >>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
> >>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>
> >>> FYI, I stumbled upon needing this for my reproducer for the read()
> >>> corruption [1] to work, and I think it's still not ideal. I also needed
> >>> madvise(MADV_HUGEPAGE) for the executable file mapping to make sure
> >>> khugepaged acts on my process. Yeah, commit 99cb0dbd47a1 suggests madvise.
> >>> Yet, khugepaged will happily collapse file mappings even without madvise
> >>> anyway. However, it might not know about the mm at all unless
> >>> __khugepaged_enter() has been applied at least on one of its vma's.
> >>> madvise() is one way to do it for executable file mappings, but it can also
> >>> happen through e.g. do_huge_pmd_anonymous_page() on another mapping, which
> >>> has nothing to do with the file mapping.
> >>> So what I'm trying to say is that we are somewhat inconsistent - the rules
> >>> to consider a vma in khugepaged seem to be clear and result of admin
> >>> configuration and madvise, but the rules to consider a mm for khugepaged
> >>> (which is the only way to collapse file mappings) are not completely
> >>> identical and there might be "random luck" involved.
> >>
> >> Yes, khugepaged_enter() is not called for file vma explicitly. My wild
> >> guess is THP for readonly fs was assumed to be collapsed by explicit
> >> demand from the users, for example, madvise.
> >>
> >> To achieve more consistent behavior we could call khugepaged_enter()
> >> for file fault just like what huge anonymous fault does. Of course we
> >> need to fix khugepaged_enter() to do the proper check as well.
> >
> > Or we could follow shmem's implementation to call khugepaged_enter()
> > in .mmap method for each filesystem so that khugepaged_enter() doesn't
> > have to be called for each filemap_fault(). Luckily most filesystems
> > use generic_file_mmap().
> >
>
> I think I get the point. We need to fix the inconsistent behavior between file
> vma and anon vma where khugepaged_enter() is only called for anon vma explicitly.
> Am I supposed to do this or Yang Shi would kindly help do this ?

I will take care of it. I have been working on a prototype.

>
> Many thanks both of you. :)
>
> >>
> >>>
> >>> [1] https://lore.kernel.org/all/df3b5d1c-a36b-2c73-3e27-99e74983de3a@suse.cz/
> >>>
> >>>> ---
> >>>> v3->v4:
> >>>>   collect Reviewed-by tag
> >>>>   define transhuge_vma_enabled next to transhuge_vma_suitable
> >>>> ---
> >>>>  fs/proc/task_mmu.c      |  2 +-
> >>>>  include/linux/huge_mm.h | 57 +++++++++++++++++++++++++----------------
> >>>>  mm/huge_memory.c        | 11 +++++++-
> >>>>  mm/khugepaged.c         |  4 +--
> >>>>  mm/shmem.c              |  3 +--
> >>>>  5 files changed, 48 insertions(+), 29 deletions(-)
> >>>>
> >>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>>> index fc9784544b24..7389df326edd 100644
> >>>> --- a/fs/proc/task_mmu.c
> >>>> +++ b/fs/proc/task_mmu.c
> >>>> @@ -832,7 +832,7 @@ static int show_smap(struct seq_file *m, void *v)
> >>>>       __show_smap(m, &mss, false);
> >>>>
> >>>>       seq_printf(m, "THPeligible:    %d\n",
> >>>> -                transparent_hugepage_enabled(vma));
> >>>> +                transparent_hugepage_active(vma));
> >>>>
> >>>>       if (arch_pkeys_enabled())
> >>>>               seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index 0a526f211fec..7b7f7b52ccb8 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -115,9 +115,34 @@ extern struct kobj_attribute shmem_enabled_attr;
> >>>>
> >>>>  extern unsigned long transparent_hugepage_flags;
> >>>>
> >>>> +static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >>>> +             unsigned long haddr)
> >>>> +{
> >>>> +     /* Don't have to check pgoff for anonymous vma */
> >>>> +     if (!vma_is_anonymous(vma)) {
> >>>> +             if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> >>>> +                             HPAGE_PMD_NR))
> >>>> +                     return false;
> >>>> +     }
> >>>> +
> >>>> +     if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> >>>> +             return false;
> >>>> +     return true;
> >>>> +}
> >>>> +
> >>>> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> >>>> +                                       unsigned long vm_flags)
> >>>> +{
> >>>> +     /* Explicitly disabled through madvise. */
> >>>> +     if ((vm_flags & VM_NOHUGEPAGE) ||
> >>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> >>>> +             return false;
> >>>> +     return true;
> >>>> +}
> >>>> +
> >>>>  /*
> >>>>   * to be used on vmas which are known to support THP.
> >>>> - * Use transparent_hugepage_enabled otherwise
> >>>> + * Use transparent_hugepage_active otherwise
> >>>>   */
> >>>>  static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>>  {
> >>>> @@ -128,15 +153,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>>       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> >>>>               return false;
> >>>>
> >>>> -     if (vma->vm_flags & VM_NOHUGEPAGE)
> >>>> +     if (!transhuge_vma_enabled(vma, vma->vm_flags))
> >>>>               return false;
> >>>>
> >>>>       if (vma_is_temporary_stack(vma))
> >>>>               return false;
> >>>>
> >>>> -     if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> >>>> -             return false;
> >>>> -
> >>>>       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> >>>>               return true;
> >>>>
> >>>> @@ -150,22 +172,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>>       return false;
> >>>>  }
> >>>>
> >>>> -bool transparent_hugepage_enabled(struct vm_area_struct *vma);
> >>>> -
> >>>> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >>>> -             unsigned long haddr)
> >>>> -{
> >>>> -     /* Don't have to check pgoff for anonymous vma */
> >>>> -     if (!vma_is_anonymous(vma)) {
> >>>> -             if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
> >>>> -                             HPAGE_PMD_NR))
> >>>> -                     return false;
> >>>> -     }
> >>>> -
> >>>> -     if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
> >>>> -             return false;
> >>>> -     return true;
> >>>> -}
> >>>> +bool transparent_hugepage_active(struct vm_area_struct *vma);
> >>>>
> >>>>  #define transparent_hugepage_use_zero_page()                         \
> >>>>       (transparent_hugepage_flags &                                   \
> >>>> @@ -351,7 +358,7 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>>       return false;
> >>>>  }
> >>>>
> >>>> -static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>> +static inline bool transparent_hugepage_active(struct vm_area_struct *vma)
> >>>>  {
> >>>>       return false;
> >>>>  }
> >>>> @@ -362,6 +369,12 @@ static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
> >>>>       return false;
> >>>>  }
> >>>>
> >>>> +static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> >>>> +                                       unsigned long vm_flags)
> >>>> +{
> >>>> +     return false;
> >>>> +}
> >>>> +
> >>>>  static inline void prep_transhuge_page(struct page *page) {}
> >>>>
> >>>>  static inline bool is_transparent_hugepage(struct page *page)
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 76ca1eb2a223..4f37867eed12 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -63,7 +63,14 @@ static struct shrinker deferred_split_shrinker;
> >>>>  static atomic_t huge_zero_refcount;
> >>>>  struct page *huge_zero_page __read_mostly;
> >>>>
> >>>> -bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>> +static inline bool file_thp_enabled(struct vm_area_struct *vma)
> >>>> +{
> >>>> +     return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
> >>>> +            !inode_is_open_for_write(vma->vm_file->f_inode) &&
> >>>> +            (vma->vm_flags & VM_EXEC);
> >>>> +}
> >>>> +
> >>>> +bool transparent_hugepage_active(struct vm_area_struct *vma)
> >>>>  {
> >>>>       /* The addr is used to check if the vma size fits */
> >>>>       unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> >>>> @@ -74,6 +81,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
> >>>>               return __transparent_hugepage_enabled(vma);
> >>>>       if (vma_is_shmem(vma))
> >>>>               return shmem_huge_enabled(vma);
> >>>> +     if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
> >>>> +             return file_thp_enabled(vma);
> >>>>
> >>>>       return false;
> >>>>  }
> >>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >>>> index 6c0185fdd815..d97b20fad6e8 100644
> >>>> --- a/mm/khugepaged.c
> >>>> +++ b/mm/khugepaged.c
> >>>> @@ -442,9 +442,7 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
> >>>>  static bool hugepage_vma_check(struct vm_area_struct *vma,
> >>>>                              unsigned long vm_flags)
> >>>>  {
> >>>> -     /* Explicitly disabled through madvise. */
> >>>> -     if ((vm_flags & VM_NOHUGEPAGE) ||
> >>>> -         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> >>>> +     if (!transhuge_vma_enabled(vma, vm_flags))
> >>>>               return false;
> >>>>
> >>>>       /* Enabled via shmem mount options or sysfs settings. */
> >>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>> index a08cedefbfaa..1dcbec313c70 100644
> >>>> --- a/mm/shmem.c
> >>>> +++ b/mm/shmem.c
> >>>> @@ -4032,8 +4032,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
> >>>>       loff_t i_size;
> >>>>       pgoff_t off;
> >>>>
> >>>> -     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >>>> -         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> >>>> +     if (!transhuge_vma_enabled(vma, vma->vm_flags))
> >>>>               return false;
> >>>>       if (shmem_huge == SHMEM_HUGE_FORCE)
> >>>>               return true;
> >>>
> > .
> >
>
