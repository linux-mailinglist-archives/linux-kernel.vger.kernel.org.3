Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C2D5101B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351902AbiDZPRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351917AbiDZPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:15:41 -0400
X-Greylist: delayed 1315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 08:10:28 PDT
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.46.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288F3A1B1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:10:27 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 583F4BFC8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:48:32 -0500 (CDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with SMTP
        id jMUPntAWH9AGSjMURn0nFw; Tue, 26 Apr 2022 09:48:32 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U80fI97g89tIVJwg/sg9xJdAtkuna8yWHZLH8Fxmdaw=; b=AhujkquVIa5WRrsxj9ZsiXnotP
        ewOGwNygYhQ0/Ohisj+9nI0Ofnp0zdPHGpE18D/BJ0Lzt3G4Ri4kDUYKWkMFqzT25ZkA6S7rMJQ+o
        thkMCbDAhTqq39z6nYIFKcWBAEsxsyVSHS+MA6g3/1+m+U9b29Z0d0925jOCPXZVCYACg1iANu85J
        fVnq8byXhcQOSHIkS1bX0XrIxB6omC1at2yKFE2ilFTXitzRmhdGq/6GHqN06MXGuNUwv1lF6fDUc
        yEJjsOJ19vcLYzcOSX/cHjGQqVL6cetioaVh/cffc0wmJYMa0X69fUFM0YWYF4LTxkhRH0t/B+I45
        1qJD+Jig==;
Received: from p578d29e0.dip0.t-ipconnect.de ([87.141.41.224]:38026 helo=[192.168.10.199])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <navin@linumiz.com>)
        id 1njMUP-000KFi-2O; Tue, 26 Apr 2022 14:48:29 +0000
Message-ID: <80b6a194-53d7-bacc-23f9-7526f51b5463@linumiz.com>
Date:   Tue, 26 Apr 2022 16:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/1] iio: temperature: max31865: Make use of device
 properties
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20220413185335.21743-1-andriy.shevchenko@linux.intel.com>
 <20220416114801.0865fcba@jic23-huawei>
From:   navin <navin@linumiz.com>
In-Reply-To: <20220416114801.0865fcba@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 87.141.41.224
X-Source-L: No
X-Exim-ID: 1njMUP-000KFi-2O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p578d29e0.dip0.t-ipconnect.de ([192.168.10.199]) [87.141.41.224]:38026
X-Source-Auth: navin@linumiz.com
X-Email-Count: 2
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.04.22 12:48, Jonathan Cameron wrote:
> On Wed, 13 Apr 2022 21:53:35 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> Convert the module to be property provider agnostic and allow
>> it to be used on non-OF platforms.
> This one should call out the addition of missing mod_devicetable.h
> If nothing else comes up I can add that whilst applying.
> Looks fine to me but I'd like to give a little time for
> Navin to comment if they wish.
>
> Jonathan

Looks fine for me. Thanks

Navin

>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   drivers/iio/temperature/max31865.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/temperature/max31865.c b/drivers/iio/temperature/max31865.c
>> index 86c3f3509a26..e3bb78184c6e 100644
>> --- a/drivers/iio/temperature/max31865.c
>> +++ b/drivers/iio/temperature/max31865.c
>> @@ -12,9 +12,11 @@
>>   #include <linux/delay.h>
>>   #include <linux/err.h>
>>   #include <linux/init.h>
>> +#include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/sysfs.h>
>> +#include <linux/property.h>
>>   #include <linux/spi/spi.h>
>>   #include <asm/unaligned.h>
>>   
>> @@ -305,7 +307,7 @@ static int max31865_probe(struct spi_device *spi)
>>   	indio_dev->channels = max31865_channels;
>>   	indio_dev->num_channels = ARRAY_SIZE(max31865_channels);
>>   
>> -	if (of_property_read_bool(spi->dev.of_node, "maxim,3-wire")) {
>> +	if (device_property_read_bool(&spi->dev, "maxim,3-wire")) {
>>   		/* select 3 wire */
>>   		data->three_wire = 1;
>>   	} else {
