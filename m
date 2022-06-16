Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAB54D624
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbiFPAcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPAcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:32:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6781137
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:32:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y6so15949plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4sxB7mKhpG8kKijL49RJFhdwBOQCob12ez2AgqPWMs=;
        b=chwEQBeCytguQxa2cWmKV4T980cMNhAHE1A/QXU1FfEWxUE2DY9ec7nDdeW8wjZiKp
         6EPES01SBA7zzzD+3rCaRGk37a8saToMt0YQhJuw6mNAQINBosuCFxDlKg62aeTS73gq
         E71RpNMhDmCM/NfyqhqeLFm9kISX2pbbVh+FQ64yNnKwOnPdy4wmQusqY8MszRRvLoyx
         7xe9ShyPYqgFdiuu3kFceMHrGnFso3NQw0fNKcjjhpY9wTCJuHumRqPXGID8q6d4d9IR
         DHxLQqBrN5cWyLSldl1W5GW6587U6npQoPQsUKZm/aJXGj/MbZWi6+TEEsmZ1yfAtEDu
         0nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4sxB7mKhpG8kKijL49RJFhdwBOQCob12ez2AgqPWMs=;
        b=26EvbGc0E6gGKaZ8WLADedBEoUr5e02Lwx1Q2bxwsoQmm7PyRjkuL+UaIFMKZW8MGF
         rJKAE+OEvY2Wz84exIpy7wUab4Lycl9FqkQPfbT8v9rPtpRRMMHlm98vgfHNCny5/6Af
         5jXuuJjXxCcqbgfuhIoH3SSGDAICqtqPhT+dZx10Rtevpw1+VnCXQKntkUpQlMNI2FAr
         uVXSvxcTGeiPKemMbwsUjyVNGBeB7TIRbEmYpGYwuy7PC3jwANUUzbhp35fXm75SLw/M
         1rbBqcBqiGbAUpVsdIKvJRKRgAAlWna0x05iGjR6lGCFQsgPKcW1oWTKuqJ5TGOxDXLr
         00UA==
X-Gm-Message-State: AJIora++R2uvHqBTC/OfGp37IXG7z6l2UmGOxEX4hmUiN6vU3VSRzY9t
        t79Hl8OjFbldhQoMAQ0xpoQqR7W+JPMOv+wexoE=
X-Google-Smtp-Source: AGRyM1v3fngWwHsxPa4gsFxzpnzmut5VyBt05f4GZOETrtYzvj4EJkiIgdk5A8UdvxKPykYyGOdQfyFivy2iaj7oHNM=
X-Received: by 2002:a17:90a:ce84:b0:1e4:d803:fad with SMTP id
 g4-20020a17090ace8400b001e4d8030fadmr13330263pju.99.1655339560561; Wed, 15
 Jun 2022 17:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220615172926.546974-1-shy828301@gmail.com> <20220615172926.546974-5-shy828301@gmail.com>
 <Yqp2j6sf7m3wmwou@google.com>
In-Reply-To: <Yqp2j6sf7m3wmwou@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 17:32:28 -0700
Message-ID: <CAHbLzkp2DD=4P-ynkKcoOYjHwcQUwHjL5nY5krkJHJOP58TrdQ@mail.gmail.com>
Subject: Re: [v4 PATCH 4/7] mm: thp: kill transparent_hugepage_active()
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 15, 2022 at 5:17 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On 15 Jun 10:29, Yang Shi wrote:
> > The transparent_hugepage_active() was introduced to show THP eligibility
> > bit in smaps in proc, smaps is the only user.  But it actually does the
> > similar check as hugepage_vma_check() which is used by khugepaged.  We
> > definitely don't have to maintain two similar checks, so kill
> > transparent_hugepage_active().
> >
> > This patch also fixed the wrong behavior for VM_NO_KHUGEPAGED vmas.
> >
> > Also move hugepage_vma_check() to huge_memory.c and huge_mm.h since it
> > is not only for khugepaged anymore.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  fs/proc/task_mmu.c         |  2 +-
> >  include/linux/huge_mm.h    | 11 ++++++++-
> >  include/linux/khugepaged.h |  2 --
> >  mm/huge_memory.c           | 50 +++++++++++++++++++++++++++++++-------
> >  mm/khugepaged.c            | 48 +++---------------------------------
> >  5 files changed, 56 insertions(+), 57 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 37ccb5c9f4f8..39a40ec181e7 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -863,7 +863,7 @@ static int show_smap(struct seq_file *m, void *v)
> >       __show_smap(m, &mss, false);
> >
> >       seq_printf(m, "THPeligible:    %d\n",
> > -                transparent_hugepage_active(vma));
> > +                hugepage_vma_check(vma, vma->vm_flags, true));
> >
> >       if (arch_pkeys_enabled())
> >               seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 8a5a8bfce0f5..aeb13119ee28 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -202,7 +202,9 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
> >              !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
> >  }
> >
> > -bool transparent_hugepage_active(struct vm_area_struct *vma);
>
> Like v3, I think this also needs to be deleted from !CONFIG_TRANSPARENT_HUGEPAGE

Oops, thanks for catching this. Will fix it.

>
> Otherwise can add
>
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
>
> > +bool hugepage_vma_check(struct vm_area_struct *vma,
> > +                     unsigned long vm_flags,
> > +                     bool smaps);
> >
> >  #define transparent_hugepage_use_zero_page()                         \
> >       (transparent_hugepage_flags &                                   \
> > @@ -368,6 +370,13 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
> >       return false;
> >  }
> >
> > +static inline bool hugepage_vma_check(struct vm_area_struct *vma,
> > +                                    unsigned long vm_flags,
> > +                                    bool smaps)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline void prep_transhuge_page(struct page *page) {}
> >
> >  #define transparent_hugepage_flags 0UL
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index 31ca8a7f78f4..ea5fd4c398f7 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -10,8 +10,6 @@ extern struct attribute_group khugepaged_attr_group;
> >  extern int khugepaged_init(void);
> >  extern void khugepaged_destroy(void);
> >  extern int start_stop_khugepaged(void);
> > -extern bool hugepage_vma_check(struct vm_area_struct *vma,
> > -                            unsigned long vm_flags);
> >  extern void __khugepaged_enter(struct mm_struct *mm);
> >  extern void __khugepaged_exit(struct mm_struct *mm);
> >  extern void khugepaged_enter_vma(struct vm_area_struct *vma,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b530462c4493..a28c6100b491 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -69,21 +69,53 @@ static atomic_t huge_zero_refcount;
> >  struct page *huge_zero_page __read_mostly;
> >  unsigned long huge_zero_pfn __read_mostly = ~0UL;
> >
> > -bool transparent_hugepage_active(struct vm_area_struct *vma)
> > +bool hugepage_vma_check(struct vm_area_struct *vma,
> > +                     unsigned long vm_flags,
> > +                     bool smaps)
> >  {
> > -     /* The addr is used to check if the vma size fits */
> > -     unsigned long addr = (vma->vm_end & HPAGE_PMD_MASK) - HPAGE_PMD_SIZE;
> > +     if (!transhuge_vma_enabled(vma, vm_flags))
> > +             return false;
> > +
> > +     if (vm_flags & VM_NO_KHUGEPAGED)
> > +             return false;
> > +
> > +     /* Don't run khugepaged against DAX vma */
> > +     if (vma_is_dax(vma))
> > +             return false;
> >
> > -     if (!transhuge_vma_suitable(vma, addr))
> > +     /* Check alignment for file vma and size for both file and anon vma */
> > +     if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> >               return false;
> > -     if (vma_is_anonymous(vma))
> > -             return __transparent_hugepage_enabled(vma);
> > -     if (vma_is_shmem(vma))
> > +
> > +     /* Enabled via shmem mount options or sysfs settings. */
> > +     if (shmem_file(vma->vm_file))
> >               return shmem_huge_enabled(vma);
> > -     if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
> > +
> > +     if (!khugepaged_enabled())
> > +             return false;
> > +
> > +     /* THP settings require madvise. */
> > +     if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> > +             return false;
> > +
> > +     /* Only regular file is valid */
> > +     if (file_thp_enabled(vma))
> >               return true;
> >
> > -     return false;
> > +     if (!vma_is_anonymous(vma))
> > +             return false;
> > +
> > +     if (vma_is_temporary_stack(vma))
> > +             return false;
> > +
> > +     /*
> > +      * THPeligible bit of smaps should show 1 for proper VMAs even
> > +      * though anon_vma is not initialized yet.
> > +      */
> > +     if (!vma->anon_vma)
> > +             return smaps;
> > +
> > +     return true;
> >  }
> >
> >  static bool get_huge_zero_page(void)
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 5baa394e34c8..3afd87f8c0b1 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -437,46 +437,6 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
> >       return atomic_read(&mm->mm_users) == 0;
> >  }
> >
> > -bool hugepage_vma_check(struct vm_area_struct *vma,
> > -                     unsigned long vm_flags)
> > -{
> > -     if (!transhuge_vma_enabled(vma, vm_flags))
> > -             return false;
> > -
> > -     if (vm_flags & VM_NO_KHUGEPAGED)
> > -             return false;
> > -
> > -     /* Don't run khugepaged against DAX vma */
> > -     if (vma_is_dax(vma))
> > -             return false;
> > -
> > -     /* Check alignment for file vma and size for both file and anon vma */
> > -     if (!transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
> > -             return false;
> > -
> > -     /* Enabled via shmem mount options or sysfs settings. */
> > -     if (shmem_file(vma->vm_file))
> > -             return shmem_huge_enabled(vma);
> > -
> > -     if (!khugepaged_enabled())
> > -             return false;
> > -
> > -     /* THP settings require madvise. */
> > -     if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
> > -             return false;
> > -
> > -     /* Only regular file is valid */
> > -     if (file_thp_enabled(vma))
> > -             return true;
> > -
> > -     if (!vma->anon_vma || !vma_is_anonymous(vma))
> > -             return false;
> > -     if (vma_is_temporary_stack(vma))
> > -             return false;
> > -
> > -     return true;
> > -}
> > -
> >  void __khugepaged_enter(struct mm_struct *mm)
> >  {
> >       struct mm_slot *mm_slot;
> > @@ -513,7 +473,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> >  {
> >       if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> >           khugepaged_enabled()) {
> > -             if (hugepage_vma_check(vma, vm_flags))
> > +             if (hugepage_vma_check(vma, vm_flags, false))
> >                       __khugepaged_enter(vma->vm_mm);
> >       }
> >  }
> > @@ -958,7 +918,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> >
> >       if (!transhuge_vma_suitable(vma, address))
> >               return SCAN_ADDRESS_RANGE;
> > -     if (!hugepage_vma_check(vma, vma->vm_flags))
> > +     if (!hugepage_vma_check(vma, vma->vm_flags, false))
> >               return SCAN_VMA_CHECK;
> >       /*
> >        * Anon VMA expected, the address may be unmapped then
> > @@ -1448,7 +1408,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> >        * the valid THP. Add extra VM_HUGEPAGE so hugepage_vma_check()
> >        * will not fail the vma for missing VM_HUGEPAGE
> >        */
> > -     if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE))
> > +     if (!hugepage_vma_check(vma, vma->vm_flags | VM_HUGEPAGE, false))
> >               return;
> >
> >       /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> > @@ -2143,7 +2103,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
> >                       progress++;
> >                       break;
> >               }
> > -             if (!hugepage_vma_check(vma, vma->vm_flags)) {
> > +             if (!hugepage_vma_check(vma, vma->vm_flags, false)) {
> >  skip:
> >                       progress++;
> >                       continue;
> > --
> > 2.26.3
> >
