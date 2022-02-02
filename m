Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997034A7536
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345626AbiBBQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:01:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45124 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiBBQBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:01:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 257C6B831A5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D5CC004E1;
        Wed,  2 Feb 2022 16:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643817671;
        bh=xY/tyDM9TE7fNi/TXqAUlya0knvSWbYnTKhzfBHBIVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNITSCmtm/ADY+hgozLM2hXfWFkZcoF7SgqxxI4HVjNlHu5DwB2y+FAd0P2qA18qA
         a1B0LuHWgucoSpbWrMgmRXsP7bZZV5ABgFiQDW38s36AGMABdxLKF6nBCE8yad1WpN
         mV5Q635B/rx1kdbKdK+Adi/nOaKOCJ0wnqwIZ9ycrAmt9g/0gBsmq/10CnIdNDkHyz
         uApS+di1tbca//X8kns8p016xWr7vR8Kuu3zm3VWeF0g1fPAzN0fodo0EmMWysLX5s
         qGIWj13Lihu1KPy6d0hb7l061mC9sQB+RVQMByYBnEZetczZ5XGQvsPk60sW0xarFi
         Iavw5uQV6Qo2A==
Date:   Wed, 2 Feb 2022 09:01:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] include: drop pointless __compiler_offsetof indirection
Message-ID: <YfqqwxKCP+qJCyYg@dev-arch.archlinux-ax161>
References: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202102147.326672-1-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 11:21:47AM +0100, Rasmus Villemoes wrote:
> (1) compiler_types.h is unconditionally included via an -include
> flag (see scripts/Makefile.lib), and it defines __compiler_offsetof
> unconditionally. So testing for definedness of __compiler_offsetof is
> mostly pointless.
> 
> (2) Every relevant compiler provides __builtin_offsetof (even sparse
> has had that for 14 years), and if for whatever reason one would end
> up picking up the poor man's fallback definition (C file compiler with
> completely custom CFLAGS?), newer clang versions won't treat the
> result as an Integer Constant Expression, so if used in place where
> such is required (static initializer or static_assert), one would
> get errors like
> 
> t.c:11:16: error: static_assert expression is not an integral constant expression
> t.c:11:16: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
> t.c:4:33: note: expanded from macro 'offsetof'
> #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
> 
> So just define offsetof unconditionally and directly in terms of
> __builtin_offsetof.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler_types.h | 2 --
>  include/linux/stddef.h         | 6 +-----
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 3c1795fdb568..83ee7f7ada5d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -137,8 +137,6 @@ struct ftrace_likely_data {
>   */
>  #define __naked			__attribute__((__naked__)) notrace
>  
> -#define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
> -
>  /*
>   * Prefer gnu_inline, so that extern inline functions do not emit an
>   * externally visible function. This makes extern inline behave as per gnu89
> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index ca507bd5f808..929d67710cc5 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -13,11 +13,7 @@ enum {
>  };
>  
>  #undef offsetof
> -#ifdef __compiler_offsetof
> -#define offsetof(TYPE, MEMBER)	__compiler_offsetof(TYPE, MEMBER)
> -#else
> -#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
> -#endif
> +#define offsetof(TYPE, MEMBER)	__builtin_offsetof(TYPE, MEMBER)
>  
>  /**
>   * sizeof_field() - Report the size of a struct field in bytes
> -- 
> 2.31.1
> 
