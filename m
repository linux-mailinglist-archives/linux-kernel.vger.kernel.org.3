Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42474B1449
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbiBJRdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:33:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiBJRdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:33:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76416E70
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:33:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso6307501pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s1JxkA/6RqlFkNqo+B0vHqwqIwt69OTcdFi1JrclJy0=;
        b=TqhyI4o6satsvyQuG1Zc8r8TIgibFdDLQ5hxbAyadJyXzeh0LOv6zV16eM4zZQ9/cF
         yabB+fhKpy02YqtuMOCe3jkJ17EHzCX8dtLlRdSY01dOCd8MjSROPnOsDl138Pe7J1W0
         w+JhckfKaWP4VyRyG64FrJwbnR3o2OWbIQbxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s1JxkA/6RqlFkNqo+B0vHqwqIwt69OTcdFi1JrclJy0=;
        b=vvvvgyvXxJaZV0nBXKy+gVBxQBrxWIXNfyF/gjEIpTltLHXaB0kHUiWic8fn3PnkPF
         8cUh4yU9eZ75Wk+L50lkaR09yE6MlLLFJKt4wtRbXqIaZ0yHWGEIL5WH3zRlIIpGUf2V
         vuOZzXUgDEXMetgNflpxCeKi8LeYTCtr48Nq3KuAH1l2gEkZMASq8FgZaR0aJPg4U09o
         /Kys/Uw7L3TfYsUKzOQsEhL1qrFtZdi8wL428PuLHKIQycBinFPR+e/LqHxU0rQqBw6W
         JyoGXR60o0Y0k6G00N14w+iQjTGfSyG4t00xr3qFH3Zph7s+iSWu6Dka1NIWNVZTgd+X
         +9mA==
X-Gm-Message-State: AOAM5319E76IAUXneIydL3owwHaAe/vm+XnGL/+VHRds7shwT4zqUExg
        +4QuF/ZCU6nmQdVw4No8JsVTHg==
X-Google-Smtp-Source: ABdhPJxdXxPIIlNt4XefXLudxSANNJKlBpKyeJfhr0MLHFEsOMl0aq9P/WLopDOxLW7qwRKHEL9hcw==
X-Received: by 2002:a17:902:da8c:: with SMTP id j12mr6381579plx.17.1644514394970;
        Thu, 10 Feb 2022 09:33:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id kb18sm3755296pjb.30.2022.02.10.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:33:14 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:33:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: move KEXEC_SIG_FORCE from arch/x86 to arch
Message-ID: <202202100931.F62DC5C885@keescook>
References: <20220210131648.16276-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210131648.16276-1-msuchanek@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:16:48PM +0100, Michal Suchanek wrote:
> There is nothing x86-specific about KEXEC_SIG_FORCE
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  arch/Kconfig     | 7 +++++++
>  arch/x86/Kconfig | 7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 678a80713b21..dc2446f01ac1 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -24,6 +24,13 @@ config KEXEC_ELF
>  config HAVE_IMA_KEXEC
>  	bool
>  
> +config KEXEC_SIG_FORCE
> +	bool "Require a valid signature in kexec_file_load() syscall"
> +	depends on KEXEC_SIG
> +	help
> +	  This option makes kernel signature verification mandatory for
> +	  the kexec_file_load() syscall.
> +
>  config SET_FS
>  	bool
>  
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..3ea648dad6b6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2032,13 +2032,6 @@ config KEXEC_SIG
>  	  verification for the corresponding kernel image type being
>  	  loaded in order for this to work.
>  
> -config KEXEC_SIG_FORCE
> -	bool "Require a valid signature in kexec_file_load() syscall"
> -	depends on KEXEC_SIG
> -	help
> -	  This option makes kernel signature verification mandatory for
> -	  the kexec_file_load() syscall.
> -

This means it is no longer folded under KEXEC_SIG in menuconfig,
which makes it harder to find. I would prefer seeing KEXEC_SIG (and
KEXEC_SIG_FORCE) moved out of the per-arch Kconfig files into a common
location, and then arch Kconfig can add something like:

	select ARCH_SUPPORTS_KEXEC

>  config KEXEC_BZIMAGE_VERIFY_SIG
>  	bool "Enable bzImage signature verification support"
>  	depends on KEXEC_SIG
> -- 
> 2.31.1
> 

-- 
Kees Cook
