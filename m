Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2C561535
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiF3IhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiF3Ig5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:36:57 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497635AB6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:36:56 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31780ad7535so171802187b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H8l4qxX+FKw5kDPTr9scmV5acCPaGXYZJXzanXBii1A=;
        b=mEpP8utUUpXvMMgIG+q63oMs/+fUfG78I2zuAu/93kXKCCTHToMuegvexe1277Ppry
         CbPfc8VA778JgyOTs1sLYCI0AsZQaQ119tB/zGlD5qd7NPGCsyx7NNQt5pMZ750gGO8u
         tZSoMG0VC4Egx7yf/zWUiJpF353Jk85ntlPI+fkbFeIjln57gceWf9IpPh3ennWZs+Y5
         VXxyPdBeg9hbKJGeimpxxgR8cxoEgi+XVZ/DPlZBlTaq6LzsNhjzQ7IhgnzbzUZ7b4ys
         90GiM0+ZAxTJkyo51jfSw2l9uGqH9O2Bm25CyZMt6LsSgTLLAeqyP4sViphw2X+aLq3t
         KJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H8l4qxX+FKw5kDPTr9scmV5acCPaGXYZJXzanXBii1A=;
        b=xeS5wzIrAegB+lZFthbkh8NOWGFdXocG7NWo93+/zz5RYjmfKVcusVA1a4a++mfyWv
         590496FVPOyV6C7s7QyAxG/xY5GSPhKW3wf9oH8qYvF7aoFvo9ljOKExW/IzKr5AWWN5
         RE4K+3H/sXCzNiy/ls5CTo+XkVZSedyhlvzwhtItI1RG2f9QbLGu+pqhpuh6Nrje8pLe
         oi9jE466NyLhyH73Msh8jvj+mwkd+R5VuE/zwV3liDsY0uw+MCgwJJstxdwt3s8Ft8Cy
         vs+Aiq2+Yn4QU7vCmDxNxWaoGEnD8K8h82EHmc8npr9OZ1iTx28yT1QvmSQQvpWgDSqD
         QzKA==
X-Gm-Message-State: AJIora+bN0Stbje37bVftIxLAhhZQ6tVxAwMQmqfdUFJNC47GGTst3Ng
        r6LdjNa+QrxDlG1LQ14YfVPALBpoQmUnc9HxkuwaiA==
X-Google-Smtp-Source: AGRyM1tQHi4YuCctgXJD0lEAmUA6q7mN0lEicoQe3Xg6/U3SVP4Dcd++mhi9vVj60vOlNIqi2Ajx+fi20IPABwmMuqY=
X-Received: by 2002:a81:e0b:0:b0:31c:1b57:2509 with SMTP id
 11-20020a810e0b000000b0031c1b572509mr9193338ywo.461.1656578215624; Thu, 30
 Jun 2022 01:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com> <20220622162230.83474-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220622162230.83474-5-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 30 Jun 2022 10:36:19 +0200
Message-ID: <CAG_fn=UhOYXHqYjzytjp9vx3w9rN=tfh1sY_=bLRYmj_fAJ+Hw@mail.gmail.com>
Subject: Re: [PATCHv4 4/8] x86/mm: Handle LAM on context switch
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Jun 22, 2022 at 6:22 PM Kirill A. Shutemov
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
> ---
>  arch/x86/include/asm/mmu.h         |  1 +
>  arch/x86/include/asm/mmu_context.h | 24 +++++++++++
>  arch/x86/include/asm/tlbflush.h    |  4 ++
>  arch/x86/mm/tlb.c                  | 68 +++++++++++++++++++++++-------
>  4 files changed, 82 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 5d7494631ea9..d150e92163b6 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -40,6 +40,7 @@ typedef struct {
>
>  #ifdef CONFIG_X86_64
>         unsigned short flags;
> +       u64 lam_cr3_mask;
>  #endif

Can you please add a comment for this field?

>
>         struct mutex lock;
> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mm=
u_context.h
> index b8d40ddeab00..e6eac047c728 100644
> --- a/arch/x86/include/asm/mmu_context.h
> +++ b/arch/x86/include/asm/mmu_context.h
> @@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, =
struct mm_struct *next)
>  }
>  #endif
>
> +#ifdef CONFIG_X86_64
> +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> +{
> +       return mm->context.lam_cr3_mask;
> +}

For the sake of uniformity, can it be either lam_cr3_mask or
cr3_lam_mask everywhere?

>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbfl=
ush.h
> index 4af5579c7ef7..2d70d75e207f 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -100,6 +100,10 @@ struct tlb_state {
>          */
>         bool invalidate_other;
>
> +#ifdef CONFIG_X86_64
> +       u8 lam;
> +#endif
> +

Comment here as well, please.

>         /*
>          * Mask that contains TLB_NR_DYN_ASIDS+1 bits to indicate
>          * the corresponding user PCID needs a flush next time we
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index d400b6d9d246..c5c4f76329c2 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -154,17 +154,17 @@ static inline u16 user_pcid(u16 asid)
>         return ret;
>  }
>
> -static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
> +static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, u64 lam)

I think it's more natural to make `lam` an unsigned long, because cr3
is treated as unsigned long everywhere.

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
> +static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid, u64 =
lam)
ditto

>  {
>         VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
>         /*
> @@ -173,7 +173,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *=
pgd, u16 asid)
>          * boot because all CPU's the have same capabilities:
>          */
>         VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> -       return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
> +       return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
>  }
>
>  /*
> @@ -274,15 +274,15 @@ static inline void invalidate_user_asid(u16 asid)
>                   (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_f=
lush_mask));
>  }
>
> -static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
> +static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, u64 lam, bool ne=
ed_flush)
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
> @@ -486,11 +486,38 @@ void cr4_update_pce(void *ignored)
>  static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
>  #endif
>
> +#ifdef CONFIG_X86_64
> +static inline u64 tlbstate_lam_cr3_mask(void)
Please add comments for these methods.
> +{
> +       u64 lam =3D this_cpu_read(cpu_tlbstate.lam);
> +
> +       return lam << X86_CR3_LAM_U57_BIT;
> +}
> +
> +static inline void set_tlbstate_lam_cr3_mask(u64 mask)
> +{
> +       this_cpu_write(cpu_tlbstate.lam, mask >> X86_CR3_LAM_U57_BIT);
> +}
> +
> +#else
> +
> +static inline u64 tlbstate_lam_cr3_mask(void)
> +{
> +       return 0;
> +}
> +
> +static inline void set_tlbstate_lam_cr3_mask(u64 mask)
> +{
> +}
> +#endif
> +
>  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                         struct task_struct *tsk)
>  {
>         struct mm_struct *real_prev =3D this_cpu_read(cpu_tlbstate.loaded=
_mm);
>         u16 prev_asid =3D this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +       u64 prev_lam =3D tlbstate_lam_cr3_mask();
> +       u64 new_lam =3D mm_cr3_lam_mask(next);

Ditto.

>         bool was_lazy =3D this_cpu_read(cpu_tlbstate_shared.is_lazy);
>         unsigned cpu =3D smp_processor_id();
>         u64 next_tlb_gen;
> @@ -504,6 +531,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
t mm_struct *next,
>          * cpu_tlbstate.loaded_mm) matches next.
>          *
>          * NB: leave_mm() calls us with prev =3D=3D NULL and tsk =3D=3D N=
ULL.
> +        *
> +        * NB: Initial LAM enabling calls us with prev =3D=3D next. We mu=
st update
> +        * CR3 if prev_lam doesn't match the new one.
>          */
>
>         /* We don't want flush_tlb_func() to run concurrently with us. */
> @@ -520,7 +550,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
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
> @@ -551,7 +581,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struc=
t mm_struct *next,
>          * provides that full memory barrier and core serializing
>          * instruction.
>          */
> -       if (real_prev =3D=3D next) {
> +       if (real_prev =3D=3D next && prev_lam =3D=3D new_lam) {

Do we want the warning checks below to only happen if prev_lam=3D=3Dnew_lam=
?

>                 VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx=
_id) !=3D
>                            next->context.ctx_id);
>
> @@ -622,15 +652,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, str=
uct mm_struct *next,
>                 barrier();
>         }
>
> +       set_tlbstate_lam_cr3_mask(new_lam);
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
> @@ -691,6 +722,10 @@ void initialize_tlbstate_and_flush(void)
>         /* Assert that CR3 already references the right mm. */
>         WARN_ON((cr3 & CR3_ADDR_MASK) !=3D __pa(mm->pgd));
>
> +       /* LAM expected to be disabled in CR3 and init_mm */
> +       WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
> +       WARN_ON(mm_cr3_lam_mask(&init_mm));
> +
>         /*
>          * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initializa=
tion
>          * doesn't work like other CR4 bits because it can only be set fr=
om
> @@ -700,7 +735,7 @@ void initialize_tlbstate_and_flush(void)
>                 !(cr4_read_shadow() & X86_CR4_PCIDE));
>
>         /* Force ASID 0 and force a TLB flush. */
Please update this comment.

> -       write_cr3(build_cr3(mm->pgd, 0));
> +       write_cr3(build_cr3(mm->pgd, 0, 0));
>
>         /* Reinitialize tlbstate. */
>         this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT)=
;
> @@ -708,6 +743,7 @@ void initialize_tlbstate_and_flush(void)
>         this_cpu_write(cpu_tlbstate.next_asid, 1);
>         this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
>         this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
> +       set_tlbstate_lam_cr3_mask(0);
>
>         for (i =3D 1; i < TLB_NR_DYN_ASIDS; i++)
>                 this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
> @@ -1047,8 +1083,10 @@ void flush_tlb_kernel_range(unsigned long start, u=
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

Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise
erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.


This e-mail is confidential. If you received this communication by
mistake, please don't forward it to anyone else, please erase all
copies and attachments, and please let me know that it has gone to the
wrong person.
