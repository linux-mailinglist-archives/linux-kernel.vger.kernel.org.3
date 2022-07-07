Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D674C56A961
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiGGRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiGGRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051153334E;
        Thu,  7 Jul 2022 10:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7431061458;
        Thu,  7 Jul 2022 17:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C93EC3411E;
        Thu,  7 Jul 2022 17:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657214445;
        bh=OFOndgeYOideWvY0bB0qskwVhKVefMybWvHyuOmdo6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FzTBsiPIs7zWylT1DVO6ifAVTFrQWfKbz0J97fEtmlwHkK21FGmWBlQyfqHPbLINV
         M9LD+yjGKhbT02lNPNmfLbqkeeZ33gxStDd/QMNWWrCHus2s/5QixKRl3yLvrfMX/8
         BAPsexd4JqCNCtBAOpWbPLUVzkyQt7b6cR5TYhW2fGUwQW6V2mId9+6F5WTGDrz0hq
         jdqUowHV4Az2Uf+8zoiD9R6wyhw0aPgCYEw30rnYnGBZqieUT/hzFQhEX35TpveOY4
         FPvsCxKpPucNdkBhLTTNcpyck6w5gxagtwP2zY1HlznmY58WZvl7dPiG2TibCkrYsK
         DvnE5UrwSxCpw==
Date:   Thu, 7 Jul 2022 18:30:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220707183027.342f6c88@jic23-huawei>
In-Reply-To: <1657116702-24161-3-git-send-email-u0084500@gmail.com>
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
        <1657116702-24161-3-git-send-email-u0084500@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jul 2022 22:11:42 +0800
cy_huang <u0084500@gmail.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek rtq6056 supporting.
> 
> It can be used for the system to monitor load current and power with 16-bit
> resolution.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Various feedback inline.

Thanks,

Jonathan

> ---
> Since v5
> - Fix kernel version text for ABI.
> 
> Since v4
> - Add '__aligned(8)' for timestamp member in buffer_trigger_handler function.
> - Declare timestamp from 'int64_t' to more unified 's64'.
> 
> Since v3
> - Refine pm_runtime API calling order in 'read_channel' API.
> - Fix vshunt wrong scale for divider.
> - Refine the comment text.
> - Use 'devm_add_action_or_reset' to decrease the code usage in probe
>   function.
> - Use RUNTIME_PM_OPS to replace SET_RUNTIME_PM_OPS.
> - minor fix for the comma.
> - Use pm_ptr to replace the direct assigned pm_ops.
> 
> Since v2
> - Rename file from 'rtq6056-adc' to 'rtq6056'.
> - Refine the ABI, if generic already defined it, remove it and check the channel
>   report unit.
> - Add copyright text.
> - include the correct header.
> - change the property parsing name.
> - To use iio_chan_spec address field.
> - Refine each channel separate and shared_by_all.
> - Use pm_runtime and pm_runtime_autosuspend.
> - Remove the shutdown callback. From the HW suggestion, it's not recommended to
>   use battery as the power supply.
> - Check all scale unit (voltage->mV, current->mA, power->milliWatt).
> - Use the read_avail to provide the interface for attribute value list.
> - Add comma for the last element in the const integer array.
> - Refine each ADC label text.
> - In read_label callback, replace snprintf to sysfs_emit.
> 
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |   6 +
>  drivers/iio/adc/Kconfig                            |  15 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/rtq6056.c                          | 651 +++++++++++++++++++++
>  4 files changed, 673 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
>  create mode 100644 drivers/iio/adc/rtq6056.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> new file mode 100644
> index 00000000..e89d15b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> @@ -0,0 +1,6 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_integration_time
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_integration_time
> +KernelVersion:	5.20
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Each voltage conversion time in uS

Please move this entry to sysfs-bus-iio

It's a natural extension of existing standard ABI so doesn't need to be in
a driver specific documentation file.

However, way back in patch 1 I gave feedback on why we don't normally use integration time
for voltage channels and I thought you were changing this...

...

> +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
> +				    struct iio_chan_spec const *ch,
> +				    int *val)
> +{
> +	struct device *dev = priv->dev;
> +	unsigned int addr = ch->address;
> +	unsigned int regval;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);
> +	ret = regmap_read(priv->regmap, addr, &regval);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
> +	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
> +		*val = regval;
> +	else
> +		*val = sign_extend32(regval, 16);
> +

One blank line only.

> +
> +	return IIO_VAL_INT;
> +}
> +
...


> +
> +static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan, int val,
> +				 int val2, long mask)
> +{
> +	struct rtq6056_priv *priv = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))

This is racy as can enter buffered mode immediately after this check.
Use iio_device_claim_direct_mode() to avoid any races around this.

> +		return -EBUSY;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return rtq6056_adc_set_conv_time(priv, chan, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return rtq6056_adc_set_average(priv, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static void rtq6056_remove(void *dev)
> +{
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);

There isn't anything here to push the device into a suspend state, so why
does calling pm_runtime_set_suspended() make sense?

> +}
> +
>
> +
> +static int rtq6056_probe(struct i2c_client *i2c)
> +{
> +	struct iio_dev *indio_dev;
> +	struct rtq6056_priv *priv;
> +	struct device *dev = &i2c->dev;
> +	struct regmap *regmap;
> +	unsigned int vendor_id, shunt_resistor_uohm;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->dev = dev;
> +	priv->vshuntct_us = priv->vbusct_us = 1037;
> +	priv->avg_sample = 1;
> +	i2c_set_clientdata(i2c, priv);
> +
> +	regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to init regmap\n");
> +
> +	priv->regmap = regmap;
> +
> +	ret = regmap_read(regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get manufacturer info\n");
> +
> +	if (vendor_id != RTQ6056_VENDOR_ID)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Invalid vendor id 0x%04x\n", vendor_id);
> +
> +	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
> +					   rtq6056_reg_fields, F_MAX_FIELDS);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regmap field\n");
> +
> +	/*
> +	 * By default, configure average sample as 1, bus and shunt conversion
> +	 * timea as 1037 microsecond, and operating mode to all on.
> +	 */
> +	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable continuous sensing\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_enable(dev);

Look at whether you can use devm_pm_runtime_enable()
Note it handles disabling autosuspend for you.

When using runtime_pm() you want to ensure that the device works without
runtime pm support being enabled.  As such, you turn the device on before
enabling runtime_pm() and (this is missing I think) turn it off after disabling
runtime pm.  So I'd expect a devm_add_action_or_reset() call to unwind
setting the device into continuous sending above.

> +
> +	ret = devm_add_action_or_reset(dev, rtq6056_remove, dev);

The callback naming is too generic. It should give some indication
of what it is undoing (much of probe is handled by other devm_ callbacks).

> +	if (ret)
> +		return ret;
> +
> +	/* By default, use 2000 micro-ohm resistor */
> +	shunt_resistor_uohm = 2000;
> +	device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> +				 &shunt_resistor_uohm);
> +
> +	ret = rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to init shunt resistor\n");
> +
> +	indio_dev->name = "rtq6056";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = rtq6056_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
> +	indio_dev->info = &rtq6056_info;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      rtq6056_buffer_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to allocate iio trigger buffer\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> +
> +static const struct dev_pm_ops rtq6056_pm_ops = {
> +	RUNTIME_PM_OPS(rtq6056_runtime_suspend, rtq6056_runtime_resume, NULL)

Is there any reason we can't use these same ops to achieve at least some power
saving in suspend?  i.e. use DEFINE_RUNTIME_PM_OPS()

I have tidying this up in existing drivers on my todo list as I think it is almost
always a good idea.  Note this is why there isn't a define to create the
particular combination you have here.

> +};
> +

