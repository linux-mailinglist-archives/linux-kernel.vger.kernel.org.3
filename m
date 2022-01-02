Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D83482B6D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiABNc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:32:57 -0500
Received: from elvis.franken.de ([193.175.24.41]:52739 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231288AbiABNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:32:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1n40yi-0002m7-05; Sun, 02 Jan 2022 14:32:52 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 84F40C0A4B; Sun,  2 Jan 2022 14:31:09 +0100 (CET)
Date:   Sun, 2 Jan 2022 14:31:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] MIPS: signal: Protect against sigaltstack
 wraparound
Message-ID: <20220102133109.GF3468@alpha.franken.de>
References: <1639974460-3278-1-git-send-email-yangtiezhu@loongson.cn>
 <1639974460-3278-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639974460-3278-2-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:27:38PM +0800, Tiezhu Yang wrote:
> If a process uses alternative signal stack by using sigaltstack(),
> then that stack overflows and stack wraparound occurs.
> 
> Simple Explanation:
> The accurate sp order is A,B,C,D,...
> But now the sp points to A,B,C and A,B,C again.
> 
> This problem can reproduce by the following code:
> 
>   $ cat test_sigaltstack.c
>   #include <stdio.h>
>   #include <signal.h>
>   #include <stdlib.h>
>   #include <string.h>
> 
>   volatile int counter = 0;
> 
>   void print_sp()
>   {
>       unsigned long sp;
> 
>       __asm__ __volatile__("move %0, $sp" : "=r" (sp));
>       printf("sp = 0x%08lx\n", sp);
>   }
> 
>   void segv_handler()
>   {
>       int *c = NULL;
> 
>       print_sp();
>       counter++;
>       printf("%d\n", counter);
> 
>       if (counter == 23)
>           abort();
> 
>       *c = 1;	// SEGV
>   }
> 
>   int main()
>   {
>       int *c = NULL;
>       char *s = malloc(SIGSTKSZ);
>       stack_t stack;
>       struct sigaction action;
> 
>       memset(s, 0, SIGSTKSZ);
>       stack.ss_sp = s;
>       stack.ss_flags = 0;
>       stack.ss_size = SIGSTKSZ;
>       if (sigaltstack(&stack, NULL)) {
>           printf("Failed to use sigaltstack!\n");
>           return -1;
>       }
> 
>       memset(&action, 0, sizeof(action));
>       action.sa_handler = segv_handler;
>       action.sa_flags = SA_ONSTACK | SA_NODEFER;
>       sigemptyset(&action.sa_mask);
>       sigaction(SIGSEGV, &action, NULL);
> 
>       *c = 0;	//SEGV
> 
>       if (!s)
>           free(s);
> 
>       return 0;
>   }
>   $ gcc test_sigaltstack.c -o test_sigaltstack
>   $ ./test_sigaltstack
>   sp = 0x120015c80
>   1
>   sp = 0x120015900
>   2
>   sp = 0x120015580
>   3
>   sp = 0x120015200
>   4
>   sp = 0x120014e80
>   5
>   sp = 0x120014b00
>   6
>   sp = 0x120014780
>   7
>   sp = 0x120014400
>   8
>   sp = 0x120014080
>   9
>   sp = 0x120013d00
>   10
>   sp = 0x120015c80
>   11               # wraparound occurs! the 11nd output is same as 1st.
>   sp = 0x120015900
>   12
>   sp = 0x120015580
>   13
>   sp = 0x120015200
>   14
>   sp = 0x120014e80
>   15
>   sp = 0x120014b00
>   16
>   sp = 0x120014780
>   17
>   sp = 0x120014400
>   18
>   sp = 0x120014080
>   19
>   sp = 0x120013d00
>   20
>   sp = 0x120015c80
>   21                # wraparound occurs! the 21nd output is same as 1st.
>   sp = 0x120015900
>   22
>   sp = 0x120015580
>   23
>   Aborted
> 
> With this patch:
> 
>   $ ./test_sigaltstack
>   sp = 0x120015c80
>   1
>   sp = 0x120015900
>   2
>   sp = 0x120015580
>   3
>   sp = 0x120015200
>   4
>   sp = 0x120014e80
>   5
>   sp = 0x120014b00
>   6
>   sp = 0x120014780
>   7
>   sp = 0x120014400
>   8
>   sp = 0x120014080
>   9
>   Segmentation fault
> 
> If we are on the alternate signal stack and would overflow it, don't.
> Return an always-bogus address instead so we will die with SIGSEGV.
> 
> This patch is similar with commit 83bd01024b1f ("x86: protect against
> sigaltstack wraparound").
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/kernel/signal.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index c9b2a75..c1632e8 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -563,6 +563,13 @@ void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
>  	sp = regs->regs[29];
>  
>  	/*
> +	 * If we are on the alternate signal stack and would overflow it, don't.
> +	 * Return an always-bogus address instead so we will die with SIGSEGV.
> +	 */
> +	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size)))
> +		return (void __user __force *)(-1UL);
> +
> +	/*
>  	 * FPU emulator may have it's own trampoline active just
>  	 * above the user stack, 16-bytes before the next lowest
>  	 * 16 byte boundary.  Try to avoid trashing it.
> -- 
> 2.1.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
