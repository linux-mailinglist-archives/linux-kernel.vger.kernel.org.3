Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749714B3CF0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiBMSvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:51:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiBMSvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:51:05 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243457B36
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:50:58 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JJxXndevRuvBOJJxYnOPY5; Sun, 13 Feb 2022 19:50:57 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 13 Feb 2022 19:50:57 +0100
X-ME-IP: 90.126.236.122
Message-ID: <9e5ed543-cd45-85db-50b5-52c2afd54c55@wanadoo.fr>
Date:   Sun, 13 Feb 2022 19:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iio: use div64_u64() instead of do_div()
Content-Language: fr
To:     Jonathan Cameron <jic23@kernel.org>, Qing Wang <wangqing@vivo.com>
Cc:     Jyoti Bhayana <jbhayana@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644395873-3937-1-git-send-email-wangqing@vivo.com>
 <20220213175940.1066f5a8@jic23-huawei>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220213175940.1066f5a8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/02/2022 à 18:59, Jonathan Cameron a écrit :
> On Wed,  9 Feb 2022 00:37:53 -0800
> Qing Wang <wangqing@vivo.com> wrote:
> 
>> From: Wang Qing <wangqing@vivo.com>
>>
>> do_div() does a 64-by-32 division.
>> When the divisor is u64, do_div() truncates it to 32 bits, this means it
>> can test non-zero and be truncated to zero for division.
>>
>> fix do_div.cocci warning:
>> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
> These look correct to me.  Jyoti, please could give these a sanity check?
> 

This is wrong.

See [1].

CJ

[1]: 
https://lore.kernel.org/linux-kernel/20211117112559.jix3hmx7uwqmuryg@pengutronix.de/

> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/common/scmi_sensors/scmi_iio.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> index d538bf3..d6df5da
>> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
>> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
>> @@ -160,7 +160,7 @@ static int scmi_iio_set_odr_val(struct iio_dev *iio_dev, int val, int val2)
>>   	mult = scnprintf(buf, sizeof(buf), "%llu", sf) - 1;
>>   
>>   	sec = int_pow(10, mult) * UHZ_PER_HZ;
>> -	do_div(sec, uHz);
>> +	div64_u64(sec, uHz);
>>   	if (sec == 0) {
>>   		dev_err(&iio_dev->dev,
>>   			"Trying to set invalid sensor update value for sensor %s",
>> @@ -237,10 +237,10 @@ static void convert_ns_to_freq(u64 interval_ns, u64 *hz, u64 *uhz)
>>   	u64 rem, freq;
>>   
>>   	freq = NSEC_PER_SEC;
>> -	rem = do_div(freq, interval_ns);
>> +	rem = div64_u64(freq, interval_ns);
>>   	*hz = freq;
>>   	*uhz = rem * 1000000UL;
>> -	do_div(*uhz, interval_ns);
>> +	div64_u64(*uhz, interval_ns);
>>   }
>>   
>>   static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>> @@ -266,7 +266,7 @@ static int scmi_iio_get_odr_val(struct iio_dev *iio_dev, int *val, int *val2)
>>   	mult = SCMI_SENS_CFG_GET_UPDATE_EXP(sensor_config);
>>   	if (mult < 0) {
>>   		sensor_interval_mult = int_pow(10, abs(mult));
>> -		do_div(sensor_update_interval, sensor_interval_mult);
>> +		div64_u64(sensor_update_interval, sensor_interval_mult);
>>   	} else {
>>   		sensor_interval_mult = int_pow(10, mult);
>>   		sensor_update_interval =
>> @@ -500,7 +500,7 @@ static u64 scmi_iio_convert_interval_to_ns(u32 val)
>>   	mult = SCMI_SENS_INTVL_GET_EXP(val);
>>   	if (mult < 0) {
>>   		sensor_interval_mult = int_pow(10, abs(mult));
>> -		do_div(sensor_update_interval, sensor_interval_mult);
>> +		div64_u64(sensor_update_interval, sensor_interval_mult);
>>   	} else {
>>   		sensor_interval_mult = int_pow(10, mult);
>>   		sensor_update_interval =
> 
> 

