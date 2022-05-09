Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44E851F3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiEIE5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiEIEyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:54:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D42A1446;
        Sun,  8 May 2022 21:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwu1JFSJFESV2ZY0u1V2bGirvYqhXYqq8TiztFFlMoukMJCfjqPXGFKLUcH3UI2pw1xnezneY6fu/S3o5igX/HsYqu7UAeY3yrr6pB2LOdkpQLHFzmXGvU6eJQ+zgKPOQcXtIG8HefJaIDJY9M5jENWNfgk+aJqjEC2jGJL1lAM/CRZx1D8ayD3WM+SamkOq4g9gJCNCf+U4LTdagjJ3Riik63KrBQi+W95wDyYjVf3yTMWCqnkE2RCYNgjBToMZ2BN5ofmKjT3WG6DIUYfjqNJIdFpgTRdeCuzlNOYgt+LokwPEuQg6ZAYkwzCPjB5N6acZTN1TpYflBoaBcHSvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs+k5HhUJJ/Pgb+Ox3NwfAm79h933k7PrpYC0G0a4FM=;
 b=kgSS1gxyVYbm/Ehsize31zNDB0JBdwvsp8bjn1+89dI1yrjQeBrHbl8fCZMvPkrf7cExiP1Rxk+woXjJJEp2M5aQ/IqWPF4rGoi9v8QzGAM3S1iJGNuCCliqlqOyqhvLDUJC3MduR3KJwtHMRW28IwC01IWZ1ch8pCrkFSRt9U/60ru5L9mwbehBNYPBDwVIb/SptlmBeBcKV4qiDblQcBZ1b5cZoMjOUO6vQIbqJlZVqSOLqC94HBQD1e47MJEZplWL9pQ3nYwbsfA0j0FagtNNzJHNS2qUaMEeq93jrTuUOKaAPKFmf2TcSfDoZ0XVqVWVjl9p6pE3YKXUNbqM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs+k5HhUJJ/Pgb+Ox3NwfAm79h933k7PrpYC0G0a4FM=;
 b=w6vPOjnTCpWQaE81V+FOX4wGoghyYy49Xh6/9URnv4Amya9uQSm6y3gOSKlFFveNuplmr4fFP5nU/Et6L41rlK+gN7/aRLD4/I66aeA/LNe2j2p5GUHGJmlOv0Xi/fzu4YWbzw3Pus0Nxh5l+o/a4gLcWkDtD/E/vYBmTar8CkQ=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by DM5PR12MB1177.namprd12.prod.outlook.com (2603:10b6:3:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 04:50:13 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::3e) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 04:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 04:50:13 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 8 May
 2022 23:50:04 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <rrichter@amd.com>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 2/8] perf/amd/ibs: Use ->is_visible callback for dynamic attributes
Date:   Mon, 9 May 2022 10:19:08 +0530
Message-ID: <20220509044914.1473-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509044914.1473-1-ravi.bangoria@amd.com>
References: <20220509044914.1473-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1906eaf2-2396-49eb-38a7-08da3177676a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1177:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB11770E5D75AF139B2DA4F7A7E0C69@DM5PR12MB1177.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csd4dfIH4toiS1QpD+h2eYHaTAIw+m6aLXsgLKh8TYtyneoTMhXJ10AFtkTi0/5UbL5iSbGA8BPJCYx5lhnFv0x+FlHMhyWtwQ2+UwoYGgjCIwMhjgw0OiC2+/AQl64Z5oHgvrpUj9lyln21/LC5X4eoaGl7bqwtGwCAAwBCemqxjm+jyquhk/76lVvnXL39tM23cHVRZHjAQSi2L0kWmHV2oSzHUha5gTapo6W6dUni9HqZp17ATxut1y24/o1wrjfktAOSAZHmbjyw2pXS+uBLByTyID/VyxhXLAClrIskyegKsWoBunkDgAoSogcB+acUaP0tIFEP0ekaBCl05wIVDHL3PiM7glpa+EZsLTmfu/nS9hN2U7k5BEInyPavNmzWLN8KU+vqjHkpo5bMtMqmDodLsuuSDPts3lT4nKz+Us4IT7vOYqy1hUZVC19FxSr+MPIQ9hahsrTr93myKjLw9lPpTRNGb/gAEojUfCz0/qvBLcutTjQi1SIPSV6rNGy3cEPq0n0SRGDNDnQd1X/ubls3FAdyItB3fqCzPudTSdIb68Y+NzMq+NhgzDRzhv0G3m7NcKwBqPNCyccHqZZHrvnI8jmnCKnIoTwBTe0xoGs0qELGHgVfHFgvj/5EAjdEva4rVssoM5xC77K0fybHnP7D+IOsdg1TTEMHqRcmIFr8vzDSWrKbT9m+l4I39bz3GCIGycL+v3+Rv8Rq5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(4326008)(110136005)(70206006)(70586007)(8676002)(54906003)(356005)(86362001)(81166007)(508600001)(316002)(8936002)(83380400001)(2616005)(5660300002)(1076003)(44832011)(426003)(47076005)(36756003)(7416002)(40460700003)(336012)(26005)(16526019)(186003)(36860700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:50:13.0355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1906eaf2-2396-49eb-38a7-08da3177676a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, some attributes are added at build time whereas others
at boot time depending on IBS pmu capabilities. Instead, we can
just add all attribute groups at build time but hide individual
group at boot time using more appropriate ->is_visible() callback.

Also, struct perf_ibs has bunch of fields for pmu attributes which
just pass on the pointer, does not do anything else. Remove them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 78 +++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 367ca899e6e8..785212b5dfd6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -94,10 +94,6 @@ struct perf_ibs {
 	unsigned int			fetch_ignore_if_zero_rip : 1;
 	struct cpu_perf_ibs __percpu	*pcpu;
 
-	struct attribute		**format_attrs;
-	struct attribute_group		format_group;
-	const struct attribute_group	*attr_groups[2];
-
 	u64				(*get_count)(u64 config);
 };
 
@@ -518,16 +514,61 @@ static void perf_ibs_del(struct perf_event *event, int flags)
 
 static void perf_ibs_read(struct perf_event *event) { }
 
+/*
+ * We need to initialize with empty group if all attributes in the
+ * group are dynamic.
+ */
+static struct attribute *attrs_empty[] = {
+	NULL,
+};
+
+static struct attribute_group empty_format_group = {
+	.name = "format",
+	.attrs = attrs_empty,
+};
+
+static const struct attribute_group *empty_attr_groups[] = {
+	&empty_format_group,
+	NULL,
+};
+
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
 
-static struct attribute *ibs_fetch_format_attrs[] = {
+static struct attribute *rand_en_attrs[] = {
 	&format_attr_rand_en.attr,
 	NULL,
 };
 
-static struct attribute *ibs_op_format_attrs[] = {
-	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
+static struct attribute_group group_rand_en = {
+	.name = "format",
+	.attrs = rand_en_attrs,
+};
+
+static const struct attribute_group *fetch_attr_groups[] = {
+	&group_rand_en,
+	NULL,
+};
+
+static umode_t
+cnt_ctl_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return ibs_caps & IBS_CAPS_OPCNT ? attr->mode : 0;
+}
+
+static struct attribute *cnt_ctl_attrs[] = {
+	&format_attr_cnt_ctl.attr,
+	NULL,
+};
+
+static struct attribute_group group_cnt_ctl = {
+	.name = "format",
+	.attrs = cnt_ctl_attrs,
+	.is_visible = cnt_ctl_is_visible,
+};
+
+static const struct attribute_group *op_attr_update[] = {
+	&group_cnt_ctl,
 	NULL,
 };
 
@@ -551,7 +592,6 @@ static struct perf_ibs perf_ibs_fetch = {
 	.max_period		= IBS_FETCH_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
-	.format_attrs		= ibs_fetch_format_attrs,
 
 	.get_count		= get_ibs_fetch_count,
 };
@@ -577,7 +617,6 @@ static struct perf_ibs perf_ibs_op = {
 	.max_period		= IBS_OP_MAX_CNT << 4,
 	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
 	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
-	.format_attrs		= ibs_op_format_attrs,
 
 	.get_count		= get_ibs_op_count,
 };
@@ -739,17 +778,6 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 
 	perf_ibs->pcpu = pcpu;
 
-	/* register attributes */
-	if (perf_ibs->format_attrs[0]) {
-		memset(&perf_ibs->format_group, 0, sizeof(perf_ibs->format_group));
-		perf_ibs->format_group.name	= "format";
-		perf_ibs->format_group.attrs	= perf_ibs->format_attrs;
-
-		memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
-		perf_ibs->attr_groups[0]	= &perf_ibs->format_group;
-		perf_ibs->pmu.attr_groups	= perf_ibs->attr_groups;
-	}
-
 	ret = perf_pmu_register(&perf_ibs->pmu, name, -1);
 	if (ret) {
 		perf_ibs->pcpu = NULL;
@@ -761,7 +789,6 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 
 static __init int perf_event_ibs_init(void)
 {
-	struct attribute **attr = ibs_op_format_attrs;
 	int ret;
 
 	/*
@@ -774,14 +801,14 @@ static __init int perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
+	perf_ibs_fetch.pmu.attr_groups = fetch_attr_groups;
+
 	ret = perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
 	if (ret)
 		return ret;
 
-	if (ibs_caps & IBS_CAPS_OPCNT) {
+	if (ibs_caps & IBS_CAPS_OPCNT)
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
-		*attr++ = &format_attr_cnt_ctl.attr;
-	}
 
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
@@ -789,6 +816,9 @@ static __init int perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
+	perf_ibs_op.pmu.attr_groups = empty_attr_groups;
+	perf_ibs_op.pmu.attr_update = op_attr_update;
+
 	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
 	if (ret)
 		goto err_op;
-- 
2.27.0

