Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5D51FBBC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiEIL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiEIL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:57:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DDF35AA4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:53:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so19062021wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RxUzrPlGd351YrggkQ+XVPFB6IRBoiOml8FovLXDQls=;
        b=QkXMW5uuaL3UWTGchOY4X5vIz2WtCTt+ksTinRvBmWsybFlbwoMxdLcDQOxye3ohgi
         gnmzf6e3rnEgJ0uOQrRNHKHMU+ULsY9FJBBhSFJH3TbPAzKHQRPdwW8EZk+j1tH88eFn
         ODC8CR8RZbxKmtHeS/vTb/W53fH8Q0NSiS5Wf2GvXdi1xEIO75iAFQ3FqlQEB0N2SwPQ
         NPldIAEDAPHH+KnG9POHjALKNJnbvNCs0azsHHRbqYi9pGvMmBcrZX+QIbQ6CfQXF/K9
         jezmJsaQymWVYXSUG1qlVuJTpoy+2xkS7uvm/evWWoQo/OYMOBNVeeuOMLCRK4EA8ryy
         rdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RxUzrPlGd351YrggkQ+XVPFB6IRBoiOml8FovLXDQls=;
        b=4RzrTjgYZi4+YGuQkswYgspbdomU/cnY3OUQl0l8jbgJNSVXqb1dK0yZMr9Pzh72/3
         yhmSDWOhuv8TvN28VEEYyJqoCr9zeFU88jC1ZlxcocRIusrFsXhc6tQVvGBnNGehrSND
         ntKNmHLaqATbvyfD5U34S4tktv4zkXfFQYVVMBpjuL9oZ1+PhabSIioo7P2w6eQmplNr
         u89ncHCXkVf9L4++d2bAPivqM5J3x4N0Ii4o5mhrbtXiNb2LxkVlOO+vY5dM9yLXJKhw
         CF5LS29yM8qaA14gRGGkM1uh9u7pgEhC+lzBGE8UA5ljW7zEDwsMZAPd8NGaBBMWjYbg
         78OA==
X-Gm-Message-State: AOAM5307V8za2dMLkSDM3hvK4nceYMifOhMYYgJyNCtGbgR+mluVDMmR
        IW3McCljboac8BWaxpL8Ob7gHg==
X-Google-Smtp-Source: ABdhPJynPqQUzeFT4sckq1r/7NDs65EafIDtt517li/wAXth+qZSTmTNNlUOB6AgZGr6bSeEd4qyTw==
X-Received: by 2002:a5d:598c:0:b0:20c:6912:6870 with SMTP id n12-20020a5d598c000000b0020c69126870mr13265519wri.465.1652097194941;
        Mon, 09 May 2022 04:53:14 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id y17-20020a7bc191000000b003942a244f45sm5298524wmi.30.2022.05.09.04.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 04:53:14 -0700 (PDT)
Message-ID: <b148d9a1-9c3b-9e6f-1419-7a644bcd43b5@linaro.org>
Date:   Mon, 9 May 2022 12:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v14 05/10] iio: adc: qcom-spmi-rradc: introduce round
 robin adc
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
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
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220429220904.137297-6-caleb.connolly@linaro.org>
 <20220501183850.5bbbcbab@jic23-huawei>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220501183850.5bbbcbab@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/05/2022 18:38, Jonathan Cameron wrote:
> On Fri, 29 Apr 2022 23:09:00 +0100
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> The Round Robin ADC is responsible for reading data about the rate of
>> charge from the USB or DC input ports, it can also read the battery
>> ID (resistence), skin temperature and the die temperature of the pmic.
>> It is found on the PMI8998 and PM660 Qualcomm PMICs.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Hi Caleb,
Hi Jonathan,

Thanks for spotting this, I completely missed it... Yeah this should be 
IIO_INFO_PROCESSED, the battery ID calculation doesn't fit in the 
raw/offset/scale format.
> 
> I took another quick read through of this and noticed that the battery channel
> is providing on IIO_INFO_RAW but there is code for IIO_INFO_PROCESSED.
> 
> Something gone wrong along the way?  If all we need is to change it to
> BIT(IIO_INFO_PROCESSED) I can do that whilst applying or you can do a v15 if
> you prefer.
That would be hugely appreciated, thanks a lot.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
> 
>> diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
>> new file mode 100644
>> index 000000000000..c437546d8a4c
>> --- /dev/null
>> +++ b/drivers/iio/adc/qcom-spmi-rradc.c
> 
> 
> ..
> 
>> +
>> +/*
>> + * These functions explicitly cast int64_t to int.
>> + * They will never overflow, as the values are small enough.
> 
> See below. I don't think this gets used...
> 
>> + */
>> +static int rradc_post_process_batt_id(struct rradc_chip *chip, u16 adc_code,
>> +				      int *result_ohms)
>> +{
>> +	uint32_t current_value;
>> +	int64_t r_id;
>> +
>> +	current_value = chip->batt_id_data;
>> +	r_id = ((int64_t)adc_code * RR_ADC_FS_VOLTAGE_MV);
>> +	r_id = div64_s64(r_id, (RR_ADC_CHAN_MSB * current_value));
>> +	*result_ohms = (int)(r_id * MILLI);
>> +
>> +	return 0;
>> +}
>> +
> 
> 
>> +
>> +static int rradc_read_raw(struct iio_dev *indio_dev,
>> +			  struct iio_chan_spec const *chan_spec, int *val,
>> +			  int *val2, long mask)
>> +{
>> +	struct rradc_chip *chip = iio_priv(indio_dev);
>> +	const struct rradc_channel *chan;
>> +	int ret;
>> +	u16 adc_code;
>> +
>> +	if (chan_spec->address >= RR_ADC_CHAN_MAX) {
>> +		dev_err(chip->dev, "Invalid channel index:%lu\n",
>> +			chan_spec->address);
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		return rradc_read_scale(chip, chan_spec->address, val, val2);
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		return rradc_read_offset(chip, chan_spec->address, val);
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = rradc_do_conversion(chip, chan_spec->address, &adc_code);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val = adc_code;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_PROCESSED:
> 
> This doesn't seem to apply to any channels....
> 
>> +		chan = &rradc_chans[chan_spec->address];
>> +		if (!chan->scale_fn)
>> +			return -EINVAL;
>> +		ret = rradc_do_conversion(chip, chan_spec->address, &adc_code);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		*val = chan->scale_fn(chip, adc_code, val);
>> +		return IIO_VAL_INT;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int rradc_read_label(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, char *label)
>> +{
>> +	return snprintf(label, PAGE_SIZE, "%s\n",
>> +			rradc_chans[chan->address].label);
>> +}
>> +
>> +static const struct iio_info rradc_info = {
>> +	.read_raw = rradc_read_raw,
>> +	.read_label = rradc_read_label,
>> +};
>> +
>> +static const struct rradc_channel rradc_chans[RR_ADC_CHAN_MAX] = {
>> +	{
>> +		.label = "batt_id",
>> +		.scale_fn = rradc_post_process_batt_id,
>> +		.lsb = RR_ADC_BATT_ID_5_LSB,
>> +		.status = RR_ADC_BATT_ID_STS,
>> +		.size = 6,
>> +		.trigger_addr = RR_ADC_BATT_ID_TRIGGER,
>> +		.trigger_mask = BIT(0),
>> +	}, {
>> +		.label = "batt",
>> +		.lsb = RR_ADC_BATT_THERM_LSB,
>> +		.status = RR_ADC_BATT_THERM_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_BATT_THERM_TRIGGER,
>> +	}, {
>> +		.label = "pmi8998_skin",
>> +		.lsb = RR_ADC_SKIN_TEMP_LSB,
>> +		.status = RR_ADC_AUX_THERM_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_AUX_THERM_TRIGGER,
>> +	}, {
>> +		.label = "usbin_i",
>> +		.lsb = RR_ADC_USB_IN_I_LSB,
>> +		.status = RR_ADC_USB_IN_I_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_USB_IN_I_TRIGGER,
>> +	}, {
>> +		.label = "usbin_v",
>> +		.lsb = RR_ADC_USB_IN_V_LSB,
>> +		.status = RR_ADC_USB_IN_V_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_USB_IN_V_TRIGGER,
>> +		.trigger_mask = BIT(7),
>> +	}, {
>> +		.label = "dcin_i",
>> +		.lsb = RR_ADC_DC_IN_I_LSB,
>> +		.status = RR_ADC_DC_IN_I_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_DC_IN_I_TRIGGER,
>> +	}, {
>> +		.label = "dcin_v",
>> +		.lsb = RR_ADC_DC_IN_V_LSB,
>> +		.status = RR_ADC_DC_IN_V_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_DC_IN_V_TRIGGER,
>> +	}, {
>> +		.label = "pmi8998_die",
>> +		.lsb = RR_ADC_PMI_DIE_TEMP_LSB,
>> +		.status = RR_ADC_PMI_DIE_TEMP_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_PMI_DIE_TEMP_TRIGGER,
>> +		.trigger_mask = RR_ADC_TRIGGER_EVERY_CYCLE,
>> +	}, {
>> +		.label = "chg",
>> +		.lsb = RR_ADC_CHARGER_TEMP_LSB,
>> +		.status = RR_ADC_CHARGER_TEMP_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_CHARGER_TEMP_TRIGGER,
>> +	}, {
>> +		.label = "gpio",
>> +		.lsb = RR_ADC_GPIO_LSB,
>> +		.status = RR_ADC_GPIO_STS,
>> +		.size = 2,
>> +		.trigger_addr = RR_ADC_GPIO_TRIGGER,
>> +	},
>> +};
>> +
>> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX] = {
>> +	{
>> +		.type = IIO_RESISTANCE,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.address = RR_ADC_BATT_ID,
>> +		.channel = 0,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_TEMP,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.address = RR_ADC_BATT_THERM,
>> +		.channel = 0,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_TEMP,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE) |
>> +				      BIT(IIO_CHAN_INFO_OFFSET),
>> +		.address = RR_ADC_SKIN_TEMP,
>> +		.channel = 1,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_CURRENT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.address = RR_ADC_USBIN_I,
>> +		.channel = 0,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_VOLTAGE,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.address = RR_ADC_USBIN_V,
>> +		.channel = 0,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_CURRENT,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.address = RR_ADC_DCIN_I,
>> +		.channel = 1,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_VOLTAGE,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.address = RR_ADC_DCIN_V,
>> +		.channel = 1,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_TEMP,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE) |
>> +				      BIT(IIO_CHAN_INFO_OFFSET),
>> +		.address = RR_ADC_DIE_TEMP,
>> +		.channel = 2,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_TEMP,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_OFFSET) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.address = RR_ADC_CHG_TEMP,
>> +		.channel = 3,
>> +		.indexed = 1,
>> +	}, {
>> +		.type = IIO_VOLTAGE,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> +				      BIT(IIO_CHAN_INFO_SCALE),
>> +		.address = RR_ADC_GPIO,
>> +		.channel = 2,
>> +		.indexed = 1,
>> +	},
>> +};
>> +
> 

-- 
Kind Regards,
Caleb (they/he)
