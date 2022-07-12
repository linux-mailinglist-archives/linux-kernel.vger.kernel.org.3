Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35A571FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbiGLPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiGLPkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:40:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44730C2598;
        Tue, 12 Jul 2022 08:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwuDVvGbUs4PTTUHOADy+KvAvkkGuShSob/7KReIC/gPkrJhZ0zUzWftkk7zbu/K1SuI2g2IJkSyK1J8FzTLjkTEJPd4l3UaJvaGdA/hnryKAD/UbaHrTE/BQhCLQ2BlV1emPTKZu7nmwlped9JSDJ229oIsn0HvdtDQLlacez9HnITj62L1RZ6+p0u4x8kr/DuLFEJPeF9AaWu4IodS5n7NtXuEkkX1BP7QaYAj2ywi+W60E44E42n2aA9h97V15XjYRsRmyjG0OiGQ7oFs9j6GrvNZeTkVSypc4KBJGuB8AdDgRwjlNTTC4ChXrWqAmojkBRvAP+pGk3YJi795Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avaRGQ+ve4o1uu4LCzGTIuVJV9ZowH+vjGRU3vPbpQw=;
 b=WQt/QJBKgP3U557qGxEvWCKlEeGDSPYdotrJNmPJDmXf6PYRgPOVpDHYclwxQuyoa9MJYPxTQxB1egEm4rZYDzxj3n3ZIbNDfpDCBu8KtklYst+xkYvfdq+rEBrPs7SyuS6WEhPMX6yfut4csubT4hBgyLIazeipiVzriI+iMwlnu/bSlG5D6e1LJsijmg0itBRnAna2aMtVdSQBvCTG+Ipb1aKpUA2PQAbp8Mi7AHwYGi1mR3s/1UHvdVgjrkdyvTAw2lvCCgffN10Mjvql071O2S1cJjMAmow0ws+b/++meJfwM0C0XsVXBi6TumoNLeywVv6BD8+4NfQ6oFo1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avaRGQ+ve4o1uu4LCzGTIuVJV9ZowH+vjGRU3vPbpQw=;
 b=i15/wOm6pDFopIXTxmQjNdODrXQMUvARi9EWzBgj7b/eoxyh43YXEnxGbM6iMxTDPKq5mGZakkNfoVhWvFVCSd1Um57gIHrmewsJd9CV04PGNRUfxUxOOy2t1w8niQ3geGqdFS7pp2JNeK/+ISsck5m8dhd9R47m95ENHn2gQgk=
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Tue, 12 Jul
 2022 15:40:35 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::ed) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 15:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:40:35 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:40:31 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 04/13] cpufreq: amd-pstate: prefetch cppc_req_cached value in amd_pstate_cpu_init()
Date:   Tue, 12 Jul 2022 11:40:20 -0400
Message-ID: <001d002ba93580763421c712247bf8d9faa67756.1657638462.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50420444-b693-46b8-d4e6-08da641cdce5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GurQ8JENrrPHwlVqf6+2P0ibc4sUFeiIgrhSaw64SRLRrChmqRqm1b47KF7tgBUR9Ts9oJO8dTzvmICN2SkqLBc/XAYBvE69L7t/1WOsHuD9dXmlAvXV3e3ModkhirPdwQv7aE4zezPWJ6dyc8VIsHjrpGbtfxIIuhO/RJPCtjhMaorx4bNTCyVvKjU2rebG21zm+ysOg+jKV99gzh0gJJ6EloksYqxPJK3iHq892t10toyNt5Gy2sZd0jyPjf/qrL9pFrsOYS2l1XaubzTyRtINWA0+kMykTI0CMnq4lB5NeCJWEe2NIozezmifqmhqep7kyIYwXq2a4K8FyvTBCDecz+50NF8FAJRCh0WKFnx4QuQMCYnV2ud2aDpX5rNDrtwUj7NG7jZdF1FbohgsegqgTgOr+iOb1AiwxeAt4iG9jhnnUJY1m80HR6T3p1oWfk/Ob0uKHDc9oWolWgCFqHwxZnWNq0K6TISuQHz+tlu/Au9Dmpoo+Lv+6gY5ccbsVj6w5y+7rLcpbAg3YiA81IqxPWtWVYf18he/jHZWE+C7z5pkJrrMv6EAXXzBL2mJirlDXSivfNfDqwUBbvlUlVzdUhbhQl4PZitVTYT4AA5Nx92LousfLy8JaMiVF+IAUcrYYX2MELIcDY945lscCn+G7KWZb1BlQrC8Dl6bSN5iczGk+kzQYAbEIdeWsU50r2N0rOK6uwrNYVsulpURlKBixXI4zCjC/y0okWXvK7/MjX9RVq5JqsPc42huhhehOw7KQOWPjm6h0VdkDihRJHk7U/X6ABAZZn1/AvxpybuajGgcE7W8qD/xK7I1fSdniABm7qJXAk/e0baDJ9pTJHcbZ54nRrg7ozHhZvGEafo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(478600001)(36860700001)(40460700003)(6666004)(2906002)(70206006)(83380400001)(4326008)(316002)(36756003)(5660300002)(54906003)(82310400005)(6636002)(110136005)(8676002)(8936002)(41300700001)(7696005)(70586007)(2616005)(47076005)(336012)(186003)(26005)(426003)(16526019)(356005)(40480700001)(82740400003)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:40:35.3476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50420444-b693-46b8-d4e6-08da641cdce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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

