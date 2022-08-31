Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7666F5A84BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiHaRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHaRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:50:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA781AF11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:50:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x27-20020a25ac9b000000b0069140cfbbd9so2655271ybi.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=DV+gDUOPXsEDpKSEUMrteZ0JJtXsJvhmDLffo2hWpR8=;
        b=HBb+XvmRItArfa2t5gRHf8PcZ1GxONOZ475mZIhqV15S9MNKFUVIiybXVFMVncm9hy
         SamFWQCwqiU70VJ2JltGjOim0xPwkz80VlPOKbJAxiQ1WVYrNm6SXSGOJ4XQ6vHDEd/R
         po8Y0+m643ma3R85P6d41Ax67a11/2yjBmJuaVO/M6knVwv5motiuEctD+MzCmjkaDPO
         d1g+2EVSAsBC1KQ09LRFYCZ1K28n15tqvhg1nQbN2w+C5uyHSeG59ajSer2ytjROK8NY
         OyZ3oRgpsAyEZApj2PM4+z6L2nmCk1h3WxB1ApSxzcHd1AcV4p5bNnWSkV/V8eM9mqFW
         iC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=DV+gDUOPXsEDpKSEUMrteZ0JJtXsJvhmDLffo2hWpR8=;
        b=iNr1PHI3axaXrRSNrPJq+nnph2B2pbL55rcDa1tvNJR0BdIIWxhlq9r6VaR57xYDzC
         mzljcpZ8c7zJyZsnlspAme57qCmDfXSou6z0xJm7iqipEFyP27ETKzDIxsKtvjA2svTt
         MTeV0YQFVXmt/PMqHSXd3amsyKznHPBkAr067OvGSEF39byC/DS/syPUcB8T9IA6b1YU
         F8y389+0KVCxGEBeKqSOVTJf9QFrRI1lXmqQPsW+O9fZpknisifVMxs/82qKdax8KBmu
         U0RxyBN4YP/OGbOUT9ZghEtow9FGontk1b6zN/S13N8fDZV8yTq3z05qwCYQtrUTT2ED
         9I5A==
X-Gm-Message-State: ACgBeo1CpUsIQAyDPCUBcWdTPKiOAhI54cy8/5AwzbtQV5LxyXDSmo74
        pLCr/G+/EbSIVgV3xLI5fx2VcUxhowpI
X-Google-Smtp-Source: AA6agR7KHG0Q/Eku109go1TslC6JmYdAv6tQ1sws4sdXYpB85CQ5uLYs8ghrj+5NvhzsJTTbeRyiDeP2FiMq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a25:cf8b:0:b0:695:79fa:14c2 with SMTP id
 f133-20020a25cf8b000000b0069579fa14c2mr16824533ybg.636.1661968213868; Wed, 31
 Aug 2022 10:50:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:23 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-5-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 4/7] perf topology: Add core_wide
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
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

