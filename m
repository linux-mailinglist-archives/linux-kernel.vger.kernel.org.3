Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5656647E9FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbhLXBFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:05:39 -0500
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:24385
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350464AbhLXBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:05:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS6qX87tPhaZQtYdW0laSdq1CUaGhwXXoKL7t2vsp4gNo3evskvZ/b04P9sssoFafYa3ioVKj9R5YbaS+WGeoduz9bLZAsy9m4MlvOVA+1QMXK36a5fx+IzqRh8ogDydPf14mYZxFFJAEh5PTJlVERtVCMwDSF20pAmlf6IbiCDulB6HfJZnhr28A7eV23POJ5ytGSdNBRDS3+tr4CJ/pDSk6oYR+xlVUKuAgy0WYyfTSHKgVMq46EM9WktiIwkK9tI4Pa1jiOKTT4FzUFcB02lD/4TUtOjigzwSiuDmIWoTX0il6Gg6A9TgVbk+6n5T1zFq7vHavDMke73UL3Dt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFpsTHzsc4S/yAm2lai1tvTk8AIOTj4EwQTjCfegOTM=;
 b=kWcrLlPZ+YrCbcMu5PVOsAAIkGnZkBV0cAsJJDiTYcjjRfGrzemjIs1vWsOlG7K9cZs9oKyO1tfOd5fXchHWkcN0cxACskrh8/j8Yw9UuCeJjibFGBSd5CufDW1aoTWe1ie8YKzmp4vVw8e+mAy1k6YujVLHqksLBmuaSEIpV68Uc4Nu/NBOJD95HUiTE7NJqOt7iDIfmyFgpT2npA7f4S2Q6njKLipjOpVN5cd0Nr8ob+UkWFIf7JVXrfsebFlOrNcWuIg5v2kLgzARAR4eoXGGxL9pniWUZmW1DYz+nt2K1u8XMB7Fe1SsoZH47pNsJAFycZ6wPc/mxsODz6b44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFpsTHzsc4S/yAm2lai1tvTk8AIOTj4EwQTjCfegOTM=;
 b=v2rHVP5amESffAozYvxw1O62Cl8SrPwWgmYm36UPJxwyoyDXXhtYJpqeBNs92a0bBAXsruYcTLk4PuuPeYUIQtcXIWqtodmeb/Ekt5zqDw2YAKHt+lx4GzReI7l2oqCVDnqHVNcUYNnbFN32FIFdoIwRkGVC5xuIvvenoa/CsFQ=
Received: from DM5PR20CA0029.namprd20.prod.outlook.com (2603:10b6:3:13d::15)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 01:05:35 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::2f) by DM5PR20CA0029.outlook.office365.com
 (2603:10b6:3:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Fri, 24 Dec 2021 01:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:05:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:05:30 -0600
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
Subject: [PATCH v7 01/14] x86/cpufeatures: Add AMD Collaborative Processor Performance Control feature flag
Date:   Fri, 24 Dec 2021 09:04:55 +0800
Message-ID: <20211224010508.110159-2-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b545ed3f-319e-4784-f584-08d9c6797dab
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5126582E7AAC3E2097D0A745EC7F9@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kr8VmuVJ84+Bgyfl6uhznLhM+TlWh+JYpS2wuWb1vqB0R6J0MaWG+RB+N69NR+88aoNRzJZDzSdNdmpJSigGr4CdGACZ3w5D6LT+N7wN7Y/xTU/wYVvLrq548PoXwIPLViaEyLwTVCW8Y1YzM91Jfv4BBsNsZtnKgcbxlnoqnwoNvrVOf6iMnqSZRAbtjBAn8FSgx83lEfnUc91qq2TRDVGPbm69c4V9B8LhhRFei2LZKYRHKbChAJHMUF2uuj8KUZqBhcyb/5K8cCN8v54VpuBY3M7S3mrjvcNJ8h6pTL58I0QChhc35+NRVZB8Jo5gQ7Koz4Gm4XuLXG62omQ6J1K59aQT3LbGejZrr11f4BiigcBRBM5NTug5ac5r9a1cq71E908sEoLZc/6ntOV/WzToXtbGFfGP2A9O5ViAer55IpHxarCKYmOXERxAfn02SWKkI0UIrMXuWSzjJIgvLgAoDwcMiqNA2UURS6z0t+SUwKx0XDLtz+8HVynzM07+401U72Ho/N4ZMBP8U3/pgFMmdk5pF76nUDyx86VQ7k8pV7+lOZ/0ttgl89D7ABD4DZBjJgDd7tb8Qrc/q8Ets0WOJDuoLggckHTfX6Agp9Sg/ZUcjopI/Gd7m4l/U+gR1H+4xqI/TqAJubVmu6Ye0tNaIOnWVLX2S0XcOKU45fH6glQbZZiKsMbrwSt2VyV7lzFMR7IAu/edqJKRYbT9+Zi+dxCkW+WVmeET74rmDHSzuhlF+ohqQ03jzZM4ZIG2fdDflfo2cmiC2xz2uuYyw0u0034KJJX2oA2W4KRLs7Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(336012)(36756003)(186003)(316002)(16526019)(7696005)(54906003)(6666004)(110136005)(508600001)(2616005)(40460700001)(5660300002)(1076003)(2906002)(70206006)(70586007)(81166007)(82310400004)(47076005)(86362001)(356005)(36860700001)(426003)(7416002)(8936002)(8676002)(4326008)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:05:35.0306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b545ed3f-319e-4784-f584-08d9c6797dab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Collaborative Processor Performance Control feature flag for AMD
processors.

This feature flag will be used on the following AMD P-State driver. The
AMD P-State driver has two approaches to implement the frequency control
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

