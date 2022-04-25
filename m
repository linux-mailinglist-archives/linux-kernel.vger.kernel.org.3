Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A0E50E4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiDYQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYQBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:01:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402E11483F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:58:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w16so9244720ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAi15D3GhuHW3k/SY019JP8Na1Ol7Z0uk5/P0huRAEw=;
        b=m75VZP1RMkzwXq1zomlowNKRoidLMaL9RSFHtBODlDYhS/6Sy4Qws5AFvWHmilxZc+
         4tPsKpVEBYQxkUdVwhZU4D3Mcu6UOrsC5ugP6MYpPLBq1extFrTzBzyDNU80Z17h3A9G
         pEDcq/3nwn2wxejJXz68Imuu9QCi+LmTbcPjkLjseRmC/C3AMrpybNEt/z5/6x6wVOVX
         /goLqde3nsqV4mnMMoA6ogAM6Ls7BrMs3mwXJxC7ThOtQ9E3EYIJ1Y9QaWrHb8jiW4oO
         ZrueHebT2aQ2NyixNSvsJ5mPkrvtEbDm1BmWyh2GOoN4+IKqTP3PsgmqGCtbZOXWBaCy
         1aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAi15D3GhuHW3k/SY019JP8Na1Ol7Z0uk5/P0huRAEw=;
        b=mswSTx7ZsZaAQsaz0xecePX4bXwp8UpUZ7HqjaA1vRtVv3t2ckLfIq+KjhgJJUgcU6
         5ALvO77CHoHuPSsSd1L7X+Mp3/fCGML42Q2OF3O+/ixPf5+IyJ2iXDFtkhwuFbIVyRks
         LQaI+byzPjfkhQhBFhInaoxiqODy9YH7YB6QD6wVajPIvkxVqr0ijN/QoEtueF+lDjAY
         m9uZ6k2xAk2daEtayOc/3xyLcNVFyEPawMynDMWNPsCSr8Tm6U1usUaz8lgkaHeyRAEX
         PdHkr/Rc1IhYtOUWMquXqlLV0ElRoATnDx4YjM7g8aZ87aDL2n7avEFEqoF9CW1d+Pjp
         L7Gw==
X-Gm-Message-State: AOAM533Vjy08nImugApKTKjxFMFjSpYCfu8YlxYLycG1+9Q5t9O47brr
        YSg2d1M6O3yJLaeWnI0QLsqYDDEvEQg9LObxCYEKvQ==
X-Google-Smtp-Source: ABdhPJzx5ZKMZ8spKsBXIVIg53wp5DlMINjg/uvb8HCfcpJZhZqLSLQJ6d0zZeWH0KNm+0OZVSkGxyz7JZqTe67GArw=
X-Received: by 2002:a17:907:c1b:b0:6f0:1335:6fb with SMTP id
 ga27-20020a1709070c1b00b006f0133506fbmr17252045ejc.294.1650902309072; Mon, 25
 Apr 2022 08:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com> <20220412135534.2796158-4-aford173@gmail.com>
In-Reply-To: <20220412135534.2796158-4-aford173@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 25 Apr 2022 16:58:13 +0100
Message-ID: <CAPY8ntCfL=ZPwPr_1N-m_J1FTq+V77-3fggY-joZCyyu-k_qvQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] media: i2c: imx219: Enable variable XCLK
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tim Harvey <tharvey@gateworks.com>,
        cstevens@beaconembedded.com, aford@beaconembedded.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam

I have no way of testing with an alternate XCLK value, so I'm working
based on the datasheet only.

On Tue, 12 Apr 2022 at 14:55, Adam Ford <aford173@gmail.com> wrote:
>
> The datasheet shows the external clock can be anything
> from 6MHz to 27MHz, but EXCK, PREPLLCK_VT_DIV and
> PREPLLCK_OP_DIV need to change based on the clock, so
> create helper functions to set these registers based on
> the rate of xclk.
>
> Move the validation of the clock rate into imx219_check_hwcfg
> which means delaying the call to it until after xclk has been
> determined.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/media/i2c/imx219.c | 79 ++++++++++++++++++++++++++++++--------
>  1 file changed, 63 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index d13ce5c1ece6..08e7d0e72430 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -39,8 +39,12 @@
>  #define IMX219_REG_CHIP_ID             0x0000
>  #define IMX219_CHIP_ID                 0x0219
>
> -/* External clock frequency is 24.0M */
> -#define IMX219_XCLK_FREQ               24000000
> +/* Default external clock frequency is 24.0M */
> +#define IMX219_XCLK_MIN_FREQ           6000000
> +#define IMX219_XCLK_MAX_FREQ           27000000
> +#define IMX219_REG_EXCK                        0x012a
> +#define IMX219_REG_PREPLLCK_VT_DIV     0x0304
> +#define IMX219_REG_PREPLLCK_OP_DIV     0x0305
>
>  /* Pixel rate is fixed for all the modes */
>  #define IMX219_PIXEL_RATE              182400000
> @@ -166,8 +170,6 @@ static const struct imx219_reg pll_clk_table[] = {
>
>         {0x0301, 0x05}, /* VTPXCK_DIV */
>         {0x0303, 0x01}, /* VTSYSCK_DIV */
> -       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> -       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
>         {0x0306, 0x00}, /* PLL_VT_MPY */
>         {0x0307, 0x39},
>         {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> @@ -182,7 +184,6 @@ static const struct imx219_reg pll_clk_table[] = {
>   */
>  static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x0128, 0x00},
> -       {0x012a, 0x18},
>         {0x012b, 0x00},
>         {0x0164, 0x00},
>         {0x0165, 0x00},
> @@ -222,7 +223,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
>
>  static const struct imx219_reg mode_1920_1080_regs[] = {
>         {0x0128, 0x00},
> -       {0x012a, 0x18},
>         {0x012b, 0x00},
>         {0x0162, 0x0d},
>         {0x0163, 0x78},
> @@ -262,7 +262,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
>
>  static const struct imx219_reg mode_1640_1232_regs[] = {
>         {0x0128, 0x00},
> -       {0x012a, 0x18},
>         {0x012b, 0x00},
>         {0x0164, 0x00},
>         {0x0165, 0x00},
> @@ -302,7 +301,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>
>  static const struct imx219_reg mode_640_480_regs[] = {
>         {0x0128, 0x00},
> -       {0x012a, 0x18},
>         {0x012b, 0x00},
>         {0x0162, 0x0d},
>         {0x0163, 0x78},
> @@ -1015,6 +1013,50 @@ static int imx219_configure_lanes(struct imx219 *imx219)
>         return ret;
>  };
>
> +static int imx219_set_exck_freq(struct imx219 *imx219)
> +{
> +       int ret;
> +       /* The imx219 registers need MHz not Hz */
> +       u8 clk = (u8) (imx219->xclk_freq/1000000U);
> +
> +       /* Set the clock frequency in MHz */
> +       ret = imx219_write_reg(imx219, IMX219_REG_EXCK,
> +                              IMX219_REG_VALUE_08BIT, clk);
> +
> +       /* Configure the PREPLLCK_VT_DIV and PREPLLCK_OP_DIV for automatic */
> +       switch (clk) {
> +       case 6 ... 11:
> +               ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_VT_DIV,
> +                              IMX219_REG_VALUE_08BIT, 0x01);
> +               if (ret)
> +                       return ret;
> +               ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_OP_DIV,
> +                              IMX219_REG_VALUE_08BIT, 0x01);
> +               return ret;
> +       case 12 ... 23:
> +               ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_VT_DIV,
> +                              IMX219_REG_VALUE_08BIT, 0x02);
> +               if (ret)
> +                       return ret;
> +
> +               ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_OP_DIV,
> +                              IMX219_REG_VALUE_08BIT, 0x02);
> +
> +               return ret;
> +       case 24 ... 27:
> +               ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_VT_DIV,
> +                              IMX219_REG_VALUE_08BIT, 0x03);
> +               if (ret)
> +                       return ret;
> +               ret = imx219_write_reg(imx219, IMX219_REG_PREPLLCK_OP_DIV,
> +                              IMX219_REG_VALUE_08BIT, 0x03);
> +               return ret;
> +       default:
> +               /* Should never get here */
> +               return -EINVAL;
> +       }
> +}
> +
>  static int imx219_start_streaming(struct imx219 *imx219)
>  {
>         struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
> @@ -1039,6 +1081,9 @@ static int imx219_start_streaming(struct imx219 *imx219)
>                 goto err_rpm_put;
>         }
>
> +       /* Configure clock based on reference clock frequency */
> +       imx219_set_exck_freq(imx219);

You're not checking the return value from this function, so any I2C
failures will be ignored.

> +
>         /* Apply default values of current mode */
>         reg_list = &imx219->mode->reg_list;
>         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> @@ -1428,6 +1473,13 @@ static int imx219_check_hwcfg(struct imx219 *imx219)
>                 return -EINVAL;
>         }
>
> +       if ((imx219->xclk_freq < IMX219_XCLK_MIN_FREQ) ||
> +            imx219->xclk_freq > IMX219_XCLK_MAX_FREQ) {
> +               dev_err(&client->dev, "xclk frequency not supported: %d Hz\n",

imx219->xclk_freq is unsigned, so %u

> +                       imx219->xclk_freq);
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
> @@ -1478,10 +1530,6 @@ static int imx219_probe(struct i2c_client *client)
>         if (ret)
>                 return ret;
>
> -       /* Check the hardware configuration in device tree */
> -       if (imx219_check_hwcfg(imx219))
> -               return -EINVAL;
> -
>         /* Get system clock (xclk) */
>         imx219->xclk = devm_clk_get(dev, NULL);
>         if (IS_ERR(imx219->xclk)) {
> @@ -1490,11 +1538,10 @@ static int imx219_probe(struct i2c_client *client)
>         }
>
>         imx219->xclk_freq = clk_get_rate(imx219->xclk);

My bug admittedly, but clk_get_rate returns an unsigned long, but
imx219->xclk_freq is u32.
Ideally imx219->xclk_freq should be unsigned long to match, and the
dev_err I commented on earlier should be %lu.

Cheers.
  Dave

> -       if (imx219->xclk_freq != IMX219_XCLK_FREQ) {
> -               dev_err(dev, "xclk frequency not supported: %d Hz\n",
> -                       imx219->xclk_freq);
> +
> +       /* Check the hardware configuration in device tree */
> +       if (imx219_check_hwcfg(imx219))
>                 return -EINVAL;
> -       }
>
>         ret = imx219_get_regulators(imx219);
>         if (ret) {
> --
> 2.34.1
>
