Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932634B028E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiBJB5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:57:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiBJB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C262AA80;
        Wed,  9 Feb 2022 17:36:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F65FB823EF;
        Thu, 10 Feb 2022 00:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4934DC340E7;
        Thu, 10 Feb 2022 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644454603;
        bh=eYU7NV2lU87Te/oArn1NFLW6lyegJxoiFC+uPfhAoqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHNJ+HIGQETrnOyMDDQrDAi7CbpVHwry6k0dMz7Pll50RKFrgTdC7ep7ZJJsbkQ9o
         nTH/ipeptiqJQB9LfMlZEXWuno7bbnE7pH/5O0B051E4cZsA5yGzWV3crxMqw4NgJ5
         iXcswHuj30mc0r0F7U5EV/DfEEMJFq2/w/GPjlNJIf+/dLy0mLiXZGPAJ54Lc7wJaZ
         nA1EOyKH0EGXRI7wJJJVLqMm1y1P4VenifBojYd7ZRMwkqsRRnWCoL/kQU085yNLkh
         BKykwY5Er6HpdG7W3KbwpaLNIrrJeIyZyqKLsk7rLBrT/+cG+EftZhyCL6GUTVrQ74
         r6qFp0TC9oHcg==
Date:   Wed, 9 Feb 2022 19:04:07 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] overflow: Provide constant expression struct_size
Message-ID: <20220210010407.GA701603@embeddedor>
References: <20220210004326.776574-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210004326.776574-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 04:43:26PM -0800, Kees Cook wrote:
> There have been cases where struct_size() (or flex_array_size()) needs
> to be calculated for an initializer, which requires it be a constant
> expression. This is possible when the "count" argument is a constant
> expression, so provide this ability for the helpers.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/linux/overflow.h | 10 +++++++---
>  lib/test_overflow.c      |  7 +++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 59d7228104d0..f1221d11f8e5 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/limits.h>
> +#include <linux/const.h>
>  
>  /*
>   * We need to compute the minimum and maximum values representable in a given
> @@ -221,8 +222,9 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
>  #define flex_array_size(p, member, count)				\
> -	size_mul(count,							\
> -		 sizeof(*(p)->member) + __must_be_array((p)->member))
> +	__builtin_choose_expr(__is_constexpr(count),			\
> +		(count) * sizeof(*(p)->member) + __must_be_array((p)->member),	\
> +		size_mul(count, sizeof(*(p)->member) + __must_be_array((p)->member)))
>  
>  /**
>   * struct_size() - Calculate size of structure with trailing flexible array.
> @@ -237,6 +239,8 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>   * Return: number of bytes needed or SIZE_MAX on overflow.
>   */
>  #define struct_size(p, member, count)					\
> -	size_add(sizeof(*(p)), flex_array_size(p, member, count))
> +	__builtin_choose_expr(__is_constexpr(count),			\
> +		sizeof(*(p)) + flex_array_size(p, member, count),	\
> +		size_add(sizeof(*(p)), flex_array_size(p, member, count)))
>  
>  #endif /* __LINUX_OVERFLOW_H */
> diff --git a/lib/test_overflow.c b/lib/test_overflow.c
> index 712fb2351c27..d488ffaf56be 100644
> --- a/lib/test_overflow.c
> +++ b/lib/test_overflow.c
> @@ -602,11 +602,18 @@ struct __test_flex_array {
>  
>  static int __init test_overflow_size_helpers(void)
>  {
> +	/* Make sure struct_size() can be used in a constant expression. */
> +	u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
>  	struct __test_flex_array *obj;
>  	int count = 0;
>  	int err = 0;
>  	int var;
>  
> +	/* Verify constant expression against runtime version. */
> +	var = 55;
> +	OPTIMIZER_HIDE_VAR(var);
> +	err |= sizeof(ce_array) != struct_size(obj, data, var);
> +
>  #define check_one_size_helper(expected, func, args...)	({	\
>  	bool __failure = false;					\
>  	size_t _r;						\
> -- 
> 2.30.2
> 
