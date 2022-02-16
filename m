Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7844B81D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiBPHiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:38:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiBPHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:37:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE217227C;
        Tue, 15 Feb 2022 23:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbkChu+uc6K3ZF/gOQH09QsZeVwz7bmkmxnXBMme6nQwPnRqyEL7P/snP89a7b33kxx55py69ukmn+PX9y/bHe0/oCnw5zM+KpoeR9UOso/FIk0NtAdi0Zr5WPWeGkuSR8FYPzsDqhjdLKeQhzAykuSGwsncYSqpbFJbG0dY67IcmMDJZsBU5TlYEvWAlwk5D1GXO+fQ67iZYzFBgELBZcRkfRiiCO5KaaurHMdwb3r9+cLl6drNB4GNzPyok2MvskgYxMLt5n5nwY2npNAd8KyvvU66fjBdtATg0MyhJpzHVReuFx/eO2oKKvpCNUftLFRSxHNPRvgUqcPeRLoaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSbHKoDmmLKln3/kxetImKM8rlt0tRMIUEteL7W0/GY=;
 b=XkRkT4bk/VNSk1o/jZ1EgdTsxhSuveLWsk/xFAK3zjElTRD9QE+OmgUUAw5e61gDTucGiu406yKQT+uvsr20KOuZUyqrozLByI4BA8GFdS9MV4anQlJ+GmI//qxVXhBgG8q4T7LePU+sH23tQqEnfjOHswGknvDm/NAkkPNo5QIUPfNy3wMBTlQVkD2aWrql5dAgpm9OOZW+x0qYxh+r0zLemfc6fwa0Z9wiHwg3preRkChnvaIrrdPaqzq99CS9Rg7+rilfQZRa94uzKzLE+Xpon364WJmbtEHMh/uttlJ9QoICD7t4gmdyn30taF33Yh0Dzv0x2OEfIiFBqldhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSbHKoDmmLKln3/kxetImKM8rlt0tRMIUEteL7W0/GY=;
 b=p7Y85e6ms9/KVZLs38rH9yjqBzMYYKyQ1F5I4fXclVXvkJsv2tEKdnueV7B1MIZXR58ReBf2b+7QDY22r++tNfjeUo3IR9A6SWrXPdN/XRH5o/rQHjCIQEyuhkyppDpWaJ2qaHuff1BAPw+7yS8bZFOBBrUlVau0cCW4AFYEmlI=
Received: from BN8PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:70::47)
 by MWHPR12MB1888.namprd12.prod.outlook.com (2603:10b6:300:112::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Wed, 16 Feb
 2022 07:36:45 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::7a) by BN8PR04CA0034.outlook.office365.com
 (2603:10b6:408:70::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 07:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:36:44 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:36:39 -0600
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
Subject: [PATCH RESEND v6 3/9] cpupower: Initial AMD P-State capability
Date:   Wed, 16 Feb 2022 15:35:52 +0800
Message-ID: <20220216073558.751071-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216073558.751071-1-ray.huang@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 525bbadb-4015-44a5-feb0-08d9f11f14d7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1888:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB188865D102517308437F157CEC359@MWHPR12MB1888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ssn24aA9FmP5dE+vpi3SAmgImkA7xRgJg2Xj7JV7Ubf2Oa6ZmDt3pd/9HbRq+OWKBzqen+YqeW2pBzBjRgVjdsxrM1F8eRDpdsCEZQDhf5x8Y/YwGFl1Pqhd48H51s7J/bP/HFFg4YOwho6Y9BBLVqu+lS5XHwEGMYOkRmxDPj2s5dG/tYaoED4GPgptJvo+a3Db3LgMNxNVCtLKRbcYxgqHnQ1kUN5Xp/6CmvqeFLd0cre51S0VJkwjZymCYPOoX5vmcNNKJXFZCKZsBd9iCW7F4U2nw6XDAqPPU39U/YEwUd1swgF+By5Umh+RQ1X9F5zOFnjY0mYdFt+02vo1bWwox/GWgfi5uUO/zvnEMnKDguEnOV0sU9JA/p9w7SAmJD+0nUjtP/FbbY9MkqkShUYmabLSqjP0oR7Zm9lgTfaY2Fu3b0BwpjkztIgKGEaDzdUpsH3gr26tAVtgvf+d9ZxWpZ5kiCyIuABDKQNGrestSe5ACr/QwU1xgBCYxlC1WoSklZzsaXYC8j/hp+TdqtRfskCuO3klu0gTeiyFKaJ11WW+nm8d7WE4h41RKOC40MUoppdu5HyQrio7hhqBrg/mxB3h8fBIRHQMOKIlL84BX6HmKJNMSezzzq5w06lbDyrwBQePqxVoNbF8oQssNKqeM4kgNzhxMDNfZLST5BBmQPawwQnSzWi8DAtz5hZNYgpncmJZ9e4PXaTT01RvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(110136005)(4326008)(7416002)(54906003)(356005)(8936002)(316002)(5660300002)(70206006)(2906002)(8676002)(16526019)(186003)(508600001)(36860700001)(6666004)(26005)(1076003)(2616005)(336012)(86362001)(7696005)(47076005)(40460700003)(36756003)(426003)(82310400004)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:36:44.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525bbadb-4015-44a5-feb0-08d9f11f14d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1888
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

