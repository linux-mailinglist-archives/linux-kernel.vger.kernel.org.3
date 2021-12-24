Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EAD47EA03
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350584AbhLXBF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:05:58 -0500
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:54130
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350553AbhLXBF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:05:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL9szznkzDrbaYDaQmz4YSCndsMVSD6AlJsi8zA3hDim+TvbSeetNvnn4n+4sdLRVrJkyX0Ak2ceMXLpopwTkfAQdphNeJrA+9bVLyfA5qra/qZHhJf79e+SCrB+SsXd9kcunS4dpu13KNh16FMz4VuvalgURx9xGiSJUzmM18x94wrMqMw61ANjHFmAgUIvDWCUntYNV2EGr/4uFwjC2NoJQkW4mcxz9tRAz9JJwft1EXFgVDo1WHzlEV9gwbJWDN6VTUNbFMw8jp0jFRoMwEvnUbx2gyvk1YscB10uw5zUKZwS9H7fr2q9cmNqOxJ6Ghgaq9QMju49+5rwdNGVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3UU5d76mg+7cQStoPV9EmAx/srF2ZK8NyHHbv51EwA=;
 b=lwS8/+rId5wWf0a8iNuAaQTHbQE0vCOjyIwOfOpOF/unLzBtzVIMeuHkLPokItc77g8G6nxJHupU7JkvbAV68EbYWyKSui+E7SC9tqC6ZsxVcWy34p+OhjFcZxQRJwcHsXk4nHIesDSySrq32r/vi58Mi09kU35qUCmhC9f6A6iW+k/2aLtiZuhq1AiueK+Z7kMeDFWFcYMT6/kwvlhfsQGbjs2E4a9Jdk6dxM8q9miEEcAvIe08Th2bLGH4jpAG3fZxG7ymyBNhEEBi+3BOWGrx4qNPCkK3MfeHeLNXYhGaHUPiEooyH8TArFTCRaFQQi8F9WhsdJM0aTTWdrtGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3UU5d76mg+7cQStoPV9EmAx/srF2ZK8NyHHbv51EwA=;
 b=uUMAeIfzKGYch4tExPLBg4qWmIOO8bYCWnrVtFezs9cq3rTCtcOXyUNH+V1JDhgNt8t12VunlpzbF7dgi1PdLKFHbWOR4sZkydLy5ATSLNCDoWxx5LeKbdzKNO3HCsmoV6iUnxB93Zd62p/i8SOLj9ahOnkVT/l9IZcKj3YWL7M=
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by MN2PR12MB3471.namprd12.prod.outlook.com (2603:10b6:208:c8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 01:05:49 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::62) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Fri, 24 Dec 2021 01:05:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Fri, 24 Dec 2021 01:05:48 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 23 Dec
 2021 19:05:43 -0600
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
Subject: [PATCH v7 04/14] ACPI: CPPC: Check present CPUs for determining _CPC is valid
Date:   Fri, 24 Dec 2021 09:04:58 +0800
Message-ID: <20211224010508.110159-5-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0b1bf12-08f4-45b6-6605-08d9c67985ec
X-MS-TrafficTypeDiagnostic: MN2PR12MB3471:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB34714DB54F5C6668256A4228EC7F9@MN2PR12MB3471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRMrTg/4WTpfG1dGyY++aszQ82pkIX+NBFyym96xmCufX4onh4kxDdEZ75J4a59OWYPALJKEaKS96h+ImEEohJIJ/mFcQPwEZiCtOYXRKFwPWe5mUKp5tW3wqu9GQbGjq1MBC6ZpdvgCU0m2Gj4tLVc8fV1523VoXounzFs2KRuyXPlbj2Dz1gwPnpl9jJP/qEFclzwNMjialcDAmfrQd7PFRWnmQHfrqCqTv6c6+RNLoYMD7XSHjXf4Tx04B4mmbNO7ir25ySCYiTHHaifcy7JofENsmtmi1g1lrf9gjTv083pyTdK9UEOydSIVIz26KLCXqEKTiI0xGWlWWycc/USYf5VeUaTzvV+5GnSZFSegSSXBQOaCN7+5Q93zUD8Tpmj6cAW8qFxTmnkz11OTTazr6bbVmhk10ux9X3eESw+QdDnCHiudk7PDWEqzpL/+7McEi4JvEKtVa78S8T1RcUWahdytacPuDTr3EoZmJCPYkopyKb9NzyMVz10rbe1+bhse5D6gO05gDxXuP9484zZ3yek8NHjoKf+y0nXEAV/Vt4bmdeZIxubTIVCbhHrlB5O8EitFvhWQgYLHOBI9EmEo3Xh/hAG7/l1iXMpWQ4Lt10KqI8SupxmdtUdEmSXDrCF5H69Ku1NsNKIxb6ceMwuJc4p+Lt+HrCTWLcUup+AZ1CV35wHLOHpOl0fe+2y/T9+H3DqXEVnaOPH9LLcllQPtioMHDfSmAJq82cyPPqOygfP1eaPgValK3bmntUw+prz3QRFyPL65KG4gc+5n7Gl6QY9knQZbWFH2FlzKotU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(5660300002)(83380400001)(316002)(86362001)(26005)(16526019)(6666004)(54906003)(81166007)(70206006)(8676002)(356005)(36860700001)(508600001)(426003)(186003)(36756003)(2616005)(336012)(4326008)(8936002)(2906002)(7696005)(70586007)(40460700001)(47076005)(1076003)(110136005)(82310400004)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 01:05:48.8903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b1bf12-08f4-45b6-6605-08d9c67985ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

As this is a static check, it should be based upon what is currently
present on the system. This makes probeing more deterministic.

While local APIC flags field (lapic_flags) of cpu core in MADT table is
0, then the cpu core won't be enabled. In this case, _CPC won't be found
in this core, and return back to _CPC invalid with walking through
possible cpus (include disable cpus). This is not expected, so switch to
check present CPUs instead.

Reported-by: Jinzhou Su <Jinzhou.Su@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index df2933c28bec..0c4f7005818e 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -413,7 +413,7 @@ bool acpi_cpc_valid(void)
 	struct cpc_desc *cpc_ptr;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
 		if (!cpc_ptr)
 			return false;
-- 
2.25.1

