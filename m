Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F0D46DAED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhLHSYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:24:25 -0500
Received: from foss.arm.com ([217.140.110.172]:38438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232989AbhLHSYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:24:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 867061042;
        Wed,  8 Dec 2021 10:20:51 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5EF3F73D;
        Wed,  8 Dec 2021 10:20:50 -0800 (PST)
Date:   Wed, 8 Dec 2021 18:20:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     arnd@arndb.de, boqun.feng@gmail.com, lkp@intel.com, will@kernel.org
Subject: Re: [PATCH] locking/atomic: atomic64: remove unusable atomics
Message-ID: <YbD3f3CnTUkInNoP@FVFF77S0Q05N>
References: <20211126115923.41489-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126115923.41489-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, did you have any thoughts on this, or would you be happy to pick it as a
cleanup?

If there's anything on your queue that I can help to get out of the way, please
let me know!

Thanks,
Mark.

On Fri, Nov 26, 2021 at 11:59:23AM +0000, Mark Rutland wrote:
> The generic atomic64 implementation provides:
> 
> * atomic64_and_return()
> * atomic64_or_return()
> * atomic64_xor_return()
> 
> ... but none of these exist in the standard atomic64 API as described by
> scripts/atomic/atomics.tbl, and none of these have prototypes exposed by
> <asm-generic/atomic64.h>.
> 
> The lkp kernel test robot noted this results in warnings when building with
> W=1:
> 
>   lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_and_return' [-Wmissing-prototypes]
> 
>   lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_or_return' [-Wmissing-prototypes]
> 
>   lib/atomic64.c:82:5: warning: no previous prototype for 'generic_atomic64_xor_return' [-Wmissing-prototypes]
> 
> This appears to have been a thinko in commit:
> 
>   28aa2bda2211f432 ("locking/atomic: Implement atomic{,64,_long}_fetch_{add,sub,and,andnot,or,xor}{,_relaxed,_acquire,_release}()")
> 
> ... where we grouped add/sub separately from and/ox/xor, so that we could avoid
> implementing _return forms for the latter group, but forgot to remove
> ATOMIC64_OP_RETURN() for that group.
> 
> This doesn't cause any functional problem, but it's pointless to build code
> which cannot be used. Remove the unusable code. This does not affect add/sub,
> for which _return forms will still be built.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/r/202111120712.RtQHZohY-lkp@intel.com
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  lib/atomic64.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/lib/atomic64.c b/lib/atomic64.c
> index 3df653994177..caf895789a1e 100644
> --- a/lib/atomic64.c
> +++ b/lib/atomic64.c
> @@ -118,7 +118,6 @@ ATOMIC64_OPS(sub, -=)
>  #undef ATOMIC64_OPS
>  #define ATOMIC64_OPS(op, c_op)						\
>  	ATOMIC64_OP(op, c_op)						\
> -	ATOMIC64_OP_RETURN(op, c_op)					\
>  	ATOMIC64_FETCH_OP(op, c_op)
>  
>  ATOMIC64_OPS(and, &=)
> @@ -127,7 +126,6 @@ ATOMIC64_OPS(xor, ^=)
>  
>  #undef ATOMIC64_OPS
>  #undef ATOMIC64_FETCH_OP
> -#undef ATOMIC64_OP_RETURN
>  #undef ATOMIC64_OP
>  
>  s64 generic_atomic64_dec_if_positive(atomic64_t *v)
> -- 
> 2.30.2
> 
