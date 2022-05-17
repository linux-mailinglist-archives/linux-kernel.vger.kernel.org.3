Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D7529BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiEQIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbiEQILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:11:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549A3CA5B;
        Tue, 17 May 2022 01:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068D0611E2;
        Tue, 17 May 2022 08:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEDEC34100;
        Tue, 17 May 2022 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652775081;
        bh=G13kXIW4s6Pcy4BSlXyMefkAe8ns85SmAcmOmBOdOws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p6T8WwRRYkq2Yr0T/ugAAQuYioRnEv9Co8Aatc3ztL3Sf3qbQEVqRmJCyQLC/13sF
         r58+AhSwc7onQTwwl7a6AXjvMYaAVXkFNlfxGpV3rAjCeQ09b+4JkxxilV/u1Hwvao
         tydOTumob09OYzt2yEM5VPCT9Dh1pLqyR8qKZzSCS9PMraIE7Zv9RQ9qqsjkRwfYTm
         kkMQL36jqxoVJAj7ZMGMrijXHfH1bgROd7xoxzJzuCHAS+2GtDSdNgCJiZCtsJ6ASM
         0oy7RONFwjQC+DS25khs0akCVDftbxlIwPaZz0UaS14K8ewH4IEfMuQtTQxR3MbQSO
         5/GERxxc/muMg==
Received: by mail-oi1-f177.google.com with SMTP id v66so21451132oib.3;
        Tue, 17 May 2022 01:11:21 -0700 (PDT)
X-Gm-Message-State: AOAM531Bsclh2cAi8FQXDsawrejLDRziW/tF59TjGYVFUh27piSJ28gz
        EVJZg2MjDfYDHDiL7T4DuGZt1GdIluq3JUOH4MQ=
X-Google-Smtp-Source: ABdhPJy1CTbEQsyqgIE8jj4/8WvmUlhpYtiVDu0SgAQke0jlX2w6xF+xlZ/GA4o6rm7siIum7OpWULRH6bxfMSxVboo=
X-Received: by 2002:a05:6808:1314:b0:326:e438:d8cd with SMTP id
 y20-20020a056808131400b00326e438d8cdmr15625016oiv.228.1652775080613; Tue, 17
 May 2022 01:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220516101635.1082132-1-yoan.picchi@arm.com> <20220516101635.1082132-3-yoan.picchi@arm.com>
In-Reply-To: <20220516101635.1082132-3-yoan.picchi@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 17 May 2022 10:11:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
Message-ID: <CAMj1kXGAiA-SkTFD5EgcacYao0RKT7oK0AxvxkR7Ho_KZSGXCw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Removes the x86 dependency on the QAT drivers
To:     yoan.picchi@arm.com
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        qat-linux <qat-linux@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 at 12:16, <yoan.picchi@arm.com> wrote:
>
> From: Yoan Picchi <yoan.picchi@arm.com>
>
> This dependency looks outdated. After the previous patch, we have been able
> to use this driver to encrypt some data and to create working VF on arm64.
>
> Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>

Are you sure the driver is safe for non-coherent DMA as well?

> ---
>  drivers/crypto/qat/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/crypto/qat/Kconfig b/drivers/crypto/qat/Kconfig
> index 4b90c0f22b03..88df2cf4cac9 100644
> --- a/drivers/crypto/qat/Kconfig
> +++ b/drivers/crypto/qat/Kconfig
> @@ -17,7 +17,7 @@ config CRYPTO_DEV_QAT
>
>  config CRYPTO_DEV_QAT_DH895xCC
>         tristate "Support for Intel(R) DH895xCC"
> -       depends on X86 && PCI
> +       depends on PCI
>         select CRYPTO_DEV_QAT
>         help
>           Support for Intel(R) DH895xcc with Intel(R) QuickAssist Technology
> @@ -28,7 +28,7 @@ config CRYPTO_DEV_QAT_DH895xCC
>
>  config CRYPTO_DEV_QAT_C3XXX
>         tristate "Support for Intel(R) C3XXX"
> -       depends on X86 && PCI
> +       depends on PCI
>         select CRYPTO_DEV_QAT
>         help
>           Support for Intel(R) C3xxx with Intel(R) QuickAssist Technology
> @@ -39,7 +39,7 @@ config CRYPTO_DEV_QAT_C3XXX
>
>  config CRYPTO_DEV_QAT_C62X
>         tristate "Support for Intel(R) C62X"
> -       depends on X86 && PCI
> +       depends on PCI
>         select CRYPTO_DEV_QAT
>         help
>           Support for Intel(R) C62x with Intel(R) QuickAssist Technology
> @@ -50,7 +50,7 @@ config CRYPTO_DEV_QAT_C62X
>
>  config CRYPTO_DEV_QAT_4XXX
>         tristate "Support for Intel(R) QAT_4XXX"
> -       depends on X86 && PCI
> +       depends on PCI
>         select CRYPTO_DEV_QAT
>         help
>           Support for Intel(R) QuickAssist Technology QAT_4xxx
> @@ -61,7 +61,7 @@ config CRYPTO_DEV_QAT_4XXX
>
>  config CRYPTO_DEV_QAT_DH895xCCVF
>         tristate "Support for Intel(R) DH895xCC Virtual Function"
> -       depends on X86 && PCI
> +       depends on PCI
>         select PCI_IOV
>         select CRYPTO_DEV_QAT
>
> @@ -74,7 +74,7 @@ config CRYPTO_DEV_QAT_DH895xCCVF
>
>  config CRYPTO_DEV_QAT_C3XXXVF
>         tristate "Support for Intel(R) C3XXX Virtual Function"
> -       depends on X86 && PCI
> +       depends on PCI
>         select PCI_IOV
>         select CRYPTO_DEV_QAT
>         help
> @@ -86,7 +86,7 @@ config CRYPTO_DEV_QAT_C3XXXVF
>
>  config CRYPTO_DEV_QAT_C62XVF
>         tristate "Support for Intel(R) C62X Virtual Function"
> -       depends on X86 && PCI
> +       depends on PCI
>         select PCI_IOV
>         select CRYPTO_DEV_QAT
>         help
> --
> 2.25.1
>
