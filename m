Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE2548D38E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiAMIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:25:07 -0500
Received: from smtpcmd15176.aruba.it ([62.149.156.176]:60404 "EHLO
        smtpcmd15176.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiAMIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:25:06 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 03:25:06 EST
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 7vJ0n0l5QXfnt7vJ0nCTuY; Thu, 13 Jan 2022 09:18:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1642061882; bh=E8QqJWxJWNAWd8iW7hzgzQw25jkEtuY2BJyXz7LyYzE=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=ZnHF7yMEDPTw/dtoXIUyLttFaQJyVadjjw19HKqVH3wL8aSOw9FDSiC0ADysr+RYd
         ONODmQApDuJa+jBCmdebpkmD9+/LFEnHK2LFw73NK+cM2GME8ndQT/4zDVHivVQiIL
         /fn53eLG20BDPGGqLDbahItjqex7zIsIHpJSgjMA2eSpVGEEWznJ1TNPzAlDTeXtRv
         e0LqQCuOJTW8gFvt6lY5J6o6Eyvvh6eD5hwFjSFEwJ4vpjM9lwyVSGVTta9GgQIk4a
         I56Kd0aNV3AxLYi2EdYy5JhBsX/g7opEnhmnbOfvSm8LZLsAveo/PfTqYqYK4I65Oa
         a5p8x5PoFQEWg==
Subject: Re: [PATCH] pps: clients: gpio: Propagate return value from
 pps_gpio_probe
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robert Hancock <robert.hancock@calian.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rasm@fe.up.pt, jamesnuss@nanometrics.ca, akpm@linux-foundation.org
References: <20220112205214.2060954-1-robert.hancock@calian.com>
 <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <d21aeae0-f75d-f8b9-032a-f4751696d467@enneenne.com>
Date:   Thu, 13 Jan 2022 09:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yd9DDJ2HmptwIITA@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfM+u+afPtUMvhHcHaGGnnOVaadRY15Ikdv31n6AVW3Mv9sr+eD4HlAVYl4XOLCfKqDo5/KW4XpXNYnsH5Zjag3auTetC9lIFguSkb8k1Kt502b/qBizV
 xCgsOLtJ0ckxxjdcYE7RJ+Vfr9hPECdXeZ9tUroM8KH7bycs6GWe/ZldCnkEAA63jFn/EoS4xs5iWBF1x3pPr+5ofgcsIx+IKkc04deB1C56TL/9SLT2y7QV
 Pu7sSoHWIReHGFxKTEgMWjGOrfunZjxGoC8r9tZHfpaNDixpMSb/wh/g/owsvZWRBC0kI8x2SXXvqjiEYKJMrVDPWsla2/4sknxxaXaScx34UqUBy689cz4U
 tX8xZH2TElhf/yt41DNSPe69iICtU1DQY2jM04ZPHHcH7YZDCVhNx+n22pRsRHtbuR3LvfKS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/22 22:07, Andy Shevchenko wrote:
> On Wed, Jan 12, 2022 at 02:52:14PM -0600, Robert Hancock wrote:
>> If the pps-gpio driver was probed prior to the GPIO device it uses, the
>> devm_gpiod_get call returned an -EPROBE_DEFER error, but pps_gpio_probe
>> replaced that error code with -EINVAL, causing the pps-gpio probe to
>> fail and not be retried later. Propagate the error return value so that
>> deferred probe works properly.
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> 
>> Fixes: 161520451dfa (pps: new client driver using GPIO)
>> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
>> ---
>>  drivers/pps/clients/pps-gpio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
>> index 35799e6401c9..2f4b11b4dfcd 100644
>> --- a/drivers/pps/clients/pps-gpio.c
>> +++ b/drivers/pps/clients/pps-gpio.c
>> @@ -169,7 +169,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
>>  	/* GPIO setup */
>>  	ret = pps_gpio_setup(dev);
>>  	if (ret)
>> -		return -EINVAL;
>> +		return ret;
>>  
>>  	/* IRQ setup */
>>  	ret = gpiod_to_irq(data->gpio_pin);
>> -- 
>> 2.31.1
>>
> 


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
