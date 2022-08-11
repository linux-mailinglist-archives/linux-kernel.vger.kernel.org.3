Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2603558FE29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiHKOSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiHKOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:18:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28374368;
        Thu, 11 Aug 2022 07:18:41 -0700 (PDT)
Received: from [IPV6:2405:201:10:389d:42df:ae4c:c047:294c] (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C53C6601D2F;
        Thu, 11 Aug 2022 15:18:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660227519;
        bh=cxtX52V91rWJFD9wPxapVB6Hwe73avZEgO2Qdf4hr04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KbTB80ZWlWeZWqxytaJFOUXXSKsPz2KJ+RSf+REqW+DsjnZjt40AbMP1FJ4bMn9SY
         Na8FnTNON/tlBd15EPd8sc9S0F3HBhxMVIRHEaSTnZeNU+FV2Cve/AD5wGXBzorAHx
         AVTIlJthTpFxBL9zh327SNu/1VX0TpRHT1mdZyq1D3NWvnKIvds/6b7cEirtUlD8zt
         8cvEBiSgId0BGnUZzqiuK6vhnJSCkWCLNE2VNc22MvnA6KYfLSax2G6kAFmAKAUIij
         qH0RhF2d1GRGJW0Gu8wZIiEMYwjgohWX6HbV7etL46gljYjpOoTfQ2JWKc+cuxLRUz
         vMB38egaHZ2GQ==
Message-ID: <4e481aa6-eebd-a934-72de-27f0e5e04fb1@collabora.com>
Date:   Thu, 11 Aug 2022 19:48:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] iio: light: Add raw attribute
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, krisman@collabora.com,
        kernel@collabora.com, alvaro.soliverez@collabora.com
References: <20220811101443.499761-1-shreeya.patel@collabora.com>
 <20220811142518.00000256@huawei.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220811142518.00000256@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/08/22 18:55, Jonathan Cameron wrote:
> On Thu, 11 Aug 2022 15:44:43 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
>> Add IIO_CHAN_INFO_RAW to the mask to be able to read raw values
>> from the light sensor.
> Why is this useful?  It's rare to support _PROCESSED and _RAW for the same channel.
> Normally occurred to avoid breaking ABI.

Hi Jonathan,

For some context, we have been using a downstream driver for ltrf216a
in steam deck. The formula for Lux calculation used in that driver is
incorrect which we corrected in the driver that has been upstreamed now.

The userspace code to handle brightness on steam deck uses the 
in_illuminance_input
value from sysfs and multiplies that value with some constant stored in 
BIOS at
factory calibration time.

With the Lux calculation change in upstreamed driver, 
in_illuminance_input gives us
a different value leading to change in the brightness on steam deck. It 
is also not possible
for us to recalculate the constant stored in BIOS.

We need a way to add some magic in userspace code so that brightness 
adjustment
works like before. So I'm trying to calculate a constant using the 
current formula
that we are using :-
( greendata * 45 * LTRF216A_WIN_FAC ) / ( data->als_data_gain * 
data->int_time_fac)

Except for the greendata which is ALS_DATA, I have all the other values 
to calculate
a constant, hence, I added RAW attribute so I can read the ALS_DATA 
value from userspace.


Thanks,
Shreeya Patel

>
> Jonathan
>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>>   drivers/iio/light/ltrf216a.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>> index e6e24e70d2b9..a717bf99bd2a 100644
>> --- a/drivers/iio/light/ltrf216a.c
>> +++ b/drivers/iio/light/ltrf216a.c
>> @@ -93,6 +93,7 @@ static const struct iio_chan_spec ltrf216a_channels[] = {
>>   	{
>>   		.type = IIO_LIGHT,
>>   		.info_mask_separate =
>> +			BIT(IIO_CHAN_INFO_RAW) |
>>   			BIT(IIO_CHAN_INFO_PROCESSED) |
>>   			BIT(IIO_CHAN_INFO_INT_TIME),
>>   		.info_mask_separate_available =
>> @@ -259,6 +260,18 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
>>   	int ret;
>>   
>>   	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = ltrf216a_set_power_state(data, true);
>> +		if (ret)
>> +			return ret;
>> +		mutex_lock(&data->lock);
>> +		ret = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = ret;
>> +		ltrf216a_set_power_state(data, false);
>> +		return IIO_VAL_INT;
>>   	case IIO_CHAN_INFO_PROCESSED:
>>   		mutex_lock(&data->lock);
>>   		ret = ltrf216a_get_lux(data);
