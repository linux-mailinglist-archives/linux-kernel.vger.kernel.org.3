Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261F55F9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiF2IBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiF2IBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:01:47 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710863AA59;
        Wed, 29 Jun 2022 01:01:46 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 726DB240011;
        Wed, 29 Jun 2022 08:01:43 +0000 (UTC)
Date:   Wed, 29 Jun 2022 10:01:41 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] media: ov5693: rename clk into xvclk
Message-ID: <20220629080141.if6zdpfodsomtd6j@uno.localdomain>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-4-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627150453.220292-4-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Mon, Jun 27, 2022 at 05:04:49PM +0200, Tommaso Merciai wrote:
> Rename clk pdata pointer into xvclk (system clock input).
> Same for clk_rate into xvclk_rate. This is more explicit
>
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Not sure this is really better, but I guess it doesn't hurt

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
  j

> ---
>  drivers/media/i2c/ov5693.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> index 9e84468d920e..d2adc5513a21 100644
> --- a/drivers/media/i2c/ov5693.c
> +++ b/drivers/media/i2c/ov5693.c
> @@ -157,7 +157,7 @@ struct ov5693_device {
>  	struct gpio_desc *reset;
>  	struct gpio_desc *powerdown;
>  	struct regulator_bulk_data supplies[OV5693_NUM_SUPPLIES];
> -	struct clk *clk;
> +	struct clk *xvclk;
>
>  	struct ov5693_mode {
>  		struct v4l2_rect crop;
> @@ -794,7 +794,7 @@ static void ov5693_sensor_powerdown(struct ov5693_device *ov5693)
>
>  	regulator_bulk_disable(OV5693_NUM_SUPPLIES, ov5693->supplies);
>
> -	clk_disable_unprepare(ov5693->clk);
> +	clk_disable_unprepare(ov5693->xvclk);
>  }
>
>  static int ov5693_sensor_powerup(struct ov5693_device *ov5693)
> @@ -804,7 +804,7 @@ static int ov5693_sensor_powerup(struct ov5693_device *ov5693)
>  	gpiod_set_value_cansleep(ov5693->reset, 1);
>  	gpiod_set_value_cansleep(ov5693->powerdown, 1);
>
> -	ret = clk_prepare_enable(ov5693->clk);
> +	ret = clk_prepare_enable(ov5693->xvclk);
>  	if (ret) {
>  		dev_err(ov5693->dev, "Failed to enable clk\n");
>  		goto fail_power;
> @@ -1390,7 +1390,7 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
>  static int ov5693_probe(struct i2c_client *client)
>  {
>  	struct ov5693_device *ov5693;
> -	u32 clk_rate;
> +	u32 xvclk_rate;
>  	int ret = 0;
>
>  	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
> @@ -1408,16 +1408,16 @@ static int ov5693_probe(struct i2c_client *client)
>
>  	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
>
> -	ov5693->clk = devm_clk_get(&client->dev, "xvclk");
> -	if (IS_ERR(ov5693->clk)) {
> +	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
> +	if (IS_ERR(ov5693->xvclk)) {
>  		dev_err(&client->dev, "Error getting clock\n");
> -		return PTR_ERR(ov5693->clk);
> +		return PTR_ERR(ov5693->xvclk);
>  	}
>
> -	clk_rate = clk_get_rate(ov5693->clk);
> -	if (clk_rate != OV5693_XVCLK_FREQ)
> +	xvclk_rate = clk_get_rate(ov5693->xvclk);
> +	if (xvclk_rate != OV5693_XVCLK_FREQ)
>  		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
> -			 clk_rate, OV5693_XVCLK_FREQ);
> +			 xvclk_rate, OV5693_XVCLK_FREQ);
>
>  	ret = ov5693_configure_gpios(ov5693);
>  	if (ret)
> --
> 2.25.1
>
