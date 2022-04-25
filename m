Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C3D50E579
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbiDYQXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238909AbiDYQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:23:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6F68302
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:20:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a21so6877326edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Fe6LxZHEqkixiJSvboLiKadG37amnsHY4Z+NTobank=;
        b=PQ+pDUS7FMhEa365JDHWZHkT7SB9g8TLyESL1A3E6ssjzeZT12XEFoOS4S5PTnTfpZ
         GixK5jYaNDEX+cN6BCQuKIr9szisyoX8YI0l9IHGjKBnECk6kf1p1SIytS2dKcRMw979
         x/yqGkTt4xS10tQKMOIgfdRKBwIRAWlnBCvozTPgeCN0aTCOfeBd+J/msyRkMHpwJhMj
         /K4XIdUyBgCzhvGwGYN7sm6SeyPXY8asTWf5qIbFcvRinuP/pS8uRt3bkBr+kFbnKxle
         8PMsy6QaDcKQUQvpm+LsNxld6BtcSPNkmCl8jHNvyoOniBhjXcF/aA3dziVfILKOrPuo
         y2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Fe6LxZHEqkixiJSvboLiKadG37amnsHY4Z+NTobank=;
        b=MSYOVCkPid6FLd4RUNpMqMpB1VdmIJBqi0HMJI+KRCs5SbvaCr//Q+NNu76/OtJF/j
         O2R7cqiDwvK8qO5THFBUyWnyBdQ1eIJtCrqOkjihIoYbHpjQgCKrK4+dNTaVODSVYDYn
         LowwCk2hlNAddGoWkUF8KruIi+Gnq+K3QxDcNy54C+1tUv00bD08FZCZMQ3tiR5TbrAi
         I2Djigljubt6hA5xB/slK2sm+V+XD4LsUeC2hl+NkqaWEJWo4NFd3NOHzladxUdkFy1r
         OvaE/t4FcNv25BA9a58Wym9OTOZ0I6a6M2CHrLSgtDTwDyS8CFGsIQkj1I02kpzqvzQl
         +Dbw==
X-Gm-Message-State: AOAM533AwCDfz/w5q9w+p7XL+gjhdmBmRsW8xgJmi0yUHcjzK/qvj4Er
        yJi0jw/NfB1NRz6JBPOQN83Fp4GTgv4KK0Atu9QDhQ==
X-Google-Smtp-Source: ABdhPJx2yDEdvEhFCkE9/UJ3OYVSrXf0wvM9TSGwgmJy7RjUSw0/Ac9QtaXkvwbeMtzu51EGMfh+faJw+mhpYs47DEk=
X-Received: by 2002:aa7:dd45:0:b0:425:8cea:8c76 with SMTP id
 o5-20020aa7dd45000000b004258cea8c76mr19617581edw.353.1650903645608; Mon, 25
 Apr 2022 09:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com> <20220412135534.2796158-2-aford173@gmail.com>
In-Reply-To: <20220412135534.2796158-2-aford173@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 25 Apr 2022 17:20:29 +0100
Message-ID: <CAPY8ntCKxRMFX023BsM70bA0UbPApzOzLbg+2X0SU93_GABKiA@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: i2c: imx219: Split common registers from mode tables
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
> There are four modes, and each mode has a table of registers.
> Some of the registers are common to all modes, so create new
> tables for these common registers to reduce duplicate code.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/media/i2c/imx219.c | 103 ++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index e10af3f74b38..b7cc36b16547 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -145,19 +145,36 @@ struct imx219_mode {
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
> +/* To Access Addresses 3000-5fff, send the following commands */
> +static const struct imx219_reg mfg_specific_reg[] = {
> +       {0x0100, 0x00}, /* Mode Select */
>         {0x30eb, 0x0c},
>         {0x30eb, 0x05},
>         {0x300a, 0xff},
>         {0x300b, 0xff},
>         {0x30eb, 0x05},
>         {0x30eb, 0x09},
> +};
> +
> +static const struct imx219_reg pll_clk_table[] = {
> +
> +       {0x0301, 0x05}, /* VTPXCK_DIV */
> +       {0x0303, 0x01}, /* VTSYSCK_DIV */
> +       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> +       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
> +       {0x0306, 0x00}, /* PLL_VT_MPY */
> +       {0x0307, 0x39},
> +       {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> +       {0x030c, 0x00}, /* PLL_OP_MPY */
> +       {0x030d, 0x72},
> +};

(I've come back to this patch last as my first reading was happy with it)
Is there a good reason for making these two tables instead of one with
comments as to what the registers are doing?

As per my comment on patch 4, one table of registers setting these,
the DPHY register, and registers
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
would remove the duplication, reduce the code size, and be slightly
more readable.

  Dave

> +/*
> + * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> + * driver.
> + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> + */
> +static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
> @@ -178,15 +195,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x0171, 0x01},
>         {0x0174, 0x00},
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
> @@ -208,13 +216,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
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
>         {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
> @@ -237,15 +238,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
>         {0x0171, 0x01},
>         {0x0174, 0x00},
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
> @@ -265,13 +257,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
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
>         {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
> @@ -292,15 +277,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>         {0x0171, 0x01},
>         {0x0174, 0x01},
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
> @@ -322,13 +298,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
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
>         {0x0114, 0x01},
>         {0x0128, 0x00},
>         {0x012a, 0x18},
> @@ -351,15 +320,6 @@ static const struct imx219_reg mode_640_480_regs[] = {
>         {0x0171, 0x01},
>         {0x0174, 0x03},
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
> @@ -1041,6 +1001,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
>         if (ret < 0)
>                 return ret;
>
> +       /* Send the Manufacturing Header common to all modes */
> +       ret = imx219_write_regs(imx219, mfg_specific_reg, ARRAY_SIZE(mfg_specific_reg));
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
> +               goto err_rpm_put;
> +       }
> +
>         /* Apply default values of current mode */
>         reg_list = &imx219->mode->reg_list;
>         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> @@ -1056,6 +1023,14 @@ static int imx219_start_streaming(struct imx219 *imx219)
>                 goto err_rpm_put;
>         }
>
> +       /* Configure the PLL clocks */
> +       ret = imx219_write_regs(imx219, pll_clk_table, ARRAY_SIZE(pll_clk_table));
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to sent PLL clocks\n", __func__);
> +               goto err_rpm_put;
> +       }
> +
> +
>         /* Apply customized values from user */
>         ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
>         if (ret)
> --
> 2.34.1
>
