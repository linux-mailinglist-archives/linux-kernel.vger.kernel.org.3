Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69F3464878
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347618AbhLAHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:24 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27327 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347579AbhLAHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:06 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J3rM5577lzbhwd;
        Wed,  1 Dec 2021 15:29:37 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:29:44 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 15:29:44 +0800
Subject: Re: [PATCH -next] staging: rtl8192e: rtllib_module: fix missing
 free_netdev() on error in alloc_rtllib()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Pavel Skripkin <paskripkin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <gregkh@linuxfoundation.org>
References: <20211130034007.779351-1-yangyingliang@huawei.com>
 <851b57b9-79ac-e7a1-a61a-6f36a5d9d77a@gmail.com>
 <8f1c4e5a-663f-e5f4-a98e-b72ee3a4f365@huawei.com>
 <20211201065502.GC9522@kadam>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <5a7a0b57-1df5-2ef8-785a-6b8a5d47dc48@huawei.com>
Date:   Wed, 1 Dec 2021 15:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211201065502.GC9522@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/12/1 14:55, Dan Carpenter wrote:
> On Wed, Dec 01, 2021 at 10:41:41AM +0800, Yang Yingliang wrote:
>> Hi,
>>
>> On 2021/12/1 2:57, Pavel Skripkin wrote:
>>> On 11/30/21 06:40, Yang Yingliang wrote:
>>>> Add the missing free_netdev() before return from alloc_rtllib()
>>>> in the error handling case.
>>>>
>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>> ---
>>>>    drivers/staging/rtl8192e/rtllib_module.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/staging/rtl8192e/rtllib_module.c
>>>> b/drivers/staging/rtl8192e/rtllib_module.c
>>>> index 64d9feee1f39..18d898714c5c 100644
>>>> --- a/drivers/staging/rtl8192e/rtllib_module.c
>>>> +++ b/drivers/staging/rtl8192e/rtllib_module.c
>>>> @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
>>>>          ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput),
>>>> GFP_KERNEL);
>>>>        if (!ieee->pHTInfo)
>>>> -        return NULL;
>>>> +        goto failed;
>>>>          HTUpdateDefaultSetting(ieee);
>>>>        HTInitializeHTInfo(ieee);
>>>>
>>> Good catch!
>>>
>>> There are 2 more possible leaks, tho. rtllib_networks_allocate() and
>>> rtllib_softmac_init() should be unwinded too.
>> The error path of rtllib_networks_allocate()  won't leak the dev.
> You've misunderstood what Pavel is saying.  He's saying that we need to
> call rtllib_networks_free() as well as free_netdev().
>
> This code has a "goto failed" and that means it is either going to do
> nothing or do everything.  It is a bad style of error handling and it
> often has bugs like this.  The best way to write error handling is to
> use Free the Last Thing style.
>
> int my_alloc_function()
> {
> 	a = alloc();
> 	if (!a)
> 		return -ENOMEM;  // <- there is no last thing
>
> 	b = alloc();
> 	if (!b) {
> 		ret = -ENOMEM;
> 		goto free_a;  // <- this name says "a" is the last thing
> 	}
>
> 	c = alloc();
> 	if (!c) {
> 		ret = -ENOMEM;
> 		goto free_b;
> 	}
>
> 	return 0;
>
> free_b:
> 	free(b);
> free_a:
> 	free(a);
>
> 	return ret;
> }
>
> In this style of error handling you only need to remember the last
> successful allocation and the names tell you what the goto does so it
> is much easier to check if it's correct.
>
> Then to create a my_free_function() you can just: Copy and paste the
> error handling.  Add a free(c).  Delete the labels.
>
> void my_free_function()
> {
> 	free(c);
> 	free(b);
> 	free(a);
> }
>
> The free function for alloc_rtllib() is free_rtllib() and it looks like
> this:
>
> drivers/staging/rtl8192e/rtllib_module.c
>     150  void free_rtllib(struct net_device *dev)
>     151  {
>     152          struct rtllib_device *ieee = (struct rtllib_device *)
>     153                                        netdev_priv_rsl(dev);
>     154
>     155          kfree(ieee->pHTInfo);
>     156          ieee->pHTInfo = NULL;
>                  ^^^^^^^^^^^^^^^^^^^^^
> This line is pointless and should be deleted.
>
>     157          rtllib_softmac_free(ieee);
>     158
>     159          lib80211_crypt_info_free(&ieee->crypt_info);
>     160
>     161          rtllib_networks_free(ieee);
>     162          free_netdev(dev);
>     163  }
>
> As you can see this free function calls rtllib_softmac_free(),
> lib80211_crypt_info_free() and rtllib_networks_free() so the error
> handling in alloc_rtllib() needs to do that as well.  Based on what
> I have said, then ideally the error handling for alloc_rtllib() would
> look something like this:
>
>          return dev;
>
> free_softmac:
>          rtllib_softmac_free(ieee);
>          lib80211_crypt_info_free(&ieee->crypt_info);
> free_networks:
>          rtllib_networks_free(ieee);
> free_netdev:
>          free_netdev(dev);
>
>          return NULL;
>
> The rtllib_softmac_init() function should really return an int, but it
> returns void.  That could be fixed in a separate patch if you want.
I get it, thanks for your suggestion.
>
> regards,
> dan carpenter
> .
