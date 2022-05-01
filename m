Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBE5166A2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353122AbiEAReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353368AbiEAReH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7221AF0E;
        Sun,  1 May 2022 10:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 892E760DF5;
        Sun,  1 May 2022 17:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5743C385A9;
        Sun,  1 May 2022 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651426236;
        bh=+Sj4+OOIwwCCplhIGKM8DJp+5SXEF8N0Ep0e41vKsSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CNqrpXquA0HooR+qbgrBcU4068tjQxMiBMUFXwcc7htTRyS8XeBMVml6p4tC2ohMf
         QvaHzccSR5WebNzMha4E7WLZvk+CoOekcuk2f2d8pHeWpMPpGppgWKDS0I4a7id2So
         0tNGRE2/YvPQ24FG4z2kL5mSGovFODFFGHvD4vu1LOGAMgzj12Ol9udpyDftjcB3xz
         7s6BJvE0z5B6okFtGQacHQ7KAWBiISG6RohG9ABu6NAOXNAYjJF0F+UgyRAu5/fGLq
         rMnMaayjLc2kAGW0QbElvu+V+URrXxZfDQiEBclfdeW8IsNKN+wsv6pKrUjvOgrn7o
         aUY1gREYumvJA==
Date:   Sun, 1 May 2022 18:38:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v14 05/10] iio: adc: qcom-spmi-rradc: introduce round
 robin adc
Message-ID: <20220501183850.5bbbcbab@jic23-huawei>
In-Reply-To: <20220429220904.137297-6-caleb.connolly@linaro.org>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
        <20220429220904.137297-6-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 29 Apr 2022 23:09:00 +0100
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The Round Robin ADC is responsible for reading data about the rate of
> charge from the USB or DC input ports, it can also read the battery
> ID (resistence), skin temperature and the die temperature of the pmic.
> It is found on the PMI8998 and PM660 Qualcomm PMICs.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Hi Caleb,

I took another quick read through of this and noticed that the battery channel
is providing on IIO_INFO_RAW but there is code for IIO_INFO_PROCESSED.

Something gone wrong along the way?  If all we need is to change it to
BIT(IIO_INFO_PROCESSED) I can do that whilst applying or you can do a v15 if
you prefer.

Thanks,

Jonathan

> ---

> diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
> new file mode 100644
> index 000000000000..c437546d8a4c
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-rradc.c


..

> +
> +/*
> + * These functions explicitly cast int64_t to int.
> + * They will never overflow, as the values are small enough.

See below. I don't think this gets used...

> + */
> +static int rradc_post_process_batt_id(struct rradc_chip *chip, u16 adc_code,
> +				      int *result_ohms)
> +{
> +	uint32_t current_value;
> +	int64_t r_id;
> +
> +	current_value = chip->batt_id_data;
> +	r_id = ((int64_t)adc_code * RR_ADC_FS_VOLTAGE_MV);
> +	r_id = div64_s64(r_id, (RR_ADC_CHAN_MSB * current_value));
> +	*result_ohms = (int)(r_id * MILLI);
> +
> +	return 0;
> +}
> +


> +
> +static int rradc_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan_spec, int *val,
> +			  int *val2, long mask)
> +{
> +	struct rradc_chip *chip = iio_priv(indio_dev);
> +	const struct rradc_channel *chan;
> +	int ret;
> +	u16 adc_code;
> +
> +	if (chan_spec->address >= RR_ADC_CHAN_MAX) {
> +		dev_err(chip->dev, "Invalid channel index:%lu\n",
> +			chan_spec->address);
> +		return -EINVAL;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return rradc_read_scale(chip, chan_spec->address, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		return rradc_read_offset(chip, chan_spec->address, val);
> +	case IIO_CHAN_INFO_RAW:
> +		ret = rradc_do_conversion(chip, chan_spec->address, &adc_code);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = adc_code;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:

This doesn't seem to apply to any channels....

> +		chan = &rradc_chans[chan_spec->address];
> +		if (!chan->scale_fn)
> +			return -EINVAL;
> +		ret = rradc_do_conversion(chip, chan_spec->address, &adc_code);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = chan->scale_fn(chip, adc_code, val);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rradc_read_label(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, char *label)
> +{
> +	return snprintf(label, PAGE_SIZE, "%s\n",
> +			rradc_chans[chan->address].label);
> +}
> +
> +static const struct iio_info rradc_info = {
> +	.read_raw = rradc_read_raw,
> +	.read_label = rradc_read_label,
> +};
> +
> +static const struct rradc_channel rradc_chans[RR_ADC_CHAN_MAX] = {
> +	{
> +		.label = "batt_id",
> +		.scale_fn = rradc_post_process_batt_id,
> +		.lsb = RR_ADC_BATT_ID_5_LSB,
> +		.status = RR_ADC_BATT_ID_STS,
> +		.size = 6,
> +		.trigger_addr = RR_ADC_BATT_ID_TRIGGER,
> +		.trigger_mask = BIT(0),
> +	}, {
> +		.label = "batt",
> +		.lsb = RR_ADC_BATT_THERM_LSB,
> +		.status = RR_ADC_BATT_THERM_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_BATT_THERM_TRIGGER,
> +	}, {
> +		.label = "pmi8998_skin",
> +		.lsb = RR_ADC_SKIN_TEMP_LSB,
> +		.status = RR_ADC_AUX_THERM_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_AUX_THERM_TRIGGER,
> +	}, {
> +		.label = "usbin_i",
> +		.lsb = RR_ADC_USB_IN_I_LSB,
> +		.status = RR_ADC_USB_IN_I_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_USB_IN_I_TRIGGER,
> +	}, {
> +		.label = "usbin_v",
> +		.lsb = RR_ADC_USB_IN_V_LSB,
> +		.status = RR_ADC_USB_IN_V_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_USB_IN_V_TRIGGER,
> +		.trigger_mask = BIT(7),
> +	}, {
> +		.label = "dcin_i",
> +		.lsb = RR_ADC_DC_IN_I_LSB,
> +		.status = RR_ADC_DC_IN_I_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_DC_IN_I_TRIGGER,
> +	}, {
> +		.label = "dcin_v",
> +		.lsb = RR_ADC_DC_IN_V_LSB,
> +		.status = RR_ADC_DC_IN_V_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_DC_IN_V_TRIGGER,
> +	}, {
> +		.label = "pmi8998_die",
> +		.lsb = RR_ADC_PMI_DIE_TEMP_LSB,
> +		.status = RR_ADC_PMI_DIE_TEMP_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_PMI_DIE_TEMP_TRIGGER,
> +		.trigger_mask = RR_ADC_TRIGGER_EVERY_CYCLE,
> +	}, {
> +		.label = "chg",
> +		.lsb = RR_ADC_CHARGER_TEMP_LSB,
> +		.status = RR_ADC_CHARGER_TEMP_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_CHARGER_TEMP_TRIGGER,
> +	}, {
> +		.label = "gpio",
> +		.lsb = RR_ADC_GPIO_LSB,
> +		.status = RR_ADC_GPIO_STS,
> +		.size = 2,
> +		.trigger_addr = RR_ADC_GPIO_TRIGGER,
> +	},
> +};
> +
> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX] = {
> +	{
> +		.type = IIO_RESISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.address = RR_ADC_BATT_ID,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.address = RR_ADC_BATT_THERM,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.address = RR_ADC_SKIN_TEMP,
> +		.channel = 1,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_USBIN_I,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_USBIN_V,
> +		.channel = 0,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_CURRENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_DCIN_I,
> +		.channel = 1,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_DCIN_V,
> +		.channel = 1,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.address = RR_ADC_DIE_TEMP,
> +		.channel = 2,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_CHG_TEMP,
> +		.channel = 3,
> +		.indexed = 1,
> +	}, {
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.address = RR_ADC_GPIO,
> +		.channel = 2,
> +		.indexed = 1,
> +	},
> +};
> +

