Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649D5822C7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiG0JH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiG0JGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152F47BB8;
        Wed, 27 Jul 2022 02:06:37 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt7Bg5Z86zmVH1;
        Wed, 27 Jul 2022 17:04:27 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:17 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:16 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [RFC v4 07/17] perf kwork: Add irq report support
Date:   Wed, 27 Jul 2022 17:03:20 +0800
Message-ID: <20220727090330.107760-8-yangjihong1@huawei.com>
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

Implements irq kwork report function.

Test cases:

  # perf kwork record -- sleep 10
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 6.134 MB perf.data ]

  # perf kwork report

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25            | 0000 |   1167.501 ms |     18284 |      1.096 ms |      44004.464905 s |      44004.466001 s |
    eth0:10                        | 0002 |      0.185 ms |         5 |      0.058 ms |      44005.012222 s |      44005.012280 s |
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork report -C 2

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    eth0:10                        | 0002 |      0.185 ms |         5 |      0.058 ms |      44005.012222 s |      44005.012280 s |
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork report -C 3

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork report -i perf.data

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25            | 0000 |   1167.501 ms |     18284 |      1.096 ms |      44004.464905 s |      44004.466001 s |
    eth0:10                        | 0002 |      0.185 ms |         5 |      0.058 ms |      44005.012222 s |      44005.012280 s |
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork report -s max,freq

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25            | 0000 |   1167.501 ms |     18284 |      1.096 ms |      44004.464905 s |      44004.466001 s |
    eth0:10                        | 0002 |      0.185 ms |         5 |      0.058 ms |      44005.012222 s |      44005.012280 s |
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork report -S

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25            | 0000 |   1167.501 ms |     18284 |      1.096 ms |      44004.464905 s |      44004.466001 s |
    eth0:10                        | 0002 |      0.185 ms |         5 |      0.058 ms |      44005.012222 s |      44005.012280 s |
   --------------------------------------------------------------------------------------------------------------------------------
    Total count            :     18289
    Total runtime   (msec) :  1167.686 (0.115% load average)
    Total time span (msec) : 10159.155
   --------------------------------------------------------------------------------------------------------------------------------

  # perf kwork report --time 44005,

    Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
   --------------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25            | 0000 |    402.173 ms |      4695 |      0.981 ms |      44007.831992 s |      44007.832973 s |
    eth0:10                        | 0002 |      0.089 ms |         2 |      0.058 ms |      44005.012222 s |      44005.012280 s |
   --------------------------------------------------------------------------------------------------------------------------------

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 42c905537e22..8b96113529dd 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -480,16 +480,79 @@ static int report_exit_event(struct perf_kwork *kwork,
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
+	if (kwork->tp_handler->entry_event) {
+		return kwork->tp_handler->entry_event(kwork, &kwork_irq,
+						      evsel, sample, machine);
+	}
+
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
+	if (kwork->tp_handler->exit_event) {
+		return kwork->tp_handler->exit_event(kwork, &kwork_irq,
+						     evsel, sample, machine);
+	}
+
+	return 0;
+}
+
 const struct evsel_str_handler irq_tp_handlers[] = {
-	{ "irq:irq_handler_entry", NULL, },
-	{ "irq:irq_handler_exit",  NULL, },
+	{ "irq:irq_handler_entry", process_irq_handler_entry_event, },
+	{ "irq:irq_handler_exit",  process_irq_handler_exit_event,  },
 };
 
+static int irq_class_init(struct kwork_class *class,
+			  struct perf_session *session)
+{
+	if (perf_session__set_tracepoints_handlers(session, irq_tp_handlers)) {
+		pr_err("Failed to set irq tracepoints handlers\n");
+		return -1;
+	}
+
+	class->work_root = RB_ROOT_CACHED;
+	return 0;
+}
+
+static void irq_work_init(struct kwork_class *class,
+			  struct kwork_work *work,
+			  struct evsel *evsel,
+			  struct perf_sample *sample,
+			  struct machine *machine __maybe_unused)
+{
+	work->class = class;
+	work->cpu = sample->cpu;
+	work->id = evsel__intval(evsel, sample, "irq");
+	work->name = evsel__strval(evsel, sample, "name");
+}
+
+static void irq_work_name(struct kwork_work *work, char *buf, int len)
+{
+	snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
+}
+
 static struct kwork_class kwork_irq = {
 	.name           = "irq",
 	.type           = KWORK_CLASS_IRQ,
 	.nr_tracepoints = 2,
 	.tp_handlers    = irq_tp_handlers,
+	.class_init     = irq_class_init,
+	.work_init      = irq_work_init,
+	.work_name      = irq_work_name,
 };
 
 const struct evsel_str_handler softirq_tp_handlers[] = {
-- 
2.30.GIT

