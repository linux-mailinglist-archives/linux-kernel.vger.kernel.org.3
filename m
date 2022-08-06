Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C85958B6D5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiHFQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiHFQ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:29:15 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63D911804;
        Sat,  6 Aug 2022 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=0/EWJspkALZrTjeOIOA2+pvDgmwguZHERdtDusPdfjA=; b=FuwoneNfT65l3UvNLYJXO78yv4
        T5Z0WHKuNAyln87RP6k8H9XmNnEI89215lp4xzYGGKvcUuqRH4JfaZvdhTdLNlRKBMDKbg9tc8wiR
        GrECcTEx10AW1zG9vD7qnaFMjmWTXk+1Cz/XFSMHOXKnYkkekq6sGuZS/9GBtbzs0gP6i5ZCICvRH
        FkEbcN1n4tACbwsmm7IYZUkfaoCdWgeOLEKLlGDHBhWLzsklmmyZJ4fCyaA7i92OOctaPA8dkEQxm
        uQr318HnuhMYM6tFsyR5onGhzFvuH94zbNp+Q/EOCBTDTxjVOwZKzVgaESBruD9MPlIDbHSFpsnIh
        LFhCo/CA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1oKMfo-0004JB-1N; Sat, 06 Aug 2022 18:29:12 +0200
Received: from [2001:a61:2aaa:fe01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oKMfn-000IWg-TF; Sat, 06 Aug 2022 18:29:11 +0200
Message-ID: <c28e5dfa-9ce8-a60e-a72a-1c733711ccca@metafoo.de>
Date:   Sat, 6 Aug 2022 18:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] iio: temperature: mlx90632 Add supply regulator to
 sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, Crt Mori <cmo@melexis.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220802103022.423328-1-cmo@melexis.com>
 <20220806171345.45cf1228@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220806171345.45cf1228@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26619/Sat Aug  6 09:53:47 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/22 18:15, Jonathan Cameron wrote:
> On Tue,  2 Aug 2022 12:30:22 +0200
> Crt Mori <cmo@melexis.com> wrote:
>
>> Provide possibility to toggle power supply to the sensor so that user
>> can optimize their setup and not have the sensor constantly powered.
>>
>> Signed-off-by: Crt Mori <cmo@melexis.com>
>> ---
>>   drivers/iio/temperature/mlx90632.c | 52 ++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
>> index 7ee7ff8047a4..e6e5e649a9f9 100644
>> --- a/drivers/iio/temperature/mlx90632.c
>> +++ b/drivers/iio/temperature/mlx90632.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/math64.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>>   
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/sysfs.h>
>> @@ -128,6 +129,7 @@
>>    *        calculations
>>    * @object_ambient_temperature: Ambient temperature at object (might differ of
>>    *                              the ambient temperature of sensor.
>> + * @regulator: Regulator of the device
>>    */
>>   struct mlx90632_data {
>>   	struct i2c_client *client;
>> @@ -136,6 +138,7 @@ struct mlx90632_data {
>>   	u16 emissivity;
>>   	u8 mtyp;
>>   	u32 object_ambient_temperature;
>> +	struct regulator *regulator;
>>   };
>>   
>>   static const struct regmap_range mlx90632_volatile_reg_range[] = {
>> @@ -841,6 +844,37 @@ static int mlx90632_wakeup(struct mlx90632_data *data)
>>   	return mlx90632_pwr_continuous(data->regmap);
>>   }
>>   
>> +static void mlx90632_disable_regulator(void *_data)
>> +{
>> +	struct mlx90632_data *data = _data;
>> +	int ret;
>> +
>> +	ret = regulator_disable(data->regulator);
>> +	if (ret < 0)
>> +		dev_err(regmap_get_device(data->regmap),
>> +			"Failed to disable power regulator: %d\n", ret);
>> +}
>> +
>> +static int mlx90632_enable_regulator(struct mlx90632_data *data)
>> +{
>> +	int ret;
>> +
>> +	ret = regulator_set_voltage(data->regulator, 3200000, 3600000);
>> +	if (ret < 0) {
> Hmm. This can be problematic, as a valid option is for the a stub regulator to
> have been returned.  Mostly for device where it is common for them to be wired
> to fixed regulators, we just assume the firmware set the voltage correctly.
> Ideally it provides a fixed (or controllable) regulator to make that clear.

Just to add to what Jonathan said. For configurable regulators the 
allowed voltage values should be provided in the devicetree and the 
regulator framework will set it automatically. See the 
regulator-min-microvolt and regulator-max-microvolt DT properties.

