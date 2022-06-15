Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7890E54BF14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiFOBIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiFOBIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:08:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B74183A2;
        Tue, 14 Jun 2022 18:08:08 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LN6Xc4TcCzRjXR;
        Wed, 15 Jun 2022 09:04:48 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:07:58 +0800
Received: from [10.67.103.212] (10.67.103.212) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 15 Jun 2022 09:07:57 +0800
Subject: Re: [PATCH 1/3] uacce: supports device isolation feature
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>
References: <20220614122943.1406-1-yekai13@huawei.com>
 <20220614122943.1406-5-yekai13@huawei.com>
 <452a54f0-27ce-6c0d-da56-883b0204f57c@linaro.org>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <wangzhou1@hisilicon.com>
From:   "yekai(A)" <yekai13@huawei.com>
Message-ID: <3422d14f-abf2-68d6-0923-1b62ec2abb17@huawei.com>
Date:   Wed, 15 Jun 2022 09:07:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <452a54f0-27ce-6c0d-da56-883b0204f57c@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.212]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 22:14, Zhangfei Gao wrote:
>
>
> On 2022/6/14 下午8:29, Kai Ye wrote:
>> UACCE add the hardware error isolation API. Users can configure
>> the error frequency threshold by this vfs node. This API interface
>> certainly supports the configuration of user protocol strategy. Then
>> parse it inside the device driver. UACCE only reports the device
>> isolate state. When the error frequency is exceeded, the device
>> will be isolated. The isolation strategy should be defined in each
>> driver module.
>>
>> Signed-off-by: Kai Ye <yekai13@huawei.com>
>> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
>> ---
>>   drivers/misc/uacce/uacce.c | 51 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/uacce.h      | 15 ++++++++++-
>>   2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
>> index b6219c6bfb48..4d9d9aeb145a 100644
>> --- a/drivers/misc/uacce/uacce.c
>> +++ b/drivers/misc/uacce/uacce.c
>> @@ -12,6 +12,20 @@ static dev_t uacce_devt;
>>   static DEFINE_MUTEX(uacce_mutex);
>>   static DEFINE_XARRAY_ALLOC(uacce_xa);
>>   +static int cdev_get(struct device *dev, void *data)
>> +{
>> +    struct uacce_device *uacce;
>> +    struct device **t_dev = data;
>> +
>> +    uacce = container_of(dev, struct uacce_device, dev);
>> +    if (uacce->parent == *t_dev) {
>> +        *t_dev = dev;
>> +        return 1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int uacce_start_queue(struct uacce_queue *q)
>>   {
>>       int ret = 0;
>> @@ -346,12 +360,47 @@ static ssize_t region_dus_size_show(struct
>> device *dev,
>>                  uacce->qf_pg_num[UACCE_QFRT_DUS] << PAGE_SHIFT);
>>   }
>>   +static ssize_t isolate_show(struct device *dev,
>> +                struct device_attribute *attr, char *buf)
>> +{
>> +    struct uacce_device *uacce = to_uacce_device(dev);
>> +
>> +    return sysfs_emit(buf, "%d\n",
>> uacce->ops->get_isolate_state(uacce));
> Are these two isolate ops  required or optional?
> Do we need consider NULL pointer?
>
> Thanks
> .
>

Yes, need to consider NULL pointer.

Thanks
kai
