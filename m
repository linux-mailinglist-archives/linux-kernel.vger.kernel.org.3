Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB052F8B9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348616AbiEUEjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbiEUEjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:39:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EEA1796F5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:39:03 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q76so9279783pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Oqzay5B4LvGIfEr3Wr7+F8qISdRmPP4W1Q/bE7MjKQo=;
        b=F1PO5h5Qt0PnNiwk/YJOpDcuKRfvUwnoqxWTx2nT65pxXrbAciCHyU7cIVIn/0ygpu
         oiIYQjanRxLJVeBG+iEaImYVAqRckvI5YqJEyLgwDUcGxkxOGanO/M3TexcnqJPfbVF4
         Hh65bBSAQJ9rY00WT6QdymQd2+96gEqohfrXJM2cHmK5BdPQCOdTN4V+RuyZksHaYuiS
         iSzXNDlJgKdLV1EgMep1vbpEGogPeticJw5p+PmxXCu/0yEI8CyVs1nkZ3SRdM0kXjKL
         rAYCIV2n8mKBeRC1CnayfFTW5bzAltUdmRkjV/z3wTtTUxqnwCsumnA6p/zN9FBPZCGY
         yOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Oqzay5B4LvGIfEr3Wr7+F8qISdRmPP4W1Q/bE7MjKQo=;
        b=zIGqQ9qZo+zDwo9TJHOoVIQZKrJcZTG+OwttT8RVQLmljTkF1MAmuiepqaWxX+rJ2z
         ofXrTwZbKp1Ut1AjAGs//h/d6esVDxI4M/FmGGRXbjOGzuu9CntU3nRPQX0sZqauXBc6
         GJ7iXEpETrlGtpdubxwyBHTZxXFZyZcj6+879+lMfi4srtaaRca3ur4g5usJmg2Cozzh
         J6ol30M9ylTtgW/H6fMVBPx0mkDzs/i34kLVj8aBCGwwsR7boV9dBjbDEZESF1hNVuU8
         LI4feGLuQxe+hFPgPbD0KBL1jK4n3JcDn4Q4PWBya8QwjLuKzBUSDP6cbvOytWKp6Ugo
         NiRw==
X-Gm-Message-State: AOAM533eJ1QlsDpEG+/PEhlYWtWcjiNYLZeI37eqNFGdyNu+hj1jry1m
        zItT8icbiVtQpIigFajPaQ8=
X-Google-Smtp-Source: ABdhPJycvWKVZFuBTNrLSHDz/AzP3fBUTf998VuABkPAijCsMylLqGpT8DigrnPRfFWghXTm1ubjYg==
X-Received: by 2002:a05:6a00:1d1d:b0:518:421c:b65e with SMTP id a29-20020a056a001d1d00b00518421cb65emr10858418pfx.43.1653107942243;
        Fri, 20 May 2022 21:39:02 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a6b0400b001df17c83bbdsm2712818pjj.45.2022.05.20.21.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 21:39:01 -0700 (PDT)
Date:   Sat, 21 May 2022 12:38:53 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 6/6] mm: Expand Copy-On-Write to PTE table
Message-ID: <20220521043853.GC1508515@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-7-shiyn.lin@gmail.com>
 <0c152776-6851-eb3e-b5c2-16826779891f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c152776-6851-eb3e-b5c2-16826779891f@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:49:31PM +0000, Christophe Leroy wrote:
> 
> 
> Le 19/05/2022 à 20:31, Chih-En Lin a écrit :
> > This patch adds the Copy-On-Write (COW) mechanism to the PTE table.
> > To enable the COW page table use the clone3() system call with the
> > CLONE_COW_PGTABLE flag. It will set the MMF_COW_PGTABLE flag to the
> > processes.
> > 
> > It uses the MMF_COW_PGTABLE flag to distinguish the default page table
> > and the COW one. Moreover, it is difficult to distinguish whether the
> > entire page table is out of COW state. So the MMF_COW_PGTABLE flag won't
> > be disabled after its setup.
> > 
> > Since the memory space of the page table is distinctive for each process
> > in kernel space. It uses the address of the PMD index for the ownership
> > of the PTE table to identify which one of the processes needs to update
> > the page table state. In other words, only the owner will update COW PTE
> > state, like the RSS and pgtable_bytes.
> > 
> > It uses the reference count to control the lifetime of COW PTE table.
> > When someone breaks COW, it will copy the COW PTE table and decrease the
> > reference count. But if the reference count is equal to one before the
> > break COW, it will reuse the COW PTE table.
> > 
> > This patch modifies the part of the copy page table to do the basic COW.
> > For the break COW, it modifies the part of a page fault, zaps page table
> > , unmapping, and remapping.
> > 
> > Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> > ---
> >   include/linux/pgtable.h |   3 +
> >   mm/memory.c             | 262 ++++++++++++++++++++++++++++++++++++----
> >   mm/mmap.c               |   4 +
> >   mm/mremap.c             |   5 +
> >   4 files changed, 251 insertions(+), 23 deletions(-)
> > 
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 33c01fec7b92..357ce3722ee8 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -631,6 +631,9 @@ static inline int cow_pte_refcount_read(pmd_t *pmd)
> >          return atomic_read(&pmd_page(*pmd)->cow_pgtable_refcount);
> >   }
> > 
> > +extern int handle_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
> > +               unsigned long addr, bool alloc);
> > +
> >   #ifndef pte_access_permitted
> >   #define pte_access_permitted(pte, write) \
> >          (pte_present(pte) && (!(write) || pte_write(pte)))
> > diff --git a/mm/memory.c b/mm/memory.c
> > index aa66af76e214..ff3fcbe4dfb5 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -247,6 +247,8 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
> >                  next = pmd_addr_end(addr, end);
> >                  if (pmd_none_or_clear_bad(pmd))
> >                          continue;
> > +               BUG_ON(cow_pte_refcount_read(pmd) != 1);
> > +               BUG_ON(!cow_pte_owner_is_same(pmd, NULL));
> 
> See comment on a previous patch of this series, there seem to be a huge 
> number of new BUG_ONs.

Got it.

> >                  free_pte_range(tlb, pmd, addr);
> >          } while (pmd++, addr = next, addr != end);
> > 
> > @@ -1031,7 +1033,7 @@ static inline void cow_pte_rss(struct mm_struct *mm, struct vm_area_struct *vma,
> >   static int
> >   copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> >                 pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> > -              unsigned long end)
> > +              unsigned long end, bool is_src_pte_locked)
> >   {
> >          struct mm_struct *dst_mm = dst_vma->vm_mm;
> >          struct mm_struct *src_mm = src_vma->vm_mm;
> > @@ -1053,8 +1055,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> >                  goto out;
> >          }
> >          src_pte = pte_offset_map(src_pmd, addr);
> > -       src_ptl = pte_lockptr(src_mm, src_pmd);
> > -       spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > +       if (!is_src_pte_locked) {
> > +               src_ptl = pte_lockptr(src_mm, src_pmd);
> > +               spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > +       }
> 
> Odd construct, that kind of construct often leads to messy errors.
> 
> Could you construct things differently by refactoring the code ?

Sure, I will try my best.
It's probably why here have the bug when doing the stress testing.

> > @@ -1180,11 +1186,55 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
> >                                  continue;
> >                          /* fall through */
> >                  }
> > -               if (pmd_none_or_clear_bad(src_pmd))
> > -                       continue;
> > -               if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
> > -                                  addr, next))
> > +
> > +               if (test_bit(MMF_COW_PGTABLE, &src_mm->flags)) {
> > +
> > +                        if (pmd_none(*src_pmd))
> > +                               continue;
> 
> Why not keep the pmd_none_or_clear_bad(src_pmd) instead ?
> 
> > +
> > +                       /* XXX: Skip if the PTE already COW this time. */
> > +                       if (!pmd_none(*dst_pmd) &&
> 
> Shouldn't is be a pmd_none_or_clear_bad() ?
> 
> > +                           cow_pte_refcount_read(src_pmd) > 1)
> > +                               continue;
> > +
> > +                       /* If PTE doesn't have an owner, the parent needs to
> > +                        * take this PTE.
> > +                        */
> > +                       if (cow_pte_owner_is_same(src_pmd, NULL)) {
> > +                               set_cow_pte_owner(src_pmd, src_pmd);
> > +                               /* XXX: The process may COW PTE fork two times.
> > +                                * But in some situations, owner has cleared.
> > +                                * Previously Child (This time is the parent)
> > +                                * COW PTE forking, but previously parent, owner
> > +                                * , break COW. So it needs to add back the RSS
> > +                                * state and pgtable bytes.
> > +                                */
> > +                               if (!pmd_write(*src_pmd)) {
> > +                                       unsigned long pte_start =
> > +                                               addr & PMD_MASK;
> > +                                       unsigned long pte_end =
> > +                                               (addr + PMD_SIZE) & PMD_MASK;
> > +                                       cow_pte_rss(src_mm, src_vma, src_pmd,
> > +                                           pte_start, pte_end, true /* inc */);
> > +                                       mm_inc_nr_ptes(src_mm);
> > +                                       smp_wmb();
> > +                                       pmd_populate(src_mm, src_pmd,
> > +                                                       pmd_page(*src_pmd));
> > +                               }
> > +                       }
> > +
> > +                       pmdp_set_wrprotect(src_mm, addr, src_pmd);
> > +
> > +                       /* Child reference count */
> > +                       pmd_get_pte(src_pmd);
> > +
> > +                       /* COW for PTE table */
> > +                       set_pmd_at(dst_mm, addr, dst_pmd, *src_pmd);
> > +               } else if (!pmd_none_or_clear_bad(src_pmd) &&
> 
> Can't we keep pmd_none_or_clear_bad(src_pmd) common to both cases ?
> 

You are right.
I will change to pmd_none_or_clear_bad().

> > +                           copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
> > +                                   addr, next, false)) {
> >                          return -ENOMEM;
> > +               }
> >          } while (dst_pmd++, src_pmd++, addr = next, addr != end);
> >          return 0;
> >   }
> > @@ -1336,6 +1386,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >   struct zap_details {
> >          struct folio *single_folio;     /* Locked folio to be unmapped */
> >          bool even_cows;                 /* Zap COWed private pages too? */
> > +       bool cow_pte;                   /* Do not free COW PTE */
> >   };
> > 
> >   /* Whether we should zap all COWed (private) pages too */
> > @@ -1398,8 +1449,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                          page = vm_normal_page(vma, addr, ptent);
> >                          if (unlikely(!should_zap_page(details, page)))
> >                                  continue;
> > -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
> > -                                                       tlb->fullmm);
> > +                       if (!details || !details->cow_pte)
> > +                               ptent = ptep_get_and_clear_full(mm, addr, pte,
> > +                                                               tlb->fullmm);
> >                          tlb_remove_tlb_entry(tlb, pte, addr);
> >                          if (unlikely(!page))
> >                                  continue;
> > @@ -1413,8 +1465,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                                      likely(!(vma->vm_flags & VM_SEQ_READ)))
> >                                          mark_page_accessed(page);
> >                          }
> > -                       rss[mm_counter(page)]--;
> > -                       page_remove_rmap(page, vma, false);
> > +                       if (!details || !details->cow_pte) {
> > +                               rss[mm_counter(page)]--;
> > +                               page_remove_rmap(page, vma, false);
> > +                       } else
> > +                               continue;
> 
> Can you do the reverse:
> 
> 			if (details && details->cow_pte)
> 				continue;
> 
> 			rss[mm_counter(page)]--;
> 			page_remove_rmap(page, vma, false);

It's better than I wrote.
Thanks.

> 
> >                          if (unlikely(page_mapcount(page) < 0))
> >                                  print_bad_pte(vma, addr, ptent, page);
> >                          if (unlikely(__tlb_remove_page(tlb, page))) {
> > @@ -1425,6 +1480,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >                          continue;
> >                  }
> > 
> > +               // TODO: Deal COW PTE with swap
> > +
> >                  entry = pte_to_swp_entry(ptent);
> >                  if (is_device_private_entry(entry) ||
> >                      is_device_exclusive_entry(entry)) {
> > @@ -1513,16 +1570,34 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
> >                          spin_unlock(ptl);
> >                  }
> > 
> > -               /*
> > -                * Here there can be other concurrent MADV_DONTNEED or
> > -                * trans huge page faults running, and if the pmd is
> > -                * none or trans huge it can change under us. This is
> > -                * because MADV_DONTNEED holds the mmap_lock in read
> > -                * mode.
> > -                */
> > -               if (pmd_none_or_trans_huge_or_clear_bad(pmd))
> > -                       goto next;
> > -               next = zap_pte_range(tlb, vma, pmd, addr, next, details);
> > +
> > +               if (test_bit(MMF_COW_PGTABLE, &tlb->mm->flags) &&
> > +                   !pmd_none(*pmd) && !pmd_write(*pmd)) {
> 
> Can't you use pmd_none_or_trans_huge_or_clear_bad() and keep it common ? ...

Sure.

> > +static int zap_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
> > +               unsigned long addr)
> > +{
> > +       struct mm_struct *mm = vma->vm_mm;
> > +       unsigned long start, end;
> > +
> > +       if (pmd_put_pte(vma, pmd, addr)) {
> > +               // fallback
> > +               return 1;
> > +       }
> 
> No { } for a single line if. The comment could go just before the if.
> 
> > +
> > +       start = addr & PMD_MASK;
> > +       end = (addr + PMD_SIZE) & PMD_MASK;
> > +
> > +       /* If PMD entry is owner, clear the ownership, and decrease RSS state
> > +        * and pgtable_bytes.
> > +        */
> 
> Please follow the standard comments style:
> 
> /*
>   * Some text
>   * More text
>   */
> 

Got it.

> > +       if (cow_pte_owner_is_same(pmd, pmd)) {
> > +               set_cow_pte_owner(pmd, NULL);
> > +               cow_pte_rss(mm, vma, pmd, start, end, false /* dec */);
> > +               mm_dec_nr_ptes(mm);
> > +       }
> > +
> > +       pmd_clear(pmd);
> > +       return 0;
> > +}
> > +
> > +/* If alloc set means it won't break COW. For this case, it will just decrease
> > + * the reference count. The address needs to be at the beginning of the PTE page
> > + * since COW PTE is copy-on-write the entire PTE.
> > + * If pmd is NULL, it will get the pmd from vma and check it is cowing.
> > + */
> > +int handle_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
> > +               unsigned long addr, bool alloc)
> > +{
> > +       pgd_t *pgd;
> > +       p4d_t *p4d;
> > +       pud_t *pud;
> > +       struct mm_struct *mm = vma->vm_mm;
> > +       int ret = 0;
> > +       spinlock_t *ptl = NULL;
> > +
> > +       if (!pmd) {
> > +               pgd = pgd_offset(mm, addr);
> > +               if (pgd_none_or_clear_bad(pgd))
> > +                       return 0;
> > +               p4d = p4d_offset(pgd, addr);
> > +               if (p4d_none_or_clear_bad(p4d))
> > +                       return 0;
> > +               pud = pud_offset(p4d, addr);
> > +               if (pud_none_or_clear_bad(pud))
> > +                       return 0;
> > +               pmd = pmd_offset(pud, addr);
> > +               if (pmd_none(*pmd) || pmd_write(*pmd))
> > +                       return 0;
> > +       }
> > +
> > +       // TODO: handle COW PTE with swap
> > +       BUG_ON(is_swap_pmd(*pmd));
> > +       BUG_ON(pmd_trans_huge(*pmd));
> > +       BUG_ON(pmd_devmap(*pmd));
> > +
> > +       BUG_ON(pmd_none(*pmd));
> > +       BUG_ON(pmd_write(*pmd));
> 
> So many BUG_ON ? All this has a cost during the execution.

I will consider it again.

> > +
> > +       ptl = pte_lockptr(mm, pmd);
> > +       spin_lock(ptl);
> > +       if (!alloc)
> > +               ret = zap_cow_pte(vma, pmd, addr);
> > +       else
> > +               ret = break_cow_pte(vma, pmd, addr);
> 
> Better as
> 
> 	if (alloc)
> 		break_cow_pte()
> 	else
> 		zap_cow_pte()

Great!
Thanks.

> > +       spin_unlock(ptl);
> > +
> > +       return ret;
> > +}
> > +
> >   /*
> >    * These routines also need to handle stuff like marking pages dirty
> >    * and/or accessed for architectures that don't do it in hardware (most
> > @@ -4825,6 +5028,19 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> >                                  return 0;
> >                          }
> >                  }
> > +
> > +               /* When the PMD entry is set with write protection, it needs to
> > +                * handle the on-demand PTE. It will allocate a new PTE and copy
> > +                * the old one, then set this entry writeable and decrease the
> > +                * reference count at COW PTE.
> > +                */
> > +               if (test_bit(MMF_COW_PGTABLE, &mm->flags) &&
> > +                   !pmd_none(vmf.orig_pmd) && !pmd_write(vmf.orig_pmd)) {
> > +                       if (handle_cow_pte(vmf.vma, vmf.pmd, vmf.real_address,
> > +                          (cow_pte_refcount_read(&vmf.orig_pmd) > 1) ?
> > +                          true : false) < 0)
> 
> (condition ? true : false) is exactly the same as (condition)
> 

I knew. ;-)

Again, thanks!
