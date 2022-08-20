Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2959AD2B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbiHTKYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbiHTKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00D46CD21;
        Sat, 20 Aug 2022 03:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D7DC61128;
        Sat, 20 Aug 2022 10:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F934C433D6;
        Sat, 20 Aug 2022 10:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660991041;
        bh=rTI7vxzDOM9MZjNW2fwEnIccXEq6YSB+Xp2WYNeNHM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ioR9hsHaqBvV765f2/Wq6kyznmVS28tEayZqq+IKkQU+i9+OKl9k+kq25mFRH7aCY
         WdD5dk6AETxr5OImv9FoxAG1W/IVvb3bPCb0T9vDLg/ZpZuVPTVi95eHMREhoGNvMg
         D6Xl6x1X/RehdWcdDGnB4PlVVeEDuPF+NS7apFushbf9+4NbLApgMWddbBehM7PPWS
         Ukv7ANrg8tUmaiWZYa4MANc4nayZHdvahDg2DuCX5wUQP6eFMBDlIoNoKPDdLRdzOq
         /DeCNyi+rEcuqWfWcWsJEuLr2ay+44E0LqApt2NXXPgwdCR+pA3A/fwAvfpb7pzX0L
         yXuQ0aq4mUw/w==
Date:   Sat, 20 Aug 2022 11:34:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Mois, George" <George.Mois@analog.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lucas.p.stankus@gmail.com" <lucas.p.stankus@gmail.com>
Subject: Re: [PATCH 2/2] drivers: iio: accel adxl312 and adxl314 support
Message-ID: <20220820113436.40c24770@jic23-huawei>
In-Reply-To: <SN6PR03MB3421435300309BCDD2D701EA946D9@SN6PR03MB3421.namprd03.prod.outlook.com>
References: <20220816102828.182345-1-george.mois@analog.com>
        <20220816102828.182345-3-george.mois@analog.com>
        <20220816150958.00002431@huawei.com>
        <SN6PR03MB3421435300309BCDD2D701EA946D9@SN6PR03MB3421.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 10:11:16 +0000
"Mois, George" <George.Mois@analog.com> wrote:

> Hi Jonathan,
> 
> Thank you for your review!
> 
> Regards,
> George
> > 
> > On Tue, 16 Aug 2022 13:28:28 +0300
> > George Mois <george.mois@analog.com> wrote:
> >   
> > > ADXL312 and ADXL314 are small, thin, low power, 3-axis accelerometers
> > > with high resolution (13-bit) measurement up to +/-12 g and +/- 200 g
> > > respectively.
> > >
> > > Implement support for ADXL312 and ADXL314 by extending the ADXL313
> > > driver.
> > >
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL312.pdf
> > > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL314.pdf
> > >
> > > Signed-off-by: George Mois <george.mois@analog.com>  
> > 
> > Hi George,
> > 
> > Various comments inline.
> > 
> > Thanks,
> > 
> > Jonathan  
> > > ---
> > >  drivers/iio/accel/adxl313.h      |  15 ++-
> > >  drivers/iio/accel/adxl313_core.c | 164 +++++++++++++++++++++++--------
> > >  drivers/iio/accel/adxl313_spi.c  |  40 +++++++-
> > >  3 files changed, 173 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> > > index 4415f2fc07e1..7428b1f7768f 100644
> > > --- a/drivers/iio/accel/adxl313.h
> > > +++ b/drivers/iio/accel/adxl313.h
> > > @@ -26,6 +26,7 @@
> > >  #define ADXL313_REG_FIFO_STATUS		0x39
> > >
> > >  #define ADXL313_DEVID0			0xAD
> > > +#define ADXL313_DEVID0_ADXL312_314	0xE5
> > >  #define ADXL313_DEVID1			0x1D
> > >  #define ADXL313_PARTID			0xCB
> > >  #define ADXL313_SOFT_RESET		0x52
> > > @@ -37,18 +38,28 @@
> > >  #define ADXL313_MEASUREMENT_MODE	BIT(3)
> > >
> > >  #define ADXL313_RANGE_MSK		GENMASK(1, 0)
> > > -#define ADXL313_RANGE_4G		3
> > > +#define ADXL313_RANGE_MAX		3
> > >
> > >  #define ADXL313_FULL_RES		BIT(3)
> > >  #define ADXL313_SPI_3WIRE		BIT(6)
> > >  #define ADXL313_I2C_DISABLE		BIT(6)
> > >
> > > +extern const struct regmap_access_table adxl312_readable_regs_table;
> > >  extern const struct regmap_access_table adxl313_readable_regs_table;
> > > +extern const struct regmap_access_table adxl314_readable_regs_table;
> > >
> > > +extern const struct regmap_access_table adxl312_writable_regs_table;
> > >  extern const struct regmap_access_table adxl313_writable_regs_table;
> > > +extern const struct regmap_access_table adxl314_writable_regs_table;
> > > +
> > > +enum adxl313_device_type {
> > > +	ADXL312,
> > > +	ADXL313,
> > > +	ADXL314,
> > > +};
> > >
> > >  int adxl313_core_probe(struct device *dev,
> > >  		       struct regmap *regmap,
> > > -		       const char *name,
> > > +		       const struct spi_device_id *id,
> > >  		       int (*setup)(struct device *, struct regmap *));
> > >  #endif /* _ADXL313_H_ */
> > > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> > > index afeef779e1d0..eea7d235950e 100644
> > > --- a/drivers/iio/accel/adxl313_core.c
> > > +++ b/drivers/iio/accel/adxl313_core.c
> > > @@ -11,9 +11,17 @@
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/module.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/spi/spi.h>  
> > 
> > Not in the core driver. This needs to be kept unware of the
> > buses that migh be used.
> >   
> > >
> > >  #include "adxl313.h"
> > >
> > > +static const struct regmap_range adxl312_readable_reg_range[] = {
> > > +	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
> > > +	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > > +	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> > > +	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
> > > +};
> > > +
> > >  static const struct regmap_range adxl313_readable_reg_range[] = {
> > >  	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
> > >  	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> > > @@ -22,12 +30,32 @@ static const struct regmap_range adxl313_readable_reg_range[] = {
> > >  	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS),
> > >  };
> > >
> > > +const struct regmap_access_table adxl312_readable_regs_table = {
> > > +	.yes_ranges = adxl312_readable_reg_range,
> > > +	.n_yes_ranges = ARRAY_SIZE(adxl312_readable_reg_range),
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(adxl312_readable_regs_table, IIO_ADXL312);
> > > +
> > >  const struct regmap_access_table adxl313_readable_regs_table = {
> > >  	.yes_ranges = adxl313_readable_reg_range,
> > >  	.n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range),
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(adxl313_readable_regs_table, IIO_ADXL313);
> > >
> > > +const struct regmap_access_table adxl314_readable_regs_table = {
> > > +	.yes_ranges = adxl312_readable_reg_range,
> > > +	.n_yes_ranges = ARRAY_SIZE(adxl312_readable_reg_range),
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(adxl314_readable_regs_table, IIO_ADXL314);
> > > +
> > > +static const struct regmap_range adxl312_writable_reg_range[] = {
> > > +	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > > +	regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> > > +	regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
> > > +	regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
> > > +	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
> > > +};
> > > +
> > >  static const struct regmap_range adxl313_writable_reg_range[] = {
> > >  	regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> > >  	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > > @@ -37,16 +65,30 @@ static const struct regmap_range adxl313_writable_reg_range[] = {
> > >  	regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL),
> > >  };
> > >
> > > +const struct regmap_access_table adxl312_writable_regs_table = {
> > > +	.yes_ranges = adxl312_writable_reg_range,
> > > +	.n_yes_ranges = ARRAY_SIZE(adxl312_writable_reg_range),
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(adxl312_writable_regs_table, IIO_ADXL312);
> > > +
> > >  const struct regmap_access_table adxl313_writable_regs_table = {
> > >  	.yes_ranges = adxl313_writable_reg_range,
> > >  	.n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range),
> > >  };
> > >  EXPORT_SYMBOL_NS_GPL(adxl313_writable_regs_table, IIO_ADXL313);
> > >
> > > +const struct regmap_access_table adxl314_writable_regs_table = {
> > > +	.yes_ranges = adxl312_writable_reg_range,
> > > +	.n_yes_ranges = ARRAY_SIZE(adxl312_writable_reg_range),
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(adxl314_writable_regs_table, IIO_ADXL314);
> > > +
> > >  struct adxl313_data {
> > >  	struct regmap	*regmap;
> > > +	const struct spi_device_id *id;
> > > +	int scale_factor;
> > >  	struct mutex	lock; /* lock to protect transf_buf */
> > > -	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
> > > +	__le16		transf_buf ____cacheline_aligned;  
> > Check your patch for accidental reverts of other changes like this...
> >   
> > >  };
> > >
> > >  static const int adxl313_odr_freqs[][2] = {
> > > @@ -156,12 +198,10 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
> > >  		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
> > >  		return IIO_VAL_INT;
> > >  	case IIO_CHAN_INFO_SCALE:
> > > -		/*
> > > -		 * Scale for any g range is given in datasheet as
> > > -		 * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
> > > -		 */
> > >  		*val = 0;
> > > -		*val2 = 9576806;
> > > +
> > > +		*val2 = data->scale_factor;  
> > I'd move this into a structure containing all the chip type specific data.
> > Hence this would be
> > data->chip.scale_factor.
> >   
> > > +
> > >  		return IIO_VAL_INT_PLUS_NANO;
> > >  	case IIO_CHAN_INFO_CALIBBIAS:
> > >  		ret = regmap_read(data->regmap,
> > > @@ -170,7 +210,7 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
> > >  			return ret;
> > >
> > >  		/*
> > > -		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> > > +		 * 8-bit resolution at minimum range, that is 4x accel data scale
> > >  		 * factor at full resolution
> > >  		 */
> > >  		*val = sign_extend32(regval, 7) * 4;
> > > @@ -198,7 +238,7 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
> > >  	switch (mask) {
> > >  	case IIO_CHAN_INFO_CALIBBIAS:
> > >  		/*
> > > -		 * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> > > +		 * 8-bit resolution at minimum range, that is 4x accel data scale
> > >  		 * factor at full resolution
> > >  		 */
> > >  		if (clamp_val(val, -128 * 4, 127 * 4) != val)
> > > @@ -223,14 +263,17 @@ static const struct iio_info adxl313_info = {
> > >  static int adxl313_setup(struct device *dev, struct adxl313_data *data,
> > >  			 int (*setup)(struct device *, struct regmap *))
> > >  {
> > > +	enum adxl313_device_type dev_type = data->id->driver_data;
> > >  	unsigned int regval;
> > >  	int ret;
> > >
> > > -	/* Ensures the device is in a consistent state after start up */
> > > -	ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> > > -			   ADXL313_SOFT_RESET);
> > > -	if (ret)
> > > -		return ret;
> > > +	/* If ADXL313, ensures the device is in a consistent state after start up */
> > > +	if (dev_type == ADXL313) {  
> > 
> > Add a flag to the chip_info structure suggested below for 'soft_reset' and
> > base this decision on that.  The aim is to encode all the variations in chips
> > in one place so adding future chips is isolated there.
> >   
> > > +		ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> > > +				   ADXL313_SOFT_RESET);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > >
> > >  	if (setup) {
> > >  		ret = setup(dev, data->regmap);
> > > @@ -242,41 +285,54 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	if (regval != ADXL313_DEVID0) {
> > > +	if (dev_type == ADXL313 && regval != ADXL313_DEVID0) {  
> > 
> > Obviously this predates your changes...
> > Don't fail in this case.  Warn only.  We may be dealing with a newer compatible
> > device that falls back to an the ADXL313 compatible in dt. It's fine to express
> > we don't know what it is - particularly if ID matches something else, but
> > not to fail as a result.
> >   
> 
> Is this change mandatory? I am asking this because we have setups that require
> the driver to fail if not the correct device is plugged in or if there is no device
> attached to the system. 

Yes unfortunately.  There have been a couple of discussions with the device
tree maintainers on this recently.
The problem case is that a new compatible chip with a different device ID
is introduced.  The expectation is that

compatible = "newchip", "olderchip-with-otherwise identical software interfaces"
will work with an old kernel that knows nothing about new chip.
Note this extends to newer devices that add features but maintain backwards
compatibility with older devices as well.  The idea is we get partial support
in older kernels and the new compatible will be used only when new features
are added.

As a general rule new IIO drivers are tending to warn/info on unexpected IDs because
there is a non trivial risk of the part being wrong. If they know the ID but
it's for a different device they support, they should assume the device is
the one the ID matches for (and warn that the DT is probably wrong for the
board).

There are corner cases that are fine for detecting 'no device' such as
when we know the manufacturer doesn't use 0x00 or 0xff (likely false values on
SPI) for device IDs. In those cases it is fine to fail on basis device
isn't there.

> 
> Returning only warnings will cause the device  to probe, but abnormal values
> to be produced. Moreover, most of the iio drivers perform a chip ID check and
> return an error code if the physical device is not found.

We had this wrong the past unfortunately and haven't 'fixed' all drivers yet.
However, note that I expect we will do this over time. If the DT is wrong then
you are on your own. Correct solution is perform some form of detection in
an early boot firmware (uboot or similar) and patch the DT appropriately.
By the time Linux sees DT it should be correct for the board.

> 
> Wouldn't it be better to treat the situation of new compatible devices when
> they appear?

Unfortunately people insist on not upgrading their kernels as quick as new
devices turn up in device trees + the intent is that there is no need to
if the device is compatible with an older one (up to the ID).

Jonathan


> 
> > >  		dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
> > >  		return -ENODEV;
> > >  	}


