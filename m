Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295C4BBBF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiBRPSH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 10:18:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBRPSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:18:06 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 353AA24F0F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:17:49 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-CPx7BDMGMSieQKvLJa3X6Q-1; Fri, 18 Feb 2022 10:17:44 -0500
X-MC-Unique: CPx7BDMGMSieQKvLJa3X6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0CB2F45;
        Fri, 18 Feb 2022 15:17:43 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B1FC7BD55;
        Fri, 18 Feb 2022 15:17:42 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/osnoise: Make osnoise_main to sleep for microseconds
Date:   Fri, 18 Feb 2022 16:17:38 +0100
Message-Id: <302aa6c7bdf2d131719b22901905e9da122a11b2.1645197336.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

osnoise's runtime and period are in the microseconds scale, but it is
currently sleeping in the millisecond's scale. This behavior roots in the
usage of hwlat as the skeleton for osnoise.

Make osnoise to sleep in the microseconds scale. Also, move the sleep to
a specialized function.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 53 ++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 870a08da5b48..cfddb30e65ab 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1436,6 +1436,37 @@ static int run_osnoise(void)
 static struct cpumask osnoise_cpumask;
 static struct cpumask save_cpumask;
 
+/*
+ * osnoise_sleep - sleep until the next period
+ */
+static void osnoise_sleep(void)
+{
+	u64 interval;
+	ktime_t wake_time;
+
+	mutex_lock(&interface_lock);
+	interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
+	mutex_unlock(&interface_lock);
+
+	/*
+	 * differently from hwlat_detector, the osnoise tracer can run
+	 * without a pause because preemption is on.
+	 */
+	if (!interval) {
+		/* Let synchronize_rcu_tasks() make progress */
+		cond_resched_tasks_rcu_qs();
+		return;
+	}
+
+	wake_time = ktime_add_us(ktime_get(), interval);
+	__set_current_state(TASK_INTERRUPTIBLE);
+
+	while (schedule_hrtimeout_range(&wake_time, 0, HRTIMER_MODE_ABS)) {
+		if (kthread_should_stop())
+			break;
+	}
+}
+
 /*
  * osnoise_main - The osnoise detection kernel thread
  *
@@ -1444,30 +1475,10 @@ static struct cpumask save_cpumask;
  */
 static int osnoise_main(void *data)
 {
-	u64 interval;
 
 	while (!kthread_should_stop()) {
-
 		run_osnoise();
-
-		mutex_lock(&interface_lock);
-		interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
-		mutex_unlock(&interface_lock);
-
-		do_div(interval, USEC_PER_MSEC);
-
-		/*
-		 * differently from hwlat_detector, the osnoise tracer can run
-		 * without a pause because preemption is on.
-		 */
-		if (interval < 1) {
-			/* Let synchronize_rcu_tasks() make progress */
-			cond_resched_tasks_rcu_qs();
-			continue;
-		}
-
-		if (msleep_interruptible(interval))
-			break;
+		osnoise_sleep();
 	}
 
 	return 0;
-- 
2.34.1

