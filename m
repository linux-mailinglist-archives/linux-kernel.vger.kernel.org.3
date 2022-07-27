Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39C5822CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiG0JIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiG0JGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED4474E6;
        Wed, 27 Jul 2022 02:06:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt7CC66hdzmVFH;
        Wed, 27 Jul 2022 17:04:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:18 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:17 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [RFC v4 09/17] perf kwork: Add workqueue report support
Date:   Wed, 27 Jul 2022 17:03:22 +0800
Message-ID: <20220727090330.107760-10-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220727090330.107760-1-yangjihong1@huawei.com>
References: <20220727090330.107760-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements workqueue report function.

Test cases:

  # perf kwork -k workqueue rep

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    (w)gc_worker                   | 0001 |   1912.389 ms |       173 |     12.896 ms |      44002.050787 s |      44002.063683 s |
    (w)mix_interrupt_randomness    | 0000 |     24.308 ms |       285 |      3.349 ms |      44004.784908 s |      44004.788257 s |
    (w)e1000_watchdog              | 0002 |      5.332 ms |         5 |      2.059 ms |      44000.914366 s |      44000.916424 s |
    (w)vmstat_update               | 0005 |      0.989 ms |         2 |      0.953 ms |      43997.986991 s |      43997.987944 s |
    (w)vmstat_shepherd             | 0000 |      0.964 ms |         8 |      0.195 ms |      43997.986453 s |      43997.986648 s |
    (w)vmstat_update               | 0003 |      0.306 ms |         6 |      0.077 ms |      44004.689543 s |      44004.689620 s |
    (w)vmstat_update               | 0000 |      0.196 ms |         5 |      0.049 ms |      44005.713732 s |      44005.713781 s |
    (w)vmstat_update               | 0001 |      0.162 ms |         2 |      0.130 ms |      44000.192034 s |      44000.192164 s |
    (w)mix_interrupt_randomness    | 0002 |      0.114 ms |         5 |      0.037 ms |      44005.012625 s |      44005.012662 s |
    (w)vmstat_update               | 0002 |      0.084 ms |         2 |      0.043 ms |      44004.817702 s |      44004.817745 s |
    (w)vmstat_update               | 0006 |      0.067 ms |         2 |      0.041 ms |      43997.987214 s |      43997.987254 s |
    (w)neigh_periodic_work         | 0004 |      0.039 ms |         1 |      0.039 ms |      43999.929935 s |      43999.929974 s |
    (w)vmstat_update               | 0007 |      0.037 ms |         1 |      0.037 ms |      43997.988969 s |      43997.989006 s |
    (w)neigh_managed_work          | 0001 |      0.036 ms |         1 |      0.036 ms |      43997.665813 s |      43997.665849 s |
    (w)neigh_managed_work          | 0004 |      0.036 ms |         1 |      0.036 ms |      44002.953507 s |      44002.953543 s |
    (w)vmstat_update               | 0004 |      0.027 ms |         1 |      0.027 ms |      43997.913973 s |      43997.914000 s |
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork -k workqueue rep -S

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    (w)gc_worker                   | 0001 |   1912.389 ms |       173 |     12.896 ms |      44002.050787 s |      44002.063683 s |
    (w)mix_interrupt_randomness    | 0000 |     24.308 ms |       285 |      3.349 ms |      44004.784908 s |      44004.788257 s |
    (w)e1000_watchdog              | 0002 |      5.332 ms |         5 |      2.059 ms |      44000.914366 s |      44000.916424 s |
    (w)vmstat_update               | 0005 |      0.989 ms |         2 |      0.953 ms |      43997.986991 s |      43997.987944 s |
    (w)vmstat_shepherd             | 0000 |      0.964 ms |         8 |      0.195 ms |      43997.986453 s |      43997.986648 s |
    (w)vmstat_update               | 0003 |      0.306 ms |         6 |      0.077 ms |      44004.689543 s |      44004.689620 s |
    (w)vmstat_update               | 0000 |      0.196 ms |         5 |      0.049 ms |      44005.713732 s |      44005.713781 s |
    (w)vmstat_update               | 0001 |      0.162 ms |         2 |      0.130 ms |      44000.192034 s |      44000.192164 s |
    (w)mix_interrupt_randomness    | 0002 |      0.114 ms |         5 |      0.037 ms |      44005.012625 s |      44005.012662 s |
    (w)vmstat_update               | 0002 |      0.084 ms |         2 |      0.043 ms |      44004.817702 s |      44004.817745 s |
    (w)vmstat_update               | 0006 |      0.067 ms |         2 |      0.041 ms |      43997.987214 s |      43997.987254 s |
    (w)neigh_periodic_work         | 0004 |      0.039 ms |         1 |      0.039 ms |      43999.929935 s |      43999.929974 s |
    (w)vmstat_update               | 0007 |      0.037 ms |         1 |      0.037 ms |      43997.988969 s |      43997.989006 s |
    (w)neigh_managed_work          | 0001 |      0.036 ms |         1 |      0.036 ms |      43997.665813 s |      43997.665849 s |
    (w)neigh_managed_work          | 0004 |      0.036 ms |         1 |      0.036 ms |      44002.953507 s |      44002.953543 s |
    (w)vmstat_update               | 0004 |      0.027 ms |         1 |      0.027 ms |      43997.913973 s |      43997.914000 s |
   --------------------------------------------------------------------------------------------------------------------------------
    Total count            :       500
    Total runtime   (msec) :  1945.085 (0.192% load average)
    Total time span (msec) : 10155.026
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork -k workqueue rep -n vmstat_update

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    (w)vmstat_update               | 0005 |      0.989 ms |         2 |      0.953 ms |      43997.986991 s |      43997.987944 s |
    (w)vmstat_update               | 0003 |      0.306 ms |         6 |      0.077 ms |      44004.689543 s |      44004.689620 s |
    (w)vmstat_update               | 0000 |      0.196 ms |         5 |      0.049 ms |      44005.713732 s |      44005.713781 s |
    (w)vmstat_update               | 0001 |      0.162 ms |         2 |      0.130 ms |      44000.192034 s |      44000.192164 s |
    (w)vmstat_update               | 0002 |      0.084 ms |         2 |      0.043 ms |      44004.817702 s |      44004.817745 s |
    (w)vmstat_update               | 0006 |      0.067 ms |         2 |      0.041 ms |      43997.987214 s |      43997.987254 s |
    (w)vmstat_update               | 0007 |      0.037 ms |         1 |      0.037 ms |      43997.988969 s |      43997.989006 s |
    (w)vmstat_update               | 0004 |      0.027 ms |         1 |      0.027 ms |      43997.913973 s |      43997.914000 s |
   --------------------------------------------------------------------------------------------------------------------------------

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c6e94d54ca36..0a9d28fc9e97 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -664,17 +664,89 @@ static struct kwork_class kwork_softirq = {
 	.work_name      = softirq_work_name,
 };
 
+static struct kwork_class kwork_workqueue;
+static int process_workqueue_execute_start_event(struct perf_tool *tool,
+						 struct evsel *evsel,
+						 struct perf_sample *sample,
+						 struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->entry_event) {
+		return kwork->tp_handler->entry_event(kwork, &kwork_workqueue,
+						    evsel, sample, machine);
+	}
+
+	return 0;
+}
+
+static int process_workqueue_execute_end_event(struct perf_tool *tool,
+					       struct evsel *evsel,
+					       struct perf_sample *sample,
+					       struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->exit_event) {
+		return kwork->tp_handler->exit_event(kwork, &kwork_workqueue,
+						   evsel, sample, machine);
+	}
+
+	return 0;
+}
+
 const struct evsel_str_handler workqueue_tp_handlers[] = {
 	{ "workqueue:workqueue_activate_work", NULL, },
-	{ "workqueue:workqueue_execute_start", NULL, },
-	{ "workqueue:workqueue_execute_end",   NULL, },
+	{ "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
+	{ "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event,   },
 };
 
+static int workqueue_class_init(struct kwork_class *class,
+				struct perf_session *session)
+{
+	if (perf_session__set_tracepoints_handlers(session,
+						   workqueue_tp_handlers)) {
+		pr_err("Failed to set workqueue tracepoints handlers\n");
+		return -1;
+	}
+
+	class->work_root = RB_ROOT_CACHED;
+	return 0;
+}
+
+static void workqueue_work_init(struct kwork_class *class,
+				struct kwork_work *work,
+				struct evsel *evsel,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	char *modp = NULL;
+	unsigned long long function_addr = evsel__intval(evsel,
+							 sample, "function");
+
+	work->class = class;
+	work->cpu = sample->cpu;
+	work->id = evsel__intval(evsel, sample, "work");
+	work->name = function_addr == 0 ? NULL :
+		machine__resolve_kernel_addr(machine, &function_addr, &modp);
+}
+
+static void workqueue_work_name(struct kwork_work *work, char *buf, int len)
+{
+	if (work->name != NULL)
+		snprintf(buf, len, "(w)%s", work->name);
+	else
+		snprintf(buf, len, "(w)0x%" PRIx64, work->id);
+}
+
 static struct kwork_class kwork_workqueue = {
 	.name           = "workqueue",
 	.type           = KWORK_CLASS_WORKQUEUE,
 	.nr_tracepoints = 3,
 	.tp_handlers    = workqueue_tp_handlers,
+	.class_init     = workqueue_class_init,
+	.work_init      = workqueue_work_init,
+	.work_name      = workqueue_work_name,
 };
 
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
-- 
2.30.GIT

