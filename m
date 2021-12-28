Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A131480D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhL1Ujj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhL1Ujh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:39:37 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D5EC061574;
        Tue, 28 Dec 2021 12:39:37 -0800 (PST)
Received: from [81.101.6.87] (port=37716 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n2JFq-0002D9-JM; Tue, 28 Dec 2021 20:39:35 +0000
Date:   Tue, 28 Dec 2021 20:45:09 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     frank zago <frank@zago.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: position: Add support for ams AS5600 angle
 sensor
Message-ID: <20211228204454.57d652b1@jic23-huawei>
In-Reply-To: <20211225175353.4254-1-frank@zago.net>
References: <20211225175353.4254-1-frank@zago.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 11:53:53 -0600
frank zago <frank@zago.net> wrote:

> The AS5600 is a Hall-based rotary magnetic position sensor using
> planar sensors that convert the magnetic field component perpendicular
> to the surface of the chip into a voltage, or a numerical value
> available through i2c.
> 
> The driver registers the chip as an IIO_ANGL device. It also exposes
> the various registers through debugfs for further configuration.
> 
> Signed-off-by: frank zago <frank@zago.net>
Hi Frank,

The normal channels etc look fine to me.  For the debugfs please
drop the mapping from field to register.  The expectation is the debugfs
path is raw access to registers - so no one familiar with how it is use
in IIO will look for the documentation you provide and hence will assume
the register address in Figure 21 / register map are the ones to use.
That will mean you need to have high and low registers for the 16 bit ones.

So
0x07 >> $AS5600/direct_reg_access
cat $AS5600/direct_reg_access
should give you only WD/FTH(2:0)/SF(1:0).

If you want the other half of the 16bit register then use 0x08.

A side effect of moving to register access as shown on the datasheet is that
most of the documentation will be unnecessary.  It is fairly unusual to need
a .rst doc for a particular sensor, so consider how useful it is after that
register mapping info is gone.

The Datasheet: 
tag can be added before you Signed-off-by as well so we have the datasheet
path in git as well as in the driver.

Thanks,

Jonathan


> ---
> 
> changes in v2
> - set the scale for both channels
> - moved the sysfs entries into debugfs
> - add enums for each register fields
> - add rst doc for the driver
> 
>  Documentation/iio/as5600.rst  | 143 ++++++++++++++
>  Documentation/iio/index.rst   |   2 +
>  drivers/iio/position/Kconfig  |  10 +
>  drivers/iio/position/Makefile |   1 +
>  drivers/iio/position/as5600.c | 350 ++++++++++++++++++++++++++++++++++
>  5 files changed, 506 insertions(+)
>  create mode 100644 Documentation/iio/as5600.rst
>  create mode 100644 drivers/iio/position/as5600.c
> 
> diff --git a/Documentation/iio/as5600.rst b/Documentation/iio/as5600.rst
> new file mode 100644
> index 000000000000..4f672baa78b6
> --- /dev/null
> +++ b/Documentation/iio/as5600.rst
> @@ -0,0 +1,143 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================
> +ams AS5600 driver
> +=================
> +
> +
> +Overview
> +========
> +
> +The ams AS5600 is a 12-Bit Programmable Contactless Potentiometer. Its
> +i2c address is 0x36.
> +
> +For more information, see the datasheet at
> +
> +  https://ams.com/documents/20143/36005/AS5600_DS000365_5-00.pdf
> +
> +
> +Accessing the device registers
> +==============================
> +
> +If needed, the device can be configured through debugfs, where most
> +register fields are accessible.
> +
> +.. flat-table:: Registers and fields

As mentioned below, the debugfs interface should just provide
direct access to the registers. As such I'd not normally expect
to see any documentation in the kernel tree as people would just use
the datasheet rather than having to look up what they want on the
datasheet then figure out how it is remapped using this table.

> +
> +  * - Register
> +    - Field
> +    - Index
> +    - Writable range
> +
> +  * - ZMCO
> +    - ZMCO
> +    - 0
> +
> +  * - ZPOS
> +    - ZPOS
> +    - 1
> +    - 0 to 4095
> +
> +  * - MPOS
> +    - MPOS
> +    - 2
> +    - 0 to 4095
> +
> +  * - MANG
> +    - MANG
> +    - 3
> +
> +  * - CONF
> +    - PM
> +    - 4
> +    - 0 to 3
> +
> +  * - CONF
> +    - HYST
> +    - 5
> +    - 0 to 3
> +
> +  * - CONF
> +    - OUTS
> +    - 6
> +    - 0 to 3
> +
> +  * - CONF
> +    - PWMF
> +    - 7
> +    - 0 to 3
> +
> +  * - CONF
> +    - SF
> +    - 8
> +    - 0 to 3
> +
> +  * - CONF
> +    - FTH
> +    - 9
> +    - 0 to 7
> +
> +  * - CONF
> +    - WD
> +    - 10
> +    - 0 or 1
> +
> +  * - STATUS
> +    - MH
> +    - 11
> +
> +  * - STATUS
> +    - ML
> +    - 12
> +
> +  * - STATUS
> +    - MD
> +    - 13
> +
> +  * - AGC
> +    - AGC
> +    - 14
> +
> +  * - MAGNITUDE
> +    - MAGNITUDE
> +    - 15
> +
> +These registers allow the user to check the device and, if needed, to
> +configure it.
> +
> +Assuming the device is iio:device0, its debugfs path will be::
> +
> +  AS5600=/sys/kernel/debug/iio/iio:device0/direct_reg_access
> +
> +Locate the index of a register to access in the table above, then use
> +the following commands to read a value::
> +
> +  $ echo <index> > $AS5600/direct_reg_access
> +  $ cat $AS5600/direct_reg_access
> +
> +or this to write a value::
> +
> +  $ echo <index> <value> > $AS5600/direct_reg_access
> +
> +For instance, this would return 1 if the magnet is present::
> +
> +  $ echo 13 > $AS5600/direct_reg_access
> +  $ cat $AS5600/direct_reg_access
> +
> +
> +Channels
> +========
> +
> +The driver provides 2 channels. The channel 0 returns the raw,
> +unscaled data. The channel 1 returns the data as was scaled by the
> +device when ZPOS / MPOS are used. All angles returned have a value of
> +0 to 4095.
> +
> +ZPOS and MPOS let a user restrict the angle returned, which improves
> +the precision returned, since the angle returned is still in the 0 to
> +4095 range. The minimal angle recommended is 18 degrees. For instance,
> +this sets ZPOS and MPOS to a 70 degrees angle (4096/360*70=796), starting
> +at some given offset (1200)::
> +
> +  echo 1 1200 > $AS5600
> +  echo 2 1996 > $AS5600
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 58b7a4ebac51..937b626e64d4 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -9,4 +9,6 @@ Industrial I/O
> 
>     iio_configfs
> 
> +   as5600
> +
>     ep93xx_adc
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
> index 000000000000..2c45dbfe170d
> --- /dev/null
> +++ b/drivers/iio/position/as5600.c
> @@ -0,0 +1,350 @@
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
> + *
> + * ZPOS and MPOS can be programmed through their debugfs entries. The
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
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/bitfield.h>
> +
> +/* Registers and their fields, as defined in the datasheet */
> +#define REG_ZMCO 0x00
> +#define REG_ZPOS 0x01
> +#define   REG_ZPOS_ZPOS GENMASK(11, 0)
> +#define REG_MPOS 0x03
> +#define   REG_MPOS_MPOS GENMASK(11, 0)
> +#define REG_MANG 0x05
> +#define   REG_MANG_MANG GENMASK(11, 0)
> +#define REG_CONF 0x07
> +#define REG_STATUS 0x0b
> +#define   REG_STATUS_MD BIT(5)
> +#define REG_RAW_ANGLE 0x0c
> +#define   REG_RAW_ANGLE_ANGLE GENMASK(11, 0)
> +#define REG_ANGLE 0x0e
> +#define   REG_ANGLE_ANGLE GENMASK(11, 0)
> +#define REG_AGC 0x1a
> +#define REG_MAGNITUDE 0x1b
> +#define REG_BURN 0xff
> +
> +enum {
> +	X_REG_ZMCO_ZMCO,
> +	X_REG_ZPOS_ZPOS,
> +	X_REG_MPOS_MPOS,
> +	X_REG_MANG_MANG,
> +	X_REG_CONF_PM,
> +	X_REG_CONF_HYST,
> +	X_REG_CONF_OUTS,
> +	X_REG_CONF_PWMF,
> +	X_REG_CONF_SF,
> +	X_REG_CONF_FTH,
> +	X_REG_CONF_WD,
> +	X_REG_STATUS_MH,
> +	X_REG_STATUS_ML,
> +	X_REG_STATUS_MD,
> +	X_REG_AGC_AGC,
> +	X_REG_MAGNITUDE_MAGNITUDE,
> +
> +	X_REG_NUM_ENTRIES,	/* last */
> +};
> +
> +static const struct {
> +	u8 reg;
> +	u16 mask;
> +	u16 max_value;		/* maximum writable value */
> +} reg_access[] = {
> +	[X_REG_ZMCO_ZMCO] = { REG_ZMCO, GENMASK(1, 0) },
> +	[X_REG_ZPOS_ZPOS] = { REG_ZPOS, REG_ZPOS_ZPOS, 4095 },
> +	[X_REG_MPOS_MPOS] = { REG_MPOS, REG_MPOS_MPOS, 4095 },
> +	[X_REG_MANG_MANG] = { REG_MANG, REG_MANG_MANG, 4095 },
> +	[X_REG_CONF_PM] = { REG_CONF, GENMASK(1, 0), 3 },

Leave them as raw access to the register rather than remapping
them to different addresses.

When using the debugfs interface people expect to be able to just
use the register addresses from a data sheet.

It's a debug interface so up to the caller to do read-modify-write
if it is needed.

> +	[X_REG_CONF_HYST] = { REG_CONF, GENMASK(3, 2), 3 },
> +	[X_REG_CONF_OUTS] = { REG_CONF, GENMASK(5, 4), 3 },
> +	[X_REG_CONF_PWMF] = { REG_CONF, GENMASK(7, 6), 3 },
> +	[X_REG_CONF_SF] = { REG_CONF, GENMASK(9, 8), 3 },
> +	[X_REG_CONF_FTH] = { REG_CONF, GENMASK(12, 10), 7},
> +	[X_REG_CONF_WD] = { REG_CONF, BIT(13), 1 },
> +	[X_REG_STATUS_MH] = { REG_STATUS, BIT(3) },
> +	[X_REG_STATUS_ML] = { REG_STATUS, BIT(4) },
> +	[X_REG_STATUS_MD] = { REG_STATUS, REG_STATUS_MD },
> +	[X_REG_AGC_AGC] = { REG_AGC, GENMASK(7, 0) },
> +	[X_REG_MAGNITUDE_MAGNITUDE] = { REG_MAGNITUDE, GENMASK(11, 0) },
> +};
> +
> +/* runtime versions of the FIELD_GET/FIELD_PREP macros */
> +#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> +
> +struct as5600_priv {
> +	struct iio_dev *iio_dev;
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	u16 zpos;
> +	u16 mpos;
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
> +		if (chan->channel == 0) {
> +			reg = REG_RAW_ANGLE;
> +			bitmask = REG_RAW_ANGLE_ANGLE;

Move the bitmask part to after you have the value and then you can use the
build time version of FIELD_GET() which is preferable when possible.

> +		} else {
> +			reg = REG_ANGLE;
> +			bitmask = REG_ANGLE_ANGLE;
> +		}
> +		angle = i2c_smbus_read_word_swapped(priv->client, reg);
> +
> +		if (angle < 0)
> +			return angle;

As this isn't the angle but rather a register value from which you
extract the angle I'd go with another name.  Perhaps just ret?

> +		*val = field_get(bitmask, angle);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Always 4096 steps, but angle range varies between
> +		 * 18 and 360 degrees.
> +		 */
> +		if (chan->channel == 0) {
> +			/* Whole angle range - 2*pi / 4096 */
> +			*val = 3141592;
> +			*val2 = 2048000000;
> +		} else {
> +			s32 range;
> +
> +			/* Partial angle - (range/4096) * (2*pi / 4096) */
> +			mutex_lock(&priv->lock);
> +			range = priv->mpos - priv->zpos;
> +			mutex_unlock(&priv->lock);
> +			if (range <= 0)
> +				range += 4096;
> +
> +			*val = range * 314159;
> +			*val /= 4096;
> +			*val2 = 204800000;
> +		}
> +
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t as5600_reg_access_read(struct as5600_priv *priv,
> +				      unsigned int reg_access_idx,
> +				      unsigned int *readval)
> +{
> +	unsigned int reg = reg_access[reg_access_idx].reg;
> +	unsigned int mask = reg_access[reg_access_idx].mask;
> +	int ret;
> +
> +	switch (reg) {
> +	case REG_ZMCO:
> +	case REG_STATUS:
> +	case REG_AGC:
> +		ret = i2c_smbus_read_byte_data(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		*readval = field_get(mask, ret);
> +		return 0;
> +
> +	case REG_ZPOS:
> +	case REG_MPOS:
> +	case REG_CONF:
> +	case REG_MAGNITUDE:
> +		ret = i2c_smbus_read_word_swapped(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		*readval = field_get(mask, ret);
> +		return 0;
For a debug interface just read / write registers as described in figure 21.
Sometimes it may be necessary to read or write two separate registers for the
larger values - that is a problem for userspace or whoever is using this debug
interface to deal with not the driver.
 
> +	}
> +
> +	return -EINVAL;

Put this in a default: for the switch as you have done for below.

It makes it easy for static analysis tools to conclude you deliberately
didn't handle other cases rather than 'forgetting them'. Some of the tools
get fussy otherwise and it generates noise we could do without ;)

> +}
> +
> +static ssize_t as5600_reg_access_write(struct as5600_priv *priv,
> +				       unsigned int reg_access_idx,
> +				       unsigned int writeval)
> +{
> +	unsigned int reg = reg_access[reg_access_idx].reg;
> +	unsigned int mask = reg_access[reg_access_idx].mask;
> +	u16 out;
> +	int ret;
> +
> +	switch (reg) {
> +	case REG_ZPOS:
> +	case REG_MPOS:
> +	case REG_CONF:
> +		if (writeval > reg_access[reg_access_idx].max_value)
> +			return -EINVAL;
> +
> +		/* Read then write, as per spec */
> +		ret = i2c_smbus_read_word_swapped(priv->client, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		out = ret & ~mask;
> +		out |= field_prep(mask, writeval);
> +
> +		ret = i2c_smbus_write_word_swapped(priv->client, reg, out);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (reg == REG_ZPOS)
> +			priv->zpos = writeval;
> +		else if (reg == REG_MPOS)
> +			priv->mpos = writeval;
> +
> +		break;
> +
> +	default:
> +		/* Not a writable register */
> +		return -EINVAL;
> +
> +	}
> +
> +	return 0;

Drop this and return where you have break above.
Otherwise anyone reading the code has to go look to see if anything else
is done for those cases where you have break.  There is no benefit in that
(and it saves a couple of lines of code which is always nice :)

> +}
> +
> +static int as5600_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct as5600_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (reg >= X_REG_NUM_ENTRIES)
> +		return -EINVAL;
> +
> +	if (readval) {
> +		ret = as5600_reg_access_read(priv, reg, readval);
> +	} else {
> +

blank line here doesn't add to readability so please remove.

> +		mutex_lock(&priv->lock);
> +		ret = as5600_reg_access_write(priv, reg, writeval);
> +		mutex_unlock(&priv->lock);
> +	}
> +
> +	return ret;
> +}
> +

