Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE604DD275
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiCRBiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRBiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:38:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC362D91BB;
        Thu, 17 Mar 2022 18:36:42 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKRQ62BSpzCqlq;
        Fri, 18 Mar 2022 09:34:38 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 09:36:40 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 09:36:40 +0800
Subject: Re: [PATCH 1/3] block: don't show disk stats if io accounting is
 disabled
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <mpatocka@redhat.com>, <snitzer@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220317112653.1019490-1-yukuai3@huawei.com>
 <20220317112653.1019490-2-yukuai3@huawei.com>
 <22cd48e9-fe36-414c-942e-382b8139ab4b@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <32a69b87-270e-479a-6207-24de3d70e9ed@huawei.com>
Date:   Fri, 18 Mar 2022 09:36:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <22cd48e9-fe36-414c-942e-382b8139ab4b@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
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

在 2022/03/17 22:06, Bart Van Assche 写道:
> On 3/17/22 04:26, Yu Kuai wrote:
>> If io accounting is disabled, there is no point to handle such device
>> in diskstats_show(), and it can be confused for users because all fields
>> in iostat are zero while the disk is handling io.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/genhd.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/block/genhd.c b/block/genhd.c
>> index c3b32c665aec..e5307f512185 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -937,6 +937,9 @@ ssize_t part_stat_show(struct device *dev,
>>       struct disk_stats stat;
>>       unsigned int inflight;
>> +    if (!blk_queue_io_stat(q))
>> +        return sprintf(buf, "io accounting is disabled\n");
>> +
> 
> Hmm ... the above looks sub-optimal to me. Has it been considered to 
> return an error code instead or even better to hide the stat attribute 
> if I/O accounting is disabled? The latter can be achieved by modifying 
> disk_visible().

Hi,

It's right this way is much better, i'll hide the 'stat' in next
iteration.

BTW, do you have any suggestion about patch 3?

Thanks,
Kuai
