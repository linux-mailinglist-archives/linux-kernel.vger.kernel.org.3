Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD97C490BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiAQPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiAQPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:50:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890B7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:50:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A8860FAD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBA4C36AE7;
        Mon, 17 Jan 2022 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642434624;
        bh=WsPNe1Hx43VHSCNBUeBEASSqX+3rnhsa2BPleFLd+SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zwQeY8ffSUVxeJ1jSp7KvX8e9gpuMLhmMwE0UlaHQLLQbzi8UEK8HN34VAGuQiXUr
         CPyq3cHx8ss9DodAu4BeYxD/TK8eeqhO2m/kY+oY0/O/reLtI4qn9E8hzomImjJElQ
         JoKsspK5XA1p7FCbYUP1xC01uanC+X15umso0GzM=
Date:   Mon, 17 Jan 2022 16:50:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] sysrq: do not omit current cpu when showing backtrace of
 all active CPUs
Message-ID: <YeWQPVy30EFTQaoq@kroah.com>
References: <20220117154300.2808-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117154300.2808-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:43:00PM +0800, Changbin Du wrote:
> The backtrace of current CPU also should be printed as it is active. This
> change add stack trace for current CPU and print a hint for idle CPU for
> the generic workqueue based printing. (x86 already does this)

How does x86 already do this?  What processors do not currently do this?

> Now it looks like below:
> [  279.401567] sysrq: Show backtrace of all active CPUs
> [  279.407234] sysrq: CPU5:
> [  279.407505] Call Trace:
> [  279.408789] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
> [  279.411698] [<ffffffff800060ac>] show_stack+0x32/0x3e
> [  279.411809] [<ffffffff80542258>] sysrq_handle_showallcpus+0x4c/0xc6
> [  279.411929] [<ffffffff80542f16>] __handle_sysrq+0x106/0x26c
> [  279.412034] [<ffffffff805436a8>] write_sysrq_trigger+0x64/0x74
> [  279.412139] [<ffffffff8029cd48>] proc_reg_write+0x8e/0xe2
> [  279.412252] [<ffffffff8021a8f8>] vfs_write+0x90/0x2be
> [  279.412362] [<ffffffff8021acd2>] ksys_write+0xa6/0xce
> [  279.412467] [<ffffffff8021ad24>] sys_write+0x2a/0x38
> [  279.412689] [<ffffffff80003ff8>] ret_from_syscall+0x0/0x2
> [  279.417173] sysrq: CPU6: backtrace skipped as idling
> [  279.417185] sysrq: CPU4: backtrace skipped as idling
> [  279.417187] sysrq: CPU0: backtrace skipped as idling
> [  279.417181] sysrq: CPU7: backtrace skipped as idling
> [  279.417190] sysrq: CPU1: backtrace skipped as idling
> [  279.417193] sysrq: CPU3: backtrace skipped as idling
> [  279.417219] sysrq: CPU2:
> [  279.419179] Call Trace:
> [  279.419440] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
> [  279.419782] [<ffffffff800060ac>] show_stack+0x32/0x3e
> [  279.420015] [<ffffffff80542b30>] showacpu+0x5c/0x96
> [  279.420317] [<ffffffff800ba71c>] flush_smp_call_function_queue+0xd6/0x218
> [  279.420569] [<ffffffff800bb438>] generic_smp_call_function_single_interrupt+0x14/0x1c
> [  279.420798] [<ffffffff800079ae>] handle_IPI+0xaa/0x13a
> [  279.421024] [<ffffffff804dcb92>] riscv_intc_irq+0x56/0x70
> [  279.421274] [<ffffffff80a05b70>] generic_handle_arch_irq+0x6a/0xfa
> [  279.421518] [<ffffffff80004006>] ret_from_exception+0x0/0x10
> [  279.421750] [<ffffffff80096492>] rcu_idle_enter+0x16/0x1e
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  drivers/tty/sysrq.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index bbfd004449b5..34cfdda4aff5 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -232,8 +232,10 @@ static void showacpu(void *dummy)
>  	unsigned long flags;
>  
>  	/* Idle CPUs have no interesting backtrace. */
> -	if (idle_cpu(smp_processor_id()))
> +	if (idle_cpu(smp_processor_id())) {
> +		pr_info("CPU%d: backtrace skipped as idling\n", smp_processor_id());
>  		return;
> +	}

Why do you need to see the skipped processor?  Can't you just infer this
from a lack of calltrace on the other cpus?  What needs to see this
information?

>  
>  	raw_spin_lock_irqsave(&show_lock, flags);
>  	pr_info("CPU%d:\n", smp_processor_id());
> @@ -260,10 +262,13 @@ static void sysrq_handle_showallcpus(int key)
>  
>  		if (in_hardirq())
>  			regs = get_irq_regs();
> -		if (regs) {
> -			pr_info("CPU%d:\n", smp_processor_id());
> +
> +		pr_info("CPU%d:\n", smp_processor_id());
> +		if (regs)
>  			show_regs(regs);
> -		}
> +		else
> +			show_stack(NULL, NULL, KERN_INFO);
> +

Why is this change needed as well?

thanks,

greg k-h
