Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB64AF3FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiBIOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiBIOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:24:56 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C63C061355;
        Wed,  9 Feb 2022 06:24:58 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2199mV2L022765;
        Wed, 9 Feb 2022 15:24:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=PTo/+aQuDEXW9wkhi8xu6zjbYAzQQo4vacWnFYwBULo=;
 b=qrfsufCM5JHLD6eapsojKg/QCBtXqie3CoaE2aCR5s/Duq9/A4szuxhdH85+wz/5Y/1u
 r+pbzF3tn150ltlk2bNqdurA5PhJ6WjuQvtMvB3L73IyfZ3lh/F3ztxCPLSPN0SsJ8Xi
 U/NcvfO8ZvgevpOOkzhWNXlLLN8jVCE/PPaDsT9X2/c/5APurMs+/wxgSiQ1mgKS6rKc
 r9BicRkBsnlumJJnum5s/XYk1Xjb+5q6JlZn5Fmu+aV5iArcW/gFg00oFgOhywaLmZ6o
 UpWsHoZFkMO0ncK4tvtweQU+OefVmHWRMPPs4+YVlVKIimoI+MDurJRipcq8cMi5xXPO cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e4ba9hge1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 15:24:25 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A32D10002A;
        Wed,  9 Feb 2022 15:24:24 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 119C6226FC9;
        Wed,  9 Feb 2022 15:24:24 +0100 (CET)
Received: from [10.211.4.65] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 9 Feb
 2022 15:24:22 +0100
Subject: Re: [PATCH v2 1/1] iio: trigger: stm32-timer: Make use of device
 properties
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
References: <20220202204112.57095-1-andriy.shevchenko@linux.intel.com>
 <20220205173114.5a60fc47@jic23-huawei>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <05babdec-fd9a-a674-23a5-c689ff8fa8e3@foss.st.com>
Date:   Wed, 9 Feb 2022 15:24:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220205173114.5a60fc47@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_07,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22 6:31 PM, Jonathan Cameron wrote:
> On Wed,  2 Feb 2022 22:41:12 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> Convert the module to be property provider agnostic and allow
>> it to be used on non-OF platforms.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Looks fine to me.  The stm32 drivers are well maintained so I'll
> leave this one on list a little longer for feedback.
> 
> +Cc: Fabrice
> 
>> ---
>> v2: dropped depends on OF
>>  drivers/iio/trigger/Kconfig               |  2 +-
>>  drivers/iio/trigger/stm32-timer-trigger.c | 11 ++++++-----
>>  2 files changed, 7 insertions(+), 6 deletions(-)

Hi Andy, Jonathan,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Best Regards,
Fabrice

>>
>> diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
>> index 8cef2f7452e8..7ecb69725b1d 100644
>> --- a/drivers/iio/trigger/Kconfig
>> +++ b/drivers/iio/trigger/Kconfig
>> @@ -38,7 +38,7 @@ config IIO_STM32_LPTIMER_TRIGGER
>>  
>>  config IIO_STM32_TIMER_TRIGGER
>>  	tristate "STM32 Timer Trigger"
>> -	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
>> +	depends on (ARCH_STM32 && MFD_STM32_TIMERS) || COMPILE_TEST
>>  	help
>>  	  Select this option to enable STM32 Timer Trigger
>>  
>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
>> index 4f9461e1412c..5049d9ecfc1a 100644
>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
>> @@ -11,9 +11,10 @@
>>  #include <linux/iio/timer/stm32-timer-trigger.h>
>>  #include <linux/iio/trigger.h>
>>  #include <linux/mfd/stm32-timers.h>
>> +#include <linux/mod_devicetable.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/of_device.h>
>> +#include <linux/property.h>
>>  
>>  #define MAX_TRIGGERS 7
>>  #define MAX_VALIDS 5
>> @@ -771,11 +772,11 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>>  	unsigned int index;
>>  	int ret;
>>  
>> -	if (of_property_read_u32(dev->of_node, "reg", &index))
>> -		return -EINVAL;
>> +	ret = device_property_read_u32(dev, "reg", &index);
>> +	if (ret)
>> +		return ret;
>>  
>> -	cfg = (const struct stm32_timer_trigger_cfg *)
>> -		of_match_device(dev->driver->of_match_table, dev)->data;
>> +	cfg = device_get_match_data(dev);
>>  
>>  	if (index >= ARRAY_SIZE(triggers_table) ||
>>  	    index >= cfg->num_valids_table)
> 
