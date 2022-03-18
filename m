Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE9A4DD326
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 03:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiCRChf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 22:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiCRChc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:37:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38692B962A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:36:14 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKSkp0dF6zCqhq;
        Fri, 18 Mar 2022 10:34:10 +0800 (CST)
Received: from huawei.com (10.175.104.82) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:36:12 +0800
From:   Baisong Zhong <zhongbaisong@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <zhongbaisong@huawei.com>
Subject: [PATCH -next] sched/rt: fix build error when CONFIG_SYSCTL is disable
Date:   Fri, 18 Mar 2022 10:54:17 +0800
Message-ID: <20220318025417.3683430-1-zhongbaisong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid random build errors which do not select
CONFIG_SYSCTL by depending on it in Kconfig.

This fixes the following warning:

In file included from kernel/sched/build_policy.c:43:
At top level:
kernel/sched/rt.c:3017:12: error: ‘sched_rr_handler’ defined but not used [-Werror=unused-function]
 3017 | static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
      |            ^~~~~~~~~~~~~~~~
kernel/sched/rt.c:2978:12: error: ‘sched_rt_handler’ defined but not used [-Werror=unused-function]
 2978 | static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
      |            ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:310: kernel/sched/build_policy.o] Error 1
make[1]: *** [scripts/Makefile.build:638: kernel/sched] Error 2
make[1]: *** Waiting for unfinished jobs....

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
---
 kernel/sched/rt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 71791be36065..ee319581b1cd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -5,7 +5,6 @@
  */
 
 int sched_rr_timeslice = RR_TIMESLICE;
-static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 /* More than 4 hours if BW_SHIFT equals 20. */
 static const u64 max_rt_runtime = MAX_BW;
 
@@ -25,11 +24,12 @@ unsigned int sysctl_sched_rt_period = 1000000;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+#ifdef CONFIG_SYSCTL
+static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-#ifdef CONFIG_SYSCTL
 static struct ctl_table sched_rt_sysctls[] = {
 	{
 		.procname       = "sched_rt_period_us",
@@ -2911,6 +2911,7 @@ long sched_group_rt_period(struct task_group *tg)
 	return rt_period_us;
 }
 
+#ifdef CONFIG_SYSCTL
 static int sched_rt_global_constraints(void)
 {
 	int ret = 0;
@@ -2930,8 +2931,11 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 
 	return 1;
 }
+#endif /* CONFIG_SYSCTL */
 
 #else /* !CONFIG_RT_GROUP_SCHED */
+
+#ifdef CONFIG_SYSCTL
 static int sched_rt_global_constraints(void)
 {
 	unsigned long flags;
@@ -2949,8 +2953,10 @@ static int sched_rt_global_constraints(void)
 
 	return 0;
 }
+#endif /* CONFIG_SYSCTL */
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_SYSCTL
 static int sched_rt_global_validate(void)
 {
 	if (sysctl_sched_rt_period <= 0)
@@ -3035,6 +3041,7 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
 
 	return ret;
 }
+#endif /* CONFIG_SYSCTL */
 
 #ifdef CONFIG_SCHED_DEBUG
 void print_rt_stats(struct seq_file *m, int cpu)
-- 
2.25.1

