Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F704D1623
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiCHLWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346463AbiCHLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:22:39 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150524579C;
        Tue,  8 Mar 2022 03:21:43 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id bt3so15846198qtb.0;
        Tue, 08 Mar 2022 03:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4/6/jNoigqZsZr9XYglGbTplLVuMWJmgJ5Lyc0Enx4=;
        b=S+PKWVC4Zmy0ZUCBkUv/3n5Q8Ass0kX7DTLun6UTI1BymCfqihoc0+6wLL9p5Yp6pu
         LK2z6PsmReLrnAn26Iqn/SQ9sk6Hl2H7PSpNj4GGAwNL5PGOBuHE3SJ+FffBmWE2Dut6
         TobjsyAAO1m6e1U6c3NqBt7cmKcuaiZ7CngpfFWVzXXJNlWgZ6oDYKmtpuWB3fRZxYyA
         jBX/9IPYTk0Wbn/KSPxy/9vG/iZ9fj+/QtnXcLCym6zVFpDW/KHkC20E0RZHfF8wEpZ8
         wLq8gFdR10NgA87SuSGzLuq4bNKGvSnOvGSAw+Ezo8iQgmjh1YmpQp24B5+hRW2jAPeM
         pHRw==
X-Gm-Message-State: AOAM531gcOq3lpYpT0hp0oTofEK8nG8LzN9wxNaEzZPc2X1oyGpoRJJ6
        GyRJUPkekFDMITZEbPNbR8NoLGWzhyPCdw==
X-Google-Smtp-Source: ABdhPJwtNf3sO/CJmVmqr+ZA2Tl5NCrBx+U8Rxd9yGik7ssiW9A8Le8BPzZBwiImwfRhlwJQuRptjg==
X-Received: by 2002:a05:622a:406:b0:2e0:9838:6b58 with SMTP id n6-20020a05622a040600b002e098386b58mr102157qtx.607.1646738501920;
        Tue, 08 Mar 2022 03:21:41 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002de4d014733sm10428486qtf.13.2022.03.08.03.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 03:21:41 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id l2so17568936ybe.8;
        Tue, 08 Mar 2022 03:21:41 -0800 (PST)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr11278520ybk.207.1646738500973; Tue, 08
 Mar 2022 03:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me> <20220124121009.108649-6-alistair@alistair23.me>
In-Reply-To: <20220124121009.108649-6-alistair@alistair23.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 12:21:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUe-z-6_=W5AFtWMug-cqTZKJhd-iLbdoRnSKoXwm27Uw@mail.gmail.com>
Message-ID: <CAMuHMdUe-z-6_=W5AFtWMug-cqTZKJhd-iLbdoRnSKoXwm27Uw@mail.gmail.com>
Subject: Re: [PATCH v18 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
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
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On Mon, Jan 24, 2022 at 1:25 PM Alistair Francis <alistair@alistair23.me> wrote:
> This is a multi-function device to interface with the sy7636a
> EPD PMIC chip from Silergy.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks for your patch, which is now commit de34a40532507814 ("hwmon:
sy7636a: Add temperature driver for sy7636a") in mfd/for-mfd-next.

> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1672,6 +1672,15 @@ config SENSORS_SIS5595
>           This driver can also be built as a module. If so, the module
>           will be called sis5595.
>
> +config SENSORS_SY7636A
> +       tristate "Silergy SY7636A"
> +       help
> +         If you say yes here you get support for the thermistor readout of
> +         the Silergy SY7636A PMIC.

As this is an i2c mfd device, you do need a dependency on MFD and I2C,
or some other symbol, unless compile-testing?

> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called sy7636a-hwmon.
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
