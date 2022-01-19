Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB23493F35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356478AbiASRm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356397AbiASRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:42:55 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BBBC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:42:54 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so7069324wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OegbDPdXm3sV0Rvdu8S4fL7eXlxzhuHMWuEq/Y9oGpw=;
        b=FRqsTopmLNQWeJMYKN9m9ZbfoVKW0+n1Xvnrt4g/w1013FQM0Z+3zU/g4yTBb2h3sx
         ij0tkqkuwaoyc909S+9ckn43iYmmBfqxZ/JqsQI+SPp2wfoFjZ4a3VvXADhLQdoCKqEe
         6lycmMJ0Es1pSl7cqYHy6+mS4fDVjaY7K+uEYfCxdVKLLq0tRKg+5N2gvjR8ZdAsnWXY
         Poz1EGfSWWUs64K/dnD19QlAZRG14/6Z/IZpqa1y2RYEy5WLhPcARz3v2Ga/FPiwlkx4
         vhE5O414ebBRT5jqt1vfA/AzbnLmaW++8twO3QNW2jtbFWxSmKPh3SfJxkX2ASZbigDg
         s9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OegbDPdXm3sV0Rvdu8S4fL7eXlxzhuHMWuEq/Y9oGpw=;
        b=KB/BdcD8IUGiLF5JyZsz0cLR/28K0Bwawg1YyJn2GmLZDabj0Qex06+orbfuUrRWgB
         SWedb+0izbFrRdh2F16gywfzF5D1mbGW2Mtg/ksT9dQVxLRm09GrfD4qJBe89pFoHW+w
         xQiLEDh8YluAqzRv+IY4Pezy7jAD7FNqypUGZHG6ttDzYyrrIosy/PqS7CiV8OazYm3L
         YjRPGmGWrG6jGaxmWR29lQJS12SEz5MA3VjFbWz5Dqr0j+o3KApqbdVxDJ7BZk72rPqz
         Msl1XcYDm2qrzotA1LEU5mK/f4umEuqxza1BWGUtw9LgBXQaB8pjFviG1LQCN9TE6pgl
         O9Kg==
X-Gm-Message-State: AOAM531G91VNfgeJZHhrinmaaG0aotnISh5y7mpcdDmjFLhGjSQmJQ4s
        KaFAUQe6mW4uojLedyfNhRME1g==
X-Google-Smtp-Source: ABdhPJxVYEBLDcVZw2238uOiXYZ+lN+sQ1uikswfKycmpoS9k3JMLNBS3/RjGpr/sGNXgww775ixxA==
X-Received: by 2002:a05:6000:1709:: with SMTP id n9mr4480560wrc.10.1642614173119;
        Wed, 19 Jan 2022 09:42:53 -0800 (PST)
Received: from [192.168.0.30] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id l19sm235843wmq.7.2022.01.19.09.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 09:42:52 -0800 (PST)
Message-ID: <d0d42804-f437-e964-1c0d-4eb65e76db6c@linaro.org>
Date:   Wed, 19 Jan 2022 17:42:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 3/7] iio: adc: qcom-spmi-rradc: introduce round robin
 adc
Content-Language: en-US
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
 <20220106173131.3279580-4-caleb.connolly@linaro.org>
 <20220109172948.76dbb1fa@jic23-huawei>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220109172948.76dbb1fa@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/2022 17:29, Jonathan Cameron wrote:
> On Thu,  6 Jan 2022 17:31:27 +0000
> Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> The Round Robin ADC is responsible for reading data about the rate of
>> charge from the USB or DC in jacks, it can also read the battery
>> ID (resistence) and some temperatures. It is found on the PMI8998 and
>> PM660 Qualcomm PMICs.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Hi Calib,
Hi Jonathan,

I've spent some time on this and mostly reworked things, thanks a lot for
your feedback, it's been quite interesting to learn about IIO. :)

Quite a few of the channels fit well into the (adc_code + offset) * scale format,
however the one you commented on "rradc_post_process_chg_temp()" doesn't seem to
fit, it requires multiple steps of applying offsets and scale and I haven't been
able to re-arrange it to work sensibly.

I noticed the calibbias properties which seems like something I should expose
for "rradc_get_fab_coeff()"?

Could you point me in the right direction here? For reference my WIP tree can be
found here: https://github.com/aospm/linux/commits/upstreaming/spmi-rradc

I also tried switching to labels, but I found that when I drop the extend_name
property the driver fails to probe because multiple channels end up with the same
name in sysfs (e.g. "in_temp_raw"). I've read through the docs and looked at a few
other drivers but I wasn't able to find out what I'm missing for this to work.

I've snipped to the relevant bits below.

Kind regards,
Caleb
> 
> Various things inline but biggest is probably that in IIO we prefer
> if possible to make application of offsets and scales a job for the caller,
> either userspace or in kernel callers. This allows them to maintain precision
> better if they need to further transform the data.
> 
> Jonathan
> 
>> ---
>>   drivers/iio/adc/Kconfig           |   13 +
>>   drivers/iio/adc/Makefile          |    1 +
>>   drivers/iio/adc/qcom-spmi-rradc.c | 1070 +++++++++++++++++++++++++++++
>>   3 files changed, 1084 insertions(+)
>>   create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
>>

[snip]

>> +static int rradc_post_process_chg_temp(struct rradc_chip *chip, u16 adc_code,
>> +				       int *result_millidegc)
>> +{
>> +	int64_t uv, offset, slope;
>> +	int ret;
>> +
>> +	ret = rradc_get_fab_coeff(chip, &offset, &slope);
>> +	if (ret < 0) {
>> +		dev_err(chip->dev, "Unable to get fab id coefficients\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	uv = ((int64_t)adc_code * RR_ADC_TEMP_FS_VOLTAGE_NUM);
>> +	uv = div64_s64(uv,
>> +		       (RR_ADC_TEMP_FS_VOLTAGE_DEN * RR_ADC_CHAN_MAX_VALUE));
>> +	uv = offset - uv;
>> +	uv = div64_s64((uv * MILLI), slope);
>> +	uv += RR_ADC_CHG_TEMP_OFFSET_MILLI_DEGC;
>> +	*result_millidegc = (int)uv;
> 
> Marginally harder than the one below, but this is still looking like it can
> be well expressed as an offset + scale.  Thus making the tedious maths
> userspaces or callers problem.  I'm working backwards hence won't comment on
> similar before this point. Key is to transform whatever maths you have into
> 
> (adc_code + offset) * scale then expose offset and scale as well as the
> raw value.  The right maths will get done for in kernel users and
> userspace can do it nicely with floating point.
> 
>> +
>> +	return 0;
>> +}

[snip]

>> +static const struct iio_chan_spec rradc_iio_chans[RR_ADC_CHAN_MAX] = {
>> +	{
>> +		.extend_name = "batt_id",
> 
> We recently introduced channel labels to try and avoid the need for
> extend_name.  The problem with extend_name is that generic software then
> has trouble parsing the resulting sysfs files as they can have very
> freeform naming.  Moving it to label makes that much easier.  Note that
> there is code to give a default label of extend_name to work around
> this problem for older drivers.
> 
>> +		.type = IIO_RESISTANCE,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.address = RR_ADC_BATT_ID,
>> +	},

> 
> Thanks,
> 
> Jonathan

-- 
Kind Regards,
Caleb (they/them)
