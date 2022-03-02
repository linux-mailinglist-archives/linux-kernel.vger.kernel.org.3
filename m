Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461A54CA512
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiCBMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbiCBMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:44:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F58F9A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:43:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n14so2591491wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JEEYQR28aCloRRLqefUizpnHK6W5GlhdIkcq9mPHcXs=;
        b=k2XRyMYJYkEP6XEKB7cdLJ190JESykZzXQvhU7bLNl2lsG+FShKBlnpYNjnFRV5uIM
         ybmlj5Mq94zokFwdLPnfSKkuLZH0kHgNTkvcPeQI2Fa2CBS5MTCIrmCBe0+Fsiik3pQ3
         3etb05nh4EnOywFVJhKPKLLnbV7GzJR8rb4KoDUjj0H6EvZ14j4ZVLwpHMT7CNw4uEDA
         hy5VOljLrASupWEybrn6diB65BXkrQ3OcKTfLN938fTHNP9HwvM4V92lx20H0xChCAuV
         Sq7cldj2nTylq6SJGiiXNb84qpcbAM5Oqr1vxdPSzQ4reX7hdqLRBsK1eec0bqE3pnbo
         rrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JEEYQR28aCloRRLqefUizpnHK6W5GlhdIkcq9mPHcXs=;
        b=dqjYtYLJSocIt1d4IYXh/xKIOhUmI24K8Uu5gl4Wc4BQwOEBIVjG2EIpzIDFelTUOj
         eqgfDfUNGRRbvTyZMvGtUWpFMDvjesGV5qtdsQzz99geYYDLrlNArsAs0RvOPnPv95qJ
         38XmtE56xO2u3SexOVyVN5TGwW8RdiujnL+iZUjdXGD3As9FwkcEYrfyedcKb7OHDkuH
         b8mRXTuU//b5ylD8ca9B2wBAi5T2i6ppy9uQkdwtPeISJJxZcax0NJNYfN+CLfb7y1F1
         1xcayI5oygCLN8wf/RuqNs8g6qSIK3sugc4UB8wfdsJqPlcuAW6WLgjTSNwtqQBT5AtW
         5iEg==
X-Gm-Message-State: AOAM531HO+sUi5kjKJva7phxq5JNTBUf8vx5oKvAIy6nAq/8mmQhvCBR
        cFMVc7nchZ7kYTiwPkY+ArY=
X-Google-Smtp-Source: ABdhPJzJITa4Aj10n/oqA1Bdkc7ezGPyxiKtq2abOmF3TF9WdCXqj7TEUdMluh8w4PtoRaW5+0dktw==
X-Received: by 2002:a05:6000:188b:b0:1f0:46f4:a494 with SMTP id a11-20020a056000188b00b001f046f4a494mr967528wri.259.1646225018457;
        Wed, 02 Mar 2022 04:43:38 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id e4-20020a05600c218400b003818133ab4dsm5412044wme.14.2022.03.02.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:43:38 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:43:35 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: return_address: disable again for
 CONFIG_ARM_UNWIND=y
Message-ID: <Yh9mdzA9R8jFJxO7@Red>
References: <20220302113201.1864406-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302113201.1864406-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 02, 2022 at 12:32:01PM +0100, Ard Biesheuvel a écrit :
> Commit 41918ec82eb6 ("ARM: ftrace: enable the graph tracer with the EABI
> unwinder") removed the dummy version of return_address() that was
> provided for the CONFIG_ARM_UNWIND=y case, on the assumption that the
> removal of the kernel_text_address() call from unwind_frame() in the
> preceding patch made it safe to do so.
> 
> However, this turns out not to be the case: Corentin reports warnings
> about suspicious RCU usage and other strange behavior that seems to
> originate in the stack unwinding that occurs in return_address().
> 
> Given that the function graph tracer (which is what these changes were
> enabling for CONFIG_ARM_UNWIND=y builds) does not appear to care about
> this distinction, let's revert return_address() to the old state.
> 
> Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
> Fixes: 41918ec82eb6 ("ARM: ftrace: enable the graph tracer with the EABI unwinder")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm/include/asm/ftrace.h | 18 ++++++++++++++++++
>  arch/arm/kernel/Makefile      |  5 ++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 5358aad67831..7e9251ca29fe 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -35,8 +35,26 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  
>  #ifndef __ASSEMBLY__
>  
> +#if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
> +/*
> + * return_address uses walk_stackframe to do it's work.  If both
> + * CONFIG_FRAME_POINTER=y and CONFIG_ARM_UNWIND=y walk_stackframe uses unwind
> + * information.  For this to work in the function tracer many functions would
> + * have to be marked with __notrace.  So for now just depend on
> + * !CONFIG_ARM_UNWIND.
> + */
> +
>  void *return_address(unsigned int);
>  
> +#else
> +
> +static inline void *return_address(unsigned int level)
> +{
> +       return NULL;
> +}
> +
> +#endif
> +
>  #define ftrace_return_address(n) return_address(n)
>  
>  #define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 5cebb8d5a1d6..56511856ff9d 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -25,7 +25,10 @@ obj-y		:= elf.o entry-common.o irq.o opcodes.o \
>  KASAN_SANITIZE_stacktrace.o := n
>  KASAN_SANITIZE_traps.o := n
>  
> -obj-y				+= return_address.o
> +ifneq ($(CONFIG_ARM_UNWIND),y)
> +obj-$(CONFIG_FRAME_POINTER)	+= return_address.o
> +endif
> +
>  obj-$(CONFIG_ATAGS)		+= atags_parse.o
>  obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
>  obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += atags_compat.o
> -- 
> 2.30.2
> 

This patch remove the RCU warning and the boot is now clean.

Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks!
