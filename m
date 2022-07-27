Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3E5822CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiG0JIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiG0JGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC5547B98;
        Wed, 27 Jul 2022 02:06:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt7CC6ZYPzmVFs;
        Wed, 27 Jul 2022 17:04:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:19 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:19 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [RFC v4 12/17] perf kwork: Add workqueue latency support
Date:   Wed, 27 Jul 2022 17:03:25 +0800
Message-ID: <20220727090330.107760-13-yangjihong1@huawei.com>
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

Implements workqueue latency function.

Test cases:

  # perf kwork -k workqueue lat

    Kwork Name                     | Cpu  | Avg delay     | Count     | Max delay     | Max delay start     | Max delay end       |
   --------------------------------------------------------------------------------------------------------------------------------
    (w)vmstat_update               | 0001 |      5.004 ms |         1 |      5.004 ms |      44001.745646 s |      44001.750650 s |
    (w)vmstat_update               | 0006 |      1.773 ms |         1 |      1.773 ms |      44000.830840 s |      44000.832613 s |
    (w)vmstat_shepherd             | 0000 |      0.992 ms |         8 |      2.474 ms |      44007.717845 s |      44007.720318 s |
    (w)vmstat_update               | 0000 |      0.974 ms |         5 |      2.624 ms |      44004.785970 s |      44004.788594 s |
    (w)e1000_watchdog              | 0002 |      0.687 ms |         5 |      2.632 ms |      44005.009334 s |      44005.011966 s |
    (w)vmstat_update               | 0002 |      0.307 ms |         1 |      0.307 ms |      44004.817395 s |      44004.817702 s |
    (w)vmstat_update               | 0004 |      0.296 ms |         1 |      0.296 ms |      43997.913677 s |      43997.913973 s |
    (w)mix_interrupt_randomness    | 0000 |      0.283 ms |       285 |      3.724 ms |      44006.790889 s |      44006.794613 s |
    (w)neigh_managed_work          | 0001 |      0.271 ms |         1 |      0.271 ms |      43997.665542 s |      43997.665813 s |
    (w)vmstat_update               | 0005 |      0.261 ms |         1 |      0.261 ms |      44007.820542 s |      44007.820803 s |
    (w)neigh_managed_work          | 0004 |      0.220 ms |         1 |      0.220 ms |      44002.953287 s |      44002.953507 s |
    (w)neigh_periodic_work         | 0004 |      0.217 ms |         1 |      0.217 ms |      43999.929718 s |      43999.929935 s |
    (w)mix_interrupt_randomness    | 0002 |      0.199 ms |         5 |      0.310 ms |      44005.012316 s |      44005.012625 s |
    (w)vmstat_update               | 0003 |      0.199 ms |         4 |      0.307 ms |      44005.714391 s |      44005.714699 s |
    (w)gc_worker                   | 0001 |      0.071 ms |       173 |      1.128 ms |      44002.062579 s |      44002.063707 s |
   --------------------------------------------------------------------------------------------------------------------------------
    INFO: 0.020% skipped events (17 including 10 raise, 7 entry, 0 exit)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c7d66b0f7f68..245e4aae258e 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -775,6 +775,21 @@ static struct kwork_class kwork_softirq = {
 };
 
 static struct kwork_class kwork_workqueue;
+static int process_workqueue_activate_work_event(struct perf_tool *tool,
+						 struct evsel *evsel,
+						 struct perf_sample *sample,
+						 struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->raise_event) {
+		return kwork->tp_handler->raise_event(kwork, &kwork_workqueue,
+						    evsel, sample, machine);
+	}
+
+	return 0;
+}
+
 static int process_workqueue_execute_start_event(struct perf_tool *tool,
 						 struct evsel *evsel,
 						 struct perf_sample *sample,
@@ -806,7 +821,7 @@ static int process_workqueue_execute_end_event(struct perf_tool *tool,
 }
 
 const struct evsel_str_handler workqueue_tp_handlers[] = {
-	{ "workqueue:workqueue_activate_work", NULL, },
+	{ "workqueue:workqueue_activate_work", process_workqueue_activate_work_event, },
 	{ "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
 	{ "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event,   },
 };
-- 
2.30.GIT

