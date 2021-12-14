Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243947480F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhLNQ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbhLNQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:29:26 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152BEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:26 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id q16so17714240pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UUeDg3UbpK4Lk35DpDi+VxMMtiqCVAzMEDO0lgDAodA=;
        b=23ODNl+wM18aXgMSOm5njgveUa5CPCbR4uXfDKVl1dvvNY1fnEGi0hpEL4h37pWPQY
         youwEY8axQ+mS7bu/2Zjm9pEJ7dMWpR2uxp+Y+cqmZ8XNmuBXuAp9uWT19lkr86RsWqu
         pX8dOKjAiiuAjt/okoat/j9KpyTyOASzmy3C28wjjof16XzDgXkJuErZsPNLWBVoTwRN
         A7mJAdUoLO0D8GWeD69IWxUA7uiIt6ZZe9Hot8/YWqjk1WoyXItUpsZ4PSJhhG3U/fHL
         1lSTB5WcGw7sJgS464udCNGBMhTXPFoJs5p8KWr4xAonEUNoG9Ec85ENulYEsmEx24Mn
         qbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UUeDg3UbpK4Lk35DpDi+VxMMtiqCVAzMEDO0lgDAodA=;
        b=3ZthRdAZyJ37ztCDgmisDET9mIHU5ckrMqZYBf6Lq79Sh+eGBmA+b7Bpes2D0zOVSg
         ykEh7hyKfvnk2KqgOS/jk97+xNhyCIgHVDScih1ypQ0495ijSwMQWW26Vkn1dHLtOaax
         wIzB/ZHrfOyTfLt6atEMik6lT8NXSaPNbirwiefi3864vyrAWyXvYTFZww2+TnDJFDsc
         IlhBlBHVmi4S4owwrLot9WFQNaVjuytWDvYwHezBXeFMK/SUnhJVU5qzuFVgn6PfGKcP
         9m6MbQ4mJIOD70f+LE6REtLuueXcU49fAI2Mg9DLdstbIXT3cNTJLOVhU/uxsfSuNvhv
         DOTw==
X-Gm-Message-State: AOAM533DJqNNrDljXWTltXyv3xR1gf5i8hqJfQ+h3CpH6wtJsg2HCyli
        t6ZXAHT6qTnTUIIlDFBTId8png==
X-Google-Smtp-Source: ABdhPJwWH2ZfN4mw7218/OZV1XCCHiMfE6h7+SNjJtrxOnsnE8Q/TJAvaJwj1YTOHl18aZga8qbpnw==
X-Received: by 2002:a62:1b51:0:b0:49f:a8d8:84b with SMTP id b78-20020a621b51000000b0049fa8d8084bmr5108326pfb.31.1639499365439;
        Tue, 14 Dec 2021 08:29:25 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id t191sm260609pgd.3.2021.12.14.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:29:24 -0800 (PST)
Date:   Tue, 14 Dec 2021 08:29:24 -0800 (PST)
X-Google-Original-Date: Mon, 13 Dec 2021 18:23:15 PST (-0800)
Subject:     Re: [PATCH v9 05/17] riscv: Add vector feature to compile
In-Reply-To: <2684ea9e25a63c7a88faf46680a26e560027e444.1636362169.git.greentime.hu@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-e9e08b2d-bb86-43e5-9975-bb497350e770@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2021 01:48:17 PST (-0800), greentime.hu@sifive.com wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch adds a new config option which could enable assembler's
> vector feature.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/Kconfig  | 9 +++++++++
>  arch/riscv/Makefile | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f076cee11af6..0311579920b9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -389,6 +389,15 @@ config FPU
>
>  	  If you don't know what to do here, say Y.
>
> +config VECTOR
> +	bool "VECTOR support"
> +	default n
> +	help
> +	  Say N here if you want to disable all vector related procedure
> +	  in the kernel.
> +
> +	  If you don't know what to do here, say Y.
> +
>  endmenu

As the kernel build robot points out, this should have some sort of 
dependency on a vector toolchain.  Not sure if there's a better way to 
do it that cc-option, looks like there are some other tests for 
assembler arguments that way.

>
>  menu "Kernel features"
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 37de70df4fae..f109214a2d7f 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -57,6 +57,7 @@ riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
>  riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
>  riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
>  riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
> +riscv-march-aflags-$(CONFIG_VECTOR)		:= $(riscv-march-aflags-y)v
>
>  KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
>  KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
