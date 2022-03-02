Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE04CB264
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiCBWeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:33:58 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0D4F45C;
        Wed,  2 Mar 2022 14:33:14 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id v5so2580012qkj.4;
        Wed, 02 Mar 2022 14:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MH2CJfGKAeTvDpXrtXLMMm+AC8F6kORH3TEKSbCrNfI=;
        b=RKeNmy3FgK0W71enFNR21BoAMLPgQXHsfgsQCPyNwyuvfc7MZfNodSByaq0Xp2JeOP
         tf5cFIpBZ6//AkroEjrR/w9M87A3MtinzkU6NksETqZj3V63/skTEg0IrWKa/DdihjUM
         A2ac1oIm9AhN8QgbHXUX9hs/Ta4d9tz0s/WAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MH2CJfGKAeTvDpXrtXLMMm+AC8F6kORH3TEKSbCrNfI=;
        b=6mRQY/espVYJBbUDhVgXKRV1zrJrY+9xTWwL9RnmFCjuO9sgFgkXPe/ZcGurydP1/G
         y+/exoCl7hjZefbDupHayEiTZYjdMwdUlZTYHqyMBl1OCRLTxL441qyGCXzlIEOOHEV0
         08gtVQQnRWcOhj94CPqB4dflVGDcIkwyGrDb0MwOmLNbqd3I43hvTlg1rykxLdXvBfTw
         92Gmq/Yf+lxgbfjQHOeimAoIWATZmTP4ncm2ZGWZYcSwwVIv6GhRuYFi+GiculV2bN3J
         SNiTbeu6cDGJJxSqtdMC0CphhzrAILi1qeyF4/hzD0qMsr9mS1W+Ar9LZDvRSQyhbcwh
         TePA==
X-Gm-Message-State: AOAM5317+yejw+FLV2d5KK/VK3YFyUUapSa38PYE62MJurm1WHUUiuHP
        5LY+eZ/uK8oCahKPB4KD9E12vbNAwLv9Y6yietM=
X-Google-Smtp-Source: ABdhPJyEPtu3slh8282TJBc0g7ayy9DHHSl7hyRSC0WrVkNRJQUeSH83zE/yVMt2TqYx5LcoPN0nxADhKTQ6LJ7k4ss=
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id
 l3-20020a37f903000000b00648ca74b7dcmr17319869qkj.666.1646260393417; Wed, 02
 Mar 2022 14:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-9-clg@kaod.org>
In-Reply-To: <20220302173114.927476-9-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:33:00 +0000
Message-ID: <CACPK8XeA9MUg-Ai4XMTRDDEK52UFHupAFcBTCN7ZhSHZOfTaBg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] spi: aspeed: Add support for the AST2400 SPI controller
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Extend the driver for the AST2400 SPI Flash Controller (SPI). This
> controller has a slightly different interface which requires
> adaptation of the 4B handling. Summary of features :
>
>    . host Firmware
>    . 1 chip select pin (CE0)
>    . slightly different register set, between AST2500 and the legacy
>      controller
>    . no segment registers
>    . single, dual mode.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index e133984d3c95..8c6d7f79d97f 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -32,6 +32,7 @@
>  #define   CTRL_IO_DUAL_DATA            BIT(29)
>  #define   CTRL_IO_QUAD_DATA            BIT(30)
>  #define   CTRL_COMMAND_SHIFT           16
> +#define   CTRL_IO_ADDRESS_4B           BIT(13) /* AST2400 SPI only */
>  #define   CTRL_IO_DUMMY_SET(dummy)                                     \
>         (((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
>  #define   CTRL_CE_STOP_ACTIVE          BIT(2)
> @@ -272,6 +273,8 @@ static bool aspeed_spi_supports_op(struct spi_mem *me=
m, const struct spi_mem_op
>         return spi_mem_default_supports_op(mem, op);
>  }
>
> +static const struct aspeed_spi_data ast2400_spi_data;
> +
>  static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_m=
em_op *op)
>  {
>         struct aspeed_spi *aspi =3D spi_controller_get_devdata(mem->spi->=
master);
> @@ -301,6 +304,9 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem,=
 const struct spi_mem_op *o
>                         addr_mode |=3D (0x11 << chip->cs);
>                 else
>                         addr_mode &=3D ~(0x11 << chip->cs);
> +
> +               if (op->addr.nbytes =3D=3D 4 && chip->aspi->data =3D=3D &=
ast2400_spi_data)
> +                       ctl_val |=3D CTRL_IO_ADDRESS_4B;
>         }
>
>         if (op->dummy.buswidth && op->dummy.nbytes)
> @@ -392,7 +398,13 @@ static int aspeed_spi_chip_set_default_window(struct=
 aspeed_spi_chip *chip)
>         struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] =3D { 0 }=
;
>         struct aspeed_spi_window *win =3D &windows[chip->cs];
>
> -       aspeed_spi_get_windows(aspi, windows);
> +       /* No segment registers for the AST2400 SPI controller */
> +       if (aspi->data =3D=3D &ast2400_spi_data) {
> +               win->offset =3D 0;
> +               win->size =3D aspi->ahb_window_size;
> +       } else {
> +               aspeed_spi_get_windows(aspi, windows);
> +       }
>
>         chip->ahb_base =3D aspi->ahb_base + win->offset;
>         chip->ahb_window_size =3D win->size;
> @@ -455,6 +467,10 @@ static int aspeed_spi_chip_adjust_window(struct aspe=
ed_spi_chip *chip,
>         struct aspeed_spi_window *win =3D &windows[chip->cs];
>         int ret;
>
> +       /* No segment registers for the AST2400 SPI controller */
> +       if (aspi->data =3D=3D &ast2400_spi_data)
> +               return 0;
> +
>         /*
>          * Due to an HW issue on the AST2500 SPI controller, the CE0
>          * window size should be smaller than the maximum 128MB.
> @@ -539,6 +555,12 @@ static int aspeed_spi_dirmap_create(struct spi_mem_d=
irmap_desc *desc)
>                 else
>                         addr_mode &=3D ~(0x11 << chip->cs);
>                 writel(addr_mode, aspi->regs + CE_CTRL_REG);
> +
> +               /* AST2400 SPI controller sets 4BYTE address mode in
> +                * CE0 Control Register
> +                */
> +               if (op->addr.nbytes =3D=3D 4 && chip->aspi->data =3D=3D &=
ast2400_spi_data)
> +                       ctl_val |=3D CTRL_IO_ADDRESS_4B;
>         }
>
>         /* READ mode is the controller default setting */
> @@ -805,6 +827,14 @@ static const struct aspeed_spi_data ast2400_fmc_data=
 =3D {
>         .segment_reg   =3D aspeed_spi_segment_reg,
>  };
>
> +static const struct aspeed_spi_data ast2400_spi_data =3D {
> +       .max_cs        =3D 1,
> +       .hastype       =3D false,
> +       .we0           =3D 0,
> +       .ctl0          =3D 0x04,
> +       /* No segment registers */
> +};
> +
>  static const struct aspeed_spi_data ast2500_fmc_data =3D {
>         .max_cs        =3D 3,
>         .hastype       =3D true,
> @@ -849,6 +879,7 @@ static const struct aspeed_spi_data ast2600_spi_data =
=3D {
>
>  static const struct of_device_id aspeed_spi_matches[] =3D {
>         { .compatible =3D "aspeed,ast2400-fmc", .data =3D &ast2400_fmc_da=
ta },
> +       { .compatible =3D "aspeed,ast2400-spi", .data =3D &ast2400_spi_da=
ta },
>         { .compatible =3D "aspeed,ast2500-fmc", .data =3D &ast2500_fmc_da=
ta },
>         { .compatible =3D "aspeed,ast2500-spi", .data =3D &ast2500_spi_da=
ta },
>         { .compatible =3D "aspeed,ast2600-fmc", .data =3D &ast2600_fmc_da=
ta },
> --
> 2.34.1
>
