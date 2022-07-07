Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96F56A8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiGGQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiGGQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B11B86B;
        Thu,  7 Jul 2022 09:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lavoXZ2S8Ne0S67MyN0sQ3+vRXMqFzW13XfQ+rZ3mBaXGQ/nA5V1ZaDrLbd/S9JT/HWMbE4hCDrYvKYwR/Gu2HR5FqSNeBoaJiAWabc/tSzbvbxOnDHh0WuJNhQngBWIe87Zj3DuzYgMi9J6PxMlJ+GJWbVpMXR57ae4dHDSLP5kF8KJkEVc7Z3N0zbW5dsYCx/FUMhHNoYbgDK11Qshr1v+Y77k4Doj3FkEtgxyiererhiVZuxAiihrI4JytMDsfJgtA/S0/TsA18d7Y+aF95ePLIWidQbk23hn0Ky5MFUg4GoFAINI+TAbRZKMHocROqta0ggSFKhrRUKyS3ezvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avaRGQ+ve4o1uu4LCzGTIuVJV9ZowH+vjGRU3vPbpQw=;
 b=eclYcKIhfhD9pX1vZgQBvIerwTp3uIe/oWzxfRTEbbgud+4G3i0MMn0RZhKfKbPXyXr2XTWX/XUWSaGYTIpdgdcboPm/W3WWDQD+wg6R+TXNBnuqYIQFvQ7BjbVDwbUDkFgXm2khgxYLzhnSef9OjxurEw939SqrZuh/CB68Feo2L/12PdS5oPeMAMFzei7P57w3FnoobBJnxYTs1ckbLFN5oiCifQUe03rtJNJgLft8D0C+6FrA2fvkGKMJyJuzgvPJUxTMQJtkFqeynWApyu5fstg5MD6aR2UlDq1LLNnXi6ujqyrXMscVkHFw7ZahwV8q4Hyj/lek/LUs+w7SpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avaRGQ+ve4o1uu4LCzGTIuVJV9ZowH+vjGRU3vPbpQw=;
 b=TypFAJ80M4G2vu49kazZkCP0ZcCRNfhA+eK3bVQAKpyh7tn3hXIpqjZA5212EKUedfxHKbX2QiPwekHicu8Zp9DSMyVfJJIuWyZT+hGg59HAhD4o73SnJYJtqoIwWeAPpLIIdrxAlHIArm3Amt3so1WW5CHwDucARVFrjs3+YbY=
Received: from BN9PR03CA0285.namprd03.prod.outlook.com (2603:10b6:408:f5::20)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 16:59:28 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::cb) by BN9PR03CA0285.outlook.office365.com
 (2603:10b6:408:f5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 16:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.16 via Frontend Transport; Thu, 7 Jul 2022 16:59:28 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 11:59:23 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 04/12] cpufreq: amd-pstate: prefetch cppc_req_cached value in amd_pstate_cpu_init()
Date:   Thu, 7 Jul 2022 12:59:08 -0400
Message-ID: <20220707165908.215470-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9b65588-a995-4982-cc68-08da603a0dce
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUCnx2nkeI0x1OYNeTkH2ssziac+l2YECRfuifCXWZNtLct3a9nC+d6DjcBzpjvIPYNwRs0/ZaOxPNDtWmSoGHrjMQROSH6YWfne5K8h5KMSoh5C05r0dKsxtaQkCOyGguf3RrQpCk9cQ5UaqLgN8FxwMmkqbSdmVnXJy/qv4LR27bPrSlv9msDHsg7qtoz6DzDVi0OILj0KmRENPMam3/PUiDuRCfSpSZcj4e9MV2koAJxYPwW6JTummTe+rRCgxDo6alzPLYShKvhjBxvBtlBUMwJBgRNrQlp68cKkf2cmnH6ObfPbtqWKvGHyBpPbqNY1NR5UVFYJEQnbsXvZz31bPFRagyMbnSkDu494B+2Mq3H9XF1u9VcK9xHwp2UB2rAqj608nc6yjOBANNyCMA+6WPpBn07QH2D42Il+hMEvDcwbA4CrsE5g/iz2+lfDo9owPCZKl6ixYJjAcIpyqusL0c5cdidUSCqniv45E2oQU1Sg8ghuTqF/CTUy8AJIcMG1XiYIGK6MUtAFb6iphI8ZvKjtEXl7aKt+0NNZd/gHNfY4fsr+365SMfgGh3wNqhzy/aczSM8x5m2bdceGIWKQSIeG+CQOc/hSyyjsMcnmyD2jBWx+J+kU8LBboTJrMi+WeYahX2uY7NmLbDZ5V/tLvk7hf8TBhQrjVMqFav+fxVZrGnV3bijyAMpA4iYasz6NrEIX2c8gu7cLVMZE3hxJqpHgnaX2k0B0iVP0jnLq0VUkLK3QPuh1pIFT1wMyk9Z3m2zJJDcTM48eSirZ7kCfj7bLSBfsqS3Q7ZCe3RzZYYK2UZp7lnWJdPPS7qtObQ0KIneCDkicS7l5GGfS6+/WY6LIobMketMW2d0FhUqUMAx/6o/IXIKcrz/nr9df
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(8936002)(2906002)(2616005)(36860700001)(478600001)(4326008)(40460700003)(86362001)(16526019)(26005)(186003)(1076003)(34020700004)(47076005)(426003)(336012)(82310400005)(82740400003)(70206006)(5660300002)(8676002)(7696005)(316002)(81166007)(70586007)(110136005)(6666004)(41300700001)(36756003)(83380400001)(40480700001)(356005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 16:59:28.1747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b65588-a995-4982-cc68-08da603a0dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cppc_req_cached valued should be prefetched during
amd_pstate_cpu_init call period, then the amd_pstate_update() will get
correct cached value before updating the perf to change the cpu perf
level.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 43e6df9f67f6..e4904da54541 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -547,12 +547,17 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
+	if (!shared_mem) {
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
 
-	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
-	if (ret)
-		return ret;
-	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
-
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+	}
 	amd_pstate_boost_init(cpudata);
 
 	return 0;
-- 
2.25.1

