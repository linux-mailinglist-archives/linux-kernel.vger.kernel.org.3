Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63394A87B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351872AbiBCPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:35:37 -0500
Received: from foss.arm.com ([217.140.110.172]:53052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233431AbiBCPfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:35:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BB1E1424;
        Thu,  3 Feb 2022 07:35:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.88.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 359AB3F40C;
        Thu,  3 Feb 2022 07:35:35 -0800 (PST)
Date:   Thu, 3 Feb 2022 15:35:30 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, boqun.feng@gmail.com, peterz@infradead.org,
        will@kernel.org, ardb@kernel.org
Subject: Re: [PATCH] atomics: fix atomic64_{read_acquire,set_release}
 fallbacks
Message-ID: <Yfv2Qgh/FYdGtQFj@FVFF77S0Q05N>
References: <20220203143848.3934515-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203143848.3934515-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 02:38:48PM +0000, Mark Rutland wrote:
> @@ -1258,7 +1272,16 @@ arch_atomic_dec_if_positive(atomic_t *v)
>  static __always_inline s64
>  arch_atomic64_read_acquire(const atomic64_t *v)
>  {
> -	return smp_load_acquire(&(v)->counter);
> +	s64 ret;
> +
> +	if (__native_word(atomic64_t)) {
> +		ret = smp_load_acquire(&(v)->counter);
> +	} else {
> +		ret = arch_atomic_read(v);

Ard pointed out on IRC that this is bogus, and should be using
arch_atomic64_read() ...

> +		__atomic_acquire_fence();
> +	}
> +
> +	return ret;
>  }
>  #define arch_atomic64_read_acquire arch_atomic64_read_acquire
>  #endif
> @@ -1267,7 +1290,12 @@ arch_atomic64_read_acquire(const atomic64_t *v)
>  static __always_inline void
>  arch_atomic64_set_release(atomic64_t *v, s64 i)
>  {
> -	smp_store_release(&(v)->counter, i);
> +	if (__native_word(atomic64_t)) {
> +		smp_store_release(&(v)->counter, i);
> +	} else {
> +		__atomic_release_fence();
> +		arch_atomic_set(v, i);

... and arch_atomic64_set() ...

> +	}
>  }
>  #define arch_atomic64_set_release arch_atomic64_set_release
>  #endif
> @@ -2358,4 +2386,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #endif
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// cca554917d7ea73d5e3e7397dd70c484cad9b2c4
> +// ba488b6398359cb776d457971f30cef78d0d36dc
> diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
> index 803ba7561076..7b8b87143c0c 100755
> --- a/scripts/atomic/fallbacks/read_acquire
> +++ b/scripts/atomic/fallbacks/read_acquire
> @@ -2,6 +2,15 @@ cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_read_acquire(const ${atomic}_t *v)
>  {
> -	return smp_load_acquire(&(v)->counter);
> +	${int} ret;
> +
> +	if (__native_word(${atomic}_t)) {
> +		ret = smp_load_acquire(&(v)->counter);
> +	} else {
> +		ret = arch_atomic_read(v);

... because this should be arch_${atomic}_read() ...

> +		__atomic_acquire_fence();
> +	}
> +
> +	return ret;
>  }
>  EOF
> diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
> index 86ede759f24e..5f692db3ce29 100755
> --- a/scripts/atomic/fallbacks/set_release
> +++ b/scripts/atomic/fallbacks/set_release
> @@ -2,6 +2,11 @@ cat <<EOF
>  static __always_inline void
>  arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
>  {
> -	smp_store_release(&(v)->counter, i);
> +	if (__native_word(${atomic}_t)) {
> +		smp_store_release(&(v)->counter, i);
> +	} else {
> +		__atomic_release_fence();
> +		arch_atomic_set(v, i);

... and this should be arch_${atomic}_set().

I'll spin a v2 with that corrected.

Thanks,
Mark.
