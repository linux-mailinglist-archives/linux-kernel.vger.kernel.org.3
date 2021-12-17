Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6354785A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhLQHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhLQHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:40:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C66C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 23:40:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D476205C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 07:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F0FC36AE5;
        Fri, 17 Dec 2021 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639726822;
        bh=XAYqhQ19Oe8PjNRSU0jQtd7ZEHWDhd57BupKVSA6N/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oS8jq2PriRFrFkF46fmZ3+3qWIGazDG3LQ7NGMHW3SafPdBtJ+X2P/hD1dHQiUzXE
         Avl2fFzYksQg8J9hNQ3PSUcshJlgIinLuqC73G3GKaOujwXSQOVa/q6tY/XjF5Hz0h
         2/yMHU181715p2Dw1MwOvFueDnoFcVbIp9vqaJo6sS//wQwcb9UthjGChYhpJAucjz
         Cmh+PwPIp7uXXl/r2lGppEOROv+bUn1FhM+F7jtC/B5McBOs4ZNM350cTWtG2Gzpnw
         +9KZw8lM3A5Stq4mzj9z9mR2JoLPmRGlI1IsGd4xlxbfe/Nh47UV1XnP3F9xR984Mg
         T/a+5r3a3jOjg==
Date:   Fri, 17 Dec 2021 16:40:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Janet Liu <jianhua.ljh@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        orson.zhai@unisoc.com
Subject: Re: [PATCH v2 2/2] arm64: kprobes: add support for
 KPROBES_ON_FTRACE
Message-Id: <20211217164019.7d5d9848f350fef4f709c62f@kernel.org>
In-Reply-To: <1635858706-27320-2-git-send-email-jianhua.ljh@gmail.com>
References: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
        <1635858706-27320-2-git-send-email-jianhua.ljh@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  2 Nov 2021 21:11:46 +0800
Janet Liu <jianhua.ljh@gmail.com> wrote:

> From: Janet Liu <janet.liu@unisoc.com>
> 
> This patch allow kprobes on ftrace call sites. This optimization
> avoids use of a trap with regular kprobes.
> 
> This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
> "patchable-function-entry" options which is only implemented with newer
> toolchains.
> 
> Signed-off-by: Janet Liu <janet.liu@unisoc.com>
> ---
>  arch/arm64/Kconfig                 |  1 +
>  arch/arm64/kernel/probes/Makefile  |  1 +
>  arch/arm64/kernel/probes/ftrace.c  | 73 ++++++++++++++++++++++++++++++
>  arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 339130712093..f59005608976 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -200,6 +200,7 @@ config ARM64
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
>  	select HAVE_OPTPROBES
> +	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> index c77c92ac95fd..d9b204f4795a 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -3,5 +3,6 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>  				   kprobes_trampoline.o		\
>  				   simulate-insn.o
>  obj-$(CONFIG_OPTPROBES) 	+= opt.o opt_head.o
> +obj-$(CONFIG_KPROBES_ON_FTRACE) += ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>  				   simulate-insn.o
> diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
> new file mode 100644
> index 000000000000..46ea92eb552f
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/ftrace.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Dynamic Ftrace based Kprobes Optimization
> +//
> +// Copyright (C) 2021, Unisoc Inc.
> +// Author: Janet Liu <janet.liu@unisoc.com>
> +#include <linux/kprobes.h>
> +#include <linux/ptrace.h>
> +#include <linux/hardirq.h>
> +#include <linux/preempt.h>
> +#include <linux/ftrace.h>
> +
> +
> +/* Ftrace callback handler for kprobes*/
> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> +{
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +	struct pt_regs *regs = ftrace_get_regs(fregs);
> +	int bit;
> +
> +	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> +	if (bit < 0)
> +		return;
> +
> +	preempt_disable_notrace();

This already has been done in ftrace side.

> +	p = get_kprobe((kprobe_opcode_t *)ip);
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		goto end;
> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		unsigned long orig_ip = instruction_pointer(regs);
> +
> +		instruction_pointer_set(regs, ip);

The 'ip' is the address of the 'bl' instruction, which must be
p->addr + AARCH64_INSN_SIZE * 2. But this is a bit strange.

On aarch64, if the user probe callback is called from breakpoint handler,
regs->pc == kp->addr. But in this case, it is not the same.

So, what about this?

 instruction_pointer_set(regs, ip - AARCH64_INSN_SIZE);

> +
> +		__this_cpu_write(current_kprobe, p);
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +			/*
> +			 *Emulate singlestep (and also recover regs->pc)
> +			 *as if there is a nop
> +			 */
> +			instruction_pointer_set(regs,
> +					(unsigned long)p->addr + MCOUNT_INSN_SIZE);

And then, this will be

			instruction_pointer_set(regs,
					(unsigned long)p->addr + AARCH64_INSN_SIZE * 2);

So basically, kprobes on ftrace will skips 2 NOP instructions (the compiler installed
2 nops) and call post handler. This means we have a virtual big NOP instruction there.

> +			if (unlikely(p->post_handler)) {
> +				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +				p->post_handler(p, regs, 0);
> +			}
> +			instruction_pointer_set(regs, orig_ip);
> +		}
> +
> +		/*
> +		 * If pre_handler returns !0,it changes regs->pc. We have to
> +		 * skip emulating post_handler.
> +		 */
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +end:
> +	preempt_enable_notrace();
> +	ftrace_test_recursion_unlock(bit);
> +}
> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> +
> +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> +{
> +	p->ainsn.api.insn = NULL;
> +	p->ainsn.api.restore = 0;
> +	return 0;
> +}
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 6dbcc89f6662..3d371d3e4dfa 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -417,6 +417,33 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
>  	return 0;
>  }
>  
> +kprobe_opcode_t __kprobes *kprobe_lookup_name(const char *name, unsigned int offset)
> +{
> +	kprobe_opcode_t *addr;
> +
> +	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	if (addr && !offset) {
> +		unsigned long faddr;
> +
> +		faddr = ftrace_location_range((unsigned long)addr,
> +					      (unsigned long)addr + 8);

this '8' must be (AARCH64_INSN_SIZE * 2). And here you may need to add
a comment why search the 2 instructions. (it is because arm64 uses 
-fpatchable-function-entry=2.)

> +		if (faddr)
> +			addr = (kprobe_opcode_t *)faddr;
> +	}
> +#endif
> +	return addr;
> +}
> +
> +bool __kprobes arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	return offset <= 8;

Ditto.

> +#else
> +	return !offset;
> +#endif
> +}
> +
>  int __init arch_init_kprobes(void)
>  {
>  	register_kernel_break_hook(&kprobes_break_hook);
> -- 
> 2.25.1
> 

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
