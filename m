Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89E450E62D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiDYQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiDYQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:54:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF0015FF7;
        Mon, 25 Apr 2022 09:51:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u15so30731040ejf.11;
        Mon, 25 Apr 2022 09:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jheCLNNChkLj/HYsztoOjTLG6HSbS6rrP6TOZ0/SX0M=;
        b=Otmrq5iRxqNp8bQzmw7rjrOpdQCDTXHkYxDC3LYmZK7aJGjOdDnNtQy1/jX/zQsiQj
         TzsfxrDA22sG1nr4BCdPIHmlexc9lkmR2FMWRg2C1eMhE0Vz0/7+3u1NSKLa8kY2D/vh
         E3xnW2ki4RYI6X2+fuTMdnCLazuuofqRnzGm6MecVOjUZlaoG9kvtad5yD0f1NzbcCCq
         1TAIOijdyWW17d95PwPT17wyhB+jzK6pG5eNpl+Wqic2QECfMHidb29YGUwtLtua8Ffh
         LCQTVbWUSJJuiKd19n/njcsaqzDQwDIsTTwbDJyjkDwVorDEP13/a0aPKPwnRWbTT9u8
         pxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jheCLNNChkLj/HYsztoOjTLG6HSbS6rrP6TOZ0/SX0M=;
        b=GlC21HehRuKNN5V3o4OkpMnoPl8el0ZU5HZi87YkGziQF/CnwZ5kuQwIHNHT504cNM
         PTlz8EoG4CBc3emPXWyX3DecoZPeM6tnXmz4rjmfeN+fCUM0NLVyWys35K8Xu2KxTrl5
         GRD5d1Q6eERoddbEKw6XR1Ffmc3LoHZB4xFWf+PGsCeNmA1Z/Rn5DATk2WJWHH7sIT0Y
         8Oe6y1JYAjSq2uf0COTwmVWP5cu3K630hpYZBax4XSNwtSi6p2O/I5bP//BQyxyuPpMf
         HljeTu6vqO1hxPzbBcf6bR4sXeRnz1R1ty2fSQK0E0pu7S96qkbg/Hsi94ufKCMi49bO
         OFrA==
X-Gm-Message-State: AOAM531PlPgYUuqiHhzI/Q9UMnG0W6UlyMmFcpXgjGaaUvaFeHGDCSlE
        pgZZ1IT9TDqJOpmR1W7HQWdZv/9t7jRqOgX6zk8=
X-Google-Smtp-Source: ABdhPJxl0FrQNEBTwssJQEzPm6bDLlJn4uMc9tlz8EkZAfyKeLQ5pJpJ76UzNDtip8B0sFiDU0SGHwZLbeKAJZtUPjs=
X-Received: by 2002:a17:907:1c13:b0:6f0:106f:6c90 with SMTP id
 nc19-20020a1709071c1300b006f0106f6c90mr17729486ejc.504.1650905467250; Mon, 25
 Apr 2022 09:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com> <20220412135534.2796158-2-aford173@gmail.com>
 <CAPY8ntCKxRMFX023BsM70bA0UbPApzOzLbg+2X0SU93_GABKiA@mail.gmail.com>
In-Reply-To: <CAPY8ntCKxRMFX023BsM70bA0UbPApzOzLbg+2X0SU93_GABKiA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 25 Apr 2022 11:50:56 -0500
Message-ID: <CAHCN7xK_y6XhyksrPdcgCH24T0n46kJDNtvk2awoDCouWrDsMg@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: i2c: imx219: Split common registers from mode tables
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tim Harvey <tharvey@gateworks.com>,
        cstevens@beaconembedded.com,
        Adam Ford-BE <aford@beaconembedded.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Apr 25, 2022 at 11:20 AM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Adam
>
> On Tue, 12 Apr 2022 at 14:55, Adam Ford <aford173@gmail.com> wrote:
> >
> > There are four modes, and each mode has a table of registers.
> > Some of the registers are common to all modes, so create new
> > tables for these common registers to reduce duplicate code.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  drivers/media/i2c/imx219.c | 103 ++++++++++++++-----------------------
> >  1 file changed, 39 insertions(+), 64 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > index e10af3f74b38..b7cc36b16547 100644
> > --- a/drivers/media/i2c/imx219.c
> > +++ b/drivers/media/i2c/imx219.c
> > @@ -145,19 +145,36 @@ struct imx219_mode {
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
> > +static const struct imx219_reg mfg_specific_reg[] = {
> > +       {0x0100, 0x00}, /* Mode Select */
> >         {0x30eb, 0x0c},
> >         {0x30eb, 0x05},
> >         {0x300a, 0xff},
> >         {0x300b, 0xff},
> >         {0x30eb, 0x05},
> >         {0x30eb, 0x09},
> > +};
> > +
> > +static const struct imx219_reg pll_clk_table[] = {
> > +
> > +       {0x0301, 0x05}, /* VTPXCK_DIV */
> > +       {0x0303, 0x01}, /* VTSYSCK_DIV */
> > +       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> > +       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
> > +       {0x0306, 0x00}, /* PLL_VT_MPY */
> > +       {0x0307, 0x39},
> > +       {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> > +       {0x030c, 0x00}, /* PLL_OP_MPY */
> > +       {0x030d, 0x72},
> > +};
>
> (I've come back to this patch last as my first reading was happy with it)
> Is there a good reason for making these two tables instead of one with
> comments as to what the registers are doing?

The pll_clk tables were written after the resolution settings before I
split them.  I was concerned about having all the common tables in one
place, because registers would be set in a different order than they
were originally.  I wasn't sure if the pll clock tables needed to be
set after the resolution or not.  It seemed possible to me that it
wouldn't necessarily know how to set the clocks without knowing the
desired resolution.  I can certainly merge them together and run some
tests to see if there are regressions.  If there are none, I can keep
them in a common block.

I can certainly add comments to indicate what's being done.  I had
thought about it.
>
> As per my comment on patch 4, one table of registers setting these,
> the DPHY register, and registers
>     {0x455e, 0x00},
>     {0x471e, 0x4b},
>     {0x4767, 0x0f},
>     {0x4750, 0x14},
>     {0x4540, 0x00},
>     {0x47b4, 0x14},
>     {0x4713, 0x30},
>     {0x478b, 0x10},
>     {0x478f, 0x10},
>     {0x4793, 0x10},
>     {0x4797, 0x0e},
>     {0x479b, 0x0e},
>     {0x0162, 0x0d},
>     {0x0163, 0x78},
> would remove the duplication, reduce the code size, and be slightly
> more readable.
>
>   Dave
>
> > +/*
> > + * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > + * driver.
> > + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > + */
> > +static const struct imx219_reg mode_3280x2464_regs[] = {
> >         {0x0114, 0x01},
> >         {0x0128, 0x00},
> >         {0x012a, 0x18},
> > @@ -178,15 +195,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
> >         {0x0171, 0x01},
> >         {0x0174, 0x00},
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
> > @@ -208,13 +216,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
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
> >         {0x0114, 0x01},
> >         {0x0128, 0x00},
> >         {0x012a, 0x18},
> > @@ -237,15 +238,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
> >         {0x0171, 0x01},
> >         {0x0174, 0x00},
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
> > @@ -265,13 +257,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
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
> >         {0x0114, 0x01},
> >         {0x0128, 0x00},
> >         {0x012a, 0x18},
> > @@ -292,15 +277,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
> >         {0x0171, 0x01},
> >         {0x0174, 0x01},
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
> > @@ -322,13 +298,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
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
> >         {0x0114, 0x01},
> >         {0x0128, 0x00},
> >         {0x012a, 0x18},
> > @@ -351,15 +320,6 @@ static const struct imx219_reg mode_640_480_regs[] = {
> >         {0x0171, 0x01},
> >         {0x0174, 0x03},
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
> > @@ -1041,6 +1001,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> >         if (ret < 0)
> >                 return ret;
> >
> > +       /* Send the Manufacturing Header common to all modes */
> > +       ret = imx219_write_regs(imx219, mfg_specific_reg, ARRAY_SIZE(mfg_specific_reg));
> > +       if (ret) {
> > +               dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
> > +               goto err_rpm_put;
> > +       }
> > +
> >         /* Apply default values of current mode */
> >         reg_list = &imx219->mode->reg_list;
> >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > @@ -1056,6 +1023,14 @@ static int imx219_start_streaming(struct imx219 *imx219)
> >                 goto err_rpm_put;
> >         }
> >
> > +       /* Configure the PLL clocks */
> > +       ret = imx219_write_regs(imx219, pll_clk_table, ARRAY_SIZE(pll_clk_table));
> > +       if (ret) {
> > +               dev_err(&client->dev, "%s failed to sent PLL clocks\n", __func__);
> > +               goto err_rpm_put;
> > +       }
> > +
> > +
> >         /* Apply customized values from user */
> >         ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
> >         if (ret)
> > --
> > 2.34.1
> >
