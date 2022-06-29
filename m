Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36556056A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiF2QIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiF2QIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:08:02 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FB2AE69;
        Wed, 29 Jun 2022 09:08:00 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D94BD240002;
        Wed, 29 Jun 2022 16:07:57 +0000 (UTC)
Date:   Wed, 29 Jun 2022 18:07:56 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] media: ov5693: move hw cfg functions into
 ov5693_hwcfg
Message-ID: <20220629160756.s6vh7r3uqj62oaqd@uno.localdomain>
References: <20220629152933.422990-1-tommaso.merciai@amarulasolutions.com>
 <20220629152933.422990-5-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220629152933.422990-5-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Wed, Jun 29, 2022 at 05:29:31PM +0200, Tommaso Merciai wrote:
> Move hw configuration functions into ov5693_hwcfg. This is done to
> separate the code that handle the hw cfg from probe in a clean way.
> Add also support to get clock from "clock-frequency" fwnode in
> ov5675_hwcfg function

Why ? :)

What about:

"Add support for ACPI-based platforms that specify the clock frequency by
using the "clock-frequency" property instead of specifying a clock
provider reference."

>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Not on this patch, but it seems you have not collected the tags
received on the previous version of the series.

> ---
> Changes since v2:
>  - Fix commit body as suggested by Sakari, Jacopo
>  - Add details to commit body as suggested Jacopo
>  - Move ov5693_check_hwcfg into ov5693_hwcfg
>  - Fix xvclk_rate position as suggested Jacopo

Also fixed a bug it seems :)

>
>  drivers/media/i2c/ov5693.c | 57 +++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index d2adc5513a21..3c805a5a5181 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -1339,16 +1339,48 @@ static int ov5693_get_regulators(struct ov5693_device *ov5693)
>  				       ov5693->supplies);
>  }
>
> -static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
> +static int ov5693_hwcfg(struct ov5693_device *ov5693)
>  {
>  	struct fwnode_handle *fwnode = dev_fwnode(ov5693->dev);
>  	struct v4l2_fwnode_endpoint bus_cfg = {
>  		.bus_type = V4L2_MBUS_CSI2_DPHY,
>  	};
>  	struct fwnode_handle *endpoint;
> +	u32 xvclk_rate;
>  	unsigned int i;
>  	int ret;
>
> +	ov5693->xvclk = devm_clk_get_optional(ov5693->dev, "xvclk");
> +	if (IS_ERR(ov5693->xvclk))
> +		return dev_err_probe(ov5693->dev, PTR_ERR(ov5693->xvclk),
> +				     "failed to get xvclk: %ld\n",
> +				     PTR_ERR(ov5693->xvclk));
> +
> +	if (ov5693->xvclk) {
> +		xvclk_rate = clk_get_rate(ov5693->xvclk);
> +	} else {
> +		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
> +					       &xvclk_rate);
> +
> +		if (ret) {
> +			dev_err(ov5693->dev, "can't get clock frequency");
> +			return ret;
> +		}
> +	}

This now looks good to me, thanks!

> +
> +	if (xvclk_rate != OV5693_XVCLK_FREQ)
> +		dev_warn(ov5693->dev, "Found clk freq %u, expected %u\n",
> +			 xvclk_rate, OV5693_XVCLK_FREQ);
> +
> +	ret = ov5693_configure_gpios(ov5693);
> +	if (ret)
> +		return ret;
> +
> +	ret = ov5693_get_regulators(ov5693);
> +	if (ret)
> +		return dev_err_probe(ov5693->dev, ret,
> +				     "Error fetching regulators\n");
> +
>  	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
>  	if (!endpoint)
>  		return -EPROBE_DEFER; /* Could be provided by cio2-bridge */
> @@ -1390,7 +1422,6 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
>  static int ov5693_probe(struct i2c_client *client)
>  {
>  	struct ov5693_device *ov5693;
> -	u32 xvclk_rate;
>  	int ret = 0;

No need for ret to be intialized, but it was already like this...

The patch itself looks good
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

>
>  	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
> @@ -1400,7 +1431,7 @@ static int ov5693_probe(struct i2c_client *client)
>  	ov5693->client = client;
>  	ov5693->dev = &client->dev;
>
> -	ret = ov5693_check_hwcfg(ov5693);
> +	ret = ov5693_hwcfg(ov5693);
>  	if (ret)
>  		return ret;
>
> @@ -1408,26 +1439,6 @@ static int ov5693_probe(struct i2c_client *client)
>
>  	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
>
> -	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
> -	if (IS_ERR(ov5693->xvclk)) {
> -		dev_err(&client->dev, "Error getting clock\n");
> -		return PTR_ERR(ov5693->xvclk);
> -	}
> -
> -	xvclk_rate = clk_get_rate(ov5693->xvclk);
> -	if (xvclk_rate != OV5693_XVCLK_FREQ)
> -		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
> -			 xvclk_rate, OV5693_XVCLK_FREQ);
> -
> -	ret = ov5693_configure_gpios(ov5693);
> -	if (ret)
> -		return ret;
> -
> -	ret = ov5693_get_regulators(ov5693);
> -	if (ret)
> -		return dev_err_probe(&client->dev, ret,
> -				     "Error fetching regulators\n");
> -
>  	ov5693->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  	ov5693->pad.flags = MEDIA_PAD_FL_SOURCE;
>  	ov5693->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> --
> 2.25.1
>
