Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB218502C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354809AbiDOPHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDOPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:07:01 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655415838;
        Fri, 15 Apr 2022 08:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1650035066; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRWVXKW+RZN7vxEYxFynwfobJo7XniIQKD+eb2wTdOc=;
        b=o+MOZCEA+EYYqJcDDf9v+gfNQWTX15W/ct4ImD4k2t4pcDD/fftevnqeK4QRv0jcSQ3vcv
        5o5nxEqFodGTaJD1WKhzcOU0uuk/zSmLToMZJJf6jBt30cz29mMAmbAPmK6N2XCmZhGQkW
        pFWBhJ3cTDeDpVYAzaz0Ysvq0juJLRo=
Date:   Fri, 15 Apr 2022 16:04:16 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add support for new Ingenic SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Message-Id: <47ZDAR.RKPJNNUQZQO22@crapouillou.net>
In-Reply-To: <1650032528-118220-4-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1650032528-118220-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven., avril 15 2022 at 22:22:08 +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> 1.Since it would be dangerous to specify a newer SoC's compatible
>   string as the fallback of an older SoC's compatible string, we
>   add support for the "ingenic,jz4775-spi" compatible string in
>   the driver.
>=20
>   This will permit to support the JZ4775 by having:
>   compatible =3D "ingenic,jz4775-spi";
>=20
>   Instead of doing:
>   compatible =3D "ingenic,jz4775-spi", "ingenic,jz4780-spi";
>=20
> 2.Add support for probing the spi-ingenic driver on the X1000 SoC
>   from Ingenic. From the X1000 SoC onwards, the maximum frequency
>   allowed by the SSI module of Ingenic SoCs has been changed from
>   54MHz to 50MHz. So "max_speed_hz" is introduced in "jz_soc_info"
>   to set different maximum frequency values.
>=20
> 3.Add support for probing the spi-ingenic driver on the X2000 SoC
>   from Ingenic. The X2000 SoC has only one native chip select line,
>   so "max_native_cs" is introduced in "jz_soc_info" to set different
>   maximum number of native chip select lines.
>=20
> 4.Because of the introduction of support for the X-series SoCs, the
>   current driver is not only applicable to the JZ-series SoCs, so
>   the description texts has been modified to avoid misunderstanding.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/spi/Kconfig       |  4 ++--
>  drivers/spi/spi-ingenic.c | 42=20
> +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 39 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index d2815eb..cca92a8 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -419,10 +419,10 @@ config SPI_IMX
>  	  This enables support for the Freescale i.MX SPI controllers.
>=20
>  config SPI_INGENIC
> -	tristate "Ingenic JZ47xx SoCs SPI controller"
> +	tristate "Ingenic SoCs SPI controller"
>  	depends on MACH_INGENIC || COMPILE_TEST
>  	help
> -	  This enables support for the Ingenic JZ47xx SoCs SPI controller.
> +	  This enables support for the Ingenic SoCs SPI controller.
>=20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called spi-ingenic.
> diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
> index 672e4ed..ff507c8 100644
> --- a/drivers/spi/spi-ingenic.c
> +++ b/drivers/spi/spi-ingenic.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * SPI bus driver for the Ingenic JZ47xx SoCs
> + * SPI bus driver for the Ingenic SoCs
>   * Copyright (c) 2017-2021 Artur Rojek <contact@artur-rojek.eu>
>   * Copyright (c) 2017-2021 Paul Cercueil <paul@crapouillou.net>
> + * Copyright (c) 2022 =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)=20
> <zhouyanjie@wanyeetech.com>
>   */
>=20
>  #include <linux/clk.h>
> @@ -52,6 +53,9 @@ struct jz_soc_info {
>  	u32 bits_per_word_mask;
>  	struct reg_field flen_field;
>  	bool has_trendian;
> +
> +	unsigned int max_speed_hz;
> +	unsigned int max_native_cs;
>  };
>=20
>  struct ingenic_spi {
> @@ -418,7 +422,7 @@ static int spi_ingenic_probe(struct=20
> platform_device *pdev)
>=20
>  	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs)) {
>  		dev_warn(dev, "Number of chip select lines not specified.\n");
> -		num_cs =3D 2;
> +		num_cs =3D pdata->max_native_cs;
>  	}
>=20
>  	platform_set_drvdata(pdev, ctlr);
> @@ -433,9 +437,9 @@ static int spi_ingenic_probe(struct=20
> platform_device *pdev)
>  	ctlr->max_dma_len =3D SPI_INGENIC_FIFO_SIZE;
>  	ctlr->bits_per_word_mask =3D pdata->bits_per_word_mask;
>  	ctlr->min_speed_hz =3D 7200;
> -	ctlr->max_speed_hz =3D 54000000;
> +	ctlr->max_speed_hz =3D pdata->max_speed_hz;
>  	ctlr->use_gpio_descriptors =3D true;
> -	ctlr->max_native_cs =3D 2;
> +	ctlr->max_native_cs =3D pdata->max_native_cs;
>  	ctlr->num_chipselect =3D num_cs;
>  	ctlr->dev.of_node =3D pdev->dev.of_node;
>=20
> @@ -459,17 +463,44 @@ static const struct jz_soc_info jz4750_soc_info=20
> =3D {
>  	.bits_per_word_mask =3D SPI_BPW_RANGE_MASK(2, 17),
>  	.flen_field =3D REG_FIELD(REG_SSICR1, 4, 7),
>  	.has_trendian =3D false,
> +
> +	.max_speed_hz =3D 54000000,
> +	.max_native_cs =3D 2,
>  };
>=20
>  static const struct jz_soc_info jz4780_soc_info =3D {
>  	.bits_per_word_mask =3D SPI_BPW_RANGE_MASK(2, 32),
>  	.flen_field =3D REG_FIELD(REG_SSICR1, 3, 7),
>  	.has_trendian =3D true,
> +
> +	.max_speed_hz =3D 54000000,
> +	.max_native_cs =3D 2,
> +};
> +
> +static const struct jz_soc_info x1000_soc_info =3D {
> +	.bits_per_word_mask =3D SPI_BPW_RANGE_MASK(2, 32),
> +	.flen_field =3D REG_FIELD(REG_SSICR1, 3, 7),
> +	.has_trendian =3D true,
> +
> +	.max_speed_hz =3D 50000000,
> +	.max_native_cs =3D 2,
> +};
> +
> +static const struct jz_soc_info x2000_soc_info =3D {
> +	.bits_per_word_mask =3D SPI_BPW_RANGE_MASK(2, 32),
> +	.flen_field =3D REG_FIELD(REG_SSICR1, 3, 7),
> +	.has_trendian =3D true,
> +
> +	.max_speed_hz =3D 50000000,
> +	.max_native_cs =3D 1,
>  };
>=20
>  static const struct of_device_id spi_ingenic_of_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4750-spi", .data =3D &jz4750_soc_info },
> +	{ .compatible =3D "ingenic,jz4775-spi", .data =3D &jz4780_soc_info },
>  	{ .compatible =3D "ingenic,jz4780-spi", .data =3D &jz4780_soc_info },
> +	{ .compatible =3D "ingenic,x1000-spi", .data =3D &x1000_soc_info },
> +	{ .compatible =3D "ingenic,x2000-spi", .data =3D &x2000_soc_info },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, spi_ingenic_of_match);
> @@ -483,7 +514,8 @@ static struct platform_driver spi_ingenic_driver=20
> =3D {
>  };
>=20
>  module_platform_driver(spi_ingenic_driver);
> -MODULE_DESCRIPTION("SPI bus driver for the Ingenic JZ47xx SoCs");
> +MODULE_DESCRIPTION("SPI bus driver for the Ingenic SoCs");
>  MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
>  MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
> +MODULE_AUTHOR("=E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wan=
yeetech.com>");
>  MODULE_LICENSE("GPL");
> --
> 2.7.4
>=20


