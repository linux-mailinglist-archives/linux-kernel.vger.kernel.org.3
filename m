Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877946349E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbhK3MmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:42:17 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:12097
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241867AbhK3Mld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzJ4gRzu8lMEiVHvm0nSAabyFJ167ec6BLVahwCoVwl6wozjLlzzCNLOzRAWER39Pd+3KIYWSsV50hY9WN6AKSL3MrBt39MKgXcFK3IzCy7RAbygqelZX3O1hp2m5k0pscKi8fxQswVzTcRUZL7+EFTB+/WxJnon7rwjb/wrnsXZc8l7aXlfMu2w0VyqItn1DsqLoJ7cP5EuwEp6QkqapdTig6D72CwNU/BSSFeiVl1OAUf82aB1rPq6JmXnSdw64BA6if5Yae2IpEZy4bNpOJE7Td3GWnx7oLMX92MjvkUi9ZYMyaFIQ1PIfYPFbfN8mnjxl/BP7l86wO9Ld6mWww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=VbrG25mImU0/LmC6IzF2CAKm9P41d1bEC1Iluv2JKk8wU+eVbvC/FbQIhfkasDzdkxg455GtoK+dZ0+jn/adUftx80IeNPUwOB02hdxzPmt2lWTLDs08cGMRJX/CghtqG6mcioIPohdcdVM1RUgTCUoq7XvYRi6uyW07zgnYSKttV3cBN9ReX4dPYOUGvMrJ+/OTDt4DqmkOVpVSQB5yHyMXRvze0CC9kJDhbetNqW08AlR6wOLaY8YjYC+rU9+5kySrErjsMi3IwBBtwH08LipRq5R1degKr0N3rY9GqxnmAHsQacXUQLBcainfcsRYm1f8qobFzjqAcK3sj3XMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggtBMGzJNT0gf1w54AjpMAmINQmo2vLf+BXHb6ym2hY=;
 b=p3YSX6+c53ut+Mz/Nle9PmMf8Hrgb9fQFAbhjKxrz4O96EpI1J8BhsxTEPl8OcFIiDXSnmSqcDqQVV4KcHtxgVPqEorgjCzENyWPCD8Y9yGtXG/tH3XAK0HK9uDEWeq0auVyOCJMAi25q6dUfsx8HwOf2v1nNsoJLWARxK0u/w8=
Received: from BN9PR03CA0182.namprd03.prod.outlook.com (2603:10b6:408:f9::7)
 by DM8PR12MB5494.namprd12.prod.outlook.com (2603:10b6:8:24::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Tue, 30 Nov 2021 12:38:10 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::d3) by BN9PR03CA0182.outlook.office365.com
 (2603:10b6:408:f9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 12:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:38:10 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:38:05 -0600
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
Subject: [PATCH v5 15/22] cpupower: initial AMD P-state capability
Date:   Tue, 30 Nov 2021 20:36:34 +0800
Message-ID: <20211130123641.1449041-16-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41666914-3079-4723-28a9-08d9b3fe447f
X-MS-TrafficTypeDiagnostic: DM8PR12MB5494:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5494F1638255BB1A293A57AFEC679@DM8PR12MB5494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTvCtvCyl1iekVT0/l8HX0de38Gtn87bRnLcForDWy6zubTyuKemFb2c7WEs0kDOSnguYOa2JejU8XpEXzyB3fr1/pGft00iI1uBLzS4Ra9jspi9nslL2zqMmbHVFnuGmWat/m5fy1aCCjMxVr6q8cWMvgf3vpIdxSaiQLj3OTmPn2weIh12hsM9QQNoE0brfbaE8LNn2EkkfWQSrJzSrGQLVx8zH+mk/f37rCZRTv/dTi7x1DYXOvvw9H7le612T4DNoL4sujnrS2lH1xLkA8niRYHYQdKiEO6ennj/rwxt/3Zmci6tWAVkm1nu9z/6GUV6oP4l7MtxQH8aJzLjs3dAnLDfUO5bjrr1Wb4w/f15H4s8twxBTGCvb8ZABSngnn+Q/w20MWV/N/9zFaGDxP4smseL8xZdmf7E3MkCsB3W/E+9Ws2XtgrfEViPrNHEccsFWupOFnyg/u7EULRFuG/CkKgt6288nxVwa6VBWJ4V8lUiR9U0gpHM13yeduAvb5avnvmjn5OAIZeJzNojYK7zL3Fyi0T6ukUl6M+ChjjIefdeBpWA0lNmo2+rMg/kXSgcRYR5JGtdfSIiamOCEXAyY7v7b3v4BThikH5NsOy320cWI1lyU9tDNVwHlR4313T0RYjUnXt7MauqXO2c/o1CndhqNoOt7gwhFriZUkqIc74IWOziFfImW+UMNRF5lDHeyMmmVuC4Y52tel32jhd+XZY96QCUTpH52bcMWL6obLVcDfw5SxoHCh1Tj1QvMyywI9PhrcvuHFbIvBSsnQoTw5fXQr77NgZxAHaRNx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(7416002)(86362001)(508600001)(1076003)(70586007)(356005)(2906002)(2616005)(36756003)(47076005)(70206006)(6666004)(8936002)(81166007)(5660300002)(26005)(426003)(36860700001)(82310400004)(16526019)(336012)(4326008)(8676002)(186003)(110136005)(316002)(7696005)(40460700001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:38:10.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41666914-3079-4723-28a9-08d9b3fe447f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5494
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel starts the amd-pstate module, the cpupower will initial the
capability flag as CPUPOWER_CAP_AMD_PSTATE. And once amd-pstate
capability is set, it won't need to set legacy ACPI relative
capabilities anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 72eb43593180..2a6dc104e76b 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
+
+		if (cpupower_amd_pstate_enabled()) {
+			cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATE;
+
+			/*
+			 * If AMD P-state is enabled, the firmware will treat
+			 * AMD P-state function as high priority.
+			 */
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB_MSR;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_HW_PSTATE;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_PSTATEDEF;
+		}
 	}
 
 	if (cpu_info->vendor == X86_VENDOR_INTEL) {
-- 
2.25.1

