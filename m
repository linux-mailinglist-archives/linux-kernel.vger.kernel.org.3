Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D652488E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiELJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351820AbiELJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:06:05 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B2F1EADA;
        Thu, 12 May 2022 02:05:59 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 3B9F5240002;
        Thu, 12 May 2022 09:05:54 +0000 (UTC)
Date:   Thu, 12 May 2022 11:05:53 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v3 4/4] media: i2c: ov5675: add .get_selection support
Message-ID: <20220512090553.x7mzsj3ff3u5gqxq@uno.localdomain>
References: <20220509143226.531117-1-foss+kernel@0leil.net>
 <20220509143226.531117-4-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220509143226.531117-4-foss+kernel@0leil.net>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, May 09, 2022 at 04:32:26PM +0200, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
> pixels and there are an additional 24 black rows "at the bottom".
>
> As recommended in the SELECTION API documentation, let's put the first
> useful active pixel at the top/left corner (0,0).
>
> This window is the default and maximal crop allowed by the sensor.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>
> added in v3
>
>  drivers/media/i2c/ov5675.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
> index 5544e1ae444e..8e3a5bc6c027 100644
> --- a/drivers/media/i2c/ov5675.c
> +++ b/drivers/media/i2c/ov5675.c
> @@ -78,6 +78,9 @@
>  #define OV5675_REG_FORMAT1		0x3820
>  #define OV5675_REG_FORMAT2		0x373d
>
> +#define OV5675_PIXEL_ARRAY_WIDTH	2592U
> +#define OV5675_PIXEL_ARRAY_HEIGHT	1944U
> +
>  #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
>
>  static const char * const ov5675_supply_names[] = {
> @@ -1115,6 +1118,27 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
>  	return 0;
>  }
>
> +static int ov5675_get_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
> +		return -EINVAL;
> +
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP:
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		/* In HW, top/left corner is actually at (16,16) */
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = OV5675_PIXEL_ARRAY_WIDTH;
> +		sel->r.height = OV5675_PIXEL_ARRAY_HEIGHT;
> +		return 0;
> +	}

CROP_NATIVE = the full pixel array size = 2592x1944

CROP_BOUNDS = the rectangle that contains all possible crop
              rectangles, aka the readable portion of your pixel array.
              If in your case the sensor can read out dummy and non
              active lines this is == NATIVE

CROP_DEFAULT = the active/valid pixel area. If there are any
               dummy/invalid lines the DEFAULT rectangle should not
               include them

CROP = the portion of the active pixel area cropped to produce the
       final image. You should look into the modes definition and
       inspect what values are programmed in register 0x380x (I don't
       have a datasheet hence I don't know what corresponds to what)

Does this make any sense to you ?

Thanks
  j

> +	return -EINVAL;
> +}
> +
>  static int ov5675_enum_mbus_code(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *sd_state,
>  				 struct v4l2_subdev_mbus_code_enum *code)
> @@ -1164,6 +1188,7 @@ static const struct v4l2_subdev_video_ops ov5675_video_ops = {
>  static const struct v4l2_subdev_pad_ops ov5675_pad_ops = {
>  	.set_fmt = ov5675_set_format,
>  	.get_fmt = ov5675_get_format,
> +	.get_selection = ov5675_get_selection,
>  	.enum_mbus_code = ov5675_enum_mbus_code,
>  	.enum_frame_size = ov5675_enum_frame_size,
>  };
> --
> 2.35.3
>
