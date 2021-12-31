Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C81482538
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhLaQy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:54:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53604 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLaQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:54:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36763B81D1C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371A3C36AE9;
        Fri, 31 Dec 2021 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640969664;
        bh=rvg6wZRVQUU4lpCX5Q8pmgTeUuHLBdlRzgcEDddaL60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tIopv7WjtNwg2I+/VhiCEmWKJA3Tp1CfYoB9KDs2x8I6fLKM/8volT7GuscQVzWs0
         4W609XGbmX/wgGnDbQaEZi78ZWSGGAKnaapOTTOW3B22ltwqmUndOzNxtVXNQaKX8q
         gq3S3GleuaHGqpUVSk8u1fvG9CXNaeb4Piqe7S3oMtRFCrmKSjgdXzLt2NsMG8CrUr
         BanPbFsEiEi7ytq9i7+dL0cU0jv+EME5GaLSECaJm9JmFPfUdmEYyr1CeREoPZkk9B
         9Pmxe0u9r58Cuv2Chi9G4xslNjW+6xAQ14SNUxoCRVzrO4B0kDE2ISiNRE8JDLSI0P
         cab1GSHv+NJ3g==
Date:   Fri, 31 Dec 2021 09:54:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     cgel.zte@gmail.com
Cc:     ndesaulniers@google.com, keescook@chromium.org,
        wang.yong12@zte.com.cn, xu.xin16@zte.com.cn,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] tools: compiler-gcc.h::Keep compatible with
 non-clang compilers.
Message-ID: <Yc81vBwPo/aHMfXB@archlinux-ax161>
References: <20211231100833.590691-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231100833.590691-1-xu.xin16@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 10:08:33AM +0000, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> When HOSTC = gcc (GCC) 4.8.5, there is an error occurring as follows:
> error: Undefined __has_attribute.
> 
> This problem is introduced by commit d0ee23f9d78be ("tools:
> compiler-gcc.h: Guard error attribute use with __has_attribute").

Yes, sorry for breaking this. It has been discussed here with some ideas
for a resolution but I never got any feedback so I never carried it
through, thank you for picking it up.

https://lore.kernel.org/r/c1b1a299-c60d-28a4-07ab-1ecd211d6da9@i-love.sakura.ne.jp/

This patch should probably be sent straight to Linus next time it is
sent, as he directly applied both my commit and the one that it was
fixing. Nick and I do not pick up patches currently although Kees might
be willing to take this one.

> To solve it, this patch is given to keep the comatibility.

                                               ^ compatibility

Might be worth adding "with older GCC versions" at the end of that
sentence.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Co-developed-by: wangyong <wang.yong12@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>  tools/include/linux/compiler-gcc.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
> index 8816f06fc6c7..7da593d3cb91 100644
> --- a/tools/include/linux/compiler-gcc.h
> +++ b/tools/include/linux/compiler-gcc.h
> @@ -16,6 +16,11 @@
>  # define __fallthrough __attribute__ ((fallthrough))
>  #endif
>  
> +
> +#ifndef __has_attribute
> +# define __has_attribute(x) 0  /* Compatibility with non-clang compilers. */

This comment is not really accurate; it implies that clang is the only
one that defines __has_attribute() but GCC 5.x or newer supports
__has_attribute().  A more accurate comment might be:

/* Compatibility with GCC < 5.x */

> +#endif
> +
>  #if __has_attribute(__error__)
>  # define __compiletime_error(message) __attribute__((error(message)))
>  #endif
> -- 
> 2.25.1
> 
