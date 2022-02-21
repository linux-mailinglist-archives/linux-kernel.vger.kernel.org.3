Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A84BD701
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbiBUHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:18:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbiBUHSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:18:05 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE7C14019;
        Sun, 20 Feb 2022 23:17:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8ACCF482;
        Mon, 21 Feb 2022 08:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645427847;
        bh=aSB52NNA4H92Oslixgeyy510diwPvOcyJd91kINF57c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlSHLBrDXvdSWLwOBbH7z38SPLDPRbp/mPG/gBe+ulwi/xzqbFc6bDYXOLadUDJB4
         5FYBuMgNCjUG3MPq0DvymghRTRKOwZgbbLqRyHPtFxQPq2TmC88wqbpyucwMD5IzwT
         oPzdhyvDd0La3qg9C2OeUUUAc1FNifOLgVy/6wuM=
Date:   Mon, 21 Feb 2022 09:17:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: Re: [PATCH v5 09/11] media: imx219: Introduce the set_routing
 operation
Message-ID: <YhM8fFae+Zmxymd3@pendragon.ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-10-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220208155027.891055-10-jeanmichel.hautbois@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Tue, Feb 08, 2022 at 04:50:25PM +0100, Jean-Michel Hautbois wrote:
> As we want to use multiplexed streams API, we need to be able to set the
> pad routing. Introduce the set_routing operation.
> 
> As this operation is required for a multiplexed able sensor, add the
> V4L2_SUBDEV_FL_MULTIPLEXED flag.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> ---
>  drivers/media/i2c/imx219.c | 82 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index abcaee15c4a0..35b61fad8e35 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -118,6 +118,10 @@
>  #define IMX219_PIXEL_ARRAY_WIDTH	3280U
>  #define IMX219_PIXEL_ARRAY_HEIGHT	2464U
>  
> +/* Embedded metadata stream structure */
> +#define IMX219_EMBEDDED_LINE_WIDTH	16384
> +#define IMX219_NUM_EMBEDDED_LINES	1
> +
>  struct imx219_reg {
>  	u16 address;
>  	u8 val;
> @@ -784,15 +788,85 @@ static void imx219_init_formats(struct v4l2_subdev_state *state)
>  	format->height = supported_modes[0].height;
>  	format->field = V4L2_FIELD_NONE;
>  	format->colorspace = V4L2_COLORSPACE_RAW;
> +
> +	if (state->routing.routes[1].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE) {

There's no guarantee the routing table will have 2 entries.

> +		format = v4l2_state_get_stream_format(state, 0, 1);
> +		format->code = MEDIA_BUS_FMT_METADATA_8;
> +		format->width = IMX219_EMBEDDED_LINE_WIDTH;
> +		format->height = 1;
> +		format->field = V4L2_FIELD_NONE;
> +		format->colorspace = V4L2_COLORSPACE_DEFAULT;
> +	}
>  }
>  
> -static int imx219_init_cfg(struct v4l2_subdev *sd,
> -			   struct v4l2_subdev_state *state)
> +static int __imx219_set_routing(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *state)
>  {
> +	struct v4l2_subdev_route routes[] = {
> +		{
> +			.source_pad = 0,
> +			.source_stream = 0,
> +			.flags = V4L2_SUBDEV_ROUTE_FL_IMMUTABLE |
> +				 V4L2_SUBDEV_ROUTE_FL_SOURCE |
> +				 V4L2_SUBDEV_ROUTE_FL_ACTIVE,
> +		},
> +		{

		}, {

> +			.source_pad = 0,
> +			.source_stream = 1,
> +			.flags = V4L2_SUBDEV_ROUTE_FL_SOURCE |
> +				 V4L2_SUBDEV_ROUTE_FL_ACTIVE,
> +		}
> +	};

That doesn't look right. You're hardcoding the routes, disregarding
completely what userspace wants to program. This default configuration
must move to .init_cfg().

> +
> +	struct v4l2_subdev_krouting routing = {
> +		.num_routes = ARRAY_SIZE(routes),
> +		.routes = routes,
> +	};
> +
> +	int ret;
> +
> +	ret = v4l2_subdev_set_routing(sd, state, &routing);
> +	if (ret)
> +		return ret;
> +
>  	imx219_init_formats(state);
> +
>  	return 0;
>  }
>  
> +static int imx219_set_routing(struct v4l2_subdev *sd,
> +			      struct v4l2_subdev_state *state,
> +			      enum v4l2_subdev_format_whence which,
> +			      struct v4l2_subdev_krouting *routing)
> +{
> +	int ret;
> +
> +	if (routing->num_routes == 0 || routing->num_routes > 2)
> +		return -EINVAL;
> +
> +	v4l2_subdev_lock_state(state);

Note for the future: v11 of the V4L2 streams series will handle locking
in the code, so you'll have to drop this (same in .init_cfg()).

> +
> +	ret = __imx219_set_routing(sd, state);
> +
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
> +static int imx219_init_cfg(struct v4l2_subdev *sd,
> +			   struct v4l2_subdev_state *state)
> +{
> +	int ret;
> +
> +	v4l2_subdev_lock_state(state);
> +
> +	ret = __imx219_set_routing(sd, state);
> +
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
>  static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *sd_state,
>  				 struct v4l2_subdev_mbus_code_enum *code)
> @@ -1251,6 +1325,7 @@ static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
>  	.get_fmt		= imx219_get_pad_format,
>  	.set_fmt		= imx219_set_pad_format,
>  	.get_selection		= imx219_get_selection,
> +	.set_routing		= imx219_set_routing,
>  	.enum_frame_size	= imx219_enum_frame_size,
>  };
>  
> @@ -1509,7 +1584,8 @@ static int imx219_probe(struct i2c_client *client)
>  
>  	/* Initialize subdev */
>  	imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> -			    V4L2_SUBDEV_FL_HAS_EVENTS;
> +			    V4L2_SUBDEV_FL_HAS_EVENTS |
> +			    V4L2_SUBDEV_FL_MULTIPLEXED;
>  	imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  
>  	/* Initialize source pad */

-- 
Regards,

Laurent Pinchart
