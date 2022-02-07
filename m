Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774BD4ACBD3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiBGWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiBGWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:07:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D9C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:07:29 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so380189pja.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZHETUekZPTtiHL5dMF4kZArX4bJsrtlJFkqOqsn+FVY=;
        b=oKWNQblaJu1yOsLu4STWKuV7RV2fT2/zNxeMtrOCPfNj1cn3ZXsol7tMwK9w46Q18C
         cmC1B2ov7GsZSNsvnEx97u8JPMffXZuo7C8GWBN+I7Bl+aeS9uXsoERTPw3sjlbjBAQH
         MnBYFj987d1rgQirvwEbq4bIs/hXaCN+c5Jwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZHETUekZPTtiHL5dMF4kZArX4bJsrtlJFkqOqsn+FVY=;
        b=RxC5ek1xq1ckju6GIMPEaM3gSVtlpZSa0EcYU8cTB585UAqMwYXcu59xMrQ7k1cdas
         UXnB/t6Uyji0h2O6AUhYSmRzj4CKV6KHHBVWZVhDKOzRcqn6XLQmFEFA2RjfrhIn4xFx
         2Ohz8JaOa13A+Vjovd6ceEjPeGijO/GnDcq+S3gR7D4z4E8Jth7uKOrTGgOrhoRpkF1u
         Matb8DOZ8aUTbXlRAEEfBxws+gCzFW1n1wpPdeiOL1eKNZnhJrvDt09+FdRbU56jtC5W
         WaDYYqZK3L0ujqSrKyHiILEmehYtLnzkBpKhERNjXglzD5B+XmR+1D+S0Wqq4lE3YYqG
         Q0uw==
X-Gm-Message-State: AOAM533fGNvJEGiI1voq54DYr0Yk7UuXZpPHB0V3Kk8GM/19M9NktkpC
        RKNIrrkO+YWDk7KqM0MV1l66lg==
X-Google-Smtp-Source: ABdhPJzjIAsDyYY5YOWIeBIgXI9qB9X68AvdHC603QccGBlLr5nREvFhNoZFmxCBwu6mtYnRcCumlg==
X-Received: by 2002:a17:902:f1cb:: with SMTP id e11mr1683411plc.48.1644271648558;
        Mon, 07 Feb 2022 14:07:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s11sm13819879pfu.58.2022.02.07.14.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:07:28 -0800 (PST)
Date:   Mon, 7 Feb 2022 14:07:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 3/6] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Message-ID: <202202071405.FB72C07@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127115626.14179-4-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:56:23PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Those were added as part of the SMAP enablement but SMAP is currently
> an integral part of kernel proper and there's no need to disable it
> anymore.
> 
> Rip out that functionality.
> 
> If still needed - clearcpuid=smap.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  Documentation/x86/cpuinfo.rst                 |  5 ++--
>  arch/x86/Kconfig                              | 11 ---------
>  arch/x86/include/asm/disabled-features.h      |  8 +------
>  arch/x86/include/asm/smap.h                   | 24 -------------------
>  arch/x86/kernel/cpu/common.c                  | 15 +-----------
>  scripts/Makefile.build                        |  1 -
>  scripts/link-vmlinux.sh                       |  3 ---
>  .../arch/x86/include/asm/disabled-features.h  |  8 +------
>  9 files changed, 6 insertions(+), 71 deletions(-)
> [...]
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a4b89b757287..9b37902607ed 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -233,7 +233,6 @@ objtool_args =								\
>  	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
>  	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
>  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
> -	$(if $(CONFIG_X86_SMAP), --uaccess)				\
>  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
>  	$(if $(CONFIG_SLS), --sls)
>  
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 666f7bbc13eb..8547aaa1a630 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -140,9 +140,6 @@ objtool_link()
>  		if is_enabled CONFIG_RETPOLINE; then
>  			objtoolopt="${objtoolopt} --retpoline"
>  		fi
> -		if is_enabled CONFIG_X86_SMAP; then
> -			objtoolopt="${objtoolopt} --uaccess"
> -		fi
>  		if is_enabled CONFIG_SLS; then
>  			objtoolopt="${objtoolopt} --sls"
>  		fi

I was expecting to see --uaccess unconditionally added to objtool
arguments. I think that needs to happen?

-- 
Kees Cook
