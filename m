Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5761B57045C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiGKNef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGKNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:34:33 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DFD20BCF;
        Mon, 11 Jul 2022 06:34:29 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 68C5560011;
        Mon, 11 Jul 2022 13:34:25 +0000 (UTC)
Date:   Mon, 11 Jul 2022 15:34:23 +0200
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
Subject: Re: [PATCH 3/3] media: i2c: ak7375: Add regulator management
Message-ID: <20220711133423.w6yzbcfqwv2muu34@uno.localdomain>
References: <20220711042838.213351-1-y.oudjana@protonmail.com>
 <20220711042838.213351-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711042838.213351-4-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yassine

On Mon, Jul 11, 2022 at 08:28:39AM +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Make the driver get needed regulators on probe and enable/disable
> them on runtime PM callbacks.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/media/i2c/ak7375.c | 39 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/media/i2c/ak7375.c b/drivers/media/i2c/ak7375.c
> index 40b1a4aa846c..59d5cb00e3ba 100644
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
> + * lack of documentation. 2 ms is added as a safety margin.
> + */
> +#define AK7375_POWER_DELAY_US	5000
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
> @@ -132,6 +148,7 @@ static int ak7375_init_controls(struct ak7375_device *dev_vcm)
>  static int ak7375_probe(struct i2c_client *client)
>  {
>  	struct ak7375_device *ak7375_dev;
> +	int i;

I would have moved this one down to maintain variable declaration
in the in-famous reverse-xmas-tree ordering. Up to you.

>  	int ret;
>
>  	ak7375_dev = devm_kzalloc(&client->dev, sizeof(*ak7375_dev),
> @@ -139,6 +156,17 @@ static int ak7375_probe(struct i2c_client *client)
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
> +	usleep_range(AK7375_POWER_DELAY_US, AK7375_POWER_DELAY_US + 10);
> +

Isn't 10usec a very small delay to be given to usleep_range() for a
delay of at least 3msec ? Also assuming 5msec just to be safe seems a
little arbitrary. Adding 2 milliseconds in the wakeup path introduces
a non-negligible delay.

It's likely a detail, but according to Documentation/timers/timers-howto.rst

        Since usleep_range is built on top of hrtimers, the
        wakeup will be very precise (ish), thus a simple
        usleep function would likely introduce a large number
        of undesired interrupts.

        With the introduction of a range, the scheduler is
        free to coalesce your wakeup with any other wakeup
        that may have happened for other reasons, or at the
        worst case, fire an interrupt for your upper bound.

        The larger a range you supply, the greater a chance
        that you will not trigger an interrupt; this should
        be balanced with what is an acceptable upper bound on
        delay / performance for your specific code path. Exact
        tolerances here are very situation specific, thus it
        is left to the caller to determine a reasonable range.

If you have a min of 3msec I would try with a range of (3000, 3500).
What do you think ?

>  	ret = ak7375_i2c_write(ak7375_dev, AK7375_REG_CONT,
>  		AK7375_MODE_ACTIVE, 1);
>  	if (ret) {
> --
> 2.37.0
>
