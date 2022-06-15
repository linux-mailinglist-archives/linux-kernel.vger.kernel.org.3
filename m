Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EEB54CC33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiFOPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiFOPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:07:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D0BE28;
        Wed, 15 Jun 2022 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655305668; x=1686841668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CXQFgUFtaJrmqb7dbdE8TtUh3d8InjWxzbzSrWOzXFg=;
  b=jicdFCU1THDmB2kmETTcLs6Xtsn3HA3EMDkqeCW4WMID3Kx7HwX/ThSc
   oeYC7Z7lxKtMTqUWWD3fPjp959ugaIVAaoSqsuL5Wtv4XIOjgt7Foqvuh
   AJterXlvPQabgTapmF0qe/S0V5aCZnuS55ufzlzZLh998Q3d3+reZQxep
   3NRmBaDOAQ8723XjW8n3wDGOcOkCvSmKLzIQpiJYHt5nuqTO4dWElg20f
   wgbULT4cuDNF4Xy1NiQRjpHbN83DC9SuxmM2jx2ATj1TUPOnPZvQJCsCs
   sY/GBiVLWCT2+M6h6PniVqWroP7r1uezOtWmdtYUNwfZTNEpWPs9sD7Qq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279039943"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279039943"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583248668"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2022 08:07:44 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH] perf record: Support "--cputype" option for hybrid events
Date:   Wed, 15 Jun 2022 23:08:23 +0800
Message-Id: <20220615150823.2230349-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

perf stat already has the "--cputype" option to enable events only on the
specified PMU for the hybrid platform, this commit extends the "--cputype"
support to perf record.

Without "--cputype", it reports events for both cpu_core and cpu_atom.

 # ./perf record  -e cycles -a sleep 1 | ./perf report

 # To display the perf.data header info, please use --header/--header-only options.
 #
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.000 MB (null) ]
 #
 # Total Lost Samples: 0
 #
 # Samples: 335  of event 'cpu_core/cycles/'
 # Event count (approx.): 35855267
 #
 # Overhead  Command          Shared Object      Symbol
 # ........  ...............  .................  .........................................
 #
     10.31%  swapper          [kernel.kallsyms]  [k] poll_idle
      9.42%  swapper          [kernel.kallsyms]  [k] menu_select
      ...    ...               ...               ... ...

 # Samples: 61  of event 'cpu_atom/cycles/'
 # Event count (approx.): 16453825
 #
 # Overhead  Command        Shared Object      Symbol
 # ........  .............  .................  ......................................
 #
     26.36%  snapd          [unknown]          [.] 0x0000563cc6d03841
      7.43%  migration/13   [kernel.kallsyms]  [k] update_sd_lb_stats.constprop.0
      ...    ...            ...                ... ...

With "--cputype", it reports events only for the specified PMU.

 # ./perf record --cputype core  -e cycles -a sleep 1 | ./perf report

 # To display the perf.data header info, please use --header/--header-only options.
 #
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.000 MB (null) ]
 #
 # Total Lost Samples: 0
 #
 # Samples: 221  of event 'cpu_core/cycles/'
 # Event count (approx.): 27121818
 #
 # Overhead  Command          Shared Object      Symbol
 # ........  ...............  .................  .........................................
 #
     11.24%  swapper          [kernel.kallsyms]  [k] e1000_irq_enable
      7.77%  swapper          [kernel.kallsyms]  [k] mwait_idle_with_hints.constprop.0
      ...    ...              ...                ... ...

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ++++
 tools/perf/builtin-record.c              |  3 +++
 tools/perf/builtin-stat.c                | 20 --------------------
 tools/perf/util/pmu-hybrid.c             | 19 +++++++++++++++++++
 tools/perf/util/pmu-hybrid.h             |  2 ++
 5 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cf8ad50f3de1..ba8d680da1ac 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -402,6 +402,10 @@ Enable weightened sampling. An additional weight is recorded per sample and can
 displayed with the weight and local_weight sort keys.  This currently works for TSX
 abort events and some memory events in precise mode on modern Intel CPUs.
 
+--cputype::
+Only enable events on applying cpu with this type for hybrid platform(e.g. core or atom).
+For non-hybrid events, it should be no effect.
+
 --namespaces::
 Record events of type PERF_RECORD_NAMESPACES.  This enables 'cgroup_id' sort key.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9a71f0330137..e1edd4e98358 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3183,6 +3183,9 @@ static struct option __record_options[] = {
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_BOOLEAN('q', "quiet", &quiet, "don't print any message"),
+	OPT_CALLBACK(0, "cputype", &record.evlist, "hybrid cpu type",
+		     "Only enable events on applying cpu with this type for hybrid platform (e.g. core or atom)",
+		     parse_hybrid_type),
 	OPT_BOOLEAN('s', "stat", &record.opts.inherit_stat,
 		    "per thread counts"),
 	OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ce87a8eb7d7..0d95b29273f4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1184,26 +1184,6 @@ static int parse_stat_cgroups(const struct option *opt,
 	return parse_cgroups(opt, str, unset);
 }
 
-static int parse_hybrid_type(const struct option *opt,
-			     const char *str,
-			     int unset __maybe_unused)
-{
-	struct evlist *evlist = *(struct evlist **)opt->value;
-
-	if (!list_empty(&evlist->core.entries)) {
-		fprintf(stderr, "Must define cputype before events/metrics\n");
-		return -1;
-	}
-
-	evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
-	if (!evlist->hybrid_pmu_name) {
-		fprintf(stderr, "--cputype %s is not supported!\n", str);
-		return -1;
-	}
-
-	return 0;
-}
-
 static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index f51ccaac60ee..5c490b5201b7 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -13,6 +13,7 @@
 #include <stdarg.h>
 #include <locale.h>
 #include <api/fs/fs.h>
+#include "util/evlist.h"
 #include "fncache.h"
 #include "pmu-hybrid.h"
 
@@ -87,3 +88,21 @@ char *perf_pmu__hybrid_type_to_pmu(const char *type)
 	free(pmu_name);
 	return NULL;
 }
+
+int parse_hybrid_type(const struct option *opt, const char *str, int unset __maybe_unused)
+{
+	struct evlist *evlist = *(struct evlist **)opt->value;
+
+	if (!list_empty(&evlist->core.entries)) {
+		fprintf(stderr, "Must define cputype before events/metrics\n");
+		return -1;
+	}
+
+	evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu(str);
+	if (!evlist->hybrid_pmu_name) {
+		fprintf(stderr, "--cputype %s is not supported!\n", str);
+		return -1;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 2b186c26a43e..26101f134a3a 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -5,6 +5,7 @@
 #include <linux/perf_event.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
+#include <subcmd/parse-options.h>
 #include <stdbool.h>
 #include "pmu.h"
 
@@ -18,6 +19,7 @@ bool perf_pmu__hybrid_mounted(const char *name);
 struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
 char *perf_pmu__hybrid_type_to_pmu(const char *type);
+int parse_hybrid_type(const struct option *opt, const char *str, int unset __maybe_unused);
 
 static inline int perf_pmu__hybrid_pmu_num(void)
 {
-- 
2.25.1

