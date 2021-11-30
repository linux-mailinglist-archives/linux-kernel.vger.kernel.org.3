Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEEC46347C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhK3Mke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:40:34 -0500
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:15713
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232106AbhK3Mka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:40:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UouyDbAhYPSG9jBTZtEGRci82xI0EntXYfB13TsmYx6qF0M/oHjqz0dLJxTZ3HI9Aw/xWPMRngTEkCTen1jv4K8xxgRxyLOUb59yEyNoxjtPlrZdstbq1u1+a5brC97c4FjmrXrUTq0yIm/MiAHceyiEG0117VxfkLm7T//VFE0cb20+/p7sMWlX54PkigJF4Ce2+VeO1wPeEhKCmHRUdtevXD8KBe/ZyzFd6oGkxw7Engss1TbJKL7TjmzV7KF5CsfburBPmkzU44vdT3yOZwj4EJE3EmGRX/NpWT1NOUk183AfS/DW5KgS/xJjtK/10mj0qa4Wjsnlxu0/0KHvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yUZkCL0yck8d8/rirSFyp0H6Gs7BCb7wXyyMbYT5jM=;
 b=d2U9w9DW6/gLPqFVHBRyLgC7qVIB3nAK20GHNoQJJRmIUQGUJ2kgAWv654qFjNVyojimrLfN0HKAGpI/zStDMtCEJ+bujYw4hFCqZzpHRcRNXnKMmX5njaoU2uTwxNvXgvXyhXukqRQu9egfJcWJNJikb6z3x99PJxc5e5ycQbd0X5M3yXJ+r8ChdlP/uW3NXG7O31cHuvK/N9uV6qAxk5WrUpgxpuWHCc8+mJVaEexknVjW26JzXEG9BGpymJL8/OmfnY3yu/0NgpTqoHQImtlwzLW7ck4D+7KjiHlkfCppE4kR4o1AhE7Qj4STAW15dHNX3iYnbIY6IAsScADK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yUZkCL0yck8d8/rirSFyp0H6Gs7BCb7wXyyMbYT5jM=;
 b=RqzlHN4RZkCkq2r5o6SQ5CNbkBrGLCGmFJDIK7qHiLpnoSDOQq2L/5teq73R/ZFgOzn93X+SAwoHCLOBvpG3fhVHNqD6DaIQO4dnC9SKSckCCx4yMrit54t6O8Wo4RNiBdzHJxxVN/r3AX7Lzm31nFEToDEAN7Zv1hASHk/Szms=
Received: from BN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:408:e4::6)
 by CY4PR12MB1896.namprd12.prod.outlook.com (2603:10b6:903:124::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 12:37:09 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::df) by BN0PR02CA0001.outlook.office365.com
 (2603:10b6:408:e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:03 -0600
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
Subject: [PATCH v5 01/22] x86/cpufeatures: add AMD Collaborative Processor Performance Control feature flag
Date:   Tue, 30 Nov 2021 20:36:20 +0800
Message-ID: <20211130123641.1449041-2-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9783c71a-336e-4bef-5584-08d9b3fe2017
X-MS-TrafficTypeDiagnostic: CY4PR12MB1896:
X-Microsoft-Antispam-PRVS: <CY4PR12MB18966DBFA0701C43270B266EEC679@CY4PR12MB1896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jI55RhBrBzR0WNtjJRKAgnE2j+dWND/LmkkqYwsHaYIWDFMf0shMio87dghh+pBHl6vwB7bC1eoRYaok4iZ7i31Jp6j8G9oSybhBrRZnT/upuqhJ5o9j7bbGG/OCFWAk2ZVwdeZTCzGPi42OPtJrs0cXT/58UHfhCJxCPm9UJ8RAdDGQ+fczjueGrM3SPuJtovFdafmTHyAy8OatN8tQYUto09pf6zhmO1Hx5ZsTymFBvepkgy3TFx//HZBL768HPT+k848cuS7gBQ8/2oOiPTRXwVG1YOUy65o25ljlvh0KkXqee46vEs5QHpuKLr2J98icg0LKeUe0Ru8AAhugA89U2bAmNu+FjNxj2FpXtVqPyRsUPvVSxEhU9HVAXhSM6GXeN8as9qXYMCMCH9lEoEE2vpFMQpUsaTZbaRTP/7hWTFMkU2TYFnU7W4cW25o3Z3Umairvkv+KlE2/W1xgOFQqYTPZPTfIr068qx0i6CQy89c++0CNAPClWXwpGkCTRkDHHwICXJUjdYy4bva+I4SgZGQJiMgN7RMnVVXpGhxg7za18f4PPSdzvzP33TraV18XRJFEfPbRuYrdVMFzSk0wVtpLFPPIhLYsJ4Y460pY/N/3X81Ic9I5ilkeafwBS0lMOvlJKL6KGrlzvpoAIBwbVt80ZpfOk3XMYyRU4WoXK1WXUD/h5a0OfyrUxwAjzk4sqAYFW3u1hc2voUpIoBXm+4IMiQLHIz+wpsTlDeeFt0h+GB/lHD4+iJWMY4xSc9JsK2qBb4YHD8gW5eC8I/ODoDZMq5/9zmbDd92/oDA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8936002)(8676002)(5660300002)(82310400004)(2906002)(26005)(356005)(186003)(16526019)(426003)(336012)(6666004)(40460700001)(316002)(36756003)(2616005)(110136005)(47076005)(1076003)(36860700001)(81166007)(7696005)(86362001)(70586007)(70206006)(54906003)(4326008)(508600001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:08.7343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9783c71a-336e-4bef-5584-08d9b3fe2017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1896
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Collaborative Processor Performance Control feature flag for AMD
processors.

This feature flag will be used on the following amd-pstate driver. The
amd-pstate driver has two approaches to implement the frequency control
behavior. That depends on the CPU hardware implementation. One is "Full
MSR Support" and another is "Shared Memory Support". The feature flag
indicates the current processors with "Full MSR Support".

Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..18de5f76f198 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -315,6 +315,7 @@
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-- 
2.25.1

