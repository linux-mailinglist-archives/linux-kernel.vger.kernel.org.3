Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0A4BFCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiBVPfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiBVPfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0448A163060;
        Tue, 22 Feb 2022 07:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeQrJv+k7WXd6h+hEX/rHEwMYGyaAI0hapTSFPDhxrUlY1MNv5qmCQGkMhKqotzSOk/EzU06CemhAknI7OKC9fyDO8dM0tIPmallF47qZj/Ivl055P4jz0RzjziOErrglL2Dq3b5j1F5intEOGl+xDUF9M8+GwoETs3HhG3wBDsLODGNyOU44bsm+C/ggkuvnMxcNtSvM8imEHi3OgtVwFQrFqUjGxTrYWXQ7EonCE+qhYVW6jycVcSb9gOPevZ+96IIjFgJNcn7fnzgsnKDkEpHkJJL8ncuihQeJkhcgIkqXHoxPJqsJdj54XiPiIkM3qcZkWlD1Y0DAkooA4bxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSbHKoDmmLKln3/kxetImKM8rlt0tRMIUEteL7W0/GY=;
 b=hZYahQu5iEjhfP3QAOK+o2FnB8+7hpWZZwWdhhQpHSC/fX3idN4Dlhp0jgK6R2tMGEqclQh6Ljx8xfDz+A8YRoVZ7EJOpTNr6qtaJqikSeF4f+uGd/ujd8Zir1KAn8mkb6qZx1jhrLFxQ5/Oblyp9VDSQA83DQijkC07HlYTZ/TC+zkQBu9R6AvZC6uYv8xqBAwSXuMxEIi7f6FEWEwPxakMez53zpPF7atUJjNKATAOcpD/bi42MkSgBeUo7J3K9lGijptCxEiD9hKRboS2UGuOcwO4gb0ee2BHzFRqD+Zc1f2DOTF4Lt/dVGgbMFyrMWnOJM58wJawFgx9iLkE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSbHKoDmmLKln3/kxetImKM8rlt0tRMIUEteL7W0/GY=;
 b=r99ackZXrKbrDodUV/imlIfwYJRRoNHgXXULiv1p81m820Hb/MZb4xrWuplBZMs8WW21cI+FjxDPkLPq40vEdfUmSLI/UITw6AACx03tvFp7bFs1PvAz4smWjoLWS2ZhU3CL7NzRlI1vQXLjcDtx/TT84KWPUhD6RRNSxkv4paw=
Received: from DM3PR11CA0007.namprd11.prod.outlook.com (2603:10b6:0:54::17) by
 BN8PR12MB4771.namprd12.prod.outlook.com (2603:10b6:408:a5::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Tue, 22 Feb 2022 15:35:05 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::9d) by DM3PR11CA0007.outlook.office365.com
 (2603:10b6:0:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 15:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:35:04 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 09:34:59 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Jassmine Meng <li.meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Giovanni Gherdovich" <ggherdovich@suse.cz>,
        <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
Subject: [PATCH v7 03/10] cpupower: Initial AMD P-State capability
Date:   Tue, 22 Feb 2022 23:34:19 +0800
Message-ID: <20220222153426.2216974-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222153426.2216974-1-ray.huang@amd.com>
References: <20220222153426.2216974-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfbdf9b4-31e0-4a93-4a82-08d9f618e62a
X-MS-TrafficTypeDiagnostic: BN8PR12MB4771:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB47718F2E0130721989289635EC3B9@BN8PR12MB4771.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0xb/Ka1XQ3xKEPa+Znocvn2yQhR+LKS9HCxjaN2rtYXlx6eeYDAFYXsKPoanvD4Ik9OEzIeSUn1/MPEMtm2Rm4qNl82Q52x5WcI+ESRGQ7I8HDP66KfHuHaizcid0SFIOynC+IZ3Ka76yjRoaBDpsIlgxVwUsZS9j6rrlp62ZlSx64U6o6giUnHpsbKtFwdJdUJLQhBfzaGXwQl+hQtFNLV3GVEgYqcfyXEY+A0DDHZ099rcefzXVuHpa7hwT+sRFq06kH19mTaRusPI+QyIbFSlG/DXqPPB2fuEIfPpr+5fQqjtohf+lgpoYOH3o04TaxJT1hXJjs4x3JLV21K6PTDr0LlS7bFIF/9QRpkVQRnMoUpb7+CxceqD91YNQQk9QsvzsKIon2bz/gjv62OjdqUiIvKBLILFUnBJ9HizEoaN/7mBYe4D9Hb4IZAX4U82FeSQGItyk8VrG4gwEbcUvb/FKa69nQXd394vVtfgIj/D84XN+Dqrnbz7F6FsaKiuJDMWZLyjBvg1AgxxRABUXFq4Zb+QRDlj9PKwSr2S15SBfjfOgcdsgkCUdK8/N0CFAbzFWzDhbD3gX+Khhn5O+83NS8OxmrZrkxxfzZK4cl9NEQF7wrn4rQ+fJABkuNqNoL5zeI+u23U+DTs4MHBrVoFXo/xvZjeBnqA7IJwi9N8hLZvhk82e7CWeyTzifmEe24FthnYRl3SGLIr0Vs1Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(110136005)(54906003)(40460700003)(7416002)(47076005)(316002)(36860700001)(336012)(2616005)(5660300002)(2906002)(1076003)(8676002)(36756003)(426003)(7696005)(508600001)(70206006)(356005)(8936002)(81166007)(70586007)(86362001)(26005)(16526019)(4326008)(82310400004)(6666004)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:35:04.9721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbdf9b4-31e0-4a93-4a82-08d9f618e62a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel starts the AMD P-State module, the cpupower will initial the
capability flag as CPUPOWER_CAP_AMD_PSTATE. And once AMD P-State
capability is set, it won't need to set legacy ACPI relative
capabilities anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 tools/power/cpupower/utils/helpers/cpuid.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 72eb43593180..eae91f11d187 100644
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
+			 * If AMD P-State is enabled, the firmware will treat
+			 * AMD P-State function as high priority.
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

