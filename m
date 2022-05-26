Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9455350B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbiEZOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiEZOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:32:13 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C01145F;
        Thu, 26 May 2022 07:32:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v9so2306481oie.5;
        Thu, 26 May 2022 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E7WwcTIUlrEvSYeTJzaHsAU/jaSdTTZXA/rZJSrZ89c=;
        b=V+WostSg9mmiVHDAg4kGF2Bpf+HT08ui2Pq3qrvdDKO8GOx2zovsBGwvylqfhL39N7
         iEl3Px7EvsEVpz6MrtFgRDp+KDKkCfK8101idzGDu+X2dj04tuxrzzhuAI7DZYnncmeO
         XnCQyLUXXxGNOdqNKTjhre8Mm9RqJR8NgBY6cHJ4cV2ysEu42BiyMAC2ftTXHKa8/tY5
         JInVPYSm/g9qsXIO5KjUSfXDugtNOkqwUuB/9KY9h5YkdDRxuHaoA8h/WGMg6czd/weq
         qFx7ybZd/5fTlIJkNoLB9xjhlnuSBZxPzn/brKDrX5omK1H+F7Wdkf7ZD3OKaboUCb8h
         OFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E7WwcTIUlrEvSYeTJzaHsAU/jaSdTTZXA/rZJSrZ89c=;
        b=UaH50zv8RLDVPfMbZcNr0HK2eY6CRmwyltBYWxR0HMQObMOLqN+PdPhxB5H2MdOy/K
         bgLuBphwKnKbJI/2Vl1H+Ncct4Bk0fcvt4fOCTjtjp52Qb/h35y2s2P1YTsiLD/s6hHx
         zPMwaRypaX0P2YO1+COSyVKTe1gXvFKokitZRdftEsg9OKBkf7wDGNTjCGeAV0oeHwMA
         YPYuJZppKVN5Wn2OT2RKSUt1+oqr/pKIGzcaWqhqbdK9zmkpo6lHioFA2ldwU0ghqldI
         T8zlf3eL0pfUhsM3Qi1wTuLajwkyjl13Xo5+lDO9jnaGawNr6Ksy0X2Ah2ekBwG3Qf7Q
         2uTg==
X-Gm-Message-State: AOAM530zqAMZg7bkaguhK6gQoGEazx8bHd9gzwtsbn8WBZ4Oyxy2UHqa
        wKfFvfKOJ0byl/ifEttenghOgbVszuVr4g==
X-Google-Smtp-Source: ABdhPJzeaaIoevOLo4J0cUk6UQalpJizJpZMVq8I7RPzxr+PlzLGAWYZJp1Bm9J6Dh0zDiBsgc6uPQ==
X-Received: by 2002:a05:6808:1805:b0:32b:17e3:c7b with SMTP id bh5-20020a056808180500b0032b17e30c7bmr1313670oib.37.1653575531987;
        Thu, 26 May 2022 07:32:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d5f92000000b006060322127esm647788oti.78.2022.05.26.07.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 07:32:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a1760694-7ac7-3f31-c181-13f663bd60b0@roeck-us.net>
Date:   Thu, 26 May 2022 07:32:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 13/40] hwmon: (lm90) Support multiple temperature
 resolutions
Content-Language: en-US
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
References: <20220525135758.2944744-1-linux@roeck-us.net>
 <20220525135758.2944744-14-linux@roeck-us.net>
 <Yo8oWvd3ChpOyOJ7@t480s.localdomain>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Yo8oWvd3ChpOyOJ7@t480s.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 00:12, Slawomir Stepien wrote:
> On maj 25, 2022 06:57, Guenter Roeck wrote:
>> (...)
>> @@ -1477,36 +1332,36 @@ static int lm90_temp_write(struct device *dev, u32 attr, int channel, long val)
>>   
>>   	switch (attr) {
>>   	case hwmon_temp_min:
>> -		if (channel == 0)
>> -			err = lm90_set_temp8(data,
>> -					      lm90_temp_min_index[channel],
>> -					      val);
>> -		else
>> -			err = lm90_set_temp11(data,
>> -					      lm90_temp_min_index[channel],
>> -					      val);
>> +		err = lm90_set_temp(data, lm90_temp_min_index[channel],
>> +				    channel, val);
>>   		break;
>>   	case hwmon_temp_max:
>> -		if (channel == 0)
>> -			err = lm90_set_temp8(data,
>> -					     lm90_temp_max_index[channel],
>> -					     val);
>> -		else
>> -			err = lm90_set_temp11(data,
>> -					      lm90_temp_max_index[channel],
>> -					      val);
>> +		err = lm90_set_temp(data, lm90_temp_max_index[channel],
>> +				    channel, val);
>>   		break;
>>   	case hwmon_temp_crit:
>> -		err = lm90_set_temp8(data, lm90_temp_crit_index[channel], val);
>> +		err = lm90_set_temp(data, lm90_temp_crit_index[channel],
>> +				    channel, val);
>>   		break;
>>   	case hwmon_temp_crit_hyst:
>>   		err = lm90_set_temphyst(data, val);
>>   		break;
>>   	case hwmon_temp_emergency:
>> -		err = lm90_set_temp8(data, lm90_temp_emerg_index[channel], val);
>> +		err = lm90_set_temp(data, lm90_temp_emerg_index[channel],
>> +				    channel, val);
>>   		break;
>>   	case hwmon_temp_offset:
>> -		err = lm90_set_temp11(data, REMOTE_OFFSET, val);
>> +		val = lm90_temp_to_reg(0, val,
>> +				       lm90_temp_get_resolution(data, REMOTE_OFFSET));
>> +		data->temp[REMOTE_OFFSET] = val;
> 
> I do not understand why you do this val assignment here, before doing real i2c write. That write
> might fail and then we have "incorrect" value in data->temp.
> 

No special reason. I'll move the assignment to the end of the case statement.

Guenter

>> +		err = i2c_smbus_write_byte_data(data->client,
>> +						LM90_REG_REMOTE_OFFSH,
>> +						val >> 8);
>> +		if (err)
>> +			break;
>> +		err = i2c_smbus_write_byte_data(data->client,
>> +						LM90_REG_REMOTE_OFFSL,
>> +						val & 0xff);
>>   		break;
>>   	default:
>>   		err = -EOPNOTSUPP;
>> @@ -2035,6 +1890,7 @@ static int lm90_probe(struct i2c_client *client)
>>   	 * ALERT# output
>>   	 */
>>   	data->alert_alarms = lm90_params[data->kind].alert_alarms;
>> +	data->resolution = lm90_params[data->kind].resolution ? : 11;
>>   
>>   	/* Set chip capabilities */
>>   	data->flags = lm90_params[data->kind].flags;
> 

