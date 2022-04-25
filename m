Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771DF50DA1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiDYHbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiDYHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:31:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE93C9FF6;
        Mon, 25 Apr 2022 00:28:07 -0700 (PDT)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KmxRP6BjCzfb5t;
        Mon, 25 Apr 2022 15:27:13 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500023.china.huawei.com (7.221.188.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:28:05 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:28:04 +0800
Subject: Re: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220415101053.554495-1-yukuai3@huawei.com>
 <dc800086-43c6-1ff2-659e-258cb75649dd@huawei.com>
 <3fbadd9f-11dd-9043-11cf-f0839dcf30e1@opensource.wdc.com>
 <63e84f2a-2487-a0c3-cab2-7d2011bc2db4@huawei.com>
 <55e8b04f-0d2f-2ce1-6514-5abd0b67fd48@opensource.wdc.com>
 <6957af40-8720-d74b-5be7-6bcdd9aa1089@huawei.com>
 <237a43f0-3b09-46d0-e73c-57ef51e39590@opensource.wdc.com>
 <c11ebf9e-a232-4a5d-d539-f95f584f220e@huawei.com>
 <2e7969ea-68d0-964a-808e-ee8943de70e3@opensource.wdc.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <35f18afa-0db1-b423-5824-4d5631b0422f@huawei.com>
Date:   Mon, 25 Apr 2022 15:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2e7969ea-68d0-964a-808e-ee8943de70e3@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

在 2022/04/25 15:06, Damien Le Moal 写道:

>>> By the way, did you check that doing something like:
>>>
>>> echo 2048 > /sys/block/sdX/queue/nr_requests
>>>
>>> improves performance for your high number of jobs test case ?
>>
>> Yes, performance will not degrade when numjobs is not greater than 256
>> in this case.
> 
> That is my thinking as well. I am asking if did check that (did you run it ?).

Hi,

I'm sure I ran it with 256 jobs before.

However, I didn't run it with 512 jobs. And following is the result I
just tested:

ratio of sequential io: 49.1%

Read|Write seek 

cnt 99338, zero cnt 48753 

     >=(KB) .. <(KB)     : count       ratio |distribution 
              |
          0 .. 1         : 48753       49.1% 
|########################################|
          1 .. 2         : 0            0.0% | 
              |
          2 .. 4         : 0            0.0% | 
              |
          4 .. 8         : 0            0.0% | 
              |
          8 .. 16        : 0            0.0% | 
              |
         16 .. 32        : 0            0.0% | 
              |
         32 .. 64        : 0            0.0% | 
              |
         64 .. 128       : 4975         5.0% |##### 
              |
        128 .. 256       : 4439         4.5% |#### 
              |
        256 .. 512       : 2615         2.6% |### 
              |
        512 .. 1024      : 967          1.0% |# 
              |
       1024 .. 2048      : 213          0.2% |# 
              |
       2048 .. 4096      : 375          0.4% |# 
              |
       4096 .. 8192      : 723          0.7% |# 
              |
       8192 .. 16384     : 1436         1.4% |## 
              |
      16384 .. 32768     : 2626         2.6% |### 
              |
      32768 .. 65536     : 4197         4.2% |#### 
              |
      65536 .. 131072    : 6431         6.5% |###### 
              |
     131072 .. 262144    : 7590         7.6% |####### 
              |
     262144 .. 524288    : 6433         6.5% |###### 
              |
     524288 .. 1048576   : 4583         4.6% |#### 
              |
    1048576 .. 2097152   : 2237         2.3% |## 
              |
    2097152 .. 4194304   : 489          0.5% |# 
              |
    4194304 .. 8388608   : 83           0.1% |# 
              |
    8388608 .. 16777216  : 36           0.0% |# 
              |
   16777216 .. 33554432  : 0            0.0% | 
              |
   33554432 .. 67108864  : 0            0.0% | 
              |
   67108864 .. 134217728 : 137          0.1% |# 
              |
