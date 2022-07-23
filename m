Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0776857EBD0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 06:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiGWEIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 00:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGWEIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 00:08:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6A70E54;
        Fri, 22 Jul 2022 21:08:39 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LqXmM41ZDzkX6Y;
        Sat, 23 Jul 2022 12:06:11 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 23 Jul 2022 12:08:35 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 23 Jul 2022 12:08:34 +0800
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
To:     Joe Perches <joe@perches.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        <josef@toxicpanda.com>, <axboe@kernel.dk>, <houtao1@huawei.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
 <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
 <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
 <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
 <ec031ff1-3936-92ce-b66b-59e3e6a289ab@huaweicloud.com>
 <c4cf82073cccd574aa75b3a8e1f15748929c7621.camel@perches.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <809c7cb8-6602-8568-cd91-33281a6fb508@huawei.com>
Date:   Sat, 23 Jul 2022 12:08:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c4cf82073cccd574aa75b3a8e1f15748929c7621.camel@perches.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

在 2022/07/23 11:12, Joe Perches 写道:
> On Sat, 2022-07-23 at 10:15 +0800, Yu Kuai wrote:
>> Hi!
> 
> Hello.
> 
>> 在 2022/07/20 19:46, Yu Kuai 写道:
>>> 在 2022/07/18 22:32, Joe Perches 写道:
>>>> On Mon, 2022-07-18 at 21:52 +0800, Yu Kuai wrote:
>>>>> 在 2022/07/06 17:33, Yu Kuai 写道:
>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>
>>>>>> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
>>>>>> to define pr_fmt and use short pr_err() to output error message,
>>>>>> however, the definition is missed.
>>>>> friendly ping ...
>>>> []
>>>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>>>> []
>>>>>> @@ -44,6 +44,9 @@
>>>>>>     #include <linux/nbd-netlink.h>
>>>>>>     #include <net/genetlink.h>
>>>>>> +#undef pr_fmt
>>>>>> +#define pr_fmt(fmt) "nbd: " fmt
>>>>>> +
>>>> Typically, this #define is place before all #include lines
>>>> so there is no need for an #undef
>>
>> I tried to remove the #undef:
> 
> I'll repeat my message.
> 
> Move the #define before _any_ #include.
> 
> Also, there are some message that would need existing "nbd: " output
> prefixes removed.

Thanks for your explanation, I do miss that.

Kuai
> ---
>   drivers/block/nbd.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index f5d098a148cbf..222f26ac5e96a 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -11,6 +11,8 @@
>    * (part of code stolen from loop.c)
>    */
>   
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>   #include <linux/major.h>
>   
>   #include <linux/blkdev.h>
> @@ -1950,8 +1952,8 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   			     test_bit(NBD_DISCONNECT_REQUESTED, &nbd->flags)) ||
>   			    !refcount_inc_not_zero(&nbd->refs)) {
>   				mutex_unlock(&nbd_index_mutex);
> -				pr_err("nbd: device at index %d is going down\n",
> -					index);
> +				pr_err("device at index %d is going down\n",
> +				       index);
>   				return -EINVAL;
>   			}
>   		}
> @@ -1961,7 +1963,7 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
>   	if (!nbd) {
>   		nbd = nbd_dev_add(index, 2);
>   		if (IS_ERR(nbd)) {
> -			pr_err("nbd: failed to add new device\n");
> +			pr_err("failed to add new device\n");
>   			return PTR_ERR(nbd);
>   		}
>   	}
> 
> 
> .
> 
