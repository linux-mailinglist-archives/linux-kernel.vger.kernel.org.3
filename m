Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1E5A85D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiHaSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiHaSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:37:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825A13E00
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:35:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r22so14227807pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BF6HZWh0lIO6JP7Iahnyp/DPpNq7NYWD0O6mpa00wm0=;
        b=WMT7IblMUP6IbINyxYOTTk3/5C/SsZwEz/PStR1GnxNGEiTOBTx0H0bcoX7mtTZOFs
         vW/nmQVoxpVJGmhXtPihBudI7bs7hFhQ7NNkMHCNvfgh40a1jYEzzES0ocdqAzWF06W6
         ereG8wftpqUi6FJJpbNpjoGm7QbHY6Odaz8Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BF6HZWh0lIO6JP7Iahnyp/DPpNq7NYWD0O6mpa00wm0=;
        b=lRx9iC+wbj0+VTPqhleogjFS9IrwXqTU3Hi9v96jHmwXTaGHuI87e9xNzO12E3QN9k
         e4MjNOWiK8cnbcNDpqfTwbdKJwFgO7+cO1fjcrb0lPfZ8Sdonrl+iIN8+SIlaFx1h6N6
         2U3EIbQU+BYq6GwenO6883oclnqIahYJn5jvf3B7Bc+JANObpjV7KN+tz6HfhnWqsbfq
         v1CtlkqCEBqM+C3Tz0KiFG3IXI4CIzPTACXiMuPBfub6mv5cqWkz7wEGUaKH/x1x5lq1
         CprZB16Oll37p2UBb8cwQD6Xi13k+82TNuJJWMzvQUpPhqGYy/q20i0OXFIPdZM7xiJM
         ngdA==
X-Gm-Message-State: ACgBeo2pDvTkAWu84Clljb9xK9Ao5cc7p+jFbGv9BITN8EYbVPusbs8b
        9sm6FnF1YzeZzOht4BleGJtzwA==
X-Google-Smtp-Source: AA6agR7fo6VejIBMks/yQH9zBQhqvzOQ/jVgBeELe620QEE3MIqxdQctdFNdrpDaTK8wEGiOq4adhA==
X-Received: by 2002:a05:6a00:a90:b0:530:2f3c:da43 with SMTP id b16-20020a056a000a9000b005302f3cda43mr27374922pfl.50.1661970899675;
        Wed, 31 Aug 2022 11:34:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bm26-20020a656e9a000000b0042bd73400b6sm3642659pgb.87.2022.08.31.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:34:59 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:34:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 1/3] fortify: use __builtin_dynamic_object_size in
 __compiletime_strlen
Message-ID: <202208311132.27EE59B@keescook>
References: <20220830205309.312864-1-ndesaulniers@google.com>
 <20220830205309.312864-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830205309.312864-2-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:53:07PM -0700, Nick Desaulniers wrote:
> With CONFIG_FORTIFY=y and CONFIG_UBSAN_LOCAL_BOUNDS=y enabled, we
> observe a runtime panic while running Android's Compatibility Test
> Suite's (CTS) android.hardware.input.cts.tests.  This is stemming from a
> strlen() call in hidinput_allocate().
> 
> __compiletime_strlen is implemented in terms of __builtin_object_size(),
> then does an array access to check for NUL-termination. A quirk of
> __builtin_object_size() is that for strings whose values are runtime
> dependent, __builtin_object_size(str, 1 or 0) returns the maximum size
> of possible values when those sizes are determinable at compile time.
> Example:
> 
>   static const char *v = "FOO BAR";
>   static const char *y = "FOO BA";
>   unsigned long x (int z) {
>       // Returns 8, which is:
>       // max(__builtin_object_size(v, 1), __builtin_object_size(y, 1))
>       return __builtin_object_size(z ? v : y, 1);
>   }
> 
> So when FORTIFY is enabled, the current implementation of
> __compiletime_strlen will try to access beyond the end of y at runtime
> using the size of v. Mixed with UBSAN_LOCAL_BOUNDS we get a fault.
> 
> hidinput_allocate() has a local C string whose value is control flow
> dependent on a switch statement, so __builtin_object_size(str, 1)
> evaluates to the maximum string length, making all other cases fault on
> the last character check. hidinput_allocate() could be cleaned up to
> avoid runtime calls to strlen() since the local variable can only have
> literal values, so there's no benefit to trying to fortify the strlen
> call site there.
> 
> Add a Kconfig check for __builtin_dynamic_object_size(), then use that
> when available (gcc-12+, all supported versions of clang) which avoids
> this surprising behavior.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/fortify-string.h | 8 +++++++-
>  init/Kconfig                   | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 3b401fa0f374..c5adad596a3f 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -14,11 +14,17 @@ void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("
>  void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
>  void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
>  
> +#ifdef CONFIG_CC_HAS_BUILTIN_DYNAMIC_OBJECT_SIZE
> +#define __object_size __builtin_dynamic_object_size
> +#else
> +#define __object_size __builtin_object_size
> +#endif

Instead of a Kconfig, how about just:

#if __has_builtin(__builtin_dynamic_object_size)
# define __object_size __builtin_dynamic_object_size
#else
# define __object_size __builtin_object_size
#endif

?

> +
>  #define __compiletime_strlen(p)					\
>  ({								\
>  	unsigned char *__p = (unsigned char *)(p);		\
>  	size_t __ret = (size_t)-1;				\
> -	size_t __p_size = __builtin_object_size(p, 1);		\
> +	size_t __p_size = __object_size(p, 1);			\
>  	if (__p_size != (size_t)-1) {				\
>  		size_t __p_len = __p_size - 1;			\
>  		if (__builtin_constant_p(__p[__p_len]) &&	\

The fact that __builtin_object_size() will actually span control flow,
and produce a size-inclusive result on the possible inputs is ...
surprising and potentially quite problematic. But I'm satisfied that
bdos appears to fix it here (since the "compiletime"ness will still get
filtered by the __builtin_constant_p() check).

-Kees

-- 
Kees Cook
