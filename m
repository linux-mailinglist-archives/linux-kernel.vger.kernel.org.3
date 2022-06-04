Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8068853D591
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350581AbiFDEre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350565AbiFDErY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:47:24 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E915FB7;
        Fri,  3 Jun 2022 21:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwBcUPlQ/MWdWSrwT/SLPXSFQls3CxFOf7VZTlrKmjI71pTI4XlsdjkPeWc5KdAGL5y68Z94qoY/N2aSjNZmHwLZ3kuGzUM/iJAUO8er5lEJPj7faTHOMBmMI9DBQMZpOi3D13vPAjaANPzQqwLBMRibPTk7Ltn7AHJJTNla2H3rEwmVpvHqk214txD6VidHu9M+n3O5x9siQQVYrY1vRBSrs9AD1I2sVsojows0/EaK7cA9FH5C5tc0xjnf86qfW3iRWz78PexIGWYEkU2lOMVEFmzzWGVBmjOFDvK6vgI2DbTk6W2ubNPv/3HtPpiPgaCQmbQPj3SfX4L6b8MGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tudASsyNH8zVWWhLw0GXyRDg0DBMFqv8tI1ynr4Q45I=;
 b=HTQgKYJpxAAdzZWREVeLk7v+e9VHgITPbByHbT1y9LbaJvUWknxab+Pv39YzlCjpg7ONg+gNcffL+KuIqFbJ067y1elWWt6JmqLWB8lBkBevcmdvLQrgrN3cBPiLW+Sdr+Ej6WfWXGxCfedu2nz4YVakiIeg25Q9gAozwG0ceFlgQ4GGBZ0/pGtOFQ2xtjpYEurtN+DcqR5fIAWNDaisP9egy22V5yrPCBt1s+RkF2XclmXA+k6rRFW/W6130w5yxL6PHF4KXu8FEdeTcOABUBhI78c9W++1N0gEyOI1yTYgAkJwk+JMtL+85IawzguLkhWjDQ+y7Trl6swsyofLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tudASsyNH8zVWWhLw0GXyRDg0DBMFqv8tI1ynr4Q45I=;
 b=RTXZf0rbxqi61hS6ugj3V1sAhULaDSM4bh+PG8ZlGx3SITg86I8sjvaUpi3loWYXJ73klFkL1+2w2UmyDCY/NfqZetetk6kh0+KAEsmNihhSXWdynA+b2O5lOH9ot7aszZ4bBFhowBHwQqXLeywHVogh5jRX6JdiPgp+zfII5kA=
Received: from BN9PR03CA0948.namprd03.prod.outlook.com (2603:10b6:408:108::23)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Sat, 4 Jun
 2022 04:47:11 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::b7) by BN9PR03CA0948.outlook.office365.com
 (2603:10b6:408:108::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16 via Frontend
 Transport; Sat, 4 Jun 2022 04:47:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Sat, 4 Jun 2022 04:47:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 23:47:00 -0500
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
Subject: [PATCH v6 4/8] perf headers: Store pmu caps in an array of strings
Date:   Sat, 4 Jun 2022 10:15:15 +0530
Message-ID: <20220604044519.594-5-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 992c9320-3e6e-44d0-0678-08da45e54964
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3333B80DCF17E717CB84B0CEE0A09@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuYtJJW07jG/ZXfVX0QNUF1ftIJVmMjUOz0u8sq3lkHefcqydygKXxi7NmINSSWCWFAJig54P0bskZeCJyLW+ob7u+fbWFieZotIZiMK479W3TUmXld+VW62lYD29F5juMiaafY/a+fcxCNsSLB6D4QqLQyyv+f3yvm5d7V5nZz361iTHiH/Tp69g2+c9fXyic32C5NH5ZEYsPYyeuhx9j473EOctVmYbMdXf865VLJ9uwkrFJupoxFpZitXXJsXyUz1tY/FsRvpYvoauOSGy5BU7oHvVsgeDXfQFLsDtiOLV9qWfd9IV/zfePDsFSL8gQs5xq2IGFoojuTlmP3kG3ug8KH4CsYKPrA4Bn2gEse0Uf+lg/X0ToVIfk+H+6UR+ORls+436S67VSayHpFeQj0L0N4I/R9Ma9cxhUSr/9OyImQvHJL+26Bd/5PvlBRAAxOV//1JWu+QcrMthtotc8r8JyQED/rwUpKtXC0vSbXl9Mx98TXFHOJGAjEvhgnzA38LDXE/PeWgeFHWQGjhkbm8WEwU3TST4UrbZvtc1lDPnHNagmnk2rkOeTEzm3/7Lb0CjPR6/a5ZdAr3FSk4idQ54kK9xmezVulonW3rraETxlqAw/rioHS3xMwehnxrRcihhBAq+5mUogezkwQiI6QFxS4ki2+iYWKulnn+16mLhKmuOTMiG8DNjGFvPj6WiMjMZowH6JmxnQFhnQGoQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(36860700001)(7416002)(83380400001)(54906003)(6666004)(7696005)(5660300002)(316002)(36756003)(82310400005)(1076003)(70586007)(47076005)(70206006)(2616005)(26005)(426003)(186003)(336012)(44832011)(4326008)(40460700003)(8676002)(356005)(81166007)(2906002)(508600001)(6916009)(86362001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2022 04:47:10.6684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992c9320-3e6e-44d0-0678-08da45e54964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/env.c    |  6 +++-
 tools/perf/util/env.h    |  4 +--
 tools/perf/util/header.c | 63 ++++++++++++++++++++++------------------
 3 files changed, 41 insertions(+), 32 deletions(-)

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
index ee7ccd94e272..ca5b1f03810d 100644
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
@@ -3202,27 +3197,26 @@ static int process_compressed(struct feat_fd *ff,
 }
 
 static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
-				    char **cpu_pmu_caps,
+				    char ***cpu_pmu_caps,
 				    unsigned int *max_branches)
 {
-	char *name, *value;
-	struct strbuf sb;
-	u32 nr_caps;
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
@@ -3231,12 +3225,10 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 		if (!value)
 			goto free_name;
 
-		if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
+		if (asprintf(&ptr, "%s=%s", name, value) < 0)
 			goto free_value;
 
-		/* include a NULL character at the end */
-		if (strbuf_add(&sb, "", 1) < 0)
-			goto free_value;
+		(*cpu_pmu_caps)[i] = ptr;
 
 		if (!strcmp(name, "branches"))
 			*max_branches = atoi(value);
@@ -3244,7 +3236,7 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
 		free(value);
 		free(name);
 	}
-	*cpu_pmu_caps = strbuf_detach(&sb, NULL);
+	*nr_cpu_pmu_caps = nr_caps;
 	return 0;
 
 free_value:
@@ -3252,16 +3244,24 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
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
@@ -3270,6 +3270,7 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 	struct hybrid_cpc_node *nodes;
 	u32 nr_pmu, i;
 	int ret;
+	int j;
 
 	if (do_read_u32(ff, &nr_pmu))
 		return -1;
@@ -3297,6 +3298,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 			ret = -1;
 			goto err;
 		}
+		if (!n->nr_cpu_pmu_caps)
+			pr_debug("%s pmu capabilities not available\n", n->pmu_name);
 	}
 
 	ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
@@ -3305,6 +3308,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
 
 err:
 	for (i = 0; i < nr_pmu; i++) {
+		for (j = 0; j < nodes[i].nr_cpu_pmu_caps; j++)
+			free(nodes[i].cpu_pmu_caps[j]);
 		free(nodes[i].cpu_pmu_caps);
 		free(nodes[i].pmu_name);
 	}
-- 
2.31.1

