Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E28D55368F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiFUPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351597AbiFUPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:46:39 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96972CDE8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:46:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o7so28416429eja.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAai0FfdqLrpftN9wmZ6NtWjQkykMlzlgrF66RvPQt8=;
        b=rls3Nixofbt4S7WQKX2wm858F7z4EjkxC9tIwT2nkM+uOfC1IN0L/RdBe4PhBiD98Q
         6ijONzSf+OYd5I4+CLPX4eNNsTVnn8yAE+sa2elU4hMg3I00VWBVYlStZIkJx4fuRn4g
         nBbxnFo2tCT6PCMCrRohT0RIn3il9gLPuyplLTeEJt00Wp9homSsUH9hRvga0pEpS7d+
         mcx+GI+spL6bpuSP3KYcl/3wBDWssomQPUFnAXeKg+7mEEyxn0MSCvhs4hk49tc63Y+B
         MMc814Ma9XYM6WmkZIIMXHkb6kteB3ZFiuWMaQHG69xTva8hURV8xAFLjSdUkEPEkrZ6
         B5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAai0FfdqLrpftN9wmZ6NtWjQkykMlzlgrF66RvPQt8=;
        b=XtrwMVCiJd+Wr0LYd5yh3LcUydg53GQakrAJaZQi7b2mF50oQYH0XEMEp5WHa/JSJR
         LKsoAvPAyapPfvxwR8OihYlAh6EEnAcr4qRpd1WwFgbfrWtuoYMPU8YOqhvcE4GRdY8J
         tdo/I5l/hKsDSl01zZjk9FiN+HRUrdqo4KqZOHQncCEWlemCZL0Hdv0azyb7Re+L6WZM
         8h0jArLsPZTHT+5Noq+cryoXRBmE5tmc7O9bF50lKh5IE3U8g82F4NU+0pgsw/ZsztYT
         yjeK6HHv8VO6sj+RBxONZickJvhAh4XWcie4tmIb0TcO8FUao+JBrY+/MCn0QXdhrD28
         aAnA==
X-Gm-Message-State: AJIora/55QBTwrmwALvoXq2Dlirf12rwV7jPzgjrureK+Oz1dYXgL0JC
        uiu1YtwPmD6OyHdeIRb2jH411Fa5/oFqkko37vENmA==
X-Google-Smtp-Source: AGRyM1ujnEZrNgrU9zwAv0fnczsHDWeW3XmHL1kotvz733UVwreqxU0J/ViQBFNpouZPT+LlUMMN13XJeicQsoROd1M=
X-Received: by 2002:a17:906:51d0:b0:722:dbb7:5ac1 with SMTP id
 v16-20020a17090651d000b00722dbb75ac1mr5721598ejk.175.1655826396312; Tue, 21
 Jun 2022 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220616123150.5890-1-aford173@gmail.com>
In-Reply-To: <20220616123150.5890-1-aford173@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 21 Jun 2022 16:46:21 +0100
Message-ID: <CAPY8ntCmov0OY3tBabf7ndSVCNgeYeSy+e4E0sdaW54zZpoauw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] media: i2c: imx219: Split common registers from
 mode tables
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam

Thanks for the patch, and sorry it's taken me a few days to get to it.

On Thu, 16 Jun 2022 at 13:31, Adam Ford <aford173@gmail.com> wrote:
>
> There are four modes, and each mode has a table of registers.
> Some of the registers are common to all modes, so create new
> tables for these common registers to reduce duplicate code.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Merge the PLL table into the common table instead of having
>      two separate, common tables.
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index e10af3f74b38..a43eed143999 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -145,23 +145,60 @@ struct imx219_mode {
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
> +static const struct imx219_reg imx219_common_regs[] = {
> +       {0x0100, 0x00}, /* Mode Select */
> +
> +       /* Access Command Sequence */
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

Registers 0x0170 and 0x171 for X_ODD_INC_A and Y_ODD_INC_A are also
common to all modes as 0x01. You could have modes with skipping, but
currently there are none.

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
> @@ -176,51 +213,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x016f, 0xa0},
>         {0x0170, 0x01},
>         {0x0171, 0x01},
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
> @@ -235,47 +236,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
>         {0x016f, 0x38},
>         {0x0170, 0x01},
>         {0x0171, 0x01},
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
> @@ -290,51 +259,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>         {0x016f, 0xd0},
>         {0x0170, 0x01},
>         {0x0171, 0x01},
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
> @@ -349,33 +282,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
>         {0x016f, 0xe0},
>         {0x0170, 0x01},
>         {0x0171, 0x01},
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
> @@ -1041,6 +953,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
>         if (ret < 0)
>                 return ret;
>
> +       /* Send the Manufacturing Header common to all modes */

It's a table of common settings, not a manufacturing header.
s/Send the Manufacturing Header/Send all registers that are

 Dave

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
