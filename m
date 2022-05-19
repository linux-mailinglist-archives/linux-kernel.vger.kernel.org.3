Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD552C922
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiESBGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiESBGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:06:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1624F9E7;
        Wed, 18 May 2022 18:06:24 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L3WrB0D1jzhZ13;
        Thu, 19 May 2022 09:05:46 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:06:22 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 09:06:21 +0800
Subject: Re: [PATCH -next v2 6/6] nbd: use pr_err to output error message
To:     Joe Perches <joe@perches.com>, <josef@toxicpanda.com>,
        <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220518122618.1702997-1-yukuai3@huawei.com>
 <20220518122618.1702997-7-yukuai3@huawei.com>
 <f0acebb66b9b46ad472e0d0989dc0f5810cac3dd.camel@perches.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <65fe63ed-91d4-35bd-3e25-39c4457295d0@huawei.com>
Date:   Thu, 19 May 2022 09:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f0acebb66b9b46ad472e0d0989dc0f5810cac3dd.camel@perches.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/05/19 2:12, Joe Perches Ð´µÀ:
> On Wed, 2022-05-18 at 20:26 +0800, Yu Kuai wrote:
>> Instead of using the long printk(KERN_ERR "nbd: ...") to
>> output error message, defining pr_fmt and using
>> the short pr_err("") to do that. The replacemen is done
>> by using the following command:
>>
>>    sed -i 's/printk(KERN_ERR "nbd: /pr_err("/g' \
>> 		  drivers/block/nbd.c
> 
> It's also good to rewrap to 80 columns where possible.
> 
>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> []
>> @@ -2130,13 +2130,13 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>>   	nbd = idr_find(&nbd_index_idr, index);
>>   	if (!nbd) {
>>   		mutex_unlock(&nbd_index_mutex);
>> -		printk(KERN_ERR "nbd: couldn't find device at index %d\n",
>> +		pr_err("couldn't find device at index %d\n",
>>   		       index);
> 
> like here
> 
>>   		return -EINVAL;
>>   	}
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>>   		mutex_unlock(&nbd_index_mutex);
>> -		printk(KERN_ERR "nbd: device at index %d is going down\n",
>> +		pr_err("device at index %d is going down\n",
>>   		       index);
> 
> and here and below...
Hi, Josef

Thanks for your advice, I'll send a new version.
> 
>> @@ -2170,7 +2170,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>>   	nbd = idr_find(&nbd_index_idr, index);
>>   	if (!nbd) {
>>   		mutex_unlock(&nbd_index_mutex);
>> -		printk(KERN_ERR "nbd: couldn't find a device at index %d\n",
>> +		pr_err("couldn't find a device at index %d\n",
>>   		       index);
>>   		return -EINVAL;
>>   	}
>> @@ -2192,7 +2192,7 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
>>   	}
>>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>>   		mutex_unlock(&nbd_index_mutex);
>> -		printk(KERN_ERR "nbd: device at index %d is going down\n",
>> +		pr_err("device at index %d is going down\n",
>>   		       index);
>>   		return -EINVAL;
>>   	}
> 
> 
> 
> .
> 
