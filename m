Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5F59D253
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiHWHib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiHWHi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:38:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394926323;
        Tue, 23 Aug 2022 00:38:24 -0700 (PDT)
Received: from [IPV6:2405:201:10:389d:42df:ae4c:c047:294c] (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 418646601D6C;
        Tue, 23 Aug 2022 08:38:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661240302;
        bh=RR3DsGctabxB0wq90bhQwx/toTIhdf248hspU1c4lN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bb942cUwAkCI4IJr6wQ/rGR3IcT0hbjmMttL7+vI7+WEIP8NT1ZE3XMcKX9AL0Yfg
         ib0FN+dx45AVVHLifYvcH8OU4TpBRvdlfw1oaYOTmhhTPy8HXhtsI7/0ZMh13M2KNf
         X8NiKjExy9jDrUoZ0a1Zb5R44Cexo19O/RxBAJ0Te+aTICjKWx2yhFsnglMJnHYWDn
         E7Gu+Fnuj3GMowhxLmQ7PA4M4H6R4X84saOkecdy0JiEVGqTb3/542Kahl/0D/WPhw
         2Fp9HoA2Ui3LhNnL6Wz4UESLgvb+13casCwsm1r/Fhoxn+h29YpNLdYx/QhS4v2el/
         8Mwu+eycPPHAw==
Message-ID: <5f7fd4cc-dcc5-2d47-5271-bf7bd78b5df4@collabora.com>
Date:   Tue, 23 Aug 2022 13:08:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iio: light: ltrf216a: Add raw attribute
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, krisman@collabora.com,
        kernel@collabora.com, alvaro.soliverez@collabora.com
References: <20220812100424.529425-1-shreeya.patel@collabora.com>
 <20220814172232.4caeaf1c@jic23-huawei>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220814172232.4caeaf1c@jic23-huawei>
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


On 14/08/22 21:52, Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 15:34:24 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
>> Add IIO_CHAN_INFO_RAW to the mask to be able to read raw values
>> from the light sensor.
>>
>> The userspace code for brightness control in steam deck uses the
>> in_illuminance_input value through sysfs and multiplies it
>> with a constant stored in BIOS at factory calibration time.
>>
>> The downstream driver for LTRF216A that we have been using
>> has incorrect formula for LUX calculation which we corrected
>> in the upstreamed driver.
>>
>> Now to be able to use the upstreamed driver, we need to add some
>> magic in userspace so that the brightness control works like before
>> even with the updated LUX formula.
>>
>> Hence, we need the raw data to calculate a constant that can be
>> added in userspace code.
>>
>> Downstream driver LUX formula :-
>> (greendata*8*LTRF216A_WIN_FAC) / (data->als_gain_fac*data->int_time_fac*10)
>>
>> Upstreamed driver LUX formula :-
>> (greendata*45*LTRF216A_WIN_FAC) / (data->als_gain_fac*data->int_time_fac)
>>
>> greendata is the ALS_DATA which we would like to get through sysfs using
>> the raw attribute.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Hi Shreeya.
>
> Your description above makes me wonder though if we should support
> this as an intensity channel as we did for many of the early Ambient light
> sensors.  Not sure why it's called 'greendata' btw!
> For those early tsl2583 IIRC and similar, we had two sensors with infrared vs
> visible+infrared (which is basically what clear is here).
> The readings given were of those two sensors then we did a bunch of maths
> to convert those to LUX (in simplest drivers we simply subtracted
> the infrared part from visible and applied a scale factor)
>
> That lead to IIO_TYPE_BOTH though we later added IIO_TYPE_CLEAR which is
> subtly different as that was for color sensors with RGB and clearish
> filters.  The value you want here doesn't really correspond to any of
> those modifiers
>
> I guess that brings us back around to LIGHT(illuminance) + raw as you have it.
> or adding a 'visible' modifier which is also rather ugly and hard
> to define.
>
> Let's leave this on list a while longer to see if others comment.
> For now I'm inclined to just accept this as a dirty hack needed for this
> corner case.
Hi Jonathan,

I was wondering if it's fine to merge this now since we haven't got
any other comments on it.


Thanks
Shreeya Patel
> Jonathan
>
>> ---
>>
>> Changes in v2
>>    - Add a better commit message explaining why we want this change.
>>    - Call ltrf216a_set_power_state(data, false) before return.
>>
>>
>>   drivers/iio/light/ltrf216a.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>> index e6e24e70d2b9..4b8ef36b6912 100644
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
>> +		ltrf216a_set_power_state(data, false);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = ret;
>> +		return IIO_VAL_INT;
>>   	case IIO_CHAN_INFO_PROCESSED:
>>   		mutex_lock(&data->lock);
>>   		ret = ltrf216a_get_lux(data);
>
