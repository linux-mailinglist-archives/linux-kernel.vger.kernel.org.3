Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02E956A8F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiGGRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiGGRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:00:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276C599DC;
        Thu,  7 Jul 2022 10:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hri5LPJ3x9sFKoNR2XVHrJFxN6juTLceIcUjMdFdVL5ya8MX5dENg2SDQUp6sb9+VWvFU/U2lQUSHVqJGrBtfwSQHE3qpPpvlRPtkmCQE27k9NyXy5U280dkXI3hAUaketBwoaSg0WRkgmAfx4DhVfS/+VBSk7iTkxSeAed/xOyO1cU+j3rNr+3jx/EEuTIqHI3zMOKnI9/6Wzn7WUeF9JXvKWeNW7CEHR7AtVPw30CkMAQ2gkscXcXxnugTNSYa6XvMkN5Po52YnKV7QdyPbGAHjPj9TAKapepimY5tmRY4IxDEyDIZfVbFuVwdsIjs050amCou5vcWgfMOXafyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76f2SBmh7P/rRxfMHYyBcgNGlGwGPtXKjcuhDvE1FVA=;
 b=EfImrCVOcK7eXGwuspwrFEGRnq8bnSCOOr6HNPGp02R7LgBzIYoL3KjFtBmIUliQn2iQE6gudhjk1JSJ8JCyAS0j/AolgGck/f+1YB3ohSqHmuXKVhRR4MT47K2Fj7NDl4rI0072lm+s38J+Jry6hVue72DykPjxWIlLa1J4+4KwWaKJuzz4fFiv7BiTzjEV5Ae/Ns18CD2WIkns/8KIt2uDEXa1p6rnLsaeDi2Z0F/oziQC8HeuKgc7cIQ1S+Ltw8pkF15muBszProFEd7deAuS+vaJdLKqJy6TfDOMcfb5bnKWk1W7SzWLjRvUBR9GkgObQUSk9+ObHL9BkHuckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76f2SBmh7P/rRxfMHYyBcgNGlGwGPtXKjcuhDvE1FVA=;
 b=E5M6+o8ZtvdtDNHsfQqNzQTquVtSBM96fXzaE6EKgdhkBjk0I9MHFlKlyzo/z1jfqpiw+7ngyWbxWNg6hWcXatcf9aUa1BFLs6cwm5XUt3/euCajOhE29zLtkwD/U6fx1HdcD6QhSunUDXfSiRRZKRZecCJU11jfkLAXSA4e12k=
Received: from BN8PR16CA0024.namprd16.prod.outlook.com (2603:10b6:408:4c::37)
 by DM5PR12MB4664.namprd12.prod.outlook.com (2603:10b6:4:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 17:00:08 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::90) by BN8PR16CA0024.outlook.office365.com
 (2603:10b6:408:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20 via Frontend
 Transport; Thu, 7 Jul 2022 17:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:00:08 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:00:00 -0500
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
Subject: [PATCH 05/12] cpufreq: amd-pstate: simplify cpudata pointer assignment
Date:   Thu, 7 Jul 2022 12:59:28 -0400
Message-ID: <20220707165928.215684-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f9c517c-a67e-407a-1304-08da603a25b3
X-MS-TrafficTypeDiagnostic: DM5PR12MB4664:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA4ErcmA63nmZ63TDBot9ajk+HcmMNPW6Rm4LL8Tn2hEi5GVhmyUXUvu0DOF+XPHmBWuPtYXTGs9eF9AStWl37c4YXsBTzw1qdsNFYiKPx/CfSfa8ubO+ipOvco0gO9/0cCrFi0UoluoxRmlOmW14pXet4MMLv92dDUitbnn+k4NKjxPtvcvlU/SYrx61UHKw/syZW0eGmMlaSAgtPw+pYNlwI0c2mGvpdbywZ8bxQWQzTbw9l2Rz7S9s6V6qWazPwKEvXTxVAhQBudDkSiGoKJTub7QOuMLSVddGM+WSU49l2l3VlhMDpw1WLEgi7VZ0cgjweDDWMwa480ik9c/qaH/5t8S9oo93iwTO1KfhsRY2X1HO1qgIFIkuyRoptw6fKJ8VU4zYOE/Xlx2XjaBbW1otW4bi8vPbBWHE7yv0P6F1BdKh7tz5Ow2pq8E9gwoiXUPs//0EsuJQr7w/hRoqb8/6jHwI2Yukr6nFwYCu/e1KIuNNXk3+IvLHHslQFSt+YMjUjRh4h+L2ujJj/eMyeilvaKSnozzb61Umnp0+1/ZqCImULciiuu1lbt0347+Kj2Y/MVAGh97UinhJM/RCgcvlC/grCpI0wREGm77xyeki+4GJcjY0cgjtmPpu12+INiFSGp3Tw5NJAMAct8UrDfhFek33k6HOMlKa12gfCDeleYuHaW4XDXlNH0Zwy+bSE0m2LXQjBtAoaaX+RyTrjvjkFeV7lACavpo2HdnCkOYJZEkIqm7Hi8oc0n5LxGaEPRskI8138bujjp80h5iOwYdbw5kyrJ6uO1e3ecOrABSHcWe0n1TpWSAQWUeGvfTFP7NKVbJvLig9byoWShivx1UHttDPvc2kuBBuw/AJLmghOwdrhTOV3pcS4J+XCw+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(40470700004)(46966006)(478600001)(34020700004)(1076003)(186003)(16526019)(40480700001)(36756003)(41300700001)(7696005)(2616005)(110136005)(6666004)(2906002)(81166007)(316002)(8936002)(5660300002)(54906003)(82740400003)(426003)(82310400005)(47076005)(336012)(356005)(26005)(8676002)(70586007)(86362001)(83380400001)(70206006)(36860700001)(40460700003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:00:08.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9c517c-a67e-407a-1304-08da603a25b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4664
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the cpudata assignment to cpudata declaration which
will simplify the functions.

No functional change intended.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e4904da54541..fc0de9fd643b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -571,9 +571,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
@@ -615,9 +613,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
 	int max_freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_freq = amd_get_max_freq(cpudata);
 	if (max_freq < 0)
@@ -630,9 +626,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 						     char *buf)
 {
 	int freq;
-	struct amd_cpudata *cpudata;
-
-	cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata = policy->driver_data;
 
 	freq = amd_get_lowest_nonlinear_freq(cpudata);
 	if (freq < 0)
-- 
2.25.1

