Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5C4EB7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiC3BT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbiC3BTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:19:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD82018C;
        Tue, 29 Mar 2022 18:18:11 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KSpTC3TmhzcbX9;
        Wed, 30 Mar 2022 09:17:51 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:18:08 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 30 Mar 2022 09:18:07 +0800
Subject: Re: [PATCH -next RFC 1/6] blk-mq: add a new flag
 'BLK_MQ_F_NO_TAG_PREEMPTION'
To:     Jens Axboe <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-2-yukuai3@huawei.com>
 <190625d8-ed84-f657-6058-2d151f6d4caa@kernel.dk>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <f83ea9d7-bc89-6855-f9a6-c42f4647d383@huawei.com>
Date:   Wed, 30 Mar 2022 09:18:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <190625d8-ed84-f657-6058-2d151f6d4caa@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2022/03/29 20:44, Jens Axboe wrote:
> On 3/29/22 3:40 AM, Yu Kuai wrote:
>> Tag preemption is the default behaviour, specifically blk_mq_get_tag()
>> will try to get tag unconditionally, which means a new io can preempt tag
>> even if there are lots of ios that are waiting for tags.
>>
>> This patch introduce a new flag, prepare to disable such behaviour, in
>> order to optimize io performance for large random io for HHD.
> 
> Not sure why we need a flag for this behavior. Does it ever make sense
> to allow preempting waiters, jumping the queue?
> 

Hi,

I was thinking using the flag to control the new behavior, in order to
reduce the impact on general path.

If wake up path is handled properly, I think it's ok to disable
preempting tags.

Thanks
Kuai
