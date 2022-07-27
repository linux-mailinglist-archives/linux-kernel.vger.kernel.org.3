Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C35822C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiG0JHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiG0JGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:06:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7747BB6;
        Wed, 27 Jul 2022 02:06:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt7Bh1QW8zmVFk;
        Wed, 27 Jul 2022 17:04:28 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 17:06:14 +0800
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
Subject: [RFC v4 02/17] perf kwork: Add irq kwork record support
Date:   Wed, 27 Jul 2022 17:03:15 +0800
Message-ID: <20220727090330.107760-3-yangjihong1@huawei.com>
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

Record interrupt events irq:irq_handler_entry & irq_handler_exit

Test cases:

 # perf kwork record -o perf_kwork.date -- sleep 1
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Captured and wrote 0.556 MB perf_kwork.date ]
  #
  # perf evlist -i perf_kwork.date
  irq:irq_handler_entry
  irq:irq_handler_exit
  dummy:HG
  # Tip: use 'perf evlist --trace-fields' to show fields for tracepoint events
  #

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Documentation/perf-kwork.txt |  2 +-
 tools/perf/builtin-kwork.c              | 15 ++++++++++++++-
 tools/perf/util/kwork.h                 |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index dc1e36da57bb..57bd5fa7d5c9 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 -k::
 --kwork::
-	List of kwork to profile
+	List of kwork to profile (irq, etc)
 
 -v::
 --verbose::
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index f3def74ddbd2..8c7ba0b96354 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -25,7 +25,20 @@
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 
+const struct evsel_str_handler irq_tp_handlers[] = {
+	{ "irq:irq_handler_entry", NULL, },
+	{ "irq:irq_handler_exit",  NULL, },
+};
+
+static struct kwork_class kwork_irq = {
+	.name           = "irq",
+	.type           = KWORK_CLASS_IRQ,
+	.nr_tracepoints = 2,
+	.tp_handlers    = irq_tp_handlers,
+};
+
 static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
+	[KWORK_CLASS_IRQ]       = &kwork_irq,
 };
 
 static void setup_event_list(struct perf_kwork *kwork,
@@ -134,7 +147,7 @@ int cmd_kwork(int argc, const char **argv)
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_STRING('k', "kwork", &kwork.event_list_str, "kwork",
-		   "list of kwork to profile"),
+		   "list of kwork to profile (irq, etc)"),
 	OPT_BOOLEAN('f', "force", &kwork.force, "don't complain, do it"),
 	OPT_END()
 	};
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 6950636aab2a..f1d89cb058fc 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -13,6 +13,7 @@
 #include <linux/bitmap.h>
 
 enum kwork_class_type {
+	KWORK_CLASS_IRQ,
 	KWORK_CLASS_MAX,
 };
 
-- 
2.30.GIT

