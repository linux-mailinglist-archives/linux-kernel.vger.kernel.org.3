Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB752D011
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiESKEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiESKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:04:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019B994F8;
        Thu, 19 May 2022 03:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7vUAi5MXHxXxdN6J2aBieuzq0I24VCNbRpIyap/zKpC+FTZw85G7NsMqgfY1nYZ4XdKpQ2nfK7BVuBfanFoRopFx6QwGPXfDhazM8ldT4fxg9i+VhmmPQLOwwD90UA+ptSBEagb/pVFigpQLKBlyWw4GSFvgfGylJpKmo9CV5OpQbfp0LlMIgMxnnkYDhda9wUsfzV2CZbQ+xq/E+ipmvfC2Rx4zIIknrJY3NCYTj8/tVKcRfaX561n6dPSCRCVsHhM0sELvzNHLeJ/7nU0g1ti4rUKBLUAyyGDvakdU7Jm9RFWU0cteNTF1bszOy/nVjaZKjymVSGUVkGbULCjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OVvWqCB30ygs1JPU3twVNjPAE6gC/B7+P7tcX0QU40=;
 b=jV+esA2VL3rvCNMV2+6FwXObQOJvaOtphyaKtZ4awq+7oNgPp0y3vn76uEUefuaxRPDvLLqwZtYx/cbUu4iThKmmd4VM1tVsAsSfYZWaiGBWFnKDo1kqSvc26e+ELfg4m5DJ+oo6OFAHpsd6TAFJqoHdr1YhBte0AqJd12sA/DZuAu4mwOfcPK4dnOkPMk/16aj3JtMPytPe41v2QSgaDU/ZTQz5wOtZaKZprKwCcyfCI04wY1p3b2mydWjf/cD4GwESdDaOYWlRDP3nmWYghEyxukN54qMGoP2fjuJI8HHAbxwQTbsH1dYucM682FfYz/rUpuvSe0o9Q/CXseEw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OVvWqCB30ygs1JPU3twVNjPAE6gC/B7+P7tcX0QU40=;
 b=b7/xJnlHcfIz8nc0nSU3GInnX9R20Z/8pM9mQiWmeVEUoFNe2PCu5LgYJoHMuOLgvWAddr2f5b915FduiP0BvcZ/fzsmvSChBqRe43xAk0je65ISGeHkKCND/evzioPA7Omx9zL8eDbTtX7YD/ui3foR+cznkIRftuiRY5JN5RI=
Received: from DM5PR18CA0068.namprd18.prod.outlook.com (2603:10b6:3:22::30) by
 MWHPR12MB1934.namprd12.prod.outlook.com (2603:10b6:300:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 10:04:43 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::a) by DM5PR18CA0068.outlook.office365.com
 (2603:10b6:3:22::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Thu, 19 May 2022 10:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 10:04:43 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 05:04:37 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 3/5] perf/x86/amd/uncore: Detect available DF counters
Date:   Thu, 19 May 2022 15:33:32 +0530
Message-ID: <bac7b2806561e03f2acc7fdc9db94f102df80e1d.1652954372.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652954372.git.sandipan.das@amd.com>
References: <cover.1652954372.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb69846-bfc7-49e4-db80-08da397eff18
X-MS-TrafficTypeDiagnostic: MWHPR12MB1934:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1934D5ADDBB25F07EB37DE828BD09@MWHPR12MB1934.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkkwGfUuBJcUKAcPe2W6OgNtnQszm58dRvrO7767qicCOy64T4weaWXddEVGHk9NILTtGD21NsOEm5BcbpdcdHG5e3/xcD+rZqZDBhOwhGWMEoLB/rzH/scTLas4Ta+RfNpXbGathxnhKYlqk+WjDEo+04G4h0IJFvIL6jB+vEuhhlTwQGntxH/zL1glVY2hShOV7cgOpUfjgok0BBo9k3ssPrW5ddw2iI0IX+OCoa7KzLP62jpgGmhdx94EUh4f36mTM4DAeu0d7qF1HdgnLEycJpclWrVuKFfCnxuIESK//Lqldh9VBA768+niYVzv6ThquiX3iI7qzDvayt+VO9PHZ+psvnwtN8wJbUoJAAt6i3vPiVjn9twW+Q/kT45gI+j4eeaMRHYdXy0lHq83ARnHBOZkZVTwGEdqH3rkW/LzJYqEN39Z/LnZgkn/GvJvZIToTyt+PM+By0RwhhHdWeKCJlPKToRH2i8cqbYYpOACTVEFph4/oMSB24YEz4bPccbVxlWHZwAb+ySgXiS0ZGbhu/1em6fX1A2ik2xDKcSTtg3/RbCdlhPRZTKyGBggXwPAzJ63Zv0RBBzP77+LBRxZMgshYEOccVt9pRiy39P/TaDBeXU7RqBGSIyARkuvbYBk21Ocuy+ID0MXs/+ZsaEBRUhF3wUe+Yiqh72LyYkCd0v/aqiUc5RqgIrPiGzymM3rXlBJHwJ74whF3qh8cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(508600001)(86362001)(54906003)(110136005)(44832011)(316002)(7416002)(81166007)(356005)(8936002)(5660300002)(26005)(70206006)(8676002)(82310400005)(83380400001)(36756003)(2616005)(40460700003)(47076005)(426003)(7696005)(336012)(186003)(16526019)(4326008)(70586007)(6666004)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:04:43.3734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb69846-bfc7-49e4-db80-08da397eff18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use CPUID leaf 0x80000022 EBX to detect the
number of Data Fabric (DF) PMCs. This offers more
flexibility if the counts change in later processor
families.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c      | 10 ++++++++++
 arch/x86/include/asm/perf_event.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index c3e218dccf6e..233dd405dd06 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -30,6 +30,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
 
+static int pmu_version;
 static int num_counters_llc;
 static int num_counters_nb;
 static bool l3_mask;
@@ -629,6 +630,7 @@ static int __init amd_uncore_init(void)
 {
 	struct attribute **df_attr = amd_uncore_df_format_attr;
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
+	union cpuid_0x80000022_ebx ebx;
 	int ret = -ENODEV;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
@@ -638,6 +640,9 @@ static int __init amd_uncore_init(void)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
+		pmu_version = 2;
+
 	num_counters_nb	= NUM_COUNTERS_NB;
 	num_counters_llc = NUM_COUNTERS_L2;
 	if (boot_cpu_data.x86 >= 0x17) {
@@ -666,6 +671,11 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_nb;
 
+		if (pmu_version >= 2) {
+			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+			num_counters_nb = ebx.split.num_df_pmc;
+		}
+
 		pr_info("%d %s %s counters detected\n", num_counters_nb,
 			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
 			amd_nb_pmu.name);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 409725e86f42..af157aa74f4e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -194,6 +194,9 @@ union cpuid_0x80000022_ebx {
 	struct {
 		/* Number of Core Performance Counters */
 		unsigned int	num_core_pmc:4;
+		unsigned int	reserved:6;
+		/* Number of Data Fabric Counters */
+		unsigned int	num_df_pmc:6;
 	} split;
 	unsigned int		full;
 };
-- 
2.34.1

