Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1E589D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbiHDOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiHDOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:20:14 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 429192AED;
        Thu,  4 Aug 2022 07:20:12 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oJbhq-0008EB-00; Thu, 04 Aug 2022 16:20:10 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2BAB4C01A0; Thu,  4 Aug 2022 15:58:12 +0200 (CEST)
Date:   Thu, 4 Aug 2022 15:58:12 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] MIPS: tlbex: Explicitly compare _PAGE_NO_EXEC against 0
Message-ID: <20220804135812.GA10513@alpha.franken.de>
References: <YulSY1pDms0ZyNs9@debian>
 <20220802175936.2278362-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802175936.2278362-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 10:59:36AM -0700, Nathan Chancellor wrote:
> When CONFIG_XPA is enabled, Clang warns:
> 
>   arch/mips/mm/tlbex.c:629:24: error: converting the result of '<<' to a boolean; did you mean '(1 << _PAGE_NO_EXEC_SHIFT) != 0'? [-Werror,-Wint-in-bool-context]
>           if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
>                               ^
>   arch/mips/include/asm/pgtable-bits.h:174:28: note: expanded from macro '_PAGE_NO_EXEC'
>   # define _PAGE_NO_EXEC          (1 << _PAGE_NO_EXEC_SHIFT)
>                                      ^
>   arch/mips/mm/tlbex.c:2568:24: error: converting the result of '<<' to a boolean; did you mean '(1 << _PAGE_NO_EXEC_SHIFT) != 0'? [-Werror,-Wint-in-bool-context]
>           if (!cpu_has_rixi || !_PAGE_NO_EXEC) {
>                                 ^
>   arch/mips/include/asm/pgtable-bits.h:174:28: note: expanded from macro '_PAGE_NO_EXEC'
>   # define _PAGE_NO_EXEC          (1 << _PAGE_NO_EXEC_SHIFT)
>                                      ^
>   2 errors generated.
> 
> _PAGE_NO_EXEC can be '0' or '1 << _PAGE_NO_EXEC_SHIFT' depending on the
> build and runtime configuration, which is what the negation operators
> are trying to convey. To silence the warning, explicitly compare against
> 0 so the result of the '<<' operator is not implicitly converted to a
> boolean.
> 
> According to its documentation, GCC enables -Wint-in-bool-context with
> -Wall but this warning is not visible when building the same
> configuration with GCC. It appears GCC only warns when compiling C++,
> not C, although the documentation makes no note of this:
> https://godbolt.org/z/x39q3brxf
> 
> Reported-by: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/mips/mm/tlbex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 8dbbd99fc7e8..be4d4670d649 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -626,7 +626,7 @@ static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
>  		return;
>  	}
>  
> -	if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
> +	if (cpu_has_rixi && _PAGE_NO_EXEC != 0) {
>  		if (fill_includes_sw_bits) {
>  			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
>  		} else {
> @@ -2565,7 +2565,7 @@ static void check_pabits(void)
>  	unsigned long entry;
>  	unsigned pabits, fillbits;
>  
> -	if (!cpu_has_rixi || !_PAGE_NO_EXEC) {
> +	if (!cpu_has_rixi || _PAGE_NO_EXEC == 0) {
>  		/*
>  		 * We'll only be making use of the fact that we can rotate bits
>  		 * into the fill if the CPU supports RIXI, so don't bother
> 
> base-commit: 7d0d3fa7339ed5a06d6608b7cde9f079eba62bb1
> -- 
> 2.37.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
