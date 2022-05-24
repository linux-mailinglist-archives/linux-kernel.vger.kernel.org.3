Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBB53217F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiEXDPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiEXDPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:15:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5A8A045
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:15:47 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6fT35gZZzjWws;
        Tue, 24 May 2022 11:15:03 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 11:15:45 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 11:15:44 +0800
Message-ID: <c6ae7eda-0792-2ac0-e524-eb000366b50f@huawei.com>
Date:   Tue, 24 May 2022 11:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] amba: fix refcount underflow if amba_device_add() fails
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh@kernel.org>
References: <20220524030941.GA290608@roeck-us.net>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220524030941.GA290608@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/24 11:09, Guenter Roeck wrote:
> On Tue, May 24, 2022 at 10:51:39AM +0800, Kefeng Wang wrote:
>> "ARM: 9192/1: amba: fix memory leak in amba_device_try_add()" leads
>> to a refcount underflow if amba_device_add() fails, which called by
>> of_amba_device_create(), the of_amba_device_create() already exists
>> the error handling, so amba_put_device() only need to be added into
>> amba_deferred_retry().
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks.

PS: I also test with kmemleak, this could also fix previous memory leak 
issue.

>
> Thanks,
> Guenter
>
>> ---
>>   drivers/amba/bus.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> index 0e3ed5eb367b..0cb20324da16 100644
>> --- a/drivers/amba/bus.c
>> +++ b/drivers/amba/bus.c
>> @@ -493,13 +493,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>>   		goto skip_probe;
>>   
>>   	ret = amba_read_periphid(dev);
>> -	if (ret) {
>> -		if (ret != -EPROBE_DEFER) {
>> -			amba_device_put(dev);
>> -			goto err_out;
>> -		}
>> +	if (ret)
>>   		goto err_release;
>> -	}
>>   
>>   skip_probe:
>>   	ret = device_add(&dev->dev);
>> @@ -546,6 +541,7 @@ static int amba_deferred_retry(void)
>>   			continue;
>>   
>>   		list_del_init(&ddev->node);
>> +		amba_device_put(ddev->dev);
>>   		kfree(ddev);
>>   	}
>>   
>> -- 
>> 2.35.3
>>
> .
