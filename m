Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5CA4C21D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiBXCnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBXCnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:43:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE223585C;
        Wed, 23 Feb 2022 18:43:24 -0800 (PST)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K3xtL4Xqjz1FD30;
        Thu, 24 Feb 2022 10:38:50 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 10:43:22 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 10:43:21 +0800
Subject: Re: [PATCH RFC] blk-mq: fix potential uaf for 'queue_hw_ctx'
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220223112601.2902761-1-yukuai3@huawei.com>
 <YhZFITXtiL8Xaord@T590> <df32802a-7dfb-3e80-359a-206c2be6ebe5@huawei.com>
 <YhbqWqtwNueSffuR@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <430683f5-d271-b2f2-8f7c-486e2a4a7d42@huawei.com>
Date:   Thu, 24 Feb 2022 10:43:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YhbqWqtwNueSffuR@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

在 2022/02/24 10:15, Ming Lei 写道:
>> Hi, Ming
>>
>> If blk_mq_quiesce_queue() is called from __blk_mq_update_nr_hw_queues()
>> first, and then swithing elevator to none won't trigger the problem.
>> However, what if blk_mq_unquiesce_queue() from switching elevator
>> decrease quiesce_depth to 0 first, and then blk_mq_quiesce_queue() is
>> called from __blk_mq_update_nr_hw_queues(), it seems to me such
>> concurrent scenarios still exist.
> 
> No, the scenario won't exist, once blk_mq_quiesce_queue() returns, it is
> guaranteed that:
> 
> - in-progress run queue is drained
> - no new run queue can be started

I understand that... What I mean about the concurrent scenario is that
reading queue_hw_ctx in blk_mq_run_hw_queues(), not the actual run
queue blk_mq_run_hw_queue():

t1                              t2
elevator_switch
  blk_mq_quiesce_queue -> quiesce_depth = 1
  blk_mq_unquiesce_queue-> quiesce_depth = 0
   blk_mq_run_hw_queues
                                  __blk_mq_update_nr_hw_queues
                                   blk_mq_quiesce_queue
    queue_for_each_hw_ctx
    -> quiesce_queue can't prevent reading queue_hw_ctx
     blk_mq_run_hw_queue
     //need_run is always false, nothing to do

Am I missing something about blk_mq_quiesce_queue ?

Thanks,
Kuai
