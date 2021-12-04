Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643894685DD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbhLDPQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 10:16:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60834 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbhLDPQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 10:16:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072DB60E9C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 15:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D11C341C2;
        Sat,  4 Dec 2021 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638630757;
        bh=G/W/hwyc76NgftD541U3X9khOR1ConPy4J15vFju+00=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z7v462uaFTGw4rEH+rEKV9cK6WlG296coCyL15mbpJD0XLAZTEiPoMuwIdL7KgybZ
         V5xvQD6zzmSklqlb4T5QWL1d7UHj/M+VM+lSV2UDN7sroCHbXdo4uBfXgZ9PAH1uQG
         oBCA+ioBlSv2eUFKHCFU+6fgdXV5/AcgCrjAFQ6TlK1ac03q2BmTYK4ZsbjWA3Z2LY
         xQTkv0VfiAGbj/AG0cHL22NaxMbU1joq6EFKs1s64pVyTMjnvCVlETHcLGifgLuWDD
         QlYGgQzygjGxF/asyhl8a7UEtZ5crboHGzdKQ6NPLv++454CCqe4IQQYHu7S+fuTgG
         LHj7rDhmrqkfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 282825C1010; Sat,  4 Dec 2021 07:12:37 -0800 (PST)
Date:   Sat, 4 Dec 2021 07:12:37 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH -rcu] kcsan: Turn barrier instrumentation into macros
Message-ID: <20211204151237.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211204125703.3344454-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204125703.3344454-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 01:57:03PM +0100, Marco Elver wrote:
> Some architectures use barriers in 'extern inline' functions, from which
> we should not refer to static inline functions.
> 
> For example, building Alpha with gcc and W=1 shows:
> 
> ./include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
>    70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
>       |                              ^~~~~~~~~
> ./arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
>   293 |         smp_rmb(); /* see above */
>       |         ^~~~~~~
> 
> Which seems to warn about 6.7.4#3 of the C standard:
>   "An inline definition of a function with external linkage shall not
>    contain a definition of a modifiable object with static or thread
>    storage duration, and shall not contain a reference to an identifier
>    with internal linkage."
> 
> Fix it by turning barrier instrumentation into macros, which matches
> definitions in <asm/barrier.h>.
> 
> Perhaps we can revert this change in future, when there are no more
> 'extern inline' users left.
> 
> Link: https://lkml.kernel.org/r/202112041334.X44uWZXf-lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  include/linux/kcsan-checks.h | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index 9d2c869167f2..92f3843d9ebb 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -241,28 +241,30 @@ static inline void __kcsan_disable_current(void) { }
>   * disabled with the __no_kcsan function attribute.
>   *
>   * Also see definition of __tsan_atomic_signal_fence() in kernel/kcsan/core.c.
> + *
> + * These are all macros, like <asm/barrier.h>, since some architectures use them
> + * in non-static inline functions.
>   */
>  #define __KCSAN_BARRIER_TO_SIGNAL_FENCE(name)					\
> -	static __always_inline void kcsan_##name(void)				\
> -	{									\
> +	do {									\
>  		barrier();							\
>  		__atomic_signal_fence(__KCSAN_BARRIER_TO_SIGNAL_FENCE_##name);	\
>  		barrier();							\
> -	}
> -__KCSAN_BARRIER_TO_SIGNAL_FENCE(mb)
> -__KCSAN_BARRIER_TO_SIGNAL_FENCE(wmb)
> -__KCSAN_BARRIER_TO_SIGNAL_FENCE(rmb)
> -__KCSAN_BARRIER_TO_SIGNAL_FENCE(release)
> +	} while (0)
> +#define kcsan_mb()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(mb)
> +#define kcsan_wmb()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(wmb)
> +#define kcsan_rmb()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(rmb)
> +#define kcsan_release()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(release)
>  #elif defined(CONFIG_KCSAN_WEAK_MEMORY) && defined(__KCSAN_INSTRUMENT_BARRIERS__)
>  #define kcsan_mb	__kcsan_mb
>  #define kcsan_wmb	__kcsan_wmb
>  #define kcsan_rmb	__kcsan_rmb
>  #define kcsan_release	__kcsan_release
>  #else /* CONFIG_KCSAN_WEAK_MEMORY && ... */
> -static inline void kcsan_mb(void)		{ }
> -static inline void kcsan_wmb(void)		{ }
> -static inline void kcsan_rmb(void)		{ }
> -static inline void kcsan_release(void)		{ }
> +#define kcsan_mb()	do { } while (0)
> +#define kcsan_wmb()	do { } while (0)
> +#define kcsan_rmb()	do { } while (0)
> +#define kcsan_release()	do { } while (0)
>  #endif /* CONFIG_KCSAN_WEAK_MEMORY && ... */
>  
>  /**
> -- 
> 2.34.1.400.ga245620fadb-goog
> 
