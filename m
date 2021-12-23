Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926AF47E40C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348628AbhLWNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhLWNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD30C061401;
        Thu, 23 Dec 2021 05:22:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 123E7B82078;
        Thu, 23 Dec 2021 13:22:29 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 71039C36AE5;
        Thu, 23 Dec 2021 13:22:25 +0000 (UTC)
Date:   Thu, 23 Dec 2021 13:28:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     frank zago <frank@zago.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: position: Add support for ams AS5600 angle sensor
Message-ID: <20211223132800.682a56d2@jic23-huawei>
In-Reply-To: <20211216202651.120172-1-frank@zago.net>
References: <20211216202651.120172-1-frank@zago.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 14:26:51 -0600
frank zago <frank@zago.net> wrote:

> The AS5600 is a Hall-based rotary magnetic position sensor using
> planar sensors that convert the magnetic field component perpendicular
> to the surface of the chip into a voltage, or a numerical value
> available through i2c.
> 
> The driver registers the chip as an IIO_ANGL device. It also exposes
> the various registers through sysfs.
> 
> Signed-off-by: frank zago <frank@zago.net>
> ---
> 
> I'm not certain the values the driver return to IIO are correct. The
> angle returned by the chip is a value in 0..4095, and that's what the
> driver returns. The sysfs doc says it should be in radian.
> 
> Also it's unclear to me how I should define the scale.
The sensor is providing 0-4095 as 0-360 degrees.  So the
in_angl_scale attribute how many radians per LSB

2*M_PI / 4096 or something similar to that.

Thus _raw * _scale = rotation in radians.

> 
> 
>  .../ABI/testing/sysfs-bus-iio-position-as5600 |  38 +++
>  drivers/iio/position/Kconfig                  |  10 +
>  drivers/iio/position/Makefile                 |   1 +
>  drivers/iio/position/as5600.c                 | 309 ++++++++++++++++++
>  4 files changed, 358 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-position-as5600
>  create mode 100644 drivers/iio/position/as5600.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-position-as5600 b/Documentation/ABI/testing/sysfs-bus-iio-position-as5600
> new file mode 100644
> index 000000000000..d0d9c794529b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-position-as5600
> @@ -0,0 +1,38 @@
> +What:		sys/bus/iio/devices/iio:deviceX/in_angl0_raw

For attributes that fit within the standard ABI, you should not document them
in a driver specific ABI file.  The documentation building tool only copes
with them being in one place.  If the particular entry isn't there
in sysfs-bus-iio then add it there.


> +KernelVersion:	TBD

Always guess - it's better than us forgetting to fill these in at all ;)

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +	Returns the unscaled and unmodified angle
> +
> +What:		sys/bus/iio/devices/iio:deviceX/in_angl1_raw
> +KernelVersion:	TBD
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +	Returns the scaled and modified angle, as affected by the
> +	zpos/mpos/mang values.
> +
> +What:		sys/bus/iio/devices/iio:deviceX/agc
> +What:		sys/bus/iio/devices/iio:deviceX/conf_fth
> +What:		sys/bus/iio/devices/iio:deviceX/conf_hyst
> +What:		sys/bus/iio/devices/iio:deviceX/conf_outs
> +What:		sys/bus/iio/devices/iio:deviceX/conf_pm
> +What:		sys/bus/iio/devices/iio:deviceX/conf_pwmf
> +What:		sys/bus/iio/devices/iio:deviceX/conf_sf
> +What:		sys/bus/iio/devices/iio:deviceX/conf_wd
> +What:		sys/bus/iio/devices/iio:deviceX/magnitude
> +What:		sys/bus/iio/devices/iio:deviceX/mang
> +What:		sys/bus/iio/devices/iio:deviceX/mpos
> +What:		sys/bus/iio/devices/iio:deviceX/status_md
> +What:		sys/bus/iio/devices/iio:deviceX/status_mh
> +What:		sys/bus/iio/devices/iio:deviceX/status_ml
> +What:		sys/bus/iio/devices/iio:deviceX/zmco
> +What:		sys/bus/iio/devices/iio:deviceX/zpos
> +KernelVersion:	TBD
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +	Read and write the ams AS5600 internal registers and their
> +	fields. zpos/mpos can be used to create a subset of the 0-360
> +	degree range. status_md will tell whether the magnet is
> +	detected. Check the datasheet
> +	(https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf)
> +	for more information.

No to this lot.  If you need raw register access it needs to be debugfs
not sysfs.  IIO provides a standard way of doing that.
(just grep debugfs and you will find lots of examples).


> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> index 1576a6380b53..111ed551ae79 100644
> --- a/drivers/iio/position/Kconfig
> +++ b/drivers/iio/position/Kconfig
> @@ -6,6 +6,16 @@
> 
>  menu "Linear and angular position sensors"
> 
> +config AS5600
> +	tristate "ams AS5600 angular position sensor"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build support for the ams 5600
> +	  12-Bit Programmable Contactless Potentiometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called as5600.
> +
>  config IQS624_POS
>  	tristate "Azoteq IQS624/625 angular position sensors"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> index d70902f2979d..53930681e6a4 100644
> --- a/drivers/iio/position/Makefile
> +++ b/drivers/iio/position/Makefile
> @@ -4,5 +4,6 @@
> 
>  # When adding new entries keep the list in alphabetical order
> 
> +obj-$(CONFIG_AS5600)		+= as5600.o
>  obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
>  obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> diff --git a/drivers/iio/position/as5600.c b/drivers/iio/position/as5600.c
> new file mode 100644
> index 000000000000..2b160fd3a795
> --- /dev/null
> +++ b/drivers/iio/position/as5600.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ams AS5600 -- 12-Bit Programmable Contactless Potentiometer
> + *
> + * Copyright 2021, Frank Zago
> + *
> + * datasheet v1.06 (2018-Jun-20):
> + *    https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
> + *
> + * The rotating magnet is installed from 0.5mm to 3mm parallel to and
> + * above the chip.
> + *
> + * The raw angle value returned by the chip is [0..4095]. The channel
> + * 0 (in_angl0_raw) returns the unscaled and unmodified angle, always
> + * covering the 360 degrees. The channel 1 returns the chip adjusted
> + * angle, covering from 18 to 360 degrees, as modified by its
> + * ZPOS/MPOS/MANG values,

So, the raw case is simple, the other one more complex.

I think zpos maps well to offset in iio terms. Mpos is harder because
we don't typically define a maximum value for a channel. I'm also not
sure what the point is in either of these unless MANG is used and
as you observer that is not exposed (good thing too given limited write cycles).
Without MANG you might as well just do it in userspace - unless the DAC or PWM
outputs are of interest...

> + *
> + * ZPOS and MPOS can be programmed through their sysfs entries. The
> + * MANG register doesn't appear to be programmable without flashing
> + * the chip.
> + *
> + * If the DIR pin is grounded, angles will increase when the magnet is
> + * turned clockwise. If DIR is connected to Vcc, it will be the opposite.
> + *
> + * Permanent programming of the MPOS/ZPOS/MANG/CONF registers is not
> + * implemented.
> + *
> + * The i2c address of the device is 0x36.
> + */
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +
> +/* Registers and their fields, as defined in the datasheet */
> +#define REG_ZMCO 0x00
> +#define   REG_ZMCO_ZMCO GENMASK(1, 0)
> +#define REG_ZPOS 0x01
> +#define   REG_ZPOS_ZPOS GENMASK(11, 0)
> +#define REG_MPOS 0x03
> +#define   REG_MPOS_MPOS GENMASK(11, 0)
> +#define REG_MANG 0x05
> +#define   REG_MANG_MANG GENMASK(11, 0)
> +#define REG_CONF 0x07
> +#define   REG_CONF_PM   GENMASK(1, 0)
> +#define   REG_CONF_HYST GENMASK(3, 2)
> +#define   REG_CONF_OUTS GENMASK(5, 4)
> +#define   REG_CONF_PWMF GENMASK(7, 6)
> +#define   REG_CONF_SF   GENMASK(9, 8)
> +#define   REG_CONF_FTH  GENMASK(12, 10)
> +#define   REG_CONF_WD   BIT(13)
> +#define REG_STATUS 0x0b
> +#define   REG_STATUS_MH BIT(3)
> +#define   REG_STATUS_ML BIT(4)
> +#define   REG_STATUS_MD BIT(5)
> +#define REG_RAW_ANGLE 0x0c
> +#define   REG_RAW_ANGLE_ANGLE GENMASK(11, 0)
> +#define REG_ANGLE 0x0e
> +#define   REG_ANGLE_ANGLE GENMASK(11, 0)
> +#define REG_AGC 0x1a
> +#define   REG_AGC_AGC GENMASK(7, 0)
> +#define REG_MAGNITUDE 0x1b
> +#define   REG_MAGNITUDE_MAGNITUDE GENMASK(11, 0)
> +#define REG_BURN 0xff
> +
> +/* To simplify some code, the register index and each fields bitmask
> + * are encoded in the address field of the sysfs attributes and
> + * iio_chan_spec. field_get and field_prep are runtime versions of the
> + * FIELD_GET/FIELD_PREP macros.
> + */
> +#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))

There is a discussion ongoing about introducing these in general. Not sure
if it has happened yet though.

> +
> +#define to_address(reg, field) ((REG_##reg << 16) | REG_##reg##_##field)
> +#define reg_from_address(address) (address >> 16)
> +#define mask_from_address(address) (address & 0xffff)

I'd rather you used indirection and a nice table of values for this stuff.
Ends up more readable than encoding values only to rip them apart again.

> +
> +struct as5600_priv {
> +	struct iio_dev *iio_dev;
> +	struct i2c_client *client;
> +};
> +
> +static int as5600_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct as5600_priv *priv = iio_priv(indio_dev);
> +	u16 bitmask;
> +	s32 angle;
> +	u16 reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		reg = reg_from_address(chan->address);
> +		bitmask = mask_from_address(chan->address);
> +		angle = i2c_smbus_read_word_swapped(priv->client, reg);
> +		if (angle < 0)
> +			return angle;
> +		*val = field_get(bitmask, angle);

As this is the only case that will be left, just use long hand code based
on the channel index so that we can immediately see what the mask and address
are here (or at least define names that make it clear they are the right ones).

It will be a few more lines of code, but easier to read.
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 4095;
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t rs5600_attr_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct as5600_priv *priv = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	unsigned int reg = reg_from_address(this_attr->address);
> +	unsigned int mask = mask_from_address(this_attr->address);
> +	int ret;
> +
> +	switch (reg) {
> +	case REG_ZMCO:
> +	case REG_STATUS:
> +	case REG_AGC:
> +		ret = i2c_smbus_read_byte_data(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +		return sysfs_emit(buf, "%u\n", field_get(mask, ret));
> +
> +	case REG_ZPOS:
> +	case REG_MPOS:
> +	case REG_MANG:
> +	case REG_CONF:
> +	case REG_MAGNITUDE:
> +		ret = i2c_smbus_read_word_swapped(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +		return sysfs_emit(buf, "%u\n", field_get(mask, ret));
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t rs5600_attr_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct as5600_priv *priv = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	unsigned int reg = reg_from_address(this_attr->address);
> +	unsigned int mask = mask_from_address(this_attr->address);
> +	u16 val_in;
> +	u16 out;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 0, &val_in);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg) {
> +	case REG_ZPOS:
> +	case REG_MPOS:
> +	case REG_CONF:
> +		/* Read then write, as per spec */
> +		ret = i2c_smbus_read_word_swapped(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		out = ret & ~mask;
> +		out |= field_prep(mask, val_in);
> +
> +		ret = i2c_smbus_write_word_swapped(priv->client, reg, out);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	}
> +
> +	return len;
> +}
> +
> +#define AS5600_ATTR_RO(name, reg, field)				\
> +	IIO_DEVICE_ATTR(name, 0444, rs5600_attr_show, NULL, to_address(reg, field))
> +
> +#define AS5600_ATTR_RW(name, reg, field)				\
> +	IIO_DEVICE_ATTR(name, 0644, rs5600_attr_show, rs5600_attr_store, \
> +			to_address(reg, field))
> +
> +static AS5600_ATTR_RO(zmco, ZMCO, ZMCO);
> +static AS5600_ATTR_RO(conf_pm, CONF, PM);
> +static AS5600_ATTR_RO(conf_hyst, CONF, HYST);
> +static AS5600_ATTR_RO(conf_outs, CONF, OUTS);
> +static AS5600_ATTR_RO(conf_pwmf, CONF, PWMF);
> +static AS5600_ATTR_RO(conf_sf, CONF, SF);
> +static AS5600_ATTR_RO(conf_fth, CONF, FTH);
> +static AS5600_ATTR_RO(conf_wd, CONF, WD);
> +static AS5600_ATTR_RO(mang, MANG, MANG);
> +static AS5600_ATTR_RO(status_mh, STATUS, MH);
> +static AS5600_ATTR_RO(status_ml, STATUS, ML);
> +static AS5600_ATTR_RO(status_md, STATUS, MD);
> +static AS5600_ATTR_RO(agc, AGC, AGC);
> +static AS5600_ATTR_RO(magnitude, MAGNITUDE, MAGNITUDE);
> +
> +static AS5600_ATTR_RW(zpos, ZPOS, ZPOS);
> +static AS5600_ATTR_RW(mpos, MPOS, MPOS);
> +
> +static struct attribute *as5600_attributes[] = {
> +	&iio_dev_attr_zmco.dev_attr.attr,
> +	&iio_dev_attr_zpos.dev_attr.attr,
> +	&iio_dev_attr_mpos.dev_attr.attr,
> +	&iio_dev_attr_mang.dev_attr.attr,
> +	&iio_dev_attr_conf_pm.dev_attr.attr,
> +	&iio_dev_attr_conf_hyst.dev_attr.attr,
> +	&iio_dev_attr_conf_outs.dev_attr.attr,
> +	&iio_dev_attr_conf_pwmf.dev_attr.attr,
> +	&iio_dev_attr_conf_sf.dev_attr.attr,
> +	&iio_dev_attr_conf_fth.dev_attr.attr,
> +	&iio_dev_attr_conf_wd.dev_attr.attr,
> +	&iio_dev_attr_status_mh.dev_attr.attr,
> +	&iio_dev_attr_status_ml.dev_attr.attr,
> +	&iio_dev_attr_status_md.dev_attr.attr,
> +	&iio_dev_attr_agc.dev_attr.attr,
> +	&iio_dev_attr_magnitude.dev_attr.attr,
> +	NULL

As above, no to any of these forming part of the sysfs ABI.
The purpose of having a subsystem is to standardize the interface
so we need to do that but only introducing new ABI where we need
it and then trying to keep that inline with the existing ABI so
it forms a (somewhat) coherent whole.

> +static int as5600_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct as5600_priv *priv;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	priv->client = client;
> +
> +	indio_dev->info = &as5600_info;
> +	indio_dev->name = "as5600";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = as5600_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as5600_channels);
> +
> +	ret = i2c_smbus_read_byte_data(client, REG_STATUS);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* No magnet present could be a problem. */

:) Good understatement.  Why not just fail the probe if this occurs?

> +	if ((ret & REG_STATUS_MD) == 0)
> +		dev_warn(&client->dev, "Magnet not detected\n");
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +


