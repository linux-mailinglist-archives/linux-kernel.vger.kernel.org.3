Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10144CB272
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiCBWpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCBWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:45:20 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E0120E80;
        Wed,  2 Mar 2022 14:44:33 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d3so2740786qvb.5;
        Wed, 02 Mar 2022 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lu/jPg14h52ilfsaK3yG7n7UKRxXPoFKOGDtMJ0a0Vg=;
        b=eB4eRPC3bipDoafgs6UsA52p/R1atWU/iZDgbuFKq1xIt0fzUCKoz2wIOa+zygDCld
         e9czImxJS+ynFlerMQirnU/TCQoe7I1KQrK4TptaRxH+l/r4zGYQW5rksdZKYMGIYz9W
         uL647uy0ftQaeK1mydDtF0lGjkPMemxGobKwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lu/jPg14h52ilfsaK3yG7n7UKRxXPoFKOGDtMJ0a0Vg=;
        b=iVyWjmJnStqHofSU93df6fgAPzPRW4vwvqI3ddbK7hhG4jQExMExVcCexWqld6zGIc
         cXdMdiRZdc8VlYa7uwkAl1xelLaCagLdmRxZQy4r7y/MaTp0WUnGwVi5j7PLziIMXHdd
         snpz9UQ1o98iUxVpNbpfnVdAlDsZZAwLeEW66ZY4wNR4aoAUYJNz1RZRbIPeZV4XvWze
         1r6Vs7GKd+QiOAvt+AU2j0flVfHl1i90UQ+FIGa1Czc1EyexFZJrBJQEXxUqOdH7h5oR
         wkMSwtX84RC5sDrzNHUC+6Pep9kaVhTRPbRf+ZAOvfIwhiorE0SdOSd/A4a5wIOFP9xC
         e49A==
X-Gm-Message-State: AOAM530AL+FvS2NQ8MjOlgOq2IpBS2/n0+ucVnQNUVhSpV8QV9rFPzG7
        uMqNyerlVCvUs+GYzbRIh6Q27L5FBh8P2ROwDMA=
X-Google-Smtp-Source: ABdhPJwqfoYT7pF2cOO/yiSsEgYYAbjBfWP1b9cOYkEckOMVg36ijfEH6wOIRrgEJgrs074eMJuTyiRA4d1DsHDEVzk=
X-Received: by 2002:a05:6214:19c4:b0:432:8bd1:d8d7 with SMTP id
 j4-20020a05621419c400b004328bd1d8d7mr22503520qvc.65.1646261072217; Wed, 02
 Mar 2022 14:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-10-clg@kaod.org>
In-Reply-To: <20220302173114.927476-10-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:44:20 +0000
Message-ID: <CACPK8Xe8wc-z5ntfAfe96tMmq8eEvk0x60GG6jjc=F7BbU5xRQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] spi: aspeed: Calibrate read timings
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

On Wed, 2 Mar 2022 at 17:32, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> To accommodate the different response time of SPI transfers on different
> boards and different SPI NOR devices, the Aspeed controllers provide a
> set of Read Timing Compensation registers to tune the timing delays
> depending on the frequency being used. The AST2600 SoC has one of
> these registers per device. On the AST2500 and AST2400 SoCs, the
> timing register is shared by all devices which is a bit problematic to
> get good results other than for one device.
>
> The algorithm first reads a golden buffer at low speed and then performs
> reads with different clocks and delay cycle settings to find a breaking
> point. This selects a default good frequency for the CEx control register=
.
> The current settings are bit optimistic as we pick the first delay giving

typo: are a bit

> good results. A safer approach would be to determine an interval and
> choose the middle value.
>
> Calibration is performed when the direct mapping for reads is created.
> Since the underlying spi-nor object needs to be initialized to create
> the spi_mem operation for direct mapping, we should be fine. Having a
> specific API would clarify the requirements though.
>
> Cc: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
>  1 file changed, 281 insertions(+)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 8c6d7f79d97f..dce25dfe6913 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -35,6 +35,8 @@
>  #define   CTRL_IO_ADDRESS_4B           BIT(13) /* AST2400 SPI only */
>  #define   CTRL_IO_DUMMY_SET(dummy)                                     \
>         (((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
> +#define   CTRL_FREQ_SEL_SHIFT          8
> +#define   CTRL_FREQ_SEL_MASK           GENMASK(11, CTRL_FREQ_SEL_SHIFT)
>  #define   CTRL_CE_STOP_ACTIVE          BIT(2)
>  #define   CTRL_IO_MODE_CMD_MASK                GENMASK(1, 0)
>  #define   CTRL_IO_MODE_NORMAL          0x0
> @@ -47,6 +49,9 @@
>  /* CEx Address Decoding Range Register */
>  #define CE0_SEGMENT_ADDR_REG           0x30
>
> +/* CEx Read timing compensation register */
> +#define CE0_TIMING_COMPENSATION_REG    0x94
> +
>  enum aspeed_spi_ctl_reg_value {
>         ASPEED_SPI_BASE,
>         ASPEED_SPI_READ,
> @@ -72,10 +77,15 @@ struct aspeed_spi_data {
>         bool    hastype;
>         u32     mode_bits;
>         u32     we0;
> +       u32     timing;
> +       u32     hclk_mask;
> +       u32     hdiv_max;
>
>         u32 (*segment_start)(struct aspeed_spi *aspi, u32 reg);
>         u32 (*segment_end)(struct aspeed_spi *aspi, u32 reg);
>         u32 (*segment_reg)(struct aspeed_spi *aspi, u32 start, u32 end);
> +       int (*calibrate)(struct aspeed_spi_chip *chip, u32 hdiv,
> +                        const u8 *golden_buf, u8 *test_buf);
>  };
>
>  #define ASPEED_SPI_MAX_NUM_CS  5
> @@ -519,6 +529,8 @@ static int aspeed_spi_chip_adjust_window(struct aspee=
d_spi_chip *chip,
>         return 0;
>  }
>
> +static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
> +
>  static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>  {
>         struct aspeed_spi *aspi =3D spi_controller_get_devdata(desc->mem-=
>spi->master);
> @@ -567,6 +579,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_di=
rmap_desc *desc)
>         chip->ctl_val[ASPEED_SPI_READ] =3D ctl_val;
>         writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
>
> +       ret =3D aspeed_spi_do_calibration(chip);
> +
>         dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
>                  chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_RE=
AD]);
>
> @@ -814,6 +828,249 @@ static u32 aspeed_spi_segment_ast2600_reg(struct as=
peed_spi *aspi,
>                 ((end - 1) & AST2600_SEG_ADDR_MASK);
>  }
>
> +/*
> + * Read timing compensation sequences
> + */
> +
> +#define CALIBRATE_BUF_SIZE SZ_16K
> +
> +static bool aspeed_spi_check_reads(struct aspeed_spi_chip *chip,
> +                                  const u8 *golden_buf, u8 *test_buf)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < 10; i++) {
> +               memcpy_fromio(test_buf, chip->ahb_base, CALIBRATE_BUF_SIZ=
E);
> +               if (memcmp(test_buf, golden_buf, CALIBRATE_BUF_SIZE) !=3D=
 0) {
> +#if defined(VERBOSE_DEBUG)
> +                       print_hex_dump_bytes(DEVICE_NAME "  fail: ", DUMP=
_PREFIX_NONE,
> +                                            test_buf, 0x100);
> +#endif
> +                       return false;
> +               }
> +       }
> +       return true;
> +}
> +
> +#define FREAD_TPASS(i) (((i) / 2) | (((i) & 1) ? 0 : 8))
> +
> +/*
> + * The timing register is shared by all devices. Only update for CE0.
> + */
> +static int aspeed_spi_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
> +                               const u8 *golden_buf, u8 *test_buf)
> +{
> +       struct aspeed_spi *aspi =3D chip->aspi;
> +       const struct aspeed_spi_data *data =3D aspi->data;
> +       int i;
> +       int good_pass =3D -1, pass_count =3D 0;
> +       u32 shift =3D (hdiv - 1) << 2;
> +       u32 mask =3D ~(0xfu << shift);
> +       u32 fread_timing_val =3D 0;
> +
> +       /* Try HCLK delay 0..5, each one with/without delay and look for =
a
> +        * good pair.
> +        */
> +       for (i =3D 0; i < 12; i++) {
> +               bool pass;
> +
> +               if (chip->cs =3D=3D 0) {
> +                       fread_timing_val &=3D mask;
> +                       fread_timing_val |=3D FREAD_TPASS(i) << shift;
> +                       writel(fread_timing_val, aspi->regs + data->timin=
g);
> +               }
> +               pass =3D aspeed_spi_check_reads(chip, golden_buf, test_bu=
f);
> +               dev_dbg(aspi->dev,
> +                       "  * [%08x] %d HCLK delay, %dns DI delay : %s",
> +                       fread_timing_val, i / 2, (i & 1) ? 0 : 4,
> +                       pass ? "PASS" : "FAIL");
> +               if (pass) {
> +                       pass_count++;
> +                       if (pass_count =3D=3D 3) {
> +                               good_pass =3D i - 1;
> +                               break;
> +                       }
> +               } else {
> +                       pass_count =3D 0;
> +               }
> +       }
> +
> +       /* No good setting for this frequency */
> +       if (good_pass < 0)
> +               return -1;
> +
> +       /* We have at least one pass of margin, let's use first pass */
> +       if (chip->cs =3D=3D 0) {
> +               fread_timing_val &=3D mask;
> +               fread_timing_val |=3D FREAD_TPASS(good_pass) << shift;
> +               writel(fread_timing_val, aspi->regs + data->timing);
> +       }
> +       dev_dbg(aspi->dev, " * -> good is pass %d [0x%08x]",
> +               good_pass, fread_timing_val);
> +       return 0;
> +}
> +
> +static bool aspeed_spi_check_calib_data(const u8 *test_buf, u32 size)
> +{
> +       const u32 *tb32 =3D (const u32 *)test_buf;
> +       u32 i, cnt =3D 0;
> +
> +       /* We check if we have enough words that are neither all 0
> +        * nor all 1's so the calibration can be considered valid.
> +        *
> +        * I use an arbitrary threshold for now of 64
> +        */
> +       size >>=3D 2;
> +       for (i =3D 0; i < size; i++) {
> +               if (tb32[i] !=3D 0 && tb32[i] !=3D 0xffffffff)
> +                       cnt++;
> +       }
> +       return cnt >=3D 64;
> +}
> +
> +static const u32 aspeed_spi_hclk_divs[] =3D {
> +       0xf, /* HCLK */
> +       0x7, /* HCLK/2 */
> +       0xe, /* HCLK/3 */
> +       0x6, /* HCLK/4 */
> +       0xd, /* HCLK/5 */
> +};
> +
> +#define ASPEED_SPI_HCLK_DIV(i) \
> +       (aspeed_spi_hclk_divs[(i) - 1] << CTRL_FREQ_SEL_SHIFT)
> +
> +static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
> +{
> +       struct aspeed_spi *aspi =3D chip->aspi;
> +       const struct aspeed_spi_data *data =3D aspi->data;
> +       u32 ahb_freq =3D aspi->clk_freq;
> +       u32 max_freq =3D chip->clk_freq;
> +       u32 ctl_val;
> +       u8 *golden_buf =3D NULL;
> +       u8 *test_buf =3D NULL;
> +       int i, rc, best_div =3D -1;
> +
> +       dev_dbg(aspi->dev, "calculate timing compensation - AHB freq: %d =
MHz",
> +               ahb_freq / 1000000);
> +
> +       /*
> +        * use the related low frequency to get check calibration data
> +        * and get golden data.
> +        */
> +       ctl_val =3D chip->ctl_val[ASPEED_SPI_READ] & data->hclk_mask;
> +       writel(ctl_val, chip->ctl);
> +
> +       test_buf =3D kzalloc(CALIBRATE_BUF_SIZE * 2, GFP_KERNEL);
> +       if (!test_buf)
> +               return -ENOMEM;
> +
> +       golden_buf =3D test_buf + CALIBRATE_BUF_SIZE;
> +
> +       memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
> +       if (!aspeed_spi_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE))=
 {
> +               dev_info(aspi->dev, "Calibration area too uniform, using =
low speed");
> +               goto no_calib;
> +       }
> +
> +#if defined(VERBOSE_DEBUG)
> +       print_hex_dump_bytes(DEVICE_NAME "  good: ", DUMP_PREFIX_NONE,
> +                            golden_buf, 0x100);
> +#endif
> +
> +       /* Now we iterate the HCLK dividers until we find our breaking po=
int */
> +       for (i =3D ARRAY_SIZE(aspeed_spi_hclk_divs); i > data->hdiv_max -=
 1; i--) {
> +               u32 tv, freq;
> +
> +               freq =3D ahb_freq / i;
> +               if (freq > max_freq)
> +                       continue;
> +
> +               /* Set the timing */
> +               tv =3D chip->ctl_val[ASPEED_SPI_READ] | ASPEED_SPI_HCLK_D=
IV(i);
> +               writel(tv, chip->ctl);
> +               dev_dbg(aspi->dev, "Trying HCLK/%d [%08x] ...", i, tv);
> +               rc =3D data->calibrate(chip, i, golden_buf, test_buf);
> +               if (rc =3D=3D 0)
> +                       best_div =3D i;
> +       }
> +
> +       /* Nothing found ? */
> +       if (best_div < 0) {
> +               dev_warn(aspi->dev, "No good frequency, using dumb slow")=
;
> +       } else {
> +               dev_dbg(aspi->dev, "Found good read timings at HCLK/%d", =
best_div);
> +
> +               /* Record the freq */
> +               for (i =3D 0; i < ASPEED_SPI_MAX; i++)
> +                       chip->ctl_val[i] =3D (chip->ctl_val[i] & data->hc=
lk_mask) |
> +                               ASPEED_SPI_HCLK_DIV(best_div);
> +       }
> +
> +no_calib:
> +       writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
> +       kfree(test_buf);
> +       return 0;
> +}
> +
> +#define TIMING_DELAY_DI                BIT(3)
> +#define TIMING_DELAY_HCYCLE_MAX        5
> +#define TIMING_REG_AST2600(chip)                               \
> +       ((chip)->aspi->regs + (chip)->aspi->data->timing +      \
> +        (chip)->cs * 4)
> +
> +static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u3=
2 hdiv,
> +                                       const u8 *golden_buf, u8 *test_bu=
f)
> +{
> +       struct aspeed_spi *aspi =3D chip->aspi;
> +       int hcycle;
> +       u32 shift =3D (hdiv - 2) << 3;
> +       u32 mask =3D ~(0xfu << shift);
> +       u32 fread_timing_val =3D 0;
> +
> +       for (hcycle =3D 0; hcycle <=3D TIMING_DELAY_HCYCLE_MAX; hcycle++)=
 {
> +               int delay_ns;
> +               bool pass =3D false;
> +
> +               fread_timing_val &=3D mask;
> +               fread_timing_val |=3D hcycle << shift;
> +
> +               /* no DI input delay first  */
> +               writel(fread_timing_val, TIMING_REG_AST2600(chip));
> +               pass =3D aspeed_spi_check_reads(chip, golden_buf, test_bu=
f);
> +               dev_dbg(aspi->dev,
> +                       "  * [%08x] %d HCLK delay, DI delay none : %s",
> +                       fread_timing_val, hcycle, pass ? "PASS" : "FAIL")=
;
> +               if (pass)
> +                       return 0;
> +
> +               /* Add DI input delays  */
> +               fread_timing_val &=3D mask;
> +               fread_timing_val |=3D (TIMING_DELAY_DI | hcycle) << shift=
;
> +
> +               for (delay_ns =3D 0; delay_ns < 0x10; delay_ns++) {
> +                       fread_timing_val &=3D ~(0xf << (4 + shift));
> +                       fread_timing_val |=3D delay_ns << (4 + shift);
> +
> +                       writel(fread_timing_val, TIMING_REG_AST2600(chip)=
);
> +                       pass =3D aspeed_spi_check_reads(chip, golden_buf,=
 test_buf);
> +                       dev_dbg(aspi->dev,
> +                               "  * [%08x] %d HCLK delay, DI delay %d.%d=
ns : %s",
> +                               fread_timing_val, hcycle, (delay_ns + 1) =
/ 2,
> +                               (delay_ns + 1) & 1 ? 5 : 5, pass ? "PASS"=
 : "FAIL");
> +                       /*
> +                        * TODO: This is optimistic. We should look
> +                        * for a working interval and save the middle
> +                        * value in the read timing register.
> +                        */
> +                       if (pass)
> +                               return 0;
> +               }
> +       }
> +
> +       /* No good setting for this frequency */
> +       return -1;
> +}
> +
>  /*
>   * Platform definitions
>   */
> @@ -822,6 +1079,10 @@ static const struct aspeed_spi_data ast2400_fmc_dat=
a =3D {
>         .hastype       =3D true,
>         .we0           =3D 16,
>         .ctl0          =3D CE0_CTRL_REG,
> +       .timing        =3D CE0_TIMING_COMPENSATION_REG,
> +       .hclk_mask     =3D 0xfffff0ff,
> +       .hdiv_max      =3D 1,
> +       .calibrate     =3D aspeed_spi_calibrate,
>         .segment_start =3D aspeed_spi_segment_start,
>         .segment_end   =3D aspeed_spi_segment_end,
>         .segment_reg   =3D aspeed_spi_segment_reg,
> @@ -832,6 +1093,10 @@ static const struct aspeed_spi_data ast2400_spi_dat=
a =3D {
>         .hastype       =3D false,
>         .we0           =3D 0,
>         .ctl0          =3D 0x04,
> +       .timing        =3D 0x14,
> +       .hclk_mask     =3D 0xfffff0ff,
> +       .hdiv_max      =3D 1,
> +       .calibrate     =3D aspeed_spi_calibrate,
>         /* No segment registers */
>  };
>
> @@ -840,6 +1105,10 @@ static const struct aspeed_spi_data ast2500_fmc_dat=
a =3D {
>         .hastype       =3D true,
>         .we0           =3D 16,
>         .ctl0          =3D CE0_CTRL_REG,
> +       .timing        =3D CE0_TIMING_COMPENSATION_REG,
> +       .hclk_mask     =3D 0xfffff0ff,
> +       .hdiv_max      =3D 1,
> +       .calibrate     =3D aspeed_spi_calibrate,
>         .segment_start =3D aspeed_spi_segment_start,
>         .segment_end   =3D aspeed_spi_segment_end,
>         .segment_reg   =3D aspeed_spi_segment_reg,
> @@ -850,6 +1119,10 @@ static const struct aspeed_spi_data ast2500_spi_dat=
a =3D {
>         .hastype       =3D false,
>         .we0           =3D 16,
>         .ctl0          =3D CE0_CTRL_REG,
> +       .timing        =3D CE0_TIMING_COMPENSATION_REG,
> +       .hclk_mask     =3D 0xfffff0ff,
> +       .hdiv_max      =3D 1,
> +       .calibrate     =3D aspeed_spi_calibrate,
>         .segment_start =3D aspeed_spi_segment_start,
>         .segment_end   =3D aspeed_spi_segment_end,
>         .segment_reg   =3D aspeed_spi_segment_reg,
> @@ -861,6 +1134,10 @@ static const struct aspeed_spi_data ast2600_fmc_dat=
a =3D {
>         .mode_bits     =3D SPI_RX_QUAD | SPI_RX_QUAD,
>         .we0           =3D 16,
>         .ctl0          =3D CE0_CTRL_REG,
> +       .timing        =3D CE0_TIMING_COMPENSATION_REG,
> +       .hclk_mask     =3D 0xf0fff0ff,
> +       .hdiv_max      =3D 2,
> +       .calibrate     =3D aspeed_spi_ast2600_calibrate,
>         .segment_start =3D aspeed_spi_segment_ast2600_start,
>         .segment_end   =3D aspeed_spi_segment_ast2600_end,
>         .segment_reg   =3D aspeed_spi_segment_ast2600_reg,
> @@ -872,6 +1149,10 @@ static const struct aspeed_spi_data ast2600_spi_dat=
a =3D {
>         .mode_bits     =3D SPI_RX_QUAD | SPI_RX_QUAD,
>         .we0           =3D 16,
>         .ctl0          =3D CE0_CTRL_REG,
> +       .timing        =3D CE0_TIMING_COMPENSATION_REG,
> +       .hclk_mask     =3D 0xf0fff0ff,
> +       .hdiv_max      =3D 2,
> +       .calibrate     =3D aspeed_spi_ast2600_calibrate,
>         .segment_start =3D aspeed_spi_segment_ast2600_start,
>         .segment_end   =3D aspeed_spi_segment_ast2600_end,
>         .segment_reg   =3D aspeed_spi_segment_ast2600_reg,
> --
> 2.34.1
>
