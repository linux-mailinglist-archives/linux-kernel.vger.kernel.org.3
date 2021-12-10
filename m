Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B599547072A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbhLJRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:31:19 -0500
Received: from foss.arm.com ([217.140.110.172]:44782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232216AbhLJRbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:31:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 375FC2B;
        Fri, 10 Dec 2021 09:27:31 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CBDC3F73B;
        Fri, 10 Dec 2021 09:27:29 -0800 (PST)
Date:   Fri, 10 Dec 2021 17:27:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/9] atomic: Prepare scripts for macro ops
Message-ID: <YbON7H4YwnSzG8z0@FVFF77S0Q05N>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.308243536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162313.308243536@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:19PM +0100, Peter Zijlstra wrote:
> Due to the limited usability of the GCC 'Labels as Values' extention,
> specifically it refuses to have a goto in an __always_inline function,
> even with a compile time constant label pointer, some new atomic ops
> will need to be introduced as macros.
> 
> The xchg/cmpxchg family is already macros so extend that code to the
> regular atomic ops.
> 
> Specifically introduce meta-'M', meta-'m' and meta-'n' to signify the
> op is a macro and add arg-'L', arg-'V' and arg-'P' for Label, VarArg
> and Pair arguments respectively.

Looks like `M` got factored out into the next patch, so I think that can be
deleted from this commit message.

> This unconvered some latent bugs in the instrumentation wrappery,
> specifically the try_cmpxchg() @oldp argument was instrumented as an
> atomic_read_write, while it's a regular read_write and many of the
> gen_xchg() ops had atomic_write instrumentation while
> atomic_read_write seems more appropriate.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/atomic/atomic-instrumented.h |   78 +++++++--------
>  scripts/atomic/atomic-tbl.sh               |    8 +
>  scripts/atomic/atomics.tbl                 |    5 +
>  scripts/atomic/gen-atomic-fallback.sh      |    4 
>  scripts/atomic/gen-atomic-instrumented.sh  |  142 +++++++++++++++++++----------
>  scripts/atomic/gen-atomic-long.sh          |   32 +++++-
>  6 files changed, 177 insertions(+), 92 deletions(-)
> 

[...]

> --- a/scripts/atomic/atomics.tbl
> +++ b/scripts/atomic/atomics.tbl
> @@ -10,12 +10,17 @@
>  # * F/f	- fetch: returns base type (has fetch_ variants)
>  # * l	- load: returns base type (has _acquire order variant)
>  # * s	- store: returns void (has _release order variant)
> +# * m	- macro: with return value
> +# * n	- macro: with No return value
>  #
>  # Where args contains list of type[:name], where type is:
>  # * cv	- const pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
>  # * v	- pointer to atomic base type (atomic_t/atomic64_t/atomic_long_t)
> +# * P	- pointer to pair of atomic base type
>  # * i	- base type (int/s64/long)
>  # * p	- pointer to base type (int/s64/long)
> +# * L	- label for exception case
> +# * V:... - vararg

Nit: should've been a tab here?

[...]

> @@ -51,57 +112,49 @@ gen_proto_order_variant()
>  	local order="$1"; shift
>  	local atomic="$1"; shift
>  	local int="$1"; shift
> +	local atomicname;
>  
> -	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
> +	if [ -n "${atomic}" ]; then
> +		atomicname="${atomic}_${pfx}${name}${sfx}${order}"
> +	else
> +		atomicname="${pfx}${name}${sfx}${order}"
> +	fi

How about:

	local atomicname="${pfx}${name}${sfx}${order}"
	if [ -n "${atomic}" ]; then
		atomicname="${atomic}_${atomicname}"
	fi

... so that it's clear we're just adding the atomic type as a prefix, and the
rest of the name should be the same either way?

Regardless of that specifically:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
