Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1554FBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382760AbiFQRKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFQRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:10:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCA3A73E;
        Fri, 17 Jun 2022 10:10:35 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPlng07D6z67xCF;
        Sat, 18 Jun 2022 01:06:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 19:10:32 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 18:10:31 +0100
Date:   Fri, 17 Jun 2022 18:10:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     cy_huang <u0084500@gmail.com>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <cy_huang@richtek.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220617181027.000074a8@Huawei.com>
In-Reply-To: <1655458375-30478-3-git-send-email-u0084500@gmail.com>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
        <1655458375-30478-3-git-send-email-u0084500@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.131]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 17:32:55 +0800
cy_huang <u0084500@gmail.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Richtek RTQ6056 supporting.
> 
> It can be used for the system to monitor load current and power with 16bit
> resolution.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Hi ChiYuan,

Comments inline.

It would be nice to consider how to take advantage of the fact we know which
channels are of interest in buffered mode, and change the operating mode to
suite.

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-rtq6056          |  58 +++
>  drivers/iio/adc/Kconfig                            |  15 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/rtq6056-adc.c                      | 548 +++++++++++++++++++++
>  4 files changed, 622 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
>  create mode 100644 drivers/iio/adc/rtq6056-adc.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056 b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> new file mode 100644
> index 00000000..0516429
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-rtq6056
> @@ -0,0 +1,58 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_raw

Documentation can't be duplicated in mulitple files so these standard
attributes should rely only on the main docs.  If we duplicate it breaks
building the html docs unfortunately.


> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Shunt IN +/- sensing range from -82mV to +81.9175mV
> +		Calculating with scale (2.5 uV)
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_raw
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		BUS voltage sensing range from 0V to 36V.
> +		Calculating with scale (1.25 mV)
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_power2_raw
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Power loading that equals to bus voltage multiple loading
> +		current.
> +		Calculating with scale (25 mWatt)
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_current3_raw
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Consuming current from bus voltage.
> +		Directly report loading current in mA
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_integration_time
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Shunt voltage conversion time in uS
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage1_integration_time
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		BUS voltage conversion time in uS

integration time is not normally about conversion time. It's normally for things
like light sensors where they are charging up a capacitor for a fixed time period.

For ADC channels we tend to use _sampling_frequency (so 1/period). An example of
this being per channel is ad7124.

That does mean we tend not to provide the overall 'sampling_frequency' on these
devices, but rather let an interested userspace program figure it out - often
it depends on which channels are enabled.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_oversampling_ratio
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		The number of average sample
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_sampling_frequency
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Sampling frequency in HZ for power and current report
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/integration_time_available
> +KernelVersion:	5.18.2
> +Contact:	cy_huang@richtek.com
> +Description:
> +		Sample conversion time available for BUS and Shunt, unit in second
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 48ace74..0b2d17c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -908,6 +908,21 @@ config ROCKCHIP_SARADC
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rockchip_saradc.
>  
> +config RICHTEK_RTQ6056_ADC
> +	tristate "Richtek RTQ6056 Current and Power Monitor ADC"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to enable RQT6056 ADC support.
> +	  RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
> +	  compatible interface, and the device provides full information for
> +	  system by reading out the load current and power.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called rtq6056-adc.
> +
>  config RZG2L_ADC
>  	tristate "Renesas RZ/G2L ADC driver"
>  	depends on ARCH_RZG2L || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 39d806f..e8c6e6e 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
>  obj-$(CONFIG_RN5T618_ADC) += rn5t618-adc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
> +obj-$(CONFIG_RICHTEK_RTQ6056_ADC) += rtq6056-adc.o

Is the device anything other than ADC?  If not, drop the -adc.
The other entries you see here are ADCs that form part of a much
larger SoC.

>  obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>  obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>  obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
> diff --git a/drivers/iio/adc/rtq6056-adc.c b/drivers/iio/adc/rtq6056-adc.c
> new file mode 100644
> index 00000000..8374fce
> --- /dev/null
> +++ b/drivers/iio/adc/rtq6056-adc.c
> @@ -0,0 +1,548 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

property.h and mod_devicetable.h instead of of.h
once you have moved to generic firmware properties.

> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define RTQ6056_REG_CONFIG	0x00
> +#define RTQ6056_REG_SHUNTVOLT	0x01
> +#define RTQ6056_REG_CALIBRATION	0x05
> +#define RTQ6056_REG_MASKENABLE	0x06
> +#define RTQ6056_REG_ALERTLIMIT	0x07
> +#define RTQ6056_REG_MANUFACTID	0xFE
> +#define RTQ6056_REG_DIEID	0xFF
> +
> +#define RTQ6056_VENDOR_ID	0x1214
> +#define RTQ6056_DEFAULT_CONFIG	0x4127

This is not defined in terms of the field provided below
so it's not obvious what the initial state is.

> +#define RTQ6056_DEFAULT_CONVT	1037
> +#define RTQ6056_DEFAULT_AVG	1
This and the next are real world values. Having them as defines
makes the code less readable.

> +#define RTQ6056_DEFAULT_RSHUNT	2000
> +
> +enum {
> +	RTQ6056_CH_VSHUNT = 0,
> +	RTQ6056_CH_VBUS,
> +	RTQ6056_CH_POWER,
> +	RTQ6056_CH_CURRENT,
> +	RTQ6056_MAX_CHANNEL
> +};
> +
> +enum {
> +	F_OPMODE = 0, F_VSHUNTCT, F_VBUSCT, F_AVG, F_RESET,
> +	F_MAX_FIELDS
> +};
> +
> +struct rtq6056_priv {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct regmap_field *rm_fields[F_MAX_FIELDS];
> +	u32 shunt_resistor_uohm;
> +	int vshuntct; /* vshunt conversion time in uS */
> +	int vbusct; /* vbus conversion time in uS */
> +	int avg_sample;
> +};
> +
> +static const struct reg_field rtq6056_reg_fields[F_MAX_FIELDS] = {
> +	[F_OPMODE] = REG_FIELD(RTQ6056_REG_CONFIG, 0, 2),
> +	[F_VSHUNTCT] = REG_FIELD(RTQ6056_REG_CONFIG, 3, 5),
> +	[F_VBUSCT] = REG_FIELD(RTQ6056_REG_CONFIG, 6, 8),
> +	[F_AVG]	= REG_FIELD(RTQ6056_REG_CONFIG, 9, 11),
> +	[F_RESET] = REG_FIELD(RTQ6056_REG_CONFIG, 15, 15)
> +};
> +
> +static const struct iio_chan_spec rtq6056_channels[RTQ6056_MAX_CHANNEL + 1] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = RTQ6056_CH_VSHUNT,
Where we have a bunch of different types of channel we generally
count the channel numbers separately.  Where this is only one of a give
type, don't bother making it indexed.

Where you need an offset to use for accessing an actual register,
the .address field is more appropriate.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),

Why _by_dir as opposed to by_all given there are no output channels registered?


> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = RTQ6056_CH_VBUS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_POWER,
> +		.indexed = 1,
> +		.channel = RTQ6056_CH_POWER,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.scan_index = 2,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_CURRENT,
> +		.indexed = 1,
> +		.channel = RTQ6056_CH_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(RTQ6056_MAX_CHANNEL)
> +};
> +
> +static int rtq6056_adc_read_channel(struct rtq6056_priv *priv, int channel,
> +				    int *val)
> +{
> +	unsigned int reg = RTQ6056_REG_SHUNTVOLT + channel;
> +	unsigned int regval;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Only power and vbus channel is unsigned */
> +	if (channel == RTQ6056_CH_VBUS || channel == RTQ6056_CH_POWER)
> +		*val = regval;
> +	else
> +		*val = (s16)regval;

Prefer making it clear this is sign extension with sign_extend32()

> +
> +	return IIO_VAL_INT;
> +}
> +

...

> +
> +static int rtq6056_adc_set_average(struct rtq6056_priv *priv, int val)
> +{
> +	unsigned int selector;
> +	int ret;
> +
> +	if (val > 1024 || val < 1)
> +		return -EINVAL;
> +
> +	selector = find_closest(val, rtq6056_avg_sample_list,
> +				ARRAY_SIZE(rtq6056_avg_sample_list));
> +
> +	ret = regmap_field_write(priv->rm_fields[F_AVG], selector);
> +	if (ret)
> +		return ret;
> +
> +	priv->avg_sample = rtq6056_avg_sample_list[selector];

Blank line - see below. Same for other similar cases.

> +	return 0;
> +}
> +
> +static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv, int *val)
> +{
> +	int sample_time;
> +
> +	sample_time = priv->vshuntct + priv->vbusct;
> +	sample_time *= priv->avg_sample;

> +
> +	*val = DIV_ROUND_UP(1000000, sample_time);
> +	return IIO_VAL_INT;
> +}
> +


> +
> +static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
> +	[RTQ6056_CH_VSHUNT] = "Vshunt(uV)",

Units must be the standard ones for the IIO channel types.
Hence documenting them here is misleading.

> +	[RTQ6056_CH_VBUS] = "Vbus(mV)",
> +	[RTQ6056_CH_POWER] = "Power(mW)",
> +	[RTQ6056_CH_CURRENT] = "Current(mA)",
> +};
> +
> +static int rtq6056_adc_read_label(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  char *label)
> +{
> +	return snprintf(label, PAGE_SIZE, "%s\n",
> +			rtq6056_channel_labels[chan->channel]);
> +}
> +
> +static int rtq6056_set_shunt_resistor(struct rtq6056_priv *priv,
> +				      int resistor_uohm)
> +{
> +	unsigned int calib_val;
> +	int ret;
> +
> +	if (resistor_uohm <= 0) {
> +		dev_err(priv->dev, "Invalid resistor [%d]\n", resistor_uohm);
> +		return -EINVAL;
> +	}
> +
> +	/* calibration = 5120000 / (Rshunt (uohm) * current lsb (1mA)) */
> +	calib_val = 5120000 / resistor_uohm;
> +	ret = regmap_write(priv->regmap, RTQ6056_REG_CALIBRATION, calib_val);
> +	if (ret)
> +		return ret;
> +
> +	priv->shunt_resistor_uohm = resistor_uohm;

Blank line before a simple return like this. It slightly helps readability.

> +	return 0;
> +}

...

> +static IIO_CONST_ATTR_NAMED(rtq6056_conv_time_available,
> +			    integration_time_available,
> +			    "0.000139 0.000203 0.000269 0.000525 0.001037 0.002061 0.004109 0.008205");
> +
> +static IIO_DEVICE_ATTR(shunt_resistor, 0644,
> +		       rtq6056_shunt_resistor_show,
> +		       rtq6056_shunt_resistor_store, 0);
> +
> +static struct attribute *rtq6056_attributes[] = {
> +	&iio_const_attr_rtq6056_conv_time_available.dev_attr.attr,
Whilst I think this particular interface will change anyway, you should
use the read_avail callback for available attributes for standard ABI.

> +	&iio_dev_attr_shunt_resistor.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group rtq6056_attribute_group = {
> +	.attrs = rtq6056_attributes,
> +};
> +
> +static const struct iio_info rtq6056_info = {
> +	.attrs = &rtq6056_attribute_group,
> +	.read_raw = rtq6056_adc_read_raw,
> +	.write_raw = rtq6056_adc_write_raw,
> +	.read_label = rtq6056_adc_read_label,
> +};

...
> +static int rtq6056_probe(struct i2c_client *i2c)
> +{
> +	struct iio_dev *indio_dev;
> +	struct rtq6056_priv *priv;
> +	unsigned int vendor_id, shunt_resistor_uohm;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->dev = &i2c->dev;
> +	priv->vshuntct = priv->vbusct = RTQ6056_DEFAULT_CONVT;
> +	priv->avg_sample = RTQ6056_DEFAULT_AVG;
> +	i2c_set_clientdata(i2c, priv);
> +
> +	priv->regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
You make a lot of use of regmap in this function. I would suggest
first allocating into a local variable, then using that to set
priv->regmap.  The local variable can then be used avoid having
priv->regmap everywhere.

Similar for dev. once a function has multiple accesses to i2c->dev,
things are cleaner if you just have

struct device *dev = &i2c->dev; and use dev after that.

> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(&i2c->dev, PTR_ERR(priv->regmap),
> +				     "Failed to init regmap\n");
> +
> +	ret = regmap_read(priv->regmap, RTQ6056_REG_MANUFACTID, &vendor_id);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to get manufacturer info\n");
> +
> +	if (vendor_id != RTQ6056_VENDOR_ID)
> +		return dev_err_probe(&i2c->dev, -ENODEV,
> +				     "invalid vendor id 0x%04x\n", vendor_id);
> +
> +	ret = devm_regmap_field_bulk_alloc(&i2c->dev, priv->regmap,
> +					   priv->rm_fields, rtq6056_reg_fields,
> +					   F_MAX_FIELDS);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to init regmap field\n");
> +
> +	/* Write the default config value */
> +	ret = regmap_write(priv->regmap, RTQ6056_REG_CONFIG,
> +			   RTQ6056_DEFAULT_CONFIG);

This write effectively turns the device on so it would be good
to register a devm_add_action_or_reset() callback here to do what
you currently have in remove.  That will mean you don't need a separate
remove at all and that you will put the device in a low power state
if you get an error after this point.

At some stage it would be nice to do runtime pm with autosuspend so that
we enter a low power state if no one is looking at the readings.

> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to write default config\n");
> +
> +	ret = of_property_read_u32(i2c->dev.of_node,

Please use generic firmware properties not device tree specific ones.
That lets people use other firmware interfaces such as ACPI using the
PRP0001 HID.

> +				   "richtek,shunt-resistor-uohm",
> +				   &shunt_resistor_uohm);
> +	if (ret)
> +		shunt_resistor_uohm = RTQ6056_DEFAULT_RSHUNT;
Flip this around

	shunt_resistor_uohm = 2000;
	device_property_read_u32(dev, "rictek,shunt-resistor-uohm",
				 &shunt_resistor_uohm);

if the property read fails, it won't change the value stored.

> +
> +	ret = rtq6056_set_shunt_resistor(priv, shunt_resistor_uohm);
> +	if (ret)
> +		dev_err_probe(&i2c->dev, ret,
> +			      "Failed to init shunt resistor\n");
> +
> +	indio_dev->name = "rtq6056";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = rtq6056_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
> +	indio_dev->info = &rtq6056_info;
> +
> +	ret = devm_iio_triggered_buffer_setup(&i2c->dev, indio_dev, NULL,
> +					      rtq6056_buffer_trigger_handler,
> +					      NULL);
> +	if (ret)
> +		return dev_err_probe(&i2c->dev, ret,
> +				     "Failed to allocate iio trigger buffer\n");
> +
> +	return devm_iio_device_register(&i2c->dev, indio_dev);
> +}
> +
> +static int rtq6056_remove(struct i2c_client *i2c)
> +{
> +	struct rtq6056_priv *priv = i2c_get_clientdata(i2c);
> +
> +	/* Config opmode to 'shutdown' mode to minimize quiescient current */
> +	return regmap_field_write(priv->rm_fields[F_OPMODE], 0);
> +}
> +
> +static void rtq6056_shutdown(struct i2c_client *i2c)
> +{
> +	struct rtq6056_priv *priv = i2c_get_clientdata(i2c);
> +
> +	/* Config opmode to 'shutdown' mode to minimize quiescient current */
> +	regmap_field_write(priv->rm_fields[F_OPMODE], 0);

Unusual to provide a shutdown for a device as simple as an ADC.  I'd expect
the overall system to power down if we hit this and hence also cover
the ADC.  If that's not the case, then perhaps add a comment explaining
that.

> +}
> +
> +static const struct of_device_id rtq6056_device_match[] = {
> +	{ .compatible = "richtek,rtq6056", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rtq6056_device_match);
> +
> +static struct i2c_driver rtq6056_driver = {
> +	.driver = {
> +		.name = "rtq6056",
> +		.of_match_table = rtq6056_device_match,
> +	},
> +	.probe_new = rtq6056_probe,
> +	.remove = rtq6056_remove,
> +	.shutdown = rtq6056_shutdown,
> +};
> +module_i2c_driver(rtq6056_driver);
> +
> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> +MODULE_DESCRIPTION("Richtek RTQ6056 ADC Driver");
> +MODULE_LICENSE("GPL v2");

