Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37EE5672C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiGEPgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGEPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:36:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D41A3A9;
        Tue,  5 Jul 2022 08:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1438B8181A;
        Tue,  5 Jul 2022 15:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF75C341C7;
        Tue,  5 Jul 2022 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657035407;
        bh=jq+RMEhV5F21llTAXKZgHAD0ZXzywB8ulhg1BKIMaVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQPrzOUNteU6rzWHw0BnCwMEOGWE7tZenYO6Ey6mlgNC+LH5oAXvVfVAYpv1XkT0k
         59n7BRQ0H+FIbKYPoqFADtZ/k/S4RqhYGT+vkvqlJCKmYF+5SR9Zm5ovMpFGUTqlQ6
         TKENX6E7GcpAhd6WHX0+STS1NNPhKs7K8Wrty6Fs+hUXtqpBlzMcyOS8h2BFCj1V7O
         1LlyICnyGzckaomTAeNFd15xADTSvFkFf1YLoItooZTykJA2czozPjY4237GYS19bs
         c/drjp14qNYaXmgoMQiVpKgrG3mnmdyXMRTPKQ+LS7WaheqULbEfl4RSN7eYNp6afZ
         Clx2hbvezWBAA==
Date:   Tue, 5 Jul 2022 08:36:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: overflow: Do not define 64-bit tests on 32-bit
Message-ID: <YsRajaMsQ5oFFL0l@dev-arch.thelio-3990X>
References: <20220702004710.2486218-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702004710.2486218-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:47:10PM -0700, Kees Cook wrote:
> The 64-bit overflow tests will trigger 64-bit division on 32-bit hosts,
> which is not currently used anywhere in the kernel, and tickles bugs
> in at least Clang 13 and earlier:
> https://github.com/ClangBuiltLinux/linux/issues/1636
> 
> In reality, there shouldn't be a reason to not build the 64-bit test
> cases on 32-bit systems, so these #ifdefs can be removed once the minimum
> Clang version reaches 13.

                        ^ 14, as clang 13 has the problem too.

> 
> In the meantime, silence W=1 warnings given by the current code:
> 
> ../lib/overflow_kunit.c:191:19: warning: 's64_tests' defined but not used [-Wunused-const-variable=]
>   191 | DEFINE_TEST_ARRAY(s64) = {
>       |                   ^~~
> ../lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
>    24 |         } t ## _tests[]
>       |           ^
> ../lib/overflow_kunit.c:94:19: warning: 'u64_tests' defined but not used [-Wunused-const-variable=]
>    94 | DEFINE_TEST_ARRAY(u64) = {
>       |                   ^~~
> ../lib/overflow_kunit.c:24:11: note: in definition of macro 'DEFINE_TEST_ARRAY'
>    24 |         } t ## _tests[]
>       |           ^
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202205110324.7GrtxG8u-lkp@intel.com
> Fixes: 455a35a6cdb6 ("lib: add runtime test of check_*_overflow functions")
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Vitor Massaru Iha <vitor@massaru.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Tested-by: Daniel Latypov <dlatypov@google.com>
> Link: https://lore.kernel.org/lkml/CAGS_qxokQAjQRip2vPi80toW7hmBnXf=KMTNT51B1wuDqSZuVQ@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

It might be nice to do something like:

/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
#if !(defined(CONFIG_CC_IS_GCC) || CONFIG_CLANG_VERSION >= 140000) && BITS_PER_LONG == 32
#define EXCLUDE_64_BIT_OVERFLOW
#endif

#ifndef EXCLUDE_64_BIT_OVERFLOW
...
#endif

so that we can easily grep for CLANG_VERSION and clean this up when we
bump to a minimum version of 14.0.0 and that the scope of the workaround
is limited to the cases where it is known not to work.

However, that is ultimately up to you. Regardless:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  lib/overflow_kunit.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 475f0c064bf6..7e3e43679b73 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -91,6 +91,7 @@ DEFINE_TEST_ARRAY(u32) = {
>  	{-4U, 5U, 1U, -9U, -20U, true, false, true},
>  };
>  
> +#if BITS_PER_LONG == 64
>  DEFINE_TEST_ARRAY(u64) = {
>  	{0, 0, 0, 0, 0, false, false, false},
>  	{1, 1, 2, 0, 1, false, false, false},
> @@ -114,6 +115,7 @@ DEFINE_TEST_ARRAY(u64) = {
>  	 false, true, false},
>  	{-15ULL, 10ULL, -5ULL, -25ULL, -150ULL, false, false, true},
>  };
> +#endif
>  
>  DEFINE_TEST_ARRAY(s8) = {
>  	{0, 0, 0, 0, 0, false, false, false},
> @@ -188,6 +190,8 @@ DEFINE_TEST_ARRAY(s32) = {
>  	{S32_MIN, S32_MIN, 0, 0, 0, true, false, true},
>  	{S32_MAX, S32_MAX, -2, 0, 1, true, false, true},
>  };
> +
> +#if BITS_PER_LONG == 64
>  DEFINE_TEST_ARRAY(s64) = {
>  	{0, 0, 0, 0, 0, false, false, false},
>  
> @@ -216,6 +220,7 @@ DEFINE_TEST_ARRAY(s64) = {
>  	{-128, -1, -129, -127, 128, false, false, false},
>  	{0, -S64_MAX, -S64_MAX, S64_MAX, 0, false, false, false},
>  };
> +#endif
>  
>  #define check_one_op(t, fmt, op, sym, a, b, r, of) do {		\
>  	t _r;							\
> @@ -650,6 +655,7 @@ static struct kunit_case overflow_test_cases[] = {
>  	KUNIT_CASE(s16_overflow_test),
>  	KUNIT_CASE(u32_overflow_test),
>  	KUNIT_CASE(s32_overflow_test),
> +/* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
>  #if BITS_PER_LONG == 64
>  	KUNIT_CASE(u64_overflow_test),
>  	KUNIT_CASE(s64_overflow_test),
> -- 
> 2.32.0
> 
