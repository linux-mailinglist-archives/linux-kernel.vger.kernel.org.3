Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758184B0952
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiBJJTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:19:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbiBJJTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:19:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496F10B3;
        Thu, 10 Feb 2022 01:19:41 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JvWPV1Sttz9sXd;
        Thu, 10 Feb 2022 17:18:06 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 17:19:24 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 17:19:24 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <axboe@kernel.dk>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yuyufen@huawei.com>, <guohanjun@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] blk-mq: avoid housekeeping CPUs scheduling a worker on a non-housekeeping CPU
Date:   Thu, 10 Feb 2022 17:35:32 +0800
Message-ID: <20220210093532.182818-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NOHZ_FULL is enabled, such as in HPC situation, CPUs are divided
into housekeeping CPUs and non-housekeeping CPUs. Non-housekeeping CPUs
are NOHZ_FULL CPUs and are often monopolized by the userspace process,
such HPC application process. Any sort of interruption is not expected.

blk_mq_hctx_next_cpu() selects each cpu in 'hctx->cpumask' alternately
to schedule the work thread blk_mq_run_work_fn(). When 'hctx->cpumask'
contains housekeeping CPU and non-housekeeping CPU at the same time, a
housekeeping CPU, which want to request a IO, may schedule a worker on a
non-housekeeping CPU. This may affect the performance of the userspace
application running on non-housekeeping CPUs.

So let's just schedule the worker thread on the current CPU when the
current CPU is housekeeping CPU.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 block/blk-mq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1adfe4824ef5..ff9a4bf16858 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -24,6 +24,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/isolation.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
@@ -2036,6 +2037,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
+	int work_cpu;
+
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 
@@ -2050,7 +2053,17 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		put_cpu();
 	}
 
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
+	/*
+	 * Avoid housekeeping CPUs scheduling a worker on a non-housekeeping
+	 * CPU
+	 */
+	if (tick_nohz_full_enabled() && housekeeping_cpu(smp_processor_id(),
+							 HK_FLAG_WQ))
+		work_cpu = smp_processor_id();
+	else
+		work_cpu = blk_mq_hctx_next_cpu(hctx);
+
+	kblockd_mod_delayed_work_on(work_cpu, &hctx->run_work,
 				    msecs_to_jiffies(msecs));
 }
 
-- 
2.20.1

