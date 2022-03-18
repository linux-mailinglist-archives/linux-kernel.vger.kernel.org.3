Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F364DD6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiCRJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiCRJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:14:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724517485D;
        Fri, 18 Mar 2022 02:13:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKdYW30M7zfYrj;
        Fri, 18 Mar 2022 17:11:43 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 17:13:12 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>, <guohanjun@huawei.com>
Subject: [PATCH RESEND 2/2] perf tools: Enhance the matching of sub-commands
Date:   Fri, 18 Mar 2022 17:22:45 +0800
Message-ID: <20220318092245.2700489-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318092245.2700489-1-liwei391@huawei.com>
References: <20220318092245.2700489-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We support short command 'rec*' for 'record' and 'rep*' for 'report' in
lots of sub-commands, but the matching is not quite strict currnetly.

It may be puzzling sometime, like we mis-type a 'recport' to report but
it will perform 'record' in fact without any message.

To fix this, add a check to ensure that the short cmd is valid prefix
of the real command.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-c2c.c       | 5 +++--
 tools/perf/builtin-kmem.c      | 2 +-
 tools/perf/builtin-kvm.c       | 9 +++++----
 tools/perf/builtin-lock.c      | 5 +++--
 tools/perf/builtin-mem.c       | 5 +++--
 tools/perf/builtin-sched.c     | 4 ++--
 tools/perf/builtin-script.c    | 6 ++++--
 tools/perf/builtin-stat.c      | 4 ++--
 tools/perf/builtin-timechart.c | 3 ++-
 9 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 77dd4afacca4..8c5f106af46f 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -44,6 +44,7 @@
 #include "../perf.h"
 #include "pmu.h"
 #include "pmu-hybrid.h"
+#include "string2.h"
 
 struct c2c_hists {
 	struct hists		hists;
@@ -3025,9 +3026,9 @@ int cmd_c2c(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(c2c_usage, c2c_options);
 
-	if (!strncmp(argv[0], "rec", 3)) {
+	if (!strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0])) {
 		return perf_c2c__record(argc, argv);
-	} else if (!strncmp(argv[0], "rep", 3)) {
+	} else if (!strncmp(argv[0], "rep", 3) && strcmp_prefix("report", argv[0])) {
 		return perf_c2c__report(argc, argv);
 	} else {
 		usage_with_options(c2c_usage, c2c_options);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 99d7ff9a8eff..3358c73db43b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1946,7 +1946,7 @@ int cmd_kmem(int argc, const char **argv)
 			kmem_page = 1;
 	}
 
-	if (!strncmp(argv[0], "rec", 3)) {
+	if (!strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0])) {
 		symbol__init(NULL);
 		return __cmd_record(argc, argv);
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c6f352ee57e6..afdfc5931df6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -24,6 +24,7 @@
 #include "util/ordered-events.h"
 #include "util/kvm-stat.h"
 #include "ui/ui.h"
+#include "util/string2.h"
 
 #include <sys/prctl.h>
 #ifdef HAVE_TIMERFD_SUPPORT
@@ -1500,10 +1501,10 @@ static int kvm_cmd_stat(const char *file_name, int argc, const char **argv)
 		goto perf_stat;
 	}
 
-	if (!strncmp(argv[1], "rec", 3))
+	if (!strncmp(argv[1], "rec", 3) && strcmp_prefix("record", argv[1]))
 		return kvm_events_record(&kvm, argc - 1, argv + 1);
 
-	if (!strncmp(argv[1], "rep", 3))
+	if (!strncmp(argv[1], "rep", 3) && strcmp_prefix("report", argv[1]))
 		return kvm_events_report(&kvm, argc - 1 , argv + 1);
 
 #ifdef HAVE_TIMERFD_SUPPORT
@@ -1631,9 +1632,9 @@ int cmd_kvm(int argc, const char **argv)
 		}
 	}
 
-	if (!strncmp(argv[0], "rec", 3))
+	if (!strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0]))
 		return __cmd_record(file_name, argc, argv);
-	else if (!strncmp(argv[0], "rep", 3))
+	else if (!strncmp(argv[0], "rep", 3) && strcmp_prefix("report", argv[0]))
 		return __cmd_report(file_name, argc, argv);
 	else if (!strncmp(argv[0], "diff", 4))
 		return cmd_diff(argc, argv);
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d70131b7b1b1..7bf7662c6089 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -18,6 +18,7 @@
 #include "util/session.h"
 #include "util/tool.h"
 #include "util/data.h"
+#include "util/string2.h"
 
 #include <sys/types.h>
 #include <sys/prctl.h>
@@ -997,9 +998,9 @@ int cmd_lock(int argc, const char **argv)
 	if (!argc)
 		usage_with_options(lock_usage, lock_options);
 
-	if (!strncmp(argv[0], "rec", 3)) {
+	if (!strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0])) {
 		return __cmd_record(argc, argv);
-	} else if (!strncmp(argv[0], "report", 6)) {
+	} else if (!strncmp(argv[0], "rep", 3) && strcmp_prefix("report", argv[0])) {
 		trace_handler = &report_lock_ops;
 		if (argc) {
 			argc = parse_options(argc, argv,
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index fcf65a59bea2..ed0083d43e27 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -20,6 +20,7 @@
 #include "util/symbol.h"
 #include "util/pmu.h"
 #include "util/pmu-hybrid.h"
+#include "util/string2.h"
 #include <linux/err.h>
 
 #define MEM_OPERATION_LOAD	0x1
@@ -496,9 +497,9 @@ int cmd_mem(int argc, const char **argv)
 			mem.input_name = "perf.data";
 	}
 
-	if (!strncmp(argv[0], "rec", 3))
+	if (!strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0]))
 		return __cmd_record(argc, argv, &mem);
-	else if (!strncmp(argv[0], "rep", 3))
+	else if (!strncmp(argv[0], "rep", 3) && strcmp_prefix("report", argv[0]))
 		return report_events(argc, argv, &mem);
 	else
 		usage_with_options(mem_usage, mem_options);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 72d446de9c60..c4615ae07b5d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3561,7 +3561,7 @@ int cmd_sched(int argc, const char **argv)
 	if (!strcmp(argv[0], "script"))
 		return cmd_script(argc, argv);
 
-	if (!strncmp(argv[0], "rec", 3)) {
+	if (!strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0])) {
 		return __cmd_record(argc, argv);
 	} else if (!strncmp(argv[0], "lat", 3)) {
 		sched.tp_handler = &lat_ops;
@@ -3581,7 +3581,7 @@ int cmd_sched(int argc, const char **argv)
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
 		return perf_sched__map(&sched);
-	} else if (!strncmp(argv[0], "rep", 3)) {
+	} else if (!strncmp(argv[0], "rep", 3) && strcmp_prefix("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
 			argc = parse_options(argc, argv, replay_options, replay_usage, 0);
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 23bc0fb5a381..b800b4f5964b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3842,13 +3842,15 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__validate_sym_arguments())
 		return -1;
 
-	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec"))) {
+	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec")) &&
+		strcmp_prefix("record", argv[0])) {
 		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
 		if (!rec_script_path)
 			return cmd_record(argc, argv);
 	}
 
-	if (argc > 1 && !strncmp(argv[0], "rep", strlen("rep"))) {
+	if (argc > 1 && !strncmp(argv[0], "rep", strlen("rep")) &&
+		strcmp_prefix("report", argv[0])) {
 		rep_script_path = get_script_path(argv[1], REPORT_SUFFIX);
 		if (!rep_script_path) {
 			fprintf(stderr,
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f98689dd687..f0e19c93f3f8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2271,11 +2271,11 @@ int cmd_stat(int argc, const char **argv)
 	} else
 		stat_config.csv_sep = DEFAULT_SEPARATOR;
 
-	if (argc && !strncmp(argv[0], "rec", 3)) {
+	if (argc && !strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0])) {
 		argc = __cmd_record(argc, argv);
 		if (argc < 0)
 			return -1;
-	} else if (argc && !strncmp(argv[0], "rep", 3))
+	} else if (argc && !strncmp(argv[0], "rep", 3) && strcmp_prefix("report", argv[0]))
 		return __cmd_report(argc, argv);
 
 	interval = stat_config.interval;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 43bf4d67edb0..1b180cfcda74 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -35,6 +35,7 @@
 #include "util/tool.h"
 #include "util/data.h"
 #include "util/debug.h"
+#include "util/string2.h"
 #include <linux/err.h>
 
 #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
@@ -1983,7 +1984,7 @@ int cmd_timechart(int argc, const char **argv)
 		return -1;
 	}
 
-	if (argc && !strncmp(argv[0], "rec", 3)) {
+	if (argc && !strncmp(argv[0], "rec", 3) && strcmp_prefix("record", argv[0])) {
 		argc = parse_options(argc, argv, timechart_record_options,
 				     timechart_record_usage,
 				     PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.25.1

