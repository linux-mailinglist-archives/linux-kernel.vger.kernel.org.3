Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC655FA34
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiF2IQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiF2IQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:16:42 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD293BA5D;
        Wed, 29 Jun 2022 01:16:40 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 732FFE000A;
        Wed, 29 Jun 2022 08:16:37 +0000 (UTC)
Date:   Wed, 29 Jun 2022 10:16:35 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Daniel Scally <djrscally@gmail.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] media: ov5693: move hw cfg functions into
 ov5693_check_hwcfg
Message-ID: <20220629081635.zvdj6pzodg4rhrdf@uno.localdomain>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-5-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627150453.220292-5-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Mon, Jun 27, 2022 at 05:04:50PM +0200, Tommaso Merciai wrote:
> Move hw configuration functions into ov5693_check_hwcfg. This is done to
> separe the code that handle the hw cfg from probe in a clean way

s/separe/separate/

You also seem to change the logic of the clk handling, please mention
this in the commit message, otherwise one could be fooled into
thinking you're only moving code around with no functional changes...

>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  drivers/media/i2c/ov5693.c | 53 +++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index d2adc5513a21..d5a934ace597 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -1348,6 +1348,38 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
>  	struct fwnode_handle *endpoint;
>  	unsigned int i;
>  	int ret;
> +	u32 xvclk_rate;

nit: move it up to maintain reverse-xmas-tree order (I know, it's an
annoying comment, but since variables are already declared in this order..)

> +
> +	ov5693->xvclk = devm_clk_get(ov5693->dev, "xvclk");

Isn't this broken ?

if you use ov5693->xvclk to identify the ACPI vs OF use case shouldn't
you use the get_optionl() version ? Otherwise in the ACPI case you will have
-ENOENT if there's not 'xvclk' property and bail out.

Unless my understanding is wrong on ACPI we have "clock-frequency" and
on OF "xvclk" with an "assigned-clock-rates",

Dan you upstreamed this driver and I assume it was tested on ACPI ?
Can you clarify how this worked for you, as it seems the original code
wanted a mandatory "xvclk" ? Are there ACPI tables with an actual
'xvclk' property ?

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
>
>  	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
>  	if (!endpoint)
> @@ -1390,7 +1422,6 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
>  static int ov5693_probe(struct i2c_client *client)
>  {
>  	struct ov5693_device *ov5693;
> -	u32 xvclk_rate;
>  	int ret = 0;
>
>  	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
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
