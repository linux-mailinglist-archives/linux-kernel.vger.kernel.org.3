Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911BE576D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiGPJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiGPJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:59:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF351C111
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 02:59:15 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LlNtK4QvPzkWKB;
        Sat, 16 Jul 2022 17:56:57 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 17:59:13 +0800
Subject: Re: [PATCH -next] nvmem: core: Fix memleak in nvmem_register()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <linux-kernel@vger.kernel.org>,
        <gongruiqi1@huawei.com>, <wangweiyang2@huawei.com>
References: <20220716075352.2622809-1-cuigaosheng1@huawei.com>
 <YtJ1mthCP+4laqOn@kroah.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <544cfbdb-9005-3d4d-58f9-258f875984dd@huawei.com>
Date:   Sat, 16 Jul 2022 17:59:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YtJ1mthCP+4laqOn@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
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

Thanks for your time.

I have made the v2 patch and moving dev_set_name after nvmem_validate_keepouts
to fix the issue, hope you can provide some advice.

Thanks.

ÔÚ 2022/7/16 16:23, Greg KH Ð´µÀ:
> On Sat, Jul 16, 2022 at 03:53:52PM +0800, Gaosheng Cui wrote:
>> dev_set_name will alloc memory for nvmem->dev.kobj.name in
>> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
>> memory will be freed and return, but nobody will free memory
>> for nvmem->dev.kobj.name, there will be memleak, so using
>> kfree_const(nvmem->dev.kobj.name) to fix it.
>>
>> Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/nvmem/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 1e3c754efd0d..6c75c9afa5f3 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -833,6 +833,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   		rval = nvmem_validate_keepouts(nvmem);
>>   		if (rval) {
>>   			ida_free(&nvmem_ida, nvmem->id);
>> +			kfree_const(nvmem->dev.kobj.name);
>>   			kfree(nvmem);
> Something is really wrong, you should never be touching the name pointer
> of a kobject directly like this.  Also the device structure itself
> should be cleaning up the memory, not a kfree.  So this feels wrong...
>
> greg k-h
> .
