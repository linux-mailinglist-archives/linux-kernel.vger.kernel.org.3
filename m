Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434E4B4D56
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbiBNKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:52:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350083AbiBNKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:51:10 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124A6D39D;
        Mon, 14 Feb 2022 02:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay70GTvrHIT5vYSOhfujfd+oMaCe09tlsCP8hQ7GifGDgsMFBFXlkaMwvAE0Mngt4TO1z+wEhfkWVIYZDiPJfnVHNowSArFqiy3RVZP4eESaMd2SmK5W6Oon9Umw1IKeFECXFescOHNdXzd43kNKd2Fiq9Xi1qlAHzmfLiv9AROTYEqxxk0HgMI6a7tgNX+Mb/G32Dq/RuUaSA4r2wktNvZRMXV3rb1LPylOUhKOSUv/6v1yWU0Kv2+C4dCR8AG2EhPdg3hEDNrmqVGFgktbWSfIdH9SVCoowbeP7ivihkRHjVGzKnrOH3NV0GXML/TfVUDL7Q0JbQjdr85l3uv1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfkqBk6TaZEpyz4CxeBo7+E5Pr+Td4vJVvuYHb5o1So=;
 b=ClmeX1lFKULTSQwxbdmQHEGtNp8zV/slhMQov5u4MWOMWLUOqNxi8FknL+2h6M6ORbHFAD2P/bckyO+rWkZs/m8qXsgVQpSVJJ1r2IuRDv4puUhkHYgQdSmNqdJ06GYcLnyHulRRAd9qjHgvRKeZlloHINA9S5x2M1uDrk3Achfgajpa3qHyKTM6JPgQ/pFVdzb1T5v4YAm8ji8GevKj7e/xktFec3VgmkAhvgb0s+XRJJh4oqP41u/BLWkOeKsnQp7idaouxyOqbn7ziyBi5H7CH8+YNnmm875xX8Uw2iQlg4TIeKjB4DnTJhgcEKXhoS+s2xpthGlJeWTkR9yvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfkqBk6TaZEpyz4CxeBo7+E5Pr+Td4vJVvuYHb5o1So=;
 b=idAGQbcTt4+QETukzel5ySvoqNKrY02TFqr+OCQAbJVtOFYfaE64NLRStkj8w43Ypjp8+x+sYINh7NKshzr8aTO461/bUDpFKZHJdJzkUUioZJ4LAXb8RpNr2TAT0L8F//ts2Q3Je1dD4QJ8u/cdY6KrWpo47Xe7P1eGdylNCLU=
Received: from DM5PR19CA0058.namprd19.prod.outlook.com (2603:10b6:3:116::20)
 by MN2PR12MB2974.namprd12.prod.outlook.com (2603:10b6:208:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 10:15:19 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::d) by DM5PR19CA0058.outlook.office365.com
 (2603:10b6:3:116::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Mon, 14 Feb 2022 10:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:15:18 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Feb
 2022 04:15:14 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Deepak Sharma" <deepak.sharma@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH 2/4] x86, sched: Move AMD maximum frequency ratio setting function into x86 CPPC
Date:   Mon, 14 Feb 2022 18:14:48 +0800
Message-ID: <20220214101450.356047-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214101450.356047-1-ray.huang@amd.com>
References: <20220214101450.356047-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c4133ca-e670-4b48-78a6-08d9efa2e702
X-MS-TrafficTypeDiagnostic: MN2PR12MB2974:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB29744A222655A4F379F1776AEC339@MN2PR12MB2974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ0opLGkJMYd3UibTSHFag4QSqObOriRfeERmq92exhqS9J2U3UsNCXTuDiIZB5Db5SFjfHOWk/lhrEa1GKD9/qKoHxT/zYP7QSuUtA3ppNe+N4/EuzwU08sSsk7NdvU2K5HL5GXHZd/bjMQ0E800M8OscFk8Upo0YP9wv7FcVWIxONQ56W/AqioEekhBM/p8qGw0k86HmwMGMUqUqouHviEY7hoHu7VQIffm3geQOtG4sKa9QdoJAJRuwkyZePxRT4hvxC0uOsHcljwyEYq+xwhEgbbcycOWm44mHLd/HIWPlaJ14N3psyOXmB28xi3owKKHj0lZ5bXpnFRjc0EWTOgH4bK14rdFJ6CCyS6zp0lpxgIuh55doKXmQkUTZLtF4yrVT4tW6uklrEZRjqJ5cTmML2+Utsf3T3FGm3f3WowDY/3IVSZ/IUMCa7XFHoK30wyK2exVizr4dCoSAL+F3czE/vfwhbAZPEO+NXNmrddWghuhL4jdnlWMwze59fN4GE2G9ekFQC1lbM06tlhV4Is2ykkAww7lxfMIsctVSlh+svm8iMioyOjrajBP+h7yvdfzUgTtwtGVcuV2gOOxArTdrYkzufodndrWpcYf3eSYcAVtgbqfa15r9O9ld66n8zdTFBSs31Q6Wr1fLjR1liivqnsLQqCzLDfbJ5thzjW+e7ZsAURcHID9NjI9LNeuow493wTOAveOhnJQLfT+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(356005)(316002)(110136005)(81166007)(2906002)(54906003)(8936002)(4326008)(8676002)(6666004)(70586007)(70206006)(5660300002)(86362001)(26005)(186003)(1076003)(36756003)(2616005)(16526019)(336012)(426003)(47076005)(7696005)(83380400001)(36860700001)(508600001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:15:18.8293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4133ca-e670-4b48-78a6-08d9efa2e702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2974
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD maximum frequency ratio setting function depends on CPPC, so the
x86 CPPC implementation file is better space for this function.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/topology.h |  9 +++++++
 arch/x86/kernel/acpi/cppc.c     | 40 ++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c       | 44 +--------------------------------
 3 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2f0b6be8eaab..168ade7d4007 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -226,4 +226,13 @@ void init_freq_invariance_cppc(void);
 #define init_freq_invariance_cppc init_freq_invariance_cppc
 #endif
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+bool amd_set_max_freq_ratio(u64 *ratio);
+#else
+static inline bool amd_set_max_freq_ratio(u64 *ratio)
+{
+	return false;
+}
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 08d823d72586..f0be5058e3e3 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -6,6 +6,8 @@
 
 #include <acpi/cppc_acpi.h>
 #include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/topology.h>
 
 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
 
@@ -47,3 +49,41 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	}
 	return err;
 }
+
+bool amd_set_max_freq_ratio(u64 *ratio)
+{
+	struct cppc_perf_caps perf_caps;
+	u64 highest_perf, nominal_perf;
+	u64 perf_ratio;
+	int rc;
+
+	if (!ratio)
+		return false;
+
+	rc = cppc_get_perf_caps(0, &perf_caps);
+	if (rc) {
+		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		return false;
+	}
+
+	highest_perf = amd_get_highest_perf();
+	nominal_perf = perf_caps.nominal_perf;
+
+	if (!highest_perf || !nominal_perf) {
+		pr_debug("Could not retrieve highest or nominal performance\n");
+		return false;
+	}
+
+	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	/* midpoint between max_boost and max_P */
+	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
+	if (!perf_ratio) {
+		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
+		return false;
+	}
+
+	*ratio = perf_ratio;
+	arch_set_max_freq_ratio(false);
+
+	return true;
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 617012f4619f..0718cc7649a4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2097,48 +2097,6 @@ static bool intel_set_max_freq_ratio(void)
 	return true;
 }
 
-#ifdef CONFIG_ACPI_CPPC_LIB
-static bool amd_set_max_freq_ratio(void)
-{
-	struct cppc_perf_caps perf_caps;
-	u64 highest_perf, nominal_perf;
-	u64 perf_ratio;
-	int rc;
-
-	rc = cppc_get_perf_caps(0, &perf_caps);
-	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
-		return false;
-	}
-
-	highest_perf = amd_get_highest_perf();
-	nominal_perf = perf_caps.nominal_perf;
-
-	if (!highest_perf || !nominal_perf) {
-		pr_debug("Could not retrieve highest or nominal performance\n");
-		return false;
-	}
-
-	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
-	/* midpoint between max_boost and max_P */
-	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
-	if (!perf_ratio) {
-		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
-		return false;
-	}
-
-	arch_turbo_freq_ratio = perf_ratio;
-	arch_set_max_freq_ratio(false);
-
-	return true;
-}
-#else
-static bool amd_set_max_freq_ratio(void)
-{
-	return false;
-}
-#endif
-
 static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
@@ -2187,7 +2145,7 @@ static void init_freq_invariance(bool secondary, bool cppc_ready)
 		if (!cppc_ready) {
 			return;
 		}
-		ret = amd_set_max_freq_ratio();
+		ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
 	}
 
 	if (ret) {
-- 
2.25.1

