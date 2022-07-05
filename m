Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7EC567678
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiGES3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiGES3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:29:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01F210CD;
        Tue,  5 Jul 2022 11:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNQbK6UDCnjcS+jDvsdxldwSJKzrzUOsJ3b2UNzsmmVF4OdPdIG3sQxSwLq6dBtHnjrsQu19fnanMwiDH0lnoqPFIs3prIoHwK5c7aUinS1YwKVEKqpmPdtceZEMOGm1JVri3Ry2SLU/4zY5U7rbgd7Unet+Kkdoq+KXup0oDstRlcZAwPU+GhYcXwFrKbTC6NcSFQDgdHoS5qr8dlyI7zaHieIimyZSfhEXmC77o3mmPJXtv15Ef3PE1eq1W2NMIaQzpvump4nkg0N00l9V/aora8jkMkslo7QJ5vMuzIyCy0HZQhs5Gr8Ic53mRl+OgNU33sk+UqaLc9tMhYX30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+BI1+9U2uxb11Ha4XRUgadKW5czpJNwX3qo+bOJKwE=;
 b=HDCBKYD22Kro842EspowF1kSoBjuVjEPQmPqo1fIEH5HX1nX4yrzKT9ZoGBsOz9yjwEm/cvkLv45/wr6DZGf1p2MuGcqR3p+Fs7teXXAr3knYtXue8q3ECfJbuowXcbnaW9eOqUphXs59MWPmv00SCwtk5pk9+oMnsqMApwV+mDTE0VOjmXav3NXVpuxK/lDB+sgYeuhtXQLSue3PH5JhprEYR61d7ZwxgbZa5V6bITLHegrObMijX9P+qcqyMfI8aqYg6JFn1sYjgWneEofMWZn8vp3VRwOjMTokYK6NtoyiIFqfGbI/pgE1FpmONWbnoxU20ANZvGpYS7psfbu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+BI1+9U2uxb11Ha4XRUgadKW5czpJNwX3qo+bOJKwE=;
 b=2x+Yqq7Dc7NSrAiVt+z5nZlBYm9MLv0bQZDbXbF23LiMJqC596fXoioqsYcSUVIEqaKtySIMVCmsJ320f/xZ1jPm5PclfoJOuzzdIkK57yN/zkVX4NmJ+gZ2woMmfdJfXxbUdLfGOgJQCq60o469C0+jJUJiz2RvD6pvR/aHu7s=
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 18:29:30 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::97) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 5 Jul 2022 18:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 18:29:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 5 Jul
 2022 13:29:28 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Robert Moore <robert.moore@intel.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>
CC:     Perry Yuan <perry.yuan@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>
Subject: [PATCH v4 2/2] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
Date:   Tue, 5 Jul 2022 13:29:15 -0500
Message-ID: <20220705182915.11663-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705182915.11663-1-mario.limonciello@amd.com>
References: <20220705182915.11663-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9f072e7-b717-4feb-6c69-08da5eb44d10
X-MS-TrafficTypeDiagnostic: MW2PR12MB2442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFqlybkspjqX6k/KbMjYSxxFQy/rxc08l5iYam9cl54ctzRESN4+N+G5PrjhOMiPXQ0bQG/jhgM46gQXJmJKjqJJG7lzqVRU7urkRiZtl32qultQp/9EEu8utQS+uJ5TBXhRuvOfcSukZwrCWX+MIVf42i+jwFTQHmngqGDRx8FNefX6gu0DO3zHp3wKtSB4OUa0KIHBxUML5v+AWLptgJsLnVG3sQ5Caw//ex4BsfGgVqY8ztzMzrEYwZED7cMh0K8FYM7/DcTaIcZ4hSQd9WmCCY4t333i15ty5W96eDrsLFPzrXNU1XP9JZO6xQPyxCJEAYIlVFNbZJAZvdK8yc+qDAHP1Bah5kEHsQfMFZKUh2n77FyFGbNTvgApcNY62pfn9ltQfokcF0DCqfhBPxWjW7eOptg/ww76F2SiirS69a3w8RjNEXAT+YJ2XfCH1NRSOfmxgcrzJrjwASvyEOedgvf4RgGQ7Oj2rlT38ZVfQzns8u+QrcQ8XNxQqUzVQswgwgsuhXDHruUsaIm5vqOSQCp6mlAy1JMit9MfQIbBKabdTJyBAIkFqTAkmuyRMYFNaZK4ta4RxqP6qpTc2uLwOavRxbTvvbtjLawpexZtVNGmeIdwgRm8+XXTpKdtgmIj/6fD0i2b61zuGrrCW3ojOlOimkokPusu+FXIh9LqPdp4PPJrL1wQ1MlBYXC0cwEudW3GasIqTWx26n9BCbhMKMGO/CYXotoXr9n3Szh+l2b+NnIMyrWZtt/I8UPCgUXyhZMKwc0Bb4GMKgLtofBzJAdpQ458jDO2nPO9qsIcC9h4dvmzO17To8CvwTgf1MXNK3a3+ZoPhIlGT6OAZjzCXFzU1e3nnhfv4PQdx+X+x8IM8iDA48ejamafIeBG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(1076003)(8936002)(86362001)(478600001)(82310400005)(44832011)(356005)(70206006)(70586007)(4326008)(8676002)(36860700001)(82740400003)(34020700004)(5660300002)(40480700001)(2616005)(7416002)(40460700003)(26005)(81166007)(186003)(16526019)(316002)(36756003)(47076005)(7696005)(54906003)(2906002)(336012)(426003)(41300700001)(83380400001)(6666004)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 18:29:30.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f072e7-b717-4feb-6c69-08da5eb44d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
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
v3->v4
 * Explicitly check for AMD before using X86_FEATURE_CPPC
v2->v3
 * Rebase on top of solution for _CPC regression on some Intel systemss
 * Refactor to avoid #ifdef CONFIG_X86

 arch/x86/kernel/acpi/cppc.c | 10 ++++++++++
 drivers/acpi/cppc_acpi.c    | 16 +++++++++++++++-
 include/acpi/cppc_acpi.h    |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 8b8cbf22461a4..734b96454896b 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -11,6 +11,16 @@
 
 /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
 
+bool cpc_supported_by_cpu(void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_HYGON:
+		return boot_cpu_has(X86_FEATURE_CPPC);
+	}
+	return false;
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

