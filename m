Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D480539100
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbiEaMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239853AbiEaMpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:45:54 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000ED6EB22;
        Tue, 31 May 2022 05:45:52 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4EEC720005;
        Tue, 31 May 2022 12:45:49 +0000 (UTC)
Date:   Tue, 31 May 2022 14:45:47 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] media: i2c: ov5675: add .get_selection support
Message-ID: <20220531124547.vqfrqbs5d37l3z6h@uno.localdomain>
References: <20220525145833.1165437-1-foss+kernel@0leil.net>
 <20220525145833.1165437-4-foss+kernel@0leil.net>
 <20220531105011.yxrosmwtw3mpaomb@uno.localdomain>
 <842dbd3c-856b-e5a8-e942-545ceb6741ca@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <842dbd3c-856b-e5a8-e942-545ceb6741ca@theobroma-systems.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

On Tue, May 31, 2022 at 02:19:21PM +0200, Quentin Schulz wrote:
> Hi Jacopo,
>
> On 5/31/22 12:50, Jacopo Mondi wrote:
> > Hi Quentin
> >
> > On Wed, May 25, 2022 at 04:58:33PM +0200, Quentin Schulz wrote:
> > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > >
> > > The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
> > > pixels and there are an additional 24 black rows "at the bottom".
> > >
> > >                       [2624]
> > >          +-----+------------------+-----+
> > >          |     |     16 dummy     |     |
> > >          +-----+------------------+-----+
> > >          |     |                  |     |
> > >          |     |     [2592]       |     |
> > >          |     |                  |     |
> > >          |16   |      valid       | 16  |[2000]
> > >          |dummy|                  |dummy|
> > >          |     |            [1944]|     |
> > >          |     |                  |     |
> > >          +-----+------------------+-----+
> > >          |     |     16 dummy     |     |
> > >          +-----+------------------+-----+
> > >          |     |  24 black lines  |     |
> > >          +-----+------------------+-----+
> > >
> > > The top-left coordinate is gotten from the registers specified in the
> > > modes which are identical for both currently supported modes.
> > >
> > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > ---
> > >
> > > v4:
> > >   - explicit a bit more the commit log,
> > >   - added drawing in the commit log,
> > >   - fixed reporting for V4L2_SEL_TGT_CROP_* thanks to Jacopo's help,
> > >
> > > added in v3
> > >
> > >   drivers/media/i2c/ov5675.c | 33 +++++++++++++++++++++++++++++++++
> > >   1 file changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> > > index c1f3c387afde0..384a9ea2372c3 100644
> > > --- a/drivers/media/i2c/ov5675.c
> > > +++ b/drivers/media/i2c/ov5675.c
> > > @@ -1121,6 +1121,38 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
> > >   	return 0;
> > >   }
> > >
> > > +static int ov5675_get_selection(struct v4l2_subdev *sd,
> > > +				struct v4l2_subdev_state *state,
> > > +				struct v4l2_subdev_selection *sel)
> > > +{
> > > +	struct ov5675 *ov5675 = to_ov5675(sd);
> > > +
> > > +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > > +		return -EINVAL;
> > > +
> > > +	switch (sel->target) {
> > > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> > > +		sel->r.top = 0;
> > > +		sel->r.left = 0;
> > > +		sel->r.width = 2624;
> > > +		sel->r.height = 2000;
> > > +		return 0;
> > > +	case V4L2_SEL_TGT_CROP:
> > > +		sel->r.top = 16;
> > > +		sel->r.left = 16;
> > > +		sel->r.width = ov5675->cur_mode->width;
> > > +		sel->r.height = ov5675->cur_mode->height;
> > > +		return 0;
> >
> > I'm afraid this doesn't match exactly my understanding of the
> > discussion we had.
> >
> > The driver defines the following modes
> >
> > /*
> >   * OV5670 sensor supports following resolutions with full FOV:
> >   * 4:3  ==> {2592x1944, 1296x972, 648x486}
> >   * 16:9 ==> {2560x1440, 1280x720, 640x360}
> >   */
> > static const struct ov5670_mode supported_modes[] = {
> > 	{
> > 		.width = 2592,
> > 		.height = 1944,
> > 	},
> > 	{
> > 		.width = 1296,
> > 		.height = 972,
> > 	},
> > 	{
> > 		.width = 648,
> > 		.height = 486,
> > 	},
> > 	{
> > 		.width = 2560,
> > 		.height = 1440,
> > 	},
> > 	{
> > 		.width = 1280,
> > 		.height = 720,
> > 	},
> > 	{
> > 		.width = 640,
> > 		.height = 360,
> > 	}
> > };
> >
> > The comment says all modes retain the "full FOV", which I assume it
> > implies they are obtained by sub-sampling and not cropping.
> >
> > The first three modes (4:3) are indeed obtained by subsampling the
> > full active pixel array:
> >
> >          (2592,1944) / 2 = (1296,972) / 2 = (648,486)
> >
> > The last three are obtained by subsampling a slightly cropped portion
> > of the pixel array
> >
> >          (2560,1440) / 2 = (1280,720) / 2 = (640,360)
> >
> > If you set CROP = cur_mode->[width/height] you will instead report the
> > visible width/height, which as said it's obtained by subsampling (of a
> > slightly cropped portion of the pixel array for the last three ones)
> >
> > The CROP rectangle is then (2592, 1944) for the first three and (2560,
> > 1440) for the last three.
> >
> > I would add a v4l2_rect to struct ov5670_mode where to record that and
> > report it here.
> >
>
> That makes a lot of sense to me, thanks for your patience and explanations.
>
> FYI, you're looking at the wrong driver (ov5670 vs ov5675; a mistake I make

You know what's depressing ? -I- have a series out for ov5670 :(
I'm so sorry, my brain got short-circuited by that probably...

> every now and then too :) ). However, the datasheet does say that "The
> OV5675 supports a binning mode to provide a lower resolution output while
> maintaining the field of view.[...] The OV5675 supports 2x2 binning." so I
> assume we're in the same scenario as you just explained.
>
> Since the OV5675 modes currently supported by the drivers are 4/3 only and
> the smaller size mode a result of subsampling, they both have the same CROP
> rectangle.
>

Thankfully the comment still applies to ov5675 then, and both modes
have the same (2592, 1944) crop rectangle :)

> > > +	case V4L2_SEL_TGT_CROP_DEFAULT:
> > > +		sel->r.top = 16;
> > > +		sel->r.left = 16;
> > > +		sel->r.width = supported_modes[0].width;
> > > +		sel->r.height = supported_modes[0].height;
> > > +		return 0;
> >
> > You could also define these values instead of fishing in the
> > supported_modes array, to protect against future changes to the array
> > itself. Up to you.
> >
>
> Since there's no cropping involved in the current modes, I assume we could
> just hardcode the width and height and tackle this limitation later, once we
> add more modes or support for configuring cropping (this patch only adds the
> getter and not the setter).

Fine with me!

Sorry again for the slip!

>
> Cheers,
> Quentin
