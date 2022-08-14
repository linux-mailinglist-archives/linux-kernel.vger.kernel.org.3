Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD4592596
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiHNQvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243564AbiHNQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:51:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03390AA3E8;
        Sun, 14 Aug 2022 09:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKtavY4los7J92NX9gWy8k3z2sX8fEHN9SJihzKUPReGWO7BjjmRtggA+VCQq1qyIUKAgHAQ53B5uqscljKMd2x9N0bZZ9YIBuzxjl5Y5Pc509tfEVXK/3OZBEPhQBbxuOGCLHB9KzW+Gti2Y00XDt+6hCez8V68vh6i4A/m9+Ost4kZMQnzW4ui/5BItYsHv3LRTPD/bLj5/ET+w4/fWNrDRLiCN+d1wneTlVETW3RyGZAhAZvLXC/+y0z1TiarMB78KRHYLhkHzzMpjj81bYQ1Yi3vEj72ZEYMchZmlc2uk2rP+0ix69ImzAlCRsczaodnCc6vjdf6WaV/osRH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITP+xMcKn0k3zI9mRfi3CV1EbREoYmm1Lpq390wDadg=;
 b=B1rMzAdmiQLQ2/PKlLxpdXlZuBQKOZCmnH1l9IQ43UbUFnL60lp7K6cHuvMGuMIXYIxpJHQTsxwS+MmDTWouJDJbq7Fq53Z9b+ZBva6HwU1MEEInFYE2vdT2xetQu4nmYnPg0N/rz+D3/uyn9z2ksoTdtCH4NxXhcZXcKX1rS/qRjQ6vsnjwFHEjEJwxvHOBIN7iSzQ2pm89OhSrbf7TxbmBUPdTt8BC1ezqx7STWPOKPzdkhlY4XWt0kbOb8n4u/qOzwAClazHWG40Ssg0sT40oPj9HON3Moj579DTNW51ZP93QFNsghqBJ+SoaIV8RDRMvzIiBopB01KkJY8dbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITP+xMcKn0k3zI9mRfi3CV1EbREoYmm1Lpq390wDadg=;
 b=EK36ELO9f7QRUjTkW33dqDwsUaz6Oann5apLCE9VfeQOIIrUNUVOckTIxzyVjOftPdJLgRxl/4Fy+jbxXzUSobLjntDhqHop7F9RIo/eJN5zGlnKUa2IgzGbBuBQvmMdra4tgST3W0JDXeYhVx0f+019RFYRqWDC3swXdJugy/o=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by BN7PR12MB2658.namprd12.prod.outlook.com (2603:10b6:408:25::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Sun, 14 Aug
 2022 16:38:44 +0000
Received: from BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::cd) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Sun, 14 Aug 2022 16:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT109.mail.protection.outlook.com (10.13.176.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sun, 14 Aug 2022 16:38:44 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:37:59 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Su Jinzhou <jinzhou.su@amd.com>
Subject: [PATCH v5 4/7] cpufreq: amd_pstate: fix wrong lowest perf fetch
Date:   Mon, 15 Aug 2022 00:35:45 +0800
Message-ID: <20220814163548.326686-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78595ce0-55c4-437c-74d7-08da7e13744a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t1y8ZqFdHGvxHf5JYF7GWWbUN0mqnM85C6oKuMz0xXQLb/pnFlJCYJNszoDWNEwWAikTBIcIiFKKcf0DjrQdWHUREuX25hrjjVTWfkMIhqhux9s7enB8Gr0QkX4K+Ck8QCpb24hlJuYkng3vvXEu4CpKS+yUZf6MrGCgOb3TjBryctugnKQqu/F3kPmDfJ8zPLRGVsZDgG8j+uhHM/dvOB7mabZIOte9gP4RBdYESriJ2UprEAZRa3jk/M0gTqo25iN0AV6GZTQcpEsfYrs/IChDKBRMc6yjrNKj9LWDS1SRXPjjg5FE18BlHXshNX5COcINirllhCAtegOwjIn0tlKPb1RAkxu2tr93+POtr9K616CTTwNTULI4LTX4WU0AnSlv6Yjb9B/a9XCVkczm09wbrBCoRxkH4KkFy1YWakdV5ffZyTaeL6bt+AjX9o5WUS57Xz3bK+NEQ0PskId51H/0plg5vxiC/DCXXhL71kjOVjG3zYa0Ubq2Wf0PsyJsKNxnsDoXOnUx/7436feLjf3JOIUdZ0YRzHcEY2PExL/cHfvNFePi17je1YeAlwlMnglBCbYsHPiuYGVkyUzVRP8hWfu1N2HUJlshLC/S8AHrp4SCBSKf/Tjn/hDqUsco9jisqx4+gVedqGas+8BV8bw3BMI4Tix2zyGATFsFgm9d5FaTUHxUubn030ZAUdgrdIvFKVOQV8Pdup+hfH/IQAhbeQAAHQfAOah0dWz718pSg8f8O3W02LbmYi52fLRVg4iJMr4JQNVlYK7qq8JsSnse35cT5GH+PMMAP0/nrUhbKPhWJdOpHLjW/y0QPwOWtHmGM28Wc4A5XZvlY5USQ3rLBKtgHIi7BJnY0PBbZfU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(1076003)(336012)(2616005)(47076005)(82310400005)(426003)(186003)(81166007)(356005)(40480700001)(83380400001)(82740400003)(478600001)(16526019)(70586007)(316002)(6666004)(41300700001)(70206006)(5660300002)(54906003)(26005)(2906002)(110136005)(8936002)(7696005)(8676002)(4326008)(4744005)(86362001)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:38:44.6080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78595ce0-55c4-437c-74d7-08da7e13744a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the wrong lowest perf value reading which is used for new
des_perf calculation by governor requested, the incorrect min_perf will
get incorrect des_perf to be set , that will cause the system frequency
changing unexpectedly.

Reviewed-by: Huang Rui <ray.huang@amd.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5cdef6638681..183cdd4ba00e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,7 +307,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
 
 	freqs.old = policy->cur;
-- 
2.34.1

