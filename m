Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFD59AE79
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346036AbiHTNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiHTNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 09:38:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1D0A46F;
        Sat, 20 Aug 2022 06:38:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by6so6811423ljb.11;
        Sat, 20 Aug 2022 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=jV5HsPYycbKtzFlfkiYDnHjsUU7p6lRxg5w8I2e4XWY=;
        b=nirgaqu6ywwnbQkdb8ty/Txzl4nKDemefcJHjbUYic+uFE+gtrIV8abOGg0t6BbSED
         lCrSS8mseOPCLELFaYcReMyPGQlfpYMPjA8f4Ea2EikRBAAWOgfrvvpKrTN44CwX4boE
         fXTJT6RnUnVboFKnm2HuIkCzOanebnzImKfFZV1Qel/Q24FD5OP7JOJBf0C0ycgyQ95h
         UCqLteCMkWfVhARtcTs4FEf4L1+OMBht9XK5Gk6vfdsunWMZ9Tm/comJvg0X/hVWNaYG
         C+uKwFliXX8dSj71lTbrTbzZ22dptfDb5svI2NkE8LvJCLNwZuwlekIzv7OYuGcyxTt+
         VNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jV5HsPYycbKtzFlfkiYDnHjsUU7p6lRxg5w8I2e4XWY=;
        b=mkkEvP42po0DaC2XVrooD3idLsZYa0orv6mebBb5xrxG4+/1pKANgjcEj/P/8HHaZP
         fDuorGOPCCsonnqq0lmDKp4TNS1dD7jVPY8iCEncptf5O1sVdKaEdcqEKR21wnKGAp7d
         5w2+ED90Tx+bXtOpkM/qveU0w87DBsyDclPB4JXbU0kJRCALEryhFdioiTK9Qy3KK/Iy
         fym7B4TbHPFJmvoMhL+9IYCQ8R58yg/SQp/tz6/l5OMuz9fVhHGkPAZ1i/xt1bwL2Tal
         kel3Foox+hU8+Lw65+2vZChYpEzOPt+/UYFyeL/KVJBD2PIK+9IiM8jBgHE/gF3SKI2M
         gVsw==
X-Gm-Message-State: ACgBeo0vpVcIyJbB0iVHchPgvlmOrU8SD2AGiwATOZktjHkN0n7qGgsh
        SESuCelW9n9mMtvHMGQP7kmkcUo/GKo=
X-Google-Smtp-Source: AA6agR4tmO9s9JyT7BR/1SCK7ymSRb4o3Z8isbbm1vW9UD9eaYuChT5e8xc0Hs4DCNLwjLDbVbrlUQ==
X-Received: by 2002:a2e:7a10:0:b0:261:a827:c8c with SMTP id v16-20020a2e7a10000000b00261a8270c8cmr3305265ljc.429.1661002699760;
        Sat, 20 Aug 2022 06:38:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512315400b0048a7c86f4e7sm1069144lfi.291.2022.08.20.06.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 06:38:19 -0700 (PDT)
Message-ID: <412c5d22-d59b-9191-80dd-e3ca11360bc4@gmail.com>
Date:   Sat, 20 Aug 2022 16:38:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
 <20220820122120.57dddcab@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
In-Reply-To: <20220820122120.57dddcab@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 14:21, Jonathan Cameron wrote:
> On Fri, 19 Aug 2022 22:19:17 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
>> bulk-enable, add-action-to-disable-at-detach - pattern.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> v2 => v3
>> Split to own patch.
>> ---
>>   drivers/iio/dac/ltc2688.c | 23 +++--------------------
>>   1 file changed, 3 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
>> index 28bdde2d3088..fcad3efe62ea 100644
>> --- a/drivers/iio/dac/ltc2688.c
>> +++ b/drivers/iio/dac/ltc2688.c
>> @@ -84,7 +84,6 @@ struct ltc2688_chan {
>>   struct ltc2688_state {
>>   	struct spi_device *spi;
>>   	struct regmap *regmap;
>> -	struct regulator_bulk_data regulators[2];
>>   	struct ltc2688_chan channels[LTC2688_DAC_CHANNELS];
>>   	struct iio_chan_spec *iio_chan;
>>   	/* lock to protect against multiple access to the device and shared data */
>> @@ -902,13 +901,6 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
>>   			       LTC2688_CONFIG_EXT_REF);
>>   }
>>   
>> -static void ltc2688_disable_regulators(void *data)
>> -{
>> -	struct ltc2688_state *st = data;
>> -
>> -	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
>> -}
>> -
>>   static void ltc2688_disable_regulator(void *regulator)
>>   {
>>   	regulator_disable(regulator);
>> @@ -970,6 +962,7 @@ static int ltc2688_probe(struct spi_device *spi)
>>   	struct regulator *vref_reg;
>>   	struct device *dev = &spi->dev;
>>   	int ret;
>> +	static const char * const regulators[] = {"vcc", "iovcc"};
> trivial - slight preference for
>   { "vcc", "iovcc" };
> 
> This isn't as important as for numeric values as we get some readability
> from the quotes but still nice to have.

Right. I'll fix it.

> For the whole static / vs non static. My personal preference is not
> to have the static marking but I don't care that much.
> 

I'd like to stick with the static here. I know this one particular array 
does not have much of a footprint - but I'd like to encourage the habit 
of considering the memory usage. This discussion serves as an example of 
how unknown the impact of making const data static is. I didn't know 
this myself until Sebastian educated me :)  Hence my strong preference 
on keeping this 'static' as an example for others who are as ignorant as 
I were ;) After all, having const data arrays static is quite an easy 
way of improving things - and it really does matter when there is many 
of arrays - or when they contain large data.

Yours
-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
