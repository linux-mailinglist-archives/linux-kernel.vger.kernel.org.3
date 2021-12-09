Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1B46E5A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhLIJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:35:28 -0500
Received: from elvis.franken.de ([193.175.24.41]:38032 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhLIJf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:35:27 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mvFmB-0001l4-02; Thu, 09 Dec 2021 10:31:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EEF1AC4E1E; Thu,  9 Dec 2021 10:31:21 +0100 (CET)
Date:   Thu, 9 Dec 2021 10:31:21 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Subject: Re: [PATCH v2] MIPS: Loongson64: Use three arguments for slti
Message-ID: <20211209093121.GC7077@alpha.franken.de>
References: <20211208165616.1746108-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208165616.1746108-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 09:56:17AM -0700, Nathan Chancellor wrote:
> LLVM's integrated assembler does not support 'slti <reg>, <imm>':
> 
> <instantiation>:16:12: error: invalid operand for instruction
>  slti $12, (0x6300 | 0x0008)
>            ^
> arch/mips/kernel/head.S:86:2: note: while in macro instantiation
>  kernel_entry_setup # cpu specific setup
>  ^
> <instantiation>:16:12: error: invalid operand for instruction
>  slti $12, (0x6300 | 0x0008)
>            ^
> arch/mips/kernel/head.S:150:2: note: while in macro instantiation
>  smp_slave_setup
>  ^
> 
> To increase compatibility with LLVM's integrated assembler, use the full
> form of 'slti <reg>, <reg>, <imm>', which matches the rest of
> arch/mips/. This does not result in any change for GNU as.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1526
> Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20211207170129.578089-1-nathan@kernel.org/
> 
> * Fix typos in commit message ("stli" -> "slti") [Sergey]
> 
>  arch/mips/include/asm/mach-loongson64/kernel-entry-init.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
