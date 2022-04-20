Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B1508322
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376624AbiDTIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376678AbiDTIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:08:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237332620
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2861B81D73
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D16C385AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650441947;
        bh=hF/HIjYDPl5egFU81Hta0M1hnljv15hkpkIgK1CxCUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sdja9fxD4VN5bgDr44QiIzqT36noGK19gAsWEkoHgiRA5pJyhtCe8DCwxLe7P0iSV
         2lsigCuxRXXntHIkFg+/zT6PSOBDjmn+VWE+WWx5rl60oNgD6WrfSeJCBcK9tdjtDk
         qLDvbp9QslIcM55ePmrbRAje01EuJS7I1ZUWsK5N974ew7MYZAml42uDi4b1lnjzHu
         WYg3xpH1iT+MI7v0eZfKkpYQ8to4Pahyg74DA/YQMXEbLWfm6AffCIh+E2aV/ufNWo
         KxVYLZcBsYegqx2zOD1Jkl7BDHvcDC/fpjJRhIcCrWsAx8v2fdZtAbXZJBSpLDaKst
         ewMhztBCSQbMw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e5ca5c580fso1196427fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:05:47 -0700 (PDT)
X-Gm-Message-State: AOAM531d6OJ1SchQ95HLvg62YYxgzd7tO1IhT/f/dW6X//k9xXnFysz8
        A4aeZmLhN5CNBWzyZD8HJAKpMrEMrBvznzC+nL8=
X-Google-Smtp-Source: ABdhPJxkT9EWgP6EX+2m+C+wLteIHMzzhgAiKG7bRuWVe3rcbQ2uY3GucXS0tx0dyLwsUPnJGDom5DMxU8LsFZqE11o=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1074336oap.228.1650441946629; Wed, 20
 Apr 2022 01:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220415170504.3781878-1-sdonthineni@nvidia.com>
In-Reply-To: <20220415170504.3781878-1-sdonthineni@nvidia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Apr 2022 10:05:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEdp=T1NnCzgM1XstWBpu60_TKax8XXeW37oaRFgy3R7A@mail.gmail.com>
Message-ID: <CAMj1kXEdp=T1NnCzgM1XstWBpu60_TKax8XXeW37oaRFgy3R7A@mail.gmail.com>
Subject: Re: [PATCH] arm64: head: Fix cache inconsistency of the
 identity-mapped region
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 at 19:05, Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>
> The secondary cores boot is stuck due to data abort while executing the
> instruction 'ldr x8, =__secondary_switched'. The RELA value of this
> instruction was updated by a primary boot core from __relocate_kernel()
> but those memory updates are not visible to CPUs after calling
> switch_to_vhe() causing problem.
>
> The cacheable/shareable attributes of the identity-mapped regions are
> different while CPU executing in EL1 (MMU enabled) and for a short period
> of time in hyp-stub (EL2-MMU disabled). As per the ARM-ARM specification
> (DDI0487G_b), this is not allowed.
>
> G5.10.3 Cache maintenance requirement:
>  "If the change affects the cacheability attributes of the area of memory,
>  including any change between Write-Through and Write-Back attributes,
>  software must ensure that any cached copies of affected locations are
>  removed from the caches, typically by cleaning and invalidating the
>  locations from the levels of cache that might hold copies of the locations
>  affected by the attribute change."
>
> Clean+invalidate the identity-mapped region till PoC before switching to
> VHE world to fix the cache inconsistency.
>
> Problem analysis with disassembly (vmlinux):
>  1) Both __primary_switch() and enter_vhe() are part of the identity region
>  2) RELA entries and enter_vhe() are sharing the same cache line fff800010970480
>  3) Memory ffff800010970484-ffff800010970498 is updated with EL1-MMU enabled
>  4) CPU fetches intrsuctions of enter_vhe() with EL2-MMU disabled
>    - Non-coherent access causing the cache line fff800010970480 drop
>  5) Secondary core executes 'ldr x8, __secondary_switched'
>    - Getting data abort because of the incorrect value at ffff800010970488
>
> ffff800010970418 <__primary_switch>:
> ffff800010970418:  d503245f  bti  c
> ffff80001097041c:  aa0003f3  mov  x19, x0
> ffff800010970420:  d5381014  mrs  x20, sctlr_el1
> ffff800010970424:  90003c81  adrp x1, ffff800011100000 <init_pg_dir>
> ffff800010970428:  97ffffc4  bl   ffff800010970338 <__enable_mmu>
> ffff80001097042c:  97ffffe8  bl   ffff8000109703cc <__relocate_kernel>
> ffff800010970430:  58000308  ldr  x8, ffff800010970490 <__primary_switch+0x78>
> ffff800010970434:  90ffb480  adrp x0, ffff800010000000 <_text>
> ffff800010970438:  d63f0100  blr  x8
> ffff80001097043c:  d5033fdf  isb
> ffff800010970440:  d5181014  msr  sctlr_el1, x20
> ffff800010970444:  d5033fdf  isb
> ffff800010970448:  940f7efe  bl   ffff800010d50040 <__create_page_tables>
> ffff80001097044c:  d508871f  tlbi vmalle1
> ffff800010970450:  d503379f  dsb  nsh
> ffff800010970454:  d5033fdf  isb
> ffff800010970458:  d5181013  msr  sctlr_el1, x19
> ffff80001097045c:  d5033fdf  isb
> ffff800010970460:  d508751f  ic   iallu
> ffff800010970464:  d503379f  dsb  nsh
> ffff800010970468:  d5033fdf  isb
> ffff80001097046c:  97ffffd8  bl   ffff8000109703cc <__relocate_kernel>
> ffff800010970470:  58000108  ldr  x8, ffff800010970490 <__primary_switch+0x78>
> ffff800010970474:  90ffb480  adrp x0, ffff800010000000 <_text>
> ffff800010970478:  d61f0100  br   x8
> ffff80001097047c:  00df10c8  .word   0x00df10c8
> ffff800010970480:  000dfba8  .word   0x000dfba8
>         ...
> ffff800010970498:  d51cd041  msr  tpidr_el2, x1
> ffff80001097049c:  d503201f  nop
>
> ffff8000109704a0 <enter_vhe>:
> ffff8000109704a0:  d508871f  tlbi vmalle1
> ffff8000109704a4:  d503379f  dsb  nsh
> ffff8000109704a8:  d5033fdf  isb
> ffff8000109704ac:  d53d1000  mrs  x0, sctlr_el12
> ffff8000109704b0:  d5181000  msr  sctlr_el1, x0
> ffff8000109704b4:  d5033fdf  isb
> ffff8000109704b8:  d508751f  ic   iallu
> ffff8000109704bc:  d503379f  dsb  nsh
> ffff8000109704c0:  d5033fdf  isb
> ffff8000109704c4:  d2a60a00  mov  x0, #0x30500000
> ffff8000109704c8:  f2810000  movk x0, #0x800
> ffff8000109704cc:  d51d1000  msr  sctlr_el12, x0
> ffff8000109704d0:  aa1f03e0  mov  x0, xzr
> ffff8000109704d4:  d69f03e0  eret
>
> ffff800010961850 <mutate_to_vhe>:
> ffff800010961850: d53c1001   mrs  x1, sctlr_el2
> ffff800010961854: 370001c1   tbnz w1, #0, ffff80001096188c <mutate_to_vhe+0x3c>
> ffff800010961858: d5380721   mrs  x1, id_aa64mmfr1_el1
> ...
> ffff80001096190c: aa010000   orr  x0, x0, x1
> ffff800010961910: d5184000   msr  spsr_el1, x0
> ffff800010961914: 14003ae3   b    ffff8000109704a0 <enter_vhe>
>
> ffff800010970270 <secondary_startup>:
> ffff800010970270: d503245f  bti  c
> ffff800010970274: 97dab23a  bl   ffff80001001cb5c <switch_to_vhe>
> ffff800010970278: 94000049  bl   ffff80001097039c <__cpu_secondary_check52bitva>
> ffff80001097027c: 94000145  bl   ffff800010970790 <__cpu_setup>
> ffff800010970280: 90001e81  adrp x1, ffff800010d40000 <swapper_pg_dir>
> ffff800010970284: 9400002d  bl   ffff800010970338 <__enable_mmu>
> ffff800010970288: 58001008  ldr  x8, ffff800010970488 <__primary_switch+0x70>
> ffff80001097028c: d61f0100  br   x8
>
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  arch/arm64/kernel/head.S | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 6a98f1a38c29a..b5786163697bb 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -462,6 +462,16 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>         ldp     x29, x30, [sp], #16             // we must enable KASLR, return
>         ret                                     // to __primary_switch()
>  0:
> +#endif
> +#ifdef CONFIG_RELOCATABLE
> +       /*
> +        * Since the RELA entries of the identity-mapped region are updated
> +        * with MMU enabled, clean and invalidate those entries to avoid
> +        * cache inconsistency while accessing with MMU disabled in hyp-stub.
> +        */
> +       adrp    x0, __idmap_text_start
> +       adr_l   x1, __idmap_text_end
> +       bl      dcache_clean_inval_poc
>  #endif
>         bl      switch_to_vhe                   // Prefer VHE if possible
>         ldp     x29, x30, [sp], #16

Thanks for the elaborate report.

I'd prefer to fix this by moving the literal out of the ID map
entirely. Does the below also fix your issue?

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6a98f1a38c29..97134d6f78ff 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -639,10 +639,15 @@ SYM_FUNC_START_LOCAL(secondary_startup)
        bl      __cpu_setup                     // initialise processor
        adrp    x1, swapper_pg_dir
        bl      __enable_mmu
-       ldr     x8, =__secondary_switched
+       ldr_l   x8, .L__secondary_switched
        br      x8
 SYM_FUNC_END(secondary_startup)

+       .pushsection ".rodata", "a", %progbits
+.L__secondary_switched:
+       .quad   __secondary_switched
+       .popsection
+
 SYM_FUNC_START_LOCAL(__secondary_switched)
        adr_l   x5, vectors
        msr     vbar_el1, x5
