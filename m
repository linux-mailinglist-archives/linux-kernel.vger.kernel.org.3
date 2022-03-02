Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364C14CB28A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiCBWtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCBWtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:49:11 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B12532F3;
        Wed,  2 Mar 2022 14:48:16 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id c7so2578849qka.7;
        Wed, 02 Mar 2022 14:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U7HKj6OXNpn8w0FHPBjThBjt7E+v6QRWEFLnATeT8R8=;
        b=WLBMwCy66RwK5pcbN9MO2NlCO4R1IBn7Qs7xVB0w98jILthSuRoLP8XafWWl4uPv1O
         hVR0NCzTtmbukMx4/j2QaOu2Gjj2iacZYdj2peE2rq+d3x+v8oVqOqlqLMUnGuYW9n+9
         SZfkcjilAsboHEAwkHUUMgr9870oCc6/lY6vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U7HKj6OXNpn8w0FHPBjThBjt7E+v6QRWEFLnATeT8R8=;
        b=lAOdqCFItRjZIxNiSbB8dTwxOq8otj3dZKD240voHMCeJq9veeqf9fchN0HLHxw9od
         0vkLUDESRq55VSdWx9X/Ek+xEDbOGJWq6hR0D6j0yP9H6oZYx4fqjA/fbvI2yXMFrj2w
         OYGmYH25vsBHgI47Or3z4/dFvR7rdfa1gGKVNAv+YM2uxamWBmT40K0xY/2AVme9nVGO
         Pk5J4XrYpSWQ9W36rug6bSCVxjJFgljVMRB+sGx1X46calaLByT9Y733llQ50hKhoY8N
         A2t4lC2D2Rrbs+dBhLm5nFIAkCvz03hyKlg0Qs/e8YUh3zWJaEXratw3ohDrxTh+me1D
         B1Ng==
X-Gm-Message-State: AOAM5322tEvuVVlv40Eo0ba4x+saiCo+r7GZiwE3aTQsxbQzw0rvmLXg
        ndVW6lBR2Zil5eWjE5hggs5ESIZ84xVisSN4+vPvS+35FTZeFw==
X-Google-Smtp-Source: ABdhPJzOFpiKj2VhwTJ2xSllMVTELkSQmErEMVEuwhCU2F9Xv/VGI8RLN1xrDdWpjiIaIt7xtwDcqhD/+5tidY8BtQQ=
X-Received: by 2002:a37:a147:0:b0:47a:be0e:4a0c with SMTP id
 k68-20020a37a147000000b0047abe0e4a0cmr16940793qke.165.1646261292872; Wed, 02
 Mar 2022 14:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-6-clg@kaod.org>
In-Reply-To: <20220302173114.927476-6-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:48:00 +0000
Message-ID: <CACPK8Xfm+-6mELg4W0aybEzY76tyYe6jQc_nEwmy4tfRWzHbvw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] spi: aspeed: Add support for direct mapping
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
> Use direct mapping to read the flash device contents. This operation
> mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
> Control Register for the settings to apply when a memory operation is
> performed on the flash device mapping window.
>
> If the window is not big enough, fall back to the "User mode" to
> perform the read.
>
> Since direct mapping now handles all reads of the flash device
> contents, also use memcpy_fromio for other address spaces, such as
> SFDP.
>
> Direct mapping for writes will come later when validated.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 688f9472e0d7..b4854b521477 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -324,8 +324,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem,=
 const struct spi_mem_op *o
>                 if (!op->addr.nbytes)
>                         ret =3D aspeed_spi_read_reg(chip, op);
>                 else
> -                       ret =3D aspeed_spi_read_user(chip, op, op->addr.v=
al,
> -                                                  op->data.nbytes, op->d=
ata.buf.in);
> +                       memcpy_fromio(op->data.buf.in, chip->ahb_base + o=
p->addr.val,
> +                                     op->data.nbytes);
>         } else {
>                 if (!op->addr.nbytes)
>                         ret =3D aspeed_spi_write_reg(chip, op);
> @@ -405,10 +405,73 @@ static int aspeed_spi_chip_set_default_window(struc=
t aspeed_spi_chip *chip)
>         return chip->ahb_window_size ? 0 : -1;
>  }
>
> +static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
> +{
> +       struct aspeed_spi *aspi =3D spi_controller_get_devdata(desc->mem-=
>spi->master);
> +       struct aspeed_spi_chip *chip =3D &aspi->chips[desc->mem->spi->chi=
p_select];
> +       struct spi_mem_op *op =3D &desc->info.op_tmpl;
> +       u32 ctl_val;
> +       int ret =3D 0;
> +
> +       chip->clk_freq =3D desc->mem->spi->max_speed_hz;
> +
> +       /* Only for reads */
> +       if (op->data.dir !=3D SPI_MEM_DATA_IN)
> +               return -EOPNOTSUPP;
> +
> +       if (desc->info.length > chip->ahb_window_size)
> +               dev_warn(aspi->dev, "CE%d window (%dMB) too small for map=
ping",
> +                        chip->cs, chip->ahb_window_size >> 20);
> +
> +       /* Define the default IO read settings */
> +       ctl_val =3D readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
> +       ctl_val |=3D aspeed_spi_get_io_mode(op) |
> +               op->cmd.opcode << CTRL_COMMAND_SHIFT |
> +               CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) =
|
> +               CTRL_IO_MODE_READ;
> +
> +       /* Tune 4BYTE address mode */
> +       if (op->addr.nbytes) {
> +               u32 addr_mode =3D readl(aspi->regs + CE_CTRL_REG);
> +
> +               if (op->addr.nbytes =3D=3D 4)
> +                       addr_mode |=3D (0x11 << chip->cs);
> +               else
> +                       addr_mode &=3D ~(0x11 << chip->cs);
> +               writel(addr_mode, aspi->regs + CE_CTRL_REG);
> +       }
> +
> +       /* READ mode is the controller default setting */
> +       chip->ctl_val[ASPEED_SPI_READ] =3D ctl_val;
> +       writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
> +
> +       dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
> +                chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_RE=
AD]);
> +
> +       return ret;
> +}
> +
> +static int aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +                                 u64 offset, size_t len, void *buf)
> +{
> +       struct aspeed_spi *aspi =3D spi_controller_get_devdata(desc->mem-=
>spi->master);
> +       struct aspeed_spi_chip *chip =3D &aspi->chips[desc->mem->spi->chi=
p_select];
> +
> +       /* Switch to USER command mode if mapping window is too small */
> +       if (chip->ahb_window_size < offset + len)
> +               aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, l=
en, buf);
> +       else
> +               memcpy_fromio(buf, chip->ahb_base + offset, len);
> +
> +       return len;
> +}
> +
>  static const struct spi_controller_mem_ops aspeed_spi_mem_ops =3D {
>         .supports_op =3D aspeed_spi_supports_op,
>         .exec_op =3D aspeed_spi_exec_op,
>         .get_name =3D aspeed_spi_get_name,
> +       .dirmap_create =3D aspeed_spi_dirmap_create,
> +       .dirmap_read =3D aspeed_spi_dirmap_read,
>  };
>
>  static void aspeed_spi_chip_set_type(struct aspeed_spi *aspi, unsigned i=
nt cs, int type)
> --
> 2.34.1
>
