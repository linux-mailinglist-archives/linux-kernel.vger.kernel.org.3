Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4915A5455AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiFIUby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiFIUbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:31:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF092315E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3434EB83079
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D972C34114;
        Thu,  9 Jun 2022 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654806702;
        bh=bnc6QDy2zL5myC/gga6GB6XNfibFDapswj73VFJ+UIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mj793kUfM3FNXSBhquvSUtshW6AZZrZOhtvxtSARO5Vq6pM2XchCEcocr9WgH7U9G
         +WkgXomfe3HMZn1SGIUSD3Qj5eqOfhpk5im2l2WTqvk2p8ki+7Yp8fYq4wev6585eA
         pg5cho2yfu/IMajymQXFCGhYAhtCqXAsED6kUoHy1+4UHzhJbJ8uALJuy6/tUkuOaD
         wDnB/0TdR2lDctTJfP6pTXMPYVa/6DOKhhn24D1m8iJcB20Vh287omplxDOXmg+5OM
         zmytq3gG1/GgTDPUSH46hWkekQX33qLS/2YQTfXE4EQ3EulXhgYjlo5Q3vMS0meFgN
         nQ4LmZlYiYbEQ==
Date:   Thu, 9 Jun 2022 13:31:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] include/uapi/linux/swab.h: move explicit cast outside
 ternary
Message-ID: <YqJYrImC3Bk40H1H@dev-arch.thelio-3990X>
References: <20220608223539.470472-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608223539.470472-1-justinstitt@google.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 03:35:39PM -0700, Justin Stitt wrote:
> From: Justin Stitt <jstitt007@gmail.com>
> 
> A cast inside __builtin_constant_p doesn't do anything since it should
> evaluate as constant at compile time irrespective of this cast. Instead,
> I moved this cast outside the ternary to ensure the return type is as
> expected.
> 
> Additionally, if __HAVE_BUILTIN_BSWAP16__ was not defined then __swab16
> is actually returning an `int` not a `u16` due to integer promotion.
> 
> As Al Viro notes:
> You *can't* get smaller-than-int out of ? :, same as you can't get it
> out of addition, etc.
> 
> This also fixes some clang -Wformat warnings involving default
> argument promotion.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <jstitt007@gmail.com>

Thanks for the patch and sticking with it through all the review!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  diff from v2 -> v3:
>   * re-insert respective (u16, u32, u64) cast to __builtin_bswap as per
>      Nick's suggestion
>   * added note from Al Viro
> 
>  include/uapi/linux/swab.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
> index 7272f85d6d6a..0723a9cce747 100644
> --- a/include/uapi/linux/swab.h
> +++ b/include/uapi/linux/swab.h
> @@ -102,7 +102,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
>  #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>  #else
>  #define __swab16(x)				\
> -	(__builtin_constant_p((__u16)(x)) ?	\
> +	(__u16)(__builtin_constant_p(x) ?	\
>  	___constant_swab16(x) :			\
>  	__fswab16(x))
>  #endif
> @@ -115,7 +115,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
>  #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
>  #else
>  #define __swab32(x)				\
> -	(__builtin_constant_p((__u32)(x)) ?	\
> +	(__u32)(__builtin_constant_p(x) ?	\
>  	___constant_swab32(x) :			\
>  	__fswab32(x))
>  #endif
> @@ -128,7 +128,7 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
>  #define __swab64(x) (__u64)__builtin_bswap64((__u64)(x))
>  #else
>  #define __swab64(x)				\
> -	(__builtin_constant_p((__u64)(x)) ?	\
> +	(__u64)(__builtin_constant_p(x) ?	\
>  	___constant_swab64(x) :			\
>  	__fswab64(x))
>  #endif
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
> 
