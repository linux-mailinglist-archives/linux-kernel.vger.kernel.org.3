Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD59502E53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbiDORhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiDORhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8AF45AE2;
        Fri, 15 Apr 2022 10:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36605621A7;
        Fri, 15 Apr 2022 17:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E19C385A5;
        Fri, 15 Apr 2022 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650044109;
        bh=rL/Iu22dVqxNUTMaBt9ONG318iOM6T5p7OiX7xcE9tM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfM1Ar+y5byq6boTrZL0fUNgD8iSEm/d9Va0V53tHamhgpmXk6OBqOjxbxL4pIy2s
         9FlpgNCoRYI5VwZpIpt9JPZ6RZNQ8n7D6UZpeZZKPz6OITXit+ANcAMlbyX91tpM3n
         TcYcxV12pWP/+yyWJTJNDnTdtCGHR/Zl/m7/r3al/y4M8G2h9djhA8K4wR/av116b8
         yJyN4KCMqIsZkoYFle+uNGftNhRo4g5OH1DXusOhYldKokMXLlzftTDpSgtM7+L3Q0
         UlQjDDfxPZyKkC9YrvwgFGda0tIL3kZhArXXgOnaQ8HoHBakAUTELzsWNCHUOmtks4
         ywMqWMAat1uEw==
Date:   Fri, 15 Apr 2022 18:43:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v4 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
Message-ID: <20220415184305.03805452@jic23-huawei>
In-Reply-To: <20220415130005.85879-9-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
        <20220415130005.85879-9-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 15 Apr 2022 14:59:59 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> From: Andrea Merello <andrea.merello@iit.it>
> 
> This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> can be connected via both serial and I2C busses; separate patches will
> add support for them.
> 
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also do calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
> 
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass
> filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> they can be customized; this is why AMG mode can still be interesting.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Hi Andrea,

A few trivial things from me on this read through.

I haven't commented on a lot of the patches because I was happy with them.

Other than the small changes requested from me, we mostly need to get
device tree review of the binding and allow time for others to take
another look.

Thanks,

Jonathan


> ---

...

> +
> +static int bno055_read_simple_chan(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	__le16 raw_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(priv->regmap, chan->address,
> +				       &raw_val, sizeof(raw_val));
> +		if (ret < 0)
> +			return ret;
> +		*val = (s16)le16_to_cpu(raw_val);

Hmm. I'd ever so slightly prefer

sign_extend32(le16_to_cpu(raw_val), 15) as it makes it extremely clear
what is going on and hopefully the compiler can do a good job
of optimising it either way.  If you strongly prefer the current
approach I'll cope :)

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (priv->operation_mode != BNO055_OPR_MODE_AMG) {
> +			*val = 0;
> +		} else {
> +			ret = regmap_bulk_read(priv->regmap,
> +					       chan->address +
> +					       BNO055_REG_OFFSET_ADDR,
> +					       &raw_val, sizeof(raw_val));
> +			if (ret < 0)
> +				return ret;
> +			/*
> +			 * IMU reports sensor offests; IIO wants correction
> +			 * offset, thus we need the 'minus' here.
> +			 */
> +			*val = -(s16)le16_to_cpu(raw_val);
> +		}
> +		return IIO_VAL_INT;
...

> +}

...

> +
> +static int bno055_read_quaternion(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int size, int *vals, int *val_len,
> +				  long mask)
> +{
> +	struct bno055_priv *priv = iio_priv(indio_dev);
> +	__le16 raw_vals[4];
> +	int i, ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (size < 4)
> +			return -EINVAL;
> +		ret = regmap_bulk_read(priv->regmap,
> +				       BNO055_QUAT_DATA_W_LSB_REG,
> +				       raw_vals, sizeof(raw_vals));
> +		if (ret < 0)
> +			return ret;
> +		for (i = 0; i < 4; i++)
> +			vals[i] = (s16)le16_to_cpu(raw_vals[i]);
> +		*val_len = 4;
> +		return IIO_VAL_INT_MULTIPLE;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Table 3-31: 1 quaternion = 2^14 LSB */
> +		if (size < 2)
> +			return -EINVAL;
> +		vals[0] = 14;
> +		vals[1] = 1 << 14;
This looks odd.  As you are using FRACTIONAL_LOG2, I think that should
just be
vals[0] = 1;
vals[1] = 14;

> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +



...

> +
> +static void bno055_clk_disable(void *arg)
> +{
> +	clk_disable_unprepare((struct clk *)arg);
> +}

Hopefully one day: https://lore.kernel.org/all/CAHp75VdH4vGr57v6tfkRuxh-3agRKO8C08+DH8dsB1HnPfnz5Q@mail.gmail.com/
will get merged...  Until then, this is the best we can do.

> +
> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +		 int xfer_burst_break_thr, bool sw_reset)
> +{
> +	const struct firmware *caldata;
See comment below. I think you need to set this to NULL here


> +
> +	ret = regmap_read(priv->regmap, BNO055_CHIP_ID_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != BNO055_CHIP_ID_MAGIC) {

We've run into this a few times recently.  Traditionally IIO has been very
restrictive on allowing drivers to probe if the Who Am I type values
don't match.  That causes problems for backwards compatibility in
device tree - e.g. (with made up compatible part number 055b :)
compatible = "bosch,bno055b", "bosch,bno055"

The viewpoint of the dt maintainers is that we should assume the
dt is correct and at most warn about missmatched IDs before trying
to carry on.  So to avoid hitting that again please relax this to a
warning and cross your fingers after this point if it doesn't match.
I'm fine on the firmware question because we know we are dealing
with buggy firmware.  Ideally we'll get some working firmware
additions at somepoint then we can just label the bad firmwares
and assume one less bug in the ones that don't match :)

> +		dev_err(dev, "Unrecognized chip ID 0x%x", val);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * In case we haven't a HW reset pin, we can still reset the chip via
> +	 * register write. This is probably nonsense in case we can't even
> +	 * communicate with the chip or the chip isn't the one we expect (i.e.
> +	 * we don't write to unknown chips), so we perform SW reset only after
> +	 * chip magic ID check
> +	 */
> +	if (!priv->reset_gpio) {
> +		ret = bno055_system_reset(priv);
> +		if (ret)
> +			return ret;
> +	}
> +

...

> +	ret = regmap_bulk_read(priv->regmap, BNO055_UID_LOWER_REG,
> +			       priv->uid, BNO055_UID_LEN);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * This has nothing to do with the IMU firmware, this is for sensor
> +	 * calibration data.

I'd not say what it isn't.  What it is will be enough.

	/* Sensor calibration data */

> +	 */
> +	fw_name_buf = kasprintf(GFP_KERNEL,
> +				BNO055_FW_UID_NAME,
> +				BNO055_UID_LEN, priv->uid);
> +	if (!fw_name_buf)
> +		return -ENOMEM;
> +
> +	ret = request_firmware(&caldata, fw_name_buf, dev);
> +	kfree(fw_name_buf);
> +	if (ret)
> +		ret = request_firmware(&caldata, BNO055_FW_GENERIC_NAME, dev);
> +
> +	if (ret)
> +		dev_notice(dev, "Calibration file load failed. See instruction in kernel Documentation/iio/bno055.rst");

If no calibration files are found, is caldata guaranteed to have been set to NULL?
I'm not seeing that in the documentation, so even if it is true today it might not
be in future and I think that leaves you referencing a variable that may not
have been set.   Probably just set caldata_data = NULL where you define
the local variable at top of this function.

> +
> +	if (caldata) {
> +		caldata_data = caldata->data;
> +		caldata_size = caldata->size;
> +	}
> +	ret = bno055_init(priv, caldata_data, caldata_size);
> +	if (caldata)
> +		release_firmware(caldata);
> +	if (ret)
> +		return ret;
> +

