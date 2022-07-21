Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57457CB98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiGUNOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGUNOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:14:00 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD57308
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:13:59 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31d85f82f0bso16586967b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=otORvzl7/EquxrHIAFf6clZzYDIdRdFY2L1POt7+dtE=;
        b=HVU5PUixSWE1bFynnkqQlhpoZnvx+5bqZMXUBMy8e6vTe8RDQ2FCWWsInNIqstahYh
         p3ic1Xy6Om8yc+wPSVugiO1v6ip5ntlgE3cVlDicRaz66g1xGTOu8fHed/uUigRht+lp
         9dyIR/DLTCKxxgkDoGs6YSB8dUha6cZEVbAnSfY1mflMSELMJZ5QUPTVc8pPNfhmqUSM
         tWD89NpDhclzEgfB7O+gI4dpjvU0LX1ukOz1wYcqDZngozo+o5P6Lus1lVYeYSHJmJyT
         CpHFPHqGTvIucOK6CgAE0H83baPujEAZV3czHdbOUYqDkwEE0tOPMHEV+Jprl3PXKxra
         uDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=otORvzl7/EquxrHIAFf6clZzYDIdRdFY2L1POt7+dtE=;
        b=JTWGWI6zChQ2CurwAjQvvtN3O2u6tMfk5YQTTt2jBvB2BkwVQd4CIs/0rNybhcPdq7
         4tYeiJV/TCBcPpLRdX5g4nuYwOUVVDqyELQQn3V7yL0dRGjdJbCIY3EPSrzuUmO9hbOu
         pV/Jugmy+5/TYYtc8nARskpHLsJYvAVVCsxuicXfc51QwtzlusfPSlnerDGWgTDxB03a
         AaytamCXvR4giWOs/whg8OdWYsK427UHqCLpGNd22v1d0PhwUYJR9caFgS0askOKeWft
         OMkT0BZdNvOfUe/W3pxJRjv5tPTKWa6ZM4W0TaGDLy4jpTuaNLZpLz6YnzUowes1bl4g
         3hzw==
X-Gm-Message-State: AJIora/b5zxlTLU3xMA/ss4hNdQQISAJpXnw5zdfw6sQHQis6d+2atsI
        gMesQhYKLNq5sfmgAo5nuQh1c15DIWxMbSIVlXn/Vw==
X-Google-Smtp-Source: AGRyM1ug/0ApQj4GhYfSqsA4mfRREs+VIn+nkmdOelzVRMzJUN+vkwGMzAVqOdAhusjmw1ncxrN1huRgf0hp9636t4s=
X-Received: by 2002:a81:b04:0:b0:31e:594e:4e4e with SMTP id
 4-20020a810b04000000b0031e594e4e4emr15118815ywl.370.1658409238341; Thu, 21
 Jul 2022 06:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-6-kirill.shutemov@linux.intel.com> <20220713150200.17080-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220713150200.17080-1-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jul 2022 15:13:22 +0200
Message-ID: <CAG_fn=XLJNEFshpF4sVSWb0N62_tO3D2X6-vu6Piz=8Aw0Cr7Q@mail.gmail.com>
Subject: Re: [PATCHv5.1 04/13] x86/mm: Handle LAM on context switch
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Kostya Serebryany <kcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 5:02 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> The mode is selected per-thread. Add new thread features indicate that th=
e
> thread has Linear Address Masking enabled.
>
> switch_mm_irqs_off() now respects these flags and constructs CR3
> accordingly.
>
> The active LAM mode gets recorded in the tlb_state.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Alexander Potapenko <glider@google.com>

> ---
>  v5.1:
>   - Fix build issue with CONFIG_MODULE=3Dy
> ---
>  arch/x86/include/asm/mmu.h         |  3 +++
>  arch/x86/include/asm/mmu_context.h | 24 +++++++++++++++++
>  arch/x86/include/asm/tlbflush.h    | 35 +++++++++++++++++++++++++
>  arch/x86/mm/tlb.c                  | 42 +++++++++++++++++++-----------
>  4 files changed, 89 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..002889ca8978 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -40,6 +40,9 @@ typedef struct {
>
>  #ifdef CONFIG_X86_64
>         unsigned short flags;
> +
> +       /* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (dis=
abled) */
> +       unsigned long lam_cr3_mask;
>  #endif
>
>         struct mutex lock;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mm=
u_context.h
> index b8d40ddeab00..69c943b2ae90 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, =
struct mm_struct *next)
>  }
>  #endif
>
> +#ifdef CONFIG_X86_64
> +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> +{
> +       return mm->context.lam_cr3_mask;
> +}
> +
> +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm=
)
> +{
> +       mm->context.lam_cr3_mask =3D oldmm->context.lam_cr3_mask;
> +}
> +
> +#else
> +
> +static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
> +{
> +       return 0;
> +}
> +
> +static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm=
)
> +{
> +}
> +#endif
> +
>  #define enter_lazy_tlb enter_lazy_tlb
>  extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk=
);
>
> @@ -168,6 +191,7 @@ static inline int arch_dup_mmap(struct mm_struct *old=
mm, struct mm_struct *mm)
>  {
>         arch_dup_pkeys(oldmm, mm);
>         paravirt_arch_dup_mmap(oldmm, mm);
> +       dup_lam(oldmm, mm);
>         return ldt_dup_context(oldmm, mm);
>  }
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbfl=
ush.h
> index 4af5579c7ef7..efe83d33327f 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -100,6 +100,16 @@ struct tlb_state {
>          */
>         bool invalidate_other;
>
> +#ifdef CONFIG_X86_64
> +       /*
> +        * Active LAM mode.
> +        *
> +        * X86_CR3_LAM_U57/U48 shifted right by X86_CR3_LAM_U57_BIT or 0 =
if LAM
> +        * disabled.
> +        */
> +       u8 lam;
> +#endif
> +
>         /*
>          * Mask that contains TLB_NR_DYN_ASIDS+1 bits to indicate
>          * the corresponding user PCID needs a flush next time we
> @@ -356,6 +366,30 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd=
, pmd_t newpmd)
>  }
>  #define huge_pmd_needs_flush huge_pmd_needs_flush
>
> +#ifdef CONFIG_X86_64
> +static inline unsigned long tlbstate_lam_cr3_mask(void)
> +{
> +       unsigned long lam =3D this_cpu_read(cpu_tlbstate.lam);
> +
> +       return lam << X86_CR3_LAM_U57_BIT;
> +}
> +
> +static inline void set_tlbstate_cr3_lam_mask(unsigned long mask)
> +{
> +       this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
> +}
> +
> +#else
> +
> +static inline unsigned long tlbstate_lam_cr3_mask(void)
> +{
> +       return 0;
> +}
> +
> +static inline void set_tlbstate_cr3_lam_mask(u64 mask)
> +{
> +}
> +#endif
>  #endif /* !MODULE */
>
>  static inline void __native_tlb_flush_global(unsigned long cr4)
> @@ -363,4 +397,5 @@ static inline void __native_tlb_flush_global(unsigned=
 long cr4)
>         native_write_cr4(cr4 ^ X86_CR4_PGE);
>         native_write_cr4(cr4);
>  }
> +
>  #endif /* _ASM_X86_TLBFLUSH_H */
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index d400b6d9d246..4c93f87a8928 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -154,17 +154,18 @@ static inline u16 user_pcid(u16 asid)
>         return ret;
>  }
>
> -static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
> +static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned lon=
g lam)
>  {
>         if (static_cpu_has(X86_FEATURE_PCID)) {
> -               return __sme_pa(pgd) | kern_pcid(asid);
> +               return __sme_pa(pgd) | kern_pcid(asid) | lam;
>         } else {
>                 VM_WARN_ON_ONCE(asid !=3D 0);
> -               return __sme_pa(pgd);
> +               return __sme_pa(pgd) | lam;
>         }
>  }
>
> -static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
> +static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
> +                                             unsigned long lam)
>  {
>         VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
>         /*
> @@ -173,7 +174,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *=
pgd, u16 asid)
>          * boot because all CPU's the have same capabilities:
>          */
>         VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> -       return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
> +       return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
>  }
>
>  /*
> @@ -274,15 +275,16 @@ static inline void invalidate_user_asid(u16 asid)
>                   (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_f=
lush_mask));
>  }
>
> -static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
> +static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, unsigned long la=
m,
> +                           bool need_flush)
>  {
>         unsigned long new_mm_cr3;
>
>         if (need_flush) {
>                 invalidate_user_asid(new_asid);
> -               new_mm_cr3 =3D build_cr3(pgdir, new_asid);
> +               new_mm_cr3 =3D build_cr3(pgdir, new_asid, lam);
>         } else {
> -               new_mm_cr3 =3D build_cr3_noflush(pgdir, new_asid);
> +               new_mm_cr3 =3D build_cr3_noflush(pgdir, new_asid, lam);
>         }
>
>         /*
> @@ -491,6 +493,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
t mm_struct *next,
>  {
>         struct mm_struct *real_prev =3D this_cpu_read(cpu_tlbstate.loaded=
_mm);
>         u16 prev_asid =3D this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +       unsigned long prev_lam =3D tlbstate_lam_cr3_mask();
> +       unsigned long new_lam =3D mm_lam_cr3_mask(next);
>         bool was_lazy =3D this_cpu_read(cpu_tlbstate_shared.is_lazy);
>         unsigned cpu =3D smp_processor_id();
>         u64 next_tlb_gen;
> @@ -520,7 +524,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
t mm_struct *next,
>          * isn't free.
>          */
>  #ifdef CONFIG_DEBUG_VM
> -       if (WARN_ON_ONCE(__read_cr3() !=3D build_cr3(real_prev->pgd, prev=
_asid))) {
> +       if (WARN_ON_ONCE(__read_cr3() !=3D build_cr3(real_prev->pgd, prev=
_asid, prev_lam))) {
>                 /*
>                  * If we were to BUG here, we'd be very likely to kill
>                  * the system so hard that we don't see the call trace.
> @@ -622,15 +626,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, str=
uct mm_struct *next,
>                 barrier();
>         }
>
> +       set_tlbstate_cr3_lam_mask(new_lam);
>         if (need_flush) {
>                 this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->=
context.ctx_id);
>                 this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_=
tlb_gen);
> -               load_new_mm_cr3(next->pgd, new_asid, true);
> +               load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
>
>                 trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
>         } else {
>                 /* The new ASID is already up to date. */
> -               load_new_mm_cr3(next->pgd, new_asid, false);
> +               load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
>
>                 trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
>         }
> @@ -691,6 +696,10 @@ void initialize_tlbstate_and_flush(void)
>         /* Assert that CR3 already references the right mm. */
>         WARN_ON((cr3 & CR3_ADDR_MASK) !=3D __pa(mm->pgd));
>
> +       /* LAM expected to be disabled in CR3 and init_mm */
> +       WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
> +       WARN_ON(mm_lam_cr3_mask(&init_mm));
> +
>         /*
>          * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initializa=
tion
>          * doesn't work like other CR4 bits because it can only be set fr=
om
> @@ -699,8 +708,8 @@ void initialize_tlbstate_and_flush(void)
>         WARN_ON(boot_cpu_has(X86_FEATURE_PCID) &&
>                 !(cr4_read_shadow() & X86_CR4_PCIDE));
>
> -       /* Force ASID 0 and force a TLB flush. */
> -       write_cr3(build_cr3(mm->pgd, 0));
> +       /* Disable LAM, force ASID 0 and force a TLB flush. */
> +       write_cr3(build_cr3(mm->pgd, 0, 0));
>
>         /* Reinitialize tlbstate. */
>         this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT)=
;
> @@ -708,6 +717,7 @@ void initialize_tlbstate_and_flush(void)
>         this_cpu_write(cpu_tlbstate.next_asid, 1);
>         this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
>         this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
> +       set_tlbstate_cr3_lam_mask(0);
>
>         for (i =3D 1; i < TLB_NR_DYN_ASIDS; i++)
>                 this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
> @@ -1047,8 +1057,10 @@ void flush_tlb_kernel_range(unsigned long start, u=
nsigned long end)
>   */
>  unsigned long __get_current_cr3_fast(void)
>  {
> -       unsigned long cr3 =3D build_cr3(this_cpu_read(cpu_tlbstate.loaded=
_mm)->pgd,
> -               this_cpu_read(cpu_tlbstate.loaded_mm_asid));
> +       unsigned long cr3 =3D
> +               build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
> +               this_cpu_read(cpu_tlbstate.loaded_mm_asid),
> +               tlbstate_lam_cr3_mask());
>
>         /* For now, be very restrictive about when this can be called. */
>         VM_WARN_ON(in_nmi() || preemptible());
> --
> 2.35.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
