Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95605465C43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354832AbhLBCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:45:25 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16334 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbhLBCoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:44:39 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J4Kv82KfJz91Mh;
        Thu,  2 Dec 2021 10:40:36 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 10:41:09 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 10:41:08 +0800
Subject: Re: [PATCH -next 2/3] staging: rtl8192e: rtllib_module: fix error
 handle case in alloc_rtllib()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <gregkh@linuxfoundation.org>, <paskripkin@gmail.com>
References: <20211201095036.1763163-1-yangyingliang@huawei.com>
 <20211201095036.1763163-3-yangyingliang@huawei.com>
 <20211201095602.GB18178@kadam>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <31d8310f-edae-da8f-7ac4-e780db8a9973@huawei.com>
Date:   Thu, 2 Dec 2021 10:41:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211201095602.GB18178@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/1 17:56, Dan Carpenter wrote:
> Almost perfect, but it needs one minor change.
>
> On Wed, Dec 01, 2021 at 05:50:35PM +0800, Yang Yingliang wrote:
>> Some variables are leaked in the error handling in alloc_rtllib(), free
>> the variables in the error path.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
> Please send this as a v4 patch with a little note here:
>
> v4: Fix crypt_info leak
> v3: Fix more leaks.  Break it up into multple patches.
> v2: Make rtllib_softmac_init() return error codes.
>
> You can probably put that in the 0/3 email.
>
>
>>   drivers/staging/rtl8192e/rtllib_module.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
>> index 64d9feee1f39..a3c74fa25cfa 100644
>> --- a/drivers/staging/rtl8192e/rtllib_module.c
>> +++ b/drivers/staging/rtl8192e/rtllib_module.c
>> @@ -88,7 +88,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>>   	err = rtllib_networks_allocate(ieee);
>>   	if (err) {
>>   		pr_err("Unable to allocate beacon storage: %d\n", err);
>> -		goto failed;
>> +		goto free_netdev;
>>   	}
>>   	rtllib_networks_initialize(ieee);
>>   
>> @@ -121,11 +121,13 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>>   	ieee->hwsec_active = 0;
>>   
>>   	memset(ieee->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
>> -	rtllib_softmac_init(ieee);
>> +	err = rtllib_softmac_init(ieee);
>> +	if (err)
>> +		goto free_networks;
> This needs to free crypt_info;  This was my mistake in the email I sent
> earlier.  Sorry!
>
>>   
>>   	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
>>   	if (!ieee->pHTInfo)
>> -		return NULL;
>> +		goto free_softmac;
>>   
>>   	HTUpdateDefaultSetting(ieee);
>>   	HTInitializeHTInfo(ieee);
>> @@ -141,8 +143,14 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>>   
>>   	return dev;
>>   
>> - failed:
>> +free_softmac:
>> +	rtllib_softmac_free(ieee);
>> +	lib80211_crypt_info_free(&ieee->crypt_info);
>> +free_networks:
>> +	rtllib_networks_free(ieee);
>> +free_netdev:
>>   	free_netdev(dev);
>> +
>>   	return NULL;
> Something like:
>
> free_softmac:
> 	rtllib_softmac_free(ieee);
> free_crypt_info:
> 	lib80211_crypt_info_free(&ieee->crypt_info);
> 	rtllib_networks_free(ieee);
> free_netdev:
>   	free_netdev(dev);
Yes, you are right, I should find this mistake before I send the patch.
I will send a v4 patch set with this fix.

Thanks,
Yang
>
> regards,
> dan carpenter
>
> .
