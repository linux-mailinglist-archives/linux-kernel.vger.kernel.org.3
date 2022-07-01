Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8205628D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiGACZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGACZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:25:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5120599E3;
        Thu, 30 Jun 2022 19:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZLB5/4AK9RROJXUgHsiEWQQTGyAf4Ta+Ri0eFTdo4VDEmx++hTahZVVZxRsODMCXX/Bw7WoN3lIAPO9mBwTGFx3zgQqBntYNmLaMC0i37zygagIVqMDZh3hdiL5VSxhS8gOBM872wG0wgGV//LeHMeOCl9SV6wZQXwvtrPD8tG4rJFh9A9hiL3i/8qD0ovgufwfvonK9YVoa97KikqeydDZCtvo48mUW5jJvjK9oDp/6gaMF/TUiy/4x/v+h2QApoP5Xb271o7NBa2RPMdzKZMLG0oto/SILvya1GLbIHLH9WJo9lCy5+ZWdMwA6FOcD5fUNSA/befSqPIn32iTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlBR2dc1fFuXyXAPYB0XrjdJ6z7CR+XqSzB+MBTahmg=;
 b=hob6iGYlnV0yqZ0fxtJB27MFl/OTtgY30ujOkkH6IFYVsIiABBES2CCFBEnJ2YL4iBfzzyI7/jTrQ6cUOIQYzfcdSba7n1RQv5qonnM/6CxPNWaatwXSoMf+WXIc3Z+hhbkIxfgDZtG5FaU4L34IuF8XeZxkW7SwM9RqJDk46MVHwVnrUQIJDh/RWsL+RIxb6wWFVMgkpFuacS4rBzcBjEAA9oJ0KxzgbLyojJZntswxnKC6UAc7lCUb3/TxOeeKRTM4G8pZXR2KApaVlIihupXj5bPwTBbL//Gh7QjBP3XLrMkD6IXiBSyuW5PLN2hHqsge3CQjmju5u9uMApTYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlBR2dc1fFuXyXAPYB0XrjdJ6z7CR+XqSzB+MBTahmg=;
 b=l3498rkS6phH6lE6NsyaAAr52V2rCrogMrgrf1XE2eOxik+G9r7MDwxlkFOcRkhOtPgF8FfryS2aJebzqBB+SsgrBh3azpDAgMQzM2yyxFKTsC1tCb65HDfm7NuWkL0g7qXvU6E2bc3dnKj5jJjTobUOJSCh9LWY5qqqsEcvA64=
Received: from DM6PR11CA0064.namprd11.prod.outlook.com (2603:10b6:5:14c::41)
 by DM6PR12MB2923.namprd12.prod.outlook.com (2603:10b6:5:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 02:25:19 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::57) by DM6PR11CA0064.outlook.office365.com
 (2603:10b6:5:14c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:25:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:25:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Robert Moore <robert.moore@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
CC:     <perry.yuan@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>
Subject: [PATCH v3 2/2] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
Date:   Thu, 30 Jun 2022 21:25:28 -0500
Message-ID: <20220701022529.2134-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701022529.2134-1-mario.limonciello@amd.com>
References: <20220701022529.2134-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e809a6b8-96d4-4b76-3d34-08da5b08f17a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FenvctmKN7oEmvz2y23wXr9bWkp2cfaVX6ZQ/eoI0RKPMyMEW+eFiYctuO0W+9yXbKeCnyRZ1+XM9A1qBgknopTuEJPlpAIWQk52MmpN8TkkeWZokUEgPE7ilIpC2a+2amwsKEKdOUmECkFdRJ7vo1KzJa8Qu3qy/3GAB8P7JRk78shcPHGYdv0/JDrpliQ5kmINnyLNDZj0LOI9QNPnt3sFJ1vRYnUy8gx4qa/QfxAHk0ko8QdcThFKLFaGO0z025+YsYLrgG3c4EvDFt2lbyZm80hBqL50xtRVmiduxYD5/y4YxX9Xx5SEAQi/wrr1AStNg9GGYeVl2ieUpWB9UBUbFP7L+1DIkYtCs6PuE7NugHSxcPbK/ZLO+R5vVULPCRirrlJFp9LxnzhLIASXhQHyUTjZdC8OSnk5O6x+isLOV0NrMja1Mb3kLra57WJD27kjGzKeUuPe3QLmdGoOFi/1lwNFpt/GcIBIfkNrPXZMXDe7oydcmCFpVrLZtl0ISG3QRkFQZ1G6o41vkAfLJqfjBWjWKxGd+w/oLxJz4vUPVIbOPAUnTcfVkcWR88C6s1AlpdgiR6jVd0yG89TM41XCwozl6qcSjBkOYFCAYTWqnzjSFcCCElj+I3r1gschDc+8RfzjE8EZvjzfcU1l8jc10u+ZfyqTkV3szV+enddSBc6y6XKSjWMI0wxXIC/pegr8VoZ+X6L4fkSfVVx87c0YVNliz4IHP4ltIczaNHhVyuc7lXNIkYzgtcktmhlY90MJvDwNH+h9HLJ1G+FD45FLT3BbBNMojxK40AFViCzzTTmpzj1Lf/j0sjYxbUGaE61i57eFSlUPGFGGQgkKuUbL7ah1Q1dOOz3vTGuGzIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(426003)(82310400005)(82740400003)(40480700001)(36860700001)(70586007)(83380400001)(36756003)(40460700003)(356005)(86362001)(478600001)(41300700001)(81166007)(6666004)(2616005)(7696005)(1076003)(186003)(16526019)(5660300002)(26005)(336012)(47076005)(54906003)(44832011)(2906002)(8936002)(316002)(7416002)(4326008)(8676002)(70206006)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:25:19.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e809a6b8-96d4-4b76-3d34-08da5b08f17a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and
when CPPC_LIB is supported") added support for claiming to
support CPPC in _OSC on non-Intel platforms.

This unfortunately caused a regression on a vartiety of AMD
platforms in the field because a number of AMD platforms don't set
the `_OSC` bit 5 or 6 to indicate CPPC or CPPC v2 support.

As these AMD platforms already claim CPPC support via a dedicated
MSR from `X86_FEATURE_CPPC`, use this enable this feature rather
than requiring the `_OSC` on platforms with a dedicated MSR.

If there is additional breakage on the shared memory designs also
missing this _OSC, additional follow up changes may be needed.

Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is supported")
Reported-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3
 * Rebase on top of solution for _CPC regression on some Intel systemss
 * Refactor to avoid #ifdef CONFIG_X86

 arch/x86/kernel/acpi/cppc.c |  5 +++++
 drivers/acpi/cppc_acpi.c    | 16 +++++++++++++++-
 include/acpi/cppc_acpi.h    |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 8b8cbf22461a4..20e257db50740 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -11,6 +11,11 @@
 
 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
 
+bool cpc_supported_by_cpu(void)
+{
+	return boot_cpu_has(X86_FEATURE_CPPC);
+}
+
 bool cpc_ffh_supported(void)
 {
 	return true;
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d64facbda0fb7..6ff1901d7d436 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -577,6 +577,19 @@ bool __weak cpc_ffh_supported(void)
 	return false;
 }
 
+/**
+ * cpc_supported_by_cpu() - check if CPPC is supported by CPU
+ *
+ * Check if the architectural support for CPPC is present even
+ * if the _OSC hasn't prescribed it
+ *
+ * Return: true for supported, false for not supported
+ */
+bool __weak cpc_supported_by_cpu(void)
+{
+	return false;
+}
+
 /**
  * pcc_data_alloc() - Allocate the pcc_data memory for pcc subspace
  *
@@ -686,7 +699,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		return -ENODEV;
+		if (!cpc_supported_by_cpu())
+			return -ENODEV;
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c6108581d97dc..d389bab54241d 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -145,6 +145,7 @@ extern bool cppc_allow_fast_switch(void);
 extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
 extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
+extern bool cpc_supported_by_cpu(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 #else /* !CONFIG_ACPI_CPPC_LIB */
-- 
2.25.1

