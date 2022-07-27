Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DB458266B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiG0M2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiG0M2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:28:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0857133;
        Wed, 27 Jul 2022 05:28:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m8so21163082edd.9;
        Wed, 27 Jul 2022 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WAI7Q2jplmuQ+srnlB4oFLWm+IYzcxAZQEee5kg+wG8=;
        b=A6DxVpFM9qxOk6bjBO10BX3QNoDjqqqvIsbZ48tXpcYlzTuDtSFTrASa6wd94MbSzv
         kCmpiPQuSdOslbnaVHKI8fyU0C33P6xs3/z0MJ75kbe94ZCkUtxw6shPRhI/9U/eSePa
         xH2AHAJCbvWugnT4dodEiI/R0448N6R2Z99tu2Y0hYdi/9B4ibdpJofJQwq4AMAHknlk
         QXUYR2NrQKMU13i2ZHLI8yUxjDohNE1sGNK1pLztdW8YEB7VPnITW6T5H/dalT2w0Ymg
         4Eu0b9Uvch20bwuXn1UFkEwhUibrlE12KAsAhsoOWFDtYIjtsujKH6F9QLfuJ4PMf4wN
         UnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WAI7Q2jplmuQ+srnlB4oFLWm+IYzcxAZQEee5kg+wG8=;
        b=bnSlveTqCqeWBVVB/RYu5PCUflg+MS7LuSxNVTvOskmmtozqQRh/b4X+WjnvMX9s1G
         yw2Nj5hsZ5z8kMAVqsZnYF0smPgb2QDAlLOmdiFb0BltqdABPr3LJHS1vfcXPRPB5RWn
         UCQp73yP1NHH4lujLEvW7jrFORLgZ5CjgAoESHzavWTtHQptM9+2Z+HaDZHi3lFxO5nN
         RPhNFUbAtwFBiHQn6k7bZyRcsU2Fs8ywmtNM7M0Zc0mR+5tzUPGdFWNyOCP3OKZf1dfh
         AT8/bV1Vj43lhEydLBs8iunSI6RZEl4LmlkMZ4FYCKiMxCn7ZWg2sKup8DPmRhAK4zNF
         5RQg==
X-Gm-Message-State: AJIora+E5/PJAnvRdcRm48HfwiyTdWXWFEaWcVXDQlMGi32eRvh6VbFo
        tRGv1GFxOJLUPi5ynMIHIVmviZQVdDbZJzCSuhKW6SYH
X-Google-Smtp-Source: AGRyM1t4mWpwX6vT2WF0Xty2oRfh34eyqfN0UBDXFEnL4vJ8NCG9y6O6K+zHrDX6xS1VGCQ/SX+SGljIMpekNUtTiuY=
X-Received: by 2002:a05:6402:11d3:b0:43c:436b:829 with SMTP id
 j19-20020a05640211d300b0043c436b0829mr8785475edw.324.1658924911868; Wed, 27
 Jul 2022 05:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220709135052.3850913-1-aford173@gmail.com>
In-Reply-To: <20220709135052.3850913-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 27 Jul 2022 07:28:20 -0500
Message-ID: <CAHCN7xLeByMUZ0ntPUckrCPVGs4GnHKTGRpaiWz5Se40qY4OiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: i2c: imx219: Split common registers from mode tables
To:     linux-media <linux-media@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 9, 2022 at 8:51 AM Adam Ford <aford173@gmail.com> wrote:
>
> There are four modes, and each mode has a table of registers.
> Some of the registers are common to all modes, so create new
> tables for these common registers to reduce duplicate code.
>

Dave,

I've tried to address your concerns in this V3 series which is down to
2 patches.  Any chance you can review them?  I've tested the 4-lane
mode on both an imx8mp (still images) and a Renesas RZ/G2M (streaming
video) and both can capture in 4-lane mode.

adam
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Change some of the comments to better reflect their description
>      Add a few more entries to the imx219_common_regs table.
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index e10af3f74b38..faa5dab3c2ec 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -145,23 +145,61 @@ struct imx219_mode {
>         struct imx219_reg_list reg_list;
>  };
>
> -/*
> - * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> - * driver.
> - * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> - */
> -static const struct imx219_reg mode_3280x2464_regs[] = {
> -       {0x0100, 0x00},
> +static const struct imx219_reg imx219_common_regs[] = {
> +       {0x0100, 0x00}, /* Mode Select */
> +
> +       /* To Access Addresses 3000-5fff, send the following commands */
>         {0x30eb, 0x0c},
>         {0x30eb, 0x05},
>         {0x300a, 0xff},
>         {0x300b, 0xff},
>         {0x30eb, 0x05},
>         {0x30eb, 0x09},
> -       {0x0114, 0x01},
> -       {0x0128, 0x00},
> -       {0x012a, 0x18},
> +
> +       /* PLL Clock Table */
> +       {0x0301, 0x05}, /* VTPXCK_DIV */
> +       {0x0303, 0x01}, /* VTSYSCK_DIV */
> +       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> +       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
> +       {0x0306, 0x00}, /* PLL_VT_MPY */
> +       {0x0307, 0x39},
> +       {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> +       {0x030c, 0x00}, /* PLL_OP_MPY */
> +       {0x030d, 0x72},
> +
> +       /* Undocumented registers */
> +       {0x455e, 0x00},
> +       {0x471e, 0x4b},
> +       {0x4767, 0x0f},
> +       {0x4750, 0x14},
> +       {0x4540, 0x00},
> +       {0x47b4, 0x14},
> +       {0x4713, 0x30},
> +       {0x478b, 0x10},
> +       {0x478f, 0x10},
> +       {0x4793, 0x10},
> +       {0x4797, 0x0e},
> +       {0x479b, 0x0e},
> +
> +       /* Frame Bank Register Group "A" */
> +       {0x0162, 0x0d}, /* Line_Length_A */
> +       {0x0163, 0x78},
> +       {0x0170, 0x01}, /* X_ODD_INC_A */
> +       {0x0171, 0x01}, /* Y_ODD_INC_A */
> +
> +       /* Output setup registers */
> +       {0x0114, 0x01}, /* CSI 2-Lane Mode */
> +       {0x0128, 0x00}, /* DPHY Auto Mode */
> +       {0x012a, 0x18}, /* EXCK_Freq */
>         {0x012b, 0x00},
> +};
> +
> +/*
> + * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> + * driver.
> + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> + */
> +static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x0164, 0x00},
>         {0x0165, 0x00},
>         {0x0166, 0x0c},
> @@ -174,53 +212,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x016d, 0xd0},
>         {0x016e, 0x09},
>         {0x016f, 0xa0},
> -       {0x0170, 0x01},
> -       {0x0171, 0x01},
> -       {0x0174, 0x00},
> +       {0x0174, 0x00}, /* No-Binning */
>         {0x0175, 0x00},
> -       {0x0301, 0x05},
> -       {0x0303, 0x01},
> -       {0x0304, 0x03},
> -       {0x0305, 0x03},
> -       {0x0306, 0x00},
> -       {0x0307, 0x39},
> -       {0x030b, 0x01},
> -       {0x030c, 0x00},
> -       {0x030d, 0x72},
>         {0x0624, 0x0c},
>         {0x0625, 0xd0},
>         {0x0626, 0x09},
>         {0x0627, 0xa0},
> -       {0x455e, 0x00},
> -       {0x471e, 0x4b},
> -       {0x4767, 0x0f},
> -       {0x4750, 0x14},
> -       {0x4540, 0x00},
> -       {0x47b4, 0x14},
> -       {0x4713, 0x30},
> -       {0x478b, 0x10},
> -       {0x478f, 0x10},
> -       {0x4793, 0x10},
> -       {0x4797, 0x0e},
> -       {0x479b, 0x0e},
> -       {0x0162, 0x0d},
> -       {0x0163, 0x78},
>  };
>
>  static const struct imx219_reg mode_1920_1080_regs[] = {
> -       {0x0100, 0x00},
> -       {0x30eb, 0x05},
> -       {0x30eb, 0x0c},
> -       {0x300a, 0xff},
> -       {0x300b, 0xff},
> -       {0x30eb, 0x05},
> -       {0x30eb, 0x09},
> -       {0x0114, 0x01},
> -       {0x0128, 0x00},
> -       {0x012a, 0x18},
> -       {0x012b, 0x00},
> -       {0x0162, 0x0d},
> -       {0x0163, 0x78},
>         {0x0164, 0x02},
>         {0x0165, 0xa8},
>         {0x0166, 0x0a},
> @@ -233,49 +233,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
>         {0x016d, 0x80},
>         {0x016e, 0x04},
>         {0x016f, 0x38},
> -       {0x0170, 0x01},
> -       {0x0171, 0x01},
> -       {0x0174, 0x00},
> +       {0x0174, 0x00}, /* No-Binning */
>         {0x0175, 0x00},
> -       {0x0301, 0x05},
> -       {0x0303, 0x01},
> -       {0x0304, 0x03},
> -       {0x0305, 0x03},
> -       {0x0306, 0x00},
> -       {0x0307, 0x39},
> -       {0x030b, 0x01},
> -       {0x030c, 0x00},
> -       {0x030d, 0x72},
>         {0x0624, 0x07},
>         {0x0625, 0x80},
>         {0x0626, 0x04},
>         {0x0627, 0x38},
> -       {0x455e, 0x00},
> -       {0x471e, 0x4b},
> -       {0x4767, 0x0f},
> -       {0x4750, 0x14},
> -       {0x4540, 0x00},
> -       {0x47b4, 0x14},
> -       {0x4713, 0x30},
> -       {0x478b, 0x10},
> -       {0x478f, 0x10},
> -       {0x4793, 0x10},
> -       {0x4797, 0x0e},
> -       {0x479b, 0x0e},
>  };
>
>  static const struct imx219_reg mode_1640_1232_regs[] = {
> -       {0x0100, 0x00},
> -       {0x30eb, 0x0c},
> -       {0x30eb, 0x05},
> -       {0x300a, 0xff},
> -       {0x300b, 0xff},
> -       {0x30eb, 0x05},
> -       {0x30eb, 0x09},
> -       {0x0114, 0x01},
> -       {0x0128, 0x00},
> -       {0x012a, 0x18},
> -       {0x012b, 0x00},
>         {0x0164, 0x00},
>         {0x0165, 0x00},
>         {0x0166, 0x0c},
> @@ -288,53 +254,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>         {0x016d, 0x68},
>         {0x016e, 0x04},
>         {0x016f, 0xd0},
> -       {0x0170, 0x01},
> -       {0x0171, 0x01},
> -       {0x0174, 0x01},
> +       {0x0174, 0x01}, /* x2-Binning */
>         {0x0175, 0x01},
> -       {0x0301, 0x05},
> -       {0x0303, 0x01},
> -       {0x0304, 0x03},
> -       {0x0305, 0x03},
> -       {0x0306, 0x00},
> -       {0x0307, 0x39},
> -       {0x030b, 0x01},
> -       {0x030c, 0x00},
> -       {0x030d, 0x72},
>         {0x0624, 0x06},
>         {0x0625, 0x68},
>         {0x0626, 0x04},
>         {0x0627, 0xd0},
> -       {0x455e, 0x00},
> -       {0x471e, 0x4b},
> -       {0x4767, 0x0f},
> -       {0x4750, 0x14},
> -       {0x4540, 0x00},
> -       {0x47b4, 0x14},
> -       {0x4713, 0x30},
> -       {0x478b, 0x10},
> -       {0x478f, 0x10},
> -       {0x4793, 0x10},
> -       {0x4797, 0x0e},
> -       {0x479b, 0x0e},
> -       {0x0162, 0x0d},
> -       {0x0163, 0x78},
>  };
>
>  static const struct imx219_reg mode_640_480_regs[] = {
> -       {0x0100, 0x00},
> -       {0x30eb, 0x05},
> -       {0x30eb, 0x0c},
> -       {0x300a, 0xff},
> -       {0x300b, 0xff},
> -       {0x30eb, 0x05},
> -       {0x30eb, 0x09},
> -       {0x0114, 0x01},
> -       {0x0128, 0x00},
> -       {0x012a, 0x18},
> -       {0x012b, 0x00},
> -       {0x0162, 0x0d},
> -       {0x0163, 0x78},
>         {0x0164, 0x03},
>         {0x0165, 0xe8},
>         {0x0166, 0x08},
> @@ -347,35 +275,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
>         {0x016d, 0x80},
>         {0x016e, 0x01},
>         {0x016f, 0xe0},
> -       {0x0170, 0x01},
> -       {0x0171, 0x01},
> -       {0x0174, 0x03},
> +       {0x0174, 0x03}, /* x2-analog binning */
>         {0x0175, 0x03},
> -       {0x0301, 0x05},
> -       {0x0303, 0x01},
> -       {0x0304, 0x03},
> -       {0x0305, 0x03},
> -       {0x0306, 0x00},
> -       {0x0307, 0x39},
> -       {0x030b, 0x01},
> -       {0x030c, 0x00},
> -       {0x030d, 0x72},
>         {0x0624, 0x06},
>         {0x0625, 0x68},
>         {0x0626, 0x04},
>         {0x0627, 0xd0},
> -       {0x455e, 0x00},
> -       {0x471e, 0x4b},
> -       {0x4767, 0x0f},
> -       {0x4750, 0x14},
> -       {0x4540, 0x00},
> -       {0x47b4, 0x14},
> -       {0x4713, 0x30},
> -       {0x478b, 0x10},
> -       {0x478f, 0x10},
> -       {0x4793, 0x10},
> -       {0x4797, 0x0e},
> -       {0x479b, 0x0e},
>  };
>
>  static const struct imx219_reg raw8_framefmt_regs[] = {
> @@ -1041,6 +946,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
>         if (ret < 0)
>                 return ret;
>
> +       /* Send all registers that are common to all modes */
> +       ret = imx219_write_regs(imx219, imx219_common_regs, ARRAY_SIZE(imx219_common_regs));
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
> +               goto err_rpm_put;
> +       }
> +
>         /* Apply default values of current mode */
>         reg_list = &imx219->mode->reg_list;
>         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> --
> 2.34.1
>
