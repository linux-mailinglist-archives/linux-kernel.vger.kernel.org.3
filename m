Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B258D898
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiHIMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiHIMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:06:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90A13D3C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:06:22 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M2BXs1pVjzjXn6;
        Tue,  9 Aug 2022 20:03:09 +0800 (CST)
Received: from huawei.com (10.67.175.78) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 9 Aug
 2022 20:06:19 +0800
From:   Zhao Wenhui <zhaowenhui8@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <shanpeic@linux.alibaba.com>,
        <changhuaixin@linux.alibaba.com>, <tj@kernel.org>,
        <dtcccc@linux.alibaba.com>, <linux-kernel@vger.kernel.org>
CC:     <zhaowenhui8@huawei.com>, <zhaogongyi@huawei.com>
Subject: [PATCH] sched/fair: limit burst to zero when cfs bandwidth is toggled off
Date:   Tue, 9 Aug 2022 20:03:20 +0800
Message-ID: <20220809120320.19496-1-zhaowenhui8@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the quota value in CFS bandwidth is set to -1, that imples the
cfs bandwidth is toggled off. So the burst feature is supposed to
be disable as well.

Currently, when quota is -1, burst will not be check, so that it can be
set to almost arbitery value. Examples:
        mkdir /sys/fs/cgroup/cpu/test
        echo -1 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
        echo 10000000000000000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

Moreover, after the burst modified by this way, quota can't be set
to any value:
        echo 100000 > cpu.cfs_quota_us
        -bash: echo: write error: Invalid argument

This patch can ensure the burst value being zero and unalterable,
when quota is set to -1.

Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Zhao Wenhui <zhaowenhui8@huawei.com>
---
 kernel/sched/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0..4c1fc01d8c68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10584,6 +10584,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				     burst + quota > max_cfs_runtime))
 		return -EINVAL;
 
+	/*
+	 * Ensure burst equals to zero when quota is -1.
+	 */
+	if (quota == RUNTIME_INF && burst)
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
@@ -10643,8 +10649,10 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
 	burst = tg->cfs_bandwidth.burst;
-	if (cfs_quota_us < 0)
+	if (cfs_quota_us < 0) {
 		quota = RUNTIME_INF;
+		burst = 0;
+	}
 	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
 		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
 	else
-- 
2.17.1

