Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C2E578256
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiGRM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiGRM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:29:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E95B66
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:29:20 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lmh645hLpz1M7xh;
        Mon, 18 Jul 2022 20:26:36 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 20:29:17 +0800
Subject: Re: [PATCH -next,v2] nvmem: core: Fix memleak in nvmem_register()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>,
        <wangweiyang2@huawei.com>
References: <20220716095257.2752110-1-cuigaosheng1@huawei.com>
 <9029caa7-beea-34f6-7f9b-b2b230c3baeb@linaro.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <81b18902-fb45-74b2-ec58-84b468ee9bf1@huawei.com>
Date:   Mon, 18 Jul 2022 20:29:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9029caa7-beea-34f6-7f9b-b2b230c3baeb@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your ideas,

I have made another patch, moving nvmem_validate_keepouts() after
device_register() and let the device core deal with cleaning name in
error cases, it's a better option for the issue.

Thanks,

在 2022/7/18 19:44, Srinivas Kandagatla 写道:
>
>
> On 16/07/2022 10:52, Gaosheng Cui wrote:
>> dev_set_name will alloc memory for nvmem->dev.kobj.name in
>> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
>> memory will be freed and return, but nobody will free memory
>> for nvmem->dev.kobj.name, there will be memleak, so moving
>> dev_set_name after nvmem_validate_keepouts to fix it.
>>
>> Fixes: de0534df9347 ("nvmem: core: fix error handling while 
>> validating keepout regions")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/nvmem/core.c | 28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 1e3c754efd0d..a5d75edf509d 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -808,20 +808,6 @@ struct nvmem_device *nvmem_register(const struct 
>> nvmem_config *config)
>>       else if (!config->no_of_node)
>>           nvmem->dev.of_node = config->dev->of_node;
>>   -    switch (config->id) {
>> -    case NVMEM_DEVID_NONE:
>> -        dev_set_name(&nvmem->dev, "%s", config->name);
>> -        break;
>> -    case NVMEM_DEVID_AUTO:
>> -        dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
>> -        break;
>> -    default:
>> -        dev_set_name(&nvmem->dev, "%s%d",
>> -                 config->name ? : "nvmem",
>> -                 config->name ? config->id : nvmem->id);
>> -        break;
>> -    }
>> -
>>       nvmem->read_only = device_property_present(config->dev, 
>> "read-only") ||
>>                  config->read_only || !nvmem->reg_write;
>>   @@ -838,6 +824,20 @@ struct nvmem_device *nvmem_register(const 
>> struct nvmem_config *config)
>>           }
>>       }
>>   +    switch (config->id) {
>> +    case NVMEM_DEVID_NONE:
>> +        dev_set_name(&nvmem->dev, "%s", config->name);
>> +        break;
>> +    case NVMEM_DEVID_AUTO:
>> +        dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
>> +        break;
>> +    default:
>> +        dev_set_name(&nvmem->dev, "%s%d",
>> +                 config->name ? : "nvmem",
>> +                 config->name ? config->id : nvmem->id);
>> +        break;
>> +    }
>> +
> The issue with this approach is that dev_err messages in 
> nvmem_validate_keepouts() will show up without device name setup.
>
> I think better option is to move nvmem_validate_keepouts() after 
> device_register() and let the device core deal with cleaning name in 
> error cases.
>
> --srini
>
>>       dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", 
>> config->name);
>>         rval = device_register(&nvmem->dev);
> .
