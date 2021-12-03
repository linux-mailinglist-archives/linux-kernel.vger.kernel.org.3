Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3F4675F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380291AbhLCLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:15:58 -0500
Received: from foss.arm.com ([217.140.110.172]:47518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235997AbhLCLP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:15:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 941BF1396;
        Fri,  3 Dec 2021 03:12:33 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.66.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8E103F5A1;
        Fri,  3 Dec 2021 03:12:31 -0800 (PST)
Date:   Fri, 3 Dec 2021 11:12:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ben Dai <ben.dai9703@gmail.com>
Cc:     samitolvanen@google.com, ndesaulniers@google.com,
        rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Ben Dai <ben.dai@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peter.zijlstra@arm.com>
Subject: Re: [PATCH] arm64: fix the address of syscall in arch_syscall_addr
 if CFI is enabled
Message-ID: <Yan7nD6U1I0m5uKY@FVFF77S0Q05N>
References: <20211203052908.7467-1-ben.dai@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203052908.7467-1-ben.dai@unisoc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Please Cc the arm64 maintainers for arm64 patches, you can find the relevant
folk in the MAINTAINERS file, and you can use the get_maintainer.pl script to
find them automatically (e.g. with `./scripts/get_maintainer.pl ${PATCH}` or
`./scripts/get_maintainer.pl -f ${FILE}`).

For arm64 patches, you should also see LAKML
(linux-arm-kernel@lists.infradead.org).

I've added Will and Catalin now, and Ard and Peter too since they've btoh been
fighting with things in this area.

On Fri, Dec 03, 2021 at 01:29:08PM +0800, Ben Dai wrote:
> With CONFIG_CFI_CLANG, the addresses in sys_call_table[] actually point to
> jump instructions like "b __arm64_sys_*", and if CONFIG_LTO_CLANG_FULL is
> enabled, the compiler will not generate a symbol for each jump. It causes
> syscall tracer can't get symbol name in find_syscall_meta() and fail to
> initialize.
> 
> To fix this problem, implement an strong definition of arch_syscall_addr()
> to get the actual addresses of system calls.
> 
> Signed-off-by: Ben Dai <ben.dai@unisoc.com>
> ---
>  arch/arm64/kernel/syscall.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 50a0f1a38e84..2b911603966b 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -12,6 +12,8 @@
>  #include <asm/debug-monitors.h>
>  #include <asm/exception.h>
>  #include <asm/fpsimd.h>
> +#include <asm/insn.h>
> +#include <asm/patching.h>
>  #include <asm/syscall.h>
>  #include <asm/thread_info.h>
>  #include <asm/unistd.h>
> @@ -19,6 +21,25 @@
>  long compat_arm_syscall(struct pt_regs *regs, int scno);
>  long sys_ni_syscall(void);
>  
> +#ifdef CONFIG_CFI_CLANG
> +unsigned long __init arch_syscall_addr(int nr)
> +{
> +	u32 insn;
> +	unsigned long addr = (unsigned long)sys_call_table[nr];
> +
> +	/*
> +	 * Clang's CFI will replace the address of each system call function
> +	 * with the address of a jump table entry. In this case, the jump
> +	 * target address is the actual address of the system call.
> +	 */
> +	aarch64_insn_read((void *)addr, &insn);
> +	if (likely(aarch64_insn_is_b(insn)))
> +		addr += aarch64_get_branch_offset(insn);

The problemn is not your fault, but I absolutely hate this, because we're
bodging around the compiler having broken stuff for us in the first place.
We've been encountering more of these cases over time, and had we been aware of
them to begin with we'd have strongly pushed back on marging the CFI patches
until the compiler offered a better solution.

My view is that the current clang CFI scheme is broken by design here, and we
should mark tracing as incompatible with it for now, and work with the compiler
folk to get a scheme that actually works, rather than trying to bodge around
it.

Thanks,
Mark.
