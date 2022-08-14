Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91F592582
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiHNQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243340AbiHNQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:40:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5802BE3;
        Sun, 14 Aug 2022 09:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B69B80B3C;
        Sun, 14 Aug 2022 16:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197A0C433D6;
        Sun, 14 Aug 2022 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660494657;
        bh=hB5GSqsYBUG0UIm0MUR0pzAfDCRA3x4i0KMcrIk710I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PSQG/e7uIbCAiX/PKpo2k4hn86qVx4CtGvxy8at6o0r+gIrtJppb5Imrh8OCo8Eht
         rZPoLmK2IUH6jnDcIlnzP3qjLDuwcS7urcRE+kO2TahmIWBx71pp7CrGrtealkldE4
         1phA8UzDsPcsnd80ph8+ZK5AIbzw9vX2jI0nFY626w+/x2fQlGyMqaN+lz+gr/gO2u
         vNh4OSXaqHZjvLV2UMV1rEM1H4JuLsebHsjc6CkvjED/rvWO1Gd/UbH0msxnudJ9Dn
         Ry0FGxy3/DMU/fXl842jgul/9jFl+12EWR3d7gTAUlH+pDiyKE+YV8lEqd7ZJV88HM
         XyanADJHJMLdQ==
Date:   Sun, 14 Aug 2022 17:41:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220814174122.4f9afbf3@jic23-huawei>
In-Reply-To: <20220812165243.22177-7-ddrokosov@sberdevices.ru>
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru>
        <20220812165243.22177-7-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 16:52:29 +0000
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
Hi Dmitry, a few minor comments from another read through.

> + */
> +static inline int msa311_set_odr(struct msa311_priv *msa311, unsigned int odr)
> +{
> +	struct device *dev = msa311->dev;
> +	unsigned int pwr_mode;
> +	bool good_odr = false;
> +	int err;
> +
> +	err = regmap_field_read(msa311->fields[F_PWR_MODE], &pwr_mode);
> +	if (err)
> +		return err;
> +
> +	/* Filter bad ODR values */
> +	if (pwr_mode == MSA311_PWR_MODE_NORMAL)
> +		good_odr = (odr > MSA311_ODR_1_95_HZ);
> +
> +	if (!good_odr) {
> +		dev_err(dev,
> +			"cannot set odr %u.%luHz, not available in %s mode\n",

Don't you need to zero pad the fractional part?
or use iio_format_values.

> +			msa311_odr_table[odr].val,
> +			msa311_odr_table[odr].val2 / MILLIHZ_PER_HZ,
> +			msa311_pwr_modes[pwr_mode]);
> +		return -EINVAL;
> +	}
> +
> +	return regmap_field_write(msa311->fields[F_ODR], odr);
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
> +					msa311->chip_name,
> +					indio_dev);

Could wrap this a little less given you are respinning anyway. It's way under
80 chars currently.

...
	     "cannot map new data interrupt\n");
> +
> +	return 0;
> +}
> +

> +	msa311->vdd = devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(msa311->vdd)) {
> +		err = PTR_ERR(msa311->vdd);
> +		if (err == -ENODEV)
> +			msa311->vdd = NULL;
> +		else
> +			return dev_err_probe(dev, PTR_ERR(msa311->vdd),

use err instead of PTR_ERR(msa311->vdd) ?

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

