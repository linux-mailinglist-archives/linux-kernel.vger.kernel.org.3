Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFF4A7538
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiBBQB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbiBBQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:01:54 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60044C06173D;
        Wed,  2 Feb 2022 08:01:54 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso19870103ott.7;
        Wed, 02 Feb 2022 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3g3d/0nNM/m7x4mgsz4tjhBAFiZS3Vbf1uUerpVJ9lQ=;
        b=HhEE3lXB3iuVMezioKIcOChf5uZ2cD2tvUqJN6GkjOCS3ozVUiatdlZdgtgWNMOFfF
         2aURaeU2R0RcuAg4rZcpV9kYDv+/9WKwld5EmmBQ6yioLNzOE8EuwMBhWIblFWY1WP8S
         rJQ9jzlFspluGUbx44Ly+y1rSiwE40HqYsFzc3nb3T9etw8krT1xtVVwOC5u9k0utLcR
         X6m7XAfhHJFv9iEN1Pkgsc0Nvl1GJomgBYxG0ULxrS83xo8xHhCIOE8ZA0sPl7w9uJux
         lTcjclx1IpfsCTqPsPCDtsHXiiwG+HH26wdaCA3H0KuhXpas1yW5AR1tLt+/OfOLDMCW
         m1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3g3d/0nNM/m7x4mgsz4tjhBAFiZS3Vbf1uUerpVJ9lQ=;
        b=OUItOVDmNE6rsSXIZfhraM4x6qHjn1REpjXX6cswodNKSSX/fSzs5SWDBUyNqoJqR2
         5FEGlWbypmbttRcTD1y8V0EQOgPxj700QnqeSs54TFe69gDPHL4+NTz9v9pyds/IdToY
         MoiWvfTwcyc/Lt/kU0ytMuKgt+BEOjCphHhUNde+wQhcmaZ3Hl4Zl45FKC0r6T+6DNCz
         s2rjZsP/CWSHb3S12JI/fpihZSYotgMkQmtuMiiBFoG1fVnHTA+U4hXnPgL+N/R1hksh
         cwwS8CVzirUtk9HHRyZosCe7SZ28nHR/BdmSCYgUu9fA7Fpa3zCn9+KVl/5x+eQVpzZ9
         RfbQ==
X-Gm-Message-State: AOAM530W2kVLdDiCK7dpigEAVWNVVvDT4T8yb66BXed+kQRhtkxe8psd
        Zf9v+UVIqljw6uibRdWHnWQ=
X-Google-Smtp-Source: ABdhPJxTHKS5tENSR0d5oDDjMuzEHVOaTuUWMM5EdaXwgaSD2f8PtvvrrvRd6VGXmoGdjH4Lq/nLLA==
X-Received: by 2002:a9d:72d6:: with SMTP id d22mr16613935otk.237.1643817712222;
        Wed, 02 Feb 2022 08:01:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm15990946oto.53.2022.02.02.08.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 08:01:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Feb 2022 08:01:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <20220202160149.GA2322037@roeck-us.net>
References: <20220130183653.491292-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130183653.491292-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:
> Add a simple test for strlen() functionality, including using it as a
> constant expression.
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'll be taking this as part of my Clang FORTIFY_SOURCE series.
> ---
>  lib/test_string.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/lib/test_string.c b/lib/test_string.c
> index 9dfd6f52de92..59994f552c48 100644
> --- a/lib/test_string.c
> +++ b/lib/test_string.c
> @@ -179,6 +179,38 @@ static __init int strnchr_selftest(void)
>  	return 0;
>  }
>  
> +/*
> + * Unlike many other string functions, strlen() can be used in
> + * static initializers when string lengths are known at compile
> + * time. (i.e. Under these conditions, strlen() is a constant
> + * expression.) Make sure it can be used this way.
> + */
> +static const int strlen_ce = strlen("tada, a constant expression");
> +

This results in:

lib/test_string.c:188:30: error: initializer element is not constant
  188 | static const int strlen_ce = strlen("tada, a constant expression");

for several of my tests. I don't think you can mandate that a compiler
implements this.

Guenter

> +static __init int strlen_selftest(void)
> +{
> +	/* String length ruler:         123456789012345 */
> +	static const char normal[]   = "I am normal";
> +	static const char *ptr       = "where do I go?";
> +	static const char trailing[] = "hidden NULLs\0\0\0";
> +	static const char leading[]  = "\0\0hidden text";
> +
> +	if (strlen(normal) != 11)
> +		return 0x100001;
> +	if (strlen(ptr++) != 14)
> +		return 0x100002;
> +	if (strlen(ptr++) != 13)
> +		return 0x100003;
> +	if (strlen(trailing) != 12)
> +		return 0x100004;
> +	if (strlen(leading) != 0)
> +		return 0x100005;
> +	if (strlen_ce != 27)
> +		return 0x100006;
> +
> +	return 0;
> +}
> +
>  static __exit void string_selftest_remove(void)
>  {
>  }
> @@ -212,6 +244,11 @@ static __init int string_selftest_init(void)
>  	if (subtest)
>  		goto fail;
>  
> +	test = 5;
> +	subtest = strlen_selftest();
> +	if (subtest)
> +		goto fail;
> +
>  	pr_info("String selftests succeeded\n");
>  	return 0;
>  fail:
> -- 
> 2.30.2
> 
