Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666CF5A68C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiH3QuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3Qtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:49:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC64FC59CC
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340ae84fb7dso151270487b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=DV+gDUOPXsEDpKSEUMrteZ0JJtXsJvhmDLffo2hWpR8=;
        b=FHB7PM2j7Xeb6mu0pXr6OabKqA+ucAkaLujSNh8phIUwCsHQ/Bx6cVqqzkC/bbQDc+
         zJg39zJWO3ca5WcRBFATR+1rxH7/BC/iYXV0UsOrgkYAE1hK8W6O2NyhP7jgqfpS2QtL
         0pzhYGvRsbWUxXcR3hyEqyawnT2qUxI3KfX8sfU3/9k+o1iAyrGSYkw+XY5KhJbr5iT8
         6HcJQlciQakfpYFGLW5kNXPmt7xguF/L0k9YlEmqDcGb+js73xZASRIeZMJ0ry/WRUEQ
         siNMSUGK/R15Np7WfDqyImSiDh3PHvrnMnoOFV7Pl9RAV4FOeX29rI0vp04Zu9WXOwD5
         rToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=DV+gDUOPXsEDpKSEUMrteZ0JJtXsJvhmDLffo2hWpR8=;
        b=PZvQKXB4OBGtcexynsniqU4nOWxD6w2pU+eaNY7pkbpJ8EClg0dXHia5v7WILETZvI
         TXUXoZn3S18eraL2RawJcacT3vOeOe4TpkhI8o7+o8c9VlKf3H91nXXUz4KIyXpbiWmN
         pBtk63ozMTMBEMa7KSw9ENBaXsbMiEYwyVez92NaoQxzHVTrV4flrE4+x+9UZgldCwLP
         PCgbxiWHViw3WzM9oj7mkN8r+ECtP053MFD283YAwzjJMvMWCiAteG9MNMCw8ClsyMIq
         CKILkToDLUJT+bhqI5VRrbFi1r+SPeMFRSQzFRglokGyxQJfEQqFg6qHbyy4JXKKpqcZ
         z/bw==
X-Gm-Message-State: ACgBeo3m4JZunTsQzKYwo64HE9J9n/rHeewp4hVHBezV292HT5w4AzNU
        TaarIiX6iYm1XdTWUnEVn3d4l3Ckmkfd
X-Google-Smtp-Source: AA6agR7wqSfk4V3dmq5v75RMPfe9d60+K2s+ywCgsnrfucZ88FHMG8JTsA+1F2a1F5BmMiDY/XMFKV9wml6b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a25:e6c1:0:b0:696:5017:2020 with SMTP id
 d184-20020a25e6c1000000b0069650172020mr11854378ybh.49.1661878170007; Tue, 30
 Aug 2022 09:49:30 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:43 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-6-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 5/8] perf topology: Add core_wide
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to optimize metrics when all SMT threads (CPUs) on a
core are measuring events in system wide mode. For example, TMA
metrics defines CORE_CLKS for Sandybrdige as:

if SMT is disabled:
  CPU_CLK_UNHALTED.THREAD
if SMT is enabled and recording on all SMT threads:
  CPU_CLK_UNHALTED.THREAD_ANY / 2
if SMT is enabled and not recording on all SMT threads:
  (CPU_CLK_UNHALTED.THREAD/2)*
  (1+CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE/CPU_CLK_UNHALTED.REF_XCLK )

That is two more events are necessary when not gathering counts on all
SMT threads. To distinguish all SMT threads on a core vs system wide
(all CPUs) call the new property core wide.  Add a core wide test that
determines the property from user requested CPUs, the topology and
system wide. System wide is required as other processes running on a
SMT thread will change the counts.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cputopo.c | 46 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cputopo.h |  3 +++
 tools/perf/util/smt.c     | 14 ++++++++++++
 tools/perf/util/smt.h     |  7 ++++++
 4 files changed, 70 insertions(+)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 511002e52714..1a3ff6449158 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -172,6 +172,52 @@ bool cpu_topology__smt_on(const struct cpu_topology *topology)
 	return false;
 }
 
+bool cpu_topology__core_wide(const struct cpu_topology *topology,
+			     const char *user_requested_cpu_list)
+{
+	struct perf_cpu_map *user_requested_cpus;
+
+	/*
+	 * If user_requested_cpu_list is empty then all CPUs are recorded and so
+	 * core_wide is true.
+	 */
+	if (!user_requested_cpu_list)
+		return true;
+
+	user_requested_cpus = perf_cpu_map__new(user_requested_cpu_list);
+	/* Check that every user requested CPU is the complete set of SMT threads on a core. */
+	for (u32 i = 0; i < topology->core_cpus_lists; i++) {
+		const char *core_cpu_list = topology->core_cpus_list[i];
+		struct perf_cpu_map *core_cpus = perf_cpu_map__new(core_cpu_list);
+		struct perf_cpu cpu;
+		int idx;
+		bool has_first, first = true;
+
+		perf_cpu_map__for_each_cpu(cpu, idx, core_cpus) {
+			if (first) {
+				has_first = perf_cpu_map__has(user_requested_cpus, cpu);
+				first = false;
+			} else {
+				/*
+				 * If the first core CPU is user requested then
+				 * all subsequent CPUs in the core must be user
+				 * requested too. If the first CPU isn't user
+				 * requested then none of the others must be
+				 * too.
+				 */
+				if (perf_cpu_map__has(user_requested_cpus, cpu) != has_first) {
+					perf_cpu_map__put(core_cpus);
+					perf_cpu_map__put(user_requested_cpus);
+					return false;
+				}
+			}
+		}
+		perf_cpu_map__put(core_cpus);
+	}
+	perf_cpu_map__put(user_requested_cpus);
+	return true;
+}
+
 static bool has_die_topology(void)
 {
 	char filename[MAXPATHLEN];
diff --git a/tools/perf/util/cputopo.h b/tools/perf/util/cputopo.h
index 469db775a13c..969e5920a00e 100644
--- a/tools/perf/util/cputopo.h
+++ b/tools/perf/util/cputopo.h
@@ -60,6 +60,9 @@ struct cpu_topology *cpu_topology__new(void);
 void cpu_topology__delete(struct cpu_topology *tp);
 /* Determine from the core list whether SMT was enabled. */
 bool cpu_topology__smt_on(const struct cpu_topology *topology);
+/* Are the sets of SMT siblings all enabled or all disabled in user_requested_cpus. */
+bool cpu_topology__core_wide(const struct cpu_topology *topology,
+			     const char *user_requested_cpu_list);
 
 struct numa_topology *numa_topology__new(void);
 void numa_topology__delete(struct numa_topology *tp);
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index ce90c4ee4138..994e9e418227 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -21,3 +21,17 @@ bool smt_on(const struct cpu_topology *topology)
 	cached = true;
 	return cached_result;
 }
+
+bool core_wide(bool system_wide, const char *user_requested_cpu_list,
+	       const struct cpu_topology *topology)
+{
+	/* If not everything running on a core is being recorded then we can't use core_wide. */
+	if (!system_wide)
+		return false;
+
+	/* Cheap case that SMT is disabled and therefore we're inherently core_wide. */
+	if (!smt_on(topology))
+		return true;
+
+	return cpu_topology__core_wide(topology, user_requested_cpu_list);
+}
diff --git a/tools/perf/util/smt.h b/tools/perf/util/smt.h
index e26999c6b8d4..ae9095f2c38c 100644
--- a/tools/perf/util/smt.h
+++ b/tools/perf/util/smt.h
@@ -7,4 +7,11 @@ struct cpu_topology;
 /* Returns true if SMT (aka hyperthreading) is enabled. */
 bool smt_on(const struct cpu_topology *topology);
 
+/*
+ * Returns true when system wide and all SMT threads for a core are in the
+ * user_requested_cpus map.
+ */
+bool core_wide(bool system_wide, const char *user_requested_cpu_list,
+	       const struct cpu_topology *topology);
+
 #endif /* __SMT_H */
-- 
2.37.2.672.g94769d06f0-goog

