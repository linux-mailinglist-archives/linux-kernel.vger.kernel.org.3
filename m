Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A05763BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiGOOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiGOOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:38:14 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 07:38:10 PDT
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63C226EEB5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:38:10 -0700 (PDT)
Received: from [172.16.17.104] ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id CMQIoCjkGxOg1CMRFoVrST; Fri, 15 Jul 2022 16:37:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1657895828; bh=+Hv8twkI458WQPf2RkTodsab6ZaohleQbrIgT3PVHjQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=cikaFMRm5w4wqep5Ac0Znpq8YtnnFRPeRPb/Ulg68VC9xbE0hRiO8EgwDC+5T3DJk
         hpwOEya9emEkDyxywz0kve3TQmuMGyf/9Nl8m0i1m+BLf34FPptDEBcvjvGyjO5ex9
         qEMo1aZb08sWZaHxlnbBFeP3AWV3CFOZTULr38XIy5HQV2H3zX9T1VEug5U2iKTaqL
         klKUcwwIJPCygOwRE5WS0EwJqz/VYn1COTyTNasneWgQrajw1QOWL1XNYD02WT+vLn
         a3wd5zNqnH4eCCDXixDH7Kp0XtwjY3XDvoMgWZkaZS5DXapGc6ZdunKOX7PR5e1cTL
         9lWStBJNcX4hQ==
Message-ID: <41375332-6d48-2fee-6768-22b639090e3e@brickedbrain.com>
Date:   Fri, 15 Jul 2022 16:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] ads7846: don't report pressure for ads7845
Content-Language: en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
References: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
 <20220714084319.107334-2-luca.ellero@brickedbrain.com>
 <Ys/+37mzoi++8MDW@smile.fi.intel.com>
From:   Luca Ellero <luca.ellero@brickedbrain.com>
In-Reply-To: <Ys/+37mzoi++8MDW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFYA6ulDGHh3sRKi+35wzkNxpE6GEIVxuzCQc6yqmINY8qMWYJSzIRZ0hn1rpf88XOnDD/w1yeSd3TjDqkcxsZpvn6yRlDROFoFZw3LOjUuUjTX5zCha
 jmhlzhXUYuWQbb1dMd5HK3V4blX2wyFjHkXG/dgVeFmP44xQ9RVIQe0tZ0TG9F6ZMx0A28GJw/+ncYhft9UDP17il8D8bRDkjRHq/xXYfdNGoryCabmllDmy
 zeFHAwffn/I7ySMUOXFaL37uZv52tAIlZKpA4QQ+vinm7JtMFgZQrUXuxogcLjWIsSbz/FrE5KyB/lxBiX6WrUJi2Q+9X5aJmVtK0AtfqB0HFMoawHafXF9a
 yFF3OUmOK9agVbKs5y0hWrVGQLVItAlFx7ebZX+A5a3iZXqWDUa7IaRsqS8CDuDQXXtLM4Lq45MRNW45MVYxG7iBojlebFbPucKYLlq4Uer6OElO1OlqTd5E
 soDHrCrShfkTjEFDzpMspS5QKb1z9hPo0jJFxNbHEz2IpcIuZIoTADel3f+jb4o7h/5p+1+J7N3DCrCI8i/eRTrt8K+nz7Tsi/1kV8rmlNTmZZsh1xOySNqy
 dJc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 13:32, Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 10:43:17AM +0200, Luca Ellero wrote:
>> From: Luca Ellero <l.ellero@asem.it>
>>
>> ADS7845 doesn't support pressure.
>> This patch avoids the following error reported by libinput-list-devices:
>> "ADS7845 Touchscreen: kernel bug: device has min == max on ABS_PRESSURE"
> 
> Missed period, otherwise looks good.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>> Signed-off-by: Luca Ellero <l.ellero@asem.it>
>> ---
>>   drivers/input/touchscreen/ads7846.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>> index bed68a68f330..24605c40d039 100644
>> --- a/drivers/input/touchscreen/ads7846.c
>> +++ b/drivers/input/touchscreen/ads7846.c
>> @@ -1316,8 +1316,9 @@ static int ads7846_probe(struct spi_device *spi)
>>   			pdata->y_min ? : 0,
>>   			pdata->y_max ? : MAX_12BIT,
>>   			0, 0);
>> -	input_set_abs_params(input_dev, ABS_PRESSURE,
>> -			pdata->pressure_min, pdata->pressure_max, 0, 0);
>> +	if (ts->model != 7845)
>> +		input_set_abs_params(input_dev, ABS_PRESSURE,
>> +				pdata->pressure_min, pdata->pressure_max, 0, 0);
>>   
>>   	/*
>>   	 * Parse common framework properties. Must be done here to ensure the
>> -- 
>> 2.25.1
>>
> 

Hi Andy,
thank you for your comments.
I will resend v2 of the patches.
Regards
Luca

-- 
Luca Ellero

E-mail: luca.ellero@brickedbrain.com
Internet: www.brickedbrain.com

