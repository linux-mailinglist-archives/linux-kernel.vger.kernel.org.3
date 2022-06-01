Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1F539BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbiFAD2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349440AbiFAD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:28:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204FE36328;
        Tue, 31 May 2022 20:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FURpJN5B1yvxZpFUDdenk6/qS7izB/pnoGSSbjHaIX1kxyEFG/CKHtQ5Px/ZxUMK6wEN9kJkDGYdHTOqCMfHUorJ6EVtIIPqYbivizNm/BwgRr7MjUjDzF6MkpmGrsIyATZDYqbcPZWrSnj85QxzrSzxhe2tv0N4yEN92fqetUSL0UYmuRep+XFueza/bizlbyZncb4BhTDKDapKqA3BDDhD/uKkdI5M2W7MjJqLHPJgf2q6xXGVYTJDtlWkuYj+Sgy660IFOgMEFRnR9nsnJgUvnpEkzGt6Cf6oZfefsIN9boWstoPRGlu6du7Jhvzd2f65n0yjCwR1fYlXRpeJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNmzjOJZ1pq+w3hldaiG/m1QiouuoF7/Y5w8Xl3I0xo=;
 b=QINKlTDU/EP2GutP+K6vMSheDrUByBeYatnWuFFNMngYcKHBuVMbXZyo3nsK0dBnEVSufgmtbfFwXZ6JhovN+xN68xczSFBgOHy4aBmeAB6MwP8uDNqmdYBzNn/Xth8ksvxIbkQqd+BSEEY0hwrQyfYH2/Z8su5jshySqpTPZ7cfCH/NXS0bYvfDPD9+e0b1m0sh1sHlmLy1mo7Vte1a02a1ugBG+wTCgDSGVWlgTRFOsnreeJzQoJLskBY2X54yT1OUGiM87yl3nrXb8AhXan/xR/SXLtzE/QT7UgFU/UcqXcSk1RlNJqyAK0ALeTV/syiiRYDFdS1cAE/EiulGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNmzjOJZ1pq+w3hldaiG/m1QiouuoF7/Y5w8Xl3I0xo=;
 b=Hi/I6y4I9aK7/1Jp/4FoV8A8yQzvJb+Yyo5y+es1Z/SDFHmQQmH9UfaVD+rVUoVxjSpbvujHn+PbSFlAMzBxyVtQmhsRYKtrz5soDUR2U8rGkZZpyT5K1/UxcgihJIiVZQZov1vynU3DZ+Kx8ldTbtE814YsmzNN/nuxvgpnO7g=
Received: from MWHPR10CA0016.namprd10.prod.outlook.com (2603:10b6:301::26) by
 CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.19; Wed, 1 Jun 2022 03:28:07 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::37) by MWHPR10CA0016.outlook.office365.com
 (2603:10b6:301::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Wed, 1 Jun 2022 03:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 03:28:07 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 22:27:54 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <kan.liang@linux.intel.com>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <irogers@google.com>,
        <peterz@infradead.org>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v5 4/8] perf headers: Store pmu caps in an array of strings
Date:   Wed, 1 Jun 2022 08:56:04 +0530
Message-ID: <20220601032608.1034-5-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601032608.1034-1-ravi.bangoria@amd.com>
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6134f06-38f8-4ab3-75c9-08da437ebef2
X-MS-TrafficTypeDiagnostic: CY5PR12MB6622:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB66224A7EFB1519575B2CEE38E0DF9@CY5PR12MB6622.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +F3U6iUl/Ere5zRGdaxIVantd3u1MAkSMJbReene8pdiCvS6h/9nA76fwxoivEvHVYO/NQ1lgfVS3ejAVXvhIc/JCsRJojGIbcP+kQEV8DqpqkRT/KT3m/JZ+D4uZGeogTDNqDviOSpSBfxW4EfqRB+oUUpT9j4bBVW7FCmH8LLCzwdYU/dl2J91nwEuKzJbvW+eqzjTfWrVpv+LP6WlGBG5I58FAhEbSW5LKcHDUDKJinCc6Nz5bX0+ThLVTzQAH/jZkm76BX4/iChTTU4fNbXpZIQxl/B9HIsYI2kKxYDyt0yyuHTwu0NGkuP5itB+T7uvCtYQzyBqGCBkP8KvEo1uZMJmWTS+9bk6nY2ESnLTl2wdKxl1i8fa4UjTB3rkG/Yw7Gi4G75/CSXsAichcSsYCS7go5P5xYJaW08G6zFxnEKPsr/nyl4RQfsdJ3wJuK+8vaijCxcnhcMKRSnSLKemGNimZzQTtoId1Vy/awv2jApgLnjM+xnsco0ALAX0H5peh/5+Mfx6Ttbef84mmgeWlqFENSJh0rUggSIMHzzgZmN618fi3t8ajGlM0p4XRjGH/CwOw2NOXflJHthBuTWYvTr7e0LwfHhONhigPnZ7AJWFavlREIJ4UHfjMXQw1J8elBwAKECsmHvgDqX7l5lVqcr2vZfgwJlnn2UgBJT+Jm+OAdW/1a/AWRMjrjdOjmNNOVs7y1VSsDEngQPXUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(44832011)(2616005)(82310400005)(36860700001)(81166007)(356005)(110136005)(47076005)(36756003)(83380400001)(316002)(336012)(426003)(7696005)(2906002)(6666004)(54906003)(40460700003)(186003)(7416002)(86362001)(8936002)(5660300002)(4326008)(8676002)(508600001)(70586007)(70206006)(1076003)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 03:28:07.2972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6134f06-38f8-4ab3-75c9-08da437ebef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all capabilities are stored in a single string separated
by NULL character. Instead, store them in an array which makes
searching of capability easier.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/util/env.c    |  6 +++-
 tools/perf/util/env.h    |  4 +--
 tools/perf/util/header.c | 70 +++++++++++++++++++++++-----------------
 3 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 579e44c59914..7d3aeb2e4622 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -179,7 +179,7 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
 
 void perf_env__exit(struct perf_env *env)
 {
-	int i;
+	int i, j;
 
 	perf_env__purge_bpf(env);
 	perf_env__purge_cgroups(env);
@@ -196,6 +196,8 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->sibling_threads);
 	zfree(&env->pmu_mappings);
 	zfree(&env->cpu);
+	for (i = 0; i < env->nr_cpu_pmu_caps; i++)
+		zfree(&env->cpu_pmu_caps[i]);
 	zfree(&env->cpu_pmu_caps);
 	zfree(&env->numa_map);
 
@@ -218,6 +220,8 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->hybrid_nodes);
 
 	for (i = 0; i < env->nr_hybrid_cpc_nodes; i++) {
+		for (j = 0; j < env->hybrid_cpc_nodes[i].nr_cpu_pmu_caps; j++)
+			zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps[j]);
 		zfree(&env->hybrid_cpc_nodes[i].cpu_pmu_caps);
 		zfree(&env->hybrid_cpc_nodes[i].pmu_name);
 	}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a3541f98e1fc..43aab59f7322 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -46,7 +46,7 @@ struct hybrid_node {
 struct hybrid_cpc_node {
 	int		nr_cpu_pmu_caps;
 	unsigned int    max_branches;
-	char            *cpu_pmu_caps;
+	char            **cpu_pmu_caps;
 	char            *pmu_name;
 };
 
@@ -81,7 +81,7 @@ struct perf_env {
 	char			*sibling_dies;
 	char			*sibling_threads;
 	char			*pmu_mappings;
-	char			*cpu_pmu_caps;
+	char			**cpu_pmu_caps;
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ee7ccd94e272..a1e4ec53333d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2051,26 +2051,21 @@ static void print_compressed(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
 }
 
-static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char *cpu_pmu_caps,
+static void print_per_cpu_pmu_caps(FILE *fp, int nr_caps, char **cpu_pmu_caps,
 				   char *pmu_name)
 {
-	const char *delimiter;
-	char *str, buf[128];
+	const char *delimiter = "";
+	int i;
 
 	if (!nr_caps) {
 		fprintf(fp, "# %s pmu capabilities: not available\n", pmu_name);
 		return;
 	}
 
-	scnprintf(buf, sizeof(buf), "# %s pmu capabilities: ", pmu_name);
-
-	delimiter = buf;
-
-	str = cpu_pmu_caps;
-	while (nr_caps--) {
-		fprintf(fp, "%s%s", delimiter, str);
+	fprintf(fp, "# %s pmu capabilities: ", pmu_name);
+	for (i = 0; i < nr_caps; i++) {
+		fprintf(fp, "%s%s", delimiter, cpu_pmu_caps[i]);
 		delimiter = ", ";
-		str += strlen(str) + 1;
 	}
 
 	fprintf(fp, "\n");
@@ -3202,27 +3197,27 @@ static int process_compressed(struct feat_fd *ff,
 }
 
 static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
-				    char **cpu_pmu_caps,
+				    char ***cpu_pmu_caps,
 				    unsigned int *max_branches)
 {
-	char *name, *value;
-	struct strbuf sb;
-	u32 nr_caps;
+	int name_size, value_size;
+	char *name, *value, *ptr;
+	u32 nr_caps, i;
+
+	*nr_cpu_pmu_caps = 0;
+	*cpu_pmu_caps = NULL;
 
 	if (do_read_u32(ff, &nr_caps))
 		return -1;
 
-	if (!nr_caps) {
-		pr_debug("cpu pmu capabilities not available\n");
+	if (!nr_caps)
 		return 0;
-	}
-
-	*nr_cpu_pmu_caps = nr_caps;
 
-	if (strbuf_init(&sb, 128) < 0)
+	*cpu_pmu_caps = zalloc(sizeof(char *) * nr_caps);
+	if (!*cpu_pmu_caps)
 		return -1;
 
-	while (nr_caps--) {
+	for (i = 0; i < nr_caps; i++) {
 		name = do_read_string(ff);
 		if (!name)
 			goto error;
@@ -3231,12 +3226,16 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 		if (!value)
 			goto free_name;
 
-		if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
+		name_size = strlen(name);
+		value_size = strlen(value);
+		ptr = zalloc(sizeof(char) * (name_size + value_size + 2));
+		if (!ptr)
 			goto free_value;
 
-		/* include a NULL character at the end */
-		if (strbuf_add(&sb, "", 1) < 0)
-			goto free_value;
+		memcpy(ptr, name, name_size);
+		ptr[name_size] = '=';
+		memcpy(ptr + name_size + 1, value, value_size);
+		(*cpu_pmu_caps)[i] = ptr;
 
 		if (!strcmp(name, "branches"))
 			*max_branches = atoi(value);
@@ -3244,7 +3243,7 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 		free(value);
 		free(name);
 	}
-	*cpu_pmu_caps = strbuf_detach(&sb, NULL);
+	*nr_cpu_pmu_caps = nr_caps;
 	return 0;
 
 free_value:
@@ -3252,16 +3251,24 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 free_name:
 	free(name);
 error:
-	strbuf_release(&sb);
+	for (; i > 0; i--)
+		free((*cpu_pmu_caps)[i - 1]);
+	free(*cpu_pmu_caps);
+	*cpu_pmu_caps = NULL;
+	*nr_cpu_pmu_caps = 0;
 	return -1;
 }
 
 static int process_cpu_pmu_caps(struct feat_fd *ff,
 				void *data __maybe_unused)
 {
-	return process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
+	int ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
 					&ff->ph->env.cpu_pmu_caps,
 					&ff->ph->env.max_branches);
+
+	if (!ret && !ff->ph->env.cpu_pmu_caps)
+		pr_debug("cpu pmu capabilities not available\n");
+	return ret;
 }
 
 static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
@@ -3270,6 +3277,7 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	struct hybrid_cpc_node *nodes;
 	u32 nr_pmu, i;
 	int ret;
+	int j;
 
 	if (do_read_u32(ff, &nr_pmu))
 		return -1;
@@ -3297,6 +3305,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 			ret = -1;
 			goto err;
 		}
+		if (!n->nr_cpu_pmu_caps)
+			pr_debug("%s pmu capabilities not available\n", n->pmu_name);
 	}
 
 	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
@@ -3305,6 +3315,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 
 err:
 	for (i = 0; i < nr_pmu; i++) {
+		for (j = 0; j < nodes[i].nr_cpu_pmu_caps; j++)
+			free(nodes[i].cpu_pmu_caps[j]);
 		free(nodes[i].cpu_pmu_caps);
 		free(nodes[i].pmu_name);
 	}
-- 
2.31.1

