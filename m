Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB684CB25E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiCBWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiCBWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:32:54 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F1EA747;
        Wed,  2 Mar 2022 14:32:10 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id f18so3077949qtb.3;
        Wed, 02 Mar 2022 14:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5wkcZfN4pZ3a3l+3rbDL3hrP2CqpjYo6641YbuD1Z7Y=;
        b=VL8GKslkQfyhvjQaT0mMN7BaIwmwFq6sacRCmQHljoQBA+THJ2vLpspjYcX9md1xBh
         7Lx71zUGLAqELrHktKtYMZ6c5rddsL/B6uzoCbrYu+ZgogUpnaN090340zyTGohsd7uf
         8kWEeBScAb+bXOLZWfG7EA2lSEpJzE2Vs4WjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5wkcZfN4pZ3a3l+3rbDL3hrP2CqpjYo6641YbuD1Z7Y=;
        b=M6bShvz7WAVy+Wz/K0puFguUKCUDV2rg0h0QzPfPPJtGISfduPtfanDhTMucPG7t+G
         zRyk/5/ZlkaFB/soVhJV3yiC/UAVWUfZaHPadwJYeBNbVpdr4bJ3q932oCZVGGtzN54l
         gop5qRJRoAAu0I3UzXYNcSD7p63FiFEFO7LZ2q113G59aawzS6l93IsFt5Ah6uIiTH77
         1yG7v9G1ElKUMNzlGC0um4eG/ep8jh2x4fH/iBodadngq1UDi4RC1z7zHZYv3/RYIrUo
         03b91iqakoJarxt0oXmwD/0VOtq8j7R8u7MWJp0jhqUdobpcRmKV+ZNI8Xv8CbF6u2pJ
         u8sA==
X-Gm-Message-State: AOAM533j1W+rUDsTyKEvke6CUcjTcL3+Q6E8pI0HxB1Vc1EGVNdOEYRF
        o66LRfzRknOgxzyT1llfDczzaTxdyJ7byiWGvGw=
X-Google-Smtp-Source: ABdhPJzK4E9ZGkEhZzJG/1AYJMAeIbckwug2MSrPNlKv7JtSbd1wBW8lAKw6pABzthZinle3fGhjVs7GZ4i+xiYUEws=
X-Received: by 2002:ac8:5d89:0:b0:2df:f357:c681 with SMTP id
 d9-20020ac85d89000000b002dff357c681mr18831790qtx.475.1646260329845; Wed, 02
 Mar 2022 14:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-7-clg@kaod.org>
In-Reply-To: <20220302173114.927476-7-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:31:57 +0000
Message-ID: <CACPK8XcAaQWdNqEJ3f2ko0wCuAwxptkY2EncV7A2TouWzd8cWA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] spi: aspeed: Adjust direct mapping to device size
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
> The segment registers of the FMC/SPI controllers provide a way to
> configure the mapping window of the flash device contents on the AHB
> bus. Adjust this window to the size of the spi-mem mapping.
>
> Things get more complex with multiple devices. The driver needs to
> also adjust the window of the next device to make sure that there is
> no overlap, even if there is no available device. The proposal below
> is not perfect but it is covering all the cases we have seen on
> different boards with one and two devices on the same bus.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 88 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index b4854b521477..974ab215ec34 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -405,6 +405,92 @@ static int aspeed_spi_chip_set_default_window(struct=
 aspeed_spi_chip *chip)
>         return chip->ahb_window_size ? 0 : -1;
>  }
>
> +static int aspeed_spi_set_window(struct aspeed_spi *aspi,
> +                                const struct aspeed_spi_window *win)
> +{
> +       u32 start =3D aspi->ahb_base_phy + win->offset;
> +       u32 end =3D start + win->size;
> +       void __iomem *seg_reg =3D aspi->regs + CE0_SEGMENT_ADDR_REG + win=
->cs * 4;
> +       u32 seg_val_backup =3D readl(seg_reg);
> +       u32 seg_val =3D aspi->data->segment_reg(aspi, start, end);
> +
> +       if (seg_val =3D=3D seg_val_backup)
> +               return 0;
> +
> +       writel(seg_val, seg_reg);
> +
> +       /*
> +        * Restore initial value if something goes wrong else we could
> +        * loose access to the chip.
> +        */
> +       if (seg_val !=3D readl(seg_reg)) {
> +               dev_err(aspi->dev, "CE%d invalid window [ 0x%.8x - 0x%.8x=
 ] %dMB",
> +                       win->cs, start, end - 1, win->size >> 20);
> +               writel(seg_val_backup, seg_reg);
> +               return -EIO;
> +       }
> +
> +       if (win->size)
> +               dev_dbg(aspi->dev, "CE%d new window [ 0x%.8x - 0x%.8x ] %=
dMB",
> +                       win->cs, start, end - 1,  win->size >> 20);
> +       else
> +               dev_dbg(aspi->dev, "CE%d window closed", win->cs);
> +
> +       return 0;
> +}
> +
> +/*
> + * Yet to be done when possible :
> + * - Align mappings on flash size (we don't have the info)
> + * - ioremap each window, not strictly necessary since the overall windo=
w
> + *   is correct.
> + */
> +static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
> +                                        u32 local_offset, u32 size)
> +{
> +       struct aspeed_spi *aspi =3D chip->aspi;
> +       struct aspeed_spi_window windows[ASPEED_SPI_MAX_NUM_CS] =3D { 0 }=
;
> +       struct aspeed_spi_window *win =3D &windows[chip->cs];
> +       int ret;
> +
> +       aspeed_spi_get_windows(aspi, windows);
> +
> +       /* Adjust this chip window */
> +       win->offset +=3D local_offset;
> +       win->size =3D size;
> +
> +       if (win->offset + win->size > aspi->ahb_window_size) {
> +               win->size =3D aspi->ahb_window_size - win->offset;
> +               dev_warn(aspi->dev, "CE%d window resized to %dMB", chip->=
cs, win->size >> 20);
> +       }
> +
> +       ret =3D aspeed_spi_set_window(aspi, win);
> +       if (ret)
> +               return ret;
> +
> +       /* Update chip mapping info */
> +       chip->ahb_base =3D aspi->ahb_base + win->offset;
> +       chip->ahb_window_size =3D win->size;
> +
> +       /*
> +        * Also adjust next chip window to make sure that it does not
> +        * overlap with the current window.
> +        */
> +       if (chip->cs < aspi->data->max_cs - 1) {
> +               struct aspeed_spi_window *next =3D &windows[chip->cs + 1]=
;
> +
> +               /* Change offset and size to keep the same end address */
> +               if ((next->offset + next->size) > (win->offset + win->siz=
e))
> +                       next->size =3D (next->offset + next->size) - (win=
->offset + win->size);
> +               else
> +                       next->size =3D 0;
> +               next->offset =3D win->offset + win->size;
> +
> +               aspeed_spi_set_window(aspi, next);
> +       }
> +       return 0;
> +}
> +
>  static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  {
>         struct aspeed_spi *aspi =3D spi_controller_get_devdata(desc->mem-=
>spi->master);
> @@ -419,6 +505,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_di=
rmap_desc *desc)
>         if (op->data.dir !=3D SPI_MEM_DATA_IN)
>                 return -EOPNOTSUPP;
>
> +       aspeed_spi_chip_adjust_window(chip, desc->info.offset, desc->info=
.length);
> +
>         if (desc->info.length > chip->ahb_window_size)
>                 dev_warn(aspi->dev, "CE%d window (%dMB) too small for map=
ping",
>                          chip->cs, chip->ahb_window_size >> 20);
> --
> 2.34.1
>
