Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3734B10F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243227AbiBJOw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:52:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240372AbiBJOwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:52:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2C7796
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:52:55 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54618D6E;
        Thu, 10 Feb 2022 06:52:55 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F3D3F718;
        Thu, 10 Feb 2022 06:52:52 -0800 (PST)
Date:   Thu, 10 Feb 2022 14:52:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH v2 2/7] linkage: add SYM_{ENTRY,START,END}_AT()
Message-ID: <YgUmvuJYfycnhODA@FVFF77S0Q05N>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
 <20220125113200.3829108-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125113200.3829108-3-mark.rutland@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding clang folk]

Nick, Nathan, I have a couple of questions for you below.

On Tue, Jan 25, 2022 at 11:31:55AM +0000, Mark Rutland wrote:
> Currently, the SYM_{ENTRY,START,END}() helpers define symbols in terms
> of the current position within the section. In subsequent patches we'll
> need to define symbols after moving this position.
> 
> This patch splits the core out of SYM_{ENTRY,START,END}() into
> SYM_{ENTRY,START,END}_AT() macros which take a location argument,
> with SYM_{ENTRY,START,END}() passing the current position.
> 
> There should be no functional change as a result of this patch.

Unfortunately, it turns out clang doesn't like this:

| [mark@lakrids:~/src/linux]% usellvm 13.0.0 make ARCH=arm LLVM=1 -s omap1_defconfig
| [mark@lakrids:~/src/linux]% usellvm 13.0.0 make ARCH=arm LLVM=1 -s -j50 Image     
| arch/arm/mach-omap1/ams-delta-fiq-handler.S:272:5: error: expected absolute expression
| .if (qwerty_fiqin_end - qwerty_fiqin_start) > (0x200 - 0x1c)
|     ^
| arch/arm/mach-omap1/ams-delta-fiq-handler.S:273:2: error: .err encountered
|  .err
|  ^
| make[1]: *** [scripts/Makefile.build:389: arch/arm/mach-omap1/ams-delta-fiq-handler.o] Error 1
| make[1]: *** Waiting for unfinished jobs....
| make: *** [Makefile:1831: arch/arm/mach-omap1] Error 2
| make: *** Waiting for unfinished jobs....

Both GCC and clang are happy to treat labels as constant expressions:

| [mark@lakrids:~/asm-test]% cat test-label.S                                
|         .text
| 
| start:
|         nop
| end:
| 
|         .if (end - start) == 0
|         .err
|         .endif
| 
| [mark@lakrids:~/asm-test]% usekorg 11.1.0 aarch64-linux-gcc -c test-label.S                                      
| [mark@lakrids:~/asm-test]% usellvm 13.0.0 clang --target=aarch64-linux -c test-label.S

... but only GCC is happy to treat symbol definitions as constants:

| [mark@lakrids:~/asm-test]% cat test-symbol.S 
|         .text
| 
| .set start, .;
|         nop
| .set end, .;
| 
|         .if (end - start) == 0
|         .err
|         .endif
| 
| [mark@lakrids:~/asm-test]% usekorg 11.1.0 aarch64-linux-gcc -c test-symbol.S          
| [mark@lakrids:~/asm-test]% usellvm 13.0.0 clang --target=aarch64-linux -c test-symbol.S
| test-symbol.S:7:6: error: expected absolute expression
|  .if (end - start) == 0
|      ^
| test-symbol.S:8:2: error: .err encountered
|  .err
|  ^

This is obviously a behavioural difference, but I'm not sure whether it's
intentional, or just an artifact of the differing implementation of GNU as and
LLVM's integrated assembler. Nich, Nathan, any thoughts on that?

Does clang have any mechanism other than labels to define location constants
that can be used as absolute expressions? e.g. is there any mechanism to alias
a label which results in the alias also being a constant?

Thanks,
Mark.

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/linkage.h | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index dbf8506decca0..d87c2acda2540 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -147,25 +147,43 @@
>  
>  /* === generic annotations === */
>  
> +#ifndef SYM_ENTRY_AT
> +#define SYM_ENTRY_AT(name, location, linkage)		\
> +	linkage(name) ASM_NL				\
> +	.set name, location ASM_NL
> +#endif
> +
>  /* SYM_ENTRY -- use only if you have to for non-paired symbols */
>  #ifndef SYM_ENTRY
>  #define SYM_ENTRY(name, linkage, align...)		\
> -	linkage(name) ASM_NL				\
>  	align ASM_NL					\
> -	name:
> +	SYM_ENTRY_AT(name, ., linkage)
> +#endif
> +
> +/* SYM_START_AT -- use only if you have to */
> +#ifndef SYM_START_AT
> +#define SYM_START_AT(name, location, linkage)		\
> +	SYM_ENTRY_AT(name, location, linkage)
>  #endif
>  
>  /* SYM_START -- use only if you have to */
>  #ifndef SYM_START
>  #define SYM_START(name, linkage, align...)		\
> -	SYM_ENTRY(name, linkage, align)
> +	align ASM_NL					\
> +	SYM_START_AT(name, ., linkage)
> +#endif
> +
> +/* SYM_END_AT -- use only if you have to */
> +#ifndef SYM_END_AT
> +#define SYM_END_AT(name, location, sym_type)		\
> +	.type name sym_type ASM_NL			\
> +	.size name, location-name ASM_NL
>  #endif
>  
>  /* SYM_END -- use only if you have to */
>  #ifndef SYM_END
>  #define SYM_END(name, sym_type)				\
> -	.type name sym_type ASM_NL			\
> -	.size name, .-name
> +	SYM_END_AT(name, ., sym_type)
>  #endif
>  
>  /* === code annotations === */
> -- 
> 2.30.2
> 
