Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D77251A2FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351813AbiEDPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351765AbiEDPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:06:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40D9F36320;
        Wed,  4 May 2022 08:02:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10EB213D5;
        Wed,  4 May 2022 08:02:37 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F148B3F885;
        Wed,  4 May 2022 08:02:34 -0700 (PDT)
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
Subject: [PATCH 2/4] perf cs_etm: Keep separate symbols for ETMv4 and ETE parameters
Date:   Wed,  4 May 2022 16:02:13 +0100
Message-Id: <20220504150216.581281-3-german.gomez@arm.com>
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

Previously, adding a new parameter at the end of ETMv4 meant adding it
somewhere in the middle of ETE, which is not supported by the current
header version.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 43 +++++++++++++++++++++++++-----
 tools/perf/util/cs-etm.c          | 44 +++++++++++++++++++++----------
 tools/perf/util/cs-etm.h          | 11 +++++++-
 3 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 11c71aa219f7..4899eb549b4d 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -53,7 +53,15 @@ static const char * const metadata_etmv4_ro[] = {
 	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
 	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
 	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
-	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch"
+};
+
+static const char * const metadata_ete_ro[] = {
+	[CS_ETE_TRCIDR0]		= "trcidr/trcidr0",
+	[CS_ETE_TRCIDR1]		= "trcidr/trcidr1",
+	[CS_ETE_TRCIDR2]		= "trcidr/trcidr2",
+	[CS_ETE_TRCIDR8]		= "trcidr/trcidr8",
+	[CS_ETE_TRCAUTHSTATUS]		= "mgmt/trcauthstatus",
+	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch",
 };
 
 static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
@@ -616,7 +624,7 @@ static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu)
 {
 	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
-	int trcdevarch = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
+	int trcdevarch = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_ete_ro[CS_ETE_TRCDEVARCH]);
 
 	/*
 	 * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
@@ -647,6 +655,31 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 						     metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
 }
 
+static void cs_etm_save_ete_header(__u64 data[], struct auxtrace_record *itr, int cpu)
+{
+	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+
+	/* Get trace configuration register */
+	data[CS_ETE_TRCCONFIGR] = cs_etmv4_get_config(itr);
+	/* Get traceID from the framework */
+	data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* Get read-only information from sysFS */
+	data[CS_ETE_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					     metadata_ete_ro[CS_ETE_TRCIDR0]);
+	data[CS_ETE_TRCIDR1] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					     metadata_ete_ro[CS_ETE_TRCIDR1]);
+	data[CS_ETE_TRCIDR2] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					     metadata_ete_ro[CS_ETE_TRCIDR2]);
+	data[CS_ETE_TRCIDR8] = cs_etm_get_ro(cs_etm_pmu, cpu,
+					     metadata_ete_ro[CS_ETE_TRCIDR8]);
+	data[CS_ETE_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
+						   metadata_ete_ro[CS_ETE_TRCAUTHSTATUS]);
+	/* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
+	data[CS_ETE_TRCDEVARCH] = cs_etm_get_ro(cs_etm_pmu, cpu,
+						metadata_ete_ro[CS_ETE_TRCDEVARCH]);
+}
+
 static void cs_etm_get_metadata(int cpu, u32 *offset,
 				struct auxtrace_record *itr,
 				struct perf_record_auxtrace_info *info)
@@ -660,11 +693,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 	/* first see what kind of tracer this cpu is affined to */
 	if (cs_etm_is_ete(itr, cpu)) {
 		magic = __perf_cs_ete_magic;
-		/* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
-		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
-		info->priv[*offset + CS_ETE_TRCDEVARCH] =
-			cs_etm_get_ro(cs_etm_pmu, cpu,
-				      metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
+		cs_etm_save_ete_header(&info->priv[*offset], itr, cpu);
 
 		/* How much space was used */
 		increment = CS_ETE_PRIV_MAX;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b95fb3c4d7b..5991a1a46b5c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -464,12 +464,12 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
 	u64 **metadata = etm->metadata;
 
 	t_params[idx].protocol = CS_ETM_PROTO_ETE;
-	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
-	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
-	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
-	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
-	t_params[idx].ete.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
-	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETE_TRCIDR0];
+	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETE_TRCIDR1];
+	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETE_TRCIDR2];
+	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETE_TRCIDR8];
+	t_params[idx].ete.reg_configr = metadata[idx][CS_ETE_TRCCONFIGR];
+	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETE_TRCTRACEIDR];
 	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
 }
 
@@ -2537,7 +2537,20 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCIDR2]	= "	TRCIDR2			       %llx\n",
 	[CS_ETMV4_TRCIDR8]	= "	TRCIDR8			       %llx\n",
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
-	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n"
+};
+
+static const char * const cs_ete_priv_fmts[] = {
+	[CS_ETM_MAGIC]		= "	Magic number		       %llx\n",
+	[CS_ETM_CPU]		= "	CPU			       %lld\n",
+	[CS_ETM_NR_TRC_PARAMS]	= "	NR_TRC_PARAMS		       %llx\n",
+	[CS_ETE_TRCCONFIGR]	= "	TRCCONFIGR		       %llx\n",
+	[CS_ETE_TRCTRACEIDR]	= "	TRCTRACEIDR		       %llx\n",
+	[CS_ETE_TRCIDR0]	= "	TRCIDR0			       %llx\n",
+	[CS_ETE_TRCIDR1]	= "	TRCIDR1			       %llx\n",
+	[CS_ETE_TRCIDR2]	= "	TRCIDR2			       %llx\n",
+	[CS_ETE_TRCIDR8]	= "	TRCIDR8			       %llx\n",
+	[CS_ETE_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
+	[CS_ETE_TRCDEVARCH]	= "	TRCDEVARCH                     %llx\n",
 };
 
 static const char * const param_unk_fmt =
@@ -2597,19 +2610,22 @@ static int cs_etm__print_cpu_metadata_v1(__u64 *val, int *offset)
 			else
 				fprintf(stdout, cs_etm_priv_fmts[j], val[i]);
 		}
-	} else if (magic == __perf_cs_etmv4_magic || magic == __perf_cs_ete_magic) {
-		/*
-		 * ETE and ETMv4 can be printed in the same block because the number of parameters
-		 * is saved and they share the list of parameter names. ETE is also only supported
-		 * in V1 files.
-		 */
+	} else if (magic == __perf_cs_etmv4_magic) {
 		for (j = 0; j < total_params; j++, i++) {
 			/* if newer record - could be excess params */
-			if (j >= CS_ETE_PRIV_MAX)
+			if (j >= CS_ETMV4_PRIV_MAX)
 				fprintf(stdout, param_unk_fmt, j, val[i]);
 			else
 				fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
 		}
+	} else if (magic == __perf_cs_ete_magic) {
+		for (j = 0; j < total_params; j++, i++) {
+			/* if newer record - could be excess params */
+			if (j >= CS_ETE_PRIV_MAX)
+				fprintf(stdout, param_unk_fmt, j, val[i]);
+			else
+				fprintf(stdout, cs_ete_priv_fmts[j], val[i]);
+		}
 	} else {
 		/* failure - note bad magic value and error out */
 		fprintf(stdout, magic_unk_fmt, magic);
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 90c83f932d9a..817d068de98c 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -81,7 +81,16 @@ enum {
  * added in header V1
  */
 enum {
-	CS_ETE_TRCDEVARCH = CS_ETMV4_PRIV_MAX,
+	/* Dynamic, configurable parameters */
+	CS_ETE_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
+	CS_ETE_TRCTRACEIDR,
+	/* RO, taken from sysFS */
+	CS_ETE_TRCIDR0,
+	CS_ETE_TRCIDR1,
+	CS_ETE_TRCIDR2,
+	CS_ETE_TRCIDR8,
+	CS_ETE_TRCAUTHSTATUS,
+	CS_ETE_TRCDEVARCH,
 	CS_ETE_PRIV_MAX
 };
 
-- 
2.25.1

