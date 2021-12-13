Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE34726D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhLMJzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:55:15 -0500
Received: from foss.arm.com ([217.140.110.172]:47644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236569AbhLMJuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92B11FB;
        Mon, 13 Dec 2021 01:50:20 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11BC33F793;
        Mon, 13 Dec 2021 01:50:18 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, elver@google.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 2/9] atomic: Add xchg.tbl
Message-ID: <YbcXVXGDCSyu2NxA@FVFF77S0Q05N>
References: <20211210161618.645249719@infradead.org>
 <20211210162313.377798220@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210162313.377798220@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:20PM +0100, Peter Zijlstra wrote:
> The tail of gen-atomic-instrumented.sh now looks like a hard-coded
> variant of atomics.tbl, extract it into xchg.tbl.
> 
> Add meta-'M' to generate the order variants.
> 
> No change in generated files.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Nice!

I had a look as to whether it was worthwhile passing in xhcg.tbl as a script
argument as with atomics.tbl, but that meant either padding a redundant arg to
the other scripts or complicating gen-atomics.sh, and would need more
refactoring of scripting, so I think this is fine as-is.

This all looks good to me, and I can confirm no changes when regenerating the
headers:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  scripts/atomic/atomic-tbl.sh              |   10 +++++-----
>  scripts/atomic/atomics.tbl                |    2 +-
>  scripts/atomic/gen-atomic-instrumented.sh |   18 ++----------------
>  scripts/atomic/xchg.tbl                   |   13 +++++++++++++
>  4 files changed, 21 insertions(+), 22 deletions(-)
> 
> --- a/scripts/atomic/atomic-tbl.sh
> +++ b/scripts/atomic/atomic-tbl.sh
> @@ -15,31 +15,31 @@ meta_in()
>  #meta_has_ret(meta)
>  meta_has_ret()
>  {
> -	meta_in "$1" "bBiIfFlRm"
> +	meta_in "$1" "bBiIfFlRMm"
>  }
>  
>  #meta_has_acquire(meta)
>  meta_has_acquire()
>  {
> -	meta_in "$1" "BFIlR"
> +	meta_in "$1" "BFIlRM"
>  }
>  
>  #meta_has_release(meta)
>  meta_has_release()
>  {
> -	meta_in "$1" "BFIRs"
> +	meta_in "$1" "BFIRsM"
>  }
>  
>  #meta_has_relaxed(meta)
>  meta_has_relaxed()
>  {
> -	meta_in "$1" "BFIR"
> +	meta_in "$1" "BFIRM"
>  }
>  
>  #meta_has_macro(meta)
>  meta_has_macro()
>  {
> -	meta_in "$1" "mn"
> +	meta_in "$1" "Mmn"
>  }
>  
>  #find_fallback_template(pfx, name, sfx, order)
> --- a/scripts/atomic/atomics.tbl
> +++ b/scripts/atomic/atomics.tbl
> @@ -10,7 +10,7 @@
>  # * F/f	- fetch: returns base type (has fetch_ variants)
>  # * l	- load: returns base type (has _acquire order variant)
>  # * s	- store: returns void (has _release order variant)
> -# * m	- macro: with return value
> +# * M/m	- macro: with return value
>  # * n	- macro: with No return value
>  #
>  # Where args contains list of type[:name], where type is:
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -195,22 +195,8 @@ grep '^[a-z]' "$1" | while read name met
>  	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}
>  done
>  
> -for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
> -	for order in "" "_acquire" "_release" "_relaxed"; do
> -		gen_proto_order_variant "m" "" "${xchg}" "" "${order}" "" "" "v:ptr" "V:..."
> -	done
> -done
> -
> -for order in "" "_acquire" "_release" "_relaxed"; do
> -	gen_proto_order_variant "m" "" "try_cmpxchg" "" "${order}" "" "" "v:ptr" "p:oldp" "V:..."
> -done
> -
> -for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
> -	gen_proto_order_variant "m" "" "${xchg}" "" "" "" "" "v:ptr" "V:..."
> -done
> -
> -for xchg in "cmpxchg_double" "cmpxchg_double_local"; do
> -	gen_proto_order_variant "m" "" "${xchg}" "" "" "" "" "P:ptr" "V:..."
> +grep '^[a-z]' $(dirname $1)/xchg.tbl | while read name meta args; do
> +	gen_proto "${meta}" "${name}" "" "" ${args}
>  done
>  
>  cat <<EOF
> --- /dev/null
> +++ b/scripts/atomic/xchg.tbl
> @@ -0,0 +1,13 @@
> +# name	meta	args...
> +#
> +# see atomics.tbl for a description of meta and args...
> +#
> +xchg			M	v:ptr	V:...
> +cmpxchg			M	v:ptr	V:...
> +cmpxchg64		M	v:ptr	V:...
> +try_cmpxchg		M	v:ptr	p:oldp	V:...
> +cmpxchg_local		m	v:ptr	V:...
> +cmpxchg64_local		m	v:ptr	V:...
> +sync_cmpxchg		m	v:ptr	V:...
> +cmpxchg_double		m	P:ptr	V:...
> +cmpxchg_double_local	m	P:ptr	V:...
> 
> 
