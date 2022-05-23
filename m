Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F447530821
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355593AbiEWDky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355560AbiEWDkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:40:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EAE36161;
        Sun, 22 May 2022 20:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxUFsca+FuFdnpgAKy9oeYbHv153EDsCCc0LosTDsoJXe/HLji+dCN7pHs4tc0wVA/746lUeE0DjoIzoK395rnizLqJvzIoZg5W+fyGJ/jp8Qu2ghrXarg/1eOrOJ294Mz9hpRuL7/PqNWHtRgT6cnNiCCVSMdZdDR3jND6bvq4jC5hTROGCWZWLkL+X/44nR90pIQ1cc9fGWtNi+/Dg0kGCSFQciXk5JLlfRiwluR+Z8C9i5ZnsLRgkCzOXipWXswClGb4zHMXIrqxAIwZcH/voqKLWX/YXmltFq0zFYF9+ku6KTdjkcYnYeUggVswLy43C9+zZlWfBpcxbx+1AIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lwi3a7cTil1QH+HePJF9UaMi8Zd3BPnGmw0f7QJGCu8=;
 b=eS7Avt5/9ocGwhFefBC5SSucxfqMpU8mMjFeratVN5n8UInrNFGM0lpUgMW84G4uGh4iqKbgssNBJaSNRqTQ7K4mylsNfr1DjulYosoSyPCizQxD0P+9s8eCuCD5hZO30SKlGA0wTAzQRcF/1xNPKi1iH3ioSKrCE23fWS0SjSApoCsr8RgSq/gAI6yA526ZTya8luG6Aubt6etjB3rBwYvyUCxkkic9OMFqOGHNY0mbFymN/pHTTE0JWCk4yLjcH4BL/Y1+BRZh6rNxWYn24lL9s7bmB1MwuqAVfwsQE+ZL3/N036vim2fRsLm8Pto8R2jLGZ4j6ZfKnjNugBzkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwi3a7cTil1QH+HePJF9UaMi8Zd3BPnGmw0f7QJGCu8=;
 b=3CEVctU3hM1nJ6GiJOcYnXUrKMvphukhh/wg2Ur/Pjba76e6T3C0djoovmtojoUnHl8W/A9iXHLTLR5GyLrZgA3zo7LAtTZNHDIqCZFgMbILayCk+0zDp7pwYzfrUt1XgGynEGJ0JTiRgb9YPjlr1WuqEUm9tKS41ZRvwVoS3GQ=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Mon, 23 May 2022 03:40:34 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::14) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.20 via Frontend
 Transport; Mon, 23 May 2022 03:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 03:40:34 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 22 May
 2022 22:40:23 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v4 2/5] perf header: Parse non-cpu pmu capabilities
Date:   Mon, 23 May 2022 09:09:42 +0530
Message-ID: <20220523033945.1612-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523033945.1612-1-ravi.bangoria@amd.com>
References: <20220523033945.1612-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11fbd8e1-088e-4b27-4019-08da3c6dfe71
X-MS-TrafficTypeDiagnostic: DM4PR12MB6256:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6256A644BA6854E135328AFCE0D49@DM4PR12MB6256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ngyr3yjBGHlUIu8YRwp5LPmqXKAoherLoYInN49ZV26biBmaLLzRQb91sIbowelqMFeQWgrRepni4YX9Zp7laWM+I585VU/uG8NvR9sfBiKP/l+CkwGmWCzyBQAg8oN6kZzK5oanAVIIWCJE38SXnxDWrVy5Bxe7cupQiKnzl0NHFsj63xck//x3K/u2IO/mremQdXCeHbfrLfgycRIluZcmmKcKmS+vffPUN0JDZqMtwBmDAML3RHq7u32I+reirYMaqyRDHavym8jk6azdUiV6nTEhXvwf0f+p0JroSHTDpBhUIJbIVl9EwxnyHoZHcmLV3flJqOA65oHl3uLbRBJOGuRhExgkgocaFvT3hlehveaadJQz8mZGscB/h4Kww4iomx8+K4Z1mJiZjlYE9ytK/PDPp3EagLD5cyGElizDqP1Vqx67S5oSNpa47ZQclQ+YdhwAKN8w4z4y3aAFlOTA1qtuwGKsqp6GuE+W5pIVc5Y8y3hWpU2/zFndCQWpi05Pn87PLSmuldLTUI1gSv7hyi/J3+oHBNGDvkXGzba9n8tshatIit9KfLuiJXviNn7heUifEGGhglrqiLOlwiu74A9+MBnyJN7isvk5mZtUOqGe2y063t8MzvOoKGuP3vg6QdfKoOkMm41lj4w8BJEMSb0p9uas74tEMQUDg+dBrQTy5J0rY94uVQcxVOx5XNtdHoUSPCkSvSGBNDw88g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(1076003)(81166007)(82310400005)(44832011)(30864003)(36756003)(2906002)(6666004)(47076005)(83380400001)(36860700001)(2616005)(16526019)(86362001)(7696005)(26005)(316002)(40460700003)(508600001)(54906003)(4326008)(5660300002)(70206006)(6916009)(70586007)(336012)(426003)(186003)(8676002)(7416002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 03:40:34.3033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fbd8e1-088e-4b27-4019-08da3c6dfe71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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
perf tool currently parses only core(cpu) pmu capabilities. Add
support for parsing non-cpu pmu capabilities.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 .../Documentation/perf.data-file-format.txt   |  17 ++
 tools/perf/util/env.c                         |  47 +++++
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/header.c                      | 185 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 7 files changed, 273 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index f56d0e0fbff6..64dddaecda21 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -435,6 +435,23 @@ struct {
 	} [nr_pmu];
 };
 
+	HEADER_PMU_CAPS = 32,
+
+	List of pmu capabilities (except cpu pmu which is already
+	covered by HEADER_CPU_PMU_CAPS / HEADER_HYBRID_CPU_PMU_CAPS)
+
+struct {
+	u32 nr_pmus;
+	struct {
+		char pmu_name[];
+		u32 nr_caps;
+		struct {
+			char name[];
+			char value[];
+		} [nr_caps];
+	} [nr_pmus];
+};
+
 	other bits are reserved and should ignored for now
 	HEADER_FEAT_BITS	= 256,
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 579e44c59914..3ecdd7683e45 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -180,6 +180,7 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
 void perf_env__exit(struct perf_env *env)
 {
 	int i;
+	u32 j;
 
 	perf_env__purge_bpf(env);
 	perf_env__purge_cgroups(env);
@@ -222,6 +223,14 @@ void perf_env__exit(struct perf_env *env)
 		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
 	}
 	zfree(&env->hybrid_cpc_nodes);
+
+	for (i = 0; i < env->nr_pmus_with_caps; i++) {
+		zfree(&env->env_pmu_caps[i].pmu_name);
+		for (j = 0; j < env->env_pmu_caps[i].nr_caps; j++)
+			zfree(&env->env_pmu_caps[i].pmu_caps[j]);
+		zfree(&env->env_pmu_caps[i].pmu_caps);
+	}
+	zfree(&env->env_pmu_caps);
 }
 
 void perf_env__init(struct perf_env *env)
@@ -527,3 +536,41 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 
 	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
 }
+
+char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
+			     const char *cap)
+{
+	struct env_pmu_caps *env_pmu_caps = env->env_pmu_caps;
+	char *cap_eq;
+	int cap_size;
+	char **ptr;
+	int i;
+	u32 j;
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
+	for (i = 0; i < env->nr_pmus_with_caps; i++) {
+		if (strcmp(env_pmu_caps[i].pmu_name, pmu_name))
+			continue;
+
+		ptr = env_pmu_caps[i].pmu_caps;
+
+		for (j = 0; j < env_pmu_caps[i].nr_caps; j++) {
+			if (!strncmp(ptr[j], cap_eq, cap_size + 1)) {
+				free(cap_eq);
+				return &ptr[j][cap_size + 1];
+			}
+		}
+	}
+	free(cap_eq);
+	return NULL;
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a3541f98e1fc..a21d62ee9de8 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -50,6 +50,12 @@ struct hybrid_cpc_node {
 	char            *pmu_name;
 };
 
+struct env_pmu_caps {
+	char	*pmu_name;
+	u32	nr_caps;
+	char	**pmu_caps;
+};
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -75,6 +81,7 @@ struct perf_env {
 	int			nr_cpu_pmu_caps;
 	int			nr_hybrid_nodes;
 	int			nr_hybrid_cpc_nodes;
+	int			nr_pmus_with_caps;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
@@ -95,6 +102,7 @@ struct perf_env {
 	unsigned long long	 memory_bsize;
 	struct hybrid_node	*hybrid_nodes;
 	struct hybrid_cpc_node	*hybrid_cpc_nodes;
+	struct env_pmu_caps	*env_pmu_caps;
 #ifdef HAVE_LIBBPF_SUPPORT
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
@@ -172,4 +180,6 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
+char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
+			     const char *cap);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a27132e5a5ef..b4505dbb9f4a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1580,6 +1580,67 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
+/*
+ * File format:
+ *
+ * struct {
+ *	u32 nr_pmus;
+ *	struct {
+ *		char pmu_name[];
+ *		u32 nr_caps;
+ *		struct {
+ *			char name[];
+ *			char value[];
+ *		} [nr_caps];
+ *	} [nr_pmus];
+ * };
+ */
+static int write_pmu_caps(struct feat_fd *ff, struct evlist *evlist __maybe_unused)
+{
+	struct perf_pmu_caps *caps = NULL;
+	struct perf_pmu *pmu = NULL;
+	u32 nr_pmus = 0;
+	int ret;
+
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name || !strncmp(pmu->name, "cpu", 3) ||
+		    perf_pmu__caps_parse(pmu) <= 0)
+			continue;
+		nr_pmus++;
+	}
+
+	ret = do_write(ff, &nr_pmus, sizeof(nr_pmus));
+	if (ret < 0)
+		return ret;
+
+	if (!nr_pmus)
+		return 0;
+
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name || !strncmp(pmu->name, "cpu", 3) || !pmu->nr_caps)
+			continue;
+
+		ret = do_write_string(ff, pmu->name);
+		if (ret < 0)
+			return ret;
+
+		ret = do_write(ff, &pmu->nr_caps, sizeof(pmu->nr_caps));
+		if (ret < 0)
+			return ret;
+
+		list_for_each_entry(caps, &pmu->caps, list) {
+			ret = do_write_string(ff, caps->name);
+			if (ret < 0)
+				return ret;
+
+			ret = do_write_string(ff, caps->value);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -2209,6 +2270,32 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
+{
+	struct env_pmu_caps *env_pmu_caps = ff->ph->env.env_pmu_caps;
+	int nr_pmus_with_caps = ff->ph->env.nr_pmus_with_caps;
+	const char *delimiter = "";
+	char **ptr;
+	int i;
+	u32 j;
+
+	if (!nr_pmus_with_caps)
+		return;
+
+	for (i = 0; i < nr_pmus_with_caps; i++) {
+		fprintf(fp, "# %s pmu capabilities: ", env_pmu_caps[i].pmu_name);
+
+		ptr = env_pmu_caps[i].pmu_caps;
+
+		delimiter = "";
+		for (j = 0; j < env_pmu_caps[i].nr_caps; j++) {
+			fprintf(fp, "%s%s", delimiter, ptr[j]);
+			delimiter = ", ";
+		}
+		fprintf(fp, "\n");
+	}
+}
+
 static int __event_process_build_id(struct perf_record_header_build_id *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -3319,6 +3406,103 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	return ret;
 }
 
+static int __process_pmu_caps(struct feat_fd *ff, struct env_pmu_caps *env_pmu_caps)
+{
+	u32 nr_caps = env_pmu_caps->nr_caps;
+	int name_size, value_size;
+	char *name, *value, *ptr;
+	u32 i;
+
+	env_pmu_caps->pmu_caps = zalloc(sizeof(char *) * nr_caps);
+	if (!env_pmu_caps->pmu_caps)
+		return -1;
+
+	for (i = 0; i < nr_caps; i++) {
+		name = do_read_string(ff);
+		if (!name)
+			goto error;
+
+		value = do_read_string(ff);
+		if (!value)
+			goto free_name;
+
+		name_size = strlen(name);
+		value_size = strlen(value);
+		ptr = zalloc(sizeof(char) * (name_size + value_size + 2));
+		if (!ptr)
+			goto free_value;
+
+		memcpy(ptr, name, name_size);
+		ptr[name_size] = '=';
+		memcpy(ptr + name_size + 1, value, value_size);
+		env_pmu_caps->pmu_caps[i] = ptr;
+
+		free(value);
+		free(name);
+	}
+	return 0;
+
+free_value:
+	free(value);
+free_name:
+	free(name);
+error:
+	for (; i > 0; i--)
+		free(env_pmu_caps->pmu_caps[i - 1]);
+	free(env_pmu_caps->pmu_caps);
+	return -1;
+}
+
+static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct env_pmu_caps *env_pmu_caps;
+	u32 nr_pmus;
+	u32 i, j;
+
+	ff->ph->env.nr_pmus_with_caps = 0;
+	ff->ph->env.env_pmu_caps = NULL;
+
+	if (do_read_u32(ff, &nr_pmus))
+		return -1;
+
+	if (!nr_pmus)
+		return 0;
+
+	env_pmu_caps = zalloc(sizeof(struct env_pmu_caps) * nr_pmus);
+	if (!env_pmu_caps)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_pmus; i++) {
+		env_pmu_caps[i].pmu_name = do_read_string(ff);
+		if (!env_pmu_caps[i].pmu_name)
+			goto error;
+
+		if (do_read_u32(ff, &env_pmu_caps[i].nr_caps))
+			goto free_pmu_name;
+
+		if (!__process_pmu_caps(ff, &env_pmu_caps[i]))
+			continue;
+
+free_pmu_name:
+		free(env_pmu_caps[i].pmu_name);
+		goto error;
+	}
+
+	ff->ph->env.nr_pmus_with_caps = nr_pmus;
+	ff->ph->env.env_pmu_caps = env_pmu_caps;
+	return 0;
+
+error:
+	for (; i > 0; i--) {
+		free(env_pmu_caps[i - 1].pmu_name);
+		for (j = 0; j < env_pmu_caps[i - 1].nr_caps; j++)
+			free(env_pmu_caps[i - 1].pmu_caps[j]);
+		free(env_pmu_caps[i - 1].pmu_caps);
+	}
+	free(env_pmu_caps);
+	return -1;
+}
+
 #define FEAT_OPR(n, func, __full_only) \
 	[HEADER_##n] = {					\
 		.name	    = __stringify(n),			\
@@ -3382,6 +3566,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
+	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0eb4bc29a5a4..e9a067bb8b9e 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -47,6 +47,7 @@ enum {
 	HEADER_CLOCK_DATA,
 	HEADER_HYBRID_TOPOLOGY,
 	HEADER_HYBRID_CPU_PMU_CAPS,
+	HEADER_PMU_CAPS,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9a1c7e63e663..8d599acb7569 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1890,16 +1890,22 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	const char *sysfs = sysfs__mountpoint();
 	DIR *caps_dir;
 	struct dirent *evt_ent;
-	int nr_caps = 0;
+
+	if (pmu->caps_initialized)
+		return pmu->nr_caps;
 
 	if (!sysfs)
 		return -1;
 
+	pmu->nr_caps = 0;
+
 	snprintf(caps_path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
 
-	if (stat(caps_path, &st) < 0)
+	if (stat(caps_path, &st) < 0) {
+		pmu->caps_initialized = true;
 		return 0;	/* no error if caps does not exist */
+	}
 
 	caps_dir = opendir(caps_path);
 	if (!caps_dir)
@@ -1926,13 +1932,14 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 			continue;
 		}
 
-		nr_caps++;
+		pmu->nr_caps++;
 		fclose(file);
 	}
 
 	closedir(caps_dir);
 
-	return nr_caps;
+	pmu->caps_initialized = true;
+	return pmu->nr_caps;
 }
 
 void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 541889fa9f9c..4b45fd8da5a3 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -46,6 +46,8 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	bool caps_initialized;
+	u32 nr_caps;
 	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 	struct list_head hybrid_list;
-- 
2.31.1

