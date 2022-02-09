Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CAA4AE7AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiBIDDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348316AbiBIC4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:56:42 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06623C0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 18:56:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so1848883pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 18:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ekiKfPA3vcRw1iV2FBIhE5a6arm3Tvrg5Me+PHh03cY=;
        b=Fb823xD+OPg8oUvrhV8BGzbq8e3RSEY2XutyZDs8PJpxhlr/4Qe0BElUTC89PgQMkY
         623zf2SdaEU88tYvk6ZrlTtG5zAUBr8RwCTFadgKtdeHhLK5R4Km7lmGF6wVnHZhlxjD
         xvAvfAF44IjSf/NEHZaRVthmZ67r/0HZRYOvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ekiKfPA3vcRw1iV2FBIhE5a6arm3Tvrg5Me+PHh03cY=;
        b=JSBt19Io/PXVv1tPtVuTG6A8aapSkc7mXfOgxL2FpqqrZ4a/zWvSd9FGwPgpaCVZuI
         8Wu2F00nKbARuZYxTsSeIETHxIZh+B9VbdfOhFq9fSFsbApfnkHE79YtLTcZM3UXaLMI
         8fp6KdP5JTtQsWgxmwQ+XIj22ekuD4xaTNNBabYhnC1FoZItSE0AFojo8SWM0vGrN+BR
         +6baaeQ4rkL0SHQhYBkkvzxQnQ6vi1vAl7vQkm2lOdY65CVu2fKkeV0Vd4K+6qieLHVh
         lK6FJe17qRXCliKmLqpPg8BsHT3MC7PanVzQ8Kpt7G37IBAJflG2NYTua8+7LO8N167T
         Cn0Q==
X-Gm-Message-State: AOAM533gcJAoaw7fQxrq9snjOpcituf2JD4zce3Bfva9EIItJV4WghCw
        DLqyIsfdNioOX4wdCbQNNNcKhNeq45XRkw==
X-Google-Smtp-Source: ABdhPJxDsFh8wX6St5F2jxMHqUnUysoQdi+sdBLdlcH97dRiKFzIyX4kThXNv882hmgMXCoYaAKnhA==
X-Received: by 2002:a65:484b:: with SMTP id i11mr289858pgs.40.1644375401474;
        Tue, 08 Feb 2022 18:56:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z1sm17167545pfh.137.2022.02.08.18.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:56:41 -0800 (PST)
Date:   Tue, 8 Feb 2022 18:56:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 3/6] x86/cpu: Remove CONFIG_X86_SMAP and "nosmap"
Message-ID: <202202081854.90ABA52F@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-4-bp@alien8.de>
 <202202071405.FB72C07@keescook>
 <YgKHDBvQFVJhTBzN@zn.tnic>
 <YgLaERuGcefANHNi@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgLaERuGcefANHNi@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 10:01:05PM +0100, Borislav Petkov wrote:
> On Tue, Feb 08, 2022 at 04:06:52PM +0100, Borislav Petkov wrote:
> > Hmm, I think you're right.
> > 
> > Mr. Z?
> 
> He says yes.
> 
> Ok, that was a good catch, thanks!
> 
> This chunk looks now like this - I'll send a new version later.
> 
> ---
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a4b89b757287..404ea669ecca 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -233,7 +233,7 @@ objtool_args =								\
>  	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
>  	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
>  	$(if $(CONFIG_RETPOLINE), --retpoline)				\
> -	$(if $(CONFIG_X86_SMAP), --uaccess)				\
> +	--uaccess							\
>  	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
>  	$(if $(CONFIG_SLS), --sls)
>  
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 666f7bbc13eb..0fcba46fc10f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -106,7 +106,7 @@ modpost_link()
>  objtool_link()
>  {
>  	local objtoolcmd;
> -	local objtoolopt;
> +	local objtoolopt="--uaccess"
>  
>  	if is_enabled CONFIG_LTO_CLANG && is_enabled CONFIG_STACK_VALIDATION; then
>  		# Don't perform vmlinux validation unless explicitly requested,
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

Cool; yeah, that's kind of what I was expecting. I have a knee-jerk "I
don't want to touch this again later" reaction to seeing it always
applied instead of gated by CONFIG_X86 or something, but then, I doubt
that'll be hard to change when/if objtool becomes multi-architecture.

Consider the update as:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
