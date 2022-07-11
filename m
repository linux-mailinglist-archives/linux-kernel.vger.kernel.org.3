Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333145708E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiGKRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiGKRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:31:34 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC86110C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:31:33 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 6C06720008;
        Mon, 11 Jul 2022 17:31:25 +0000 (UTC)
Date:   Mon, 11 Jul 2022 19:31:23 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: i2c: ak7375: Add regulator management
Message-ID: <20220711173123.55abjsli3tmqgegj@uno.localdomain>
References: <20220711144039.232196-1-y.oudjana@protonmail.com>
 <20220711144039.232196-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711144039.232196-4-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yassine,

On Mon, Jul 11, 2022 at 06:40:39PM +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Make the driver get needed regulators on probe and enable/disable
> them on runtime PM callbacks.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v1:
>   - Reorganize variable declaration
>   - Change the power-on delay range to 3000-3500 microseconds.
>
>  drivers/media/i2c/ak7375.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
> index 40b1a4aa846c..c2b2542a0056 100644
> --- a/drivers/media/i2c/ak7375.c
> +++ b/drivers/media/i2c/ak7375.c
> @@ -6,6 +6,7 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
>
> @@ -23,17 +24,32 @@
>   */
>  #define AK7375_CTRL_STEPS	64
>  #define AK7375_CTRL_DELAY_US	1000
> +/*
> + * The vcm takes around 3 ms to power on and start taking
> + * I2C messages. This value was found experimentally due to
> + * lack of documentation.
> + */
> +#define AK7375_POWER_DELAY_US	3000
>
>  #define AK7375_REG_POSITION	0x0
>  #define AK7375_REG_CONT		0x2
>  #define AK7375_MODE_ACTIVE	0x0
>  #define AK7375_MODE_STANDBY	0x40
>
> +static const char * const ak7375_supply_names[] = {
> +	"vdd",
> +	"vio",
> +};
> +
> +#define AK7375_NUM_SUPPLIES ARRAY_SIZE(ak7375_supply_names)
> +
>  /* ak7375 device structure */
>  struct ak7375_device {
>  	struct v4l2_ctrl_handler ctrls_vcm;
>  	struct v4l2_subdev sd;
>  	struct v4l2_ctrl *focus;
> +	struct regulator_bulk_data supplies[AK7375_NUM_SUPPLIES];
> +
>  	/* active or standby mode */
>  	bool active;
>  };
> @@ -133,12 +149,24 @@ static int ak7375_probe(struct i2c_client *client)
>  {
>  	struct ak7375_device *ak7375_dev;
>  	int ret;
> +	int i;
>
>  	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
>  				  GFP_KERNEL);
>  	if (!ak7375_dev)
>  		return -ENOMEM;
>
> +	for (i = 0; i < AK7375_NUM_SUPPLIES; i++)
> +		ak7375_dev->supplies[i].supply = ak7375_supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(&client->dev, AK7375_NUM_SUPPLIES,
> +				      ak7375_dev->supplies);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to get regulators: %pe",
> +			ERR_PTR(ret));

Why are you using %pe here ? Your return value is not a pointer
(Also, missing \n at the end of the string)

From Documentation/core-api/printk-formats.rst:
	%pe	-ENOSPC

For printing error pointers (i.e. a pointer for which IS_ERR() is true)
as a symbolic error name. Error values for which no symbolic name is
known are printed in decimal, while a non-ERR_PTR passed as the
argument to %pe gets treated as ordinary %p.

> +		return ret;
> +	}
> +
>  	v4l2_i2c_subdev_init(&ak7375_dev->sd, client, &ak7375_ops);
>  	ak7375_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>  	ak7375_dev->sd.internal_ops = &ak7375_int_ops;
> @@ -210,6 +238,10 @@ static int __maybe_unused ak7375_vcm_suspend(struct device *dev)
>  	if (ret)
>  		dev_err(dev, "%s I2C failure: %d\n", __func__, ret);
>
> +	ret = regulator_bulk_disable(AK7375_NUM_SUPPLIES, ak7375_dev->supplies);
> +	if (ret)
> +		return ret;
> +
>  	ak7375_dev->active = false;
>
>  	return 0;
> @@ -230,6 +262,13 @@ static int __maybe_unused ak7375_vcm_resume(struct device *dev)
>  	if (ak7375_dev->active)
>  		return 0;
>
> +	ret = regulator_bulk_enable(AK7375_NUM_SUPPLIES, ak7375_dev->supplies);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for vcm to become ready */
> +	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 500);
> +
>  	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
>  		AK7375_MODE_ACTIVE, 1);
>  	if (ret) {
> --
> 2.37.0
>
