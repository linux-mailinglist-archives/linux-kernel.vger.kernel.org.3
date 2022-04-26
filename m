Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6950FE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240920AbiDZNK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350505AbiDZNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:10:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E4186FB;
        Tue, 26 Apr 2022 06:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xl0zM7gRLznPiRS/8pRqyQfXTyK7uT3SGy1Lqn6f1uyZkFCDyH3gG02uzIBrQ1ou5f2OZ9Fb9L0zjgkRUZKT5+bKPKUve+lHBkak1gaVDqQhWMzjixvfbL+FOSp4RJHvLCkg/nqBjFz0WPL2cX4IVIFX71czv+JaWesfmbXCxC+uGzH13kOARs8lVcJeaHPaTB5OyKeIwMva3EW5F6OMeXgela5NNThl549OBFsCGJ1OCR1WhYESH8REJ1tyKEYDRKpn2e3Uiwiw+g95sTwlL6/qM1Ru0/f051ETJRkONtWc4ey3UrVq6j7P9I92aUyLjLNOgexopLp/7Bdy9SNRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgucctWqkTGzJrnIBdhGjmEweKiWRoIMb1HJGfRwRMk=;
 b=NBXaLq0Sk0N39cTuXm1oElCeVi7a4U1GxNix8vIMX2a6RiHTK5eGh5fu1Y3v/Z5IJGPmHtWMlPbk19mlcsBmuiOEM6UEYGY2/HfT+63lmot+JMRgpDpu6Tq8bQdpgK0DCC05oc22mApnPopFmh6fB/whnrDG8mQFVS8WKM/PBetxGDntyDFb/CKeOb5giMFbP/roq6TcdcPh7uu4pcRFKO+DOUD1b2QKsCYEwCJiymIzA6nI6HQMXkhPq5Eb+H11pVB/eKWMjLdyIKivbP+Ob3ekBztzzalDsV4mv8Iwf1LgwXyqVJ1p0wwFKjI3t4hgJEQK5wDkpyGiAvX2AYfV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgucctWqkTGzJrnIBdhGjmEweKiWRoIMb1HJGfRwRMk=;
 b=X5L/+Eq34JnWvJeNoPF0/MDfdds/4jPbSg/H/dOffhWfN5hX779Br8KqrzP8VjZ3YIlIHV4p9qdOoHq+OSF7v+AgMWnofcOccmt5cQydcfay9U9S+JdlwKf1Dkchzfv6oN9ALxzRjKU/9gFtZ+xnuctV62f/CBAswdXfeV8YFCs=
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by BL0PR12MB2386.namprd12.prod.outlook.com (2603:10b6:207:47::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 13:07:12 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::9d) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 13:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 13:07:11 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 08:07:04 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>, <puwen@hygon.cn>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 4/7] perf/x86/amd/core: Detect available counters
Date:   Tue, 26 Apr 2022 18:35:35 +0530
Message-ID: <05a64f35f0e78c42c5583e1c5da666186061ec60.1650977962.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650977962.git.sandipan.das@amd.com>
References: <cover.1650977962.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f88b4241-6ed2-40b3-b052-08da2785ad5a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2386:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2386C3B4648F4A8E5D7B9DD98BFB9@BL0PR12MB2386.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjKMTyjCdG6+bBsbaSIt3pE8LpOPXMSvgzutz6M5BNpj1r3WswTKJScE+KsbRqKALk6iySNZofLuG20czCSMDcrvLqAXXga13yp9Jg2/392MfYFBvF5X/4v0dun2RRX4dyl7kwKcSbJpoEDm2xFi9jIskOyfXfAD8IUiNwollXn0HZEA/GFUt6HAYiJ5suTx3UB3t+sL7x+ll7kbzppMN5MmTuJv8ELzmvxJq+SZmnLRrRuazVH085GxfTtEeedkrmYePx45uEW5UKNzyPRQggcAgj03G5qFqoS8aBDEom/NbmL7TVbyM4f1CQs4o1bElTqm8V03onck3/ZP3oyExnzSqDOXEHscZbO9zEcGz68o/1HZCRez2A6JuDgnGvUMcOMA0Xmgagyb1YqrlB52U2TSJ51rpIwjNolCqrUz6iqpLy18zbKh/gYpw1qKFIS9nbr+Z4Eu1NlFx91EJjLKP2YOOCMYu8C6jMTsFUdQKUIzXfbpqdyfmir4xeCMrnawygpXwXcadfcrgsOxa1uHwiuqW1920B3EliwFDu3UeU0Qqt3sz04UjevJL4LWBDFM7d/pTj8B5kF+GnU8drdjTcdZL7la3Wqzg0H6qsZwbu6oWpz1J9aw6i4aEfgVWAVcGIXRh4NCog7q+/WtbfQ7F2MSqypp+3lgUn3cdv1FJJyOG8AE3gssCuN5OvvFwunqSTIZznLw5sQCJJYBjpD5LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(86362001)(36860700001)(110136005)(40460700003)(4326008)(8676002)(16526019)(186003)(2616005)(8936002)(7416002)(2906002)(47076005)(44832011)(5660300002)(336012)(426003)(36756003)(70586007)(70206006)(81166007)(82310400005)(356005)(83380400001)(26005)(508600001)(6666004)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:07:11.7007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88b4241-6ed2-40b3-b052-08da2785ad5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use CPUID leaf 0x80000022 EBX to detect the
number of Core PMCs. This offers more flexibility if the
counts change in later processor families.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c        |  6 ++++++
 arch/x86/include/asm/perf_event.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 4a61257fc58d..61a2fce99aa1 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1186,6 +1186,7 @@ static const struct attribute_group *amd_attr_update[] = {
 
 static int __init amd_core_pmu_init(void)
 {
+	union cpuid_0x80000022_ebx ebx;
 	u64 even_ctr_mask = 0ULL;
 	int i;
 
@@ -1206,9 +1207,14 @@ static int __init amd_core_pmu_init(void)
 
 	/* Check for Performance Monitoring v2 support */
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+
 		/* Update PMU version for later usage */
 		x86_pmu.version = 2;
 
+		/* Find the number of available Core PMCs */
+		x86_pmu.num_counters = ebx.split.num_core_pmc;
+
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
 	}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a5dea5da1b52..7aa1d420c779 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -186,6 +186,18 @@ union cpuid28_ecx {
 	unsigned int            full;
 };
 
+/*
+ * AMD "Extended Performance Monitoring and Debug" CPUID
+ * detection/enumeration details:
+ */
+union cpuid_0x80000022_ebx {
+	struct {
+		/* Number of Core Performance Counters */
+		unsigned int	num_core_pmc:4;
+	} split;
+	unsigned int		full;
+};
+
 struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
@@ -372,6 +384,11 @@ struct pebs_xmm {
 	u64 xmm[16*2];	/* two entries for each register */
 };
 
+/*
+ * AMD Extended Performance Monitoring and Debug cpuid feature detection
+ */
+#define EXT_PERFMON_DEBUG_FEATURES		0x80000022
+
 /*
  * IBS cpuid feature detection
  */
-- 
2.34.1

