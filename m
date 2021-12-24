Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7147E9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350539AbhLXBFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:05:47 -0500
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:18931
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350527AbhLXBFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:05:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4+NEmrdDCgskwVIg2P82y/Pi+zLP/zx+RCim6eAIFK1+m25rQnbB8uMWx4xntbAiJYMNzA76XgTeBMjCOUTgJPcFDLrz+/ezL3sae9hy/6Xa6PJVkEpPEf+wlrJZFUyEmAq1h5/X5Tyqv1ovEcCn3QkXGqAnocL6R2NY9Ag1XF4N2bIKoyx9vcoOK4NPMnd1p0mSO/U9bv+aYcEmhpBtXKFMZfQvdjkDskHFZjPdsQohe6dRsG0oW9OKmuxFn++4v9jvhPNFLelx0FRwYLCNUAUGac+ulGFqOuegW/Gz6T7qBMnxQkrcditCXXkZAePXmTybD3sne4BEtDpL3YbJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0JWqZZbP7KDJceB1FBd55dd8WVg8MQZ7LP4Zd+8H0w=;
 b=G5qpPGq6JDSwwYmOdsOcQBeLb9Xl8mA0s3oYGqhRw6mhmNSFyVS508JLYOJj6rRODa2xXPI6BFp0f2Hda9L7St4WyXGTc+Z7YoHBTDPO5zwAlO/G1QNnw54rYRcgRebw5r5bsPtbZ7oo/gsBwp/cXE3IeKnJnN+UqQ4pmwUoHk8F4tKOjMBnUEmcdGMy6734zHT6rh/5hoAu+Q1L0XKAhRuGnkvwqBsAXdiKtI1DllZ4c3LTEcIdLAU4oCd/vqjkbp/DKIIWR+ciPKH+JDHh1/XJXOkLLn1UknGkZxj+nWGGcpMxkZSzpQvtN79kd8Zzm7vVvKve4mje1kZpIrIWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0JWqZZbP7KDJceB1FBd55dd8WVg8MQZ7LP4Zd+8H0w=;
 b=aG5D/y1gD92Vp27X/wG8p4Q9g0TeuACyC/+yANRKF+NWkURRR3YgXGxuNjBpsgc+rE6hPSJU8cJ4MAC5kPkwHBsi6E5ZfvdqPv211qRN3NRV7uzHns030Ym7V9789E/WQdw3Q4hi6jEpZdpDbGZj6YMeU645RU1Iz1pszuTiCD0=
Received: from DM6PR17CA0016.namprd17.prod.outlook.com (2603:10b6:5:1b3::29)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 01:05:39 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::d4) by DM6PR17CA0016.outlook.office365.com
 (2603:10b6:5:1b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.21 via Frontend
 Transport; Fri, 24 Dec 2021 01:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:05:39 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:05:34 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: [PATCH v7 02/14] x86/msr: Add AMD CPPC MSR definitions
Date:   Fri, 24 Dec 2021 09:04:56 +0800
Message-ID: <20211224010508.110159-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224010508.110159-1-ray.huang@amd.com>
References: <20211224010508.110159-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95151b69-0b07-49cd-596a-08d9c6798046
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2877F4678D1FF9A6C59CB27DEC7F9@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwiw68eelmhjL1UhSIyxpQ5o03uuqA9zI8g6C0yXwdMDsPm7gUo5eLK3KOixbS2e2munGdRTXeH990TOv4x4l/NBhK4kQp/hmlbu/yHrHEZb2WP4Vu14pkRELSzx1dyAKNwQq/bQ4P+79KJpgO0Nr5fDTOPesbbFPIj79uIVpbIjhogPz5F7c9HE9vaPdbds1r7vMtLengSV/b7OsEDgX9pB7H1FGEyewpWQidCtz2b5VDmrmgcpwqRc0r3dQzCIy4uIEzNQkJ0vKl+75TFGi4ofUsXarNwuP0i1MKkCH6FOmCbf4/i/A7jUT1FomSz7W8vrFh70A/9S0T7Hxp37EwTIwpuXtiG3Uaha/qFMTsiCY7Es9Rq1Sv3+BfdscRg9s4eckBoYkSbTGKkvoG1PVYvh299Id6Mb5t55yw1jay92+X64p4BEYFAL1yK5/db+quEdSdB5ntgoCo+wAK3OGh6HRlXYmKo7mTCrcfwhDLokXcFcHaamsyfNwbEIH0lYvoaI3HQAcIf2R1d4wq4Aoh9agrn/F4wnIivTPMT0POzK3BdAGLT0qltPLr+ku++RU73BF1f+5OWfNxKd+2E1sxaXV9HrzvIV2CMxs0bnhO0GTR2+VdE8kCtpDeoO4/MAx1XLh94NQfrlSAHuKxDHqF6sPWoOF8dWlCSnvwrl80WXptRAofkZgvLsHP+Xq1A9FV/V9YN1AWYVHclL6JzgBSfCluYM6i8wBv/MiAHj1RAFltAD/0dSDzHf+it7lpaBnmWPtl9ZIQoc8Xps8vhNV9kGpUn17v1sxpPHSIulxcQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(40460700001)(86362001)(8936002)(8676002)(70206006)(316002)(2906002)(54906003)(70586007)(1076003)(7416002)(110136005)(6666004)(508600001)(82310400004)(7696005)(4326008)(47076005)(336012)(5660300002)(426003)(26005)(2616005)(356005)(186003)(16526019)(36756003)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:05:39.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95151b69-0b07-49cd-596a-08d9c6798046
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD CPPC (Collaborative Processor Performance Control) function uses MSR
registers to manage the performance hints. So add the MSR register macro
here.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 01e2650b9585..3faf0f97edb1 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -486,6 +486,23 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+/* AMD Collaborative Processor Performance Control MSRs */
+#define MSR_AMD_CPPC_CAP1		0xc00102b0
+#define MSR_AMD_CPPC_ENABLE		0xc00102b1
+#define MSR_AMD_CPPC_CAP2		0xc00102b2
+#define MSR_AMD_CPPC_REQ		0xc00102b3
+#define MSR_AMD_CPPC_STATUS		0xc00102b4
+
+#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
+#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
+#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
+#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
+
+#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
+#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
+#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
+#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.25.1

