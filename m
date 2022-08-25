Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1A5A0FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiHYL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbiHYL6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:58:24 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9BA59AF;
        Thu, 25 Aug 2022 04:58:21 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 99039C000A;
        Thu, 25 Aug 2022 11:58:18 +0000 (UTC)
Date:   Thu, 25 Aug 2022 13:58:16 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Shravan.Chippa@microchip.com
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        Prakash.Battu@microchip.com
Subject: Re: [PATCH] media: i2c: imx334: support lower bandwidth mode
Message-ID: <20220825115816.47tw7rb76rtunovj@uno.localdomain>
References: <20220728063044.19276-1-shravan.chippa@microchip.com>
 <20220822155303.udtb6uoizmkskjzt@uno.localdomain>
 <PH0PR11MB5611FE8093B71ED0441409EE81729@PH0PR11MB5611.namprd11.prod.outlook.com>
 <20220825072943.7jmwmlxgkuozn3t6@uno.localdomain>
 <PH0PR11MB56110AD9A7BC229CACA7C46581729@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR11MB56110AD9A7BC229CACA7C46581729@PH0PR11MB5611.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Thu, Aug 25, 2022 at 11:09:03AM +0000, Shravan.Chippa@microchip.com wrote:
>
>
> > -----Original Message-----
> > From: Jacopo Mondi <jacopo@jmondi.org>
> > Sent: 25 August 2022 01:00 PM
> > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Conor Dooley - M52691
> > <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> > <Prakash.Battu@microchip.com>
> > Subject: Re: [PATCH] media: i2c: imx334: support lower bandwidth mode
> >
> > [You don't often get email from jacopo@jmondi.org. Learn why this is
> > important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> >
> > Hi Shravan
> >
> > On Thu, Aug 25, 2022 at 07:16:22AM +0000, Shravan.Chippa@microchip.com
> > wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jacopo Mondi <jacopo@jmondi.org>
> > > > Sent: 22 August 2022 09:23 PM
> > > > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > > > Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > > mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Conor Dooley - M52691
> > > > <Conor.Dooley@microchip.com>; Battu Prakash Reddy - I30399
> > > > <Prakash.Battu@microchip.com>
> > > > Subject: Re: [PATCH] media: i2c: imx334: support lower bandwidth
> > > > mode
> > > >
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> > > >
> > > > Hello Shravan,
> > > >
> > > > On Thu, Jul 28, 2022 at 12:00:44PM +0530, shravan kumar wrote:
> > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > > >
> > > > > Some platforms may not be capable of supporting the bandwidth
> > > > > required for 12 bit or 3840x2160 resolutions.
> > > > >
> > > > > Add support for dynamically selecting 10 bit and 1920x1080
> > > > > resolutions while leaving the existing configuration as default
> > > > >
> > > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > > Signed-off-by: Prakash Battu <Prakash.Battu@microchip.com>
> > > > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > > > ---
> > > > >  drivers/media/i2c/imx334.c | 306
> > > > > +++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 279 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/i2c/imx334.c
> > > > > b/drivers/media/i2c/imx334.c index 062125501788..d1fa4c4d4d9e
> > > > > 100644
> > > > > --- a/drivers/media/i2c/imx334.c
> > > > > +++ b/drivers/media/i2c/imx334.c
> > > > > @@ -79,7 +79,6 @@ struct imx334_reg_list {
> > > > >   * struct imx334_mode - imx334 sensor mode structure
> > > > >   * @width: Frame width
> > > > >   * @height: Frame height
> > > > > - * @code: Format code
> > > > >   * @hblank: Horizontal blanking in lines
> > > > >   * @vblank: Vertical blanking in lines
> > > > >   * @vblank_min: Minimal vertical blanking in lines @@ -91,7 +90,6
> > > > > @@ struct imx334_reg_list {  struct imx334_mode {
> > > > >       u32 width;
> > > > >       u32 height;
> > > > > -     u32 code;
> > > > >       u32 hblank;
> > > > >       u32 vblank;
> > > > >       u32 vblank_min;
> > > > > @@ -119,6 +117,7 @@ struct imx334_mode {
> > > > >   * @vblank: Vertical blanking in lines
> > > > >   * @cur_mode: Pointer to current selected sensor mode
> > > > >   * @mutex: Mutex for serializing sensor controls
> > > > > + * @cur_code: current selected format code
> > > > >   * @streaming: Flag indicating streaming state
> > > > >   */
> > > > >  struct imx334 {
> > > > > @@ -140,6 +139,7 @@ struct imx334 {
> > > > >       u32 vblank;
> > > > >       const struct imx334_mode *cur_mode;
> > > > >       struct mutex mutex;
> > > > > +     u32 cur_code;
> > > > >       bool streaming;
> > > > >  };
> > > > >
> > > > > @@ -147,6 +147,169 @@ static const s64 link_freq[] = {
> > > > >       IMX334_LINK_FREQ,
> > > > >  };
> > > > >
> > > > > +/* Sensor mode registers */
> > > > > +static const struct imx334_reg mode_1920x1080_regs[] = {
> > > > > +     {0x3000, 0x01},
> > > > > +     {0x3018, 0x04},
> > > > > +     {0x3030, 0xCA},
> > > > > +     {0x3031, 0x08},
> > > > > +     {0x3032, 0x00},
> > > > > +     {0x3034, 0x4C},
> > > > > +     {0x3035, 0x04},
> > > > > +     {0x302C, 0xF0},
> > > > > +     {0x302D, 0x03},
> > > > > +     {0x302E, 0x80},
> > > > > +     {0x302F, 0x07},
> > > > > +     {0x3074, 0xCC},
> > > > > +     {0x3075, 0x02},
> > > > > +     {0x308E, 0xCD},
> > > > > +     {0x308F, 0x02},
> > > > > +     {0x3076, 0x38},
> > > > > +     {0x3077, 0x04},
> > > > > +     {0x3090, 0x38},
> > > > > +     {0x3091, 0x04},
> > > > > +     {0x3308, 0x38},
> > > > > +     {0x3309, 0x04},
> > > > > +     {0x30C6, 0x00},
> > > > > +     {0x30C7, 0x00},
> > > > > +     {0x30CE, 0x00},
> > > > > +     {0x30CF, 0x00},
> > > > > +     {0x30D8, 0x18},
> > > > > +     {0x30D9, 0x0A},
> > > > > +     {0x304C, 0x00},
> > > > > +     {0x304E, 0x00},
> > > > > +     {0x304F, 0x00},
> > > > > +     {0x3050, 0x00},
> > > > > +     {0x30B6, 0x00},
> > > > > +     {0x30B7, 0x00},
> > > > > +     {0x3116, 0x08},
> > > > > +     {0x3117, 0x00},
> > > > > +     {0x31A0, 0x20},
> > > > > +     {0x31A1, 0x0F},
> > > > > +     {0x300C, 0x3B},
> > > > > +     {0x300D, 0x29},
> > > > > +     {0x314C, 0x29},
> > > > > +     {0x314D, 0x01},
> > > > > +     {0x315A, 0x0A},
> > > > > +     {0x3168, 0xA0},
> > > > > +     {0x316A, 0x7E},
> > > > > +     {0x319E, 0x02},
> > > > > +     {0x3199, 0x00},
> > > > > +     {0x319D, 0x00},
> > > > > +     {0x31DD, 0x03},
> > > > > +     {0x3300, 0x00},
> > > > > +     {0x341C, 0xFF},
> > > > > +     {0x341D, 0x01},
> > > > > +     {0x3A01, 0x03},
> > > > > +     {0x3A18, 0x7F},
> > > > > +     {0x3A19, 0x00},
> > > > > +     {0x3A1A, 0x37},
> > > > > +     {0x3A1B, 0x00},
> > > > > +     {0x3A1C, 0x37},
> > > > > +     {0x3A1D, 0x00},
> > > > > +     {0x3A1E, 0xF7},
> > > > > +     {0x3A1F, 0x00},
> > > > > +     {0x3A20, 0x3F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x6F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x3F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x5F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3A20, 0x2F},
> > > > > +     {0x3A21, 0x00},
> > > > > +     {0x3078, 0x02},
> > > > > +     {0x3079, 0x00},
> > > > > +     {0x307A, 0x00},
> > > > > +     {0x307B, 0x00},
> > > > > +     {0x3080, 0x02},
> > > > > +     {0x3081, 0x00},
> > > > > +     {0x3082, 0x00},
> > > > > +     {0x3083, 0x00},
> > > > > +     {0x3088, 0x02},
> > > > > +     {0x3094, 0x00},
> > > > > +     {0x3095, 0x00},
> > > > > +     {0x3096, 0x00},
> > > > > +     {0x309B, 0x02},
> > > > > +     {0x309C, 0x00},
> > > > > +     {0x309D, 0x00},
> > > > > +     {0x309E, 0x00},
> > > > > +     {0x30A4, 0x00},
> > > > > +     {0x30A5, 0x00},
> > > > > +     {0x3288, 0x21},
> > > > > +     {0x328A, 0x02},
> > > > > +     {0x3414, 0x05},
> > > > > +     {0x3416, 0x18},
> > > > > +     {0x35AC, 0x0E},
> > > > > +     {0x3648, 0x01},
> > > > > +     {0x364A, 0x04},
> > > > > +     {0x364C, 0x04},
> > > > > +     {0x3678, 0x01},
> > > > > +     {0x367C, 0x31},
> > > > > +     {0x367E, 0x31},
> > > > > +     {0x3708, 0x02},
> > > > > +     {0x3714, 0x01},
> > > > > +     {0x3715, 0x02},
> > > > > +     {0x3716, 0x02},
> > > > > +     {0x3717, 0x02},
> > > > > +     {0x371C, 0x3D},
> > > > > +     {0x371D, 0x3F},
> > > > > +     {0x372C, 0x00},
> > > > > +     {0x372D, 0x00},
> > > > > +     {0x372E, 0x46},
> > > > > +     {0x372F, 0x00},
> > > > > +     {0x3730, 0x89},
> > > > > +     {0x3731, 0x00},
> > > > > +     {0x3732, 0x08},
> > > > > +     {0x3733, 0x01},
> > > > > +     {0x3734, 0xFE},
> > > > > +     {0x3735, 0x05},
> > > > > +     {0x375D, 0x00},
> > > > > +     {0x375E, 0x00},
> > > > > +     {0x375F, 0x61},
> > > > > +     {0x3760, 0x06},
> > > > > +     {0x3768, 0x1B},
> > > > > +     {0x3769, 0x1B},
> > > > > +     {0x376A, 0x1A},
> > > > > +     {0x376B, 0x19},
> > > > > +     {0x376C, 0x18},
> > > > > +     {0x376D, 0x14},
> > > > > +     {0x376E, 0x0F},
> > > > > +     {0x3776, 0x00},
> > > > > +     {0x3777, 0x00},
> > > > > +     {0x3778, 0x46},
> > > > > +     {0x3779, 0x00},
> > > > > +     {0x377A, 0x08},
> > > > > +     {0x377B, 0x01},
> > > > > +     {0x377C, 0x45},
> > > > > +     {0x377D, 0x01},
> > > > > +     {0x377E, 0x23},
> > > > > +     {0x377F, 0x02},
> > > > > +     {0x3780, 0xD9},
> > > > > +     {0x3781, 0x03},
> > > > > +     {0x3782, 0xF5},
> > > > > +     {0x3783, 0x06},
> > > > > +     {0x3784, 0xA5},
> > > > > +     {0x3788, 0x0F},
> > > > > +     {0x378A, 0xD9},
> > > > > +     {0x378B, 0x03},
> > > > > +     {0x378C, 0xEB},
> > > > > +     {0x378D, 0x05},
> > > > > +     {0x378E, 0x87},
> > > > > +     {0x378F, 0x06},
> > > > > +     {0x3790, 0xF5},
> > > > > +     {0x3792, 0x43},
> > > > > +     {0x3794, 0x7A},
> > > > > +     {0x3796, 0xA1},
> > > > > +     {0x37B0, 0x37},
> > > > > +     {0x3E04, 0x0E},
> > > > > +     {0x30E8, 0x50},
> > > > > +     {0x30E9, 0x00},
> > > > > +     {0x3E04, 0x0E},
> > > > > +     {0x3002, 0x00},
> > > > > +};
> > > > > +
> > > > >  /* Sensor mode registers */
> > > > >  static const struct imx334_reg mode_3840x2160_regs[] = {
> > > > >       {0x3000, 0x01},
> > > > > @@ -243,20 +406,57 @@ static const struct imx334_reg
> > > > mode_3840x2160_regs[] = {
> > > > >       {0x3a00, 0x01},
> > > > >  };
> > > > >
> > > > > +static const struct imx334_reg raw10_framefmt_regs[] = {
> > > > > +     {0x3050, 0x00},
> > > > > +     {0x319D, 0x00},
> > > > > +     {0x341C, 0xFF},
> > > > > +     {0x341D, 0x01},
> > > > > +};
> > > > > +
> > > > > +static const struct imx334_reg raw12_framefmt_regs[] = {
> > > > > +     {0x3050, 0x01},
> > > > > +     {0x319D, 0x01},
> > > > > +     {0x341C, 0x47},
> > > > > +     {0x341D, 0x00},
> > > > > +};
> > > > > +
> > > > > +/*
> > > > >
> > > > > + */
> > > > > +static const u32 codes[] = {
> > > >
> > > > Just "codes" is a little vague ? What about imx334_mbus_codes[] ?
> > > >
> > > > > +     MEDIA_BUS_FMT_SRGGB10_1X10,
> > > > > +     MEDIA_BUS_FMT_SRGGB12_1X12,
> > > > > +};
> > > > > +
> > > > >  /* Supported sensor mode configurations */ -static const struct
> > > > > imx334_mode supported_mode = {
> > > > > -     .width = 3840,
> > > > > -     .height = 2160,
> > > > > -     .hblank = 560,
> > > > > -     .vblank = 2340,
> > > > > -     .vblank_min = 90,
> > > > > -     .vblank_max = 132840,
> > > > > -     .pclk = 594000000,
> > > > > -     .link_freq_idx = 0,
> > > > > -     .code = MEDIA_BUS_FMT_SRGGB12_1X12,
> > > > > -     .reg_list = {
> > > > > -             .num_of_regs = ARRAY_SIZE(mode_3840x2160_regs),
> > > > > -             .regs = mode_3840x2160_regs,
> > > > > +static const struct imx334_mode supported_modes[] = {
> > > > > +     {
> > > > > +             .width = 1920,
> > > > > +             .height = 1080,
> > > > > +             .hblank = 280,
> > > > > +             .vblank = 1170,
> > > > > +             .vblank_min = 90,
> > > > > +             .vblank_max = 132840,
> > > > > +             .pclk = 594000000,
> > > > > +             .link_freq_idx = 0,
> > > > > +             .reg_list = {
> > > > > +                     .num_of_regs = ARRAY_SIZE(mode_1920x1080_regs),
> > > > > +                     .regs = mode_1920x1080_regs,
> > > > > +             },
> > > > > +     },
> > > > > +     {
> > > > > +             .width = 3840,
> > > > > +             .height = 2160,
> > > > > +             .hblank = 560,
> > > > > +             .vblank = 2340,
> > > > > +             .vblank_min = 90,
> > > > > +             .vblank_max = 132840,
> > > > > +             .pclk = 594000000,
> > > > > +             .link_freq_idx = 0,
> > > > > +             .reg_list = {
> > > > > +                     .num_of_regs = ARRAY_SIZE(mode_3840x2160_regs),
> > > > > +                     .regs = mode_3840x2160_regs,
> > > > > +             },
> > > >
> > > > Nit: I would keep the existing formats and code in position [0] so
> > > > that if additional modes are added the defaults can be kept in [0].
> > > > Also I usually see drivers listing larger modes first, but that might not be a
> > strict rule.
> > > >
> > > > >       },
> > > > >  };
> > > > >
> > > > > @@ -382,7 +582,8 @@ static int imx334_update_controls(struct
> > > > > imx334
> > > > *imx334,
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > -     ret = __v4l2_ctrl_s_ctrl(imx334->hblank_ctrl, mode->hblank);
> > > > > +     ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl,
> > > > IMX334_REG_MIN,
> > > > > +                                    IMX334_REG_MAX, 1,
> > > > > + mode->hblank);
> > > >
> > > > I might have missed why is this change related
> > >
> > > Hblank is readonly variable.
> > > If I use __v4l2_ctrl_s_ctrl function update return error.
> >
> > So it's a separate fix unrelated to the introduction of the new mode ?
> >
> > Probably it never triggered before as we had a single mode so the control
> > was actually never updated, but it's a fix worth a patch of his own maybe.
> >
> > I would make a separate patch before this one or clearly mention in the
> > commit message that also this is changed and why.
> >
> > > >
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > @@ -506,10 +707,10 @@ static int imx334_enum_mbus_code(struct
> > > > v4l2_subdev *sd,
> > > > >                                struct v4l2_subdev_state *sd_state,
> > > > >                                struct v4l2_subdev_mbus_code_enum
> > > > > *code)  {
> > > > > -     if (code->index > 0)
> > > > > +     if (code->index >= ARRAY_SIZE(codes))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     code->code = supported_mode.code;
> > > > > +     code->code = codes[code->index];
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > > @@ -526,15 +727,20 @@ static int imx334_enum_frame_size(struct
> > > > v4l2_subdev *sd,
> > > > >                                 struct v4l2_subdev_state *sd_state,
> > > > >                                 struct v4l2_subdev_frame_size_enum
> > > > > *fsize)  {
> > > > > -     if (fsize->index > 0)
> > > > > +     int i;
> > > > > +
> > > > > +     if (fsize->index >= ARRAY_SIZE(supported_modes))
> > > > >               return -EINVAL;
> > > > >
> > > > > -     if (fsize->code != supported_mode.code)
> > > > > +     for (i = 0; i < ARRAY_SIZE(codes); i++) {
> > > >
> > > > Can we use for (unsigned int i = 0; ... ) now that C99 has been adopted ?
> > >
> > > C99 might be adopted.
> > > But I have not observered no one is started using.
> > >
> >
> > $ git grep -e "for (unsigned " -e "for (int " v6.0-rc2  | wc -l
> > 186
> >
> > > >
> > > > > +             if (codes[i] == fsize->code)
> > > > > +                     break;
> > > > >               return -EINVAL;
> > > >
> > > > Are you sure this is right ?
> > > > If the format code in fsize->code is == codes[1] you will return -EINVAL ?
> > >
> > > I think this will break the for loop, if fsize->code is == codes[1]
> >
> > Yes but before getting to codes[1] you would test codes[0] and if
> > fsize->code != codes[0] you will return -EINVAL
> >
> > Am I reading this wrong ?
> >
>
> Yes, I am wrong
>
> If (codes[0] != fsize->code  &&  codes[1] != fsize->code )
> 	return -EINVAL
>

Or, if you want to generalize it for future modes:

        unsigned int i;

        for (i = 0; i < ARRAY_SIZE(codes); ++i) {
                if (codes[i] == fsize->code)
                        break;
        }

        if (i == ARRAY_SIZE(codes))
                return -EINVAL;

Thanks
  j

> > > >
> > > > Does the sensor support more formats than
> > > > MEDIA_BUS_FMT_SRGGB10_1X10 and
> > MEDIA_BUS_FMT_SRGGB12_1X12 ?
> > > > Because otherwise you could replace the for loop with a simple check.
> > > >
> > > > However support for flip might change the bayer pattern, so it's
> > > > better to keep the loop maybe.
> > > >
> > > > What about centrlize it like you're doing in
> > > > imx219_get_format_code() and use it here ? You can place the helper
> > > > just after the supported mbus codes declaration maybe ?
> > > >
> > > Yes, it is good. But imx334 do not have direct register to do VFLIP.
> > >
> > > >
> > > > > +     }
> > > > >
> > > > > -     fsize->min_width = supported_mode.width;
> > > > > +     fsize->min_width = supported_modes[fsize->index].width;
> > > > >       fsize->max_width = fsize->min_width;
> > > > > -     fsize->min_height = supported_mode.height;
> > > > > +     fsize->min_height = supported_modes[fsize->index].height;
> > > > >       fsize->max_height = fsize->min_height;
> > > > >
> > > > >       return 0;
> > > > > @@ -553,7 +759,7 @@ static void imx334_fill_pad_format(struct
> > > > > imx334 *imx334,  {
> > > > >       fmt->format.width = mode->width;
> > > > >       fmt->format.height = mode->height;
> > > > > -     fmt->format.code = mode->code;
> > > > > +     fmt->format.code = imx334->cur_code;
> > > > >       fmt->format.field = V4L2_FIELD_NONE;
> > > > >       fmt->format.colorspace = V4L2_COLORSPACE_RAW;
> > > > >       fmt->format.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT; @@ -591,6
> > > > > +797,18 @@ static int imx334_get_pad_format(struct v4l2_subdev
> > > > > +*sd,
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > +static int imx219_get_format_code(struct imx334 *imx334, struct
> > > > > +v4l2_subdev_format *fmt) {
> > > > > +     int i;
> > > > > +
> > > > > +     for (i = 0; i < ARRAY_SIZE(codes); i++) {
> > > >
> > > > Ditto, unsigned int and possibily declared inside the for loop
> > > >
> > > > > +             if (codes[i] == fmt->format.code)
> > > > > +                     return codes[i];
> > > > > +     }
> > > > > +
> > > > > +     return -EINVAL;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * imx334_set_pad_format() - Set subdevice pad format
> > > > >   * @sd: pointer to imx334 V4L2 sub-device structure @@ -606,10
> > > > > +824,21 @@ static int imx334_set_pad_format(struct v4l2_subdev
> > > > > +*sd,
> > > > >       struct imx334 *imx334 = to_imx334(sd);
> > > > >       const struct imx334_mode *mode;
> > > > >       int ret = 0;
> > > > > +     u32 code;
> > > > >
> > > > >       mutex_lock(&imx334->mutex);
> > > > >
> > > > > -     mode = &supported_mode;
> > > > > +     code = imx219_get_format_code(imx334, fmt);
> > > > > +     if (code < 0)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     imx334->cur_code = code;
> > > > > +
> > > > > +     mode = v4l2_find_nearest_size(supported_modes,
> > > > > +                                   ARRAY_SIZE(supported_modes),
> > > > > +                                   width, height,
> > > > > +                                   fmt->format.width,
> > > > > + fmt->format.height);
> > > > > +
> > > > >       imx334_fill_pad_format(imx334, mode, fmt);
> > > > >
> > > > >       if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) { @@ -617,7 +846,7
> > > > @@
> > > > > static int imx334_set_pad_format(struct v4l2_subdev *sd,
> > > > >
> > > > >               framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt-
> > >pad);
> > > > >               *framefmt = fmt->format;
> > > > > -     } else {
> > > > > +     } else if (imx334->cur_mode != mode) {
> > > >
> > > > Is this change related ? I think it's good as it avoids an
> > > > unecessary update of the controls, but maybe it's not related to this
> > patch ?
> > >
> > > I have updated mode[] array new set of value, Insated of calling
> > > functions simply.
> > > Just added a check the the mode changed then only we need to updated
> > > other parameters Same as imx219 code
> >
> > You're right, we had a single mode before this change :)
> >
> > >
> > > Thanks,
> > > Shravan
> > >
> > > >
> > > > Thanks
> > > >   j
> > > >
> > > > >               ret = imx334_update_controls(imx334, mode);
> > > > >               if (!ret)
> > > > >                       imx334->cur_mode = mode; @@ -642,11 +871,26
> > > > > @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
> > > > >       struct v4l2_subdev_format fmt = { 0 };
> > > > >
> > > > >       fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> > > > V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > > -     imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > > > +     imx334_fill_pad_format(imx334, &supported_modes[1], &fmt);
> > > > >
> > > > >       return imx334_set_pad_format(sd, sd_state, &fmt);  }
> > > > >
> > > > > +static int imx334_set_framefmt(struct imx334 *imx334) {
> > > > > +     switch (imx334->cur_code) {
> > > > > +     case MEDIA_BUS_FMT_SRGGB10_1X10:
> > > > > +             return imx334_write_regs(imx334,
> > > > > +raw10_framefmt_regs,
> > > > > +
> > > > > +ARRAY_SIZE(raw10_framefmt_regs));
> > > > > +
> > > > > +     case MEDIA_BUS_FMT_SRGGB12_1X12:
> > > > > +             return imx334_write_regs(imx334, raw12_framefmt_regs,
> > > > > +                                     ARRAY_SIZE(raw12_framefmt_regs));
> > > > > +     }
> > > > > +
> > > > > +     return -EINVAL;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * imx334_start_streaming() - Start sensor stream
> > > > >   * @imx334: pointer to imx334 device @@ -667,6 +911,13 @@ static
> > > > > int imx334_start_streaming(struct imx334
> > > > *imx334)
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > +     ret = imx334_set_framefmt(imx334);
> > > > > +     if (ret) {
> > > > > +             dev_err(imx334->dev, "%s failed to set frame format: %d\n",
> > > > > +                     __func__, ret);
> > > > > +             return ret;
> > > > > +     }
> > > > > +
> > > > >       /* Setup handler will write actual exposure and gain */
> > > > >       ret =  __v4l2_ctrl_handler_setup(imx334->sd.ctrl_handler);
> > > > >       if (ret) {
> > > > > @@ -1037,7 +1288,8 @@ static int imx334_probe(struct i2c_client
> > *client)
> > > > >       }
> > > > >
> > > > >       /* Set default mode to max resolution */
> > > > > -     imx334->cur_mode = &supported_mode;
> > > > > +     imx334->cur_mode = &supported_modes[1];
> > > > > +     imx334->cur_code = codes[1];
> > > > >       imx334->vblank = imx334->cur_mode->vblank;
> > > > >
> > > > >       ret = imx334_init_controls(imx334);
> > > > > --
> > > > > 2.17.1
> > > > >
