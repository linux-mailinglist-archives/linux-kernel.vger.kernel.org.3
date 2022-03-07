Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B34CFFDB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiCGNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCGNWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:22:38 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B35793A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:21:44 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 227DLHV9039903;
        Mon, 7 Mar 2022 07:21:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646659277;
        bh=kUiiydAskeS5fxwb//vt1Zo7baq4bJ7NZrb+LotZaNQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qBnyPa2gPfeZcd9fZmD8eZbHZXjenj8NE7dQtSwkQplUv3fL5iHwgRf6v40/RrVRF
         TucEtIeWtnkzZ8QxIq0Rrel3TZOZGd2MSDZyygnxOAR6FC05QfM+u7dd9sdKyreDgM
         RRou1zcxeJcIKzE184fimHiKq2HC//yve1oE++2Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 227DLHcr042876
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Mar 2022 07:21:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 7
 Mar 2022 07:21:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 7 Mar 2022 07:21:17 -0600
Received: from [10.250.233.82] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 227DLDWM022978;
        Mon, 7 Mar 2022 07:21:13 -0600
Message-ID: <0b24b79b-b412-7e2b-c0a6-5b6f9ed5a90d@ti.com>
Date:   Mon, 7 Mar 2022 18:51:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V1] extcon/usb: Remove disable irq operation in system
 sleep.
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Bruce Chen <brucechen251@gmail.com>, <bruce.chen@unisoc.com>,
        <myungjoo.ham@samsung.com>, <cw00.choi@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     <orsonzhai@gmail.com>, <gengcixi@gmail.com>,
        <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>
References: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
 <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/22 2:50 pm, Roger Quadros wrote:
> +TI folks Aswath & Vignesh.
> 

Thanks for looping in.

> Hi Bruce,
> 
> On 03/03/2022 09:36, Bruce Chen wrote:
>> From: Bruce Chen <bruce.chen@unisoc.com>
>>
>> If disable vbus/id irq, it will lead to wakeup system fail
>> in unisoc platform. In unisoc platform, Irq enable and irq
>> wakeup are the same interrupt line. So remove disable vbus/id
>> irq operation is a way to solve the issue> 
>> Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
>> ---
>>  drivers/extcon/extcon-usb-gpio.c | 15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
>> index f2b65d9..40d967a 100644
>> --- a/drivers/extcon/extcon-usb-gpio.c
>> +++ b/drivers/extcon/extcon-usb-gpio.c
>> @@ -226,16 +226,6 @@ static int usb_extcon_suspend(struct device *dev)
>>  		}
>>  	}
>>  
>> -	/*
>> -	 * We don't want to process any IRQs after this point
>> -	 * as GPIOs used behind I2C subsystem might not be
>> -	 * accessible until resume completes. So disable IRQ.
>> -	 */
> 
> I think the reason this was added was that if USB cable is plugged/unplugged
> while system was suspending it was causing some faults on TI DRA7 EVM
> at usb_irq_handler()/usb_extcon_detect_cable() when it tries to read GPIO status
> when I2C based GPIO controller was used but already suspended.
> But looks like disabling the IRQ is not the right approach either so your patch
> is right.
> 
> However I'm not sure if the above issue will still exist on DRA7 and other TI EVMS
> using ID/VBUS GPIO over I2C device.
> 
> Let's wait for Aswath/Vignesh to confirm. If no issues I'm OK with this patch.


Support for suspend/resume on DRA7x isn't really maintained actively.
Hence, cannot really test the patch. But, no objections for this patch
either.

[...]

Regards
Vignesh
