Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE651A2FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiEDPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351774AbiEDPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:06:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2464D3EBAD;
        Wed,  4 May 2022 08:02:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDABD1042;
        Wed,  4 May 2022 08:02:40 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9B4C3F885;
        Wed,  4 May 2022 08:02:38 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] perf cs_etm: Record ts_source in AUXTRACE_INFO for ETMv4 and ETE
Date:   Wed,  4 May 2022 16:02:14 +0100
Message-Id: <20220504150216.581281-4-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504150216.581281-1-german.gomez@arm.com>
References: <20220504150216.581281-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the value of ts_source exposed by the driver and store it in the
ETMv4 and ETE header. If the interface doesn't exist (such as in older
Kernels), defaults to a safe value of -1.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 46 +++++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.c          |  2 ++
 tools/perf/util/cs-etm.h          |  2 ++
 3 files changed, 50 insertions(+)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 4899eb549b4d..f063fece90c3 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -53,6 +53,7 @@ static const char * const metadata_etmv4_ro[] = {
 	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
 	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
 	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
+	[CS_ETMV4_TS_SOURCE]		= "ts_source",
 };
 
 static const char * const metadata_ete_ro[] = {
@@ -62,6 +63,7 @@ static const char * const metadata_ete_ro[] = {
 	[CS_ETE_TRCIDR8]		= "trcidr/trcidr8",
 	[CS_ETE_TRCAUTHSTATUS]		= "mgmt/trcauthstatus",
 	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch",
+	[CS_ETE_TS_SOURCE]		= "ts_source",
 };
 
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
@@ -612,6 +614,32 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
 	return val;
 }
 
+static int cs_etm_get_ro_signed(struct perf_pmu *pmu, int cpu, const char *path)
+{
+	char pmu_path[PATH_MAX];
+	int scan;
+	int val = 0;
+
+	/* Get RO metadata from sysfs */
+	snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
+
+	scan = perf_pmu__scan_file(pmu, pmu_path, "%d", &val);
+	if (scan != 1)
+		pr_err("%s: error reading: %s\n", __func__, pmu_path);
+
+	return val;
+}
+
+static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, int cpu, const char *path)
+{
+	char pmu_path[PATH_MAX];
+
+	/* Get RO metadata from sysfs */
+	snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
+
+	return perf_pmu__file_exists(pmu, pmu_path);
+}
+
 #define TRCDEVARCH_ARCHPART_SHIFT 0
 #define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
 #define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
@@ -653,6 +681,15 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 					       metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
 	data[CS_ETMV4_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
 						     metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
+
+	/* Kernels older than 5.19 may not expose ts_source */
+	if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]))
+		data[CS_ETMV4_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
+				metadata_etmv4_ro[CS_ETMV4_TS_SOURCE]);
+	else {
+		pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n", cpu);
+		data[CS_ETMV4_TS_SOURCE] = (__u64) -1;
+	}
 }
 
 static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, int cpu)
@@ -678,6 +715,15 @@ static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, in
 	/* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
 	data[CS_ETE_TRCDEVARCH] = cs_etm_get_ro(cs_etm_pmu, cpu,
 						metadata_ete_ro[CS_ETE_TRCDEVARCH]);
+
+	/* Kernels older than 5.19 may not expose ts_source */
+	if (cs_etm_pmu_path_exists(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TS_SOURCE]))
+		data[CS_ETE_TS_SOURCE] = (__u64) cs_etm_get_ro_signed(cs_etm_pmu, cpu,
+				metadata_ete_ro[CS_ETE_TS_SOURCE]);
+	else {
+		pr_warning("[%03d] pmu file 'ts_source' not found. Fallback to safe value (-1)\n", cpu);
+		data[CS_ETE_TS_SOURCE] = (__u64) -1;
+	}
 }
 
 static void cs_etm_get_metadata(int cpu, u32 *offset,
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5991a1a46b5c..e883ef6d9c75 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2537,6 +2537,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
 	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
+	[CS_ETMV4_TS_SOURCE] = "	TS_SOURCE		       %lld\n",
 };
 
 static const char * const cs_ete_priv_fmts[] = {
@@ -2551,6 +2552,7 @@ static const char * const cs_ete_priv_fmts[] = {
 	[CS_ETE_TRCIDR8]	= "	TRCIDR8			       %llx\n",
 	[CS_ETE_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
 	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n",
+	[CS_ETE_TS_SOURCE]	= "	TS_SOURCE                      %lld\n",
 };
 
 static const char * const param_unk_fmt =
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 817d068de98c..35b783178347 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -70,6 +70,7 @@ enum {
 	CS_ETMV4_TRCIDR2,
 	CS_ETMV4_TRCIDR8,
 	CS_ETMV4_TRCAUTHSTATUS,
+	CS_ETMV4_TS_SOURCE,
 	CS_ETMV4_PRIV_MAX,
 };
 
@@ -91,6 +92,7 @@ enum {
 	CS_ETE_TRCIDR8,
 	CS_ETE_TRCAUTHSTATUS,
 	CS_ETE_TRCDEVARCH,
+	CS_ETE_TS_SOURCE,
 	CS_ETE_PRIV_MAX
 };
 
-- 
2.25.1

