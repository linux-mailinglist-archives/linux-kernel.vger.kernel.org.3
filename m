Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFA4A9283
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 03:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356728AbiBDC4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 21:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBDC4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 21:56:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145FC061714;
        Thu,  3 Feb 2022 18:56:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A4DC472;
        Fri,  4 Feb 2022 03:56:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643943390;
        bh=J9NMebEAn3GMYcxYATkyoNOZFcu7Za4+C8jdfHFwAJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pXbxP5d3BF+T18ZrWI4yuua+9MUTXViPwUvc5JQsESQs0AmMM0DBRwKxSAydaQnja
         6cfavqQ0jrE70bAa8gOprW/QyqGIZTenYkAbeFr7x2a+z0gKyJPyr2Tt6VdNC8DvfB
         pWi9PzgHvTqvCmrOg/27VPEeL7ty7Lsxoopni2T0=
Date:   Fri, 4 Feb 2022 04:56:06 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [RFC PATCH v4 10/12] media: imx219: use a local v4l2_subdev to
 simplify reading
Message-ID: <YfyVxunwZtmdZsJe@pendragon.ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-11-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203175009.558868-11-jeanmichel.hautbois@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Thank you for the patch.

On Thu, Feb 03, 2022 at 06:50:07PM +0100, Jean-Michel Hautbois wrote:
> There is no need to dereference the imx219 structure. Use a local
> v4l2_subdev instead.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/i2c/imx219.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index 7d29cf2b06f8..7c224d007f3e 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -1492,6 +1492,7 @@ static int imx219_check_hwcfg(struct device *dev)
>  static int imx219_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> +	struct v4l2_subdev *sd;
>  	struct imx219 *imx219;
>  	int ret;
>  
> @@ -1499,7 +1500,8 @@ static int imx219_probe(struct i2c_client *client)
>  	if (!imx219)
>  		return -ENOMEM;
>  
> -	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
> +	sd = &imx219->sd;
> +	v4l2_i2c_subdev_init(sd, client, &imx219_subdev_ops);
>  
>  	/* Check the hardware configuration in device tree */
>  	if (imx219_check_hwcfg(dev))
> @@ -1566,21 +1568,21 @@ static int imx219_probe(struct i2c_client *client)
>  		goto error_power_off;
>  
>  	/* Initialize subdev */
> -	imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> -			    V4L2_SUBDEV_FL_HAS_EVENTS |
> -			    V4L2_SUBDEV_FL_MULTIPLEXED;
> -	imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> +	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> +		     V4L2_SUBDEV_FL_HAS_EVENTS |
> +		     V4L2_SUBDEV_FL_MULTIPLEXED;
> +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  
>  	/* Initialize source pad */
>  	imx219->pad.flags = MEDIA_PAD_FL_SOURCE;
>  
> -	ret = media_entity_pads_init(&imx219->sd.entity, 1, &imx219->pad);
> +	ret = media_entity_pads_init(&sd->entity, 1, &imx219->pad);
>  	if (ret) {
>  		dev_err(dev, "failed to init entity pads: %d\n", ret);
>  		goto error_handler_free;
>  	}
>  
> -	ret = v4l2_async_register_subdev_sensor(&imx219->sd);
> +	ret = v4l2_async_register_subdev_sensor(sd);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to register sensor sub-device: %d\n", ret);
>  		goto error_media_entity;
> @@ -1594,7 +1596,7 @@ static int imx219_probe(struct i2c_client *client)
>  	return 0;
>  
>  error_media_entity:
> -	media_entity_cleanup(&imx219->sd.entity);
> +	media_entity_cleanup(&sd->entity);
>  
>  error_handler_free:
>  	imx219_free_controls(imx219);

-- 
Regards,

Laurent Pinchart
