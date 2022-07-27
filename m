Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB05822C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiG0JHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiG0JGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76543329;
        Wed, 27 Jul 2022 02:06:28 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lt79R1b7Mz1M8JS;
        Wed, 27 Jul 2022 17:03:23 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:15 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:14 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <pc@us.ibm.com>, <yhs@fb.com>, <andrii.nakryiko@gmail.com>,
        <songliubraving@fb.com>, <yangjihong1@huawei.com>
Subject: [RFC v4 03/17] perf kwork: Add softirq kwork record support
Date:   Wed, 27 Jul 2022 17:03:16 +0800
Message-ID: <20220727090330.107760-4-yangjihong1@huawei.com>
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

Record softirq events irq:softirq_raise, irq:softirq_entry &
irq:softirq_exit.

Test cases:
Record all events:

  # perf kwork record -o perf_kwork.date -- sleep 1
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.897 MB perf_kwork.date ]
  #
  # perf evlist -i perf_kwork.date
  irq:irq_handler_entry
  irq:irq_handler_exit
  irq:softirq_raise
  irq:softirq_entry
  irq:softirq_exit
  dummy:HG
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events

Record softirq events:

  # perf kwork -k softirq record -o perf_kwork.date -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.141 MB perf_kwork.date ]
  #
  # perf evlist -i perf_kwork.date
  irq:softirq_raise
  irq:softirq_entry
  irq:softirq_exit
  dummy:HG
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Documentation/perf-kwork.txt |  2 +-
 tools/perf/builtin-kwork.c              | 16 +++++++++++++++-
 tools/perf/util/kwork.h                 |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 57bd5fa7d5c9..abfdeca2ad39 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 -k::
 --kwork::
-	List of kwork to profile (irq, etc)
+	List of kwork to profile (irq, softirq, etc)
 
 -v::
 --verbose::
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8c7ba0b96354..539e3f2ddc84 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -37,8 +37,22 @@ static struct kwork_class kwork_irq = {
 	.tp_handlers    = irq_tp_handlers,
 };
 
+const struct evsel_str_handler softirq_tp_handlers[] = {
+	{ "irq:softirq_raise", NULL, },
+	{ "irq:softirq_entry", NULL, },
+	{ "irq:softirq_exit",  NULL, },
+};
+
+static struct kwork_class kwork_softirq = {
+	.name           = "softirq",
+	.type           = KWORK_CLASS_SOFTIRQ,
+	.nr_tracepoints = 3,
+	.tp_handlers    = softirq_tp_handlers,
+};
+
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
 	[KWORK_CLASS_IRQ]       = &kwork_irq,
+	[KWORK_CLASS_SOFTIRQ]   = &kwork_softirq,
 };
 
 static void setup_event_list(struct perf_kwork *kwork,
@@ -147,7 +161,7 @@ int cmd_kwork(int argc, const char **argv)
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_STRING('k', "kwork", &kwork.event_list_str, "kwork",
-		   "list of kwork to profile (irq, etc)"),
+		   "list of kwork to profile (irq, softirq, etc)"),
 	OPT_BOOLEAN('f', "force", &kwork.force, "don't complain, do it"),
 	OPT_END()
 	};
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index f1d89cb058fc..669a81626cb4 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -14,6 +14,7 @@
 
 enum kwork_class_type {
 	KWORK_CLASS_IRQ,
+	KWORK_CLASS_SOFTIRQ,
 	KWORK_CLASS_MAX,
 };
 
-- 
2.30.GIT

