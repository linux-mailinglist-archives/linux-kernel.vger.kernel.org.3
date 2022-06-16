Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96F54D8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357940AbiFPDGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355839AbiFPDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:06:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7FC5A093;
        Wed, 15 Jun 2022 20:06:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w21so349256pfc.0;
        Wed, 15 Jun 2022 20:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LukzTDUwt66wcsoLaoexNQpPVZgj0xpUTeZfbRgw5Qs=;
        b=qu1tYXYRUJWS6pzyxmYabH95T0nXzYA4PPbr+118VERbjuTHZh4EWnRfXPKa8rmoZr
         GtMujE8F70cHqrCJhu+Y3Jb0RkPPoB0zaMQ0leZEOzxVWQ9NzU6e1Ryhl9Lz6YACAVWB
         0g6vcqUalviuaY+kvyTQ7H5OlBzQor4tAbqVEQO1R+jSMWdZwU/MdI2j95p7lkk0ixgP
         jmQJmMKZtv2SbLqqCwVqimoM/kg5ixsPPfTJpoTk32K/RWdIvIOD6R9eB1nIAtk+M+5N
         qAej49Ek5nbYqJAaM5USJ4wzqzx/1x3GQd/re4XKeUndrYLXXWzAsSBvjJOl0dhHx8aa
         I9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LukzTDUwt66wcsoLaoexNQpPVZgj0xpUTeZfbRgw5Qs=;
        b=ylvjNzugD5TxpPewPCpCkOl8AGnVqbS0Ktkoln7rwOedEEjx1SraXU0J0//kIil71K
         9wY4zNIhyOIW0GzDZ9/1nIF/sZ1bafYePXuw26fsXMJkGfnvPypuZagaGa0dOttbMdQv
         gkWIJ6c0mPeRwmA2fA6p6C7X1cPATRRyfAWMUtt7UJKhjkYUI2O/maAreSLcm1MNGY7q
         NQ0juqM9ZT2Xf2Uf3N43UZ7MZ8ayVkdhPMme57ksXnFbMlgFGuh88L5VbrxRlrYbyISE
         99JRujdpism6Nwy3gR3IT/du92Trfinq6HE+8YE+c6oDKqCMDkoO8UxiyXk9mETZTVV2
         R4CQ==
X-Gm-Message-State: AJIora+JL0+E3P9heHOTSUeOtqrH5X32AoE7dS5AxZfBKH1SM2C0DB94
        C3w31kCzDOwrsgPhprSHg83W4srkvck=
X-Google-Smtp-Source: AGRyM1ueTzUMMb7VkWIorwIGo5UVkEtt4/zUBAL5uI3Xy01yJAmhw9i8x3v47rLGaHh21KqDpe9CwA==
X-Received: by 2002:a63:3183:0:b0:3fd:6797:70a8 with SMTP id x125-20020a633183000000b003fd679770a8mr2594360pgx.206.1655348761209;
        Wed, 15 Jun 2022 20:06:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 9-20020a621909000000b005184c9c46dbsm382366pfz.81.2022.06.15.20.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 20:06:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0d57d565-fa50-a970-4bf2-fff95f48e5ac@roeck-us.net>
Date:   Wed, 15 Jun 2022 20:05:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers: hwmon: Add missing of_node_put() in gsc-hwmon.c
Content-Language: en-US
To:     =?UTF-8?B?5ZKM5Lqu?= <windhl@126.com>
Cc:     tharvey@gateworks.com, rjones@gateworks.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220615151856.3970186-1-windhl@126.com>
 <01243e3e-f4d2-c1ba-98f5-db7bc0c62adc@roeck-us.net>
 <2da49756.221e.1816a5fa3d3.Coremail.windhl@126.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2da49756.221e.1816a5fa3d3.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 19:37, 和亮 wrote:
> 
> 
> 
> At 2022-06-16 01:57:49, "Guenter Roeck" <linux@roeck-us.net> wrote:
>>
>> Please use proper subject lines. Here it should have been
>>
>> hwmon: (gsc-hwmon) Add missing of_node_put()
> 
> 
> 
> Thanks, I will change it in my new patch.
> 
> 
>>>>    drivers/hwmon/gsc-hwmon.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
>>> index 1fe37418ff46..34c20d13627a 100644
>>> --- a/drivers/hwmon/gsc-hwmon.c
>>> +++ b/drivers/hwmon/gsc-hwmon.c
>>> @@ -268,10 +268,14 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
>>>    
>>>    	/* fan controller base address */
>>>    	fan = of_find_compatible_node(dev->parent->of_node, NULL, "gw,gsc-fan");
>>
>> A single of_node_put(fan) here would have been be sufficient.
> 
> 
> 
> I think of_node_put after should come after its usage, right?
> 
> 

Yes, you are correct. Sorry for the noise.

>>>> -	if (fan && of_property_read_u32(fan, "reg", &pdata->fan_base)) {
>>> +	if (fan && of_property_read_u32(fan, "reg", &pdata->fan_base)) {		
>>> +		of_node_put(fan);
>>>    		dev_err(dev, "fan node without base\n");
>>>    		return ERR_PTR(-EINVAL);
>>>    	}
>>> +	
>>> +	/* if fan&&!of_property_read_u32 fail */
>>
> 
>> This comment only adds confusion and does not add any value.
> 
> 
> Sorry, I just want to say, if *fan* is not NULL, but of_property_read_u32() returns 0.
> In that case, we still need a of_node_put() to release fan, right?
> 

Yes, but that is obvious, and the comment is not needed.

Thanks,
Guenter

>>
>> Guenter
>>
>>> +	of_node_put(fan);
>>>    
>>>    	/* allocate structures for channels and count instances of each type */
> 
>>>    	device_for_each_child_node(dev, child) {
> 
> 
> Hi, Guenter, I am preparing my new patch and I want to discuss your suggestions as above.
> 

