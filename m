Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950CF4864B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239139AbiAFM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:59:32 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38430 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiAFM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:59:31 -0500
Received: by mail-wr1-f44.google.com with SMTP id a5so650579wrh.5;
        Thu, 06 Jan 2022 04:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EzxZ5tg+j3WsdhfN+n9HGSOnyhaP0qZQCgrMxlRYEA=;
        b=yvPsWqII91aCCV3c04KRB0UD/KXkJqwGUN+f0I+97+b3e3TF/PYyCfG/qV6jB70UsX
         OkoIqJuo+5lmkrb0E6TceyNYpSAfPl0YVIWsyCfFHAmiwePActYTMWmAl+tR0e8KtOh9
         2TkLnCEz/x1mygZtmgfxsQxF3gL6vqdiDtFudo24yzA2L6Lf1b1oEZUF7BeYgviaJVnL
         2xPV4rEbaTNYNGcxMpaBCn7PregA3uf5BqKv2goQnljwepKbfdkc0/yy8Izc0tiQfGgV
         fxrH7m4J8IqeSHDcaD6+LBc8LYZLlxc4Rv2n6b6sw9i25tqw6eCDvq2K/KjdNGAqM7yW
         hG0A==
X-Gm-Message-State: AOAM530BT/j9fjW8C3gA8f3vg+ISWvJqQ7m9PYRLA9DToAL+dalhTswC
        91gi5dqx0zjsaIyHJUuSvf8=
X-Google-Smtp-Source: ABdhPJww1ZxHoBF5uKKq5Iv1Knv/4S0Ex+eLmkTr79aWll30oEYQnlQdP6Qg7G0SG0Vj6aGjYp4blg==
X-Received: by 2002:adf:eb88:: with SMTP id t8mr28004359wrn.291.1641473970226;
        Thu, 06 Jan 2022 04:59:30 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q8sm2007089wrx.59.2022.01.06.04.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 04:59:29 -0800 (PST)
Date:   Thu, 6 Jan 2022 12:59:28 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] init/Kconfig: Specify the interpreter for rust-version.sh
Message-ID: <20220106125928.bdq76oc22z65zlwk@liuwe-devbox-debian-v2>
References: <20220106123357.16220-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106123357.16220-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 12:33:57PM +0000, SeongJae Park wrote:
> Some common tools like 'diff' don't support permissions of the files.
> Due to that, 'rust-version.sh' in some trees including '-mm' result in
> having no execution permission, and therefore build fails like below:
> 
>     $ make O=../linux.out/ olddefconfig
>     make[1]: Entering directory 'linux.out'
>       GEN     Makefile
>     sh: 1: linux/scripts/rust-version.sh: Permission denied
>     init/Kconfig:71: syntax error
>     init/Kconfig:70: invalid statement
>     linux/scripts/kconfig/Makefile:77: recipe for target 'olddefconfig' failed
>     make[2]: *** [olddefconfig] Error 1
>     linux/Makefile:666: recipe for target 'olddefconfig' failed
>     make[1]: *** [olddefconfig] Error 2
>     make[1]: Leaving directory 'linux.out'
>     Makefile:226: recipe for target '__sub-make' failed
>     make: *** [__sub-make] Error 2
> 
> It's not a big deal, but not so fun.  This commit fixes the issue by
> specifying the interpreter for 'rust-version.sh' in the Kconfig file.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index cd23faa163d1..97ab35692d46 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -67,7 +67,7 @@ config HAS_RUST
>  config RUSTC_VERSION
>  	depends on HAS_RUST
>  	int
> -	default $(shell,$(srctree)/scripts/rust-version.sh $(RUSTC))
> +	default $(shell,/bin/sh $(srctree)/scripts/rust-version.sh $(RUSTC))
>  
>  config CC_CAN_LINK
>  	bool
> -- 
> 2.17.1
> 
