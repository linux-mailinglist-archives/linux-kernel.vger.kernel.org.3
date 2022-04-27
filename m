Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67331511656
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiD0Lgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiD0Lgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:36:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B23B54E;
        Wed, 27 Apr 2022 04:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFj/TBer/orle9tdrdPNRtt9pC/SCQLUyvu0t2Mb9aFEwpCx5ZIc2S4ptfyCpDfCrqhGDNTxXjGvQLWM1bIVTBStWdEr6D5Tv0wGs+1ogKYsg8Q52UmZChQ3WhRp2dBk+s2Vx+MnG5qU6kggert7Q2N3dhBl0mziqXL9F+DjfQ5iZlKpyvw9tK+xtfYZNlg1z/8tAkIAyavE5pc3vtvnnpUxph8AhirU9I4K0L/7XRivFYYmaBptmBNLZebyF6bGniEL8GxjiP8yUMgtlCzj4oYrkILizcN15jl3NviMs4VOfnYH72JYEjKCham50mdhr/nCOS4vBZ+w+J8vWutV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgucctWqkTGzJrnIBdhGjmEweKiWRoIMb1HJGfRwRMk=;
 b=mUinYDYoXhfkYSgR+beVeh6lp1Vq+0cWIKy8PLuFNA4oI4gEijI4VTtwAmm356HvfN1EX3AezGTaeJEMNfqKSFHccJ1XvBksfkzyC5mmAI9X9FqPvT/+TKuMdwa4dItISIGNT3iW3wpSaIHiath4m4zAEw9ZZPomXBR6nXl1rkLvtUWNcEYLIx4TicJTv+XknBC+95JGP6Nk4J8r/sN40NWvqKewgw2WHc9W5mYo+O/2xwPiusBfvdYt93qP9FhgMNunxMIlsNOLTqMnsk76pEx318iv8SqcJpAowUaQvATWgpMK09WZAhnDRxJcSQWsx48P8Ag+V4GCsmbITyV6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgucctWqkTGzJrnIBdhGjmEweKiWRoIMb1HJGfRwRMk=;
 b=le7a/6AlxRG0Bh3JqdQ1zZXexl1Z/H4H/y1zLbeKWDB3tWiped16I4tDstTIVU/YnFU5UVmVYf9nRHJiyBKJeTZI2RdGfog4Xa3PPvshCaXp6Fmk/PY2H/1ZSOYruPPBkbxFKLTlncWxXRA5FD7Bd4LgKgCefRdj3iQJTQgz+As=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 11:33:22 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::1a) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 11:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 11:33:22 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 06:33:15 -0500
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
Subject: [PATCH v4 4/7] perf/x86/amd/core: Detect available counters
Date:   Wed, 27 Apr 2022 17:01:46 +0530
Message-ID: <05a64f35f0e78c42c5583e1c5da666186061ec60.1651058600.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651058600.git.sandipan.das@amd.com>
References: <cover.1651058600.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd1b01d7-b6a0-4d64-f340-08da2841bc77
X-MS-TrafficTypeDiagnostic: CH2PR12MB4086:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB40866CC06794DE4F5A9FE7878BFA9@CH2PR12MB4086.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DVD2GzU9/17ORXN5RN/YBcQZMD4LXIKi1FpM0BOzjrLY7TdPJtmXN6cu9jD3KolsQYfY55QJPU5SM1xKzSiqNTURA0xW2Acl4xl+Aee+NmiREI3IcAg4J3eZv1a/CYFZvW4pVLt14lBtkUOZanJKJrrTtaFhM1XBj4ldPzGaxi3304zVJIRhwigCXkDaqJThHmZon8oLY3v/zpyaKqh46EwVLorTq5IQSp9q0Eg4Zjk+l0qcnqNEpfZylNW0SVjXCfxZVw0mB00l3hmvJXE3nueoXzWQ4Pw1NgzCHNV5KmhWNcGwutvUjLGPBsBfFj19mokniyn7ug0OCLUYwBxbIx0MDySFpQbmuWaN4bOKPoRH4kNPWrFgC0FGLy/BH6z9EObKgZ0/Jo9nBES61oQNZlIfR2ldOVnUA48WHWKTXpWgr6s3GTUrwKz7aZx25cTCE2kcMMH7nWqGmuyGCo4ubyVFtX2pYbb9K9Tuo7mrcv8pAgP/yh9RZMsxVkMsCZEURNCyVybUralcKWwdcmuAZ+JDl85/prRqlZypEbzqy9HgZ1z0oRF1ZxO2IxhIJT/wHt6nwKMF4MsMZ/tl1Ud+oa1Rgnkl6d9w7ZOkhSnqF+za5WuoxmG2H/GenipzbwOD2woNn75ToiQJKFTzzAy25ftn3IoCENMVaCAA4sOabUD9u2YLf+YAKUvuVo2VXrWnJ7qESo1oJtqBsJvhZFyq3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(44832011)(47076005)(2616005)(16526019)(8936002)(5660300002)(83380400001)(81166007)(82310400005)(356005)(36860700001)(186003)(336012)(426003)(86362001)(26005)(7416002)(6666004)(8676002)(508600001)(70586007)(2906002)(70206006)(4326008)(110136005)(316002)(54906003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 11:33:22.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1b01d7-b6a0-4d64-f340-08da2841bc77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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

