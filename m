Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC493571FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiGLPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiGLPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:41:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2069.outbound.protection.outlook.com [40.107.212.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AC7C259D;
        Tue, 12 Jul 2022 08:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzrTWnqwmzK3uoQrQlyu+1EfkQrnw0ANR12zU4nvH73uAB56lbLXpjpeSJpTrVdXEU1HGnddRVBe/d5RZruSJ/km7Io/1nDHhujOskkXLJ3cyynZhHU773OvAznTmjpMrzXcDQRktGgygDjsJkZmSVMcIuE/PTft1Z0iW/1GJZEb+nlxJCub/Q1XgjQ9gqQ3pXoBbDWxySNh6+TgszS3GQeo4Jbbh9gep8tbvHmOzFRnGQPkl4aRaxNVa39Zfi1ZHE5AyS6A5AvUSEi7ANIvEKooKmMVlP2sQN4btxA3aoZpIGa2fK8pJXQNM7BiNMbOppI8mo9rXg5d4nLrflO78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqCRvjFLGerQx+cpbnO15BmME5AkfQxPNzHEeLlXMro=;
 b=DUxgxRypinOrnSuREqZZCstDHihzkkdFiw5VUi9H5k2LQI9mFeIqTmZ0ZzpC/hW6aeVRVT+647cZrKnT4jG8t4iGdFFoPcQAxViBo9QQr/EVpPWE9Kwz9snlIS5JTu4PANpWjAAehIIFfK/Mxs1JV7IeD3+r4F2A3rOGqgktfnSpzd5PEEgxBmSltdHEPX+HW6Wkr61cBN3EJtGF/ibS6S9Ph91QB3gakf/YXM+eJLNoFUyWFEPzslB3yiKz+jfksuTpBwGTbcXDnoyC3KQ3FHUVBW9SfSaxsxSdZPz52Vnjqm1ETzOoGTSTanIFQB8l6xjmNmD8+tGR+07/okxE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqCRvjFLGerQx+cpbnO15BmME5AkfQxPNzHEeLlXMro=;
 b=VsvVCPj1sH6HEJSfOUVdJbpD4AHw0mBvJd+GIsAki+9bDLBEwFYD1PxCy9sn1bSNggaxHdQop+dIhJ2cUN5eHDuIt8AqlS9KMCwwD/fvF2q2Fce2CwQXOmA/TfBot5g+Zp9ok4dMylbs8m5+qG3bnnTgpV+c7EcvtFjxBk9Me2U=
Received: from BN7PR06CA0051.namprd06.prod.outlook.com (2603:10b6:408:34::28)
 by DM5PR12MB4662.namprd12.prod.outlook.com (2603:10b6:4:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 15:41:35 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::88) by BN7PR06CA0051.outlook.office365.com
 (2603:10b6:408:34::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Tue, 12 Jul 2022 15:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:41:35 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:41:31 -0500
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
Subject: [PATCH v3 07/13] cpufreq: amd_pstate: map desired perf into pstate scope for powersave governor
Date:   Tue, 12 Jul 2022 11:41:22 -0400
Message-ID: <1c7d09c93e1e1a3eb1282082c0ac7b3c54877777.1657638462.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9722edc-61ad-4b5e-e13a-08da641d00b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB4662:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJC1qitCUmzptrDH1cAkmr/DBs1CPXeeUrnRP0Dh6sSWMYbNYGTlszOTpRY8e/zJKK+ZaR61WMB7wYTXO0U43Sl/RpvfMsUQrQcBsp6MHVkAkFHZ/NaH9PhLPtoNh659gJ1bQcMVLEFwm5Vy6wmyqHKV0eT/C2OIir55GeVSvaG3vXMNnamIRdJX8DdxwUxXhOhyc6N21wyIy0sgLQ9vynrOwl5fKdhYJZjmD4lq1kgWNHsqYU9fcZQTkLvGSnVpjqwJegqLArvM2X3BD64U/QUToBTbJRlFX4PfENEfL6sgzeG2dvHq3T8tqahd8hpRyumqCmbqe48ph2iD+ao7iYFvNj0X1tR4tOS3GKkBV0Z3TTmupGSZ8kjJHPsepmSvUtfxtzR4CVrHx/ITT/abI7hZwbMXtle26ho5ZkkQGYuZrlX0Hjvry645JiJGqOjgxTw7jdx8IOKDK+JHoec2KGUaZ4BxTSZCFmfr/TywKmVBPCjJmiD1RWijzpvvGABKjtI26E/rN+qcfm95SRQEEpjr8+DBUJUEs4tJLqvU3KXiFcgwKmSI49zqFG8xYK0b+3r9RYBKDQSnPMCTHHPIOugijGzBdFEh2IDo2HGbpYd4dYpi2h4wy1mH1iG/DhiLj3S4u3n6JVQhUsI8hvNm1wEueDddQao6AffMb0UrRUuI97Nuk8Ej3rVPMWNA9B5y0qlDb+0EYrsqHvZEz3VBoVIi03bKJzIT9TGo/lpztZ4Z6WOrLE8NlfDSJX46TQZ5IDzgJqDL3hQNy8Fd7vRt0IqQJ/m9JcrZY8O9afA4Gep4bBW/L/Tp2MS2TpzUujBFMYLcyTKcbK/eujlM2/H4CuDT+0RYNh8aKW37AHUy05I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(36756003)(426003)(26005)(336012)(4326008)(47076005)(7696005)(82310400005)(70586007)(36860700001)(70206006)(41300700001)(16526019)(8676002)(186003)(6666004)(40460700003)(86362001)(40480700001)(81166007)(316002)(2616005)(356005)(83380400001)(82740400003)(6636002)(8936002)(54906003)(5660300002)(110136005)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:41:35.4470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9722edc-61ad-4b5e-e13a-08da641d00b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4662
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
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7c51f4125263..f359b1b20140 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -265,6 +265,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
@@ -353,8 +354,6 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
-
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
 }
 
-- 
2.25.1

