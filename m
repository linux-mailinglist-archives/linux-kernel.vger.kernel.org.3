Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4450D871
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiDYErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiDYEr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:47:26 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D8D55A6;
        Sun, 24 Apr 2022 21:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwcELKrjPboIDvm85/kfui6cv84dqZOPEMAuZfDPUKMAxvlaIXus7NJFtQqw5sKxjnuAZyoluufNuRuGU82IM6+3OogE0xxKC0h0N3NvQ/TE2s9uWo1e06CUGIrCyy8ny6+ALASrFu1Rc1bFT2BBksRjLmYEXzD3wfY67xbGxODSm507NYV9MKvhfrcJpjDk+GvIZNlSG75HjP2jC78K5ZulPLxkTOUMkQZP4BKrcsx3PMufC23cREYWHSMkFj4bcNa3choVpgsmBOjYA9PMGPGxIHE01gV4G9JZazt7oCjI7V3CkcB0298WpUgc6vzaowhZnZ/jcguksRCL05m6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gey4F64cykEFeImbDTR139M2u8wfr1nEupFh4NaP7rg=;
 b=kutBnhuHMLNLyZ5GjUZaZJYbC7hQxxQjijFyTo5Z1MpVdqgs7ntXuMnvMaLlVvNHG6L9UsQy90VxDidRGFHTd3oo+YwQTiuIsy3c6+8lxcQMpYs78SFUuFYhTA/8aBsypvXJzAd3lXeeji/hn/kiQeHeBBLHf/EKbp5nJqUhXX160mi86OPuhvuyB/fENYYrXAEvkjakmZgSEq9fFOytY9P3pUJFWfcJQYOO4D4a9PSZf/BkvO+zQv63R3jDU/fhy6WbcaHpw1IWt2YuEogsGRxEyh80fNjVdHYgvBF+tB7yj/E9kWsEf1UGi4+SZtuS6mrmDMicQqnzPXg+gH3/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gey4F64cykEFeImbDTR139M2u8wfr1nEupFh4NaP7rg=;
 b=dGrCWnDxFhn5brkevL9LpJoBcNhBdgVX9F5AOd9CyNMVtKzF7WnEfwFGhj+PfsIBHG33+f/GSTzzd/6gAHcWVqVZ7Q3dJpjO5EDGctcqUSP1fhwD/N40K27ynVZV/6mK85q1AQm+GN6xCOf230AFqbxuWbkBjPPUY//oixkHTy4=
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 04:44:18 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::b7) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 04:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 04:44:17 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 24 Apr
 2022 23:44:10 -0500
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
Subject: [PATCH 1/6] perf/amd/ibs: Add support for L3 miss filtering
Date:   Mon, 25 Apr 2022 10:13:18 +0530
Message-ID: <20220425044323.2830-2-ravi.bangoria@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f3a867d4-6378-4d61-4053-08da267641ed
X-MS-TrafficTypeDiagnostic: SA0PR12MB4541:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB454113D1B2FAAD46F725D3A8E0F89@SA0PR12MB4541.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9rls0cPKBzu2NV//vJx0iiisl4fzLGDudwwRQCfkSHvAs8AlosX3pQ9IfFrJs0wlufJxmDTijPCBVz40tsVa9Qjr3dLH5FhFLQTlTRPmnSdOy7xJ8EmYi8TPyL3In89qVn2fctvppMaxRaTo4QdQBhRVZjVwPVN/aax2kUS0eklaD+IlBQnZz++pRHuaJd1Mc4GfaDYuPBc8tkXec+eJPsCBk/4Yo3G0yYBz4XnU1a38HBmvxMHgwun+V1DFqjLEN6htVaKnRmSVJvOdC+UfgppRIuBY8divGDJt1VQkKQtLvi8uyA3+06B46qlEsyJQ9jBEnekrIM8taouqpES8kZ1WUt3A9ZsGlqmB0aOUrM19macjA0pnlY1J6BXEcTnLuyNPh8AbUPh76wvyScXQEQtqkHlGuMP5zVdvrXKkJFypMoLX2RTHRHbPgHYwCy2ykXg7i5kj4fC84gtcCdTpjaG54E84pjDGW9dgI/EUYaTXprAHt89MpB6fq4kg36LAME7jkfXbHWWniF8aW02WeBti5Ymow4Ju6gOev02pqihgExSODYyj+IWa/ht3MbKmZAzVipbamRpqsbe19J17vhP0tcM0BvNWtoFz/ZXeWvoCqVcuZv7zq5xhPLzGfN0Dx4Bu4foWmFsY2h+NDaevQxvCNvk366nqYvoIrOFW4LjsF8IOvhMKbpIyekIzK1vvZ3iv2aCwNauH3d0g/aJsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(81166007)(316002)(2906002)(7416002)(86362001)(8936002)(44832011)(8676002)(4326008)(70206006)(70586007)(356005)(83380400001)(47076005)(426003)(2616005)(336012)(40460700003)(26005)(186003)(16526019)(1076003)(7696005)(110136005)(54906003)(508600001)(36860700001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 04:44:17.9629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a867d4-6378-4d61-4053-08da267641ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS L3 miss filtering works by tagging an instruction on IBS counter
overflow and generating an NMI if the tagged instruction causes an L3
miss. Samples without an L3 miss are discarded and counter is reset
with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
This helps in reducing sampling overhead when user is interested only
in such samples. One of the use case of such filtered samples is to
feed data to page-migration daemon in tiered memory systems.

Add support for L3 miss filtering in IBS driver via new pmu attribute
"l3missonly". Example usage:

  # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 42 ++++++++++++++++++++++---------
 arch/x86/include/asm/perf_event.h |  3 +++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 9739019d4b67..a5303d62060c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -520,16 +520,12 @@ static void perf_ibs_read(struct perf_event *event) { }
 
 PMU_FORMAT_ATTR(rand_en,	"config:57");
 PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
+PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
+PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
 
-static struct attribute *ibs_fetch_format_attrs[] = {
-	&format_attr_rand_en.attr,
-	NULL,
-};
-
-static struct attribute *ibs_op_format_attrs[] = {
-	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
-	NULL,
-};
+/* size = nr attrs plus NULL at the end */
+static struct attribute *ibs_fetch_format_attrs[3];
+static struct attribute *ibs_op_format_attrs[3];
 
 static struct perf_ibs perf_ibs_fetch = {
 	.pmu = {
@@ -759,9 +755,9 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 	return ret;
 }
 
-static __init void perf_event_ibs_init(void)
+static __init void perf_ibs_fetch_prepare(void)
 {
-	struct attribute **attr = ibs_op_format_attrs;
+	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
 
 	/*
 	 * Some chips fail to reset the fetch count when it is written; instead
@@ -773,11 +769,22 @@ static __init void perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
+	*format_attrs++ = &format_attr_rand_en.attr;
+	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
+		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
+		*format_attrs++ = &fetch_l3missonly.attr.attr;
+	}
+
 	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+}
+
+static __init void perf_ibs_op_prepare(void)
+{
+	struct attribute **format_attrs = perf_ibs_op.format_attrs;
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
-		*attr++ = &format_attr_cnt_ctl.attr;
+		*format_attrs++ = &format_attr_cnt_ctl.attr;
 	}
 
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
@@ -786,7 +793,18 @@ static __init void perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
+	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
+		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
+		*format_attrs++ = &op_l3missonly.attr.attr;
+	}
+
 	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+}
+
+static __init void perf_event_ibs_init(void)
+{
+	perf_ibs_fetch_prepare();
+	perf_ibs_op_prepare();
 
 	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
 	pr_info("perf: AMD IBS detected (0x%08x)\n", ibs_caps);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index b06e4c573add..a24b637a6e1d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -391,6 +391,7 @@ struct pebs_xmm {
 #define IBS_CAPS_OPBRNFUSE		(1U<<8)
 #define IBS_CAPS_FETCHCTLEXTD		(1U<<9)
 #define IBS_CAPS_OPDATA4		(1U<<10)
+#define IBS_CAPS_ZEN4IBSEXTENSIONS	(1U<<11)
 
 #define IBS_CAPS_DEFAULT		(IBS_CAPS_AVAIL		\
 					 | IBS_CAPS_FETCHSAM	\
@@ -404,6 +405,7 @@ struct pebs_xmm {
 #define IBSCTL_LVT_OFFSET_MASK		0x0F
 
 /* IBS fetch bits/masks */
+#define IBS_FETCH_L3MISSONLY	(1ULL<<59)
 #define IBS_FETCH_RAND_EN	(1ULL<<57)
 #define IBS_FETCH_VAL		(1ULL<<49)
 #define IBS_FETCH_ENABLE	(1ULL<<48)
@@ -420,6 +422,7 @@ struct pebs_xmm {
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
+#define IBS_OP_L3MISSONLY	(1ULL<<16)
 #define IBS_OP_MAX_CNT		0x0000FFFFULL
 #define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
 #define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
-- 
2.27.0

