Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08118508514
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377269AbiDTJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377262AbiDTJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:39:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B571BE95;
        Wed, 20 Apr 2022 02:36:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aferraris)
        with ESMTPSA id 5B5571F4331C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650447382;
        bh=uDYe1ZzTPx5RJEFas8TwTUZROOYhLWSgVYF1Wl38wHk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b3IcAI9R4RvQfpHzoexirNqgxgdxQJl/WhGoe7/Os/8CmSYqpzmPmi0ozXvWpV3cp
         seskRRQAtiCdBhSLSFZm2MUjvjQkXjfoUCKpUlVhepAo1X7Tee+JmD7bMXeEOXQ+mj
         7yqdVVT/N7oXWiXRD88Typv8bv5hCQcKO8wCqkv1hm1QrtH7wOOW5vs2drNedHhuZh
         z2OW8KoPlPPO5p1L75JqcpfN0G0xFswza+3HLyKQm46hiWVfSUpJNn4sJGyG7pDFPy
         MHxGWJic58ZE+w2391dSZQ+bHifDY4Ppvpdis028VQmF8R9R1Wh7vPncThyuGQHhho
         16+VmVCl6GGTA==
Message-ID: <9b1cb44f-43dc-8926-9dab-00032ab59640@collabora.com>
Date:   Wed, 20 Apr 2022 11:36:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] iio: stk3310: Export near level property for
 proximity sensor
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220415085018.35063-1-arnaud.ferraris@collabora.com>
 <20220415085018.35063-3-arnaud.ferraris@collabora.com>
 <20220416172651.695d4439@jic23-huawei>
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
In-Reply-To: <20220416172651.695d4439@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Le 16/04/2022 à 18:26, Jonathan Cameron a écrit :
> On Fri, 15 Apr 2022 10:50:18 +0200
> Arnaud Ferraris <arnaud.ferraris@collabora.com> wrote:
> 
>> This makes the value from which an object should be considered "near"
>> available to userspace. This hardware-dependent value should be set
>> in the device-tree.
>>
>> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> Hi Arnaud,
> 
> Minor request to slightly modify how you do this inline.
> Otherwise looks good to me.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/light/stk3310.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
>> index 1d02dfbc29d1..7792456323ef 100644
>> --- a/drivers/iio/light/stk3310.c
>> +++ b/drivers/iio/light/stk3310.c
>> @@ -106,6 +106,7 @@ struct stk3310_data {
>>   	struct mutex lock;
>>   	bool als_enabled;
>>   	bool ps_enabled;
>> +	uint32_t ps_near_level;
>>   	u64 timestamp;
>>   	struct regmap *regmap;
>>   	struct regmap_field *reg_state;
>> @@ -135,6 +136,25 @@ static const struct iio_event_spec stk3310_events[] = {
>>   	},
>>   };
>>   
>> +static ssize_t stk3310_read_near_level(struct iio_dev *indio_dev,
>> +				       uintptr_t priv,
>> +				       const struct iio_chan_spec *chan,
>> +				       char *buf)
>> +{
>> +	struct stk3310_data *data = iio_priv(indio_dev);
>> +
>> +	return sprintf(buf, "%u\n", data->ps_near_level);
>> +}
>> +
>> +static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
>> +	{
>> +		.name = "nearlevel",
>> +		.shared = IIO_SEPARATE,
>> +		.read = stk3310_read_near_level,
>> +	},
>> +	{ /* sentinel */ }
>> +};
>> +
>>   static const struct iio_chan_spec stk3310_channels[] = {
>>   	{
>>   		.type = IIO_LIGHT,
>> @@ -151,6 +171,7 @@ static const struct iio_chan_spec stk3310_channels[] = {
>>   			BIT(IIO_CHAN_INFO_INT_TIME),
>>   		.event_spec = stk3310_events,
>>   		.num_event_specs = ARRAY_SIZE(stk3310_events),
>> +		.ext_info = stk3310_ext_info,
>>   	}
>>   };
>>   
>> @@ -581,6 +602,11 @@ static int stk3310_probe(struct i2c_client *client,
>>   	data = iio_priv(indio_dev);
>>   	data->client = client;
>>   	i2c_set_clientdata(client, indio_dev);
>> +
>> +	if (device_property_read_u32(&client->dev, "proximity-near-level",
>> +				     &data->ps_near_level))
>> +		data->ps_near_level = 0;
> 
> Prefer this pattern.
> 
> 	data->ps_near_level = 0;
> 	device_property_read_u32(&client->dev, "proximity-near-level",
> 				 &data->ps_near_level);
> taking advantage of the fact that the output won't be set unless
> the property read succeeds.

That's a good suggestion indeed! We can even get rid of the initial 
assignment as the struct is zero-initialized on alloc, will send a v2 in 
a moment.

Thanks,
Arnaud

> 
>> +
>>   	mutex_init(&data->lock);
>>   
>>   	ret = stk3310_regmap_init(data);
> 
