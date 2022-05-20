Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D152E50F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbiETGb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiETGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:31:55 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80685286EA;
        Thu, 19 May 2022 23:31:52 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 5483A100008;
        Fri, 20 May 2022 06:31:48 +0000 (UTC)
Date:   Fri, 20 May 2022 08:31:46 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] media: i2c: ov5675: add .get_selection support
Message-ID: <20220520063146.czduh63siiwmryen@uno.localdomain>
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-4-foss+kernel@0leil.net>
 <20220512090553.x7mzsj3ff3u5gqxq@uno.localdomain>
 <b77d43d5-4a50-3da2-67b4-65224a82a202@theobroma-systems.com>
 <20220517111814.gcu7zcog4atqzwdc@uno.localdomain>
 <9e1fc111-0a64-5a01-8ec2-77a9b60d1535@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e1fc111-0a64-5a01-8ec2-77a9b60d1535@theobroma-systems.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, May 17, 2022 at 02:47:06PM +0200, Quentin Schulz wrote:
> Hi Jacopo,
>
> On 5/17/22 13:18, Jacopo Mondi wrote:
> > Hi Quentin
> >
> > On Tue, May 17, 2022 at 11:25:17AM +0200, Quentin Schulz wrote:
> > > Hi Jacopo,
> > >
> > > On 5/12/22 11:05, Jacopo Mondi wrote:
> > > > Hi Quentin,
> > > >
> > > > On Mon, May 09, 2022 at 04:32:26PM +0200, Quentin Schulz wrote:
> > > > > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > > >
> > > > > The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
> > > > > pixels and there are an additional 24 black rows "at the bottom".
> > > > >
> > > > > As recommended in the SELECTION API documentation, let's put the first
> > > > > useful active pixel at the top/left corner (0,0).
> > > > >
> > > > > This window is the default and maximal crop allowed by the sensor.
> > > > >
> > > > > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > > > > ---
> > > > >
> > > > > added in v3
> > > > >
> > > > >    drivers/media/i2c/ov5675.c | 25 +++++++++++++++++++++++++
> > > > >    1 file changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> > > > > index 5544e1ae444e..8e3a5bc6c027 100644
> > > > > --- a/drivers/media/i2c/ov5675.c
> > > > > +++ b/drivers/media/i2c/ov5675.c
> > > > > @@ -78,6 +78,9 @@
> > > > >    #define OV5675_REG_FORMAT1		0x3820
> > > > >    #define OV5675_REG_FORMAT2		0x373d
> > > > >
> > > > > +#define OV5675_PIXEL_ARRAY_WIDTH	2592U
> > > > > +#define OV5675_PIXEL_ARRAY_HEIGHT	1944U
> > > > > +
> > > > >    #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
> > > > >
> > > > >    static const char * const ov5675_supply_names[] = {
> > > > > @@ -1115,6 +1118,27 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
> > > > >    	return 0;
> > > > >    }
> > > > >
> > > > > +static int ov5675_get_selection(struct v4l2_subdev *sd,
> > > > > +				struct v4l2_subdev_state *state,
> > > > > +				struct v4l2_subdev_selection *sel)
> > > > > +{
> > > > > +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	switch (sel->target) {
> > > > > +	case V4L2_SEL_TGT_CROP:
> > > > > +	case V4L2_SEL_TGT_CROP_DEFAULT:
> > > > > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> > > > > +		/* In HW, top/left corner is actually at (16,16) */
> > > > > +		sel->r.top = 0;
> > > > > +		sel->r.left = 0;
> > > > > +		sel->r.width = OV5675_PIXEL_ARRAY_WIDTH;
> > > > > +		sel->r.height = OV5675_PIXEL_ARRAY_HEIGHT;
> > > > > +		return 0;
> > > > > +	}
> > > >
> > > > CROP_NATIVE = the full pixel array size = 2592x1944
> > > >
> > > > CROP_BOUNDS = the rectangle that contains all possible crop
> > > >                 rectangles, aka the readable portion of your pixel array.
> > > >                 If in your case the sensor can read out dummy and non
> > > >                 active lines this is == NATIVE
> > > >
> > > > CROP_DEFAULT = the active/valid pixel area. If there are any
> > > >                  dummy/invalid lines the DEFAULT rectangle should not
> > > >                  include them
> > > >
> > > > CROP = the portion of the active pixel area cropped to produce the
> > > >          final image. You should look into the modes definition and
> > > >          inspect what values are programmed in register 0x380x (I don't
> > > >          have a datasheet hence I don't know what corresponds to what)
> > > >
> > > > Does this make any sense to you ?
> > > >
> > >
> > > It's difficult to make sense of the datasheet to be honest.
> > >
> >
> > Seems like it is made on purpose, isn't it :)
> >
> >
> > > There's a 3296x2480px "full-size" rectangle, then the sensor array output
> >
> > Are there that many blank/invalid lines/cols ?
> >
>
> Seems very unlikely, but it's in the schema..
>
> Can't rule out that they just reused the same schema they had for a bigger
> sensor and just didn't update the sizes for the full-size rectangle..
>
> > > area called CROP and configurable through registers 0x380x, then another
> > > output area called WIN (for window) also configurable through registers
> > > 0x380x. The WIN area seems to be just a mask applied on top of CROP area
> > > ("timing is not affected").
> > >
> > > On top of that, the schema shows 24 black lines - I assume - incorrectly,
> > > one after the start of the full-size rectangle, one after the end of the
> > > full-size rectangle.
> > >
> > > Then the sensor array area region in another section explicitly specifies
> > > the sensor to be 2624x2000px, active dummy pixels (2 16-pixel rows and
> > > columns) and black lines (1 24-pixel line) included. Which makes the actual
> > > useful area 2592x1944px.
> > >
> > > In the datasheet, the default size for the CROP area is
> > > 2624x1952px, offset (0,12) and for WIN it is 2592x1944px, offset (16,4)
> > > (assumed relative to CROP given the second coordinate).
> > >
> > > In the kernel driver though, the 2592x1944px mode configures the CROP area
> > > to be 2624x1968px offset (0,4) and the WIN area to be 2592x1944px, offset
> > > (16,13).
> > >
> > > The datasheet only ever mentions 2592x1944px as being the max resolution of
> > > the sensor though the sensor output area documentation and registers do not
> > > mention such a limitation.
> > >
> > > Since we're not modifying the crop area at the moment, CROP_DEFAULT and CROP
> > > would be the same, which would both be 2592x1944px.
> > >
> > > For the two others, I'm not sure. Any clue or hint with the info I just
> > > gave?
> >
> > Is my intrpretation of the above correct ?
> >
> >                       [2624]
> >          +------------------------------+
> >          |     |     16 dummy     |     |
> >          |------------------------------|
> >          |     |                  |     |
> >          |     |     [2592]       |     |
> >          |     |                  |     |
> >          |16   |      valid       | 16  |[2000]
> >          |dummy|                  |dummy|
> >          |     |            [1944]|     |
> >          |     |                  |     |
> >          |------------------------------|
> >          |     |     24 blacks    |     |
> >          |------------------------------|
> >          |     |     16 dummy     |     |
> >          -------------------------------|
> >
>
> the 24 black lines and 16 dummy pixels rows at the bottom are swapped, but
> otherwise yes.
>
> BTW, did you use a specific tool to make this schema?
>

Yes, a keyboard

:p

> >
> > Math looks right at least:
> >
> >          2000 - 16 - 24 - 16 = 1944
> >          2624 - 16 - 16 = 2592
> >
> > As V4L2 selection targets are defined in respect to they larger
> > sourrounding target, if the documentation about the full size array
> > (3296,2480) doesn't tell you what offset the readable part is, I think
> > it's fair to define
> >          - NATIVE == BOUNDS = (0, 0, 2624, 2000)
> >          - DEFAULT == CROP = (16, 16, 2592, 1944)
> >
> > Or maybe better not define NATIVE at all.
> >
> > The skipped rows/cols almost seems to match what the datasheet suggests by
> > combining the cropping and windowing rectangles top/left offsets (with
> > 2 cols more skipped compared to my understanding)
> >
> >          crop = (0, 12, 2624, 1952)
> >          win = (16, 6, 2592, 1944)
> >
> >          CROP = (16, 18, 2592, 1944)
> >
> > The driver does that a little differently with:
> >
> >          crop = (0, 4, 2624, 1968)
> >          win = (16, 13, 2592, 1944)
> >
> >          CROP = (16, 17, 2624, 1944)
> >
> > Which seems a little off as the driver values for the VTS and HTS
> > register counts from 0 hence it seems to be skipping 17 rows and 18
> > cols (maybe the driver adjusts when writing the values to registers ?)
> >
>
> Datasheet states that whatever the window, it'll reuse the timings of the
> crop ("Windowing is achieved by masking off the pixels outside of the
> window; thus, the original timing is not affected."). So I assume what
> matters it that the timings are right for the crop.
>

I assume that the "timings" the datasheet refers means the pixel array
sampling rate, which depends on the "crop" rectangle that define
the portion of the pixel array fed to the on-board ISP for processing
(mostly subsampling, as this seems to be a raw sensor ?)

The output frame rate will depend instead on the bus link frequency
and the total image size including blankings (usually configured
through the registers named VTS/HTS on OV sensors?)

> > If you feel like it you can try to adjust the driver rectangles, but
> > in my experience subtle regressions might be introduced by moving
> > those values, hence I would not be too concerned and just report
> > whatever the driver does. I assume you're doing this in the context of
> > pleasing libcamera requirements, and as much as I don't like saying
> > this, if we're 1 or 2 columns off when reporting the CROP rectangle,
> > it's not a huge issue.
> >
>
> Yes, this patch is for satisfying libcamera requirements.
>

The most important requirement is to expose VBLANK and PIXEL_RATE as
they're used calculate the sensor's frame rate. Selection targets are
mostly useful to populate the camera properties (ie the full pixel
array size) and to implement digitial zoom, somewhat and "advanced"
feature, hence they're optional to support.

Thanks
  j

> I also just saw that we actually support two modes for the sensor. So I'll
> need to get the width and height of the currently selected supported_modes.
> Fortunately, the window+crop offsets seem identical so there's no need to
> add some logic for those.
>
> I'll resend patch 3 and 4 separately so they can be merged and I'll continue
> fighting with runtime PM on our camera sensor, looking into HW if
> something's off there.
>
> Cheers,
> Quentin
