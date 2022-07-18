Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC58578297
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiGRMnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiGRMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:43:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4E25C71
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:43:11 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LmhQ35clLz1M7xd;
        Mon, 18 Jul 2022 20:40:27 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 20:43:08 +0800
Subject: Re: [PATCH -next,v4] nvmem: core: Fix memleak in nvmem_register()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>,
        <wangweiyang2@huawei.com>
References: <20220718122120.3103545-1-cuigaosheng1@huawei.com>
 <a1b7262a-2c9d-7495-e660-b6ef43d3ad44@linaro.org>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <be2bffa9-7331-9d96-e7a0-94561c66d00d@huawei.com>
Date:   Mon, 18 Jul 2022 20:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a1b7262a-2c9d-7495-e660-b6ef43d3ad44@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

>
> What changed since v3?
I adjusted the commit message because the implementation of the code has 
changed.

>
> Unnecessary braces here. 
Already fixed.

Thanks,

在 2022/7/18 20:24, Srinivas Kandagatla 写道:
>
>
> On 18/07/2022 13:21, Gaosheng Cui wrote:
>> dev_set_name will alloc memory for nvmem->dev.kobj.name in
>> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
>> memory will be freed and return, but nobody will free memory
>> for nvmem->dev.kobj.name, there will be memleak, so moving
>> nvmem_validate_keepouts() after device_register() and let
>> the device core deal with cleaning name in error cases.
>>
>> Fixes: de0534df9347 ("nvmem: core: fix error handling while 
>> validating keepout regions")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>
> What changed since v3?
>
>>   drivers/nvmem/core.c | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 1e3c754efd0d..6067d3bbff5d 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -829,21 +829,19 @@ struct nvmem_device *nvmem_register(const 
>> struct nvmem_config *config)
>>       nvmem->dev.groups = nvmem_dev_groups;
>>   #endif
>>   -    if (nvmem->nkeepout) {
>> -        rval = nvmem_validate_keepouts(nvmem);
>> -        if (rval) {
>> -            ida_free(&nvmem_ida, nvmem->id);
>> -            kfree(nvmem);
>> -            return ERR_PTR(rval);
>> -        }
>> -    }
>> -
>>       dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", 
>> config->name);
>>         rval = device_register(&nvmem->dev);
>>       if (rval)
>>           goto err_put_device;
>>   +    if (nvmem->nkeepout) {
>> +        rval = nvmem_validate_keepouts(nvmem);
>> +        if (rval) {
>
> Unnecessary braces here.
>
> --srini
>> +            goto err_device_del;
>> +        }
>> +    }
>> +
>>       if (config->compat) {
>>           rval = nvmem_sysfs_setup_compat(nvmem, config);
>>           if (rval)
> .
