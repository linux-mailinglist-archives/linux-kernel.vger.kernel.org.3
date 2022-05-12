Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1B524E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354256AbiELNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353446AbiELNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:17:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707332211C8;
        Thu, 12 May 2022 06:17:56 -0700 (PDT)
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzXPP4n5DzhYTq;
        Thu, 12 May 2022 21:17:13 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 21:17:54 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 21:17:53 +0800
Subject: Re: [PATCH -next 0/6] nbd: bugfix and cleanup patches
From:   "yukuai (C)" <yukuai3@huawei.com>
To:     <josef@toxicpanda.com>, <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220426130746.885140-1-yukuai3@huawei.com>
 <a8f0b55b-625c-3393-fadb-5724e129abdf@huawei.com>
Message-ID: <98bd0dda-7cb4-ee6d-f037-d5049428d127@huawei.com>
Date:   Thu, 12 May 2022 21:17:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a8f0b55b-625c-3393-fadb-5724e129abdf@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping ...

在 2022/05/05 8:57, yukuai (C) 写道:
> friendly ping ...
> 
> 在 2022/04/26 21:07, Yu Kuai 写道:
>> path 1-2 fix races between nbd setup and module removal.
>> patch 3 fix io can't be completed in some error path.
>> patch 4 fix io hung when disconnecting failed.
>> patch 5 fix sysfs warning about duplicate creation.
>> patch 6 use pr_err to output error message.
>>
>> Yu Kuai (5):
>>    nbd: call genl_unregister_family() first in nbd_cleanup()
>>    nbd: fix race between nbd_alloc_config() and module removal
>>    nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
>>    nbd: fix io hung while disconnecting device
>>    nbd: use pr_err to output error message
>>
>> Zhang Wensheng (1):
>>    nbd: fix possible overflow on 'first_minor' in nbd_dev_add()
>>
>>   drivers/block/nbd.c | 119 +++++++++++++++++++++++++++-----------------
>>   1 file changed, 74 insertions(+), 45 deletions(-)
>>
