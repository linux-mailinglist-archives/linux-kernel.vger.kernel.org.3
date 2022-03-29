Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406F54EAA7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiC2J1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiC2J1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:27:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C756972D2;
        Tue, 29 Mar 2022 02:25:58 -0700 (PDT)
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSPJy2JB2zfZcm;
        Tue, 29 Mar 2022 17:24:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 17:25:56 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 17:25:55 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <andriy.shevchenko@linux.intel.com>,
        <john.garry@huawei.com>, <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next RFC 0/6] improve large random io for HDD
Date:   Tue, 29 Mar 2022 17:40:42 +0800
Message-ID: <20220329094048.2107094-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

There is a defect for blk-mq compare to blk-sq, specifically split io
will end up discontinuous if the device is under high io pressure, while
split io will still be continuous in sq, this is because:

1) split bio is issued one by one, if one bio can't get tag, it will go
to wail. - patch 2
2) each time 8(or wake batch) requests is done, 8 waiters will be woken up.
Thus if a thread is woken up, it will unlikey to get multiple tags.
- patch 3,4
3) new io can preempt tag even if there are lots of threads waiting for
tags. - patch 5

Test environment:
x86 vm, nr_requests is set to 64, queue_depth is set to 32 and
max_sectors_kb is set to 128.

I haven't tested this patchset on physical machine yet, I'll try later
if anyone thinks this approch is meaningful.

Fio test cmd:
[global]
filename=/dev/sda
ioengine=libaio
direct=1
offset_increment=100m

[test]
rw=randwrite
bs=512k
numjobs=256
iodepth=2

Result: raito of sequential io(calculated from log by blktrace)
original:
21%
patched: split io thoroughly and wake up based on required tags.
40%
patched and set flag: disable tag preemption.
69%

Yu Kuai (6):
  blk-mq: add a new flag 'BLK_MQ_F_NO_TAG_PREEMPTION'
  block: refactor to split bio thoroughly
  blk-mq: record how many tags are needed for splited bio
  sbitmap: wake up the number of threads based on required tags
  blk-mq: don't preempt tag expect for split bios
  sbitmap: force tag preemption if free tags are sufficient

 block/bio.c               |  2 +
 block/blk-merge.c         | 95 ++++++++++++++++++++++++++++-----------
 block/blk-mq-debugfs.c    |  1 +
 block/blk-mq-tag.c        | 39 +++++++++++-----
 block/blk-mq.c            | 14 +++++-
 block/blk-mq.h            |  7 +++
 block/blk.h               |  3 +-
 include/linux/blk-mq.h    |  7 ++-
 include/linux/blk_types.h |  6 +++
 include/linux/sbitmap.h   |  8 ++++
 lib/sbitmap.c             | 33 +++++++++++++-
 11 files changed, 173 insertions(+), 42 deletions(-)

-- 
2.31.1

