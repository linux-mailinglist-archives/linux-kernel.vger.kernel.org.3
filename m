Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD664EB830
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241938AbiC3CIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiC3CIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:08:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD6B820F;
        Tue, 29 Mar 2022 19:06:17 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSqV60h5RzDq6w;
        Wed, 30 Mar 2022 10:03:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 10:05:54 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 10:05:54 +0800
Subject: Re: [PATCH -next RFC 0/6] improve large random io for HDD
To:     Jens Axboe <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <a3e78af2-b0e3-9a97-5bbd-4bdbc5c5a58d@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7dec80e4-b96c-f00e-10c0-8510efa4b572@huawei.com>
Date:   Wed, 30 Mar 2022 10:05:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a3e78af2-b0e3-9a97-5bbd-4bdbc5c5a58d@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

在 2022/03/29 20:53, Jens Axboe 写道:
> On 3/29/22 3:40 AM, Yu Kuai wrote:
>> There is a defect for blk-mq compare to blk-sq, specifically split io
>> will end up discontinuous if the device is under high io pressure, while
>> split io will still be continuous in sq, this is because:
>>
>> 1) split bio is issued one by one, if one bio can't get tag, it will go
>> to wail. - patch 2
>> 2) each time 8(or wake batch) requests is done, 8 waiters will be woken up.
>> Thus if a thread is woken up, it will unlikey to get multiple tags.
>> - patch 3,4
>> 3) new io can preempt tag even if there are lots of threads waiting for
>> tags. - patch 5
>>
>> Test environment:
>> x86 vm, nr_requests is set to 64, queue_depth is set to 32 and
>> max_sectors_kb is set to 128.
>>
>> I haven't tested this patchset on physical machine yet, I'll try later
>> if anyone thinks this approch is meaningful.
> 
> A real machine test would definitely be a requirement. What real world
> uses cases is this solving? These days most devices have plenty of tags,
> and I would not really expect tag starvation to be much of a concern.
> 
> However, I do think there's merrit in fixing the unfairness we have
> here. But not at the cost of all of this. Why not just simply enforce
> more strict ordering of tag allocations? If someone is waiting, you get
> to wait too.
> 
> And I don't see much utility at all in tracking how many splits (and
> hence tags) would be required. Is this really a common issue, tons of
> splits and needing many tags? Why not just enforce the strict ordering
> as mentioned above, not allowing new allocators to get a tag if others
> are waiting, but perhaps allow someone submitting a string of splits to
> indeed keep allocating.
> 
> Yes, it'll be less efficient to still wake one-by-one, but honestly do
> we really care about that? If you're stalled on waiting for other IO to
> finish and release a tag, that isn't very efficient to begin with and
> doesn't seem like a case worth optimizing for me.
> 

Hi,

Thanks for your adivce, I'll do more work based on your suggestions.

Kuai
