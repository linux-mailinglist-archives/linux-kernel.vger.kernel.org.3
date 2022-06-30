Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EEA561FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiF3QDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiF3QDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA33A3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4FB860FC3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF8FC34115;
        Thu, 30 Jun 2022 16:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656604986;
        bh=DQKte8QS+TVqPnOnSBE/VfWDC3wbJgvjDUj/KcleL74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZ2x2AkSgcdOGnR5SqaKGb2DdjHEmSuK1nsLYmAxHBKR4kX5zcYlQ5EtZZWjRiTfT
         Q4nPBSiL8jPEWj0Kqs54KguUCn8BwYIDFBjtg/qfDlJzjz+5f+P1IcVf9ULqg3i+3v
         vcJ29ejaNokYfpgHlB4HT1FXAz43taLKxUKwKMiaL+ulnMK8l313PwSV0Ia28Zux00
         VXtrcTGThBVTkOCzX+fDxzafKgGB8FGp47dJTTEEIB8117adnvffMAyccqT+1i7GZg
         LPxuDxgBwDGIuBSDv0HVtH/5G1kji0Wi3FYbaKLGbz8gBsYXG/V3VrbMx1yZRfKftc
         GAS4p/pv9Jm6Q==
Date:   Thu, 30 Jun 2022 09:03:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] lib/test_printf.c: fix clang -Wformat warnings
Message-ID: <Yr3JN/mMn4K+7WnR@dev-arch.thelio-3990X>
References: <20220629235326.480858-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629235326.480858-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On Wed, Jun 29, 2022 at 04:53:26PM -0700, Justin Stitt wrote:
> see warnings:
> | lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
> | but the argument has type 'int' [-Werror,-Wformat] test("0|1|1|128|255",
> | "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:158:55: error: format specifies type 'char' but the
> | argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
> | "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:159:41: error: format specifies type 'unsigned short'
> | but the argument has type 'int' [-Werror,-Wformat]
> | test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> 
> There's an ongoing movement to eventually enable the -Wformat flag for
> clang. Previous patches have targeted incorrect usage of
> format specifiers. In this case, however, the "incorrect" format
> specifiers are intrinsically part of the test cases. Hence, fixing them
> would be misaligned with their intended purpose. My proposed fix is to
> simply disable the warnings so that one day a clean build of the kernel
> with clang (and -Wformat enabled) would be possible. It would also keep
> us in the green for alot of the CI bots.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  lib/test_printf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 07309c45f327..748591a0c55c 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -4,6 +4,12 @@
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define DO_PRAGMA(x) _Pragma(#x)
> +#define NOWARN(warnoption, ...)
> +	    DO_PRAGMA(GCC diagnostic push)
> +		    DO_PRAGMA(GCC diagnostic ignored #warnoption)
> +			    __VA_ARGS__
> +				    DO_PRAGMA(GCC diagnostic pop)

This is basically a duplicate of the __diag infrastructure that exists
in include/linux/compiler_types.h and include/linux/compiler-clang.h, I
think we should just reuse that here. It eliminates this hunk and the
hunk below...

>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -154,9 +160,13 @@ test_number(void)
>  	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
>  	test("  0x1234abcd", "%#12x", 0x1234abcd);
>  	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
> +	/* disable -Wformat for this chunk */
> +	NOWARN(-Wformat, 
>  	test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
>  	test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
>  	test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> +	)
> +	/* end chunk */
>  	/*
>  	 * POSIX/C99: »The result of converting zero with an explicit
>  	 * precision of zero shall be no characters.« Hence the output

...becomes a lot simpler in my opinion (feel free to reword the comment
however you want).

Cheers,
Nathan

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8010de49b6c5..86e088ad9e48 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -154,9 +154,12 @@ test_number(void)
 	test("0x1234abcd  ", "%#-12x", 0x1234abcd);
 	test("  0x1234abcd", "%#12x", 0x1234abcd);
 	test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|% d", 0, 1, 12, 123, 1234, -123, -1234);
+	__diag_push();
+	__diag_ignore(clang, 11, "-Wformat", "These trigger clang's -Wformat and the specifiers should not be changed.");
 	test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
 	test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
 	test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
+	__diag_pop();
 	/*
 	 * POSIX/C99: »The result of converting zero with an explicit
 	 * precision of zero shall be no characters.« Hence the output
