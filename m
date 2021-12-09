Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0D46E59F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhLIJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:35:22 -0500
Received: from elvis.franken.de ([193.175.24.41]:38024 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhLIJfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:35:21 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mvFmB-0001l4-01; Thu, 09 Dec 2021 10:31:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 960F5C4E1E; Thu,  9 Dec 2021 10:30:50 +0100 (CET)
Date:   Thu, 9 Dec 2021 10:30:50 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Subject: Re: [PATCH] MIPS: Loongson2ef: Remove unnecessary {as,cc}-option
 calls
Message-ID: <20211209093050.GB7077@alpha.franken.de>
References: <20211207175951.135400-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207175951.135400-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:59:51AM -0700, Nathan Chancellor wrote:
> When building with LLVM's integrated assembler, the build errors because
> it does not implement -mfix-loongson2f-{jump,nop}:
> 
> arch/mips/loongson2ef/Platform:36: *** only binutils >= 2.20.2 have needed option -mfix-loongson2f-nop.  Stop.
> 
> The error is a little misleading because binutils are not being used in
> this case.
> 
> To clear this up, remove the as-option calls because binutils 2.23 is
> the minimum supported version for building the kernel. At the same time,
> remove the cc-option calls for the '-march=' flags, as GCC 5.1.0 is the
> minimum supported version.
> 
> This change will not fix the LLVM build for CONFIG_CPU_LOONGSON2{E,F},
> as it does not implement the loongson2{e,f} march arguments (nor r4600,
> so it will error prior to this change) nor the assembler flags mentioned
> above but it will make the errors more obvious.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1529
> Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> This dependency on certain toolchain flags should probably be moved into
> Kconfig at some point so that users cannot select configurations that
> they do not have support for so that their builds do not error. However,
> from a brief survey, there is not a clean way to codify these
> dependencies at the moment because the CPU configs are selected by the
> individual machines that implement them, meaning that the dependencies
> would need to be added to all the machine configs (as 'select ...'
> overrides 'depends on ...'), which is outside the scope of this patch.
> Furthermore, one could argue that it is better for the user to get a big
> error when they are missing support for something, rather than the
> configs getting disabled silently, especially if they are critical to
> the machine.
> 
>  arch/mips/loongson2ef/Platform | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
