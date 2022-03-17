Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646944DC738
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiCQNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCQNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:06:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428A31557CA;
        Thu, 17 Mar 2022 06:05:33 -0700 (PDT)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KK6hy4lDNz9smw;
        Thu, 17 Mar 2022 21:01:22 +0800 (CST)
Received: from [10.174.176.103] (10.174.176.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 17 Mar 2022 21:05:11 +0800
Message-ID: <8139ea99-09fa-eb84-e9ef-f1fb470b5b88@huawei.com>
Date:   Thu, 17 Mar 2022 21:05:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in
 nbd_dev_add()
From:   "zhangwensheng (E)" <zhangwensheng5@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nbd@other.debian.org>, <yukuai3@huawei.com>
References: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
 <0e5faf35-5adb-3ea1-9f7f-7c4f61a623b2@huawei.com>
In-Reply-To: <0e5faf35-5adb-3ea1-9f7f-7c4f61a623b2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.103]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping...

在 2022/3/11 10:43, zhangwensheng (E) 写道:
> friendly ping...
>
> 在 2022/3/10 17:32, Zhang Wensheng 写道:
>> When 'index' is a big numbers, it may become negative which forced
>> to 'int'. then 'index << part_shift' might overflow to a positive
>> value that is not greater than '0xfffff', then sysfs might complains
>> about duplicate creation. Because of this, move the 'index' judgment
>> to the front will fix it and be better.
>>
>> Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
>> Fixes: 940c264984fd ("nbd: fix possible overflow for 'first_minor' in 
>> nbd_dev_add()")
>> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>
>> ---
>>   drivers/block/nbd.c | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> index 5a1f98494ddd..b3cdfc0ffb98 100644
>> --- a/drivers/block/nbd.c
>> +++ b/drivers/block/nbd.c
>> @@ -1800,17 +1800,6 @@ static struct nbd_device *nbd_dev_add(int 
>> index, unsigned int refs)
>>       refcount_set(&nbd->refs, 0);
>>       INIT_LIST_HEAD(&nbd->list);
>>       disk->major = NBD_MAJOR;
>> -
>> -    /* Too big first_minor can cause duplicate creation of
>> -     * sysfs files/links, since index << part_shift might overflow, or
>> -     * MKDEV() expect that the max bits of first_minor is 20.
>> -     */
>> -    disk->first_minor = index << part_shift;
>> -    if (disk->first_minor < index || disk->first_minor > MINORMASK) {
>> -        err = -EINVAL;
>> -        goto out_free_work;
>> -    }
>> -
>>       disk->minors = 1 << part_shift;
>>       disk->fops = &nbd_fops;
>>       disk->private_data = nbd;
>> @@ -1915,8 +1904,19 @@ static int nbd_genl_connect(struct sk_buff 
>> *skb, struct genl_info *info)
>>       if (!netlink_capable(skb, CAP_SYS_ADMIN))
>>           return -EPERM;
>>   -    if (info->attrs[NBD_ATTR_INDEX])
>> +    if (info->attrs[NBD_ATTR_INDEX]) {
>>           index = nla_get_u32(info->attrs[NBD_ATTR_INDEX]);
>> +
>> +        /*
>> +         * Too big first_minor can cause duplicate creation of
>> +         * sysfs files/links, since index << part_shift might 
>> overflow, or
>> +         * MKDEV() expect that the max bits of first_minor is 20.
>> +         */
>> +        if (index < 0 || index > MINORMASK >> part_shift) {
>> +            printk(KERN_ERR "nbd: illegal input index %d\n", index);
>> +            return -EINVAL;
>> +        }
>> +    }
>>       if (!info->attrs[NBD_ATTR_SOCKETS]) {
>>           printk(KERN_ERR "nbd: must specify at least one socket\n");
>>           return -EINVAL;
> .
