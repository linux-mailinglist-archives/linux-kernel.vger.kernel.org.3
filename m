Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF695A5BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiH3Gkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3Gkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:40:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580194456E;
        Mon, 29 Aug 2022 23:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661841630; x=1693377630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r1rkNqH4NwCMJ8U2+7fF8EZ3qwx3bexNboxUU+Dfyn4=;
  b=VI4NafG1+X8mhmKkU7fTDr5RJW8Gp0yg/lPPOLPAJ2mQiGLRBTlKU3Ch
   6EEpDm9IFSXWxLMIwcX9G1JYisGPElWD1TY5zmx2gy4WiWwA78luiMgZX
   KHP/ViFMgZimQVzIoW9ImIz07f3FVRjTtzZUtHsa5gvFE0Nasz2pv0kkt
   XwL3rHG1iKgLaTVKfdq4equBgJ98tJOmKQiv1d7HsxcC5SRCPoPH1NVYn
   v0xWylE6vnUsr/1ChgJudktWbNzmvt+/M73qzphpgdSCLxtvtxGYpJyYf
   unjX+mCW0v83wttw5EjLGnUeMnnJ+KoB1WbkiEC4BghrY7htPRE+xffB8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295098495"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="295098495"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 23:40:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="641246660"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.1.40]) ([10.213.1.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 23:40:27 -0700
Message-ID: <8d880425-72f5-6ba6-933f-b8b016da88cd@intel.com>
Date:   Tue, 30 Aug 2022 08:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.0
Subject: Re: [PATCH v2] overflow: Allow mixed type arguments
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
References: <20220829214550.3443472-1-keescook@chromium.org>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220829214550.3443472-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.08.2022 23:45, Kees Cook wrote:
> When the check_[op]_overflow() helpers were introduced, all arguments were
> required to be the same type to make the fallback macros simpler. However,
> once the fallback macros were removed[1], it is fine to allow mixed
> types, which makes using the helpers much more useful, as they can be
> used to test for type-based overflows (e.g. adding two large ints but
> storing into a u8), as would be handy in the drm core[2].
>
> Remove the restriction, and add additional self-tests that exercise some
> of the mixed-type overflow cases.
>
> [1] https://git.kernel.org/linus/4eb6bd55cfb22ffc20652732340c4962f3ac9a91
> [2] https://lore.kernel.org/lkml/20220824084514.2261614-2-gwan-gyeong.mun@intel.com
>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: change names to "type1_type2__output-type" for better readability (Rasmus)
> v1: https://lore.kernel.org/lkml/20220829204729.3409270-1-keescook@chromium.org
> ---
>   include/linux/overflow.h |  6 ----
>   lib/overflow_kunit.c     | 77 +++++++++++++++++++++++++++++-----------
>   2 files changed, 57 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 0eb3b192f07a..ad692fb11bf3 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -63,8 +63,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   	typeof(a) __a = (a);			\
>   	typeof(b) __b = (b);			\
>   	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
>   	__builtin_add_overflow(__a, __b, __d);	\
>   }))

Is there a reason to keep all local vars?
Why not:
#define check_add_overflow(a, b, d) 
__must_check_overflow(__builtin_add_overflow((a), (b), (d)))

Similar for other macros.

Regards
Andrzej

>   
> @@ -72,8 +70,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   	typeof(a) __a = (a);			\
>   	typeof(b) __b = (b);			\
>   	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
>   	__builtin_sub_overflow(__a, __b, __d);	\
>   }))
>   
> @@ -81,8 +77,6 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>   	typeof(a) __a = (a);			\
>   	typeof(b) __b = (b);			\
>   	typeof(d) __d = (d);			\
> -	(void) (&__a == &__b);			\
> -	(void) (&__a == __d);			\
>   	__builtin_mul_overflow(__a, __b, __d);	\
>   }))
>   
> diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> index 7e3e43679b73..5e1b51d42e93 100644
> --- a/lib/overflow_kunit.c
> +++ b/lib/overflow_kunit.c
> @@ -16,12 +16,15 @@
>   #include <linux/types.h>
>   #include <linux/vmalloc.h>
>   
> -#define DEFINE_TEST_ARRAY(t)			\
> -	static const struct test_ ## t {	\
> -		t a, b;				\
> -		t sum, diff, prod;		\
> -		bool s_of, d_of, p_of;		\
> -	} t ## _tests[]
> +#define DEFINE_TEST_ARRAY_TYPED(t1, t2, t)			\
> +	static const struct test_ ## t1 ## _ ## t2 ## __ ## t {	\
> +		t1 a;						\
> +		t2 b;						\
> +		t sum, diff, prod;				\
> +		bool s_of, d_of, p_of;				\
> +	} t1 ## _ ## t2 ## __ ## t ## _tests[]
> +
> +#define DEFINE_TEST_ARRAY(t)	DEFINE_TEST_ARRAY_TYPED(t, t, t)
>   
>   DEFINE_TEST_ARRAY(u8) = {
>   	{0, 0, 0, 0, 0, false, false, false},
> @@ -235,8 +238,8 @@ DEFINE_TEST_ARRAY(s64) = {
>   		a, b, r, _r, #t);				\
>   } while (0)
>   
> -#define DEFINE_TEST_FUNC(t, fmt)					\
> -static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
> +#define DEFINE_TEST_FUNC_TYPED(n, t, fmt)				\
> +static void do_test_ ## n(struct kunit *test, const struct test_ ## n *p) \
>   {							   		\
>   	check_one_op(t, fmt, add, "+", p->a, p->b, p->sum, p->s_of);	\
>   	check_one_op(t, fmt, add, "+", p->b, p->a, p->sum, p->s_of);	\
> @@ -245,15 +248,18 @@ static void do_test_ ## t(struct kunit *test, const struct test_ ## t *p) \
>   	check_one_op(t, fmt, mul, "*", p->b, p->a, p->prod, p->p_of);	\
>   }									\
>   									\
> -static void t ## _overflow_test(struct kunit *test) {			\
> +static void n ## _overflow_test(struct kunit *test) {			\
>   	unsigned i;							\
>   									\
> -	for (i = 0; i < ARRAY_SIZE(t ## _tests); ++i)			\
> -		do_test_ ## t(test, &t ## _tests[i]);			\
> +	for (i = 0; i < ARRAY_SIZE(n ## _tests); ++i)			\
> +		do_test_ ## n(test, &n ## _tests[i]);			\
>   	kunit_info(test, "%zu %s arithmetic tests finished\n",		\
> -		ARRAY_SIZE(t ## _tests), #t);				\
> +		ARRAY_SIZE(n ## _tests), #n);				\
>   }
>   
> +#define DEFINE_TEST_FUNC(t, fmt)					\
> +	DEFINE_TEST_FUNC_TYPED(t ## _ ## t ## __ ## t, t, fmt)
> +
>   DEFINE_TEST_FUNC(u8, "%d");
>   DEFINE_TEST_FUNC(s8, "%d");
>   DEFINE_TEST_FUNC(u16, "%d");
> @@ -265,6 +271,33 @@ DEFINE_TEST_FUNC(u64, "%llu");
>   DEFINE_TEST_FUNC(s64, "%lld");
>   #endif
>   
> +DEFINE_TEST_ARRAY_TYPED(u32, u32, u8) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{U8_MAX, 2, 1, U8_MAX - 2, U8_MAX - 1, true, false, true},
> +	{U8_MAX + 1, 0, 0, 0, 0, true, true, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(u32_u32__u8, u8, "%d");
> +
> +DEFINE_TEST_ARRAY_TYPED(u32, u32, int) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{U32_MAX, 0, -1, -1, 0, true, true, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(u32_u32__int, int, "%d");
> +
> +DEFINE_TEST_ARRAY_TYPED(u8, u8, int) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{U8_MAX, U8_MAX, 2 * U8_MAX, 0, U8_MAX * U8_MAX, false, false, false},
> +	{1, 2, 3, -1, 2, false, false, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(u8_u8__int, int, "%d");
> +
> +DEFINE_TEST_ARRAY_TYPED(int, int, u8) = {
> +	{0, 0, 0, 0, 0, false, false, false},
> +	{1, 2, 3, U8_MAX, 2, false, true, false},
> +	{-1, 0, U8_MAX, U8_MAX, 0, true, true, false},
> +};
> +DEFINE_TEST_FUNC_TYPED(int_int__u8, u8, "%d");
> +
>   static void overflow_shift_test(struct kunit *test)
>   {
>   	int count = 0;
> @@ -649,17 +682,21 @@ static void overflow_size_helpers_test(struct kunit *test)
>   }
>   
>   static struct kunit_case overflow_test_cases[] = {
> -	KUNIT_CASE(u8_overflow_test),
> -	KUNIT_CASE(s8_overflow_test),
> -	KUNIT_CASE(u16_overflow_test),
> -	KUNIT_CASE(s16_overflow_test),
> -	KUNIT_CASE(u32_overflow_test),
> -	KUNIT_CASE(s32_overflow_test),
> +	KUNIT_CASE(u8_u8__u8_overflow_test),
> +	KUNIT_CASE(s8_s8__s8_overflow_test),
> +	KUNIT_CASE(u16_u16__u16_overflow_test),
> +	KUNIT_CASE(s16_s16__s16_overflow_test),
> +	KUNIT_CASE(u32_u32__u32_overflow_test),
> +	KUNIT_CASE(s32_s32__s32_overflow_test),
>   /* Clang 13 and earlier generate unwanted libcalls on 32-bit. */
>   #if BITS_PER_LONG == 64
> -	KUNIT_CASE(u64_overflow_test),
> -	KUNIT_CASE(s64_overflow_test),
> +	KUNIT_CASE(u64_u64__u64_overflow_test),
> +	KUNIT_CASE(s64_s64__s64_overflow_test),
>   #endif
> +	KUNIT_CASE(u32_u32__u8_overflow_test),
> +	KUNIT_CASE(u32_u32__int_overflow_test),
> +	KUNIT_CASE(u8_u8__int_overflow_test),
> +	KUNIT_CASE(int_int__u8_overflow_test),
>   	KUNIT_CASE(overflow_shift_test),
>   	KUNIT_CASE(overflow_allocation_test),
>   	KUNIT_CASE(overflow_size_helpers_test),

