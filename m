Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C84FA1C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiDICk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiDICkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:40:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9FBF503;
        Fri,  8 Apr 2022 19:38:18 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZzhW0R63zBrv9;
        Sat,  9 Apr 2022 10:34:03 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 10:38:16 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 10:38:15 +0800
Subject: Re: [PATCH -next RFC v2 4/8] blk-mq: don't preempt tag under heavy
 load
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-5-yukuai3@huawei.com>
 <0dab5bd2-4f19-0b04-fa8c-6ed68b70c20e@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <6cae9259-3d0b-b3cd-a11f-f1c90ecb0176@huawei.com>
Date:   Sat, 9 Apr 2022 10:38:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0dab5bd2-4f19-0b04-fa8c-6ed68b70c20e@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/04/08 22:24, Bart Van Assche 写道:
> On 4/8/22 00:39, Yu Kuai wrote:
>> The idle way to disable tag preemption is to track how many tags are
> 
> idle -> ideal?
> 
>> available, and wait directly in blk_mq_get_tag() if free tags are
>> very little. However, this is out of reality because fast path is
>> affected.
>>
>> As 'ws_active' is only updated in slow path, this patch disable tag
>> preemption if 'ws_active' is greater than 8, which means there are many
>> threads waiting for tags already.
>>
>> Once tag preemption is disabled, there is a situation that can cause
>> performance degration(or io hung in extreme scenarios): the waitqueue
> 
> degration -> degradation?
> 
>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>> index 2615bd58bad3..b49b20e11350 100644
>> --- a/block/blk-mq.h
>> +++ b/block/blk-mq.h
>> @@ -156,6 +156,7 @@ struct blk_mq_alloc_data {
>>       /* allocate multiple requests/tags in one go */
>>       unsigned int nr_tags;
>> +    bool preemption;
>>       struct request **cached_rq;
> 
> Please change "preemption" into "preempt".

Thanks for your advice, will change that and previous spelling mistakes.

Kuai
> 
> Thanks,
> 
> Bart.
> 
> .
> 
