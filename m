Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CA575F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiGOKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiGOKFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0284ED0;
        Fri, 15 Jul 2022 03:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdoeqOtJIaTCp6oK7j3z0ICQbkv/H7t0uH4lOU+Cgq+In4SyP/yejq0RJCSzxfRcMjwSsDMkBnxZsVtBHhvRC7PcA/SQlv38aAISFwc2Oj+u/lLTurjT2RPwQ8ELMlexwENrheWhBuG3ECAnNJaWycyZQyolfZoWDTD9E154Zdm+KqWYk8hfW88Y7Nzvz8ViBKxHFwsptM+EYXClzJ7HfgtyNjVyA7AFUQCqGVUrb/kpzbEKbagq2++8/T+hfI7nB21oOHtHS5u44Ei3ytCTSzA3vnjQvcBjfPpMqJVFkOEVEftx18LyP2bO2jiPLJU3rmygX5FIFIWbEyaw7Q54ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYjL+dKiCfASg/bPbZ75wr3KzbdhPszKwAUG3evHkg0=;
 b=bFYrIXs8AExrc2JstdFCwA2One9qAuihPRQ+C19ufuYjINnIAdln+F1Vu6EZfI7oO7QTHqyW+6SyouA+syOY4bPS1q7lMqPMjbfdwkEit6Cpe+Qq/bCbeh/L55/80wUeYwImsIEvu5rq/B5nk3I8FAcTiVBakaPII3se/9yAhspf8c3Rbvy18ozCCw7nFop9QaRTc9z/zyPksheDkph5HaeFQu3FnujIqJvjvHvkOFDp0TkMONnnAcyLQZrivLik0OVDo5o2756/fZdq1dXUSZ6Nl0k7QFsRCsr19FHhc7bSWhucPgqsWtxmTv9VTrXOFCGiEJcxxkFaWHZgwCeYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYjL+dKiCfASg/bPbZ75wr3KzbdhPszKwAUG3evHkg0=;
 b=MlkCGiuV+fgbPNvxuVthPxXWmNhmD3aj5uLmqwIca7EPLuboU9bafC9VuNWcl1LsHjPjNx5OwRtl+xLJX1hVXHmZYCsGNR3tdT4tzQba6qzpDtAuHPImabWILa3UesKlTiIzMZ+pMJpcRv4N71pyVZ2+M7ZY/J2ALFQW8M11/ho=
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Fri, 15 Jul
 2022 10:05:32 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::91) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:31 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:27 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v4 12/13] arch_topology: remove the acpi_disabled check
Date:   Fri, 15 Jul 2022 06:04:31 -0400
Message-ID: <84ed5051c2494f7ec25317b6857f27b8c6f1b6b4.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3054ca7-a417-4a0c-2402-08da66498d48
X-MS-TrafficTypeDiagnostic: CY4PR12MB1799:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mYVcgp3I2F3Senjo6HbrPa9Lhc2OVLSmzzv2Euf4uZJZwx9I4m98FGV7oIdnnbhB8tkSPStMXtJGumnohWxangu3QrMKPucxMYhFYoRntInsuZu4+yZQIfu2mAUYFmPT2nfZsG0UzZ5zic/NMjldDI3Xb6nzCR+UoToBiMe36T3cSIOdHoz8H1duASHB4fgdKir0uw7zRDOd2nyRlYvCCuBHN863PSqFgh0upt+d5bvwHDpqA7EZCO0MJboyitcGyfC7BZJ34tHwvi+OidQswFhKQEE8oog3RYiVLkb5CjbtTiZ9zkQKIOmsAwnswaezyE9o/30qJzVBjQr6djyhqdegP+SXV+29tmGujA01IgAbG2z6nDfsxCw5Q6fGfewP43sZc48b5s/4NB3Vxzn6DQpsVBDur/SGXVKm4V8XBbWfxYhj1JvojIOrTG8Ko2jVpsv//cLi15Enkn70exQamzqCgwl7DgrNyciUI4WdhK6RbIvXAen12j2i/+fcM8lK+U7R/mCvwxNEkRwcq3LSdWn5ENjTOZ1YD+7CCWIyjlTZb/2+y+Dc4tN4SJnJAE7BKTdLwjN5OY5sfQUbFrPETs5q3i+F45P/Wk1E+zLl/y7XNnKslXwfF+M8hYewZ0XiEgLmDT2N4KIJzafdGnWsNgd/jLfvR1uVSVQNlncJMcFsMd4niMQDX1UF02+qCBd9f6wXyFCQvUXkT+Rom+CfaarDtkq3z7IrByx6B0ONgUTF68F2pvfrvfXB+cGVpEII4TDgLiDyJf6r9MwipUCAGX0OpMdRu+dtDdqlq3gN4taxLoIGnL3JpVuZ0Jv8WR/7wXEGljtsk28cfBfNh0JnG1kDG0a75t78PqcmPkobo5w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(478600001)(356005)(316002)(36756003)(6636002)(110136005)(86362001)(2906002)(54906003)(40480700001)(336012)(47076005)(81166007)(82740400003)(40460700003)(70586007)(426003)(41300700001)(70206006)(6666004)(16526019)(5660300002)(83380400001)(8936002)(7696005)(2616005)(186003)(82310400005)(36860700001)(26005)(4744005)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:31.4682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3054ca7-a417-4a0c-2402-08da66498d48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_cpc_valid" function already includes the acpi_disabled check and we can
remove the duplicated check here

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 579c851a2bd7..73a8cb31529d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -352,7 +352,7 @@ void topology_init_cpu_capacity_cppc(void)
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
-	if (likely(acpi_disabled || !acpi_cpc_valid()))
+	if (likely(!acpi_cpc_valid()))
 		return;
 
 	raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
-- 
2.32.0

