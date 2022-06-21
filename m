Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6D553718
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353413AbiFUP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353449AbiFUP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:58:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423D0B60;
        Tue, 21 Jun 2022 08:58:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so28417140ejj.12;
        Tue, 21 Jun 2022 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeoXftpe/v0Ob6pn0xGP28lf443O/cJj2rmN7pKOsSU=;
        b=prVwloim5i7s5Ov3T72osn8Q9AP2iJPYlriRF5nrOn+qaeohDofWQo73IiKzGuHacb
         B1a366Cxgv/2I0Q1Rrov2/m1lal3+OZrAIbV2+jtf1guwp1CsxIf6GOVb8PIZnIyKKDh
         86Nx8Pq14miesYB6nPyQzH5M4F1kE5P495TtgCcwV4G6K02fThG5kw52QY9DZdoUz5Xb
         PzP5fJ+SfyIhKUmWgohl18k0EfDT3BI5eAAqp2DNdfwGU7yLdRs8EwLJSnv/ifTad/Sp
         IYLxIEQIe3lIl6RgId1X04dvlo9R3jpKwuakOAfVBcePkk1DQql4edF+x4xmGsMU6WQ5
         x3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeoXftpe/v0Ob6pn0xGP28lf443O/cJj2rmN7pKOsSU=;
        b=FiERoGtn26CcQFhYHq3/BDofspZaHNLJOT3sF8eROnMPFK/71qM+uFydMWZtsmamm2
         wh1c0x3m2UH5FNt24/0kcjR35jf/YU+ZV/OdRDfcVR5NMi8INmZvItz+lRKLD+zO2hAh
         vrahEHuT5mDVsZzOTw+A/XHgOAQfMst2C/GycLXoxaRXo0MMOWtiMAeVi+2vJxIn/0Ft
         VUXdMzzIxuXHwSwNZkhuGhU8ofCgK4zGRMCMSTW8aQ3KUedP7rgdiM2d9JLn9iWh/eEn
         33Txn14t9z9GNYyN9R4XHPIMyIj9vuakAvqzeerHVRpm0iZZABCzI9CTE2BGAxuo8GoP
         5vIg==
X-Gm-Message-State: AJIora9O8E2g4PB4UMJrM3h+uAWkKoUkAiSBaZITdzuRTJvvL50vMwln
        EYPcSOEMKHvhxnO+PXsdhwunNr3vpHIVMqkLeN1AX/9nuEA=
X-Google-Smtp-Source: AGRyM1tuixytD1BV2iu/4WAs6E7wdhAg3Z4XL70+jyiNH4Bu0etWkl+a4tsUxcryF1qr5jDlIiLoL/8eEXfeNZTKtf4=
X-Received: by 2002:a17:907:8b06:b0:711:e7f6:1728 with SMTP id
 sz6-20020a1709078b0600b00711e7f61728mr26047927ejc.32.1655827116395; Tue, 21
 Jun 2022 08:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220616123150.5890-1-aford173@gmail.com> <CAPY8ntCmov0OY3tBabf7ndSVCNgeYeSy+e4E0sdaW54zZpoauw@mail.gmail.com>
In-Reply-To: <CAPY8ntCmov0OY3tBabf7ndSVCNgeYeSy+e4E0sdaW54zZpoauw@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 21 Jun 2022 10:58:25 -0500
Message-ID: <CAHCN7xKGhFn0NHEdjMg9kuPVOB_p_CL4FEiZczbGsPcob-Tv8Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] media: i2c: imx219: Split common registers from
 mode tables
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:46 AM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Adam
>
> Thanks for the patch, and sorry it's taken me a few days to get to it.
>
> On Thu, 16 Jun 2022 at 13:31, Adam Ford <aford173@gmail.com> wrote:
> >
> > There are four modes, and each mode has a table of registers.
> > Some of the registers are common to all modes, so create new
> > tables for these common registers to reduce duplicate code.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > V2:  Merge the PLL table into the common table instead of having
> >      two separate, common tables.
> >
> > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > index e10af3f74b38..a43eed143999 100644
> > --- a/drivers/media/i2c/imx219.c
> > +++ b/drivers/media/i2c/imx219.c
> > @@ -145,23 +145,60 @@ struct imx219_mode {
> >         struct imx219_reg_list reg_list;
> >  };
> >
> > -/*
> > - * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > - * driver.
> > - * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > - */
> > -static const struct imx219_reg mode_3280x2464_regs[] = {
> > -       {0x0100, 0x00},
> > +/* To Access Addresses 3000-5fff, send the following commands */
> > +static const struct imx219_reg imx219_common_regs[] = {
> > +       {0x0100, 0x00}, /* Mode Select */
> > +
> > +       /* Access Command Sequence */
> >         {0x30eb, 0x0c},
> >         {0x30eb, 0x05},
> >         {0x300a, 0xff},
> >         {0x300b, 0xff},
> >         {0x30eb, 0x05},
> >         {0x30eb, 0x09},
> > -       {0x0114, 0x01},
> > -       {0x0128, 0x00},
> > -       {0x012a, 0x18},
> > +
> > +       /* PLL Clock Table */
> > +       {0x0301, 0x05}, /* VTPXCK_DIV */
> > +       {0x0303, 0x01}, /* VTSYSCK_DIV */
> > +       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> > +       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
> > +       {0x0306, 0x00}, /* PLL_VT_MPY */
> > +       {0x0307, 0x39},
> > +       {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> > +       {0x030c, 0x00}, /* PLL_OP_MPY */
> > +       {0x030d, 0x72},
> > +
> > +       /* Undocumented registers */
> > +       {0x455e, 0x00},
> > +       {0x471e, 0x4b},
> > +       {0x4767, 0x0f},
> > +       {0x4750, 0x14},
> > +       {0x4540, 0x00},
> > +       {0x47b4, 0x14},
> > +       {0x4713, 0x30},
> > +       {0x478b, 0x10},
> > +       {0x478f, 0x10},
> > +       {0x4793, 0x10},
> > +       {0x4797, 0x0e},
> > +       {0x479b, 0x0e},
> > +
> > +       /* Frame Bank Register Group "A" */
> > +       {0x0162, 0x0d}, /* Line_Length_A */
> > +       {0x0163, 0x78},
>
> Registers 0x0170 and 0x171 for X_ODD_INC_A and Y_ODD_INC_A are also
> common to all modes as 0x01. You could have modes with skipping, but
> currently there are none.
>
> > +
> > +       /* Output setup registers */
> > +       {0x0114, 0x01}, /* CSI 2-Lane Mode */
> > +       {0x0128, 0x00}, /* DPHY Auto Mode */
> > +       {0x012a, 0x18}, /* EXCK_Freq */
> >         {0x012b, 0x00},
> > +};
> > +
> > +/*
> > + * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > + * driver.
> > + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > + */
> > +static const struct imx219_reg mode_3280x2464_regs[] = {
> >         {0x0164, 0x00},
> >         {0x0165, 0x00},
> >         {0x0166, 0x0c},
> > @@ -176,51 +213,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
> >         {0x016f, 0xa0},
> >         {0x0170, 0x01},
> >         {0x0171, 0x01},
> > -       {0x0174, 0x00},
> > +       {0x0174, 0x00}, /* No-Binning */
> >         {0x0175, 0x00},
> > -       {0x0301, 0x05},
> > -       {0x0303, 0x01},
> > -       {0x0304, 0x03},
> > -       {0x0305, 0x03},
> > -       {0x0306, 0x00},
> > -       {0x0307, 0x39},
> > -       {0x030b, 0x01},
> > -       {0x030c, 0x00},
> > -       {0x030d, 0x72},
> >         {0x0624, 0x0c},
> >         {0x0625, 0xd0},
> >         {0x0626, 0x09},
> >         {0x0627, 0xa0},
> > -       {0x455e, 0x00},
> > -       {0x471e, 0x4b},
> > -       {0x4767, 0x0f},
> > -       {0x4750, 0x14},
> > -       {0x4540, 0x00},
> > -       {0x47b4, 0x14},
> > -       {0x4713, 0x30},
> > -       {0x478b, 0x10},
> > -       {0x478f, 0x10},
> > -       {0x4793, 0x10},
> > -       {0x4797, 0x0e},
> > -       {0x479b, 0x0e},
> > -       {0x0162, 0x0d},
> > -       {0x0163, 0x78},
> >  };
> >
> >  static const struct imx219_reg mode_1920_1080_regs[] = {
> > -       {0x0100, 0x00},
> > -       {0x30eb, 0x05},
> > -       {0x30eb, 0x0c},
> > -       {0x300a, 0xff},
> > -       {0x300b, 0xff},
> > -       {0x30eb, 0x05},
> > -       {0x30eb, 0x09},
> > -       {0x0114, 0x01},
> > -       {0x0128, 0x00},
> > -       {0x012a, 0x18},
> > -       {0x012b, 0x00},
> > -       {0x0162, 0x0d},
> > -       {0x0163, 0x78},
> >         {0x0164, 0x02},
> >         {0x0165, 0xa8},
> >         {0x0166, 0x0a},
> > @@ -235,47 +236,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
> >         {0x016f, 0x38},
> >         {0x0170, 0x01},
> >         {0x0171, 0x01},
> > -       {0x0174, 0x00},
> > +       {0x0174, 0x00}, /* No-Binning */
> >         {0x0175, 0x00},
> > -       {0x0301, 0x05},
> > -       {0x0303, 0x01},
> > -       {0x0304, 0x03},
> > -       {0x0305, 0x03},
> > -       {0x0306, 0x00},
> > -       {0x0307, 0x39},
> > -       {0x030b, 0x01},
> > -       {0x030c, 0x00},
> > -       {0x030d, 0x72},
> >         {0x0624, 0x07},
> >         {0x0625, 0x80},
> >         {0x0626, 0x04},
> >         {0x0627, 0x38},
> > -       {0x455e, 0x00},
> > -       {0x471e, 0x4b},
> > -       {0x4767, 0x0f},
> > -       {0x4750, 0x14},
> > -       {0x4540, 0x00},
> > -       {0x47b4, 0x14},
> > -       {0x4713, 0x30},
> > -       {0x478b, 0x10},
> > -       {0x478f, 0x10},
> > -       {0x4793, 0x10},
> > -       {0x4797, 0x0e},
> > -       {0x479b, 0x0e},
> >  };
> >
> >  static const struct imx219_reg mode_1640_1232_regs[] = {
> > -       {0x0100, 0x00},
> > -       {0x30eb, 0x0c},
> > -       {0x30eb, 0x05},
> > -       {0x300a, 0xff},
> > -       {0x300b, 0xff},
> > -       {0x30eb, 0x05},
> > -       {0x30eb, 0x09},
> > -       {0x0114, 0x01},
> > -       {0x0128, 0x00},
> > -       {0x012a, 0x18},
> > -       {0x012b, 0x00},
> >         {0x0164, 0x00},
> >         {0x0165, 0x00},
> >         {0x0166, 0x0c},
> > @@ -290,51 +259,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
> >         {0x016f, 0xd0},
> >         {0x0170, 0x01},
> >         {0x0171, 0x01},
> > -       {0x0174, 0x01},
> > +       {0x0174, 0x01}, /* x2-Binning */
> >         {0x0175, 0x01},
> > -       {0x0301, 0x05},
> > -       {0x0303, 0x01},
> > -       {0x0304, 0x03},
> > -       {0x0305, 0x03},
> > -       {0x0306, 0x00},
> > -       {0x0307, 0x39},
> > -       {0x030b, 0x01},
> > -       {0x030c, 0x00},
> > -       {0x030d, 0x72},
> >         {0x0624, 0x06},
> >         {0x0625, 0x68},
> >         {0x0626, 0x04},
> >         {0x0627, 0xd0},
> > -       {0x455e, 0x00},
> > -       {0x471e, 0x4b},
> > -       {0x4767, 0x0f},
> > -       {0x4750, 0x14},
> > -       {0x4540, 0x00},
> > -       {0x47b4, 0x14},
> > -       {0x4713, 0x30},
> > -       {0x478b, 0x10},
> > -       {0x478f, 0x10},
> > -       {0x4793, 0x10},
> > -       {0x4797, 0x0e},
> > -       {0x479b, 0x0e},
> > -       {0x0162, 0x0d},
> > -       {0x0163, 0x78},
> >  };
> >
> >  static const struct imx219_reg mode_640_480_regs[] = {
> > -       {0x0100, 0x00},
> > -       {0x30eb, 0x05},
> > -       {0x30eb, 0x0c},
> > -       {0x300a, 0xff},
> > -       {0x300b, 0xff},
> > -       {0x30eb, 0x05},
> > -       {0x30eb, 0x09},
> > -       {0x0114, 0x01},
> > -       {0x0128, 0x00},
> > -       {0x012a, 0x18},
> > -       {0x012b, 0x00},
> > -       {0x0162, 0x0d},
> > -       {0x0163, 0x78},
> >         {0x0164, 0x03},
> >         {0x0165, 0xe8},
> >         {0x0166, 0x08},
> > @@ -349,33 +282,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
> >         {0x016f, 0xe0},
> >         {0x0170, 0x01},
> >         {0x0171, 0x01},
> > -       {0x0174, 0x03},
> > +       {0x0174, 0x03}, /* x2-analog binning */
> >         {0x0175, 0x03},
> > -       {0x0301, 0x05},
> > -       {0x0303, 0x01},
> > -       {0x0304, 0x03},
> > -       {0x0305, 0x03},
> > -       {0x0306, 0x00},
> > -       {0x0307, 0x39},
> > -       {0x030b, 0x01},
> > -       {0x030c, 0x00},
> > -       {0x030d, 0x72},
> >         {0x0624, 0x06},
> >         {0x0625, 0x68},
> >         {0x0626, 0x04},
> >         {0x0627, 0xd0},
> > -       {0x455e, 0x00},
> > -       {0x471e, 0x4b},
> > -       {0x4767, 0x0f},
> > -       {0x4750, 0x14},
> > -       {0x4540, 0x00},
> > -       {0x47b4, 0x14},
> > -       {0x4713, 0x30},
> > -       {0x478b, 0x10},
> > -       {0x478f, 0x10},
> > -       {0x4793, 0x10},
> > -       {0x4797, 0x0e},
> > -       {0x479b, 0x0e},
> >  };
> >
> >  static const struct imx219_reg raw8_framefmt_regs[] = {
> > @@ -1041,6 +953,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> >         if (ret < 0)
> >                 return ret;
> >
> > +       /* Send the Manufacturing Header common to all modes */
>
> It's a table of common settings, not a manufacturing header.
> s/Send the Manufacturing Header/Send all registers that are

I used that term because the data sheet shows the following sequence:

{0x30eb, 0x0c},
{0x30eb, 0x05},
{0x300a, 0xff},
{0x300b, 0xff},
{0x30eb, 0x05},
{0x30eb, 0x09},

It's listed as "Manufacturer Specific Registers" to access
0x3000-5fff, the specific sequence as specified in 3-4.  The entire
table is common, but I tried to put comments into the sections to
explain what they do.


>
>  Dave
>
> > +       ret = imx219_write_regs(imx219, imx219_common_regs, ARRAY_SIZE(imx219_common_regs));
> > +       if (ret) {
> > +               dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
> > +               goto err_rpm_put;
> > +       }
> > +
> >         /* Apply default values of current mode */
> >         reg_list = &imx219->mode->reg_list;
> >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > --
> > 2.34.1
> >
