Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF3C57884E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiGRR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiGRR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:26:26 -0400
X-Greylist: delayed 621 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 10:26:24 PDT
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1C2A964;
        Mon, 18 Jul 2022 10:26:24 -0700 (PDT)
Received: from [90.247.97.225] (port=43504 helo=jic23-huawei)
        by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1oDULo-000Aes-T9; Mon, 18 Jul 2022 18:16:09 +0100
Date:   Mon, 18 Jul 2022 18:25:47 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, dmitry.osipenko@collabora.com,
        Zhigang.Shi@liteon.com, krisman@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 2/2] iio: light: Add support for ltrf216a sensor
Message-ID: <20220718182547.360e5cf2@jic23-huawei>
In-Reply-To: <20220715111626.1066513-3-shreeya.patel@collabora.com>
References: <20220715111626.1066513-1-shreeya.patel@collabora.com>
        <20220715111626.1066513-3-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 16:46:26 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Add initial support for ltrf216a ambient light sensor.
> 
> Datasheet: https://gitlab.collabora.com/shreeya/iio/-/blob/master/LTRF216A.pdf
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Co-developed-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>
> Co-developed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>


The first of the two 0-day warnings confuses me. It might be spurious due
to some unrelated issue, but I'm not certain of that...

Otherwise, a few more comments around PM. The way you've done it isn't
something I've seen before + I think you leave the device powered up in
!CONFIG_PM after remove which isn't ideal.

Thanks,

Jonathan


> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;

This one was caught by 0-day.  ret = 0; or perhaps better, just return
directly in the two branches rather than having a single exit point.

> +
> +	if (on) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to resume runtime PM: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +


> +
> +static int ltrf216a_probe(struct i2c_client *client)
> +{
> +	struct ltrf216a_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &ltrf216a_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->info = &ltrf216a_info;
> +	indio_dev->name = "ltrf216a";
> +	indio_dev->channels = ltrf216a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* reset sensor, chip fails to respond to this, so ignore any errors */
> +	ltrf216a_reset(indio_dev);
> +
> +	ret = regmap_reinit_cache(data->regmap, &ltrf216a_regmap_config);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to reinit regmap cache\n");
> +
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to enable runtime PM\n");
> +
> +	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
> +	if (!IS_ENABLED(CONFIG_PM)) {
> +		ret = ltrf216a_enable(indio_dev);

What turns this off again?  I'd expect to see a devm_add_action_or_reset()
to do that in the !CONFIG_PM case.

This is also an unusual pattern. As far as I can tell it works.
Normal trick for ensuring !CONFIG_PM works is to:

1) Unconditionally turn device on.
2) Register unconditional device off devm_callback. Very rarely harmful even if device already off
   due to runtime pm.
3) Then call pm_runtime_set_active() so the state tracking matches.
4) Call 	
  pm_runtime_mark_last_busy(dev);
  pm_runtime_put_autosuspend(dev);
  (here you have a function to do this anyway)
  to let runtime_pm use same path as normal to autosuspend

the upshot of this is that if !CONFIG_PM 3 and 4 do nothing and device
is left turned on.  Is there something I'm missing that makes that cycle
inappropriate here?  The main reason to do this is it then looks exactly
like any other runtime_pm calls elsewhere in the driver, so easier to review.


> +		if (ret)
> +			return ret;
> +	}
> +
> +	data->int_time = 100000;
> +	data->int_time_fac = 100;
> +	data->als_gain_fac = 3;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +

