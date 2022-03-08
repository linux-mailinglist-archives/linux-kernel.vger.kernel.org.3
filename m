Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442984D1571
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbiCHLDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbiCHLDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:03:42 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A427176;
        Tue,  8 Mar 2022 03:02:44 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id 85so6370759qkm.9;
        Tue, 08 Mar 2022 03:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0stFw1+aRQ7CVonQBQEgUhIYKMIOUXl5HPF2CD2bC/k=;
        b=0epP9pCIKqddTV7yR69IoLKkLwLJtYQkNlseH0MrxnvSNqvwTg3azZBhsFF2Cf2Zok
         AVs2UNy7606hcBWHrqfVviOw2sn7stv1mZlCd4vBTSLbGHNkpH9t4A/VUe1a7ELzPmMs
         ItrSF387ltqVdBD2k2rB26eHL0NBHcZJiWhSW0GkM/0dUc1qATPs9aV2x0ZzB1m56+wp
         O6ZmjQ00KUFxfj+3Ivf+rNiUfP7yXyPSdDOSjvOZrywHGKb1XNuBra/l+NdXHq+ohhYE
         57HblsKC4oiTTd0XvPY06wBlIvsBDfXvdZ3rRuc0d4epi2LEpQjLEUQyXnL/djBWRslC
         7q5g==
X-Gm-Message-State: AOAM531VA7FGNmxV/XZJ5xsNvpIHdRbwS1EZQGggzdE2o87zkE3ZyCb9
        s/Hl9fxLu0dpq8/7qNPaswS+3P0QPR47IA==
X-Google-Smtp-Source: ABdhPJz4LbydenFXu8BFsaSzLPvwJWKz/7OpDdSnqtbKx0d9/rD2jQ/na1tjOAcFVIw66NznhE2yAg==
X-Received: by 2002:a05:620a:4450:b0:67c:258e:58d with SMTP id w16-20020a05620a445000b0067c258e058dmr2908687qkp.97.1646737363336;
        Tue, 08 Mar 2022 03:02:43 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm462077qkb.74.2022.03.08.03.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 03:02:42 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2db2add4516so197138047b3.1;
        Tue, 08 Mar 2022 03:02:41 -0800 (PST)
X-Received: by 2002:a81:49d0:0:b0:2db:dc6d:445d with SMTP id
 w199-20020a8149d0000000b002dbdc6d445dmr12610550ywa.512.1646737361666; Tue, 08
 Mar 2022 03:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me> <20220124121009.108649-5-alistair@alistair23.me>
In-Reply-To: <20220124121009.108649-5-alistair@alistair23.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 12:02:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXhnG3ib+2C4TsejQKWNObxVbyJ1jODjyDxGpufY8bCag@mail.gmail.com>
Message-ID: <CAMuHMdXhnG3ib+2C4TsejQKWNObxVbyJ1jODjyDxGpufY8bCag@mail.gmail.com>
Subject: Re: [PATCH v18 4/8] regulator: sy7636a: Remove requirement on sy7636a mfd
To:     Alistair Francis <alistair@alistair23.me>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>, alistair23@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
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

Hi Alistair,

On Mon, Jan 24, 2022 at 1:25 PM Alistair Francis <alistair@alistair23.me> wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks for your patch, which is now commit 947d0cce70ae37b8
("regulator: sy7636a: Remove requirement on sy7636a mfd") in
mfd/for-mfd-next.

> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1208,7 +1208,6 @@ config REGULATOR_STW481X_VMMC
>
>  config REGULATOR_SY7636A
>         tristate "Silergy SY7636A voltage regulator"
> -       depends on MFD_SY7636A

As this is an i2c mfd device, you still need a dependency on
MFD and I2C, or some other symbol?

>         help
>           This driver supports Silergy SY3686A voltage regulator.
>
> diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
> index 22fddf868e4c..29fc27c2cda0 100644
> --- a/drivers/regulator/sy7636a-regulator.c
> +++ b/drivers/regulator/sy7636a-regulator.c
> @@ -7,11 +7,14 @@
>  // Authors: Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>
>  //          Alistair Francis <alistair@alistair23.me>
>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/sy7636a.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
>  #include <linux/regmap.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/mfd/sy7636a.h>
>
>  struct sy7636a_data {
>         struct regmap *regmap;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
