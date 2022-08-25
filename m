Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE95A122C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiHYNaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiHYNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:30:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A4D258DDC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:29:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF31BD6E;
        Thu, 25 Aug 2022 06:29:59 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.47.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08F6B3F71A;
        Thu, 25 Aug 2022 06:29:53 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:29:51 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.org.uk
Subject: Re: [PATCH 1/2] arm64/traps: Replace this_cpu_* with raw_cpu_* in
 panic_bad_stack()
Message-ID: <Ywd5T0+APXqP5PXp@FVFF77S0Q05N>
References: <20220825063154.69-1-thunder.leizhen@huawei.com>
 <20220825063154.69-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825063154.69-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:31:53PM +0800, Zhen Lei wrote:
> The hardware automatically disable the IRQ interrupt before jumping to the
> interrupt or exception vector. Therefore, the preempt_disable() operation
> in this_cpu_read() after macro expansion is unnecessary. In fact, before
> commit 8168f098867f ("arm64: entry: split bad stack entry"), the operation
> this_cpu_read() precedes arm64_enter_nmi(). If set_preempt_need_resched()
> is called before stack overflow, this_cpu_read() may trigger scheduling,
> see pseudocode below.
> 
> Pseudocode of this_cpu_read(xx) when CONFIG_PREEMPTION=y:
> preempt_disable_notrace();
> raw_cpu_read(xx);
> if (unlikely(__preempt_count_dec_and_test()))
> 	__preempt_schedule_notrace();

Ok, but in mainline we have commit 8168f098867f; so we cannot reach here
without having fiddled with the preempt count.

Are you saying that some stable kernel is broken because it lacks commit
8168f098867f? Is so, I think the right fix is to backport commit 8168f098867f,
and that is then irrelevant to this change.

> Therefore, use raw_cpu_* instead of this_cpu_* to eliminate potential
> hazards. At the very least, it reduces a few lines of assembly code.

I'm happy to use raw_cpu_*() here, to minimize the work we have to do, any any
risks with e.g. instrumentation, but as above I don't think the case mentioned
in the commit message is relevant.

Thanks,
Mark.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index b7fed33981f7b76..e6b6f4650e3d895 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -871,8 +871,8 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>  void panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigned long far)
>  {
>  	unsigned long tsk_stk = (unsigned long)current->stack;
> -	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
> -	unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
> +	unsigned long irq_stk = (unsigned long)raw_cpu_read(irq_stack_ptr);
> +	unsigned long ovf_stk = (unsigned long)raw_cpu_ptr(overflow_stack);
>  
>  	console_verbose();
>  	pr_emerg("Insufficient stack space to handle exception!");
> -- 
> 2.25.1
> 
