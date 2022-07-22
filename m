Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BFE57DD13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiGVJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiGVJEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E67E306
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5723A61ED5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7DFC341C6;
        Fri, 22 Jul 2022 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658480686;
        bh=Ky+XxKWde+Zen/5MBVzZaHKroh71kf4j7DurO22Gs+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r5gRNpuZViNHDGqJerrx9Xou6azKr+P9WSk5KHyGnehmQFHdzl6XvnKlY04uQhKYj
         8lfeDw6lJYLB7nWniTW48JV0FsIKsL8kzb4YsUPf4oNzZhTcMnWkpM6PPSoZYVBgcc
         9LJtSyAztfqECbnAvx9FL4CU1sAoZQGqx7LNo9QhoTo91hzhmpcFM+MUo3ouNGXVKN
         qpOtXJVmPm5ODo/3qgnOWxmMIewF+oZ13eBPf0qonE+ZMMS3M4mmntbxi+Bn4RlsZv
         zITMB7PJfVxePttP2AEkxXDUDBQDC0aACpJRvX5Bgjz9aZH2jxSclG+ps5JyaThtKt
         ttKgLsMfwl3sQ==
Date:   Fri, 22 Jul 2022 10:04:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     arnd@arndb.de, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: run softirqs on the per-CPU IRQ stack
Message-ID: <20220722090440.GB18125@willie-the-truck>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
 <20220708094950.41944-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708094950.41944-2-zhengqi.arch@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 05:49:49PM +0800, Qi Zheng wrote:
> Currently arm64 supports per-CPU IRQ stack, but softirqs
> are still handled in the task context.
> 
> Since any call to local_bh_enable() at any level in the task's
> call stack may trigger a softirq processing run, which could
> potentially cause a task stack overflow if the combined stack
> footprints exceed the stack's size, let's run these softirqs
> on the IRQ stack as well.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/arm64/Kconfig      |  1 +
>  arch/arm64/kernel/irq.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4c1e1d2d2f8b..be0a9f0052ee 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -230,6 +230,7 @@ config ARM64
>  	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
>  	select TRACE_IRQFLAGS_SUPPORT
>  	select TRACE_IRQFLAGS_NMI_SUPPORT
> +	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index bda49430c9ea..c36ad20a52f3 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -22,6 +22,7 @@
>  #include <linux/vmalloc.h>
>  #include <asm/daifflags.h>
>  #include <asm/vmap_stack.h>
> +#include <asm/exception.h>
>  
>  /* Only access this in an NMI enter/exit */
>  DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
> @@ -71,6 +72,18 @@ static void init_irq_stacks(void)
>  }
>  #endif
>  
> +#ifndef CONFIG_PREEMPT_RT
> +static void ____do_softirq(struct pt_regs *regs)
> +{
> +	__do_softirq();
> +}
> +
> +void do_softirq_own_stack(void)
> +{
> +	call_on_irq_stack(NULL, ____do_softirq);
> +}
> +#endif

Acked-by: Will Deacon <will@kernel.org>

Please can you repost this at -rc1 and we can queue it up for 5.21?

Thanks,

Will
