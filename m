Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7642047A14F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhLSQgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:12 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:54208
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236131AbhLSQgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSRv0RFJxBWMM7XedPmb4gtX21lKC210iwDWiACodixd/2NqUTPawkQBG5k78vHRtCYifsy278uRQRu4o19U7+/gmedjzBGKnHgPklC19YCfvEnXpWa6EP/lxVq+AwzwCvnm4L/7kP2vItpiI+E6K+0MS2Rpz9ktOnrVpH1Po+szNWTjrbGw+mGZn1MFoMyTA+rW4asovoaPJ9CQ5cks2VlgynFHWGc0D3bbyL2/ZefzSHIUxW9jjlPfOLTo8hmfJSInGOVfjGJ8kfHbax6OqHjMMmrXvM/ry/TCmccXi0F9qw7md9ZDuSNTx12fs7sLamg42YOeFfJdK1IkMNr3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8kgyOkrddODGeP9fLYswG8P2mhNQkaTgXSoOqeB0ZY=;
 b=HqFJEUh23EycKjLyX1JyovfDdGg7Bl6SO/awMcKDqEukMtTMHn79ZDWrF+F8F+09p2In2T2bc+API6EShHo/NKq6jyE78711r1JzGIs38rd807NuwaA22ptN8NloREWkYwiuEu72L/EDH/KTr2PaEQNqqZkwJllt/tU1MisoqE1Gcbyl0KuMrpLjpkj54gxeWxbqMDbuEXXLkBY+HCzulYkTs2gTamMk0+v6NLdrCNb2l0RtEudkBLyKdA2n+SC8Q9Chu/VRoPjHq31CntYGJixgEsrPw0dSJcD3woCn2mZiJWeYxAlYiEee8mwuiZVy/hviRjNFyhV8u7yuqsDqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8kgyOkrddODGeP9fLYswG8P2mhNQkaTgXSoOqeB0ZY=;
 b=t3/SB1Cwmj0lITfoB9ZAzoWJrzQBRPRW1B/ePtK9iPY9XGzaoJYAYB6vofs1CzB/jlsNWXfNn/w1hkhmzniiHUsXs7AV0w5K1j0/fD1a3hnMW64iBfvVxWkkCFHCYm2iIDXHSHHSQfdu8Xh3574u53Vc3DSWyfs7ScCDKeV0c9M=
Received: from BN1PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:e1::32)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sun, 19 Dec
 2021 16:36:08 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::bf) by BN1PR12CA0027.outlook.office365.com
 (2603:10b6:408:e1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:07 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:02 -0600
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
Subject: [PATCH v6 02/14] x86/msr: add AMD CPPC MSR definitions
Date:   Mon, 20 Dec 2021 00:35:16 +0800
Message-ID: <20211219163528.1023186-3-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211219163528.1023186-1-ray.huang@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e029b3a-eea8-42f7-65ee-08d9c30da842
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311FE6DE4CB97B35ECA36D3EC7A9@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TP3M3/4UMgnW5g8xpvteolpHCawUTw8dtUBnkHZwb9l+Fk3l8Qn5phqoUP98eU3Ie4Juh61C6axxB4S2gWiG8FIHERa8cnV1SjzTVuPxZda4P8fbuJD9qqfcH/ymqVQnaXJrBaoD3Y/qEDRithxTOOt2nh6h7HVrdxWy870pWOskICh8KXafupu7uRBJi4AYB4n2ZFZo49p7+r9mqHVY9IApWwF430CFLLAj959xuz0Ac6XOTfT0N/OaevOaNkCxiDgkLm5CVRS7cy9jgCAij43jwYXEYxa+t9NvS+pMusXdYZ/sOMCNMhgExq36qhzKi2HVIJPAvfqYyFj1IShwA3l7A1FjRIgtp//7B9FeoAjVificlwefaD7tErnPCrEXntQaudgvKRsm+ajNJtAt119XzDiSPEKMHVUrD6F3gX31FPhIk+nIEJrpmxPdGPgfZVAyNTp4Q3eInROVN9k78AXhCHcY/FJNZ0gcVEZooZWPi8qeHxR+39uAeF4VICfoQtZNki6MkWoAa+aISSa16QpRz+fYM+zonFcYwD+JySVyvfH+2hucHySEi6BUyiLSyFKdCVe3213cJxUlMPfTVrP1XVxxTj6UbsoLulmVpg/TX59cbdVS/7KLpsNKxVCQL9RSe40dCUU7k1+HBmCuCUoEfDCNKp8Ia+wwwsYs/UMrBebnf1xyAty11SW3274Za2jklYus93+i56Pf4gwcS4PokfI5DMmTXGN5kTtL/d2ZXRUaYud2e5Uu3xGK5ch/MqxI+KsqhnGjjy687rCn1yyg4GA5FRMbUqtEVT8zpqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(2906002)(7416002)(316002)(110136005)(5660300002)(36860700001)(86362001)(36756003)(70586007)(81166007)(356005)(4326008)(70206006)(508600001)(82310400004)(8936002)(47076005)(16526019)(186003)(6666004)(40460700001)(54906003)(7696005)(26005)(426003)(8676002)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:07.4111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e029b3a-eea8-42f7-65ee-08d9c30da842
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
index 01e2650b9585..e7945ef6a8df 100644
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
+#define CAP1_LOWEST_PERF(x)	(((x) >> 0) & 0xff)
+#define CAP1_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
+#define CAP1_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
+#define CAP1_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
+
+#define REQ_MAX_PERF(x)		(((x) & 0xff) << 0)
+#define REQ_MIN_PERF(x)		(((x) & 0xff) << 8)
+#define REQ_DES_PERF(x)		(((x) & 0xff) << 16)
+#define REQ_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
-- 
2.25.1

