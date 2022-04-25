Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5489850E27A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbiDYN7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbiDYN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:58:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FA114023;
        Mon, 25 Apr 2022 06:55:50 -0700 (PDT)
Received: from kwepemi500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kn62m4CwNzfbCv;
        Mon, 25 Apr 2022 21:54:56 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500020.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 21:55:48 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 21:55:47 +0800
Subject: Re: [PATCH -next v2 2/5] block, bfq: add fake weight_counter for
 weight-raised queue
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     Jan Kara <jack@suse.cz>
CC:     <paolo.valente@linaro.org>, <axboe@kernel.dk>, <tj@kernel.org>,
        <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220416093753.3054696-1-yukuai3@huawei.com>
 <20220416093753.3054696-3-yukuai3@huawei.com>
 <20220425094856.qgkhba2klguduxot@quack3.lan>
 <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
Message-ID: <4048cc0c-adc8-8097-4a40-762137c4c282@huawei.com>
Date:   Mon, 25 Apr 2022 21:55:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a27b8c79-867f-9253-84db-1d39c964b3ed@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

�� 2022/04/25 21:34, yukuai (C) д��:
> �� 2022/04/25 17:48, Jan Kara д��:
>> On Sat 16-04-22 17:37:50, Yu Kuai wrote:
>>> Weight-raised queue is not inserted to weights_tree, which makes it
>>> impossible to track how many queues have pending requests through
>>> weights_tree insertion and removel. This patch add fake weight_counter
>>> for weight-raised queue to do that.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>
>> This is a bit hacky. I was looking into a better place where to hook to
>> count entities in a bfq_group with requests and I think 
>> bfq_add_bfqq_busy()
>> and bfq_del_bfqq_busy() are ideal for this. It also makes better sense
>> conceptually than hooking into weights tree handling.
>>
> Hi,
> 
> bfq_del_bfqq_busy() will be called when all the reqs in the bfqq are
> dispatched, however there might still some reqs are't completed yet.
> 
> Here what we want to track is how many bfqqs have pending reqs,
> specifically if the bfqq have reqs are't complted.
> 
> Thus I think bfq_del_bfqq_busy() is not the right place to do that.

BTW, there is a counter 'dispatched' in bfqq, how about we rename it
to 'inflight', and inc when adding req to bfqq, dec the same as
'dispatched' ?

This way we can count bfqq when adding 'inflight' from 0 to 1, and
stop when decreasing 'inflight' from 1 to 0.

