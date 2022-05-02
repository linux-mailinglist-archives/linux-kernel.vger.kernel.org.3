Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92947516D43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiEBJYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384264AbiEBJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:24:05 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40962E8;
        Mon,  2 May 2022 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651483237;
  x=1683019237;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c0FjZGzQe0yufhEltmjqpq5ZxO3Vn+OSuMkEHjTDSBU=;
  b=mV7j4MZ/g+43NANO+L3M1SXVeC7hFI81TIynBpHOtRb+BOUgR700Jiq9
   mLG3NkKXhvCqEbuWM8Sc1uPl73D5JVM13vXFZSACN/Id3nqKpGfnwWG2l
   XyucLWBb5zKnp7CbfB1dfHr5nyClGkwJELFHx9uo66thyyOlxBIb8JjlL
   qdfwkbCBYUCvmc9/4kIAc4Gnx6vfOqTLmryaZm8HTqrxYoTY/fOYu7vVJ
   JCSzcxNJKJUzubCamdb50eLzcirSzy9wY1U1d45QyJMsqNjMzLgFI5Kv2
   0bmmzgU7kG6LBIGtwDZLSS7b+DBYOxm+KQ+p2KxQzyAsoA3Jw3x7lTYEf
   Q==;
Message-ID: <053ac9d5-eb09-8477-ecc7-afa934426c74@axis.com>
Date:   Mon, 2 May 2022 11:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] hwmon: (tmp401) Add of_match_table
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, Camel Guo <Camel.Guo@axis.com>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20220429095201.2932180-1-camel.guo@axis.com>
 <737ea26d-2e25-b39b-af9b-190958008f8d@roeck-us.net>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <737ea26d-2e25-b39b-af9b-190958008f8d@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail03w.axis.com (10.20.40.9) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 18:22, Guenter Roeck wrote:
> On 4/29/22 02:52, Camel Guo wrote:
>> Add the missing of_match_table to allow device tree probing
>> 
> 
> I2C devices probe based on the I2C device table even on devicetree systems,
> so this isn't a correct statement. Please provide evidence and explain
> in detail the circumstances where this does not work.

Commit message was updated in v2. Please check out v2 instead.

> 
> Guenter
> 
>> Signed-off-by: Camel Guo <camel.guo@axis.com>
>> ---
>>   drivers/hwmon/tmp401.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>> 
>> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
>> index a58a2f31a07e..cc0a1c219b1f 100644
>> --- a/drivers/hwmon/tmp401.c
>> +++ b/drivers/hwmon/tmp401.c
>> @@ -750,10 +750,21 @@ static int tmp401_probe(struct i2c_client *client)
>>        return 0;
>>   }
>>   
>> +static const struct of_device_id __maybe_unused tmp4xx_of_match[] = {
>> +     { .compatible = "ti,tmp401", },
>> +     { .compatible = "ti,tmp411", },
>> +     { .compatible = "ti,tmp431", },
>> +     { .compatible = "ti,tmp432", },
>> +     { .compatible = "ti,tmp435", },
>> +     { },
>> +};
>> +MODULE_DEVICE_TABLE(of, tmp4xx_of_match);
>> +
>>   static struct i2c_driver tmp401_driver = {
>>        .class          = I2C_CLASS_HWMON,
>>        .driver = {
>>                .name   = "tmp401",
>> +             .of_match_table = of_match_ptr(tmp4xx_of_match),
>>        },
>>        .probe_new      = tmp401_probe,
>>        .id_table       = tmp401_id,
> 

