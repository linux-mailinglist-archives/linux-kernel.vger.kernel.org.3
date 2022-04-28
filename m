Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3655132E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbiD1L5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiD1L5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:57:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BA84EC0;
        Thu, 28 Apr 2022 04:54:28 -0700 (PDT)
Received: from kwepemi500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KpvCG5lvZz1JBfl;
        Thu, 28 Apr 2022 19:53:30 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 19:54:25 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 19:54:25 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <jack@suse.cz>, <paolo.valente@linaro.org>, <axboe@kernel.dk>,
        <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH -next v5 0/3] support concurrent sync io for bfq on a specail occasion
Date:   Thu, 28 Apr 2022 20:08:34 +0800
Message-ID: <20220428120837.3737765-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
 - rename bfq_add_busy_queues() to bfq_inc_busy_queues() in patch 1
 - fix wrong definition in patch 1
 - fix spelling mistake in patch 2: leaset -> least
 - update comments in patch 3
 - add reviewed-by tag in patch 2,3

Changes in v4:
 - split bfq_update_busy_queues() to bfq_add/dec_busy_queues(),
   suggested by Jan Kara.
 - remove unused 'in_groups_with_pending_reqs',

Changes in v3:
 - remove the cleanup patch that is irrelevant now(I'll post it
   separately).
 - instead of hacking wr queues and using weights tree insertion/removal,
   using bfq_add/del_bfqq_busy() to count the number of groups
   (suggested by Jan Kara).

Changes in v2:
 - Use a different approch to count root group, which is much simple.

Currently, bfq can't handle sync io concurrently as long as they
are not issued from root group. This is because
'bfqd->num_groups_with_pending_reqs > 0' is always true in
bfq_asymmetric_scenario().

The way that bfqg is counted into 'num_groups_with_pending_reqs':

Before this patchset:
 1) root group will never be counted.
 2) Count if bfqg or it's child bfqgs have pending requests.
 3) Don't count if bfqg and it's child bfqgs complete all the requests.

After this patchset:
 1) root group is counted.
 2) Count if bfqg have at least one bfqq that is marked busy.
 3) Don't count if bfqg doesn't have any busy bfqqs.

The main reason to use busy state of bfqq instead of 'pending requests'
is that bfqq can stay busy after dispatching the last request if idling
is needed for service guarantees.

With the above changes, concurrent sync io can be supported if only
one group is activated.

fio test script(startdelay is used to avoid queue merging):
[global]
filename=/dev/nvme0n1
allow_mounted_write=0
ioengine=psync
direct=1
ioscheduler=bfq
offset_increment=10g
group_reporting
rw=randwrite
bs=4k

[test1]
numjobs=1

[test2]
startdelay=1
numjobs=1

[test3]
startdelay=2
numjobs=1

[test4]
startdelay=3
numjobs=1

[test5]
startdelay=4
numjobs=1

[test6]
startdelay=5
numjobs=1

[test7]
startdelay=6
numjobs=1

[test8]
startdelay=7
numjobs=1

test result:
running fio on root cgroup
v5.18-rc1:	   550 Mib/s
v5.18-rc1-patched: 550 Mib/s

running fio on non-root cgroup
v5.18-rc1:	   349 Mib/s
v5.18-rc1-patched: 550 Mib/s

Note that I also test null_blk with "irqmode=2
completion_nsec=100000000(100ms) hw_queue_depth=1", and tests show
that service guarantees are still preserved.

Previous versions:
RFC: https://lore.kernel.org/all/20211127101132.486806-1-yukuai3@huawei.com/
v1: https://lore.kernel.org/all/20220305091205.4188398-1-yukuai3@huawei.com/
v2: https://lore.kernel.org/all/20220416093753.3054696-1-yukuai3@huawei.com/
v3: https://lore.kernel.org/all/20220427124722.48465-1-yukuai3@huawei.com/
v4: https://lore.kernel.org/all/20220428111907.3635820-1-yukuai3@huawei.com/

Yu Kuai (3):
  block, bfq: record how many queues are busy in bfq_group
  block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
  block, bfq: do not idle if only one group is activated

 block/bfq-cgroup.c  |  1 +
 block/bfq-iosched.c | 48 +++-----------------------------------
 block/bfq-iosched.h | 57 +++++++--------------------------------------
 block/bfq-wf2q.c    | 35 +++++++++++++++++-----------
 4 files changed, 35 insertions(+), 106 deletions(-)

-- 
2.31.1

