Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6624634A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbhK3Mmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:37 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:44819
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241943AbhK3Mlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF9QgEdI3cp4Wnf3M3rdd3NEb6mNF2nEnO3mG0jOZiyFNus8aFcCNV0D9YswMF05pAagh9mP07usb52/K8r5VFVuM4l/UIpl0iMogplk9Ts55Kx9U0yiuaBmjTWGF01luBHf8qt6uT5Q43KCDzF++BYwFRmca4mVvHt3G2tkV5fIkED1yOhn9ZOgANGuhBk63Mgr0iQh5mYTkspz5fwnM47R+DN4zAwaNmYo5aTavwvMVVSAYWqpEHbyYLU/VlqVxzSFLrfdlMtFvBlz/JfJ5CNDlfrNCJ8kX54zf35qVBRLQrjNBq5kZYp6zvj+/nQRAorRgf1o/5jhsD/W7BEL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu3SrDgaX6m4px0wjGMTsorM326powF56ZcWTWjHoWA=;
 b=OJ1IOb9iIW8GgyMnWqDmUv6mCe1ruTz2G0VxATvJGP5vGpvFFJecvvGskJr834/toQIuErYUYqioNFEaO4A97XrP04akTjB/5tYma4pVbMvNJ8zPX779LoaVA+00tjfymnJkmQQeDy1gFwv32pt7wtghBAMbCzWvOyHt1/eXPmL0g0vEKkiTaFI4pY/QfBPWIPkYAARELp1tiKFtm0gOTLSCmWISPl8jSLPn3Nbzajv44RVsLi1od0MTb5ISpqMFeJ6kaYhwebaCRXY07u7sBhqqgD8HUerBM/m2tPiLl0JIGII87obJEO6UFNNOU04TlEcY3qRG2H8DChwVh8jPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu3SrDgaX6m4px0wjGMTsorM326powF56ZcWTWjHoWA=;
 b=g3Xvx59gFuPG/WZmLOQc+FC0qMgfi9lrhB8UzwRpU7WR+4tOMig9pvR9gNNteLJt9FX5zqgmJCufDlhgvif6nwn3fLFcO4Wa/diiFT37qLUeRbuGmuz97gK9Eut+xKt8yrwksnNmJf3/gbMe7vEUj31v7Kb7Tr9MJLRIx5sD3vg=
Received: from BN6PR21CA0009.namprd21.prod.outlook.com (2603:10b6:404:8e::19)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 12:38:23 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::51) by BN6PR21CA0009.outlook.office365.com
 (2603:10b6:404:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.2 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:23 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:18 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 18/22] cpupower: add amd-pstate sysfs definition and access helper
Date:   Tue, 30 Nov 2021 20:36:37 +0800
Message-ID: <20211130123641.1449041-19-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a79cbbd-aa6b-4955-c17d-08d9b3fe4c6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4484E9FD22B12120CF32044EEC679@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuuE6/gkkT7xpLXimDyjbmz+F3S4V/ao/kTu1j79geV/5V/s6/N0jn2TjWVcRvc35QZM7egjeKRMnABwmqOYzawi7tG38Bh//8DCkL5xKOkFy95dB4MdrYc/PInsxtAjTn4iJI4U/+uJhmBrzupDk+n1Ln/yhXBKlzrhOTH881OHa2PAA36JzNsQWREBGGCd8f3zImMzeoQeF4u9z4JnmwdB+nHTz7g/9emEnwFQHWcl3YvWPAGuAT/XnahSZwKawTpSKNAx7EIphVOmckNO/ec7HrmN9WkFXCQhD8ipOBwqSFhWt9mtw48KedVxzXixBu/ucNdMK4z2AHnf1ilYciCILcP9KI5MlHcNm04d7GLWsahzmSy2fes1NptOnlgX0s4QegPAm10McufoaXw7H1GBMiHqhJ9Uk86Rav+3IuZkF9Pl6krYp3CQo4C8C0hTTSdoUUkjuE9sJeYyG+AuNArcVG2Ozikqy1Y5Lwf6MhRkkgzm9MT8UG4wCOdr2Gr5RibJdTr3id9Ay4F823OUs1qjAQmDkS4GDKOKFFwcXXeK+xmyZ6x4J4p61u5I/PXNnplmXr920xgeIoRUKLpBTNIB7MKq7o3N/ceY25wP4MAymlvZzquAdlcyiQjDpcKlRndUwdHVMoRRAMoGRpz4jtXk+j+erO5rRuSiD3XZ5RzDX7Dryt944PR28gYv6G7G5vXzeZ9gsFBIkBJ2tbwrLcjhacyKUdyjSVTVxG1F8fVZkX5S4aXuwwgGeu8X2B4/fNlI4dls4t3fvvDTzJix/HL04TUUWcfumSifjRdxr6c=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(316002)(16526019)(5660300002)(86362001)(186003)(1076003)(2616005)(6666004)(336012)(426003)(54906003)(4326008)(110136005)(82310400004)(47076005)(36756003)(70206006)(83380400001)(8936002)(356005)(81166007)(2906002)(36860700001)(70586007)(508600001)(7696005)(7416002)(26005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:23.4522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a79cbbd-aa6b-4955-c17d-08d9b3fe4c6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the marco definitions and access helper function for
amd-pstate sysfs interfaces such as each performance goals and frequency
levels in amd helper file. They will be used to read the sysfs attribute
from amd-pstate cpufreq driver for cpupower utilities.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..14c658daba4b 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -8,7 +8,10 @@
 #include <pci/pci.h>
 
 #include "helpers/helpers.h"
+#include "cpufreq.h"
+#include "acpi_cppc.h"
 
+/* ACPI P-States Helper Functions for AMD Processors ***************/
 #define MSR_AMD_PSTATE_STATUS	0xc0010063
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
@@ -146,4 +149,31 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 	pci_cleanup(pci_acc);
 	return 0;
 }
+
+/* ACPI P-States Helper Functions for AMD Processors ***************/
+
+/* AMD P-States Helper Functions ***************/
+enum amd_pstate_value {
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	MAX_AMD_PSTATE_VALUE_READ_FILES,
+};
+
+static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+};
+
+static unsigned long amd_pstate_get_data(unsigned int cpu,
+					 enum amd_pstate_value value)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu,
+						  amd_pstate_value_files,
+						  value,
+						  MAX_AMD_PSTATE_VALUE_READ_FILES);
+}
+
+/* AMD P-States Helper Functions ***************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
-- 
2.25.1

