Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465D4AD15B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346067AbiBHGLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiBHGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:11:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE82BC0401DC;
        Mon,  7 Feb 2022 22:11:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 048F2CE136D;
        Tue,  8 Feb 2022 06:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DAAC340FA;
        Tue,  8 Feb 2022 06:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644300705;
        bh=98Jh+JdWit2Ec3uBZ9fZIIVMOmAGVkhi9qoKSGmN8mE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dkarkc84bxml1mYT97ga5a+lFTT5OA3SIThy/3q5pqmFTn+KKM8Wg/T9xSG65SqlF
         WLPC5nfYthRwdLylQ3ozJKWc5Tvp6yGUIofsIZlxG4v0KCS6gYJYZPIeo/F4MgOlTJ
         Q7H/dx9Mbl7Mn6qjOOUcEdADy2vJgJh+vOdGgX1ZZtLQZWWDJ2E8zNNoDMp0uLvrGS
         0fec9ZljUZ42rP+thwv1TLb4835/iY1wMkbYXnK1osqEJFPOXkcwjHqPwYaB1V0ROv
         gLVs9OBYLHSqGC7finXbpaw8HivhQcd0m0xpbpN7bV/shGYT8WaGdn+NO9dLe5h3kq
         sgjpEzPLES1QQ==
Received: by mail-vs1-f48.google.com with SMTP id g10so2258313vss.1;
        Mon, 07 Feb 2022 22:11:45 -0800 (PST)
X-Gm-Message-State: AOAM530JkzbCupbTvdOoKjzq/IYazaNil5n7yMzP8T0KvBdAuf/snDU5
        Bt5j0Ly/h1FCrQOuf6hc7c8zt9qZr4mcy1hk34o=
X-Google-Smtp-Source: ABdhPJyoKG0uf9goGLZSjJNhyKf+bvy86AJ6ENV92VZKmmSAQhXAV+vpsm1T7Vkj70pF26s11ZlBhJpkUaWtRESj8gk=
X-Received: by 2002:a67:ec4e:: with SMTP id z14mr1017480vso.8.1644300703865;
 Mon, 07 Feb 2022 22:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20220126114452.692512-1-apatel@ventanamicro.com> <20220126114452.692512-3-apatel@ventanamicro.com>
In-Reply-To: <20220126114452.692512-3-apatel@ventanamicro.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 8 Feb 2022 14:11:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQPC0-VHdwayu96UTWY5GOePLZ5dCH1z8vhseLVztr3jQ@mail.gmail.com>
Message-ID: <CAJF2gTQPC0-VHdwayu96UTWY5GOePLZ5dCH1z8vhseLVztr3jQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/8] RISC-V: Rename relocate() and make it global
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>,
        Anup Patel <anup@brainfault.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvm-riscv@lists.infradead.org
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

On Wed, Jan 26, 2022 at 7:46 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> From: Anup Patel <anup.patel@wdc.com>
>
> The low-level relocate() function enables mmu and relocates
> execution to link-time addresses. We rename relocate() function
> to relocate_enable_mmu() function which is more informative.
>
> Also, the relocate_enable_mmu() function will be used in the
> resume path when a CPU wakes-up from a non-retentive suspend
> so we make it global symbol.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kernel/head.S | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 2363b43312fc..5f4c6b6c4974 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -90,7 +90,8 @@ pe_head_start:
>
>  .align 2
>  #ifdef CONFIG_MMU
> -relocate:
> +       .global relocate_enable_mmu
> +relocate_enable_mmu:
>         /* Relocate return address */
>         la a1, kernel_map
>         XIP_FIXUP_OFFSET a1
> @@ -185,7 +186,7 @@ secondary_start_sbi:
>         /* Enable virtual memory and relocate to virtual address */
>         la a0, swapper_pg_dir
>         XIP_FIXUP_OFFSET a0
> -       call relocate
> +       call relocate_enable_mmu
>  #endif
>         call setup_trap_vector
>         tail smp_callin
> @@ -329,7 +330,7 @@ clear_bss_done:
>  #ifdef CONFIG_MMU
>         la a0, early_pg_dir
>         XIP_FIXUP_OFFSET a0
> -       call relocate
> +       call relocate_enable_mmu
>  #endif /* CONFIG_MMU */
>
>         call setup_trap_vector
> --
> 2.25.1
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
