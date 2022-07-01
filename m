Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D75562BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiGAGkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGAGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:40:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F87E48836;
        Thu, 30 Jun 2022 23:40:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32D5C1042;
        Thu, 30 Jun 2022 23:40:01 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 409A53F792;
        Thu, 30 Jun 2022 23:39:57 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/core: Add macros for possible sysctl_perf_event_paranoid values
Date:   Fri,  1 Jul 2022 12:09:49 +0530
Message-Id: <20220701063949.1769434-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysctl_perf_event_paranoid can have values from [-1, 0, 1, 2] which decides
on perf event restrictions for unprivileged users. But using them directly
makes it difficult to correlate exact restriction level they might impose.
This just adds macros for those numerical restriction values, making them
clear and improving readability.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf_event.h | 22 ++++++++++++++++++----
 kernel/events/core.c       |  9 +--------
 kernel/kallsyms.c          |  3 ++-
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index da759560eec5..78156b9154df 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1359,14 +1359,28 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
 #define PERF_SECURITY_KERNEL		2
 #define PERF_SECURITY_TRACEPOINT	3
 
+/*
+ * perf event paranoia level:
+ *  -1 - not paranoid at all
+ *   0 - disallow raw tracepoint access for unpriv
+ *   1 - disallow cpu events for unpriv
+ *   2 - disallow kernel profiling for unpriv
+ */
+enum {
+	PERF_EVENT_DISALLOW_NONE	= -1,
+	PERF_EVENT_DISALLOW_TRACE,
+	PERF_EVENT_DISALLOW_CPU,
+	PERF_EVENT_DISALLOW_KERNEL
+};
+
 static inline int perf_is_paranoid(void)
 {
-	return sysctl_perf_event_paranoid > -1;
+	return sysctl_perf_event_paranoid > PERF_EVENT_DISALLOW_NONE;
 }
 
 static inline int perf_allow_kernel(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+	if (sysctl_perf_event_paranoid >= PERF_EVENT_DISALLOW_KERNEL && !perfmon_capable())
 		return -EACCES;
 
 	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
@@ -1374,7 +1388,7 @@ static inline int perf_allow_kernel(struct perf_event_attr *attr)
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
+	if (sysctl_perf_event_paranoid >= PERF_EVENT_DISALLOW_CPU && !perfmon_capable())
 		return -EACCES;
 
 	return security_perf_event_open(attr, PERF_SECURITY_CPU);
@@ -1382,7 +1396,7 @@ static inline int perf_allow_cpu(struct perf_event_attr *attr)
 
 static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
 {
-	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
+	if (sysctl_perf_event_paranoid >= PERF_EVENT_DISALLOW_TRACE && !perfmon_capable())
 		return -EPERM;
 
 	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..6fdfdc731bab 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -408,14 +408,7 @@ static struct srcu_struct pmus_srcu;
 static cpumask_var_t perf_online_mask;
 static struct kmem_cache *perf_event_cache;
 
-/*
- * perf event paranoia level:
- *  -1 - not paranoid at all
- *   0 - disallow raw tracepoint access for unpriv
- *   1 - disallow cpu events for unpriv
- *   2 - disallow kernel profiling for unpriv
- */
-int sysctl_perf_event_paranoid __read_mostly = 2;
+int sysctl_perf_event_paranoid __read_mostly = PERF_EVENT_DISALLOW_KERNEL;
 
 /* Minimum for 512 kiB + 1 user control page */
 int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3279ac..705f7d7d81dc 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/kdb.h>
 #include <linux/err.h>
+#include <linux/perf_event.h>
 #include <linux/proc_fs.h>
 #include <linux/sched.h>	/* for cond_resched */
 #include <linux/ctype.h>
@@ -803,7 +804,7 @@ static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
 	extern int sysctl_perf_event_paranoid;
-	if (sysctl_perf_event_paranoid <= 1)
+	if (sysctl_perf_event_paranoid <= PERF_EVENT_DISALLOW_CPU)
 		return 1;
 #endif
 	return 0;
-- 
2.20.1

