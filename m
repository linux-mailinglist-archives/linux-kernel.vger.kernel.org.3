Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEAD589210
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiHCSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiHCSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:11:12 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC1E4F697
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:11:10 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id JIploQDLd9RnzJIpmowjJ7; Wed, 03 Aug 2022 20:11:08 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Aug 2022 20:11:08 +0200
X-ME-IP: 90.11.190.129
Message-ID: <67041dbe-ad6c-c53f-9760-bd7b5988d137@wanadoo.fr>
Date:   Wed, 3 Aug 2022 20:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Content-Language: en-US
To:     ddrokosov@sberdevices.ru
Cc:     andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        jic23@kernel.org, kernel@sberdevices.ru, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, stano.jakubek@gmail.com,
        stephan@gerhold.net
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220803131132.19630-3-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/08/2022 à 15:11, Dmitry Rokosov a écrit :
> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamic user-selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> 
> This driver supports following MSA311 features:
>      - IIO interface
>      - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>      - ODR (Output Data Rate) selection
>      - Scale and samp_freq selection
>      - IIO triggered buffer, IIO reg access
>      - NEW_DATA interrupt + trigger
> 
> Below features to be done:
>      - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
>      - Low Power mode
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov-i4r8oA+eLlH99rHkP+FxIw@public.gmane.org>
> ---
>   MAINTAINERS                |    6 +
>   drivers/iio/accel/Kconfig  |   13 +
>   drivers/iio/accel/Makefile |    2 +
>   drivers/iio/accel/msa311.c | 1323 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 1344 insertions(+)
>   create mode 100644 drivers/iio/accel/msa311.c
> 

Hi,
a few nits below.

[...]

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

No need for "(%d)" and err.

> +
> +	if (partid == MSA311_WHO_AM_I)
> +		dev_dbg(dev, "found MSA311 compatible chip[%#x]\n", partid);
> +	else
> +		dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
> +			 partid, MSA311_WHO_AM_I);
> +
> +	return 0;
> +}

[...]

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

Double regulator_disable(), because of the _or_reset()?

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

No need for "(%d)" and err

CJ
