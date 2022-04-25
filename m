Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9758650D876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiDYEsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241074AbiDYErt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:47:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E0C5FC4;
        Sun, 24 Apr 2022 21:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX/UxTS4i5cY5u+38wHXSGS8iJ9kg+WNssDQdNerKJYt+S7dGQcc3Xt8m+old1buMUatNiAWhK0GAr/8fQI3KZ/2VAf6AH0lCtk+sRuA45SOxBm+IhYw3hNOXqK+zi9PWfsTV+CSpsc2glkCGKSS57Q/ttCkG61RGt+T9aCVo+MkTI6PFRhRwHQ/7c7ZhRyPdR0aIK2lrZzwzsirZm7BXnhaGO7VOepRzEA934fENGCh+pnNkbHZw/fRhMp3CRYLUl1yRh3IXhiM1Ih0SzBNmZr6GeP7Gsh/ZH5CTV6R32QW+plUt0Dtw7GiYN669Xv7CHzb8l7AIHKvZjPQ0p4cLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc/DKlOWBrsaq06CU5pYUUQaw/+u5fTRBhzfXU3V3cM=;
 b=XZSy3iuqyG14Ks/N8S0GtMiKZrQetEviEtu8EMHHpwfgQttnxL6kxh5ZjiK7lxQWNd5ygZ+CxSZVxiPWYZ1ggB2itqauYIeCwPdqxxTS52ZjsQacmcro2c0zo9Ai1PajoA4hnoYO+R89+PrG2IGK1eWxzTgrkkW+wHfLbMgTWr6zLq45Zwx30FkQ+wG7lUEj2PPHl6bA7srbJlQTu763xSapspvRo0NX6mecUjd5rZKnl0k2ICcOP3+hqRtbR0ASlW0Nlkc1tJFv5iIaWSuB231kiSqR5FWOfwEC/9rPhV2NgR2hJuUJDaxZjNqWtOjE348W66xyDW70lVMsOf2frg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc/DKlOWBrsaq06CU5pYUUQaw/+u5fTRBhzfXU3V3cM=;
 b=V14SmNiyB/9hUTU/wcYhKP13ioBaS8Ast/sXwJaLdQ32Kfk+LrAj1MsGZyCJhfllWc4gV3vGfoTIhM/8GNPIvZI9i6mrQxR66dGgxlWKaJpDIIPIE1rgCoJd1QkqTnK1D5ovn80/MD77ZxMUG3dhO29yunj0S921xL4I7N2vsb0=
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 04:44:40 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::a3) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:40 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:32 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <rrichter@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 4/6] perf/tool: Parse non-cpu pmu capabilities
Date:   Mon, 25 Apr 2022 10:13:21 +0530
Message-ID: <20220425044323.2830-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425044323.2830-1-ravi.bangoria@amd.com>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19e5a8ee-8393-4568-3837-08da26764f54
X-MS-TrafficTypeDiagnostic: CH0PR12MB5234:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5234C64A99404A08767877F7E0F89@CH0PR12MB5234.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdlIHprl4aPfsJDGR3ueIPLe9Nanv/nWz5zMQt6c18/Uf5hUg8HBnmqBWv37Mz+MYmvJuaStGq1EH44Sk4UWt+fZ3+dhUJSRGQno4XoYArCQ/IylQE7Pow11oNy9wivZtnjaLiksd0w8Na3JEQxbDuyquQLrrL7YPi1dA6hqfqU4x+l9t9UJ67gFbLaT2W6nNY81mfY20+yBMbjm+eDNo8jQBEQFUnnTNNI024qaA+fozM9Bg3bq4TcPxor7IkOHkwgVyeB+gGMVyARYp66mArNOinbXCw4+8hN2WkgagNW9sgUlb9wnG0lf8Nyefm+2hGdWJ89OJ8Y97OnROqw3MrJJMbm+Xu1zRF4Km9kiF6zUPg6e96m8NumRieSWpuaIl5F3+cqvSkuSMbNVmuAAWbcpqo68sCJnWD6G3+DFZESgTf9jSZizWwo0aQeO9X/MKVAUxd5eui2vvmwUgmAkA+9K2MTjbJ46BE7oslt7ko83JkoWWlEhP/YdvY8xk2664qeRk/qHcrfbMA0RbLv4A2WL9R1oidbzi0KU76W3CwaoeLWShqtRKc2xEHDPvsQH3SumlREJzPPjMYjwWZNAnEE0Lz18sMt5p2fVOLrVTXKmquBJpfaDLuOEP3ujKlL4K/n8lzFx7NzRuLXH4g7R+YdTp2yOcUCWK5b/TjwUfUcVdG2xGFkaW9mCXT1xTRvGu297Hqidv5gQlKb4jRMtYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(186003)(70586007)(70206006)(1076003)(336012)(16526019)(426003)(2616005)(8676002)(508600001)(54906003)(47076005)(6666004)(7696005)(26005)(40460700003)(356005)(36756003)(316002)(110136005)(81166007)(36860700001)(2906002)(82310400005)(86362001)(7416002)(8936002)(30864003)(44832011)(5660300002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:40.4481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e5a8ee-8393-4568-3837-08da26764f54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../Documentation/perf.data-file-format.txt   |  18 ++
 tools/perf/util/env.c                         |  48 +++-
 tools/perf/util/env.h                         |  11 +
 tools/perf/util/header.c                      | 211 ++++++++++++++++++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/pmu.c                         |  15 +-
 tools/perf/util/pmu.h                         |   2 +
 7 files changed, 301 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index f56d0e0fbff6..dea3acb36558 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -435,6 +435,24 @@ struct {
 	} [nr_pmu];
 };
 
+	HEADER_PMU_CAPS = 32,
+
+	List of pmu capabilities (except cpu pmu which is already
+	covered by HEADER_CPU_PMU_CAPS)
+
+struct {
+	u32 nr_pmus;
+	struct {
+		u8 core_type;	/* For hybrid topology */
+		char pmu_name[];
+		u16 nr_caps;
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
index 579e44c59914..928633f07086 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -179,7 +179,7 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
 
 void perf_env__exit(struct perf_env *env)
 {
-	int i;
+	int i, j;
 
 	perf_env__purge_bpf(env);
 	perf_env__purge_cgroups(env);
@@ -222,6 +222,14 @@ void perf_env__exit(struct perf_env *env)
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
@@ -527,3 +535,41 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 
 	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
 }
+
+char *perf_env__find_pmu_cap(struct perf_env *env, u8 core_type,
+			     const char *pmu_name, const char *cap)
+{
+	struct env_pmu_caps *env_pmu_caps = env->env_pmu_caps;
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
+	for (i = 0; i < env->nr_pmus_with_caps; i++) {
+		if (env_pmu_caps[i].core_type != core_type ||
+		    strcmp(env_pmu_caps[i].pmu_name, pmu_name))
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
index a3541f98e1fc..2b767f4ae6e0 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -50,6 +50,13 @@ struct hybrid_cpc_node {
 	char            *pmu_name;
 };
 
+struct env_pmu_caps {
+	u8	core_type;
+	char	*pmu_name;
+	u16	nr_caps;
+	char	**pmu_caps;
+};
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -75,6 +82,7 @@ struct perf_env {
 	int			nr_cpu_pmu_caps;
 	int			nr_hybrid_nodes;
 	int			nr_hybrid_cpc_nodes;
+	int			nr_pmus_with_caps;
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
@@ -95,6 +103,7 @@ struct perf_env {
 	unsigned long long	 memory_bsize;
 	struct hybrid_node	*hybrid_nodes;
 	struct hybrid_cpc_node	*hybrid_cpc_nodes;
+	struct env_pmu_caps	*env_pmu_caps;
 #ifdef HAVE_LIBBPF_SUPPORT
 	/*
 	 * bpf_info_lock protects bpf rbtrees. This is needed because the
@@ -172,4 +181,6 @@ bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
+char *perf_env__find_pmu_cap(struct perf_env *env, u8 core_type,
+			     const char *pmu_name, const char *cap);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d546ff724dbe..425859a001d1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -217,6 +217,19 @@ static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
 	return __do_read_buf(ff, addr, size);
 }
 
+static int do_read_u16(struct feat_fd *ff, u16 *addr)
+{
+	int ret;
+
+	ret = __do_read(ff, addr, sizeof(*addr));
+	if (ret)
+		return ret;
+
+	if (ff->ph->needs_swap)
+		*addr = bswap_16(*addr);
+	return 0;
+}
+
 static int do_read_u32(struct feat_fd *ff, u32 *addr)
 {
 	int ret;
@@ -1529,6 +1542,77 @@ static int write_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	return 0;
 }
 
+/*
+ * File format:
+ *
+ * struct {
+ *	u32 nr_pmus;
+ *	struct {
+ *		u8 core_type;
+ *		char pmu_name[];
+ *		u16 nr_caps;
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
+	u8 core_type = 0;
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
+		/*
+		 * Currently core_type is always set to 0. But it can be
+		 * used in future for hybrid topology pmus.
+		 */
+		ret = do_write(ff, &core_type, sizeof(core_type));
+		if (ret < 0)
+			return ret;
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
@@ -2158,6 +2242,31 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
 	}
 }
 
+static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
+{
+	struct env_pmu_caps *env_pmu_caps = ff->ph->env.env_pmu_caps;
+	int nr_pmus_with_caps = ff->ph->env.nr_pmus_with_caps;
+	const char *delimiter = "";
+	char **ptr;
+	int i, j;
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
@@ -3268,6 +3377,107 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	return ret;
 }
 
+static int __process_pmu_caps(struct feat_fd *ff, struct env_pmu_caps *env_pmu_caps)
+{
+	u16 nr_caps = env_pmu_caps->nr_caps;
+	int name_size, value_size;
+	char *name, *value, *ptr;
+	u16 i;
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
+	u32 i;
+	u16 j;
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
+		if (__do_read(ff, &env_pmu_caps[i].core_type, sizeof(env_pmu_caps[i].core_type)))
+			goto error;
+
+		env_pmu_caps[i].pmu_name = do_read_string(ff);
+		if (!env_pmu_caps[i].pmu_name)
+			goto error;
+
+		if (do_read_u16(ff, &env_pmu_caps[i].nr_caps))
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
@@ -3331,6 +3541,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(CLOCK_DATA,	clock_data,	false),
 	FEAT_OPN(HYBRID_TOPOLOGY,	hybrid_topology,	true),
 	FEAT_OPR(HYBRID_CPU_PMU_CAPS,	hybrid_cpu_pmu_caps,	false),
+	FEAT_OPR(PMU_CAPS,	pmu_caps,	false),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index c9e3265832d9..38584419678f 100644
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
index 541889fa9f9c..593005e68bea 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -46,6 +46,8 @@ struct perf_pmu {
 	struct perf_cpu_map *cpus;
 	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	bool caps_initialized;
+	u16 nr_caps;
 	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
 	struct list_head list;    /* ELEM */
 	struct list_head hybrid_list;
-- 
2.27.0

