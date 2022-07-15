Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2717B57659D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiGORCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiGORCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:02:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B282F86
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:02:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6E7662223
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59449C34115;
        Fri, 15 Jul 2022 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657904536;
        bh=RneAB0zwL0Agua+ah8JJepJ4SyYzz9VQDMDzjZbNKm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewKkhklagPG8bQsRIeV3HeDAxKqJKsZpn4wuGiaNLGKmjYwWs6iDNwf6G+5acFVzZ
         nG9wSPVDoxMoluF8DqomLr8B8IUG3RQQ6Oz9hiWwB3BwknxTNP3fNRKp/nkC8800Ec
         JRL6S5V5HqPSR/bZCeSBObFRW5bTniT3msAfPWcsfSgYa7JuP9/SMvJ3y82TXydOEj
         oyUYKn7QMBvzwH730YcR2yCM1u2Ivh/yeLSWEsISJp3z4Xc5OfHU6xBxGndI/maZOp
         +a97+6bMd8Rypk9eK8NoDLIa+VD956MR8efgMH6NCPqf//Y+564ZNPQ6LG9vVfHLZ3
         St0qO1l9uYHXA==
Date:   Sat, 16 Jul 2022 00:53:18 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v5 2/2] riscv: turn pgtable_l4|[l5]_enabled to static key
 for RV64
Message-ID: <YtGbfmEl7/IkQxZp@xhacker>
References: <20220715134847.2190-1-jszhang@kernel.org>
 <20220715134847.2190-3-jszhang@kernel.org>
 <CAJM55Z8JCePV8YRheyrsO1qQie79NM_-w-cYbNaJy-HLOtPfrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJM55Z8JCePV8YRheyrsO1qQie79NM_-w-cYbNaJy-HLOtPfrw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 05:04:38PM +0200, Emil Renner Berthing wrote:
> On Fri, 15 Jul 2022 at 15:59, Jisheng Zhang <jszhang@kernel.org> wrote:
> > On a specific HW platform, pgtable_l4|[l5]_enabled won't change after
> > boot, and the check sits at hot code path, this characteristic makes it
> > suitable for optimization with static key.
> >
> > _pgtable_l4|[l5]_enabled is used very early during boot, even is used
> > with MMU off, so the static key mechanism isn't ready. For this case,
> > we use another static key _pgtable_lx_ready to indicate whether we
> > have finalised pgtable_l4|[l5]_enabled or not, then fall back to
> > _pgtable_l4|[l5]_enabled_early bool.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > ---
> >  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
> >  arch/riscv/include/asm/pgtable-32.h |  3 ++
> >  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
> >  arch/riscv/include/asm/pgtable.h    |  5 +--
> >  arch/riscv/kernel/cpu.c             |  4 +-
> >  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
> >  arch/riscv/mm/kasan_init.c          | 16 ++++----
> >  7 files changed, 103 insertions(+), 65 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> > index 947f23d7b6af..0280eeb4756f 100644
> > --- a/arch/riscv/include/asm/pgalloc.h
> > +++ b/arch/riscv/include/asm/pgalloc.h
> > @@ -41,7 +41,7 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
> >
> >  static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
> >  {
> > -       if (pgtable_l4_enabled) {
> > +       if (pgtable_l4_enabled()) {
> >                 unsigned long pfn = virt_to_pfn(pud);
> >
> >                 set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> > @@ -51,7 +51,7 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
> >  static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
> >                                      pud_t *pud)
> >  {
> > -       if (pgtable_l4_enabled) {
> > +       if (pgtable_l4_enabled()) {
> >                 unsigned long pfn = virt_to_pfn(pud);
> >
> >                 set_p4d_safe(p4d,
> > @@ -61,7 +61,7 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
> >
> >  static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
> >  {
> > -       if (pgtable_l5_enabled) {
> > +       if (pgtable_l5_enabled()) {
> >                 unsigned long pfn = virt_to_pfn(p4d);
> >
> >                 set_pgd(pgd, __pgd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> > @@ -71,7 +71,7 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4d)
> >  static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
> >                                      p4d_t *p4d)
> >  {
> > -       if (pgtable_l5_enabled) {
> > +       if (pgtable_l5_enabled()) {
> >                 unsigned long pfn = virt_to_pfn(p4d);
> >
> >                 set_pgd_safe(pgd,
> > @@ -82,7 +82,7 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
> >  #define pud_alloc_one pud_alloc_one
> >  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  {
> > -       if (pgtable_l4_enabled)
> > +       if (pgtable_l4_enabled())
> >                 return __pud_alloc_one(mm, addr);
> >
> >         return NULL;
> > @@ -91,7 +91,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  #define pud_free pud_free
> >  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
> >  {
> > -       if (pgtable_l4_enabled)
> > +       if (pgtable_l4_enabled())
> >                 __pud_free(mm, pud);
> >  }
> >
> > @@ -100,7 +100,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
> >  #define p4d_alloc_one p4d_alloc_one
> >  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
> >  {
> > -       if (pgtable_l5_enabled) {
> > +       if (pgtable_l5_enabled()) {
> >                 gfp_t gfp = GFP_PGTABLE_USER;
> >
> >                 if (mm == &init_mm)
> > @@ -120,7 +120,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
> >  #define p4d_free p4d_free
> >  static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
> >  {
> > -       if (pgtable_l5_enabled)
> > +       if (pgtable_l5_enabled())
> >                 __p4d_free(mm, p4d);
> >  }
> >
> > diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> > index 59ba1fbaf784..1ef52079179a 100644
> > --- a/arch/riscv/include/asm/pgtable-32.h
> > +++ b/arch/riscv/include/asm/pgtable-32.h
> > @@ -17,6 +17,9 @@
> >
> >  #define MAX_POSSIBLE_PHYSMEM_BITS 34
> >
> > +#define pgtable_l5_enabled() 0
> > +#define pgtable_l4_enabled() 0
> > +
> >  /*
> >   * rv32 PTE format:
> >   * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> > diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> > index 5c2aba5efbd0..edfff00d8ca3 100644
> > --- a/arch/riscv/include/asm/pgtable-64.h
> > +++ b/arch/riscv/include/asm/pgtable-64.h
> > @@ -8,18 +8,38 @@
> >
> >  #include <linux/bits.h>
> >  #include <linux/const.h>
> > +#include <linux/jump_label.h>
> >  #include <asm/errata_list.h>
> >
> > -extern bool pgtable_l4_enabled;
> > -extern bool pgtable_l5_enabled;
> > +extern bool _pgtable_l5_enabled_early;
> > +extern bool _pgtable_l4_enabled_early;
> > +extern struct static_key_false _pgtable_l5_enabled;
> > +extern struct static_key_false _pgtable_l4_enabled;
> > +extern struct static_key_false _pgtable_lx_ready;
> 
> It amounts to the same, but I wonder if we ought to use the
> DECLARE_STATIC_KEY_FALSE macro here.

Thanks for the hint, will send out a newer version soon. Before
that, I will wait a bit for other review feedbacks.

Thanks
