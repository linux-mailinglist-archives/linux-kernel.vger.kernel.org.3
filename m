Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82250E52D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbiDYQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiDYQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:10:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F6A3D4A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:07:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d6so13925510ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXSnvoi7do4d0Cw+AqoAw/T18ZVUWnuc6GpNpfIH19c=;
        b=BR68WEsUU9ruE04R4C4gbsu8wC2yAPqXm017Rao0x8cacuQmHe1eOgwJYKQH0jzmJ4
         oSoRBzz29bJ22lqPwFCiuv9ainoLDkhAoTNF70iaDOAtzBhgznhbLlCNdb9Hrycbb9EL
         4ujvLSOQApuUAw63cRM6u13KDYE7yArbn4czXZ3YuO9FgPuZibXY9I2/GQ4Mb/1fKmBi
         TTFrbSSgUcVj1aNVfjRAHtZKI3FdxztPvsSAXKpAMZq688yfX6ERkW1zarAtgeHX58Zq
         GxdRR3qL4JXJx3KJpxrzpGshXdOwjVLhpaMlcKYb76RCssgP6EmhJLx/s1Y6NJRpkhY5
         T2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXSnvoi7do4d0Cw+AqoAw/T18ZVUWnuc6GpNpfIH19c=;
        b=2nXaDVwmqMthq3rpbacvwNgekVDrMh9P7BAbEdNKvL2xT2sAtHtWty/QR+4+8QgS+7
         NGK2+fYfIcWdvDZ6xl+EokTdEbHVEIJF02+98E5Upu+SliYKKXTIcczlddluY0i9MzqB
         RDDgIzB5+kViBk3GD07atGM4BrB8yb8Z+0EOLZze8HyWeJHZ1kY50hOaBzoBUbAb8WUL
         zHy0QpTR/EuT8+pxSwegmpz8b2zUKujrRjKKSw+obbf9BvcoBmYmw/wZfGj/L16are0x
         o8sv382D4aK8aBi1c8+k1+Ona2g9HY07WgvLnswEyON94wHJypSTO6G8jgcvYLMpuGAV
         53PA==
X-Gm-Message-State: AOAM533Dcvp1y96U4dgXelZCd/516kfB7HaiSRwLe5q5qU2kLWc2mLS4
        7O8KyyKtuzvTNsJSURtKprwZiyRm78c8RGGrKv6zzA==
X-Google-Smtp-Source: ABdhPJwhiteEqaKegPnzPkmDW2Lw00gDy5cmL0DM91noXMDgC0CtFdV2JeuzqnvNaPwoZFBMzqyNSDxSdoQXlgKtqmA=
X-Received: by 2002:a50:d08b:0:b0:425:eb86:f36d with SMTP id
 v11-20020a50d08b000000b00425eb86f36dmr5027784edd.235.1650902842151; Mon, 25
 Apr 2022 09:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com> <20220412135534.2796158-5-aford173@gmail.com>
In-Reply-To: <20220412135534.2796158-5-aford173@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 25 Apr 2022 17:07:06 +0100
Message-ID: <CAPY8ntD+HqQLeb=Z4du2X==22yBzkfqpGEjo_v6=W1zFU1F2Ow@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: i2c: imx219: Create DPHY helper function
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

On Tue, 12 Apr 2022 at 14:55, Adam Ford <aford173@gmail.com> wrote:
>
> In the table of modes, each mode sets the DPHY to auto.
> Create a helper function which does the same thing while
> removing the entry for auto DPHY from ever mode entry.

s/ever/every

>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/media/i2c/imx219.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 08e7d0e72430..bb0bc1b8d91c 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -35,6 +35,10 @@
>  #define IMX219_MODE_STANDBY            0x00
>  #define IMX219_MODE_STREAMING          0x01
>
> +
> +#define IMX219_REG_DPHY_CTRL           0x0128
> +#define IMX219_DPHY_AUTO               0
> +
>  /* Chip ID */
>  #define IMX219_REG_CHIP_ID             0x0000
>  #define IMX219_CHIP_ID                 0x0219
> @@ -183,7 +187,6 @@ static const struct imx219_reg pll_clk_table[] = {
>   * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
>   */
>  static const struct imx219_reg mode_3280x2464_regs[] = {
> -       {0x0128, 0x00},
>         {0x012b, 0x00},
>         {0x0164, 0x00},
>         {0x0165, 0x00},
> @@ -222,7 +225,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
>  };
>
>  static const struct imx219_reg mode_1920_1080_regs[] = {
> -       {0x0128, 0x00},
>         {0x012b, 0x00},
>         {0x0162, 0x0d},
>         {0x0163, 0x78},
> @@ -261,7 +263,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
>  };
>
>  static const struct imx219_reg mode_1640_1232_regs[] = {
> -       {0x0128, 0x00},
>         {0x012b, 0x00},
>         {0x0164, 0x00},
>         {0x0165, 0x00},
> @@ -300,7 +301,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>  };
>
>  static const struct imx219_reg mode_640_480_regs[] = {
> -       {0x0128, 0x00},
>         {0x012b, 0x00},
>         {0x0162, 0x0d},
>         {0x0163, 0x78},
> @@ -999,6 +999,15 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
>         return -EINVAL;
>  }
>
> +static int imx219_enable_dphy(struct imx219 *imx219, u8 mode)
> +{
> +       int ret;
> +
> +       ret = imx219_write_reg(imx219, IMX219_REG_DPHY_CTRL,
> +                              IMX219_REG_VALUE_08BIT, mode);

Is there a specific reason to extract this one register, but leave the block
    {0x455e, 0x00},
    {0x471e, 0x4b},
    {0x4767, 0x0f},
    {0x4750, 0x14},
    {0x4540, 0x00},
    {0x47b4, 0x14},
    {0x4713, 0x30},
    {0x478b, 0x10},
    {0x478f, 0x10},
    {0x4793, 0x10},
    {0x4797, 0x0e},
    {0x479b, 0x0e},
    {0x0162, 0x0d},
    {0x0163, 0x78},
that appear to also be common to all modes.

Other drivers break that lot out into a global registers array that is
always sent, rather than individual register writes.
Having this one register extra write as a new function is actually
likely to increase the size of the module overall, instead of reducing
it.

  Dave

> +       return ret;
> +};
> +
>  static int imx219_configure_lanes(struct imx219 *imx219)
>  {
>         int ret;
> @@ -1081,6 +1090,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
>                 goto err_rpm_put;
>         }
>
> +       /* Setup DPHY */
> +       ret = imx219_enable_dphy(imx219, IMX219_DPHY_AUTO);
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to configure dphy\n", __func__);
> +               goto err_rpm_put;
> +       }
> +
>         /* Configure clock based on reference clock frequency */
>         imx219_set_exck_freq(imx219);
>
> --
> 2.34.1
>
