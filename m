Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2245A2232
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245603AbiHZHp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245595AbiHZHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:45:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E201CA260F;
        Fri, 26 Aug 2022 00:45:45 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDX013WslzGprJ;
        Fri, 26 Aug 2022 15:44:01 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 15:45:43 +0800
Message-ID: <1fa01bcf-15e5-279e-79ac-056c70a9401d@huawei.com>
Date:   Fri, 26 Aug 2022 15:45:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: Use module_init and add module_exit
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <a.zummo@towertech.it>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220826070017.2340617-1-chris.zjh@huawei.com>
 <Ywh00crgSilSfZnC@mail.local>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <Ywh00crgSilSfZnC@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/26 15:22, Alexandre Belloni 写道:
> On 26/08/2022 15:00:17+0800, Zhang Jianhua wrote:
>> - Use module_init instead of device_initcall.
>> - Add a function for module_exit to unregister driver.
>>
> I can see what you are doing but this doesn't explain why. Also, was
> this tested on any actual hardware?

I find this problem by code review, so solve it smoothly, and there is 
no hardware, so I just test it on qemu.

May I need to modify the commit message?

>> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
>> ---
>>   drivers/rtc/rtc-fsl-ftm-alarm.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
>> index c0df49fb978c..28bdc6c97b64 100644
>> --- a/drivers/rtc/rtc-fsl-ftm-alarm.c
>> +++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
>> @@ -332,7 +332,13 @@ static int __init ftm_alarm_init(void)
>>   	return platform_driver_register(&ftm_rtc_driver);
>>   }
>>   
>> -device_initcall(ftm_alarm_init);
>> +static void __exit ftm_alarm_exit(void)
>> +{
>> +	platform_driver_unregister(&ftm_rtc_driver);
>> +}
>> +
>> +module_init(ftm_alarm_init)
>> +module_exit(ftm_alarm_exit)
>>   
>>   MODULE_DESCRIPTION("NXP/Freescale FlexTimer alarm driver");
>>   MODULE_AUTHOR("Biwen Li <biwen.li@nxp.com>");
>> -- 
>> 2.31.0
>>
