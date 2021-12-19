Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EE147A153
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhLSQgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:36:23 -0500
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:37792
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236173AbhLSQgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:36:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSgk6GnXYUJXZorqWMuz9AP5Q8YN//W+IiJU8+hBX1ZoWRjIpxvYmscny46jyVDyCFlNFVUOsmHvYtgYzIWyqU1ESywxFRBM+sLuLpuMRWwYeptz3SPe7G3AZmjc4Ic4QFqZm/5vT7tI8RwkCbqrGkkH/ugI47tQ0o/nO6gWanlrKGXyw6g6//t+OFsXU3pdzpzrFc3M1iku33J87nBTT2VgB3VoiHOGtZKz93VNVPugaiQDQVI0a5r5CYAKjCksm7LYcloG+rv94l2nIY92CLbckSpDJUAZWqUhdSjDWMtj+bHuJBR3hFi2CpdsM1IIBdOIpuANCgyhHJwzzFHmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3UU5d76mg+7cQStoPV9EmAx/srF2ZK8NyHHbv51EwA=;
 b=dgK6qrfbasIZnsWUbrROKaiiAGZsRc47wiL13OXVcigOYd22vZVt8EMMjMNHkcBLcEokDUtKBFkMXxBrbwxXSBlUz9XIzfkR4HNMkjnfy3v3xxjlg3AXymoO4cXasgv0MGK8d69AALH1lQWZJHjP+WLqDV1FCRQT0jDMDkjCPFRdke6QsQ3RUIjxFwFcrIxZ879U5YC7Wff9EvygKIir3L528u3GWAB+fZNqK0YWrBy6E+NyL/UUo5ATtCYYK8LE3LB0srSVIWTxqnCgPR5F1TCCwrgmyOs3BVD+8CKR15BP+GzdUafYn3g+3PTjX1SxKRUJ0i2ajkKsKu6yS30mUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3UU5d76mg+7cQStoPV9EmAx/srF2ZK8NyHHbv51EwA=;
 b=2jEBS5mqXesACitntGsPRsRiPV0zNOaGdsRxGzs5713Bdu/0daiGyd3uzktcCKd0n/fiyESFKMUpST/mu52mnnaWJboNIvhzBFvwnLTg4tYnfS0is8dAAsTOqy111uD0JIilIles9rM+MaFurryrBSs7ViOgee/thYXjiP4Huis=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 16:36:17 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::24) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Sun, 19 Dec 2021 16:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Sun, 19 Dec 2021 16:36:16 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 19 Dec
 2021 10:36:12 -0600
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
Subject: [PATCH v6 04/14] ACPI: CPPC: Check present CPUs for determining _CPC is valid
Date:   Mon, 20 Dec 2021 00:35:18 +0800
Message-ID: <20211219163528.1023186-5-ray.huang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1fe883ef-cbd1-4947-0409-08d9c30daded
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158F7730AE4E7109F962D76EC7A9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2nomj8FuPATTKLCSjlalSZLE7bF05/TjbKGdDuvF3v1IxP8a9GjCW0L5eE5zZ5TkcGqsBLh/jccKt/ZKILlEMqmnKnso8UlCx8bDc+JQ+5JAve3K+nnp0QX0yBT1YJNefcGFDKYb/BKz3UVfEIdCnJWfK+S+5fXt8dzjIDEkUH/DkcOMQXleraZA7CO/3uy/8TTbPkgxpk9xj+8BELWUc5NmRLCTy31v+C3mOCujdfKAqGSoPXMcH6Xh2NK6Fe02t8sna3TKL2DFmPFnaMsCoz07tUXSK73IB26Fbdul4AZna78ziytml31nRyybzz4O1e1DE2vJPt9vBSgPT4tNy2koBr3kPFhcgBYar6Wl/ll+LnugPqWiIV7Hct0TsDFlvNohyCOmaMVemSxo/YwdagjcSl/Hre/KJvmJXcwDlex4xgBIIksNMo8t/+w8QiPaaMYU62T3ggwrg1RnayXO4rJX4q1q5p8rh5Mdmk2IlO6z5y55M9qICZtGEqBcAzn2/7Z/gDrUMDp1hlXRM5a8WI6IpzyWWOQm8Wf05CYrS0FZrz/ed56pDO6pPBgMtV+1z+dMSArplH2iTuKGPhzrzHFRq+NLu9lnuBb3W2MZ4DHVDh4T88qUYH14sMsWLFq3I1sKMQ2oUyMlha1YRs/wO3Alzj1dzDJMALMuck3LG5rBNSugfJzFpFYaQasLWWF76t2TCZLIO0nXJNsPJsQ1XpnV2rcouGU4oPUbDTAXBEvhJFbbabE2Br61Ubt/Y1hTEHm76NviIo0cVcmTCxMnAGnnCBtlvRMh8y5MJPGHUk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(426003)(336012)(16526019)(316002)(2906002)(8936002)(110136005)(7416002)(8676002)(5660300002)(4326008)(82310400004)(40460700001)(508600001)(54906003)(86362001)(47076005)(26005)(81166007)(83380400001)(186003)(36860700001)(70586007)(356005)(2616005)(36756003)(1076003)(70206006)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 16:36:16.9305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe883ef-cbd1-4947-0409-08d9c30daded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
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

