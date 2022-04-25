Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4750D874
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbiDYEr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbiDYErb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:47:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB007E96;
        Sun, 24 Apr 2022 21:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAEcbqcZ/DRvPpw9fdLFiJl05DtS02zOqrU6ffnshD2MlhYFef6AFj3Cjdsy7kT2dXyetswLvgjQ84gNhin8gjQZACkRQ9hvVZM2+v/gSteGxpuHucZLAU1sS1oafmaJk4HceSiiUB9KsEyk3z0sYu/5jJBYJQmILQ1NTV9wTkzsQCUk8IWCanxh+X5SoW5ftfrNluRT/NxI/gZzFrwSIvFI1p0YOGQjIuyeO2KsE9wY+X/j70h1Ta7Cd9JA4xZdemp/c/KQUeGRs7hQc5cErVtGApZitUF52xhzqfuHnNO5KSB+5iA8XQb6XeJTuTwlheX3JOhaQigxSRsAtXTVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlm+lZCPw+b4YfKLjozDOqSqk713nirR/TvT22fq8EQ=;
 b=cib4KimeIgCBlRRmK4b+H5/vWC32b4sWbMq31oDm8AOM7Byg8NC7q0YK9Ma2j3QUh79jD30L+T1So92EMjwsOvneypL4xeWAH+yPKB5gmOk9Ksu0Y+BSQKJqQsb5oaXnFuvJNED1CF49k9I7C1KAElB7j71NgEFDClPNG+cAzbGtEpvbuX0SSc7D1Mdj2m9iMzMaiXUHhd17BA12R0owRRuMwwawEoz/Th9JW8R16/IhlS8ab2Rn+Ee+UCgnF4bi0zCH89snvTjnyTOkeBSGEG01C7jE7fRQWkGln3HDRoM0+8CSG20iC/2XARGpXQyLqW4k1JB6O6IeWitHQE0lkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlm+lZCPw+b4YfKLjozDOqSqk713nirR/TvT22fq8EQ=;
 b=K8+BvlibTnn4lhEnh/ytBmvk2o8dwhYUdIaiCkDxs/XH4Wqe3VLoEA8fpe3IM4UvCOs1dNDdyrwN+FItsgPhY3++KctkXZcqMlPQzFdpD1gI23ysZYvpx3cnMBRQOHEAaFgbb0bkDZSbyNZAYmxvDWbW9Lzb/1UKqIl5ecyd5GQ=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by DM6PR12MB4713.namprd12.prod.outlook.com (2603:10b6:5:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 04:44:25 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::89) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:25 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:17 -0500
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
Subject: [PATCH 2/6] perf/amd/ibs: Advertise zen4_ibs_extensions as pmu capability attribute
Date:   Mon, 25 Apr 2022 10:13:19 +0530
Message-ID: <20220425044323.2830-3-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1f1e35f-0d91-4bdf-b3fa-08da2676463d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4713:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4713EC68509F6E0307ACB962E0F89@DM6PR12MB4713.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qu1otGHJ+vsPae4Ud9cs+lXdK0ZQajw7paimwS+e9CaCyHVVeNED/1LncO3J1w4tRsBcXXQJnzgVkZZOB8zTIzxgbmgUmAsxRQGB0zgH2iUtu+iqEYQsNKPkyuZPr/psqiV/B+i32TkhlfH1ClS5Q3ibewp9yBTf1KSTWbyromIqGnQnecFVbeDTFEweoGBQgTcdaXGcM62neX0tryFRbeQjSKsirwWoXyu4E7PvkoT0LYkBMmmGKUxZz8gVMPQkxNwyks/l0Vhg/RwGA+bVbFOyU4YMNXX8BxpCSWEo5ueDYbKJhW6Rwe/9p5R2ZMVE/TXi7nLTW7ZTn05BMnmWkPyTndDI+gFMn2C5HEX67kddijy9arhNzi6w/BIj7ZKSpFkL3QQ1hAvjNirIZutKytEUu7ogq4xs5tKl1etBNhI/Df7Xc9BKl46jDOwkIEmkVBufEwlsT23wOyYEqWioGOIkdXlrqSMJaKYXQcJRJtRl2nyuYyGbJzHTnEc2qF36wa1hWLBF6jj0gCDRkXGq4sfLdwNaLx5DRc6weZjkG6bIGjdLN/ExDSfha91lZI4HVuHt2acNjWIj6/1F2uxCMnastSos8p0zYIV/VoowUQu+00inh5im4ivmnmVNc5AAXcw883wfFateQNNXtWat2n6IriMct5GZgxis7mQROL6vOnE0AnpNoEC2KWGRwIvTWpIKcUag8AxJa49pZuEL2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(83380400001)(70586007)(70206006)(2906002)(36860700001)(508600001)(26005)(186003)(16526019)(44832011)(40460700003)(4326008)(8676002)(81166007)(82310400005)(356005)(36756003)(2616005)(1076003)(5660300002)(54906003)(110136005)(8936002)(7696005)(47076005)(426003)(336012)(316002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:25.2166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f1e35f-0d91-4bdf-b3fa-08da2676463d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMU driver can advertise certain feature via capability attribute('caps'
sysfs directory) which can be consumed by userspace tools like perf. Add
zen4_ibs_extensions capability attribute for IBS pmus. This attribute
will be enabled when CPUID_Fn8000001B_EAX[11] is set.

Without patch:

  $ ls /sys/bus/event_source/devices/ibs_op/caps
  ls: cannot access '/sys/.../ibs_op/caps': No such file or directory

With patch:

  $ ls /sys/bus/event_source/devices/ibs_op/caps
  zen4_ibs_extensions

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index a5303d62060c..54e12bd7843e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -95,8 +95,10 @@ struct perf_ibs {
 	struct cpu_perf_ibs __percpu	*pcpu;
 
 	struct attribute		**format_attrs;
+	struct attribute		**caps_attrs;
 	struct attribute_group		format_group;
-	const struct attribute_group	*attr_groups[2];
+	struct attribute_group		caps_group;
+	const struct attribute_group	*attr_groups[3];
 
 	u64				(*get_count)(u64 config);
 };
@@ -522,10 +524,13 @@ PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
 PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
+PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
 
 /* size = nr attrs plus NULL at the end */
 static struct attribute *ibs_fetch_format_attrs[3];
 static struct attribute *ibs_op_format_attrs[3];
+static struct attribute *ibs_fetch_caps_attrs[2];
+static struct attribute *ibs_op_caps_attrs[2];
 
 static struct perf_ibs perf_ibs_fetch = {
 	.pmu = {
@@ -548,6 +553,7 @@ static struct perf_ibs perf_ibs_fetch = {
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
 	.format_attrs		= ibs_fetch_format_attrs,
+	.caps_attrs		= ibs_fetch_caps_attrs,
 
 	.get_count		= get_ibs_fetch_count,
 };
@@ -574,6 +580,7 @@ static struct perf_ibs perf_ibs_op = {
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
 	.format_attrs		= ibs_op_format_attrs,
+	.caps_attrs		= ibs_op_caps_attrs,
 
 	.get_count		= get_ibs_op_count,
 };
@@ -728,6 +735,7 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 {
 	struct cpu_perf_ibs __percpu *pcpu;
 	int ret;
+	int i = 0;
 
 	pcpu = alloc_percpu(struct cpu_perf_ibs);
 	if (!pcpu)
@@ -736,16 +744,26 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 	perf_ibs->pcpu = pcpu;
 
 	/* register attributes */
+	memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
 	if (perf_ibs->format_attrs[0]) {
 		memset(&perf_ibs->format_group, 0, sizeof(perf_ibs->format_group));
-		perf_ibs->format_group.name	= "format";
-		perf_ibs->format_group.attrs	= perf_ibs->format_attrs;
+		perf_ibs->format_group.name = "format";
+		perf_ibs->format_group.attrs = perf_ibs->format_attrs;
 
-		memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
-		perf_ibs->attr_groups[0]	= &perf_ibs->format_group;
-		perf_ibs->pmu.attr_groups	= perf_ibs->attr_groups;
+		perf_ibs->attr_groups[i++] = &perf_ibs->format_group;
 	}
 
+	if (perf_ibs->caps_attrs[0]) {
+		memset(&perf_ibs->caps_group, 0, sizeof(perf_ibs->caps_group));
+		perf_ibs->caps_group.name = "caps";
+		perf_ibs->caps_group.attrs = perf_ibs->caps_attrs;
+
+		perf_ibs->attr_groups[i++] = &perf_ibs->caps_group;
+	}
+
+	if (i)
+		perf_ibs->pmu.attr_groups = perf_ibs->attr_groups;
+
 	ret = perf_pmu_register(&perf_ibs->pmu, name, -1);
 	if (ret) {
 		perf_ibs->pcpu = NULL;
@@ -758,6 +776,7 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 static __init void perf_ibs_fetch_prepare(void)
 {
 	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
+	struct attribute **caps_attr = perf_ibs_fetch.caps_attrs;
 
 	/*
 	 * Some chips fail to reset the fetch count when it is written; instead
@@ -773,6 +792,7 @@ static __init void perf_ibs_fetch_prepare(void)
 	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
 		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
 		*format_attrs++ = &fetch_l3missonly.attr.attr;
+		*caps_attr++ = &zen4_ibs_extensions.attr.attr;
 	}
 
 	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
@@ -781,6 +801,7 @@ static __init void perf_ibs_fetch_prepare(void)
 static __init void perf_ibs_op_prepare(void)
 {
 	struct attribute **format_attrs = perf_ibs_op.format_attrs;
+	struct attribute **caps_attr = perf_ibs_op.caps_attrs;
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
@@ -796,6 +817,7 @@ static __init void perf_ibs_op_prepare(void)
 	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
 		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
 		*format_attrs++ = &op_l3missonly.attr.attr;
+		*caps_attr++ = &zen4_ibs_extensions.attr.attr;
 	}
 
 	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
-- 
2.27.0

