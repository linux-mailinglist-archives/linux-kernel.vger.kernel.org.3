Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D04583E35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiG1MCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiG1MBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:01:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2743691F0;
        Thu, 28 Jul 2022 05:01:43 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ltq2b1bgxzmVML;
        Thu, 28 Jul 2022 19:59:51 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:41 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Jul 2022 20:01:41 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <colin.i.king@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [PATCH 5/5] perf kwork: Add some {} for multiline for/if blocks
Date:   Thu, 28 Jul 2022 19:58:54 +0800
Message-ID: <20220728115854.80399-6-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220728115854.80399-1-yangjihong1@huawei.com>
References: <20220728115854.80399-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 47 ++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index d6c09044a929..b80f7279c4a8 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -177,9 +177,10 @@ static void setup_sorting(struct perf_kwork *kwork,
 
 	for (tok = strtok_r(str, ", ", &tmp);
 	     tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		if (sort_dimension__add(kwork, tok, &kwork->sort_list) < 0)
+		if (sort_dimension__add(kwork, tok, &kwork->sort_list) < 0) {
 			usage_with_options_msg(usage_msg, options,
 					       "Unknown --sort key: `%s'", tok);
+		}
 	}
 
 	pr_debug("Sort order: %s\n", kwork->sort_order);
@@ -656,8 +657,9 @@ static void timehist_print_event(struct perf_kwork *kwork,
 		work->class->work_name(work, kwork_name,
 				       PRINT_KWORK_NAME_WIDTH);
 		printf(" %-*s ", PRINT_KWORK_NAME_WIDTH, kwork_name);
-	} else
+	} else {
 		printf(" %-*s ", PRINT_KWORK_NAME_WIDTH, "");
+	}
 
 	/*
 	 *runtime
@@ -669,11 +671,12 @@ static void timehist_print_event(struct perf_kwork *kwork,
 	/*
 	 * delaytime
 	 */
-	if (atom->prev != NULL)
+	if (atom->prev != NULL) {
 		printf(" %*.*f ", PRINT_LATENCY_WIDTH, RPINT_DECIMAL_WIDTH,
 		       (double)(atom->time - atom->prev->time) / NSEC_PER_MSEC);
-	else
+	} else {
 		printf(" %*s ", PRINT_LATENCY_WIDTH, " ");
+	}
 
 	/*
 	 * callchain
@@ -761,9 +764,10 @@ static int process_irq_handler_entry_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->entry_event)
+	if (kwork->tp_handler->entry_event) {
 		return kwork->tp_handler->entry_event(kwork, &kwork_irq,
 						      evsel, sample, machine);
+	}
 	return 0;
 }
 
@@ -774,9 +778,10 @@ static int process_irq_handler_exit_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->exit_event)
+	if (kwork->tp_handler->exit_event) {
 		return kwork->tp_handler->exit_event(kwork, &kwork_irq,
 						     evsel, sample, machine);
+	}
 	return 0;
 }
 
@@ -832,10 +837,10 @@ static int process_softirq_raise_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->raise_event)
+	if (kwork->tp_handler->raise_event) {
 		return kwork->tp_handler->raise_event(kwork, &kwork_softirq,
 						      evsel, sample, machine);
-
+	}
 	return 0;
 }
 
@@ -846,10 +851,10 @@ static int process_softirq_entry_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->entry_event)
+	if (kwork->tp_handler->entry_event) {
 		return kwork->tp_handler->entry_event(kwork, &kwork_softirq,
 						      evsel, sample, machine);
-
+	}
 	return 0;
 }
 
@@ -860,10 +865,10 @@ static int process_softirq_exit_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->exit_event)
+	if (kwork->tp_handler->exit_event) {
 		return kwork->tp_handler->exit_event(kwork, &kwork_softirq,
 						     evsel, sample, machine);
-
+	}
 	return 0;
 }
 
@@ -953,10 +958,10 @@ static int process_workqueue_activate_work_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->raise_event)
+	if (kwork->tp_handler->raise_event) {
 		return kwork->tp_handler->raise_event(kwork, &kwork_workqueue,
 						    evsel, sample, machine);
-
+	}
 	return 0;
 }
 
@@ -967,10 +972,10 @@ static int process_workqueue_execute_start_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->entry_event)
+	if (kwork->tp_handler->entry_event) {
 		return kwork->tp_handler->entry_event(kwork, &kwork_workqueue,
 						    evsel, sample, machine);
-
+	}
 	return 0;
 }
 
@@ -981,10 +986,10 @@ static int process_workqueue_execute_end_event(struct perf_tool *tool,
 {
 	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
 
-	if (kwork->tp_handler->exit_event)
+	if (kwork->tp_handler->exit_event) {
 		return kwork->tp_handler->exit_event(kwork, &kwork_workqueue,
 						   evsel, sample, machine);
-
+	}
 	return 0;
 }
 
@@ -1253,9 +1258,10 @@ static void print_skipped_events(struct perf_kwork *kwork)
 		}
 	}
 
-	if (verbose > 0)
+	if (verbose > 0) {
 		printf("  INFO: use %lld atom pages\n",
 		       nr_list_entry(&kwork->atom_page_list));
+	}
 }
 
 static void print_bad_events(struct perf_kwork *kwork)
@@ -1332,10 +1338,11 @@ static int perf_kwork__check_config(struct perf_kwork *kwork,
 		return -1;
 	}
 
-	list_for_each_entry(class, &kwork->class_list, list)
+	list_for_each_entry(class, &kwork->class_list, list) {
 		if ((class->class_init != NULL) &&
 		    (class->class_init(class, session) != 0))
 			return -1;
+	}
 
 	if (kwork->cpu_list != NULL) {
 		ret = perf_session__cpu_bitmap(session,
-- 
2.30.GIT

