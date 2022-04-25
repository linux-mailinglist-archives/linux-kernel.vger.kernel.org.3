Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E2950E6EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbiDYRVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiDYRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:21:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC3726E7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:17:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y21so12371607edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gX2ZWb8LxEmg8Owput65gpyxR2lw6m8J6Sik1QnH9uQ=;
        b=NcRr4ingWeUGSu1ZKplng7CZcPwJ37SB2gZf3J3srm47JUqal9uBlISJ17yZkOldn5
         ESOGytFqM2IKb5/bYT+BUjYB2tLXsT2+tLZDQMvWM0PQV/ZcGOh8Jr8MT2RJFmfJ+ZpL
         XPXZSWj9z1a02FlYMLHE3Fkdm9lSIFJ6uCMrcrlVgKuco+He09+rcqN2gwwEk4cVvTKY
         QiRiQTp9eBsLtDMgDJHqwyURu4BGjSo+XGaMmlMJgCQtbLApGeV4BkM94y3vMslNTIwd
         hCFpqyrDTCiY+4wbrjVRge29GoTZgts3F0NOoecy+ooCm/3WbFsx4HaGnD74bp6l4p+Z
         +KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gX2ZWb8LxEmg8Owput65gpyxR2lw6m8J6Sik1QnH9uQ=;
        b=Bgxw7266dVWDcGb7Ao7pXV3Z9WKuh0tgtbB8abaQEkfN0HGzUYrUtHNZv3w55GA2jp
         LtijUV9lA2ncxdMjbND+89cje7K54d6obiJl4uedNJfoKS4dwkv0MgN6oeRGPqgYlOyM
         wXx5N7+8QxKrcfF7RPWud1K9AOAjrcZiOMgzB//R11Y6Pi5Cw15DisJTbbaPbyDJX0da
         DBZP7eKRCBGyLBmfAQ8S0PpVObYfivaW6qTUCHsUJGY1RdJT3FGb2Em9jxjxVSHPGja+
         T9OxlWTa/UpKdgDvQZnp6S+AdOl0/NZotoNuAlC7I5HXc9yRX4kS1gOP1/PbwoOfvAAq
         F/XA==
X-Gm-Message-State: AOAM5307Z1UU1AEcGKuujidmmtEFN/zyQ4aCHTSPaG17sHaXWkmvizLt
        54e0gt+5XpVldMlENeZF8acd361ilxgX05gJJdqx3g==
X-Google-Smtp-Source: ABdhPJxP3/tkzNqhW7/0VP/ox9oCJLWZP134CdSdEC3LqMnzwTw7RmNLUF5esfxs2UgdzQ2wWhN4aTQNyqXeV3taY4I=
X-Received: by 2002:a05:6402:26c7:b0:423:e5d6:b6c6 with SMTP id
 x7-20020a05640226c700b00423e5d6b6c6mr20007275edd.61.1650907076801; Mon, 25
 Apr 2022 10:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220412135534.2796158-1-aford173@gmail.com> <20220412135534.2796158-2-aford173@gmail.com>
 <CAPY8ntCKxRMFX023BsM70bA0UbPApzOzLbg+2X0SU93_GABKiA@mail.gmail.com> <CAHCN7xK_y6XhyksrPdcgCH24T0n46kJDNtvk2awoDCouWrDsMg@mail.gmail.com>
In-Reply-To: <CAHCN7xK_y6XhyksrPdcgCH24T0n46kJDNtvk2awoDCouWrDsMg@mail.gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 25 Apr 2022 18:17:40 +0100
Message-ID: <CAPY8ntCbSdspgFLS2yXdgL07RAhMoPXerpfOYw7yb-TUo-apyw@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: i2c: imx219: Split common registers from mode tables
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Tim Harvey <tharvey@gateworks.com>,
        cstevens@beaconembedded.com,
        Adam Ford-BE <aford@beaconembedded.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam

On Mon, 25 Apr 2022 at 17:51, Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Apr 25, 2022 at 11:20 AM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Adam
> >
> > On Tue, 12 Apr 2022 at 14:55, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > There are four modes, and each mode has a table of registers.
> > > Some of the registers are common to all modes, so create new
> > > tables for these common registers to reduce duplicate code.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > >  drivers/media/i2c/imx219.c | 103 ++++++++++++++-----------------------
> > >  1 file changed, 39 insertions(+), 64 deletions(-)
> > >
> > > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > > index e10af3f74b38..b7cc36b16547 100644
> > > --- a/drivers/media/i2c/imx219.c
> > > +++ b/drivers/media/i2c/imx219.c
> > > @@ -145,19 +145,36 @@ struct imx219_mode {
> > >         struct imx219_reg_list reg_list;
> > >  };
> > >
> > > -/*
> > > - * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > > - * driver.
> > > - * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > > - */
> > > -static const struct imx219_reg mode_3280x2464_regs[] = {
> > > -       {0x0100, 0x00},
> > > +/* To Access Addresses 3000-5fff, send the following commands */
> > > +static const struct imx219_reg mfg_specific_reg[] = {
> > > +       {0x0100, 0x00}, /* Mode Select */
> > >         {0x30eb, 0x0c},
> > >         {0x30eb, 0x05},
> > >         {0x300a, 0xff},
> > >         {0x300b, 0xff},
> > >         {0x30eb, 0x05},
> > >         {0x30eb, 0x09},
> > > +};
> > > +
> > > +static const struct imx219_reg pll_clk_table[] = {
> > > +
> > > +       {0x0301, 0x05}, /* VTPXCK_DIV */
> > > +       {0x0303, 0x01}, /* VTSYSCK_DIV */
> > > +       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> > > +       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
> > > +       {0x0306, 0x00}, /* PLL_VT_MPY */
> > > +       {0x0307, 0x39},
> > > +       {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> > > +       {0x030c, 0x00}, /* PLL_OP_MPY */
> > > +       {0x030d, 0x72},
> > > +};
> >
> > (I've come back to this patch last as my first reading was happy with it)
> > Is there a good reason for making these two tables instead of one with
> > comments as to what the registers are doing?
>
> The pll_clk tables were written after the resolution settings before I
> split them.  I was concerned about having all the common tables in one
> place, because registers would be set in a different order than they
> were originally.  I wasn't sure if the pll clock tables needed to be
> set after the resolution or not.  It seemed possible to me that it
> wouldn't necessarily know how to set the clocks without knowing the
> desired resolution.  I can certainly merge them together and run some
> tests to see if there are regressions.  If there are none, I can keep
> them in a common block.
>
> I can certainly add comments to indicate what's being done.  I had
> thought about it.

More often PLL settings are set before the resolution configuration.

The initialisation sequence for imx219 was provided by Sony, but I
note that the datasheet that Table 37 "Initialization sequence with
XCLR" lists:
- (1) to (3): Refer power up sequence timing diagram
- (4) Set PLL parameters. Basic setting. Set Readout mode. Set MIPI parameters
- (5) Start streaming with 0x0100 (mode_select = 1)
So I really wouldn't be concerned about setting the PLL registers
before the resolution. The PLL configuration is mode independent as
the pixel rate and link frequency are effectively fixed.

  Dave

> >
> > As per my comment on patch 4, one table of registers setting these,
> > the DPHY register, and registers
> >     {0x455e, 0x00},
> >     {0x471e, 0x4b},
> >     {0x4767, 0x0f},
> >     {0x4750, 0x14},
> >     {0x4540, 0x00},
> >     {0x47b4, 0x14},
> >     {0x4713, 0x30},
> >     {0x478b, 0x10},
> >     {0x478f, 0x10},
> >     {0x4793, 0x10},
> >     {0x4797, 0x0e},
> >     {0x479b, 0x0e},
> >     {0x0162, 0x0d},
> >     {0x0163, 0x78},
> > would remove the duplication, reduce the code size, and be slightly
> > more readable.
> >
> >   Dave
> >
> > > +/*
> > > + * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > > + * driver.
> > > + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > > + */
> > > +static const struct imx219_reg mode_3280x2464_regs[] = {
> > >         {0x0114, 0x01},
> > >         {0x0128, 0x00},
> > >         {0x012a, 0x18},
> > > @@ -178,15 +195,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
> > >         {0x0171, 0x01},
> > >         {0x0174, 0x00},
> > >         {0x0175, 0x00},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x0c},
> > >         {0x0625, 0xd0},
> > >         {0x0626, 0x09},
> > > @@ -208,13 +216,6 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
> > >  };
> > >
> > >  static const struct imx219_reg mode_1920_1080_regs[] = {
> > > -       {0x0100, 0x00},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x0c},
> > > -       {0x300a, 0xff},
> > > -       {0x300b, 0xff},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x09},
> > >         {0x0114, 0x01},
> > >         {0x0128, 0x00},
> > >         {0x012a, 0x18},
> > > @@ -237,15 +238,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
> > >         {0x0171, 0x01},
> > >         {0x0174, 0x00},
> > >         {0x0175, 0x00},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x07},
> > >         {0x0625, 0x80},
> > >         {0x0626, 0x04},
> > > @@ -265,13 +257,6 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
> > >  };
> > >
> > >  static const struct imx219_reg mode_1640_1232_regs[] = {
> > > -       {0x0100, 0x00},
> > > -       {0x30eb, 0x0c},
> > > -       {0x30eb, 0x05},
> > > -       {0x300a, 0xff},
> > > -       {0x300b, 0xff},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x09},
> > >         {0x0114, 0x01},
> > >         {0x0128, 0x00},
> > >         {0x012a, 0x18},
> > > @@ -292,15 +277,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
> > >         {0x0171, 0x01},
> > >         {0x0174, 0x01},
> > >         {0x0175, 0x01},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x06},
> > >         {0x0625, 0x68},
> > >         {0x0626, 0x04},
> > > @@ -322,13 +298,6 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
> > >  };
> > >
> > >  static const struct imx219_reg mode_640_480_regs[] = {
> > > -       {0x0100, 0x00},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x0c},
> > > -       {0x300a, 0xff},
> > > -       {0x300b, 0xff},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x09},
> > >         {0x0114, 0x01},
> > >         {0x0128, 0x00},
> > >         {0x012a, 0x18},
> > > @@ -351,15 +320,6 @@ static const struct imx219_reg mode_640_480_regs[] = {
> > >         {0x0171, 0x01},
> > >         {0x0174, 0x03},
> > >         {0x0175, 0x03},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x06},
> > >         {0x0625, 0x68},
> > >         {0x0626, 0x04},
> > > @@ -1041,6 +1001,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > +       /* Send the Manufacturing Header common to all modes */
> > > +       ret = imx219_write_regs(imx219, mfg_specific_reg, ARRAY_SIZE(mfg_specific_reg));
> > > +       if (ret) {
> > > +               dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
> > > +               goto err_rpm_put;
> > > +       }
> > > +
> > >         /* Apply default values of current mode */
> > >         reg_list = &imx219->mode->reg_list;
> > >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > > @@ -1056,6 +1023,14 @@ static int imx219_start_streaming(struct imx219 *imx219)
> > >                 goto err_rpm_put;
> > >         }
> > >
> > > +       /* Configure the PLL clocks */
> > > +       ret = imx219_write_regs(imx219, pll_clk_table, ARRAY_SIZE(pll_clk_table));
> > > +       if (ret) {
> > > +               dev_err(&client->dev, "%s failed to sent PLL clocks\n", __func__);
> > > +               goto err_rpm_put;
> > > +       }
> > > +
> > > +
> > >         /* Apply customized values from user */
> > >         ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
> > >         if (ret)
> > > --
> > > 2.34.1
> > >
