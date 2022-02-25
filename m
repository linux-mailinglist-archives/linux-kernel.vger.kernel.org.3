Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC104C3C45
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiBYDPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBYDPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:15:44 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF01B65EB;
        Thu, 24 Feb 2022 19:15:12 -0800 (PST)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K4ZYn6QKhz9sJ0;
        Fri, 25 Feb 2022 11:11:41 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:15:10 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 25 Feb 2022 11:15:09 +0800
Subject: Re: [PATCH RFC] blk-mq: fix potential uaf for 'queue_hw_ctx'
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220223112601.2902761-1-yukuai3@huawei.com>
 <YhhBh0ehPjdARU5h@T590>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <593de98e-6b94-43dc-c62f-12388b11533e@huawei.com>
Date:   Fri, 25 Feb 2022 11:15:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YhhBh0ehPjdARU5h@T590>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

ÔÚ 2022/02/25 10:40, Ming Lei Ð´µÀ:

>> +static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +
>> +	rcu_read_lock();
>> +	hctx = *(rcu_dereference(q->queue_hw_ctx) + id);
>> +	rcu_read_unlock();
>> +
>> +	return hctx;
>> +}
> 
> queue_hctx() should be moved into linux/blk-mq.h, otherwise feel free to
> add:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review, I will send a new patch and move queue_hctx.

Kuai
> 
> Also it should be fine to implement queue_for_each_hw_ctx() as list, then we
> can avoid the allocation for q->queue_hw_ctx without extra cost. I will work
> toward that direction for improving the code.
> 
> Thanks,
> Ming
> 
> .
> 
