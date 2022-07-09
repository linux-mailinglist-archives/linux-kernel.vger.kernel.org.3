Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA856C9E9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiGIOSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiGIOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:18:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF53E10FE8;
        Sat,  9 Jul 2022 07:18:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkSk2SKuSJdZ2Ko9dbTNRiqQ08R8kvkt9qhaoKaOcJKx2l1wz2EzBsWHTEiZtFmiMZtiHz6VyzAUnsY+999oc+90U/kH64p1GP80EMsewAANx+f+ogr564bf4XS10QMYD+2I/re5J/xSwqDvvTkPeGOD3k4c9XOD42XtCkN3m2HN7eat34IM9/9xtf5XTL60X0mB0IVCj/xvwDaDfiqovYncCbYCZsMFyBCkiGi2LDLIM2JXi1dslfK6EvCn3/UoV4Pf3kfhMP/6rra+pfEyHzbs8PHlXb9JIrjjZtjib9k5Er0LeZ21xPaqVXtOWghUYyLsVDsKFhXTEGWiB7Ekvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avaRGQ+ve4o1uu4LCzGTIuVJV9ZowH+vjGRU3vPbpQw=;
 b=lHYO8f/t49BJKr3Cs9KHZ+tCSIEpNTIh7+y62Mwn8tP8G7zBmNifvnXfbwfAUSkZQP3rMefs+CDdZlern67EIJo8xC95Vgwz/2OuEgwSb8d6yiZ20Guojxd9MarmrTYuq7EUh4TxjeLQavk9UAdvYHj3QZKTj9DUHxgwaKP7PB48w0v7j/E633alNiIhcISscyLRXkanJ3pEq3M8LMARkwhvBcSpAEQtYG2TxbtPvg05IcPbXXKnUKfpHn8l9Z00asc2IcqRK96ZGCydRkJg1oaXJ82YDyYM7FglesfLbsDqXUnF97azlgBrBcOb7ekqyPxhbMwbbx4sERtUAW8I/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avaRGQ+ve4o1uu4LCzGTIuVJV9ZowH+vjGRU3vPbpQw=;
 b=nz9DYlLtMERF4lxyRe+lLoTOg3Qe3bNbdqDQ25/obQD21MrAApiWDVAWe5uqp15VXOAsQ7AaFtwXbF+St1DYzA7zECiMXStS6YL1Q2g+6heRUjItkh5VulAvDZFbmQkHO+ftaG6zNJkZXqx0HDcY9KFW1zh87rm/3V0AFmCYAN8=
Received: from DM5PR06CA0080.namprd06.prod.outlook.com (2603:10b6:3:4::18) by
 MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Sat, 9 Jul 2022 14:18:35 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::39) by DM5PR06CA0080.outlook.office365.com
 (2603:10b6:3:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Sat, 9 Jul 2022 14:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:18:35 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:18:29 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 04/14] cpufreq: amd-pstate: prefetch cppc_req_cached value in amd_pstate_cpu_init()
Date:   Sat, 9 Jul 2022 10:18:18 -0400
Message-ID: <20220709141818.835366-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c73a1842-232d-4530-ae14-08da61b5e94e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4991:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubd54Sr6cnUYAqgYS94TpvEfYvU/De208ygEp/0kmt4vpnDOghyAVHO+Qbm/SCtlB1a/X5sVCM80eW3AWj32aFK54QeMd3LUJHX7bfMUOkvs8u1HljXwOlze7V/3zHS+A++93yg41+Kj5R+lDU2SYKP+kKf7kfjSpeXNCRTegMrDt8DBLSzXz5ip7S9RPCM9VzTVJ2bXBqWEmLLzj2wl5J34t9rL7FQ2bsDppf2zTUgUNmo2wCWpSxbp2HeCEQGtboGRgHjfURZmPxxbPzwqUlD+wyCj8ZYcKBXoVqRft9siCqMp4tQNLylUsovXbdO1TuRXlFAkvDrK0CwJtHoJxFYzCxqtKNq+Sa2CWK7sD1bl2JvPOpi9STcZu7yKlsrjHwhfaKSfGg7QY0Y549OmEuPqfL+KguLMWrS4tuEALesy6oWl8hjRDr98WUsJVeV1ot2F/HmcSc1GHqTUgfwFTdPdpUClPZJvZunKmYD8LQ36bHGIZatJ93hs3bCP3kAXgqIobMlwj7h0TwX4R7GCVFcv8f83nYVQG7BpU72u35VyZEuBbOvNf3GEWEuOM4aiO+QM1xsetcDYT3tcexImHxc6mXdWcI/ZKLvXcDY50gLE4V+zz6JKaSgcFOrC8zNNgVj88u8STfzh7PFtOUP7oG1rz9BsifrBbpqh71KXcFUfDVI8qo95VzX0M+pcY2T9tsg59N2DTh2sk+YNpVO89h9fXHhgY7Eq1wyPhx4I6r5bMN5elX5Yge3umo6hqg0uyTOIXEnjutANROUdzob3GCCDfBi0J9YZ+dHcknLbgTEvUhVK+lIWv+mBq/jAE2MAYO5riGV5Wm+mn3ttmosSUpVt/pOe+JgyL2ttK5LrKwMu+JgyB6iNCyIavmA3pId/
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(40470700004)(36840700001)(41300700001)(5660300002)(40460700003)(7696005)(478600001)(54906003)(8936002)(316002)(86362001)(6666004)(2906002)(2616005)(36756003)(34020700004)(336012)(186003)(70206006)(26005)(426003)(81166007)(70586007)(16526019)(82740400003)(1076003)(8676002)(47076005)(356005)(83380400001)(6636002)(4326008)(36860700001)(40480700001)(110136005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:18:35.6475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c73a1842-232d-4530-ae14-08da61b5e94e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
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

