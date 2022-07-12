Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0239F571731
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiGLKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiGLKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:22:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D6AACF6A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:22:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so13493692ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjUTXd6Ka6EafYLyFo8kWAbBISE3yM/FgOqSMXCb4Ck=;
        b=yMmRBuKMcX7EAI6IdgrUOclHBEexv4UwEeETQGtxCqNwF4GYaXH+f9jOorD1uG4OWG
         rkqs5dmY+Xqy06R0JiDpYJ3ujheVfPw+CMEMEo0/QRgE6eiku3QV/n0wBr2wZEq10+kg
         VBtvjsB/dDdw5VvH1qL5PlLlGnMyvsLZXdbfn/nfSvEiC6+0SF9jG6un3UzQAdNz9zYp
         Ot+fhcPXlSlfWd5icXUZsv2DKL5pkAto3c2PssvHIluwoPUJJOewXc8N49ggJIBZwNra
         O05vJd8EWuuosQxG4tzhG6QKBQQJRvEPa1GTnm1weHxS3ekvEu5l1ShEJ7cEouPEx3Bp
         Gfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjUTXd6Ka6EafYLyFo8kWAbBISE3yM/FgOqSMXCb4Ck=;
        b=bqJvDDgiE0WjcLty7ek100IDOKMndWDWRZYjd5bxJGxIX1ry1uIEAC4vDncRs+pEAK
         nCq6XVbHNubI7HS6Eo34MVQpj3oRTpjkLSdTGwzbwAlM7k090A1/I7qtBVLylG/zg6C2
         UPO+uOmuYaugVdNYmnng3h7SKnLnVNyBIcFI+xdkJTEd7FgsGzC+1EsOKuZi5JBKRdyk
         WNuqZtP+e2clxWFKfM0WSmZ0Zi5ZuiZ8jWICyqz+CIdoFBunzpuIv7jSPLSY37DrVElt
         tnlSe5Q7GxuWwH8UnhPs0/N2VjZRVEUWbhcFHF47lEtkV20vwe2RzdB8EiNiFfO4+Oc0
         ZO4A==
X-Gm-Message-State: AJIora+PvXILVvqapOiEVpuPZwMFOcFH1Tqgzksot2SjX5vXGhXq3+ue
        jF4nkS4ufgCngoxBY5hruBLO1CkmPrESuphehwNGzg==
X-Google-Smtp-Source: AGRyM1usxGX2KX0vaJRhLffTri3NjkskE7Nv66mhSACHacWR3cYW4Kt1NswdxsyRhDtnvrQjbcmYb2B9fO57Hz3eNbM=
X-Received: by 2002:a17:907:2c4a:b0:72b:5b9b:9c50 with SMTP id
 hf10-20020a1709072c4a00b0072b5b9b9c50mr8247047ejc.636.1657621340255; Tue, 12
 Jul 2022 03:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220711081257.132901-1-maz@kernel.org>
In-Reply-To: <20220711081257.132901-1-maz@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Jul 2022 12:22:09 +0200
Message-ID: <CAMRc=Mf-FEKu_HrZvsL7+H2NTnME6mVV4AjMmZkEOn0Ch+4yMQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: thunderx: Don't directly include asm-generic/msi.h
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 10:13 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On architectures that require it, asm-generic/msi.h is already
> dragged in by the higher level include files, and is commonly
> refered to as 'asm/msi.h'.
>
> It is also architecture specific, and breaks compilation in
> a pretty bad way now that linux/gpio/driver.h includes asm/msi.h
> (which drags a conflicting but nonetheless correct version
> of msi_alloc_info_t on x86).
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20220711154252.4b88a601@canb.auug.org.au
> Fixes: 91a29af413de ("gpio: Remove dynamic allocation from populate_parent_alloc_arg()")
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-thunderx.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
> index e1dedbca0c85..cc62c6e64103 100644
> --- a/drivers/gpio/gpio-thunderx.c
> +++ b/drivers/gpio/gpio-thunderx.c
> @@ -15,8 +15,6 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/spinlock.h>
> -#include <asm-generic/msi.h>
> -
>
>  #define GPIO_RX_DAT    0x0
>  #define GPIO_TX_SET    0x8
> --
> 2.34.1
>

Applied for fixes, thanks!

Bart
