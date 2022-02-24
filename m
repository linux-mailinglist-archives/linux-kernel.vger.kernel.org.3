Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE84C295A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiBXK2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbiBXK2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:28:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5ED21B8FE2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:28:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80CB01509;
        Thu, 24 Feb 2022 02:28:01 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164A73F70D;
        Thu, 24 Feb 2022 02:27:59 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:27:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Junru Shen <hhusjrsjr@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Put the fetching of the old value into the loop
 when doing atomic CAS
Message-ID: <YhddqvNzc5Hz7Ogj@lakrids>
References: <20220224082438.580191-1-hhusjrsjr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224082438.580191-1-hhusjrsjr@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:24:38PM +0800, Junru Shen wrote:
> Put the acquisition of the expected value inside the loop to prevent
> an infinite loop when it does not match.

I suspect you've found this by inspection, as I don't beleive this can
happen. See below.

> Signed-off-by: Junru Shen <hhusjrsjr@gmail.com>
> ---
>  arch/x86/include/asm/atomic64_64.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> index 7886d0578..3df04c44c 100644
> --- a/arch/x86/include/asm/atomic64_64.h
> +++ b/arch/x86/include/asm/atomic64_64.h
> @@ -207,9 +207,10 @@ static inline void arch_atomic64_and(s64 i, atomic64_t *v)
>  
>  static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val;
>  
>  	do {
> +		val = arch_atomic64_read(v);
>  	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
  	                                       ^^^^
See this bit above? ----------------------------'

If arch_atomic64_try_cmpxchg() fails, it writes the value in memory back to
this address, so it has already done the equivalent of arch_atomic64_read(v).

If you're seing this go wrong, it implies that arch_atomic64_try_cmpxchg() is
being mis-compiled, so please provide an example and the disassembly.

Likewise for the other instances below.

Thanks,
Mark.

>  	return val;
>  }
> @@ -225,9 +226,10 @@ static inline void arch_atomic64_or(s64 i, atomic64_t *v)
>  
>  static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val;
>  
>  	do {
> +		val = arch_atomic64_read(v);
>  	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
>  	return val;
>  }
> @@ -243,9 +245,10 @@ static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
>  
>  static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
>  {
> -	s64 val = arch_atomic64_read(v);
> +	s64 val;
>  
>  	do {
> +		val = arch_atomic64_read(v);
>  	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
>  	return val;
>  }
> -- 
> 2.30.2
> 
