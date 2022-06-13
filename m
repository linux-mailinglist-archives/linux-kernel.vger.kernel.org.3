Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8B54842A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbiFMJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiFMJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870AD18B29;
        Mon, 13 Jun 2022 02:48:24 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6Cz11yNzjXf8;
        Mon, 13 Jun 2022 17:46:55 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:07 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 09/13] perf kwork: Add workqueue report support
Date:   Mon, 13 Jun 2022 17:46:01 +0800
Message-ID: <20220613094605.208401-10-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220613094605.208401-1-yangjihong1@huawei.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements workqueue report function.

test case:

  # perf kwork -k workqueue rep

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (w)0xffffffff83e09fa0     | 0001 |   2152.678 ms |       194 |     12.376 ms |    2059361.546621 s |    2059361.558997 s |
    (w)0xffff888332fea180     | 0000 |     17.125 ms |       301 |      1.018 ms |    2059358.441070 s |    2059358.442089 s |
    (w)0xffff8881035a83d8     | 0007 |      7.556 ms |         3 |      3.212 ms |    2059362.614643 s |    2059362.617855 s |
    (w)0xffff888102fc14a0     | 0002 |      7.080 ms |         5 |      1.962 ms |    2059365.421753 s |    2059365.423714 s |
    (w)0xffffffff82f7da00     | 0000 |      4.277 ms |         7 |      3.778 ms |    2059360.851063 s |    2059360.854841 s |
    (w)0xffffffff8305d680     | 0006 |      1.796 ms |         1 |      1.796 ms |    2059360.046818 s |    2059360.048613 s |
    (w)0xffff8883339e9040     | 0005 |      1.659 ms |         2 |      1.619 ms |    2059361.266051 s |    2059361.267670 s |
    (w)0xffff888333de9040     | 0007 |      1.121 ms |         5 |      0.783 ms |    2059368.238059 s |    2059368.238842 s |
    (w)0xffff888332fe9040     | 0000 |      0.990 ms |         4 |      0.911 ms |    2059359.604075 s |    2059359.604986 s |
    (w)0xffff8883331e9040     | 0001 |      0.244 ms |         6 |      0.046 ms |    2059362.689277 s |    2059362.689323 s |
    (w)0xffff888102e44400     | 0007 |      0.239 ms |         2 |      0.137 ms |    2059363.117537 s |    2059363.117674 s |
    (w)0xffff8883333ea180     | 0002 |      0.141 ms |         5 |      0.049 ms |    2059365.423784 s |    2059365.423833 s |
    (w)0xffffffff83062f28     | 0006 |      0.084 ms |         2 |      0.047 ms |    2059358.208033 s |    2059358.208080 s |
    (w)0xffffffff8305ca48     | 0003 |      0.078 ms |         2 |      0.041 ms |    2059361.071371 s |    2059361.071412 s |
    (w)0xffff8883337e9040     | 0004 |      0.062 ms |         1 |      0.062 ms |    2059362.605723 s |    2059362.605785 s |
    (w)0xffff8881035a81e8     | 0001 |      0.056 ms |         1 |      0.056 ms |    2059363.118231 s |    2059363.118287 s |
    (w)0xffff8883335e9040     | 0003 |      0.026 ms |         1 |      0.026 ms |    2059358.573397 s |    2059358.573423 s |
    (w)0xffffffff83062e70     | 0006 |      0.023 ms |         1 |      0.023 ms |    2059368.398864 s |    2059368.398888 s |
    (w)0xffffffff83e06480     | 0002 |      0.000 ms |         1 |      0.000 ms |    2059359.986792 s |    2059359.986792 s |
   ---------------------------------------------------------------------------------------------------------------------------

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 65 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 1eb416faf8ef..f27ffad223a3 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -813,16 +813,77 @@ static struct kwork_class kwork_softirq = {
 	.cluster_name   = softirq_cluster_name,
 };
 
+static struct kwork_class kwork_workqueue;
+static int process_workqueue_execute_start_event(struct perf_tool *tool,
+						 struct evsel *evsel,
+						 struct perf_sample *sample,
+						 struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->entry_event)
+		return kwork->tp_handler->entry_event(kwork, &kwork_workqueue,
+						    evsel, sample, machine);
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
+	if (kwork->tp_handler->exit_event)
+		return kwork->tp_handler->exit_event(kwork, &kwork_workqueue,
+						   evsel, sample, machine);
+
+	return 0;
+}
+
 const struct evsel_str_handler workqueue_tp_handlers[] = {
 	{ "workqueue:workqueue_activate_work", NULL, },
-	{ "workqueue:workqueue_execute_start", NULL, },
-	{ "workqueue:workqueue_execute_end",   NULL, },
+	{ "workqueue:workqueue_execute_start", process_workqueue_execute_start_event, },
+	{ "workqueue:workqueue_execute_end",   process_workqueue_execute_end_event, },
 };
 
+static int workqueue_class_init(struct kwork_class *class,
+				struct perf_session *session)
+{
+	if (perf_session__set_tracepoints_handlers(session,
+						   workqueue_tp_handlers)) {
+		pr_debug("Failed to set workqueue tracepoints handlers\n");
+		return -1;
+	}
+
+	class->cluster_root = RB_ROOT_CACHED;
+	return 0;
+}
+
+static void workqueue_cluster_init(struct kwork_class *class,
+				   struct kwork_cluster *cluster,
+				   struct evsel *evsel,
+				   struct perf_sample *sample)
+{
+	cluster->name = NULL;
+	cluster->class = class;
+	cluster->cpu = sample->cpu;
+	cluster->id = evsel__intval(evsel, sample, "work");
+}
+
+static void workqueue_cluster_name(struct kwork_cluster *cluster, char *buf, int len)
+{
+	snprintf(buf, len, "(w)0x%" PRIx64, cluster->id);
+}
+
 static struct kwork_class kwork_workqueue = {
 	.name           = "workqueue",
 	.nr_tracepoints = 3,
 	.tp_handlers    = workqueue_tp_handlers,
+	.class_init     = workqueue_class_init,
+	.cluster_init   = workqueue_cluster_init,
+	.cluster_name   = workqueue_cluster_name,
 };
 
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
-- 
2.30.GIT

