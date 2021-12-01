Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF07464505
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhLACpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:45:05 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31929 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbhLACpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:45:03 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J3jyl1mkNzcbf0;
        Wed,  1 Dec 2021 10:41:35 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 10:41:41 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 10:41:41 +0800
Subject: Re: [PATCH -next] staging: rtl8192e: rtllib_module: fix missing
 free_netdev() on error in alloc_rtllib()
To:     Pavel Skripkin <paskripkin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>
References: <20211130034007.779351-1-yangyingliang@huawei.com>
 <851b57b9-79ac-e7a1-a61a-6f36a5d9d77a@gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <8f1c4e5a-663f-e5f4-a98e-b72ee3a4f365@huawei.com>
Date:   Wed, 1 Dec 2021 10:41:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <851b57b9-79ac-e7a1-a61a-6f36a5d9d77a@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/12/1 2:57, Pavel Skripkin wrote:
> On 11/30/21 06:40, Yang Yingliang wrote:
>> Add the missing free_netdev() before return from alloc_rtllib()
>> in the error handling case.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/staging/rtl8192e/rtllib_module.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtllib_module.c 
>> b/drivers/staging/rtl8192e/rtllib_module.c
>> index 64d9feee1f39..18d898714c5c 100644
>> --- a/drivers/staging/rtl8192e/rtllib_module.c
>> +++ b/drivers/staging/rtl8192e/rtllib_module.c
>> @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>>         ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), 
>> GFP_KERNEL);
>>       if (!ieee->pHTInfo)
>> -        return NULL;
>> +        goto failed;
>>         HTUpdateDefaultSetting(ieee);
>>       HTInitializeHTInfo(ieee);
>>
>
> Good catch!
>
> There are 2 more possible leaks, tho. rtllib_networks_allocate() and 
> rtllib_softmac_init() should be unwinded too.
The error path of rtllib_networks_allocate()  won't leak the dev.
>
> For some odd reason rtllib_softmac_init() does not return an error in 
> case of allocation failure, but it should be fixed. I think, it worth 
> to fix whole error handling in one patch
I will send a v2 to fix this.

Thanks,
Yang
>
>
>
>
> With regards,
> Pavel Skripkin
> .
