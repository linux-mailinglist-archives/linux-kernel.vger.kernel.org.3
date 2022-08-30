Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473EF5A5D25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiH3Hl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiH3Hlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:41:55 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315378048C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:41:54 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id cr9so7902530qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=305s+Px20ZffvameY0SQ6LsiYZFhK2XEewc8CJZLQd8=;
        b=LSS+bbvUv1TwQI2BkgnAz4kJyiWq08D7TygVqHvnYJT9oULxHnJAsrvRvAt8sDLRUE
         s2/UvMywc5K9NkVLbYYaaFyBOp2UpgWFwHELM4OfUDctVetnD22++lj0ElG9Q6UKb+DG
         kMFFQS2DdYBkSJ915H9ipPuJWZcYnYpDiD4f2RpdgRTPaiygGvyZSCPq2iivGbZYPEML
         CU9btRrF5eoe0ZkCiE5IlXyGPb4Hsa1YXdUqrUrsiNkBoRKCC8nlK45WrcMdyen3hJF5
         vNpgO4/pDhTHjypmW++OV3yuxEBmY/XuZFtU4WyBUqst9wMCSReM/DUdvWHRK2BvezNg
         3qsQ==
X-Gm-Message-State: ACgBeo0u1ydfIZ9gL3PHwunBPsIVinuiwk/XTgrKWL53XzPPwn/78Juc
        xarBQllldqJKn/DdBtSHT2b+yUetbW7jhg==
X-Google-Smtp-Source: AA6agR6aoEdHa+bkCXsOrJZRmZQbeSALSxQnxpQZEON94jNTG8i33/5A+rE/5nYpMwxHUrY+gDM0zA==
X-Received: by 2002:a05:622a:392:b0:343:738e:6f6b with SMTP id j18-20020a05622a039200b00343738e6f6bmr13719337qtx.174.1661845313190;
        Tue, 30 Aug 2022 00:41:53 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id f5-20020ac81345000000b0034455ff76ddsm6251693qtj.34.2022.08.30.00.41.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:41:51 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-32a09b909f6so253613027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:41:51 -0700 (PDT)
X-Received: by 2002:a81:ac68:0:b0:340:a36c:9807 with SMTP id
 z40-20020a81ac68000000b00340a36c9807mr12426570ywj.283.1661845310788; Tue, 30
 Aug 2022 00:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-5-arnd@kernel.org>
 <CACRpkdbFkV1T+K9wKDyODkcwu=nhbV+4_JF=YTaA5ad_w4ggbw@mail.gmail.com>
 <CAK8P3a1PQjR2sv2rar6mFY9g4PkteAC+zgRUvnr04DETJX3K9w@mail.gmail.com> <63a630b7-9068-40f9-b7f7-d9a08f74ed13@www.fastmail.com>
In-Reply-To: <63a630b7-9068-40f9-b7f7-d9a08f74ed13@www.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 09:41:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqzOTDkbC7NXXQ32dLfO+JfkEMijxepEA=FfThSE9Xow@mail.gmail.com>
Message-ID: <CAMuHMdXqzOTDkbC7NXXQ32dLfO+JfkEMijxepEA=FfThSE9Xow@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix XIP_KERNEL dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Aug 30, 2022 at 9:21 AM Arnd Bergmann <arnd@arndb.de> wrote:
> CONFIG_XIP_KERNEL does not work with any option that involves patching
> the read-only kernel .text.
>
> Since at least CONFIG_SMP_ON_UP is required in certain configurations,
> flip the dependency to always allow the .text patching options but make
> XIP_KERNEL have the dependency instead.
>
> This is a prerequisite for allowing CONFIG_ARCH_MULTIPLATFORM to
> be disabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1619,6 +1619,7 @@ endchoice
>  config XIP_KERNEL
>         bool "Kernel Execute-In-Place from ROM"
>         depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
> +       depends on !SMP_ON_UP && !ARM_PATCH_IDIV && !ARM_PATCH_PHYS_VIRT

You may want to keep the list sorted.

>         help
>           Execute-In-Place allows the kernel to run from non-volatile storage
>           directly addressable by the CPU, such as NOR flash. This saves RAM

Regardless, LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
