Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E227F56A8FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiGGRAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiGGRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:00:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6345A2D7;
        Thu,  7 Jul 2022 10:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXN+58/LE7VjUeOZ1ezUdZMFntgcWhir1q7EcQhguSU02/sUeFDQdpszHDKPrE8hIHhcv4+f0W6zk4DExdUqt1HD3+YjMCXo8ah+OFobnuHSQ6ZqPFgdxqzKeKGXj5I5s/7lHnf93MJQDx7M9Vm950n0YV6TipNNQEx4yFGqyd4J70Jj/oGYC/aMWjnnvtcYzrU1M1JuAn+EUWs4mvGlhuK9GDYTYtIL0DbKJ8leHf9sxy4Bm1sTHbMSNVlKX92Zj469vMlILsR40m4nFTwN4gJgnheovc7z5jbFq87S8FouzA8YUgyOAcB2JyTqqC3wLxawWxrx72FobfSnsTb8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO3WrzBohaF2MGyFlIjb8L5AhA+D+Aiscygxe+O0FAo=;
 b=XSQFI7T4Y/vzSmEk5eeI7uTsBX4uHm6AF3dIi8TYITCv96I8Ir4jEUv8mTFjPq7Ud5t85zpnUUUVv/11fGyv4dU+tuf0vgs7udfERQhu5LelTZPXX7Nw8LOwji2bSKwGGuwWKCmJ3qJU0eSSjmd3qcv2VhMPkjXhcxGaD0+/8wK0lQTQVsf3buLrnLcLJvD5PiSKgofOF/LGu3d18w9qiBsT6Baah9p3OPbSoLv3HG4+WehnjwBnuN8yiDXZWmy7PXnsrxJOFrdQYKCg2m22RRSlJ09ys4mkPIVmwNMpKCpj+h80H6sNVojaVT3Yfn51KotHQ/Nhez+PMCcn86wjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO3WrzBohaF2MGyFlIjb8L5AhA+D+Aiscygxe+O0FAo=;
 b=Je6FU4WgM9gg6Jqybh+l0z3Qy9ni8PN0oQ/rkcjBEKi22hL3qOcqzG4cJUXUoZvdRBnn0AicrXIN08xTL8sIK6Riom2/vCTjTWVd/FAu3efDGimZiAe8dgMU8TCaEFIpOiBx2ImA48TaDH85x1uPraxpxrUbh5RVcrCGiDmi8sc=
Received: from BN8PR16CA0035.namprd16.prod.outlook.com (2603:10b6:408:4c::48)
 by MN2PR12MB3821.namprd12.prod.outlook.com (2603:10b6:208:16f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 17:00:36 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::71) by BN8PR16CA0035.outlook.office365.com
 (2603:10b6:408:4c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Thu, 7 Jul 2022 17:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 17:00:36 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 12:00:31 -0500
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
Subject: [PATCH 07/12] cpufreq: amd_pstate: map desired perf into pstate scope for powersave governor
Date:   Thu, 7 Jul 2022 13:00:22 -0400
Message-ID: <20220707170022.216202-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d256c7-8575-4ebc-f244-08da603a3654
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2HvMzdK4OuFYvf4XI6Sso5stDCblN3HAi/9LRXeSf2COvhPgjJPRJBmSIXCdveAsNzGsP3NIXw1vBFsZbaJKgYhpjX5toVqpqcS7WzAPQ+vY2qr5UN+79wsJupQjfp0Bk8V0PnyE5nKzORciQz0UDEotWZUbHMlrO2hvpmFeuMMWV1BKyqWKrwkCVwI7s1i/lzh7HWThMjFEvWKVQQPZFCcFEU5XEWQueoEd5pR30wxm13k+ZMKr2N55vTa9lo5mEFwTx4TZccoFYj8CWzxvaBP92Rcu8RVlfWHEMIMk/5VK7jdra8w+4LO4LzrDIenxAWJAJ2tlcVhU4d5euQDUNFyaRpapqYyCI/0ScfLrgB+UoLYRkTIX2NPal/UwggH3VarIsJu9NtckmGW+bs8dvxyxk30cuFEZwHEkapMunagmSgvRwPF4DFMXiG8myA89G1R7qyMZoYvEF4AAOj2NL5ECfl1ZcLHHtDocv2QUDvTJcRUhZ8glKnK/ZdGQaoKuVkT5WOVjh2dPcObVz1M9MCIfmepuo+yveVq3M7Cb+aXHH8LYv6CQzRv0kqXDFkcPXofsFTkMO7JhMPgrD5ZxkEZ3nqU3tM0hsD+GTjVvV4IpuIIyLwFn5jnMa9qWh9v/CI08JJuFkWhDDRg7RzhrQks3//FQ2hDJ/bcJ46/FB7LmJgJh60v4TsagJ4wSXcmDJOJrQrrbvAdVoqDi4D9tjan1RjxjwjShYONor7B1QSv0Vd4IUIptiyaVW5QeQOVcDllK/bmjzCAfk7AH9nbKcBqsT09S4idOL3DjCSnMbEIS0lSb/ps/23i6Za0ziSuOmGwqkaa5cNQSbs+WjuypXYeXkVRBSpYBeMBCcL5wwfwcsa6oqQiZtiC2A/iHuvr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(83380400001)(110136005)(2906002)(54906003)(8676002)(40480700001)(70586007)(6666004)(478600001)(40460700003)(82740400003)(356005)(4326008)(81166007)(36756003)(4744005)(70206006)(8936002)(86362001)(5660300002)(316002)(1076003)(186003)(26005)(16526019)(2616005)(82310400005)(336012)(34020700004)(426003)(41300700001)(7696005)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 17:00:36.1627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d256c7-8575-4ebc-f244-08da603a3654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will fix the invalid desired perf value for powersave
governor. This issue is found when testing on one AMD EPYC system, the
actual des_perf is smaller than the min_perf value, that is invalid
value. because the min_perf is the lowest_perf system can support in
idle state.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7c51f4125263..154eed849f38 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -317,6 +317,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
 				     cpudata->max_freq);
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 	cpufreq_freq_transition_begin(policy, &freqs);
 	amd_pstate_update(cpudata, min_perf, des_perf,
 			  max_perf, false);
-- 
2.25.1

