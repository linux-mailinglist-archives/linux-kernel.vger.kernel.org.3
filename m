Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2806F473BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhLNEZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:25:11 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16804 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhLNEZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:25:10 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JCldN3r2kz914b;
        Tue, 14 Dec 2021 12:24:24 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 12:25:07 +0800
Received: from [10.174.177.69] (10.174.177.69) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 12:25:07 +0800
Message-ID: <41632d62-2bb2-fcf1-ed84-5a63733459d1@huawei.com>
Date:   Tue, 14 Dec 2021 12:25:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] block/wbt: fix negative inflight counter when
 remove scsi device
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <yi.zhang@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211213040907.2669480-1-qiulaibin@huawei.com>
 <YbeAAyWbkh5frMGc@infradead.org>
From:   QiuLaibin <qiulaibin@huawei.com>
In-Reply-To: <YbeAAyWbkh5frMGc@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.69]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/14 1:16, Christoph Hellwig wrote:
> On Mon, Dec 13, 2021 at 12:09:07PM +0800, Laibin Qiu wrote:
>> Submit_bio
>>                                                           scsi_remove_device
>>                                                           sd_remove
>>                                                           del_gendisk
>>                                                           blk_unregister_queue
>>                                                           elv_unregister_queue
>>                                                           wbt_enable_default
>>                                                           <= Set rwb->enable_state (ON)
>> q_qos_track
>> <= rwb->enable_state (ON)
>> ^^^^^^ this request will mark WBT_TRACKED without inflight add and will
>> lead to drop rqw->inflight to -1 in wbt_done() which will trigger IO hung.
>>
>> Fix this by judge whether QUEUE_FLAG_REGISTERED is marked to distinguish
>> scsi remove scene.
>> Fixes: 76a8040817b4b ("blk-wbt: make sure throttle is enabled properly")
>> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
>> ---
>>   block/blk-wbt.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index 3ed71b8da887..537f77bb1365 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -637,6 +637,10 @@ void wbt_enable_default(struct request_queue *q)
>>   {
>>   	struct rq_qos *rqos = wbt_rq_qos(q);
>>   
>> +	/* Queue not registered? Maybe shutting down... */
>> +	if (!blk_queue_registered(q))
>> +		return;
> 
> Wouldn't it make more sense to simply not call wbt_enable_default from
> elv_unregister_queue?
> .
> 

Refer to your opinion, I will post another version of V2.
Please take a look again.
