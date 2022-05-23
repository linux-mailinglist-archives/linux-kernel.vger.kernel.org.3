Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10447531318
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiEWQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiEWQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:03:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3BF2CC95
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:02:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r23so22083129wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frxPXQYmrAGuijd61tPgMpvjiT1YwuWLYRRERgQ0XGo=;
        b=nLueCmTpxJDSkHWgjeTxwio1gSDDIPXpo2tTtWJk+ky7WbNQxLXyjI3KwgNuxjKzHA
         NCaWLnwcfdFbiO+6lsM+KzlYfNQF4SsyTbFj9q0BzyW8D/isRmyN3rf1V8SXVWiqGiti
         4EiyY6D1GBTgFXYEQxnmq2zDICaQSRdA/H2u5xcfy8J8h9L0D+gDxbXWE3MsdABpaJIE
         uSR0odPs96DqnlXR4oVuZHIFjbSZ/vIpl4VVqxBPeMK4YAQ3aSIQsfk+zQtkEuJhso9t
         /PMOqafrOy+7xveK7jg9ujI/eVXBi9f/ECoUVx2D8ytd3RlZVcrNZ+ikQeA5+REACley
         8UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frxPXQYmrAGuijd61tPgMpvjiT1YwuWLYRRERgQ0XGo=;
        b=zboTI8XPwWU1dGVZPkI2yiYuCzLb7H5xsLmiSzd8oFQ6TZToPYUO0nd/D0Bhbb4Igt
         kPxkhEk2UmTo3Sa78Xr5EoGf/xexHc90oN55HyUYhb7zMtrADhn4ZccFa7fieEAxt+Fx
         9jQFeQtLrSBrFXvuSS18yUL4FFDHr9jA0y8L2z6ECC3FI/IgJ5SiK68JcAVL/RqEO3fS
         q+29Uojf5F/jUVUmD4xrNIoggS4ULySydcBj6lnqwe7HF885ISDqb1rmy89KPet1/kZ/
         5wzSvgMfLckXg5pCV/9ee5SC9M0dTiyVaoI4bKNkqRg2FsfdDEU2fmF9XsfJGF/rY8dP
         Cxmw==
X-Gm-Message-State: AOAM530VWfYu9k1PomePVZSLljzFInWAM+pzvvliZmUU0W1KUpengcio
        tg6DDrTvUgSmfEfsmEjbbEPttasbEUZj5eP01S06rA==
X-Google-Smtp-Source: ABdhPJwotj5IluLHaa4o8yUdcWy5SPFmNRDG5ZrRqiwVsjkjAyqTPzX0gyaxu2Rg/xfhEF2kUdvZmHOICiBcw35c2hc=
X-Received: by 2002:adf:d1ca:0:b0:20f:ca28:27cf with SMTP id
 b10-20020adfd1ca000000b0020fca2827cfmr9453901wrd.86.1653321777954; Mon, 23
 May 2022 09:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220519155918.3882-1-jszhang@kernel.org> <20220519155918.3882-3-jszhang@kernel.org>
In-Reply-To: <20220519155918.3882-3-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 23 May 2022 21:32:46 +0530
Message-ID: <CAAhSdy1qUukKxSBiVeHNGo84qqf-O54-Mx574VTQwb3LGF-pPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: turn pgtable_l4|[l5]_enabled to static key
 for RV64
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 9:38 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> On a specific HW platform, pgtable_l4|[l5]_enabled won't change after
> boot, and the check sits at hot code path, this characteristic makes it
> suitable for optimization with static key.
>
> _pgtable_l4|[l5]_enabled is used very early during boot, even is used
> with MMU off, so the static key mechanism isn't ready. For this case,
> we use another static key _pgtable_lx_ready to indicate whether we
> have finalised pgtable_l4|[l5]_enabled or not, then fall back to
> _pgtable_l4|[l5]_enabled_early bool.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Overall, this patch looks good to me. Please fix the errors reported by
autobuilders.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
>  arch/riscv/include/asm/pgtable-32.h |  3 ++
>  arch/riscv/include/asm/pgtable-64.h | 59 +++++++++++++++++---------
>  arch/riscv/include/asm/pgtable.h    |  5 +--
>  arch/riscv/kernel/cpu.c             |  4 +-
>  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
>  arch/riscv/mm/kasan_init.c          | 16 ++++----
>  7 files changed, 102 insertions(+), 65 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 947f23d7b6af..0280eeb4756f 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -41,7 +41,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>
>  static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
>  {
> -       if (pgtable_l4_enabled) {
> +       if (pgtable_l4_enabled()) {
>                 unsigned long pfn = virt_to_pfn(pud);
>
>                 set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> @@ -51,7 +51,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
>  static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
>                                      pud_t *pud)
>  {
> -       if (pgtable_l4_enabled) {
> +       if (pgtable_l4_enabled()) {
>                 unsigned long pfn = virt_to_pfn(pud);
>
>                 set_p4d_safe(p4d,
> @@ -61,7 +61,7 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
>
>  static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
>  {
> -       if (pgtable_l5_enabled) {
> +       if (pgtable_l5_enabled()) {
>                 unsigned long pfn = virt_to_pfn(p4d);
>
>                 set_pgd(pgd, __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> @@ -71,7 +71,7 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
>  static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
>                                      p4d_t *p4d)
>  {
> -       if (pgtable_l5_enabled) {
> +       if (pgtable_l5_enabled()) {
>                 unsigned long pfn = virt_to_pfn(p4d);
>
>                 set_pgd_safe(pgd,
> @@ -82,7 +82,7 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
>  #define pud_alloc_one pud_alloc_one
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return __pud_alloc_one(mm, addr);
>
>         return NULL;
> @@ -91,7 +91,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  #define pud_free pud_free
>  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 __pud_free(mm, pud);
>  }
>
> @@ -100,7 +100,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  #define p4d_alloc_one p4d_alloc_one
>  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -       if (pgtable_l5_enabled) {
> +       if (pgtable_l5_enabled()) {
>                 gfp_t gfp = GFP_PGTABLE_USER;
>
>                 if (mm == &init_mm)
> @@ -120,7 +120,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  #define p4d_free p4d_free
>  static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 __p4d_free(mm, p4d);
>  }
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index 5b2e79e5bfa5..8af36d76b70d 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -16,4 +16,7 @@
>
>  #define MAX_POSSIBLE_PHYSMEM_BITS 34
>
> +#define pgtable_l5_enabled() 0
> +#define pgtable_l4_enabled() 0
> +
>  #endif /* _ASM_RISCV_PGTABLE_32_H */
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7e246e9f8d70..c56bbeacd369 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -8,16 +8,35 @@
>
>  #include <linux/const.h>
>
> -extern bool pgtable_l4_enabled;
> -extern bool pgtable_l5_enabled;
> +extern bool _pgtable_l5_enabled_early;
> +extern bool _pgtable_l4_enabled_early;
> +extern struct static_key_false _pgtable_l5_enabled;
> +extern struct static_key_false _pgtable_l4_enabled;
> +extern struct static_key_false _pgtable_lx_ready;
> +
> +static __always_inline bool pgtable_l5_enabled(void)
> +{
> +       if (static_branch_likely(&_pgtable_lx_ready))
> +               return static_branch_likely(&_pgtable_l5_enabled);
> +       else
> +               return _pgtable_l5_enabled_early;
> +}
> +
> +static __always_inline bool pgtable_l4_enabled(void)
> +{
> +       if (static_branch_likely(&_pgtable_lx_ready))
> +               return static_branch_likely(&_pgtable_l4_enabled);
> +       else
> +               return _pgtable_l4_enabled_early;
> +}
>
>  #define PGDIR_SHIFT_L3  30
>  #define PGDIR_SHIFT_L4  39
>  #define PGDIR_SHIFT_L5  48
>  #define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
>
> -#define PGDIR_SHIFT     (pgtable_l5_enabled ? PGDIR_SHIFT_L5 : \
> -               (pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
> +#define PGDIR_SHIFT     (pgtable_l5_enabled() ? PGDIR_SHIFT_L5 : \
> +               (pgtable_l4_enabled() ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3))
>  /* Size of region mapped by a page global directory */
>  #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
>  #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
> @@ -119,7 +138,7 @@ static inline struct page *pud_page(pud_t pud)
>  #define mm_p4d_folded  mm_p4d_folded
>  static inline bool mm_p4d_folded(struct mm_struct *mm)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 return false;
>
>         return true;
> @@ -128,7 +147,7 @@ static inline bool mm_p4d_folded(struct mm_struct *mm)
>  #define mm_pud_folded  mm_pud_folded
>  static inline bool mm_pud_folded(struct mm_struct *mm)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return false;
>
>         return true;
> @@ -159,7 +178,7 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
>
>  static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 *p4dp = p4d;
>         else
>                 set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
> @@ -167,7 +186,7 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
>
>  static inline int p4d_none(p4d_t p4d)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return (p4d_val(p4d) == 0);
>
>         return 0;
> @@ -175,7 +194,7 @@ static inline int p4d_none(p4d_t p4d)
>
>  static inline int p4d_present(p4d_t p4d)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return (p4d_val(p4d) & _PAGE_PRESENT);
>
>         return 1;
> @@ -183,7 +202,7 @@ static inline int p4d_present(p4d_t p4d)
>
>  static inline int p4d_bad(p4d_t p4d)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return !p4d_present(p4d);
>
>         return 0;
> @@ -191,7 +210,7 @@ static inline int p4d_bad(p4d_t p4d)
>
>  static inline void p4d_clear(p4d_t *p4d)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 set_p4d(p4d, __p4d(0));
>  }
>
> @@ -207,7 +226,7 @@ static inline unsigned long _p4d_pfn(p4d_t p4d)
>
>  static inline pud_t *p4d_pgtable(p4d_t p4d)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
>
>         return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
> @@ -224,7 +243,7 @@ static inline struct page *p4d_page(p4d_t p4d)
>  #define pud_offset pud_offset
>  static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
>  {
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 return p4d_pgtable(*p4d) + pud_index(address);
>
>         return (pud_t *)p4d;
> @@ -232,7 +251,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
>
>  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 *pgdp = pgd;
>         else
>                 set_p4d((p4d_t *)pgdp, (p4d_t){ pgd_val(pgd) });
> @@ -240,7 +259,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>
>  static inline int pgd_none(pgd_t pgd)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 return (pgd_val(pgd) == 0);
>
>         return 0;
> @@ -248,7 +267,7 @@ static inline int pgd_none(pgd_t pgd)
>
>  static inline int pgd_present(pgd_t pgd)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 return (pgd_val(pgd) & _PAGE_PRESENT);
>
>         return 1;
> @@ -256,7 +275,7 @@ static inline int pgd_present(pgd_t pgd)
>
>  static inline int pgd_bad(pgd_t pgd)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 return !pgd_present(pgd);
>
>         return 0;
> @@ -264,13 +283,13 @@ static inline int pgd_bad(pgd_t pgd)
>
>  static inline void pgd_clear(pgd_t *pgd)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 set_pgd(pgd, __pgd(0));
>  }
>
>  static inline p4d_t *pgd_pgtable(pgd_t pgd)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 return (p4d_t *)pfn_to_virt(pgd_val(pgd) >> _PAGE_PFN_SHIFT);
>
>         return (p4d_t *)p4d_pgtable((p4d_t) { pgd_val(pgd) });
> @@ -288,7 +307,7 @@ static inline struct page *pgd_page(pgd_t pgd)
>  #define p4d_offset p4d_offset
>  static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
>  {
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 return pgd_pgtable(*pgd) + p4d_index(address);
>
>         return (p4d_t *)pgd;
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 046b44225623..ae01a9b83ac4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -63,8 +63,8 @@
>   * position vmemmap directly below the VMALLOC region.
>   */
>  #ifdef CONFIG_64BIT
> -#define VA_BITS                (pgtable_l5_enabled ? \
> -                               57 : (pgtable_l4_enabled ? 48 : 39))
> +#define VA_BITS                (pgtable_l5_enabled() ? \
> +                               57 : (pgtable_l4_enabled() ? 48 : 39))
>  #else
>  #define VA_BITS                32
>  #endif
> @@ -738,7 +738,6 @@ extern uintptr_t _dtb_early_pa;
>  #define dtb_early_pa   _dtb_early_pa
>  #endif /* CONFIG_XIP_KERNEL */
>  extern u64 satp_mode;
> -extern bool pgtable_l4_enabled;
>
>  void paging_init(void);
>  void misc_mem_init(void);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..29bb0ef75248 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -141,9 +141,9 @@ static void print_mmu(struct seq_file *f)
>  #if defined(CONFIG_32BIT)
>         strncpy(sv_type, "sv32", 5);
>  #elif defined(CONFIG_64BIT)
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 strncpy(sv_type, "sv57", 5);
> -       else if (pgtable_l4_enabled)
> +       else if (pgtable_l4_enabled())
>                 strncpy(sv_type, "sv48", 5);
>         else
>                 strncpy(sv_type, "sv39", 5);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 05ed641a1134..42c79388e6fd 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -44,10 +44,16 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
>  #endif
>  EXPORT_SYMBOL(satp_mode);
>
> -bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> -bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> -EXPORT_SYMBOL(pgtable_l4_enabled);
> -EXPORT_SYMBOL(pgtable_l5_enabled);
> +DEFINE_STATIC_KEY_FALSE(_pgtable_l4_enabled);
> +DEFINE_STATIC_KEY_FALSE(_pgtable_l5_enabled);
> +DEFINE_STATIC_KEY_FALSE(_pgtable_lx_ready);
> +EXPORT_SYMBOL(_pgtable_l4_enabled);
> +EXPORT_SYMBOL(_pgtable_l5_enabled);
> +EXPORT_SYMBOL(_pgtable_lx_ready);
> +bool _pgtable_l4_enabled_early = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> +bool _pgtable_l5_enabled_early = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
> +EXPORT_SYMBOL(_pgtable_l4_enabled_early);
> +EXPORT_SYMBOL(_pgtable_l5_enabled_early);
>
>  phys_addr_t phys_ram_base __ro_after_init;
>  EXPORT_SYMBOL(phys_ram_base);
> @@ -555,26 +561,26 @@ static void __init create_p4d_mapping(p4d_t *p4dp,
>  }
>
>  #define pgd_next_t             p4d_t
> -#define alloc_pgd_next(__va)   (pgtable_l5_enabled ?                   \
> -               pt_ops.alloc_p4d(__va) : (pgtable_l4_enabled ?          \
> +#define alloc_pgd_next(__va)   (pgtable_l5_enabled() ?                 \
> +               pt_ops.alloc_p4d(__va) : (pgtable_l4_enabled() ?        \
>                 pt_ops.alloc_pud(__va) : pt_ops.alloc_pmd(__va)))
> -#define get_pgd_next_virt(__pa)        (pgtable_l5_enabled ?                   \
> -               pt_ops.get_p4d_virt(__pa) : (pgd_next_t *)(pgtable_l4_enabled ? \
> +#define get_pgd_next_virt(__pa)        (pgtable_l5_enabled() ?                 \
> +               pt_ops.get_p4d_virt(__pa) : (pgd_next_t *)(pgtable_l4_enabled() ?       \
>                 pt_ops.get_pud_virt(__pa) : (pud_t *)pt_ops.get_pmd_virt(__pa)))
>  #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)     \
> -                               (pgtable_l5_enabled ?                   \
> +                               (pgtable_l5_enabled() ?                 \
>                 create_p4d_mapping(__nextp, __va, __pa, __sz, __prot) : \
> -                               (pgtable_l4_enabled ?                   \
> +                               (pgtable_l4_enabled() ?                 \
>                 create_pud_mapping((pud_t *)__nextp, __va, __pa, __sz, __prot) :        \
>                 create_pmd_mapping((pmd_t *)__nextp, __va, __pa, __sz, __prot)))
> -#define fixmap_pgd_next                (pgtable_l5_enabled ?                   \
> -               (uintptr_t)fixmap_p4d : (pgtable_l4_enabled ?           \
> +#define fixmap_pgd_next                (pgtable_l5_enabled() ?                 \
> +               (uintptr_t)fixmap_p4d : (pgtable_l4_enabled() ?         \
>                 (uintptr_t)fixmap_pud : (uintptr_t)fixmap_pmd))
> -#define trampoline_pgd_next    (pgtable_l5_enabled ?                   \
> -               (uintptr_t)trampoline_p4d : (pgtable_l4_enabled ?       \
> +#define trampoline_pgd_next    (pgtable_l5_enabled() ?                 \
> +               (uintptr_t)trampoline_p4d : (pgtable_l4_enabled() ?     \
>                 (uintptr_t)trampoline_pud : (uintptr_t)trampoline_pmd))
> -#define early_dtb_pgd_next     (pgtable_l5_enabled ?                   \
> -               (uintptr_t)early_dtb_p4d : (pgtable_l4_enabled ?        \
> +#define early_dtb_pgd_next     (pgtable_l5_enabled() ?                 \
> +               (uintptr_t)early_dtb_p4d : (pgtable_l4_enabled() ?      \
>                 (uintptr_t)early_dtb_pud : (uintptr_t)early_dtb_pmd))
>  #else
>  #define pgd_next_t             pte_t
> @@ -680,14 +686,14 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
>  #ifdef CONFIG_64BIT
>  static void __init disable_pgtable_l5(void)
>  {
> -       pgtable_l5_enabled = false;
> +       _pgtable_l5_enabled_early = false;
>         kernel_map.page_offset = PAGE_OFFSET_L4;
>         satp_mode = SATP_MODE_48;
>  }
>
>  static void __init disable_pgtable_l4(void)
>  {
> -       pgtable_l4_enabled = false;
> +       _pgtable_l4_enabled_early = false;
>         kernel_map.page_offset = PAGE_OFFSET_L3;
>         satp_mode = SATP_MODE_39;
>  }
> @@ -816,11 +822,11 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>                            PGDIR_SIZE,
>                            IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
>
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 create_p4d_mapping(early_dtb_p4d, DTB_EARLY_BASE_VA,
>                                    (uintptr_t)early_dtb_pud, P4D_SIZE, PAGE_TABLE);
>
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
>                                    (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
>
> @@ -961,11 +967,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>
>  #ifndef __PAGETABLE_PMD_FOLDED
>         /* Setup fixmap P4D and PUD */
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 create_p4d_mapping(fixmap_p4d, FIXADDR_START,
>                                    (uintptr_t)fixmap_pud, P4D_SIZE, PAGE_TABLE);
>         /* Setup fixmap PUD and PMD */
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 create_pud_mapping(fixmap_pud, FIXADDR_START,
>                                    (uintptr_t)fixmap_pmd, PUD_SIZE, PAGE_TABLE);
>         create_pmd_mapping(fixmap_pmd, FIXADDR_START,
> @@ -973,10 +979,10 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         /* Setup trampoline PGD and PMD */
>         create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
>                            trampoline_pgd_next, PGDIR_SIZE, PAGE_TABLE);
> -       if (pgtable_l5_enabled)
> +       if (pgtable_l5_enabled())
>                 create_p4d_mapping(trampoline_p4d, kernel_map.virt_addr,
>                                    (uintptr_t)trampoline_pud, P4D_SIZE, PAGE_TABLE);
> -       if (pgtable_l4_enabled)
> +       if (pgtable_l4_enabled())
>                 create_pud_mapping(trampoline_pud, kernel_map.virt_addr,
>                                    (uintptr_t)trampoline_pmd, PUD_SIZE, PAGE_TABLE);
>  #ifdef CONFIG_XIP_KERNEL
> @@ -1165,8 +1171,18 @@ static void __init reserve_crashkernel(void)
>         crashk_res.end = crash_base + crash_size - 1;
>  }
>
> +static void __init riscv_finalise_pgtable_lx(void)
> +{
> +       if (_pgtable_l5_enabled_early)
> +               static_branch_enable(&_pgtable_l5_enabled);
> +       if (_pgtable_l4_enabled_early)
> +               static_branch_enable(&_pgtable_l4_enabled);
> +       static_branch_enable(&_pgtable_lx_ready);
> +}
> +
>  void __init paging_init(void)
>  {
> +       riscv_finalise_pgtable_lx();
>         setup_bootmem();
>         setup_vm_final();
>  }
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index a22e418dbd82..356044498e8a 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -209,15 +209,15 @@ static void __init kasan_populate_p4d(pgd_t *pgd,
>                 set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_p4d)), PAGE_TABLE));
>  }
>
> -#define kasan_early_shadow_pgd_next                    (pgtable_l5_enabled ?   \
> +#define kasan_early_shadow_pgd_next                    (pgtable_l5_enabled() ? \
>                                 (uintptr_t)kasan_early_shadow_p4d :             \
> -                                                       (pgtable_l4_enabled ?   \
> +                                                       (pgtable_l4_enabled() ? \
>                                 (uintptr_t)kasan_early_shadow_pud :             \
>                                 (uintptr_t)kasan_early_shadow_pmd))
>  #define kasan_populate_pgd_next(pgdp, vaddr, next, early)                      \
> -               (pgtable_l5_enabled ?                                           \
> +               (pgtable_l5_enabled() ?                                         \
>                 kasan_populate_p4d(pgdp, vaddr, next, early) :                  \
> -               (pgtable_l4_enabled ?                                           \
> +               (pgtable_l4_enabled() ?                                         \
>                         kasan_populate_pud(pgdp, vaddr, next, early) :          \
>                         kasan_populate_pmd((pud_t *)pgdp, vaddr, next)))
>
> @@ -274,7 +274,7 @@ asmlinkage void __init kasan_early_init(void)
>                                 (__pa((uintptr_t)kasan_early_shadow_pte)),
>                                 PAGE_TABLE));
>
> -       if (pgtable_l4_enabled) {
> +       if (pgtable_l4_enabled()) {
>                 for (i = 0; i < PTRS_PER_PUD; ++i)
>                         set_pud(kasan_early_shadow_pud + i,
>                                 pfn_pud(PFN_DOWN
> @@ -282,7 +282,7 @@ asmlinkage void __init kasan_early_init(void)
>                                         PAGE_TABLE));
>         }
>
> -       if (pgtable_l5_enabled) {
> +       if (pgtable_l5_enabled()) {
>                 for (i = 0; i < PTRS_PER_P4D; ++i)
>                         set_p4d(kasan_early_shadow_p4d + i,
>                                 pfn_p4d(PFN_DOWN
> @@ -393,9 +393,9 @@ static void __init kasan_shallow_populate_p4d(pgd_t *pgdp,
>  }
>
>  #define kasan_shallow_populate_pgd_next(pgdp, vaddr, next)                     \
> -               (pgtable_l5_enabled ?                                           \
> +               (pgtable_l5_enabled() ?                                         \
>                 kasan_shallow_populate_p4d(pgdp, vaddr, next) :                 \
> -               (pgtable_l4_enabled ?                                           \
> +               (pgtable_l4_enabled() ?                                         \
>                 kasan_shallow_populate_pud(pgdp, vaddr, next) :                 \
>                 kasan_shallow_populate_pmd(pgdp, vaddr, next)))
>
> --
> 2.34.1
>
