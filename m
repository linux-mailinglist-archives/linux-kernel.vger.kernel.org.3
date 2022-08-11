Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7364258FC44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiHKMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiHKMbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:31:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF139FE3;
        Thu, 11 Aug 2022 05:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkxYLeddU7edHk61lS4dTxAdtgsHaccz3i/MvzkcUHVTNSQ16RTsBvlhvKYKplDnceOrUvN1TR2vn01jem2j+PSy9M11m5Tv8I/CeSiKVDI0+zwViudlqjQ/wVsMxX9nlZ2oAUo9xN9uyO7pHVb26wv8GeHuEyMQc4q2PkANWeBIdfYoY/ajaYLqYafm1l8eEWuAZBYjqZvmDhcDgcmCm9EAhFbv5H5Ne2Lg4NZ7mCJ20ERA+9wl1JrqFb9qPsx7uNWYbFLiEHWxJtyxRBMWASdlzf94aIOaXDMJBcGWVu9jVwKLF1sxrrGPsxrIEfZFiBT+EwvxHpvhO9ubOpamTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWjE9eE7KSWqewB/5GMjPZ2l/N78vitMp32r5+alLk0=;
 b=SdTQw5GLu+rGbVlqhmydPw1aoAdcsyg234+yMGy/3kmUlrDupkZSNq98ylFg+bG3FqUKy5wn3ERZy2ku5N8s3gusmGeya1iRiVFnBuKxqnCJYfh55j6TWk8YQFEufsjfXiZVKe/9VFw8fC1DV8r39oT0Y5FGhPzCSNfuLpUNvTV3eoVkG1AdwM2NnVKg4ts+3+9QS0MGV+FHK6pYB4TpZBOafxzMv2wZmEIhsMOC3hIcx/q9AO990URiIL2BxXFKBBCSQ5ij2qMWKtBCzphMwM59SQN0MBZE6tD/G0fUdPSXyUNs/+sO7MCzLzUcYSOTpaTRD4GA0QZB2Awr9rmEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWjE9eE7KSWqewB/5GMjPZ2l/N78vitMp32r5+alLk0=;
 b=5IsK41KEpg5TfA2mw8KC+X0wLiv6AKzQz2xWpCalsijqP3/OrqRz0scD4NpTpjdNHn9cEAMY6FJcGHQRtKa/UBCiW01ksFMA+j5dOY8C3iv2XU8ZbIABX3y29QeeGocNSDrjmM4o7IOHfFQBFYKAG0knJTRRuAyg1+xhQbo196U=
Received: from MW4PR04CA0335.namprd04.prod.outlook.com (2603:10b6:303:8a::10)
 by MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 12:31:29 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::16) by MW4PR04CA0335.outlook.office365.com
 (2603:10b6:303:8a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 11 Aug 2022 12:31:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:31:28 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:31:22 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <like.xu.linux@gmail.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH 02/13] perf/x86/amd/core: Refactor branch attributes
Date:   Thu, 11 Aug 2022 17:59:50 +0530
Message-ID: <ba4a4cde6db79b1c65c49834027bbdb8a915546b.1660211399.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1660211399.git.sandipan.das@amd.com>
References: <cover.1660211399.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56ebe07-d410-4d5b-b2fa-08da7b956a35
X-MS-TrafficTypeDiagnostic: MN2PR12MB3536:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4POl/dOAikrykOfyNkC43sfZdpW2bK2GeIDU4FUc3NcZaIedFo2/3ON9Lp/lMIgU7z1raaoI0gI4S+kE5wHbXjQfd+lCQjdVTj9UIv6B2QPWqtZiHYBsapv72mxL0jPqHc7ZHH2rGrR9wYWvxzw7T2qacEABuJ1Ocs2MCtBF3eDgAuVxXdGyueaVFuGTqsUW5UViMA6KebHV0HXnEAoUeF6abhfY3lBxKXvVNMVa7Uzjz8QgktSPrjn5uDQxnyFtkLc8rqcm+7BH4kH35LIOYkSgvJhSb1DVvtx9PDWiQZHxScO1/y+OdCUIk061X0jLoHtUCQGuXivrkoKlBLjyRx8GQ+3GygNhNfGKpeR87kmeVwK6oXUGEwusrjz0HQuy5WCUsfdC00/pPWcQovXgI2NHlSUiA77P62Cc5U3gIqWIgPne3ex6f+Hoep/7f6XVG4PcAntdP6KCVpMMaDbh0Hc7tQbbMmXFWN4toH99SXqTUSyOJ7P60jDeaU8cdpH0JG9yA0EfzcG0QhY3TlSpoT570DaBLxctFRXJwpnb5pMLlSIJ97/30T9h328uTyCh/fLxWo2c0yuqGPYkqIYU+npHvVCmli69Ld92PoO0iA3e514zBjnfDrZlCOlSJBg5wAcsYviSU4RMjZyDIzWY4XBDO/zOg9HMH9h0kOXIatI+8AzYSEZqHY3gYc6/Eb6E1cw+q+BaO5ZTUw23ez4BZZCfE3Xmy4c7YCR93hxteg++R0TSnA+PVqmlEbzCiap1s0IUY04LDA4gXH+7Ou0nw16gmULfoPLseeem9MNRZ+0YiwOhWKcwPvemxC1kSuWNp4bnnIB6qYHek+Ws1yaOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(110136005)(54906003)(316002)(41300700001)(478600001)(40480700001)(82310400005)(70586007)(7416002)(2906002)(4326008)(8676002)(44832011)(70206006)(5660300002)(8936002)(40460700003)(83380400001)(356005)(81166007)(86362001)(36860700001)(426003)(2616005)(336012)(186003)(82740400003)(16526019)(47076005)(6666004)(26005)(36756003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:31:28.6875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56ebe07-d410-4d5b-b2fa-08da7b956a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD processors that are capable of recording branches support either Branch
Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
Branch Record Extension Version 2 (LbrExtV2) support, reuse the "branches"
capability to advertise information about both BRS and LBR but make the
"branch-brs" event exclusive to Family 19h processors that support BRS.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index e32a27899e11..2f524cf84528 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1247,23 +1247,25 @@ static ssize_t branches_show(struct device *cdev,
 
 static DEVICE_ATTR_RO(branches);
 
-static struct attribute *amd_pmu_brs_attrs[] = {
+static struct attribute *amd_pmu_branches_attrs[] = {
 	&dev_attr_branches.attr,
 	NULL,
 };
 
 static umode_t
-amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+amd_branches_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return x86_pmu.lbr_nr ? attr->mode : 0;
 }
 
-static struct attribute_group group_caps_amd_brs = {
+static struct attribute_group group_caps_amd_branches = {
 	.name  = "caps",
-	.attrs = amd_pmu_brs_attrs,
-	.is_visible = amd_brs_is_visible,
+	.attrs = amd_pmu_branches_attrs,
+	.is_visible = amd_branches_is_visible,
 };
 
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
+
 EVENT_ATTR_STR(branch-brs, amd_branch_brs,
 	       "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
 
@@ -1272,15 +1274,26 @@ static struct attribute *amd_brs_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+amd_brs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	return static_cpu_has(X86_FEATURE_BRS) && x86_pmu.lbr_nr ?
+	       attr->mode : 0;
+}
+
 static struct attribute_group group_events_amd_brs = {
 	.name       = "events",
 	.attrs      = amd_brs_events_attrs,
 	.is_visible = amd_brs_is_visible,
 };
 
+#endif	/* CONFIG_PERF_EVENTS_AMD_BRS */
+
 static const struct attribute_group *amd_attr_update[] = {
-	&group_caps_amd_brs,
+	&group_caps_amd_branches,
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
 	&group_events_amd_brs,
+#endif
 	NULL,
 };
 
-- 
2.34.1

