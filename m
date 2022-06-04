Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A753D592
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350597AbiFDErj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350572AbiFDEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:47:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5331DFB3;
        Fri,  3 Jun 2022 21:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9y7D+evArDkkQcA9mOzzz3v+FblXsDlabK97Iseeeo3ePGeE5uYo7QEd9ddBUigCdr/Z+Zp/EsMWKMf80U1GiSn/ZWT6KZhJOSkB6gGvlsHEZWA/2ZW5h74v27vtc8GRRH89XrAFPrsRAJvYNxpyHPcwHm6+tBtN9iGsDBfJ3zzdkFHtOz6KtqZEKrYVGORAPIuJtybVQ+El3Edu6SDxpudiIhFC7Im8uhQEVpB1hCXtQz47CUaHQSLGIrXPqioU3ojZ+keEjGddcn/R8TBc6fQn978QMv6UoUwACyBRxwN8dF37B/pyCiZRK2bwPNRXKZCQWm331Zod7hFLjJvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IwA8vTZV9U7taiAHROvHWrJKQ/simeSszre+1aLhw0=;
 b=YayGeRFuBQniy+IekAQggSGQ9UMquqn0s0BBbZfJ/BJGlLE+vDAVBmA11GciWQhHl00jVunJToxj4UtF1lakT96W/h/GbHMUcu+mamInjh6qwdwL0OKnj8zyZlC3qCfEtXkRtPVwX2KMvQVTRAI6hXTv1Iavj3BGh4FJqyH7h07u1d6MomrfTJHfXnNpw9wxMDOhbChO3FVlZPGj3VRAw1llEmbXfEB1gfnRdhWsKZZzfjqyR6SOQ1sat//DSxWOOqQGs9tCP6SuR0wgJD0t+Q3svvE02ivw+rSNEjxC540EBCiyWX4EOoF/n3f0zBEuGpGxfyxATpb8kYGtzP4SRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IwA8vTZV9U7taiAHROvHWrJKQ/simeSszre+1aLhw0=;
 b=eoZwQTvxAqclU2YeHkUtLUZ3asIN8esy5NHnr7o/yZwYi2AdkFunRCFUhljivFEmiaUGQxOzMTrSO7RFB36Yu9iBXS82y8cTvdfIAtObtIVBuoH0X0iNTE5gUoXCskq1b+SKrwFg/yyUXs+fqFdFmJ+t6Xg9adFyiGrDlOSrN2w=
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Sat, 4 Jun
 2022 04:47:23 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::5f) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Sat, 4 Jun 2022 04:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:47:22 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:47:10 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kan.liang@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <james.clark@arm.com>, <leo.yan@linaro.org>, <ak@linux.intel.com>,
        <eranian@google.com>, <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v6 5/8] perf headers: Record non-cpu pmu capabilities
Date:   Sat, 4 Jun 2022 10:15:16 +0530
Message-ID: <20220604044519.594-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604044519.594-1-ravi.bangoria@amd.com>
References: <20220604044519.594-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 868e6c06-5d55-4483-4e17-08da45e5509c
X-MS-TrafficTypeDiagnostic: DM4PR12MB6182:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6182D234E74E1462650D31DBE0A09@DM4PR12MB6182.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWcpVoeoVnwdXUqSSASq2/mxC07JrhMgZ7TOOrQPC7oF5GglA29Q2HOZQ0tdwIdQPOsP8qVhW7MUDVapb9gUf95pfHVykW6F2wOkMJtIgxFwPiENG3TRZ4KglJgl4+kI7+yUB7Ccisdh9R1OImGsIRF03wImLBKpFDzMO1ItxTYJi3oznFERWp/mlLfZfHRM4c4MvXjhbxxaZ5I75t99N18hiQdsCTAFjOcsneq17zI81CoPzcvDJuNyaJ5jmjmZJGsG55+lnDbcw9sJS3UaAU6xcdT8m95/Fg5LfZrciTXMPksGYufNsuXdn8waomaNLGJrV9gwWTm8+hvYkyaTBDpJc2ghQ0VmTZ0UDCwwR64qRDfQCxttsm5GalHU/xsGZk5xqwHJDjm3YISgoEE8jawImw69q7rbrTA5VLigFNSLSWbk4rm+4auWqNMlHoNm3d6ZyJKkb9731KE0UP+8EaYS2Y/Q3bjFBIyKzCdiclWUeD/OpIcn34MDdak4V2mn9J2knrpclR8qTmDGSb47pbXgdRnF4a9OjloCGkGmvGCPj3v41d3ouo0h79X2Caw0ow47Ts7lVOFYg9CI3AsZqCe5Yk7i+3fDfYNN8YUTvC9LqgMS0HNMBXLTXeQpYJxs5mVPYloR5BwsgAK4cgOzEaRPVavp4gm3FVcsGCP8QQ2MKq26tHrIs1grVbN3o1CtDk1SK9XPeIhIgKYfAxP+sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(4326008)(8676002)(6916009)(5660300002)(54906003)(81166007)(316002)(26005)(86362001)(7696005)(508600001)(16526019)(336012)(36860700001)(426003)(186003)(83380400001)(2616005)(40460700003)(82310400005)(2906002)(47076005)(30864003)(70586007)(70206006)(44832011)(8936002)(7416002)(36756003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:47:22.7813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868e6c06-5d55-4483-4e17-08da45e5509c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pmus advertise their capabilities via sysfs attribute files but
perf tool currently parses only core(cpu) or hybrid core pmu
capabilities. Add support of recording non-core pmu capabilities
int perf.data header.

Note that a newly proposed HEADER_PMU_CAPS is replacing existing
HEADER_HYBRID_CPU_PMU_CAPS. Special care is taken for hybrid core
pmus by writing their capabilities first in the perf.data header
to make sure new perf.data file being read by old perf tool does
not break.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../Documentation/perf.data-file-format.txt   |  10 +-
 tools/perf/builtin-inject.c                   |   2 +-
 tools/perf/util/env.c                         |  60 ++++++-
 tools/perf/util/env.h                         |  12 +-
 tools/perf/util/header.c                      | 160 ++++++++++--------
 tools/perf/util/header.h                      |   2 +-
 6 files changed, 158 insertions(+), 88 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index f56d0e0fbff6..2233534e508a 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -419,18 +419,20 @@ Example:
   cpu_core cpu list : 0-15
   cpu_atom cpu list : 16-23
 
-	HEADER_HYBRID_CPU_PMU_CAPS = 31,
+	HEADER_PMU_CAPS = 31,
 
-	A list of hybrid CPU PMU capabilities.
+	List of pmu capabilities (except cpu pmu which is already
+	covered by HEADER_CPU_PMU_CAPS). Note that hybrid cpu pmu
+	capabilities are also stored here.
 
 struct {
 	u32 nr_pmu;
 	struct {
-		u32 nr_cpu_pmu_caps;
+		u32 nr_caps;
 		{
 			char	name[];
 			char	value[];
-		} [nr_cpu_pmu_caps];
+		} [nr_caps];
 		char pmu_name[];
 	} [nr_pmu];
 };
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a75bf11585b5..05bc0cfccf83 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -809,7 +809,7 @@ static bool keep_feat(int feat)
 	case HEADER_CPU_PMU_CAPS:
 	case HEADER_CLOCK_DATA:
 	case HEADER_HYBRID_TOPOLOGY:
-	case HEADER_HYBRID_CPU_PMU_CAPS:
+	case HEADER_PMU_CAPS:
 		return true;
 	/* Information that can be updated */
 	case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 7d3aeb2e4622..5b8cf6a421a4 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -219,13 +219,13 @@ void perf_env__exit(struct perf_env *env)
 	}
 	zfree(&env->hybrid_nodes);
 
-	for (i = 0; i < env->nr_hybrid_cpc_nodes; i++) {
-		for (j = 0; j < env->hybrid_cpc_nodes[i].nr_cpu_pmu_caps; j++)
-			zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps[j]);
-		zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps);
-		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
+	for (i = 0; i < env->nr_pmus_with_caps; i++) {
+		for (j = 0; j < env->pmu_caps[i].nr_caps; j++)
+			zfree(&env->pmu_caps[i].caps[j]);
+		zfree(&env->pmu_caps[i].caps);
+		zfree(&env->pmu_caps[i].pmu_name);
 	}
-	zfree(&env->hybrid_cpc_nodes);
+	zfree(&env->pmu_caps);
 }
 
 void perf_env__init(struct perf_env *env)
@@ -531,3 +531,51 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 
 	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
 }
+
+char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
+			     const char *cap)
+{
+	char *cap_eq;
+	int cap_size;
+	char **ptr;
+	int i, j;
+
+	if (!pmu_name || !cap)
+		return NULL;
+
+	cap_size = strlen(cap);
+	cap_eq = zalloc(cap_size + 2);
+	if (!cap_eq)
+		return NULL;
+
+	memcpy(cap_eq, cap, cap_size);
+	cap_eq[cap_size] = '=';
+
+	if (!strcmp(pmu_name, "cpu")) {
+		for (i = 0; i < env->nr_cpu_pmu_caps; i++) {
+			if (!strncmp(env->cpu_pmu_caps[i], cap_eq, cap_size + 1)) {
+				free(cap_eq);
+				return &env->cpu_pmu_caps[i][cap_size + 1];
+			}
+		}
+		goto out;
+	}
+
+	for (i = 0; i < env->nr_pmus_with_caps; i++) {
+		if (strcmp(env->pmu_caps[i].pmu_name, pmu_name))
+			continue;
+
+		ptr = env->pmu_caps[i].caps;
+
+		for (j = 0; j < env->pmu_caps[i].nr_caps; j++) {
+			if (!strncmp(ptr[j], cap_eq, cap_size + 1)) {
+				free(cap_eq);
+				return &ptr[j][cap_size + 1];
+			}
+		}
+	}
+
+out:
+	free(cap_eq);
+	return NULL;
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 43aab59f7322..4566c51f2fd9 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -43,10 +43,10 @@ struct hybrid_node {
 	char	*cpus;
 };
 
-struct hybrid_cpc_node {
-	int		nr_cpu_pmu_caps;
+struct pmu_caps {
+	int		nr_caps;
 	unsigned int    max_branches;
-	char            **cpu_pmu_caps;
+	char            **caps;
 	char            *pmu_name;
 };
 
@@ -74,7 +74,7 @@ struct perf_env {
 	int			nr_groups;
 	int			nr_cpu_pmu_caps;
 	int			nr_hybrid_nodes;
-	int			nr_hybrid_cpc_nodes;
+	int			nr_pmus_with_caps;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
@@ -94,7 +94,7 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	struct hybrid_node	*hybrid_nodes;
-	struct hybrid_cpc_node	*hybrid_cpc_nodes;
+	struct pmu_caps		*pmu_caps;
 #ifdef HAVE_LIBBPF_SUPPORT
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
@@ -172,4 +172,6 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
+char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
+			     const char *cap);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ca5b1f03810d..817dfb531da8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1512,18 +1512,13 @@ static int write_compressed(struct feat_fd *ff __maybe_unused,
 	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
 }
 
-static int write_per_cpu_pmu_caps(struct feat_fd *ff, struct perf_pmu *pmu,
-				  bool write_pmu)
+static int __write_pmu_caps(struct feat_fd *ff, struct perf_pmu *pmu,
+			    bool write_pmu)
 {
 	struct perf_pmu_caps *caps = NULL;
-	int nr_caps;
 	int ret;
 
-	nr_caps = perf_pmu__caps_parse(pmu);
-	if (nr_caps < 0)
-		return nr_caps;
-
-	ret = do_write(ff, &nr_caps, sizeof(nr_caps));
+	ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
 	if (ret < 0)
 		return ret;
 
@@ -1550,33 +1545,60 @@ static int write_cpu_pmu_caps(struct feat_fd *ff,
 			      struct evlist *evlist __maybe_unused)
 {
 	struct perf_pmu *cpu_pmu = perf_pmu__find("cpu");
+	int ret;
 
 	if (!cpu_pmu)
 		return -ENOENT;
 
-	return write_per_cpu_pmu_caps(ff, cpu_pmu, false);
+	ret = perf_pmu__caps_parse(cpu_pmu);
+	if (ret < 0)
+		return ret;
+
+	return __write_pmu_caps(ff, cpu_pmu, false);
 }
 
-static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
-				     struct evlist *evlist __maybe_unused)
+static int write_pmu_caps(struct feat_fd *ff,
+			  struct evlist *evlist __maybe_unused)
 {
-	struct perf_pmu *pmu;
-	u32 nr_pmu = perf_pmu__hybrid_pmu_num();
+	struct perf_pmu *pmu = NULL;
+	int nr_pmu = 0;
 	int ret;
 
-	if (nr_pmu == 0)
-		return -ENOENT;
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
+		    perf_pmu__caps_parse(pmu) <= 0)
+			continue;
+		nr_pmu++;
+	}
 
 	ret = do_write(ff, &nr_pmu, sizeof(nr_pmu));
 	if (ret < 0)
 		return ret;
 
+	if (!nr_pmu)
+		return 0;
+
+	/*
+	 * Write hybrid pmu caps first to maintain compatibility with
+	 * older perf tool.
+	 */
+	pmu = NULL;
 	perf_pmu__for_each_hybrid_pmu(pmu) {
-		ret = write_per_cpu_pmu_caps(ff, pmu, true);
+		ret = __write_pmu_caps(ff, pmu, true);
 		if (ret < 0)
 			return ret;
 	}
 
+	pmu = NULL;
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
+		    !pmu->nr_caps || perf_pmu__is_hybrid(pmu->name))
+			continue;
+
+		ret = __write_pmu_caps(ff, pmu, true);
+		if (ret < 0)
+			return ret;
+	}
 	return 0;
 }
 
@@ -2051,8 +2073,7 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
 }
 
-static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char **cpu_pmu_caps,
-				   char *pmu_name)
+static void __print_pmu_caps(FILE *fp, int nr_caps, char **caps, char *pmu_name)
 {
 	const char *delimiter = "";
 	int i;
@@ -2064,7 +2085,7 @@ static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char **cpu_pmu_caps,
 
 	fprintf(fp, "# %s pmu capabilities: ", pmu_name);
 	for (i = 0; i < nr_caps; i++) {
-		fprintf(fp, "%s%s", delimiter, cpu_pmu_caps[i]);
+		fprintf(fp, "%s%s", delimiter, caps[i]);
 		delimiter = ", ";
 	}
 
@@ -2073,19 +2094,18 @@ static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char **cpu_pmu_caps,
 
 static void print_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
-	print_per_cpu_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
-			       ff->ph->env.cpu_pmu_caps, (char *)"cpu");
+	__print_pmu_caps(fp, ff->ph->env.nr_cpu_pmu_caps,
+			 ff->ph->env.cpu_pmu_caps, (char *)"cpu");
 }
 
-static void print_hybrid_cpu_pmu_caps(struct feat_fd *ff, FILE *fp)
+static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 {
-	struct hybrid_cpc_node *n;
+	struct pmu_caps *pmu_caps;
 
-	for (int i = 0; i < ff->ph->env.nr_hybrid_cpc_nodes; i++) {
-		n = &ff->ph->env.hybrid_cpc_nodes[i];
-		print_per_cpu_pmu_caps(fp, n->nr_cpu_pmu_caps,
-				       n->cpu_pmu_caps,
-				       n->pmu_name);
+	for (int i = 0; i < ff->ph->env.nr_pmus_with_caps; i++) {
+		pmu_caps = &ff->ph->env.pmu_caps[i];
+		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
+				 pmu_caps->pmu_name);
 	}
 }
 
@@ -3196,27 +3216,26 @@ static int process_compressed(struct feat_fd *ff,
 	return 0;
 }
 
-static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
-				    char ***cpu_pmu_caps,
-				    unsigned int *max_branches)
+static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
+			      char ***caps, unsigned int *max_branches)
 {
 	char *name, *value, *ptr;
-	u32 nr_caps, i;
+	u32 nr_pmu_caps, i;
 
-	*nr_cpu_pmu_caps = 0;
-	*cpu_pmu_caps = NULL;
+	*nr_caps = 0;
+	*caps = NULL;
 
-	if (do_read_u32(ff, &nr_caps))
+	if (do_read_u32(ff, &nr_pmu_caps))
 		return -1;
 
-	if (!nr_caps)
+	if (!nr_pmu_caps)
 		return 0;
 
-	*cpu_pmu_caps = zalloc(sizeof(char *) * nr_caps);
-	if (!*cpu_pmu_caps)
+	*caps = zalloc(sizeof(char *) * nr_pmu_caps);
+	if (!*caps)
 		return -1;
 
-	for (i = 0; i < nr_caps; i++) {
+	for (i = 0; i < nr_pmu_caps; i++) {
 		name = do_read_string(ff);
 		if (!name)
 			goto error;
@@ -3228,7 +3247,7 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 		if (asprintf(&ptr, "%s=%s", name, value) < 0)
 			goto free_value;
 
-		(*cpu_pmu_caps)[i] = ptr;
+		(*caps)[i] = ptr;
 
 		if (!strcmp(name, "branches"))
 			*max_branches = atoi(value);
@@ -3236,7 +3255,7 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 		free(value);
 		free(name);
 	}
-	*nr_cpu_pmu_caps = nr_caps;
+	*nr_caps = nr_pmu_caps;
 	return 0;
 
 free_value:
@@ -3245,29 +3264,28 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 	free(name);
 error:
 	for (; i > 0; i--)
-		free((*cpu_pmu_caps)[i - 1]);
-	free(*cpu_pmu_caps);
-	*cpu_pmu_caps = NULL;
-	*nr_cpu_pmu_caps = 0;
+		free((*caps)[i - 1]);
+	free(*caps);
+	*caps = NULL;
+	*nr_caps = 0;
 	return -1;
 }
 
 static int process_cpu_pmu_caps(struct feat_fd *ff,
 				void *data __maybe_unused)
 {
-	int ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
-					&ff->ph->env.cpu_pmu_caps,
-					&ff->ph->env.max_branches);
+	int ret = __process_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
+				     &ff->ph->env.cpu_pmu_caps,
+				     &ff->ph->env.max_branches);
 
 	if (!ret && !ff->ph->env.cpu_pmu_caps)
 		pr_debug("cpu pmu capabilities not available\n");
 	return ret;
 }
 
-static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
-				       void *data __maybe_unused)
+static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 {
-	struct hybrid_cpc_node *nodes;
+	struct pmu_caps *pmu_caps;
 	u32 nr_pmu, i;
 	int ret;
 	int j;
@@ -3276,45 +3294,45 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 		return -1;
 
 	if (!nr_pmu) {
-		pr_debug("hybrid cpu pmu capabilities not available\n");
+		pr_debug("pmu capabilities not available\n");
 		return 0;
 	}
 
-	nodes = zalloc(sizeof(*nodes) * nr_pmu);
-	if (!nodes)
+	pmu_caps = zalloc(sizeof(*pmu_caps) * nr_pmu);
+	if (!pmu_caps)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_pmu; i++) {
-		struct hybrid_cpc_node *n = &nodes[i];
-
-		ret = process_per_cpu_pmu_caps(ff, &n->nr_cpu_pmu_caps,
-					       &n->cpu_pmu_caps,
-					       &n->max_branches);
+		ret = __process_pmu_caps(ff, &pmu_caps[i].nr_caps,
+					 &pmu_caps[i].caps,
+					 &pmu_caps[i].max_branches);
 		if (ret)
 			goto err;
 
-		n->pmu_name = do_read_string(ff);
-		if (!n->pmu_name) {
+		pmu_caps[i].pmu_name = do_read_string(ff);
+		if (!pmu_caps[i].pmu_name) {
 			ret = -1;
 			goto err;
 		}
-		if (!n->nr_cpu_pmu_caps)
-			pr_debug("%s pmu capabilities not available\n", n->pmu_name);
+		if (!pmu_caps[i].nr_caps) {
+			pr_debug("%s pmu capabilities not available\n",
+				 pmu_caps[i].pmu_name);
+		}
 	}
 
-	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
-	ff->ph->env.hybrid_cpc_nodes = nodes;
+	ff->ph->env.nr_pmus_with_caps = nr_pmu;
+	ff->ph->env.pmu_caps = pmu_caps;
 	return 0;
 
 err:
 	for (i = 0; i < nr_pmu; i++) {
-		for (j = 0; j < nodes[i].nr_cpu_pmu_caps; j++)
-			free(nodes[i].cpu_pmu_caps[j]);
-		free(nodes[i].cpu_pmu_caps);
-		free(nodes[i].pmu_name);
+		for (j = 0; j < pmu_caps[i].nr_caps; j++)
+			free(pmu_caps[i].caps[j]);
+		free(pmu_caps[i].caps);
+		free(pmu_caps[i].pmu_name);
 	}
 
-	free(nodes);
+	free(pmu_caps);
 	return ret;
 }
 
@@ -3380,7 +3398,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CPU_PMU_CAPS,	cpu_pmu_caps,	false),
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
-	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
+	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 08563c1f1bff..5790bf556b90 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -46,7 +46,7 @@ enum {
 	HEADER_CPU_PMU_CAPS,
 	HEADER_CLOCK_DATA,
 	HEADER_HYBRID_TOPOLOGY,
-	HEADER_HYBRID_CPU_PMU_CAPS,
+	HEADER_PMU_CAPS,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.31.1

