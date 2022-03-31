Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486644ED4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiCaH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiCaH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:27:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408BC6260
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7383DB81FDC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5CDC36AE2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648711534;
        bh=eajfDk2PxxORKuK6D9C/olyzCdI8ODkvwRz1UyNl0uQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UZwyOugygCu5H09FFjoTn0PUWeyo15QC+KuxrwjHj48XdN9dJhTghg4tlCt/+ATBw
         6+P1FzEuHs3SQj47op+AiyrDso1VH5CFhw8UB0F194/oNHwYx0gkUcb9+HJajc7Od5
         tL6l8svGZTws2fD09K/d+gkDRkUbKJgVpShhg0WXBQrVpw+WE64M3ga3jZGE0D0N+T
         YjdD8DsUhe94tMIm4OTXVi/lYAbu+MTXVeTEiHPAHR+29A6VJWBU8Id6j9FSJik7YY
         d/4X6aubRsytihn8hGYAA9KNch2Q6R8d9086P/KP7mADa6OOLVEFtKzD2rM1nbv9dX
         1rtCCI4BrJnTw==
Received: by mail-vs1-f52.google.com with SMTP id s18so24987646vsr.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:25:34 -0700 (PDT)
X-Gm-Message-State: AOAM530mTujTgfmPSktc5zwPAetTGPDRwm5uFtiSO+Jbv2eWOz4OB7rP
        0kSUsMsmpuAzv8FCS0F16GtQhVRsyBv7zuMoOl8=
X-Google-Smtp-Source: ABdhPJxRVUu+qPZuYA2iZSx9UwOk2xJTzzgsQGHBUfgrhQpELKkCPD/+kQeG2rRSnilUEFiPLQadA039p2U2GWSeLb4=
X-Received: by 2002:a05:6102:dd1:b0:325:80a9:b5d7 with SMTP id
 e17-20020a0561020dd100b0032580a9b5d7mr15446572vst.51.1648711532929; Thu, 31
 Mar 2022 00:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 31 Mar 2022 15:25:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSHhy95p8LhO7yGCgbCdrxxfRQnb+gBmRK4HkM3YskgxA@mail.gmail.com>
Message-ID: <CAJF2gTSHhy95p8LhO7yGCgbCdrxxfRQnb+gBmRK4HkM3YskgxA@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Ensure only ASIDLEN is used for sfence.vma
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, atishp@rivosinc.com,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair23@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, Mar 31, 2022 at 1:59 PM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> When we set the value of context.id using __new_context() we set both
> the asid and the current_version with this return statement in
> __new_context():
>
>     return asid | ver;
>
> This means that when local_flush_tlb_all_asid() is called with the asid
> specified from context.id we can write the incorrect value.
>
> We get away with this as hardware ignores the extra bits, as the RISC-V
> specification states:
>
> "bits SXLEN-1:ASIDMAX of the value held in rs2 are reserved for future
> standard use. Until their use is defined by a standard extension, they
> should be zeroed by software and ignored by current implementations."
>
> but it is still a bug and worth addressing as we are incorrectly setting
> extra bits.
>
> This patch uses asid_mask when calling sfence.vma to ensure the asid is
> always the correct len (ASIDLEN). This is similar to what we do in
> arch/riscv/mm/context.c.
>
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>  - Use helper function
> v2:
>  - Pass in pre-masked value
>
>  arch/riscv/include/asm/mmu_context.h | 2 ++
>  arch/riscv/mm/context.c              | 5 +++++
>  arch/riscv/mm/tlbflush.c             | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 7030837adc1a..94e82c9e17eb 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -16,6 +16,8 @@
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>         struct task_struct *task);
>
> +unsigned long get_mm_asid(struct mm_struct *mm);
> +
>  #define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev,
>                                struct mm_struct *next)
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..14aec5bacbc1 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -302,6 +302,11 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
>  #endif
>  }
>
> +unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +       return atomic_long_read(&mm->context.id) & asid_mask;
> +}
> +
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>         struct task_struct *task)
>  {
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..9c89c4951bee 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -42,7 +42,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>         /* check if the tlbflush needs to be sent to other CPUs */
>         broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>         if (static_branch_unlikely(&use_asid_allocator)) {
> -               unsigned long asid = atomic_long_read(&mm->context.id);
> +               unsigned long asid = get_mm_asid(mm);
>
>                 if (broadcast) {
>                         sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
