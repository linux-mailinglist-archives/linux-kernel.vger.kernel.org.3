Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691F6571FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiGLPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiGLPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:41:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B7B96B6;
        Tue, 12 Jul 2022 08:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDqctxKS1ST7vDKw5SR9nazLzv1+fsx2Tn4ViaVhf15KZMi4mlRNsheUsalWT5PbUGyzF7XoSVcmHF9muBMjlChzR5/zVFN2qMSQF2/zHvEiwIFaGj2p14wS95iWi3vP6pRgBuzim3hAKmnTeEBQ92UdYAV7J9qJ1ApIDBoc/69HISz3DSFqjw3Z25yMF06WO5DZpiamcOGlA2iwacwlOWObbGYk8KlMijlHZ+ywuxigxaKTBY/MGbniNlfQHp8AkWpG10kSrkDw3L0y6CgEopkED72l/a5bX3nJVrZTINUw626s3cIBwk5ptxMhdw1nfgw8lAK4Cx2KeCoHn79A7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IF95Ie9bB81+bMsjtP8dBQ0hXdlo4sdYb4W3ShgO7w=;
 b=eGuYnYWvmQQqCRhbzjmu89RoP65nO9qnSl/eHY7VoEYROrTJblB7Koj/38EE8SveNQA255SmfXDiUV8Y8IT2Jzng2vFHSPE5nqoflXiL7ArKIUp8H3p5yb6kZiohPfrgAMTxVOIc0r03Rk6Kr8i4Cok8wjfwJWsnKn49bCdbxQGughzgpY+PAjDJgDBVO/tmJW4gwFJGWAHr881Y5HRsYe900gkzc6Wuc7ygPWEJlXTcCCgm++ZZl+GqTP6hsg3o4s7qz4lwlIgxWQ3SI1Xzcu6Q5XY1qNqFjzzdgwisE7m2PSQSudgldtmxk8KOnvs02FbbsEm6pZTVlaMNHb/vdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IF95Ie9bB81+bMsjtP8dBQ0hXdlo4sdYb4W3ShgO7w=;
 b=N+hlchB6Y1hN3m8p/ZMbokirxyIIj+JGSyadgLLTAajzP70LJweYxWThwjGy2i4oZs+5zwd7IvyCwRTV4bpR2D2yBJ8baOn2NObEUympFQTMsSYRN+hr8yffuq7ovrhduqWp0cegHmL0T2MX4Krhqj0q//ogEkzPdAd4kNA2XS8=
Received: from BN9PR03CA0419.namprd03.prod.outlook.com (2603:10b6:408:111::34)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 15:41:15 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::2) by BN9PR03CA0419.outlook.office365.com
 (2603:10b6:408:111::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Tue, 12 Jul 2022 15:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:41:15 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:41:11 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Su Jinzhou <jinzhou.su@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 06/13] cpufreq: amd_pstate: fix wrong lowest perf fetch
Date:   Tue, 12 Jul 2022 11:41:02 -0400
Message-ID: <f722668e668e4f77370ad3485b6a80da52168ca6.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fd15309-1d75-45f9-fba3-08da641cf4f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4171:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tceb0aFMrx2ii47jsu1Zkj++PUCWXZ8IcVoYuEWMr6nIK5ktRrWsygIsedMR31npUXGBtVGgW6z5fjyFeV1W7fuFyiHRsobHkaFH/9JFjWXbUv4ZcLrU/zebiWEDLWYCrEWxyaIXwqtBaJslwVB2JqPJ6keVgdr/PXqEEAnyzOmmmjTq9+jQwml4RqrC4WXSr4JQb8tBdNvx+HaPtZzAJng2oMU+HF3hESIa3uqMaOIDz7Dyw0K2SQi+KvUIz5s7H70Ya5G0R5nJGGbuRQn9AVoBIvqzmJiXHiShzvGE8ZZ9+wLD0FYsx6tRcJBs4TjOHZMeogth1qEgEayojrpxCI7MoY+6vpNjJx82ypW16mzZHCqKM/e2v0sQbasy3vZ5YNW/WDEmvbKx8mXf5hnQ6gUh5xgCe7hbT4tg0dEGIUt6iFZtDM0yCLYsG+HsD2CDVX6sixHg8nxcO2hKHphOU4m55Y3f8aMYJVGMlwE4Xe42C4az1w6eS8MOeLNtnz1kdoTufjU+f3qsbZ7p10FVFR1v+0BM+z8CvBSUqTOrm5B6qG7XFZ/rJUh6rVLQWyPVisMYGXD8FzkbxvLTGTG4R9D6fITGWy4t9h+wTDDRsTLdHw1/QvUcYIU4ox8fQKVu+XKSxt7qLtKB/nC7TF9s1zCDe2auZ4GPQv4BNGJmj257u2z48VbuuWMtbQxVDAG4g5Ec1LlPyBqXL+iN25OcMaJzGGctNOJmAK+a/BVKBtHCtZ5KqDKGSKBRUIYN+3ulrWeP8ILym8ld3F1/6Hh4gxRP6bn6JMT1/Cro6AV1IMYbKfiv3WW8+I4jauSEVU9m1wO6VnUicTB+N1o4UoraDbCIGngF6U8xEa4pf9Rm5Bo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(36840700001)(46966006)(6666004)(16526019)(36860700001)(4744005)(186003)(54906003)(2906002)(8936002)(86362001)(36756003)(5660300002)(82310400005)(2616005)(81166007)(110136005)(40460700003)(478600001)(41300700001)(6636002)(336012)(316002)(7696005)(356005)(426003)(47076005)(70206006)(82740400003)(70586007)(83380400001)(26005)(40480700001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:41:15.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd15309-1d75-45f9-fba3-08da641cf4f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the wrong lowest perf value reading which is used for new
des_perf calculation by governor requested, the incorrect min_perf will
get incorrect des_perf to be set , that will cause the system frequency
changing unexpectedly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fc0de9fd643b..7c51f4125263 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -308,7 +308,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
 
 	freqs.old = policy->cur;
-- 
2.25.1

