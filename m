Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B857FF6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiGYNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiGYNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:02:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06DC3615C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:02:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 326262B;
        Mon, 25 Jul 2022 06:02:24 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.28.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35FBF3F73B;
        Mon, 25 Jul 2022 06:02:22 -0700 (PDT)
Date:   Mon, 25 Jul 2022 14:02:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] random: discourage use of archrandom outside of rng
Message-ID: <Yt6UVkapnnJIThhj@FVFF77S0Q05N.cambridge.arm.com>
References: <Yt5hwxC1xgvA8Asw@zx2c4.com>
 <20220725111038.720624-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725111038.720624-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:10:38PM +0200, Jason A. Donenfeld wrote:
> Borislav pointed out during the review of "random: handle archrandom
> with multiple longs" that people might actually use this function, which
> might not be good because the function has surprising semantics. This of
> course was also the case before that patch, and indeed RDSEED-like
> functions across architectures often behave surprisingly, failing often.
> While random.c has been written specifically to work with that behavior,
> not much else is well equipped for that.
> 
> So add a comment suggesting that this is not for general consumption.
> Fortunately, nobody uses this for general consumption anyway, and people
> who try quickly find themselves in trouble. But adding this comment out
> of an abundance of caution was nonetheless suggested, and it at least
> means there will be easier justification for cleaning up potential
> misuses of the function later.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/archrandom.h   | 13 +++++++++++++
>  arch/powerpc/include/asm/archrandom.h |  8 ++++++++
>  arch/s390/include/asm/archrandom.h    |  8 ++++++++
>  arch/um/include/asm/archrandom.h      |  8 ++++++++
>  arch/x86/include/asm/archrandom.h     |  9 ++++++---
>  include/asm-generic/archrandom.h      |  8 ++++++++
>  6 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> index 109e2a4454be..0b5ee0e12a13 100644
> --- a/arch/arm64/include/asm/archrandom.h
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -58,6 +58,10 @@ static inline bool __arm64_rndrrs(unsigned long *v)
>  	return ok;
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>  {
>  	/*
> @@ -71,6 +75,10 @@ static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t
>  	return 0;
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  {
>  	if (!max_longs)
> @@ -121,6 +129,11 @@ static inline bool __init __early_cpu_has_rndr(void)
>  	return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
>  }
>  
> +
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __init __must_check
>  arch_get_random_seed_longs_early(unsigned long *v, size_t max_longs)
>  {
> diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
> index 0e365c5b2396..7accfe346d49 100644
> --- a/arch/powerpc/include/asm/archrandom.h
> +++ b/arch/powerpc/include/asm/archrandom.h
> @@ -4,11 +4,19 @@
>  
>  #include <asm/machdep.h>
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>  {
>  	return 0;
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  {
>  	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
> diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
> index cf5e000df0a1..ae1efdd6f3a9 100644
> --- a/arch/s390/include/asm/archrandom.h
> +++ b/arch/s390/include/asm/archrandom.h
> @@ -18,11 +18,19 @@
>  DECLARE_STATIC_KEY_FALSE(s390_arch_random_available);
>  extern atomic64_t s390_arch_random_counter;
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>  {
>  	return 0;
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  {
>  	if (static_branch_likely(&s390_arch_random_available)) {
> diff --git a/arch/um/include/asm/archrandom.h b/arch/um/include/asm/archrandom.h
> index 24e16c979c51..d2b20bb0ed53 100644
> --- a/arch/um/include/asm/archrandom.h
> +++ b/arch/um/include/asm/archrandom.h
> @@ -7,6 +7,10 @@
>  /* This is from <os.h>, but better not to #include that in a global header here. */
>  ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>  {
>  	ssize_t ret;
> @@ -17,6 +21,10 @@ static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t
>  	return ret / sizeof(*v);
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  {
>  	return 0;
> diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
> index 02bae8e0758b..8352948e6412 100644
> --- a/arch/x86/include/asm/archrandom.h
> +++ b/arch/x86/include/asm/archrandom.h
> @@ -41,15 +41,18 @@ static inline bool __must_check rdseed_long(unsigned long *v)
>  }
>  
>  /*
> - * These are the generic interfaces; they must not be declared if the
> - * stubs in <linux/random.h> are to be invoked.
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
>   */
> -
>  static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>  {
>  	return max_longs && static_cpu_has(X86_FEATURE_RDRAND) && rdrand_long(v) ? 1 : 0;
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  {
>  	return max_longs && static_cpu_has(X86_FEATURE_RDSEED) && rdseed_long(v) ? 1 : 0;
> diff --git a/include/asm-generic/archrandom.h b/include/asm-generic/archrandom.h
> index 3cd7f980cfdc..800b41639dd7 100644
> --- a/include/asm-generic/archrandom.h
> +++ b/include/asm-generic/archrandom.h
> @@ -2,11 +2,19 @@
>  #ifndef __ASM_GENERIC_ARCHRANDOM_H__
>  #define __ASM_GENERIC_ARCHRANDOM_H__
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
>  {
>  	return 0;
>  }
>  
> +/*
> + * This should only be used by drivers/char/random.c. Other drivers *must*
> + * use get_random_bytes() instead.
> + */
>  static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
>  {
>  	return 0;
> -- 
> 2.35.1
> 
