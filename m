Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4C48BDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350589AbiALES6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:18:58 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17341 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiALES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:18:56 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JYZ6L6w80z9sCP;
        Wed, 12 Jan 2022 12:17:46 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 12:18:54 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 12:18:54 +0800
Message-ID: <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
Date:   Wed, 12 Jan 2022 12:18:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <john.garry@huawei.com>,
        <martin.petersen@oracle.com>, <hare@suse.de>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/11 22:15, Andy Shevchenko wrote:
> On Tue, Jan 11, 2022 at 10:02:16PM +0800, Laibin Qiu wrote:
>> In case of shared tags, there might be more than one hctx which
>> allocates from the same tags, and each hctx is limited to allocate at
>> most:
>>          hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
>>
>> tag idle detection is lazy, and may be delayed for 30sec, so there
>> could be just one real active hctx(queue) but all others are actually
>> idle and still accounted as active because of the lazy idle detection.
>> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
>> forever on this real active hctx.
>>
>> Fix this by recalculating wake_batch when inc or dec active_queues.
> 
> ...
> 
>>   {
>> +	unsigned int users;
> 
> Missed blank line here.
Thanks, i will modify it in V5.
> 
>>   	if (blk_mq_is_shared_tags(hctx->flags)) {
>>   		struct request_queue *q = hctx->queue;
>>   
>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
> 
> Whoever wrote this code did too much defensive programming, because the first
> conditional doesn't make much sense here. Am I right?
> 
I think because this judgement is in the general IO process, there are 
also some performance considerations here.
>> +			return true;
>> +		}
>>   	} else {
> 
>> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
>> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state)) {
> 
> Ditto.
> 
>> +			return true;
>> +		}
>>   	}
> 
> ...
> 
>> +	unsigned int wake_batch = clamp_t(unsigned int,
>> +			(sbq->sb.depth + users - 1) / users, 4U, SBQ_WAKE_BATCH);
> 
> 
> 	unsigned int wake_batch;
> 
> 	wake_batch = clamp_val((sbq->sb.depth + users - 1) / users, 4, SBQ_WAKE_BATCH);
> 	...
> 
> is easier to read, no?

Here I refer to the calculation method in sbq_calc_wake_batch(). And I 
will separate the definition from the calculation in V5.

> 
