Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F451548425
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiFMJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbiFMJtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:49:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10E1AD92;
        Mon, 13 Jun 2022 02:49:22 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM6F44VbNzjXfd;
        Mon, 13 Jun 2022 17:47:52 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:06 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:06 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 07/13] perf kwork: Add irq report support
Date:   Mon, 13 Jun 2022 17:45:59 +0800
Message-ID: <20220613094605.208401-8-yangjihong1@huawei.com>
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

Implements irq kwork report function.

test case:

  # perf kwork rep

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25       | 0000 |    429.202 ms |      7155 |      0.937 ms |    1906657.581035 s |    1906657.581973 s |
    eth0:10                   | 0002 |      0.136 ms |         5 |      0.045 ms |    1906656.302257 s |    1906656.302301 s |
   ---------------------------------------------------------------------------------------------------------------------------

  #
  # perf kwork rep -C 2

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    eth0:10                   | 0002 |      0.136 ms |         5 |      0.045 ms |    1906656.302257 s |    1906656.302301 s |
   ---------------------------------------------------------------------------------------------------------------------------

  # perf kwork rep -C 1,2

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    eth0:10                   | 0002 |      0.136 ms |         5 |      0.045 ms |    1906656.302257 s |    1906656.302301 s |
   ---------------------------------------------------------------------------------------------------------------------------

  # perf kwork rep -n eth0

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    eth0:10                   | 0002 |      0.136 ms |         5 |      0.045 ms |    1906656.302257 s |    1906656.302301 s |
   ---------------------------------------------------------------------------------------------------------------------------

  # perf kwork rep -S

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25       | 0000 |    429.202 ms |      7155 |      0.937 ms |    1906657.581035 s |    1906657.581973 s |
    eth0:10                   | 0002 |      0.136 ms |         5 |      0.045 ms |    1906656.302257 s |    1906656.302301 s |
   ---------------------------------------------------------------------------------------------------------------------------
    Total count            :      7160
    Total runtime   (msec) :   429.338 (0.142% load average)
    Total time span (msec) :  3013.347
   ---------------------------------------------------------------------------------------------------------------------------

  # perf kwork rep --time 1906657,

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25       | 0000 |    228.631 ms |      3855 |      0.937 ms |    1906657.581035 s |    1906657.581973 s |
    eth0:10                   | 0002 |      0.092 ms |         4 |      0.034 ms |    1906658.614010 s |    1906658.614043 s |
   ---------------------------------------------------------------------------------------------------------------------------

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 62 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index ec199942150f..5741a8ac3e41 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -639,15 +639,73 @@ static int report_exit_event(struct perf_kwork *kwork,
 	return 0;
 }
 
+static struct kwork_class kwork_irq;
+static int process_irq_handler_entry_event(struct perf_tool *tool,
+					   struct evsel *evsel,
+					   struct perf_sample *sample,
+					   struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->entry_event)
+		return kwork->tp_handler->entry_event(kwork, &kwork_irq,
+						      evsel, sample, machine);
+	return 0;
+}
+
+static int process_irq_handler_exit_event(struct perf_tool *tool,
+					  struct evsel *evsel,
+					  struct perf_sample *sample,
+					  struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->exit_event)
+		return kwork->tp_handler->exit_event(kwork, &kwork_irq,
+						     evsel, sample, machine);
+	return 0;
+}
+
 const struct evsel_str_handler irq_tp_handlers[] = {
-	{ "irq:irq_handler_entry", NULL, },
-	{ "irq:irq_handler_exit",  NULL, },
+	{ "irq:irq_handler_entry", process_irq_handler_entry_event, },
+	{ "irq:irq_handler_exit",  process_irq_handler_exit_event, },
 };
 
+static int irq_class_init(struct kwork_class *class,
+			  struct perf_session *session)
+{
+	if (perf_session__set_tracepoints_handlers(session, irq_tp_handlers)) {
+		pr_debug("Failed to set irq tracepoints handlers\n");
+		return -1;
+	}
+
+	class->cluster_root = RB_ROOT_CACHED;
+	return 0;
+}
+
+static void irq_cluster_init(struct kwork_class *class,
+			     struct kwork_cluster *cluster,
+			     struct evsel *evsel,
+			     struct perf_sample *sample)
+{
+	cluster->class = class;
+	cluster->cpu = sample->cpu;
+	cluster->id = evsel__intval(evsel, sample, "irq");
+	cluster->name = evsel__strval(evsel, sample, "name");
+}
+
+static void irq_cluster_name(struct kwork_cluster *cluster, char *buf, int len)
+{
+	snprintf(buf, len, "%s:%" PRIu64 "", cluster->name, cluster->id);
+}
+
 static struct kwork_class kwork_irq = {
 	.name           = "irq",
 	.nr_tracepoints = 2,
 	.tp_handlers    = irq_tp_handlers,
+	.class_init     = irq_class_init,
+	.cluster_init   = irq_cluster_init,
+	.cluster_name   = irq_cluster_name,
 };
 
 const struct evsel_str_handler softirq_tp_handlers[] = {
-- 
2.30.GIT

