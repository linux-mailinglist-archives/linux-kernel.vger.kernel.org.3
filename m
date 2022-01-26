Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D411549CFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbiAZQiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:38:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58260 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243175AbiAZQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:38:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CE061A39
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F412C340E3;
        Wed, 26 Jan 2022 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643215087;
        bh=ROjn4VlNVmb1WH5kKkS/AXgsukGjTMCpkKDS3wbqDnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ki+o/+CCgBz5rbYpht6JTrR9xg5fYRtJgBwwRkOLWH9u83mhDhG85ZvFmn/1twYTo
         rfEpn8MZUF/5+avOkT+7wwd6xMirER04cFu/xLSUirRiVPA88dpQNrw8MNe3vQhENL
         3XRI0Htpeoya95PtfiQzckptQCa2CwkYPsR1Br9n0d8yOtV+aDf2g0blwSSxtbeoPQ
         /IO346J+Zu9cUb163FeMppOig/v5xMonYGOU7x3HkLtHZtLaYagH6tFiZyNbebytCD
         lETlsYJMeY6mygtn7Lru+OPxySKq0B4O25QYPtWhHsuDZfu3HKlADSsdJ2qjI8eD+Q
         PQlo+JGqsLnlA==
Date:   Wed, 26 Jan 2022 09:38:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v3 1/3] string: Make stpcpy() possible to use
Message-ID: <YfF46oYCaelKU5qU@dev-arch.archlinux-ax161>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 04:19:15PM +0200, Andy Shevchenko wrote:
> It is a good rule to avoid submitting code without users.

While I agree with the sentiment in the general case, I don't think that
it applies in this case and this comment should be dropped. The message
of the commit this fixes and the comment right above the declaration
both make it pretty obvious why this interface was added with no in-tree
users and why the declaration was placed right above the definition.

> Currently the stpcpy() is unusable due to missed declaration.
> Any attempts to use it will bring something like:
> 
>   error: implicit declaration of function ‘stpcpy’ [-Werror=implicit-function-declaration]
> 
> Move declaration to the header and guard it as other string functions.
> 
> Fixes: 1e1b6d63d634 ("lib/string.c: implement stpcpy")
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Regardless, the commit itself seems fine from a technical standpoint. I
won't comment on whether or not this interface should be opened up.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> v3: new patch to fix reported issue
>  include/linux/string.h | 3 +++
>  lib/string.c           | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b6572aeca2f5..b1aeb3475396 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -31,6 +31,9 @@ size_t strlcpy(char *, const char *, size_t);
>  #ifndef __HAVE_ARCH_STRSCPY
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
> +#ifndef __HAVE_ARCH_STPCPY
> +char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
> +#endif
>  
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> diff --git a/lib/string.c b/lib/string.c
> index 485777c9da83..4ecb8ec1fdd1 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -233,6 +233,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
>  EXPORT_SYMBOL(strscpy);
>  #endif
>  
> +#ifndef __HAVE_ARCH_STPCPY
>  /**
>   * stpcpy - copy a string from src to dest returning a pointer to the new end
>   *          of dest, including src's %NUL-terminator. May overrun dest.
> @@ -248,7 +249,6 @@ EXPORT_SYMBOL(strscpy);
>   * not recommended for usage. Instead, its definition is provided in case
>   * the compiler lowers other libcalls to stpcpy.
>   */
> -char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
>  char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
>  {
>  	while ((*dest++ = *src++) != '\0')
> @@ -256,6 +256,7 @@ char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
>  	return --dest;
>  }
>  EXPORT_SYMBOL(stpcpy);
> +#endif
>  
>  #ifndef __HAVE_ARCH_STRCAT
>  /**
> -- 
> 2.34.1
> 
> 
