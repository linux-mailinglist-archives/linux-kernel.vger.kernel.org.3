Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D955A1264
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbiHYNe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbiHYNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:34:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C14DB7280
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:33:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ABA3D6E;
        Thu, 25 Aug 2022 06:32:52 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.47.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 902443F71A;
        Thu, 25 Aug 2022 06:32:46 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:32:43 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk
Subject: Re: [PATCH 2/2] ARM: Replace this_cpu_* with raw_cpu_* in
 panic_bad_stack()
Message-ID: <Ywd5+2UpWv4M5K6t@FVFF77S0Q05N>
References: <20220825063154.69-1-thunder.leizhen@huawei.com>
 <20220825063154.69-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825063154.69-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:31:54PM +0800, Zhen Lei wrote:
> The hardware automatically disable the IRQ interrupt before jumping to the
> interrupt or exception vector. Therefore, the preempt_disable() operation
> in this_cpu_read() after macro expansion is unnecessary. In fact, function
> this_cpu_read() may trigger scheduling, see pseudocode below.
> 
> Pseudocode of this_cpu_read(xx):
> preempt_disable_notrace();
> raw_cpu_read(xx);
> if (unlikely(__preempt_count_dec_and_test()))
> 	__preempt_schedule_notrace();
> 
> Therefore, use raw_cpu_* instead of this_cpu_* to eliminate potential
> hazards. At the very least, it reduces a few lines of assembly code.

I think if scheduling is a problem here, something should increment the
preempt_count as is done on arm64, since any other operation in this function
could end up causing preemption.

Regardless, I also think it's sensible to use raw_cpu_*() here, but I don't
think that actually fixes the problem the commit message describes.

Thanks,
Mark.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
> KernelVersion: v6.0-rc2
>  arch/arm/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 1518a1f443ff866..d5903d790cf3b7e 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -927,9 +927,9 @@ asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>  	unsigned long tsk_stk = (unsigned long)current->stack;
>  #ifdef CONFIG_IRQSTACKS
> -	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
> +	unsigned long irq_stk = (unsigned long)raw_cpu_read(irq_stack_ptr);
>  #endif
> -	unsigned long ovf_stk = (unsigned long)this_cpu_read(overflow_stack_ptr);
> +	unsigned long ovf_stk = (unsigned long)raw_cpu_read(overflow_stack_ptr);
>  
>  	console_verbose();
>  	pr_emerg("Insufficient stack space to handle exception!");
> -- 
> 2.25.1
> 
