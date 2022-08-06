Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C750558B660
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiHFPVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiHFPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76811A12;
        Sat,  6 Aug 2022 08:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF340B80025;
        Sat,  6 Aug 2022 15:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A961C433C1;
        Sat,  6 Aug 2022 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659799305;
        bh=XGP+EcZEOzVSFOo+6ddfdRfMGkTyuTlMgEE7CXSDNmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZJgwIc0rz9PUn0mOo89RfRGQ4kU4JXj8Ll1tl9YuZyjqGbXHU3cNUUnaOu9D4HFQm
         fsM/v1jFfILAwE79r9i5odUZ/zM1aCzQrjgbDcMFsUgbr+OIFgrv5epTFy04C4+yz0
         Ywj0cG5MB4mbzLgcGmdI9OiaVDOvtquyfZ5TjSfwFB2IhSdYEdlYfEEE/iyCmk/X8n
         rBVmIF5hv7w9vwIgrL2w7MYsKfBmwLr/KS2bDrF4s/6bIHf6rBwiaiCUt7QSanGoHI
         kwXH0/Y8BQdU7wPLjU9MknVVyHdQDcN/NipxAgMzdrv3FkAWJUU8A0BL4Lm4wt4QMV
         ldAwP188PZFRg==
Date:   Sat, 6 Aug 2022 16:32:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220806163204.3262c0e7@jic23-huawei>
In-Reply-To: <20220803131132.19630-3-ddrokosov@sberdevices.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
        <20220803131132.19630-3-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 13:11:25 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamic user-selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> 
> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>     - ODR (Output Data Rate) selection
>     - Scale and samp_freq selection
>     - IIO triggered buffer, IIO reg access
>     - NEW_DATA interrupt + trigger
> 
> Below features to be done:
>     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
>     - Low Power mode
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Hi Dmitry, 

A few small things I noticed whilst taking a quick look.

> ---

...

> +
> +/* Register map */
I'm not a big fan of 'structure of code' type comments like this one.
They tend to become wrong remarkably quickly. So unless they
are adding significant value, I would drop them.

> +
> +#define MSA311_SOFT_RESET_REG     0x00
> +#define MSA311_PARTID_REG         0x01
> +#define MSA311_ACC_X_REG          0x02
> +#define MSA311_ACC_Y_REG          0x04
> +#define MSA311_ACC_Z_REG          0x06
,...

> +/**
> + * struct msa311_priv - MSA311 internal private state
> + * @regs: Underlying I2C bus adapter used to abstract slave
> + *        register accesses
> + * @fields: Abstract objects for each registers fields access
> + * @dev: Device handler associated with appropriate bus client
> + * @lock: Protects msa311 device state between setup and data access routines
> + *        (power transitions, samp_freq/scale tune, retrieving axes data, etc)
> + * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
> + *                 to notify external consumers a new sample is ready
> + * @vdd: Optional external voltage regulator for the device power supply
> + */
> +struct msa311_priv {
> +	struct regmap *regs;
> +	struct regmap_field *fields[F_MAX_FIELDS];
> +
> +	struct device *dev;
> +	struct mutex lock; /* state guard */

Shouldn't need this comment given documentation above that provides
more information.

> +
> +	struct iio_trigger *new_data_trig;
> +	struct regulator *vdd;
> +};
>


> +static irqreturn_t msa311_irq_thread(int irq, void *p)
> +{
> +	struct msa311_priv *msa311 = iio_priv(p);
> +	unsigned int new_data_int_enabled;
> +	struct device *dev = msa311->dev;
> +	int err;
> +
> +	mutex_lock(&msa311->lock);

> +
> +	/*
> +	 * We do not check NEW_DATA int status, because of based on
> +	 * specification it's cleared automatically after a fixed time.
> +	 * So just check that is enabled by driver logic.

That is going to be very problematic if we can have this and events coming
through the same interrupt pin.  Not harmful for now though given you are
only supporting NEW_DATA for now.  Just something to watch out for.

> +	 */
> +	err = regmap_field_read(msa311->fields[F_NEW_DATA_INT_EN],
> +				&new_data_int_enabled);
> +
> +	/* TODO: check motion interrupts status */
> +
> +	mutex_unlock(&msa311->lock);
> +	if (err) {
> +		dev_err(dev, "cannot read new_data int state (%d)\n", err);
> +		return IRQ_NONE;
> +	}
> +
> +	if (new_data_int_enabled)
> +		iio_trigger_poll_chained(msa311->new_data_trig);
> +
> +	/* TODO: send motion events if needed */
> +
> +	return IRQ_HANDLED;
> +}
> +

> +
> +static int msa311_check_partid(struct msa311_priv *msa311)
> +{
> +	struct device *dev = msa311->dev;
> +	unsigned int partid;
> +	int err;
> +
> +	err = regmap_read(msa311->regs, MSA311_PARTID_REG, &partid);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to read partid (%d)\n", err);
> +
> +	if (partid == MSA311_WHO_AM_I)
> +		dev_dbg(dev, "found MSA311 compatible chip[%#x]\n", partid);

I think I'd drop this dev_dbg as in most cases other tracing options + absence
of the warning for when it doesn't match will be enough information.

> +	else
> +		dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
> +			 partid, MSA311_WHO_AM_I);
> +
> +	return 0;
> +}
> +


> +static int msa311_setup_interrupts(struct msa311_priv *msa311)
> +{
> +	struct device *dev = msa311->dev;
> +	struct i2c_client *i2c = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
> +	struct iio_trigger *trig;
> +	int err;
> +
> +	/* Keep going without interrupts if no initialized I2C irq */
> +	if (i2c->irq <= 0)
> +		return 0;
> +
> +	err = devm_request_threaded_irq(&i2c->dev, i2c->irq,
> +					NULL, msa311_irq_thread,
> +					IRQF_ONESHOT,
> +					i2c->name,

As below. I'd prefer the name hardcoded over relying on particular
firmwares having written the i2c name.

> +					indio_dev);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to request irq\n");
> +
> +	trig = devm_iio_trigger_alloc(dev, "%s-new-data", i2c->name);
here too.
> +	if (!trig)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "cannot allocate newdata trig\n");
> +
> +	msa311->new_data_trig = trig;
> +	msa311->new_data_trig->dev.parent = dev;

This is set by the IIO core as part of devm_iio_trigger_alloc()
We moved it to allocation (from registration) very recently
to simplify the few cases where it mattered. I don't think it did matter
in this particular case though - shouldn't have been in this driver either
way!

> +	msa311->new_data_trig->ops = &msa311_new_data_trig_ops;
> +	iio_trigger_set_drvdata(msa311->new_data_trig, indio_dev);
> +
> +	err = devm_iio_trigger_register(dev, msa311->new_data_trig);
> +	if (err)
> +		return dev_err_probe(dev, err, "can't register newdata trig\n");
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_OD],
> +				 MSA311_INT1_OD_PUSH_PULL);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot enable push-pull int\n");
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_LVL],
> +				 MSA311_INT1_LVL_HIGH);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot set active int level\n");
> +
> +	err = regmap_field_write(msa311->fields[F_LATCH_INT],
> +				 MSA311_LATCH_INT_LATCHED);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot latch int\n");
> +
> +	err = regmap_field_write(msa311->fields[F_RESET_INT], 1);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot reset int\n");
> +
> +	err = regmap_field_write(msa311->fields[F_INT1_NEW_DATA], 1);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot map new data int\n");
> +
> +	return 0;
> +}
> +

> +
> +static int msa311_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct msa311_priv *msa311;
> +	struct iio_dev *indio_dev;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*msa311));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "iio device allocation failed\n");
> +
> +	msa311 = iio_priv(indio_dev);
> +	msa311->dev = dev;
> +	i2c_set_clientdata(i2c, indio_dev);
> +
> +	err = msa311_regmap_init(msa311);
> +	if (err)
> +		return err;
> +
> +	mutex_init(&msa311->lock);
> +
> +	msa311->vdd = devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(msa311->vdd)) {
> +		err = PTR_ERR(msa311->vdd);
> +		if (err == -ENODEV)
> +			msa311->vdd = NULL;
> +		else
> +			return dev_err_probe(dev, PTR_ERR(msa311->vdd),
> +					     "cannot get vdd supply\n");
> +	}
> +
> +	if (msa311->vdd) {
> +		err = regulator_enable(msa311->vdd);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "cannot enable vdd supply\n");
> +
> +		err = devm_add_action_or_reset(dev, msa311_vdd_disable,
> +					       msa311->vdd);
> +		if (err) {
> +			regulator_disable(msa311->vdd);

Don't need the regulator_disable() call here. If devm_add_action_or_reset() fails
it will always call the callback (that's how it differs from devm_add_action())


> +			return dev_err_probe(dev, err,
> +					     "cannot add vdd disable action\n");
> +		}
> +	}
> +
> +	err = msa311_check_partid(msa311);
> +	if (err)
> +		return err;
> +
> +	err = msa311_soft_reset(msa311);
> +	if (err)
> +		return err;
> +
> +	err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "failed to power on device (%d)\n", err);
> +
> +	/*
> +	 * Register powerdown deferred callback which suspends the chip
> +	 * after module unloaded.
> +	 *
> +	 * MSA311 should be in SUSPEND mode in the two cases:
> +	 * 1) When driver is loaded, but we do not have any data or
> +	 *    configuration requests to it (we are solving it using
> +	 *    autosuspend feature).
> +	 * 2) When driver is unloaded and device is not used (devm action is
> +	 *    used in this case).
> +	 */
> +	err = devm_add_action_or_reset(dev, msa311_powerdown, msa311);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot add powerdown action\n");
> +

Probably want a pm_runtime_set_active() call here to let runtime PM know we
are starting it up with the chip turned on.  runtime pm gives me a headache
though so possible you don't strictly need this.

> +	err = devm_pm_runtime_enable(dev);
> +	if (err)
> +		return err;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	err = msa311_chip_init(msa311);
> +	if (err)
> +		return err;
> +
> +	indio_dev->modes = 0; /* setup buffered mode later */

As per other branch, I led you astray here it seems.

> +	indio_dev->channels = msa311_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(msa311_channels);
> +	indio_dev->name = i2c->name;

I'd rather see the part number encoded directly here as it should only ever
take one value (and that value should be based on the chipID once we have
multiple chipIDs supported - not what the firmware claims it is...)

> +	indio_dev->info = &msa311_info;
> +
> +	err = devm_iio_triggered_buffer_setup(dev,
> +					      indio_dev,
> +					      iio_pollfunc_store_time,
> +					      msa311_buffer_thread,
> +					      &msa311_buffer_setup_ops);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot setup iio trig buf\n");
> +
> +	err = msa311_setup_interrupts(msa311);
> +	if (err)
> +		return err;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	err = devm_iio_device_register(dev, indio_dev);
> +	if (err)
> +		return dev_err_probe(dev, err, "iio device register failed\n");
> +
> +	return 0;
> +}

...

