Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA75775F7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiGQLoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGQLoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:44:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163AC7650
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97EC66116D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E84C3411E;
        Sun, 17 Jul 2022 11:43:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SMA3G7LX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658058234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9MbqVwgcJnoOlNPAuS5Ly0No5YVUHo8q+iz8NfenLo=;
        b=SMA3G7LXEHY/BR6O0EZDYgbFqMZYmzWtMhNl9YAImcnXhDi2O/vJC7tNcY3o2ESEm8o03F
        2DC/DMgjiSXFueIke1hBaBEu1JbfXlZCy33ynibqNHdbYVYz0ORUyX6+ln4QySWcCASN/+
        SIb++mH0xfwtGExzD0QnVvSgFIPBacw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f7ddcdb9 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 17 Jul 2022 11:43:54 +0000 (UTC)
Date:   Sun, 17 Jul 2022 13:43:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH] random: handle archrandom in plural words
Message-ID: <YtP1+MJ1tNdJA60l@zx2c4.com>
References: <20220717112439.1795588-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220717112439.1795588-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 01:24:39PM +0200, Jason A. Donenfeld wrote:
> The archrandom interface was originally designed for x86, which supplies
> RDRAND/RDSEED for receiving random words into registers, resulting in
> one function to generate an int and another to generate a long. However,
> other architectures don't follow this.
> 
> On arm64, the SMCCC TRNG interface can return between 1 and 3 words. On
> s390, the CPACF TRNG interface can return between 1 and 32 words for the
> same cost as for one word. On UML, the os_getrandom() interface can return
> arbitrary amounts.
> 
> So change the api signature to take a "words" parameter designating the
> maximum number of words requested, and then return the number of words
> generated.
> 
> Since callers need to check this return value and loop anyway, each arch
> implementation does not bother implementing its own loop to try again to
> fill the requested number of words. Additionally, all existing callers
> pass in a constant words parameter. Taken together, these two things
> mean that the codegen doesn't really change much for one-word-at-a-time
> platforms, while performance is greatly improved on platforms such as
> s390.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/include/asm/archrandom.h   | 102 ++++++++++++--------------
>  arch/arm64/kernel/kaslr.c             |   2 +-
>  arch/powerpc/include/asm/archrandom.h |  30 ++------
>  arch/powerpc/kvm/book3s_hv.c          |   2 +-
>  arch/s390/include/asm/archrandom.h    |  25 ++-----
>  arch/um/include/asm/archrandom.h      |  21 ++----
>  arch/x86/include/asm/archrandom.h     |  41 +----------
>  arch/x86/kernel/espfix_64.c           |   2 +-
>  drivers/char/random.c                 |  45 ++++++++----
>  include/asm-generic/archrandom.h      |  14 +---
>  include/linux/random.h                |  12 +--
>  11 files changed, 111 insertions(+), 185 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
> index c3b9fa56af67..7a24fdee3e2f 100644
> --- a/arch/arm64/include/asm/archrandom.h
> +++ b/arch/arm64/include/asm/archrandom.h
> @@ -58,7 +58,7 @@ static inline bool __arm64_rndrrs(unsigned long *v)
>  	return ok;
>  }
>  
> -static inline bool __must_check arch_get_random_long(unsigned long *v)
> +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>  {
>  	/*
>  	 * Only support the generic interface after we have detected
> @@ -66,27 +66,15 @@ static inline bool __must_check arch_get_random_long(unsigned long *v)
>  	 * cpufeature code and with potential scheduling between CPUs
>  	 * with and without the feature.
>  	 */
> -	if (cpus_have_const_cap(ARM64_HAS_RNG) && __arm64_rndr(v))
> -		return true;
> -	return false;
> +	if (words && cpus_have_const_cap(ARM64_HAS_RNG) && __arm64_rndr(v))
> +		return 1;
> +	return 0;
>  }
>  
> -static inline bool __must_check arch_get_random_int(unsigned int *v)
> +static inline size_t __must_check arch_get_random_seed_words(unsigned long *v, size_t words)
>  {
> -	if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> -		unsigned long val;
> -
> -		if (__arm64_rndr(&val)) {
> -			*v = val;
> -			return true;
> -		}
> -	}
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> -{
> -	struct arm_smccc_res res;
> +	if (!words)
> +		return 0;
>  
>  	/*
>  	 * We prefer the SMCCC call, since its semantics (return actual
> @@ -95,10 +83,23 @@ static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  	 * (the output of a pseudo RNG freshly seeded by a TRNG).
>  	 */
>  	if (smccc_trng_available) {
> -		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> +		struct arm_smccc_res res;
> +
> +		words = min_t(size_t, 3, words);
> +		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, words * 64, &res);
>  		if ((int)res.a0 >= 0) {
> -			*v = res.a3;
> -			return true;
> +			switch (words) {
> +			case 3:
> +				*v++ = res.a1;
> +				fallthrough;
> +			case 2:
> +				*v++ = res.a2;
> +				fallthrough;
> +			case 1:
> +				*v++ = res.a3;
> +				break;
> +			}
> +			return words;
>  		}
>  	}
>  
> @@ -108,32 +109,9 @@ static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  	 * enough to implement this API if no other entropy source exists.
>  	 */
>  	if (cpus_have_const_cap(ARM64_HAS_RNG) && __arm64_rndrrs(v))
> -		return true;
> +		return 1;
>  
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> -{
> -	struct arm_smccc_res res;
> -	unsigned long val;
> -
> -	if (smccc_trng_available) {
> -		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 32, &res);
> -		if ((int)res.a0 >= 0) {
> -			*v = res.a3 & GENMASK(31, 0);
> -			return true;
> -		}
> -	}
> -
> -	if (cpus_have_const_cap(ARM64_HAS_RNG)) {
> -		if (__arm64_rndrrs(&val)) {
> -			*v = val;
> -			return true;
> -		}
> -	}
> -
> -	return false;
> +	return 0;
>  }
>  
>  static inline bool __init __early_cpu_has_rndr(void)
> @@ -143,26 +121,40 @@ static inline bool __init __early_cpu_has_rndr(void)
>  	return (ftr >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf;
>  }
>  
> -static inline bool __init __must_check
> -arch_get_random_seed_long_early(unsigned long *v)
> +static inline size_t __init __must_check
> +arch_get_random_seed_words_early(unsigned long *v, size_t words)
>  {
>  	WARN_ON(system_state != SYSTEM_BOOTING);
>  
> +	if (!words)
> +		return 0;
> +
>  	if (smccc_trng_available) {
>  		struct arm_smccc_res res;
>  
> -		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
> +		words = min_t(size_t, 3, words);
> +		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, words * 64, &res);
>  		if ((int)res.a0 >= 0) {
> -			*v = res.a3;
> -			return true;
> +			switch (words) {
> +			case 3:
> +				*v++ = res.a1;
> +				fallthrough;
> +			case 2:
> +				*v++ = res.a2;
> +				fallthrough;
> +			case 1:
> +				*v++ = res.a3;
> +				break;
> +			}
> +			return words;
>  		}
>  	}
>  
>  	if (__early_cpu_has_rndr() && __arm64_rndr(v))
> -		return true;
> +		return 1;
>  
> -	return false;
> +	return 0;
>  }
> -#define arch_get_random_seed_long_early arch_get_random_seed_long_early
> +#define arch_get_random_seed_words_early arch_get_random_seed_words_early
>  
>  #endif /* _ASM_ARCHRANDOM_H */
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 418b2bba1521..ed77afe16121 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -106,7 +106,7 @@ u64 __init kaslr_early_init(void)
>  	 * and supported.
>  	 */
>  
> -	if (arch_get_random_seed_long_early(&raw))
> +	if (arch_get_random_seed_words_early(&raw, 1))
>  		seed ^= raw;
>  
>  	if (!seed) {
> diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
> index 25ba65df6b1a..bf2182f80480 100644
> --- a/arch/powerpc/include/asm/archrandom.h
> +++ b/arch/powerpc/include/asm/archrandom.h
> @@ -4,34 +4,16 @@
>  
>  #include <asm/machdep.h>
>  
> -static inline bool __must_check arch_get_random_long(unsigned long *v)
> +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>  {
> -	return false;
> +	return 0;
>  }
>  
> -static inline bool __must_check arch_get_random_int(unsigned int *v)
> +static inline size_t __must_check arch_get_random_seed_words(unsigned long *v, size_t words)
>  {
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> -{
> -	if (ppc_md.get_random_seed)
> -		return ppc_md.get_random_seed(v);
> -
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> -{
> -	unsigned long val;
> -	bool rc;
> -
> -	rc = arch_get_random_seed_long(&val);
> -	if (rc)
> -		*v = val;
> -
> -	return rc;
> +	if (words && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
> +		return 1;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PPC_POWERNV
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index e08fb3124dca..18b2d80996b6 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1207,7 +1207,7 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  		break;
>  #endif
>  	case H_RANDOM:
> -		if (!arch_get_random_seed_long(&vcpu->arch.regs.gpr[4]))
> +		if (!arch_get_random_seed_words(&vcpu->arch.regs.gpr[4], 1))
>  			ret = H_HARDWARE;
>  		break;
>  	case H_RPT_INVALIDATE:
> diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
> index 0a1c2e66c709..5ada507a1fb8 100644
> --- a/arch/s390/include/asm/archrandom.h
> +++ b/arch/s390/include/asm/archrandom.h
> @@ -18,31 +18,16 @@
>  DECLARE_STATIC_KEY_FALSE(s390_arch_random_available);
>  extern atomic64_t s390_arch_random_counter;
>  
> -static inline bool __must_check arch_get_random_long(unsigned long *v)
> +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>  {
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_int(unsigned int *v)
> -{
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> -{
> -	if (static_branch_likely(&s390_arch_random_available)) {
> -		cpacf_trng(NULL, 0, (u8 *)v, sizeof(*v));
> -		atomic64_add(sizeof(*v), &s390_arch_random_counter);
> -		return true;
> -	}
> -	return false;
> +	return 0;
>  }
>  
> -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> +static inline size_t __must_check arch_get_random_seed_words(unsigned long *v, size_t words)
>  {
>  	if (static_branch_likely(&s390_arch_random_available)) {
> -		cpacf_trng(NULL, 0, (u8 *)v, sizeof(*v));
> -		atomic64_add(sizeof(*v), &s390_arch_random_counter);
> +		cpacf_trng(NULL, 0, (u8 *)v, words * sizeof(*v));
> +		atomic64_add(words * sizeof(*v), &s390_arch_random_counter);
>  		return true;

return words;

>  	}
>  	return false;

return 0;

> diff --git a/arch/um/include/asm/archrandom.h b/arch/um/include/asm/archrandom.h
> index 2f24cb96391d..1dd9207c42f8 100644
> --- a/arch/um/include/asm/archrandom.h
> +++ b/arch/um/include/asm/archrandom.h
> @@ -7,24 +7,17 @@
>  /* This is from <os.h>, but better not to #include that in a global header here. */
>  ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);
>  
> -static inline bool __must_check arch_get_random_long(unsigned long *v)
> +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>  {
> -	return os_getrandom(v, sizeof(*v), 0) == sizeof(*v);
> +	ssize_t ret = os_getrandom(v, words * sizeof(*v), 0);
> +	if (ret < 0)
> +		return 0;
> +	return ret;

return ret / sizeof(*v);

>  }
>  
> -static inline bool __must_check arch_get_random_int(unsigned int *v)
> +static inline size_t __must_check arch_get_random_seed_words(unsigned long *v, size_t words)
>  {
> -	return os_getrandom(v, sizeof(*v), 0) == sizeof(*v);
> -}
> -
> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> -{
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> -{
> -	return false;
> +	return 0;
>  }
>  
>  #endif
> diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
> index fb235b696175..a1717b81d876 100644
> --- a/arch/x86/include/asm/archrandom.h
> +++ b/arch/x86/include/asm/archrandom.h
> @@ -31,20 +31,6 @@ static inline bool __must_check rdrand_long(unsigned long *v)
>  	return false;
>  }
>  
> -static inline bool __must_check rdrand_int(unsigned int *v)
> -{
> -	bool ok;
> -	unsigned int retry = RDRAND_RETRY_LOOPS;
> -	do {
> -		asm volatile("rdrand %[out]"
> -			     CC_SET(c)
> -			     : CC_OUT(c) (ok), [out] "=r" (*v));
> -		if (ok)
> -			return true;
> -	} while (--retry);
> -	return false;
> -}
> -
>  static inline bool __must_check rdseed_long(unsigned long *v)
>  {
>  	bool ok;
> @@ -54,38 +40,19 @@ static inline bool __must_check rdseed_long(unsigned long *v)
>  	return ok;
>  }
>  
> -static inline bool __must_check rdseed_int(unsigned int *v)
> -{
> -	bool ok;
> -	asm volatile("rdseed %[out]"
> -		     CC_SET(c)
> -		     : CC_OUT(c) (ok), [out] "=r" (*v));
> -	return ok;
> -}
> -
>  /*
>   * These are the generic interfaces; they must not be declared if the
>   * stubs in <linux/random.h> are to be invoked.
>   */
>  
> -static inline bool __must_check arch_get_random_long(unsigned long *v)
> -{
> -	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_long(v) : false;
> -}
> -
> -static inline bool __must_check arch_get_random_int(unsigned int *v)
> -{
> -	return static_cpu_has(X86_FEATURE_RDRAND) ? rdrand_int(v) : false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>  {
> -	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_long(v) : false;
> +	return words && static_cpu_has(X86_FEATURE_RDRAND) && rdrand_long(v) ? 1 : 0;
>  }
>  
> -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> +static inline size_t __must_check arch_get_random_seed_words(unsigned long *v, size_t words)
>  {
> -	return static_cpu_has(X86_FEATURE_RDSEED) ? rdseed_int(v) : false;
> +	return words && static_cpu_has(X86_FEATURE_RDSEED) && rdseed_long(v) ? 1 : 0;
>  }
>  
>  #ifndef CONFIG_UML
> diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
> index 4fe7af58cfe1..f46c9ff3c0d4 100644
> --- a/arch/x86/kernel/espfix_64.c
> +++ b/arch/x86/kernel/espfix_64.c
> @@ -100,7 +100,7 @@ static void init_espfix_random(void)
>  	 * This is run before the entropy pools are initialized,
>  	 * but this is hopefully better than nothing.
>  	 */
> -	if (!arch_get_random_long(&rand)) {
> +	if (!arch_get_random_words(&rand, 1)) {
>  		/* The constant is an arbitrary large prime */
>  		rand = rdtsc();
>  		rand *= 0xc345c6b72fd16123UL;
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 0c6568ae5f68..70d8d1d7e2d7 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -596,12 +596,20 @@ static void extract_entropy(void *buf, size_t len)
>  		unsigned long rdseed[32 / sizeof(long)];
>  		size_t counter;
>  	} block;
> -	size_t i;
> +	size_t i, words;
>  
> -	for (i = 0; i < ARRAY_SIZE(block.rdseed); ++i) {
> -		if (!arch_get_random_seed_long(&block.rdseed[i]) &&
> -		    !arch_get_random_long(&block.rdseed[i]))
> -			block.rdseed[i] = random_get_entropy();
> +	for (i = 0; i < ARRAY_SIZE(block.rdseed);) {
> +		words = arch_get_random_seed_words(&block.rdseed[i], ARRAY_SIZE(block.rdseed) - i);
> +		if (words) {
> +			i += words;
> +			continue;
> +		}
> +		words = arch_get_random_words(&block.rdseed[i], ARRAY_SIZE(block.rdseed) - i);
> +		if (words) {
> +			i += words;
> +			continue;
> +		}
> +		block.rdseed[i++] = random_get_entropy();
>  	}
>  
>  	spin_lock_irqsave(&input_pool.lock, flags);
> @@ -776,22 +784,31 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
>  int __init random_init(const char *command_line)
>  {
>  	ktime_t now = ktime_get_real();
> -	unsigned int i, arch_bits;
> -	unsigned long entropy;
> +	size_t i, words, arch_bits;
> +	unsigned long entropy[BLAKE2S_BLOCK_SIZE / sizeof(long)];
>  
>  #if defined(LATENT_ENTROPY_PLUGIN)
>  	static const u8 compiletime_seed[BLAKE2S_BLOCK_SIZE] __initconst __latent_entropy;
>  	_mix_pool_bytes(compiletime_seed, sizeof(compiletime_seed));
>  #endif
>  
> -	for (i = 0, arch_bits = BLAKE2S_BLOCK_SIZE * 8;
> -	     i < BLAKE2S_BLOCK_SIZE; i += sizeof(entropy)) {
> -		if (!arch_get_random_seed_long_early(&entropy) &&
> -		    !arch_get_random_long_early(&entropy)) {
> -			entropy = random_get_entropy();
> -			arch_bits -= sizeof(entropy) * 8;
> +	for (i = 0, arch_bits = sizeof(entropy) * 8; i < ARRAY_SIZE(entropy);) {
> +		words = arch_get_random_seed_words(entropy, ARRAY_SIZE(entropy) - i);
> +		if (words) {
> +			_mix_pool_bytes(entropy, sizeof(*entropy) * words);
> +			i += words;
> +			continue;
>  		}
> -		_mix_pool_bytes(&entropy, sizeof(entropy));
> +		words = arch_get_random_words(entropy, ARRAY_SIZE(entropy) - i);
> +		if (words) {
> +			_mix_pool_bytes(entropy, sizeof(*entropy) * words);
> +			i += words;
> +			continue;
> +		}
> +		entropy[0] = random_get_entropy();
> +		_mix_pool_bytes(entropy, sizeof(*entropy));
> +		arch_bits -= sizeof(*entropy) * 8;
> +		++i;
>  	}
>  	_mix_pool_bytes(&now, sizeof(now));
>  	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
> diff --git a/include/asm-generic/archrandom.h b/include/asm-generic/archrandom.h
> index 3a5ee202dd86..4cdf9ab2b6cc 100644
> --- a/include/asm-generic/archrandom.h
> +++ b/include/asm-generic/archrandom.h
> @@ -2,22 +2,12 @@
>  #ifndef __ASM_GENERIC_ARCHRANDOM_H__
>  #define __ASM_GENERIC_ARCHRANDOM_H__
>  
> -static inline bool __must_check arch_get_random_long(unsigned long *v)
> +static inline size_t __must_check arch_get_random_words(unsigned long *v, size_t words)
>  {
>  	return false;

return 0;

>  }
>  
> -static inline bool __must_check arch_get_random_int(unsigned int *v)
> -{
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
> -{
> -	return false;
> -}
> -
> -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
> +static inline size_t __must_check arch_get_random_seed_words(unsigned long *v, size_t words)
>  {
>  	return false;

return 0;

>  }
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 865770e29f3e..0a327a289f09 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -112,19 +112,19 @@ declare_get_random_var_wait(long, unsigned long)
>   * Called from the boot CPU during startup; not valid to call once
>   * secondary CPUs are up and preemption is possible.
>   */
> -#ifndef arch_get_random_seed_long_early
> -static inline bool __init arch_get_random_seed_long_early(unsigned long *v)
> +#ifndef arch_get_random_seed_words_early
> +static inline size_t __init arch_get_random_seed_words_early(unsigned long *v, size_t words)
>  {
>  	WARN_ON(system_state != SYSTEM_BOOTING);
> -	return arch_get_random_seed_long(v);
> +	return arch_get_random_seed_words(v, words);
>  }
>  #endif
>  
> -#ifndef arch_get_random_long_early
> -static inline bool __init arch_get_random_long_early(unsigned long *v)
> +#ifndef arch_get_random_words_early
> +static inline bool __init arch_get_random_words_early(unsigned long *v, size_t words)
>  {
>  	WARN_ON(system_state != SYSTEM_BOOTING);
> -	return arch_get_random_long(v);
> +	return arch_get_random_words(v, words);
>  }
>  #endif
>  
> -- 
> 2.35.1
> 
