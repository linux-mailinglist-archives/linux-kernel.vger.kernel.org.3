Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2650D787
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiDYDbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiDYDbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:31:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A7F101C1;
        Sun, 24 Apr 2022 20:27:57 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kmr703sRvzhYZ2;
        Mon, 25 Apr 2022 11:27:40 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:27:55 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:27:54 +0800
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
To:     Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220415101053.554495-1-yukuai3@huawei.com>
 <450b5ab6-fb82-06dc-2a11-e0b464901c74@acm.org>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <85bfe26e-fb54-6885-8bd5-a450fa07bcd4@huawei.com>
Date:   Mon, 25 Apr 2022 11:27:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <450b5ab6-fb82-06dc-2a11-e0b464901c74@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
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

在 2022/04/25 11:09, Bart Van Assche 写道:
> On 4/15/22 03:10, Yu Kuai wrote:
>> The single io performance(randwrite):
>>
>> | bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
>> | -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
>> | bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |
> 
> Although the above data is interesting, it is not sufficient. The above 
> data comes from a setup with a single hard disk. There are many other 
> configurations that are relevant (hard disk array, high speed NVMe, QD=1 
> USB stick, ...) but for which no conclusions can be drawn from the above 
> data.
Hi,

The original idea is to improve large bs randwrite performance in HDD,
here I just test the specific case in a HDD. It's right many other test
cases and configurations are relevant.
> 
> Another question is whether the approach of this patch series is the 
> right approach? I would expect that round-robin wakeup of waiters would 
> be ideal from a fairness point of view. However, there are patches in 
> this patch series that guarantee that wakeup of tag waiters won't happen 
> in a round robin fashion.

I was thinking that round-robin can't grantee fairness in the corner
case that 8 waitqueues are not balanced. For example, one waitqueue
somehow have lots of waiters, and it's better to handle them before
newcome waiters in other waitqueues.

How you think abount this way, keep round-robin wakeup if waitqueues
are balanced, otherwise choose the waitqueue with the max waiters.

Thanks,
Kuai
> 
> Thanks,
> 
> Bart.
> .
> 
