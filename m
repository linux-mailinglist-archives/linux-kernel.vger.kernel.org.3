Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9545027B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351974AbiDOJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351935AbiDOJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:58:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754AFAAC99;
        Fri, 15 Apr 2022 02:56:26 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfsB11fpdzhXZS;
        Fri, 15 Apr 2022 17:54:33 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 17:56:24 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 17:56:23 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>, <qiulaibin@huawei.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC v3 0/8] improve tag allocation under heavy load
Date:   Fri, 15 Apr 2022 18:10:45 +0800
Message-ID: <20220415101053.554495-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - update 'waiters_cnt' before 'ws_active' in sbitmap_prepare_to_wait()
 in patch 1, in case __sbq_wake_up() see 'ws_active > 0' while
 'waiters_cnt' are all 0, which will cause deap loop.
 - don't add 'wait_index' during each loop in patch 2
 - fix that 'wake_index' might mismatch in the first wake up in patch 3,
 also improving coding for the patch.
 - add a detection in patch 4 in case io hung is triggered in corner
 cases.
 - make the detection, free tags are sufficient, more flexible.
 - fix a race in patch 8.
 - fix some words and add some comments.

Changes in v2:
 - use a new title
 - add patches to fix waitqueues' unfairness - path 1-3
 - delete patch to add queue flag
 - delete patch to split big io thoroughly

In this patchset:
 - patch 1-3 fix waitqueues' unfairness.
 - patch 4,5 disable tag preemption on heavy load.
 - patch 6 forces tag preemption for split bios.
 - patch 7,8 improve large random io for HDD. We do meet the problem and
 I'm trying to fix it at very low cost. However, if anyone still thinks
 this is not a common case and not worth to optimize, I'll drop them.

There is a defect for blk-mq compare to blk-sq, specifically split io
will end up discontinuous if the device is under high io pressure, while
split io will still be continuous in sq, this is because:

1) new io can preempt tag even if there are lots of threads waiting.
2) split bio is issued one by one, if one bio can't get tag, it will go
to wail.
3) each time 8(or wake batch) requests is done, 8 waiters will be woken up.
Thus if a thread is woken up, it will unlikey to get multiple tags.

The problem was first found by upgrading kernel from v3.10 to v4.18,
test device is HDD with 256 'max_sectors_kb', and test case is issuing 1m
ios with high concurrency.

Noted that there is a precondition for such performance problem:
There is a certain gap between bandwidth for single io with
bs=max_sectors_kb and disk upper limit.

During the test, I found that waitqueues can be extremly unbalanced on
heavy load. This is because 'wake_index' is not set properly in
__sbq_wake_up(), see details in patch 3.

Test environment:
arm64, 96 core with 200 BogoMIPS, test device is HDD. The default
'max_sectors_kb' is 1280(Sorry that I was unable to test on the machine
where 'max_sectors_kb' is 256).

The single io performance(randwrite):

| bs       | 128k | 256k | 512k | 1m   | 1280k | 2m   | 4m   |
| -------- | ---- | ---- | ---- | ---- | ----- | ---- | ---- |
| bw MiB/s | 20.1 | 33.4 | 51.8 | 67.1 | 74.7  | 82.9 | 82.9 |

It can be seen that 1280k io is already close to upper limit, and it'll
be hard to see differences with the default value, thus I set
'max_sectors_kb' to 128 in the following test.

Test cmd:
        fio \
        -filename=/dev/$dev \
        -name=test \
        -ioengine=psync \
        -allow_mounted_write=0 \
        -group_reporting \
        -direct=1 \
        -offset_increment=1g \
        -rw=randwrite \
        -bs=1024k \
        -numjobs={1,2,4,8,16,32,64,128,256,512} \
        -runtime=110 \
        -ramp_time=10

Test result: MiB/s

| numjobs | v5.18-rc1 | v5.18-rc1-patched |
| ------- | --------- | ----------------- |
| 1       | 67.7      | 67.7              |
| 2       | 67.7      | 67.7              |
| 4       | 67.7      | 67.7              |
| 8       | 67.7      | 67.7              |
| 16      | 64.8      | 65.6              |
| 32      | 59.8      | 63.8              |
| 64      | 54.9      | 59.4              |
| 128     | 49        | 56.9              |
| 256     | 37.7      | 58.3              |
| 512     | 31.8      | 57.9              |

Yu Kuai (8):
  sbitmap: record the number of waiters for each waitqueue
  blk-mq: call 'bt_wait_ptr()' later in blk_mq_get_tag()
  sbitmap: make sure waitqueues are balanced
  blk-mq: don't preempt tag under heavy load
  sbitmap: force tag preemption if free tags are sufficient
  blk-mq: force tag preemption for split bios
  blk-mq: record how many tags are needed for splited bio
  sbitmap: wake up the number of threads based on required tags

 block/blk-merge.c         |   8 +-
 block/blk-mq-tag.c        |  49 +++++++++----
 block/blk-mq.c            |  54 +++++++++++++-
 block/blk-mq.h            |   4 +
 include/linux/blk_types.h |   4 +
 include/linux/sbitmap.h   |   9 +++
 lib/sbitmap.c             | 149 +++++++++++++++++++++++++++-----------
 7 files changed, 216 insertions(+), 61 deletions(-)

-- 
2.31.1

