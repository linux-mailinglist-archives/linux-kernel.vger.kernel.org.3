Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADA4EF8DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349886AbiDARYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347073AbiDARYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:24:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2BBD20C1A5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:22:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DB4911FB;
        Fri,  1 Apr 2022 10:22:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.6.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 900493F66F;
        Fri,  1 Apr 2022 10:22:24 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:22:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, gcc@gcc.gnu.org,
        catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        szabolcs.nagy@arm.com, f.fainelli@gmail.com, opendmb@gmail.com
Subject: Re: [PATCH] arm64/io: Remind compiler that there is a memory side
 effect
Message-ID: <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
References: <20220401164406.61583-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401164406.61583-1-jeremy.linton@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

Thanks for raising this.

On Fri, Apr 01, 2022 at 11:44:06AM -0500, Jeremy Linton wrote:
> The relaxed variants of read/write macros are only declared
> as `asm volatile()` which forces the compiler to generate the
> instruction in the code path as intended. The only problem
> is that it doesn't also tell the compiler that there may
> be memory side effects. Meaning that if a function is comprised
> entirely of relaxed io operations, the compiler may think that
> it only has register side effects and doesn't need to be called.

As I mentioned on a private mail, I don't think that reasoning above is
correct, and I think this is a miscompilation (i.e. a compiler bug).

The important thing is that any `asm volatile` may have a side effects
generally outside of memory or GPRs, and whether the assembly contains a memory
load/store is immaterial. We should not need to add a memory clobber in order
to retain the volatile semantic.

See:
	
  https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile

... and consider the x86 example that reads rdtsc, or an arm64 sequence like:

| void do_sysreg_thing(void)
| {
| 	unsigned long tmp;
| 	
| 	tmp = read_sysreg(some_reg);
| 	tmp |= SOME_BIT;
| 	write_sysreg(some_reg);
| }

... where there's no memory that we should need to hazard against.

This patch might workaround the issue, but I don't believe it is a correct fix.

> For an example function look at bcmgenet_enable_dma(), before the
> relaxed variants were removed. When built with gcc12 the code
> contains the asm blocks as expected, but then the function is
> never called.

So it sounds like this is a regression in GCC 12, which IIUC isn't released yet
per:

  https://gcc.gnu.org/gcc-12/changes.html

... which says:

| Note: GCC 12 has not been released yet

Surely we can fix it prior to release?

Thanks,
Mark.

> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/io.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 7fd836bea7eb..3cceda7948a0 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -24,25 +24,25 @@
>  #define __raw_writeb __raw_writeb
>  static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
>  {
> -	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr));
> +	asm volatile("strb %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>  }
>  
>  #define __raw_writew __raw_writew
>  static inline void __raw_writew(u16 val, volatile void __iomem *addr)
>  {
> -	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr));
> +	asm volatile("strh %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>  }
>  
>  #define __raw_writel __raw_writel
>  static __always_inline void __raw_writel(u32 val, volatile void __iomem *addr)
>  {
> -	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr));
> +	asm volatile("str %w0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>  }
>  
>  #define __raw_writeq __raw_writeq
>  static inline void __raw_writeq(u64 val, volatile void __iomem *addr)
>  {
> -	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr));
> +	asm volatile("str %x0, [%1]" : : "rZ" (val), "r" (addr) : "memory");
>  }
>  
>  #define __raw_readb __raw_readb
> -- 
> 2.35.1
> 
