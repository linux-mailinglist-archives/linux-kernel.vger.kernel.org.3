Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3607054F3AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381409AbiFQIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381396AbiFQIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:55:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3165948E64
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:55:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0375212FC;
        Fri, 17 Jun 2022 01:55:27 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.39.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 882573F792;
        Fri, 17 Jun 2022 01:55:23 -0700 (PDT)
Date:   Fri, 17 Jun 2022 09:55:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 6/8] arm64: add support for machine check error
 safe
Message-ID: <YqxBd9GfUHLWZWoh@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-7-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528065056.1034168-7-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 06:50:54AM +0000, Tong Tiangen wrote:
> During the processing of arm64 kernel hardware memory errors(do_sea()), if
> the errors is consumed in the kernel, the current processing is panic.
> However, it is not optimal.
> 
> Take uaccess for example, if the uaccess operation fails due to memory
> error, only the user process will be affected, kill the user process
> and isolate the user page with hardware memory errors is a better choice.
> 
> This patch only enable machine error check framework, it add exception
> fixup before kernel panic in do_sea() and only limit the consumption of
> hardware memory errors in kernel mode triggered by user mode processes.
> If fixup successful, panic can be avoided.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/extable.h |  1 +
>  arch/arm64/mm/extable.c          | 17 +++++++++++++++++
>  arch/arm64/mm/fault.c            | 27 ++++++++++++++++++++++++++-
>  4 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aaeb70358979..a3b12ff0cd7f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -19,6 +19,7 @@ config ARM64
>  	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>  	select ARCH_HAS_CACHE_LINE_SIZE
> +	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
>  	select ARCH_HAS_CURRENT_STACK_POINTER
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
> diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
> index 72b0e71cc3de..f80ebd0addfd 100644
> --- a/arch/arm64/include/asm/extable.h
> +++ b/arch/arm64/include/asm/extable.h
> @@ -46,4 +46,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
>  #endif /* !CONFIG_BPF_JIT */
>  
>  bool fixup_exception(struct pt_regs *regs);
> +bool fixup_exception_mc(struct pt_regs *regs);
>  #endif
> diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
> index 228d681a8715..c301dcf6335f 100644
> --- a/arch/arm64/mm/extable.c
> +++ b/arch/arm64/mm/extable.c
> @@ -9,6 +9,7 @@
>  
>  #include <asm/asm-extable.h>
>  #include <asm/ptrace.h>
> +#include <asm/esr.h>
>  
>  static inline unsigned long
>  get_ex_fixup(const struct exception_table_entry *ex)
> @@ -76,3 +77,19 @@ bool fixup_exception(struct pt_regs *regs)
>  
>  	BUG();
>  }
> +
> +bool fixup_exception_mc(struct pt_regs *regs)
> +{
> +	const struct exception_table_entry *ex;
> +
> +	ex = search_exception_tables(instruction_pointer(regs));
> +	if (!ex)
> +		return false;
> +
> +	/*
> +	 * This is not complete, More Machine check safe extable type can
> +	 * be processed here.
> +	 */
> +
> +	return false;
> +}
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index c5e11768e5c1..b262bd282a89 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -696,6 +696,29 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
>  	return 1; /* "fault" */
>  }
>  
> +static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
> +				     struct pt_regs *regs, int sig, int code)
> +{
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
> +		return false;
> +
> +	if (user_mode(regs) || !current->mm)
> +		return false;

What's the `!current->mm` check for?

> +
> +	if (apei_claim_sea(regs) < 0)
> +		return false;
> +
> +	if (!fixup_exception_mc(regs))
> +		return false;

I thought we still wanted to signal the task in this case? Or do you expect to
add that into `fixup_exception_mc()` ?

> +
> +	set_thread_esr(0, esr);

Why are we not setting the address? Is that deliberate, or an oversight?

> +
> +	arm64_force_sig_fault(sig, code, addr,
> +		"Uncorrected hardware memory error in kernel-access\n");

I think the wording here is misleading since we don't expect to recover from
accesses to kernel memory, and would be better as something like:

	"Uncorrected memory error on access to user memory\n"

Thanks,
Mark.

> +
> +	return true;
> +}
> +
>  static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
>  {
>  	const struct fault_info *inf;
> @@ -721,7 +744,9 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
>  		 */
>  		siaddr  = untagged_addr(far);
>  	}
> -	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
> +
> +	if (!arm64_do_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
> +		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
