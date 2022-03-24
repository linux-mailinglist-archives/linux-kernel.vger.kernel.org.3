Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B57D4E5FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348574AbiCXH7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240549AbiCXH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:59:12 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB2E78FE56
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:57:40 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22O7vSId018687;
        Thu, 24 Mar 2022 08:57:28 +0100
Date:   Thu, 24 Mar 2022 08:57:28 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v1 04/11] tools/nolibc: x86-64: Use appropriate register
 constraints if exist
Message-ID: <20220324075728.GC18586@1wt.eu>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
 <20220324073039.140946-5-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324073039.140946-5-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 02:30:32PM +0700, Ammar Faizi wrote:
> Use appropriate register constraints if exist. Don't use register
> variables for all inputs.
> 
> Register variables with "r" constraint should be used when we need to
> pass data through a specific register to extended inline assembly that
> doesn't have a specific register constraint associated with it (anything
> outside %rax, %rbx, %rcx, %rdx, %rsi, %rdi).
> 
> It also simplifies the macro definition.

I'm a bit bothered by this one because I went the exact opposite route
in the early design precisely because I found that the current one was
simpler. E.g, I personally find this one:

> -#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
> -({                                                                            \
> -	long _ret;                                                            \
> -	register long _num  __asm__("rax") = (num);                           \
> -	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
> -	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
> -	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
> -	register long _arg4 __asm__("r10") = (long)(arg4);                    \
> -	register long _arg5 __asm__("r8")  = (long)(arg5);                    \
> -	register long _arg6 __asm__("r9")  = (long)(arg6);                    \
> -	                                                                      \
> -	__asm__ volatile (                                                    \
> -		"syscall\n"                                                   \
> -		: "=a"(_ret)                                                  \
> -		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
> -		  "r"(_arg6), "0"(_num)                                       \
> -		: "rcx", "r11", "memory", "cc"                                \
> -	);                                                                    \
> -	_ret;                                                                 \

Easier to grasp than this one:

> +#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
> +({								\
> +	long _ret = (num);					\
> +	register long _arg4 __asm__("r10") = (long)(arg4);	\
> +	register long _arg5 __asm__("r8")  = (long)(arg5);	\
> +	register long _arg6 __asm__("r9")  = (long)(arg6);	\
> +	__asm__ volatile (					\
> +		"syscall\n"					\
> +		: "+a"(_ret)	/* %rax */			\
> +		: "D"(arg1),	/* %rdi */			\
> +		  "S"(arg2),	/* %rsi */			\
> +		  "d"(arg3),	/* %rdx */			\
> +		  "r"(_arg4),	/* %r10 */			\
> +		  "r"(_arg5),	/* %r8  */			\
> +		  "r"(_arg6)	/* %r9  */			\
> +		: "rcx", "r11", "memory", "cc"			\
> +	);							\
> +	_ret;							\
>  })

where only half of the registers are described at one place and the
other half is described in comments at another place. But admittedly
it's a matter of taste. However the same approach was adopted for all
other archs (arm, aarch64, mips, riscv) and I tend to find it easier
to compare the ABI between architectures when all registers are
described at once than when two of them (i386 and x86_64) make an
exception.

I'd say that if there is any technical benefit in doing this (occasional
code improvement or better support for older or exotic compilers), I'd say
"ok go for it", but if it's only a matter of taste, I'm not convinced at
all and am rather seeing this as a regression. Now if there's rough
consensus around this approach I'll abide, but then I'd request that other
archs are adapted as well so that we don't keep a different approach only
for these two ones.

Thanks,
Willy
