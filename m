Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648C52A427
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348303AbiEQODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiEQOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:02:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614664C410
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:02:43 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i19so34878770eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9HewkSlUJVZn5Q/5DNbVooH5f3deVdZxeiACn1Li5Q=;
        b=D1Bhh2rFbxniirvRlq8fQpSsjhzTd4HG9tCO9tweapcfhjW/Zh+gssG0f1VEJ0SmlX
         lEjILkfOUWZaRc4WPbV2W6Nnj7uKhtjj0Yu0DwrRkePwpuJaqpXO1NMzG3fqnnQYiL5c
         4o8vEwIookXG387ENoyDo+UuaMF6EJuQsmqw3+DhJ0s55EPeNU4tYlUk+Fmy3uX4vfP2
         sIxYN2GrvAkrYiUayOaCkhdtVRcHLwThhbN8nI7Iz7xQpXLTPC1V4W2f9DCvooesQcfp
         harY/gCcznNaXbYkuGnwboFsj9wtHrGUBBQPNfdUWMksNmk5vnf4Xnhc638E0z15KNqx
         yhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9HewkSlUJVZn5Q/5DNbVooH5f3deVdZxeiACn1Li5Q=;
        b=dyz0BOyehjNPFn1AmeM2fnxmnusFLnZznYr9YbFu/NVMhU4Aoa9T3RUDVqEJXNaKVo
         Lf+fPgxpwqwTF+AYeUEsPkfQ5cVPq8ihyE0x7cr+URSBmh5rOj6R0G1WkM5YRiw4Vadq
         FyO2hyxtMTIcXRalrxxtXJ52LwMvyJW32IkN4+978vX8mmNfeLAWrC87iAuNLBvw0VQY
         +Ytbi81P1ktewskyTbLBxIBSiVBRBXYcHCmqgPgWTuq/ajOfH8XrLNrYdpPJnJ9Zy+ua
         kc56BOKyzZ1gRB123VGv3Zh3UO6YtVMSKk8iJL5qWZHL1VV0lPNmI2etc5+mRuK73xIQ
         hQ/Q==
X-Gm-Message-State: AOAM533z99ZKYnZ3c1xDK+/whdqNPF7rJq0ZqVwpb4P4yK/mVJkpoMJK
        Q5DNxLVtUmlnenpxsV6LDWm60KzvgVaB6N2iLZmhgQ==
X-Google-Smtp-Source: ABdhPJxOwyk4HNt9oPRkEy5I5QUZydIXq/f8v17gUcucRvEiHNgTHnnnO/ED+5cn5m9R2w8ThMMfQZEO3BpzSSqd1+g=
X-Received: by 2002:a17:906:9b8b:b0:6fe:55db:14e with SMTP id
 dd11-20020a1709069b8b00b006fe55db014emr5506610ejc.327.1652796161372; Tue, 17
 May 2022 07:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220507110114.4128854-1-tongtiangen@huawei.com>
 <20220507110114.4128854-6-tongtiangen@huawei.com> <20220517135435.GA553@mutt>
In-Reply-To: <20220517135435.GA553@mutt>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 17 May 2022 10:02:06 -0400
Message-ID: <CA+CK2bAnfxTo-Osvo9=0t=RkC4rTR+mgg2JSypsu3wm6BZFT=A@mail.gmail.com>
Subject: Re: [PATCH -next v7 5/6] arm64/mm: Enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 9:54 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On 2022-05-07 11:01, Tong Tiangen wrote:
> > From: Kefeng Wang <wangkefeng.wang@huawei.com>
> >
> > As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table check")
> > , enable ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64.
> >
> > Add additional page table check stubs for page table helpers, these stubs
> > can be used to check the existing page table entries.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> When building and booting an arm64 allmodconfig kernel on the next tree, branch next-20220516,
> see the following kernel oops when booting in QEMU [1]:
>
> T35] ------------[ cut here ]------------
> [  578.695796][   T35] kernel BUG at mm/page_table_check.c:82!
> [  578.697292][   T35] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  578.704318][   T35] Modules linked in:
> [  578.705907][   T35] CPU: 0 PID: 35 Comm: khugepaged Tainted: G                T 5.18.0-rc6-next-20220513 #1 893498a5d8159d9fb26e12492a93c07e83dd4b7f
> [  578.711170][   T35] Hardware name: linux,dummy-virt (DT)
> [  578.713315][   T35] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  578.716398][   T35] pc : page_table_check_clear.constprop.0+0x1f4/0x280
> [  578.719107][   T35] lr : page_table_check_clear.constprop.0+0x1cc/0x280
> [  578.721781][   T35] sp : ffff80000f3778b0
> [  578.723446][   T35] x29: ffff80000f3778b0 x28: ffff80000b891218 x27: ffff000012dd55f0
> [  578.726667][   T35] x26: 0000000000000008 x25: ffff80000c38cd80 x24: 0000000000000000
> [  578.729870][   T35] x23: ffff80000c38c9c0 x22: 0000000000000000 x21: 0000000000000200
> [  578.733079][   T35] x20: ffff000007bae000 x19: ffff000007bae008 x18: 0000000000000000
> [  578.736299][   T35] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  578.739505][   T35] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [  578.742735][   T35] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [  578.745925][   T35] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> [  578.749145][   T35] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff000007bae00c
> [  578.752348][   T35] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 00000000ffffffff
> [  578.755556][   T35] Call trace:
> [  578.756877][   T35]  page_table_check_clear.constprop.0+0x1f4/0x280
> [  578.759446][   T35]  __page_table_check_pmd_clear+0xc4/0x140
> [  578.761757][   T35]  pmdp_collapse_flush+0xa4/0x1c0
> [  578.763771][   T35]  collapse_huge_page+0x4e4/0xb00
> [  578.765778][   T35]  khugepaged_scan_pmd+0xc18/0xd00
> [  578.767840][   T35]  khugepaged_scan_mm_slot+0x580/0x780
> [  578.770018][   T35]  khugepaged+0x2dc/0x400
> [  578.771786][   T35]  kthread+0x164/0x180
> [  578.773430][   T35]  ret_from_fork+0x10/0x20
> [  578.775253][   T35] Code: 52800021 91001263 14000388 36f80040 (d4210000)
> [  578.777990][   T35] ---[ end trace 0000000000000000 ]---
> [  578.778021][   T35] Kernel panic - not syncing: Oops - BUG: Fatal exception
> [  578.782934][   T35] Kernel Offset: disabled
> [  578.784642][   T35] CPU features: 0x000,00100010,00001086
> [  578.786848][   T35] Memory Limit: none
> [  578.788433][   T35] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
>
> Bisected down to this patch, see the bisect log [2].
>
> When I revert this patch I don't see the issue anymore.

Thank you for reporting this. I believe, this is the same problem that
Anshuman saw [1]. However, at that time he could not reproduce it
anymore. Can you please provide QEMU command line, QEMU version,
kernel config, and information about the base image you are using.

Thank you,
Pasha

[1] https://lore.kernel.org/all/1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com/


>
> Cheers,
> Anders
> [1] https://people.linaro.org/~anders.roxell/output-next-20220513.log
> [2] http://ix.io/3XZB
>
> > ---
> >  arch/arm64/Kconfig               |  1 +
> >  arch/arm64/include/asm/pgtable.h | 61 ++++++++++++++++++++++++++++----
> >  2 files changed, 56 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 272c75af9302..3055fb5b3fb4 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -92,6 +92,7 @@ config ARM64
> >       select ARCH_SUPPORTS_ATOMIC_RMW
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_NUMA_BALANCING
> > +     select ARCH_SUPPORTS_PAGE_TABLE_CHECK
> >       select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> >       select ARCH_WANT_DEFAULT_BPF_JIT
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 8ebf1cec5d90..4e61cde27f9f 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -33,6 +33,7 @@
> >  #include <linux/mmdebug.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/sched.h>
> > +#include <linux/page_table_check.h>
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> > @@ -96,6 +97,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> >  #define pte_young(pte)               (!!(pte_val(pte) & PTE_AF))
> >  #define pte_special(pte)     (!!(pte_val(pte) & PTE_SPECIAL))
> >  #define pte_write(pte)               (!!(pte_val(pte) & PTE_WRITE))
> > +#define pte_user(pte)                (!!(pte_val(pte) & PTE_USER))
> >  #define pte_user_exec(pte)   (!(pte_val(pte) & PTE_UXN))
> >  #define pte_cont(pte)                (!!(pte_val(pte) & PTE_CONT))
> >  #define pte_devmap(pte)              (!!(pte_val(pte) & PTE_DEVMAP))
> > @@ -312,8 +314,8 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
> >                    __func__, pte_val(old_pte), pte_val(pte));
> >  }
> >
> > -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > -                           pte_t *ptep, pte_t pte)
> > +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> > +                             pte_t *ptep, pte_t pte)
> >  {
> >       if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
> >               __sync_icache_dcache(pte);
> > @@ -343,6 +345,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >       set_pte(ptep, pte);
> >  }
> >
> > +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > +                           pte_t *ptep, pte_t pte)
> > +{
> > +     page_table_check_pte_set(mm, addr, ptep, pte);
> > +     return __set_pte_at(mm, addr, ptep, pte);
> > +}
> > +
> >  /*
> >   * Huge pte definitions.
> >   */
> > @@ -454,6 +463,8 @@ static inline int pmd_trans_huge(pmd_t pmd)
> >  #define pmd_dirty(pmd)               pte_dirty(pmd_pte(pmd))
> >  #define pmd_young(pmd)               pte_young(pmd_pte(pmd))
> >  #define pmd_valid(pmd)               pte_valid(pmd_pte(pmd))
> > +#define pmd_user(pmd)                pte_user(pmd_pte(pmd))
> > +#define pmd_user_exec(pmd)   pte_user_exec(pmd_pte(pmd))
> >  #define pmd_cont(pmd)                pte_cont(pmd_pte(pmd))
> >  #define pmd_wrprotect(pmd)   pte_pmd(pte_wrprotect(pmd_pte(pmd)))
> >  #define pmd_mkold(pmd)               pte_pmd(pte_mkold(pmd_pte(pmd)))
> > @@ -501,8 +512,19 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> >  #define pud_pfn(pud)         ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
> >  #define pfn_pud(pfn,prot)    __pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
> >
> > -#define set_pmd_at(mm, addr, pmdp, pmd)      set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
> > -#define set_pud_at(mm, addr, pudp, pud)      set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
> > +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> > +                           pmd_t *pmdp, pmd_t pmd)
> > +{
> > +     page_table_check_pmd_set(mm, addr, pmdp, pmd);
> > +     return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
> > +}
> > +
> > +static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
> > +                           pud_t *pudp, pud_t pud)
> > +{
> > +     page_table_check_pud_set(mm, addr, pudp, pud);
> > +     return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
> > +}
> >
> >  #define __p4d_to_phys(p4d)   __pte_to_phys(p4d_pte(p4d))
> >  #define __phys_to_p4d_val(phys)      __phys_to_pte_val(phys)
> > @@ -643,6 +665,24 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> >  #define pud_present(pud)     pte_present(pud_pte(pud))
> >  #define pud_leaf(pud)                (pud_present(pud) && !pud_table(pud))
> >  #define pud_valid(pud)               pte_valid(pud_pte(pud))
> > +#define pud_user(pud)                pte_user(pud_pte(pud))
> > +
> > +#ifdef CONFIG_PAGE_TABLE_CHECK
> > +static inline bool pte_user_accessible_page(pte_t pte)
> > +{
> > +     return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> > +}
> > +
> > +static inline bool pmd_user_accessible_page(pmd_t pmd)
> > +{
> > +     return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> > +}
> > +
> > +static inline bool pud_user_accessible_page(pud_t pud)
> > +{
> > +     return pud_present(pud) && pud_user(pud);
> > +}
> > +#endif
> >
> >  static inline void set_pud(pud_t *pudp, pud_t pud)
> >  {
> > @@ -876,7 +916,11 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >                                      unsigned long address, pte_t *ptep)
> >  {
> > -     return __pte(xchg_relaxed(&pte_val(*ptep), 0));
> > +     pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
> > +
> > +     page_table_check_pte_clear(mm, address, pte);
> > +
> > +     return pte;
> >  }
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > @@ -884,7 +928,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> >                                           unsigned long address, pmd_t *pmdp)
> >  {
> > -     return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> > +     pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
> > +
> > +     page_table_check_pmd_clear(mm, address, pmd);
> > +
> > +     return pmd;
> >  }
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > @@ -918,6 +966,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> >  static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> >               unsigned long address, pmd_t *pmdp, pmd_t pmd)
> >  {
> > +     page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
> >       return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
> >  }
> >  #endif
> > --
> > 2.25.1
> >
>
> --
> Anders Roxell
> anders.roxell@linaro.org
> M: +46 708 22 71 05 | IRC: roxell
