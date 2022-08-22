Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB759B728
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiHVBMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHVBMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:12:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16831D335;
        Sun, 21 Aug 2022 18:12:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h24so11377878wrb.8;
        Sun, 21 Aug 2022 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=3AdmndOpd6zIunTecnpi1mLwFVDbJmvpabOXm3DCD78=;
        b=UjA6q8mKF5sQPoLULzIpKiofAFZY40IWajUeMlzFBkgXRR1L3syXcQQQ2v1DsjJ+vC
         f5EdgcNNpD0i8LhIyzUnyj+QzwsqoAXMB+h1UMxTgjtwHNCYxphL3DYz+YlWiT/YSh/0
         v1M7tkxnWYKhiZ8YiO9yHEP7FnQSETbPeuSHkLjH6x9hGP/kv65OSAj0TtGOnUaNE7oy
         dA0Y48JGNapJ6tJw18MvN1mZZoSrzS3Nse+Z7nKiD/3hdZaOiN5lGCs2/tnxxoaeDlEc
         V7YxbB4YwIip0GsTi/p38daD8wOcVuc0K6EgaaE4tx7OlsfUtsKRNtpsvHWkoxuqPBpt
         k3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=3AdmndOpd6zIunTecnpi1mLwFVDbJmvpabOXm3DCD78=;
        b=IcmBzEswe2Kj56tmsMfUhdefNX8YJ69U14WUrqi5IyyGZ69/P6oLhJO6EGlwxD7KZq
         GKn3d5MShWdLdrbRqSeZ01jXCRf02ue8im23D/5vXNfgm+V4wUHLGUyCPfPuup3SAl6e
         et6ODVtZ8TV8pQkDSLkRvrx8iLQiSUiTZnrx9NVG83n1/XnNxOjlAN7IgAKlpblQXh8I
         CddtWJJH8aKs6Dy4DHN6iyawe2e+dK91LNzwO6F16wOhr+dzxnKuQdyeRjIXJEmvigWc
         MPGqx0C0LznJnr+93Xx7wMmp5xfZAmbN2RQnq6oBsWE6o51IRDkmsLWqAeCSXsFpwBFS
         e2ug==
X-Gm-Message-State: ACgBeo1PsWHQdIwDoGsVaxWcZtqx0PuauY7TuGYWYylyKKlRDpqwLWcW
        +Ma/8NFIsDkAgE8pVbx5fGVQICZWFJA/qe1kOXY=
X-Google-Smtp-Source: AA6agR5uWVa8JzxnIp25ysSvDyI4mN9wel1e/8gMEU0B3ZJX034gy37HQN12YxIIXHg+/YhNVZwvn0jWOOj/MQJf+Kw=
X-Received: by 2002:a05:6000:1684:b0:220:6e60:768d with SMTP id
 y4-20020a056000168400b002206e60768dmr9016494wrd.121.1661130757182; Sun, 21
 Aug 2022 18:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com> <1660100142-32493-4-git-send-email-u0084500@gmail.com>
In-Reply-To: <1660100142-32493-4-git-send-email-u0084500@gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 22 Aug 2022 09:12:25 +0800
Message-ID: <CADiBU39vExtLYQZO=p=Zf_k3da1SWVjogLtvs1Oi1vCXn46bqg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] input: misc: rt5120: Add power key support
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear reviewers:

cy_huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=8810=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add RT5120 PMIC power key support.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v4:
> - Add "Copyright" string and refine for GPL version string.
>
> Since v3:
> - Simplify the power key irq handler key report
> - Since press and release irq not needed to keep in private data, change =
'press',
>   'release' irq as local variable only.
> - Fix Kconfig typo for pwrkey.
>
Since binding/mfd/regulator are all applied, only this one is left.
Any update about this pwrkey patch?
> ---
>  drivers/input/misc/Kconfig         |   9 +++
>  drivers/input/misc/Makefile        |   1 +
>  drivers/input/misc/rt5120-pwrkey.c | 109 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 drivers/input/misc/rt5120-pwrkey.c
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index a18ab73..92daa4d 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -891,6 +891,15 @@ config INPUT_SC27XX_VIBRA
>           To compile this driver as a module, choose M here. The module w=
ill
>           be called sc27xx_vibra.
>
> +config INPUT_RT5120_PWRKEY
> +       tristate "RT5120 PMIC power key support"
> +       depends on MFD_RT5120
> +       help
> +         This enables support for RT5120 PMIC power key driver.
> +
> +         To compile this driver as a module, choose M here. the module w=
ill
> +         be called rt5120-pwrkey.
> +
>  config INPUT_STPMIC1_ONKEY
>         tristate "STPMIC1 PMIC Onkey support"
>         depends on MFD_STPMIC1
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 28dfc44..d1fb00e 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON) +=3D rave-sp-pwrb=
utton.o
>  obj-$(CONFIG_INPUT_RB532_BUTTON)       +=3D rb532_button.o
>  obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)   +=3D regulator-haptic.o
>  obj-$(CONFIG_INPUT_RETU_PWRBUTTON)     +=3D retu-pwrbutton.o
> +obj-$(CONFIG_INPUT_RT5120_PWRKEY)      +=3D rt5120-pwrkey.o
>  obj-$(CONFIG_INPUT_AXP20X_PEK)         +=3D axp20x-pek.o
>  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)        +=3D rotary_encoder.o
>  obj-$(CONFIG_INPUT_RK805_PWRKEY)       +=3D rk805-pwrkey.o
> diff --git a/drivers/input/misc/rt5120-pwrkey.c b/drivers/input/misc/rt51=
20-pwrkey.c
> new file mode 100644
> index 00000000..94d25ba
> --- /dev/null
> +++ b/drivers/input/misc/rt5120-pwrkey.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022 Richtek Technology Corp.
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define RT5120_REG_INTSTAT     0x1E
> +#define RT5120_PWRKEYSTAT_MASK BIT(7)
> +
> +struct rt5120_priv {
> +       struct regmap *regmap;
> +       struct input_dev *input;
> +};
> +
> +static irqreturn_t rt5120_pwrkey_handler(int irq, void *devid)
> +{
> +       struct rt5120_priv *priv =3D devid;
> +       unsigned int stat;
> +       int ret;
> +
> +       ret =3D regmap_read(priv->regmap, RT5120_REG_INTSTAT, &stat);
> +       if (ret)
> +               return IRQ_NONE;
> +
> +       input_report_key(priv->input, KEY_POWER,
> +                        !(stat & RT5120_PWRKEYSTAT_MASK));
> +       input_sync(priv->input);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int rt5120_pwrkey_probe(struct platform_device *pdev)
> +{
> +       struct rt5120_priv *priv;
> +       struct device *dev =3D &pdev->dev;
> +       int press_irq, release_irq;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->regmap =3D dev_get_regmap(dev->parent, NULL);
> +       if (!priv->regmap)
> +               return dev_err_probe(dev, -ENODEV, "Failed to init regmap=
\n");
> +
> +       press_irq =3D platform_get_irq_byname(pdev, "pwrkey-press");
> +       if (press_irq < 0)
> +               return press_irq;
> +
> +       release_irq =3D platform_get_irq_byname(pdev, "pwrkey-release");
> +       if (release_irq < 0)
> +               return release_irq;
> +
> +       /* Make input device be device resource managed */
> +       priv->input =3D devm_input_allocate_device(dev);
> +       if (!priv->input)
> +               return dev_err_probe(dev, -ENOMEM,
> +                                    "Failed to allocate input device\n")=
;
> +
> +       priv->input->name =3D "rt5120_pwrkey";
> +       priv->input->phys =3D "rt5120_pwrkey/input0";
> +       priv->input->id.bustype =3D BUS_I2C;
> +       input_set_capability(priv->input, EV_KEY, KEY_POWER);
> +
> +       ret =3D input_register_device(priv->input);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to register input device\n")=
;
> +
> +       ret =3D devm_request_threaded_irq(dev, press_irq, NULL,
> +                                       rt5120_pwrkey_handler, 0,
> +                                       "pwrkey-press", priv);
> +       if (ret)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to register pwrkey press irq=
\n");
> +
> +       return devm_request_threaded_irq(dev, release_irq, NULL,
> +                                        rt5120_pwrkey_handler, 0,
> +                                        "pwrkey-release", priv);
> +}
> +
> +static const struct of_device_id r5120_pwrkey_match_table[] =3D {
> +       { .compatible =3D "richtek,rt5120-pwrkey" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, r5120_pwrkey_match_table);
> +
> +static struct platform_driver rt5120_pwrkey_driver =3D {
> +       .driver =3D {
> +               .name =3D "rt5120-pwrkey",
> +               .of_match_table =3D r5120_pwrkey_match_table,
> +       },
> +       .probe =3D rt5120_pwrkey_probe,
> +};
> +module_platform_driver(rt5120_pwrkey_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RT5120 power key driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
