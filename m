Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE62D52A4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiEQOdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiEQOdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:33:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37040E68
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:33:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f10so5635736pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bi1M9z7jrVbKOqLe6/b4plNwVoUH+5L8lsvnyy/YrYs=;
        b=KiXVDJyLu3yeG9gWaZDWHwWVdGkfld2Cl0b99nTR5onmp6m0mbJqyv/2i0ATUlcv/R
         hud0NHbp9YalaeaBrez89GswkWgBRzWZGTvipC92RnP/Yi8BDb+uUp+4IZVlUDereqxT
         gm8v8cFxWD79h5YVWT62fId6G/o4govyawQVQf527t3MfkM2tgL1XV8lfgaKiEqOKs1J
         Qrd6/JPD2/2jPblHm5/GpwNMrSgbBTdmFDMRaaosdsEQjxbvw/jEFXvCLiYdRW/Qodw0
         gDZeTUAfgWRcg4rJc3aGW22XO5mb8KkXcileca9/Z+GqYWYIYxRaSTtEUDcoVLSIyemu
         OjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bi1M9z7jrVbKOqLe6/b4plNwVoUH+5L8lsvnyy/YrYs=;
        b=mKGTows24DaCMVBckFfHJfGETq2Y9KalQEYHD+BdrtYZIMxmR/uZGX36EhNVTE/TDG
         Pjjiup/Ytt+dgadVjkcbesbpCstdGxBut0UIMqSyMpI+jyFZOP0dhip53mZs8TTul3kd
         8wOh7ggDgOBo4QmaWHcUaglWwdMRlDEqEJDnX1yt+PCKvKRV4+TuvhvTpQHR4oGpG8zn
         t6d/p072GdLEU3WtdOIDRD1rzKCDlTpcVITm6mm19h3Glynny81qMBvxn1Wyg9v+EChX
         FU6u/ZWGRJpGPAez/z+IyYepzjEF24o2VHrQe9fFELRwnvtP6if7VQnlpVJF6F+1Zo0Z
         VEYg==
X-Gm-Message-State: AOAM532I4rxFn8WEa4avhISBJg/vVbpBsQ5dZTlOwMMNEgn27NgiU6x9
        6XdEJjayAyO9B8SmTtpHR5naX22mpwPNv71OZ3gBeg==
X-Google-Smtp-Source: ABdhPJz4gz0WBIaXZ7E4dwKLnG1goAhDCmZq1z7lxs4FhZMh0pRNN8wg/PWBwfBI4JlAx2K2kU7LnoxILwGVWyQmNPw=
X-Received: by 2002:a17:902:7e01:b0:15e:caea:d6 with SMTP id
 b1-20020a1709027e0100b0015ecaea00d6mr22684003plm.33.1652798025579; Tue, 17
 May 2022 07:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220507110114.4128854-1-tongtiangen@huawei.com>
 <20220507110114.4128854-6-tongtiangen@huawei.com> <20220517135435.GA553@mutt> <CA+CK2bAnfxTo-Osvo9=0t=RkC4rTR+mgg2JSypsu3wm6BZFT=A@mail.gmail.com>
In-Reply-To: <CA+CK2bAnfxTo-Osvo9=0t=RkC4rTR+mgg2JSypsu3wm6BZFT=A@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 17 May 2022 16:33:34 +0200
Message-ID: <CADYN=9JtrZSAmN8J8KbG_PRVGKPhJ3JkP+nq2bqrpFqEa=Avjg@mail.gmail.com>
Subject: Re: [PATCH -next v7 5/6] arm64/mm: Enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
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

On Tue, 17 May 2022 at 16:02, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On Tue, May 17, 2022 at 9:54 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > On 2022-05-07 11:01, Tong Tiangen wrote:
> > > From: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >
> > > As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table check")
> > > , enable ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64.
> > >
> > > Add additional page table check stubs for page table helpers, these stubs
> > > can be used to check the existing page table entries.
> > >
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >
> > When building and booting an arm64 allmodconfig kernel on the next tree, branch next-20220516,
> > see the following kernel oops when booting in QEMU [1]:
> >
> > T35] ------------[ cut here ]------------
> > [  578.695796][   T35] kernel BUG at mm/page_table_check.c:82!
> > [  578.697292][   T35] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [  578.704318][   T35] Modules linked in:
> > [  578.705907][   T35] CPU: 0 PID: 35 Comm: khugepaged Tainted: G                T 5.18.0-rc6-next-20220513 #1 893498a5d8159d9fb26e12492a93c07e83dd4b7f
> > [  578.711170][   T35] Hardware name: linux,dummy-virt (DT)
> > [  578.713315][   T35] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [  578.716398][   T35] pc : page_table_check_clear.constprop.0+0x1f4/0x280
> > [  578.719107][   T35] lr : page_table_check_clear.constprop.0+0x1cc/0x280
> > [  578.721781][   T35] sp : ffff80000f3778b0
> > [  578.723446][   T35] x29: ffff80000f3778b0 x28: ffff80000b891218 x27: ffff000012dd55f0
> > [  578.726667][   T35] x26: 0000000000000008 x25: ffff80000c38cd80 x24: 0000000000000000
> > [  578.729870][   T35] x23: ffff80000c38c9c0 x22: 0000000000000000 x21: 0000000000000200
> > [  578.733079][   T35] x20: ffff000007bae000 x19: ffff000007bae008 x18: 0000000000000000
> > [  578.736299][   T35] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [  578.739505][   T35] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [  578.742735][   T35] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > [  578.745925][   T35] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > [  578.749145][   T35] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff000007bae00c
> > [  578.752348][   T35] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 00000000ffffffff
> > [  578.755556][   T35] Call trace:
> > [  578.756877][   T35]  page_table_check_clear.constprop.0+0x1f4/0x280
> > [  578.759446][   T35]  __page_table_check_pmd_clear+0xc4/0x140
> > [  578.761757][   T35]  pmdp_collapse_flush+0xa4/0x1c0
> > [  578.763771][   T35]  collapse_huge_page+0x4e4/0xb00
> > [  578.765778][   T35]  khugepaged_scan_pmd+0xc18/0xd00
> > [  578.767840][   T35]  khugepaged_scan_mm_slot+0x580/0x780
> > [  578.770018][   T35]  khugepaged+0x2dc/0x400
> > [  578.771786][   T35]  kthread+0x164/0x180
> > [  578.773430][   T35]  ret_from_fork+0x10/0x20
> > [  578.775253][   T35] Code: 52800021 91001263 14000388 36f80040 (d4210000)
> > [  578.777990][   T35] ---[ end trace 0000000000000000 ]---
> > [  578.778021][   T35] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > [  578.782934][   T35] Kernel Offset: disabled
> > [  578.784642][   T35] CPU features: 0x000,00100010,00001086
> > [  578.786848][   T35] Memory Limit: none
> > [  578.788433][   T35] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> >
> > Bisected down to this patch, see the bisect log [2].
> >
> > When I revert this patch I don't see the issue anymore.
>
> Thank you for reporting this. I believe, this is the same problem that
> Anshuman saw [1].

Yes looks like the same issue, I missed that.

> However, at that time he could not reproduce it
> anymore. Can you please provide QEMU command line

$ qemu-system-aarch64 --enable-kvm -cpu cortex-a53 -kernel
Image-20220517-1.gz -serial stdio -monitor none -nographic -m 2G -M
virt -fsdev local,id=root,path=/srv/kvm/tmp/stretch/arm64,security_model=none,writeout=immediate
-device virtio-rng-pci -device
virtio-9p-pci,fsdev=root,mount_tag=/dev/root -append "root=/dev/root
rootfstype=9p rootflags=trans=virtio,msize=131072
console=ttyAMA0,38400n8 earlycon=pl011,0x9000000 initcall_debug
softlockup_panic=0 security=none kpti=no kfence.sample_interval=0"
-object rng-random,id=rng0,filename=/dev/urandom -device
virtio-rng-pci,rng=rng0

>, QEMU version,

$ qemu-system-aarch64 --version
QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-11+deb11u1)
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers

I'm running on an arm64 host.

> kernel config

Kernel config [1].

I build the kernel with tuxmake [2] like this:
$ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig http://ix.io/3Y06

>, and information about the base image you are using.

Using a debian:stretch release when booting up QEMU.
Host system debian:bullseye

Cheers,
Anders
[1] http://ix.io/3Y06
[2] https://tuxmake.org/install-pypi/

>
> Thank you,
> Pasha
>
> [1] https://lore.kernel.org/all/1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com/
>
>
> >
> > Cheers,
> > Anders
> > [1] https://people.linaro.org/~anders.roxell/output-next-20220513.log
> > [2] http://ix.io/3XZB
> >
> > > ---
> > >  arch/arm64/Kconfig               |  1 +
> > >  arch/arm64/include/asm/pgtable.h | 61 ++++++++++++++++++++++++++++----
> > >  2 files changed, 56 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 272c75af9302..3055fb5b3fb4 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -92,6 +92,7 @@ config ARM64
> > >       select ARCH_SUPPORTS_ATOMIC_RMW
> > >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > >       select ARCH_SUPPORTS_NUMA_BALANCING
> > > +     select ARCH_SUPPORTS_PAGE_TABLE_CHECK
> > >       select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
> > >       select ARCH_WANT_DEFAULT_BPF_JIT
> > >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > > index 8ebf1cec5d90..4e61cde27f9f 100644
> > > --- a/arch/arm64/include/asm/pgtable.h
> > > +++ b/arch/arm64/include/asm/pgtable.h
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/mmdebug.h>
> > >  #include <linux/mm_types.h>
> > >  #include <linux/sched.h>
> > > +#include <linux/page_table_check.h>
> > >
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > >  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> > > @@ -96,6 +97,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> > >  #define pte_young(pte)               (!!(pte_val(pte) & PTE_AF))
> > >  #define pte_special(pte)     (!!(pte_val(pte) & PTE_SPECIAL))
> > >  #define pte_write(pte)               (!!(pte_val(pte) & PTE_WRITE))
> > > +#define pte_user(pte)                (!!(pte_val(pte) & PTE_USER))
> > >  #define pte_user_exec(pte)   (!(pte_val(pte) & PTE_UXN))
> > >  #define pte_cont(pte)                (!!(pte_val(pte) & PTE_CONT))
> > >  #define pte_devmap(pte)              (!!(pte_val(pte) & PTE_DEVMAP))
> > > @@ -312,8 +314,8 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
> > >                    __func__, pte_val(old_pte), pte_val(pte));
> > >  }
> > >
> > > -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > > -                           pte_t *ptep, pte_t pte)
> > > +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> > > +                             pte_t *ptep, pte_t pte)
> > >  {
> > >       if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
> > >               __sync_icache_dcache(pte);
> > > @@ -343,6 +345,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > >       set_pte(ptep, pte);
> > >  }
> > >
> > > +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> > > +                           pte_t *ptep, pte_t pte)
> > > +{
> > > +     page_table_check_pte_set(mm, addr, ptep, pte);
> > > +     return __set_pte_at(mm, addr, ptep, pte);
> > > +}
> > > +
> > >  /*
> > >   * Huge pte definitions.
> > >   */
> > > @@ -454,6 +463,8 @@ static inline int pmd_trans_huge(pmd_t pmd)
> > >  #define pmd_dirty(pmd)               pte_dirty(pmd_pte(pmd))
> > >  #define pmd_young(pmd)               pte_young(pmd_pte(pmd))
> > >  #define pmd_valid(pmd)               pte_valid(pmd_pte(pmd))
> > > +#define pmd_user(pmd)                pte_user(pmd_pte(pmd))
> > > +#define pmd_user_exec(pmd)   pte_user_exec(pmd_pte(pmd))
> > >  #define pmd_cont(pmd)                pte_cont(pmd_pte(pmd))
> > >  #define pmd_wrprotect(pmd)   pte_pmd(pte_wrprotect(pmd_pte(pmd)))
> > >  #define pmd_mkold(pmd)               pte_pmd(pte_mkold(pmd_pte(pmd)))
> > > @@ -501,8 +512,19 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> > >  #define pud_pfn(pud)         ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
> > >  #define pfn_pud(pfn,prot)    __pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
> > >
> > > -#define set_pmd_at(mm, addr, pmdp, pmd)      set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
> > > -#define set_pud_at(mm, addr, pudp, pud)      set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
> > > +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> > > +                           pmd_t *pmdp, pmd_t pmd)
> > > +{
> > > +     page_table_check_pmd_set(mm, addr, pmdp, pmd);
> > > +     return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
> > > +}
> > > +
> > > +static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
> > > +                           pud_t *pudp, pud_t pud)
> > > +{
> > > +     page_table_check_pud_set(mm, addr, pudp, pud);
> > > +     return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
> > > +}
> > >
> > >  #define __p4d_to_phys(p4d)   __pte_to_phys(p4d_pte(p4d))
> > >  #define __phys_to_p4d_val(phys)      __phys_to_pte_val(phys)
> > > @@ -643,6 +665,24 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> > >  #define pud_present(pud)     pte_present(pud_pte(pud))
> > >  #define pud_leaf(pud)                (pud_present(pud) && !pud_table(pud))
> > >  #define pud_valid(pud)               pte_valid(pud_pte(pud))
> > > +#define pud_user(pud)                pte_user(pud_pte(pud))
> > > +
> > > +#ifdef CONFIG_PAGE_TABLE_CHECK
> > > +static inline bool pte_user_accessible_page(pte_t pte)
> > > +{
> > > +     return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> > > +}
> > > +
> > > +static inline bool pmd_user_accessible_page(pmd_t pmd)
> > > +{
> > > +     return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> > > +}
> > > +
> > > +static inline bool pud_user_accessible_page(pud_t pud)
> > > +{
> > > +     return pud_present(pud) && pud_user(pud);
> > > +}
> > > +#endif
> > >
> > >  static inline void set_pud(pud_t *pudp, pud_t pud)
> > >  {
> > > @@ -876,7 +916,11 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> > >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> > >                                      unsigned long address, pte_t *ptep)
> > >  {
> > > -     return __pte(xchg_relaxed(&pte_val(*ptep), 0));
> > > +     pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
> > > +
> > > +     page_table_check_pte_clear(mm, address, pte);
> > > +
> > > +     return pte;
> > >  }
> > >
> > >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > @@ -884,7 +928,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> > >  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> > >                                           unsigned long address, pmd_t *pmdp)
> > >  {
> > > -     return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> > > +     pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
> > > +
> > > +     page_table_check_pmd_clear(mm, address, pmd);
> > > +
> > > +     return pmd;
> > >  }
> > >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > >
> > > @@ -918,6 +966,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> > >  static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
> > >               unsigned long address, pmd_t *pmdp, pmd_t pmd)
> > >  {
> > > +     page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
> > >       return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
> > >  }
> > >  #endif
> > > --
> > > 2.25.1
> > >
> >
> > --
> > Anders Roxell
> > anders.roxell@linaro.org
> > M: +46 708 22 71 05 | IRC: roxell
