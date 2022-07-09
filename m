Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AF56C9ED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGIOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGIOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:19:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A7BF68;
        Sat,  9 Jul 2022 07:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMgqNiQldQFdqs9XkBAMpQLdJu1TEQnH12cWmuEYBlQresYo34Jbtmd2WFjEH5Z1crrWk23ETgMyK57CGFYGAY4EFEUX8S4UKyGbP0Ecc6H/SM9aV+uzlimQ0xpiP+qT7a9Qxk9IxhLKI5ov7Fxc+Fe8vFL39iXuPvISqGkQiz3fS2/sOZcBjtflRGA1Jfc9hCqMUAEXnxb+hprRWAetn18u9U3J5q4tHLABfZJrYNWgISbAcKuScnza7OayrdwG8w0G/u533NStJc0glKn+caL/nrLZn8jWsh6EGVyXPqhp0V+yZnwh33hgm70ZIxnwJfM+LquQqH4lh6sOo1qVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IF95Ie9bB81+bMsjtP8dBQ0hXdlo4sdYb4W3ShgO7w=;
 b=fbYFaHJaZysthGnGve62XuokFN8Pls+QHm6lxHEHe4VCmJz5LgK8T4I33olkEi7rZ+tUb++tHC1SJZ4O72Zw7sK8hz0XEKj0KEz7PQZHsWSSwr5XxQLldAiLsWwNmRftFMliBSUqIdjH+BHse+o0vCi01LUmGLJMS21W+uD4gG2etABStRuybg+6fvBrdSSXysU/CiCdpbti3zESs4+4gDsKPU0gEQRnIVdxtwBoSqYo+VgJ2YRm5WKajZmrvzSt+njjs1zvt+zb1Jb/gEhu0kngtQ57m5iiWi/oGRSbcH/PJrbSjfhOpkfoIUBugWHW7NHNXJQhymEOw4KqiZDRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IF95Ie9bB81+bMsjtP8dBQ0hXdlo4sdYb4W3ShgO7w=;
 b=P+L11+si+QOdvg6N8OloGHH9Fy/xy+M4HENhy17pM01nJ06R71iiQst8BwB+Zd7G7f8lC43EGGWjZjaFmVKNCYUddLB7Wqw+2+V2BUmK/NovbOsfdox1QXLLSSfHsDnEqHsFatiI35vmk9pAB9JdA/wDbsrLqPMHmZ+eUnscMnM=
Received: from DM6PR13CA0043.namprd13.prod.outlook.com (2603:10b6:5:134::20)
 by MW2PR12MB2426.namprd12.prod.outlook.com (2603:10b6:907:10::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 14:19:02 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::fe) by DM6PR13CA0043.outlook.office365.com
 (2603:10b6:5:134::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.5 via Frontend
 Transport; Sat, 9 Jul 2022 14:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:19:01 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:18:57 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Su Jinzhou <jinzhou.su@amd.com>
Subject: [PATCH v2 06/14] cpufreq: amd_pstate: fix wrong lowest perf fetch
Date:   Sat, 9 Jul 2022 10:18:47 -0400
Message-ID: <20220709141847.835725-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb36e906-df8b-4c8b-649f-08da61b5f8e2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kXvvLYAmCEfpLH9mDYBWzy+J+y4MbfXjEwWjXVi8yWVw6kz5d8ucmKl0A/EpaHFYLrJU+NjYGMT34ifO5LHpdhpOMHGV8FNhwUE6CLAuVX2YtjkJUgpOwfaUvRPiYVeiphSvfxlIDhUs3svLLb6TDM4Kbv5tjjW3OoHDs5GdMGc5a6hwv9Oi8f2Nzwm9HWEbAyn7HhK8v0IeZGH1P9NnZQ0TtICUc7eqMMqZCXJNi9V3dKN4S4wSzjIaWNSF3bbLZZPik6ecWVeETpTRy1a5MWcz+yhKniB2sICVP2I5l6wgsIgahHcZ9uvx+VzOoDQO5F9mQ17bmyge3vbTByECfd3PPewNdBC6QnY/P4Irtzm42GJF6B7iAq0kEKmsFET+Hj+FSMrhR7bw/2gtHyG51LTe7rNSpH3BoCJx9xuiiqIqqAGhvfjyDHsx5ovB3EBPHApPRWsRbq+on/EXTOpZfXX/uCMvgNJ7yBCFw96VCguuDlZNs3iDvA2UOHYngS7MwXEEtUfiTpgN7oi2WSOKX3XDNdcIq4BFHuXzypPGmdtTc01RASNcWrJOMW3v3F22XqZM0YJdKN3QjegHUGoom5r2abQtma+d2NGWRZgas9nHcXCKO/K09YqLRg1hyMxG37ix3XvheoQqLc9RqZe5VvPYDyVITdVpkB9ASEsIiRily0mHG4L3mqE/HPFfXZ4yj1TNFvELDA0ypD8GjDOwcMczGdhF+BDzkhVZ4HbmWLRdpy4fVVU9pNOfREOy5AdeGfPNzfYv8+p2heEcMrE9AcO/efbGbwPNOkcLZd1+QHuyEP2oRdTQ9wjQPTqaZTfOk7AyUVhyMx6Iz7ngoSjnLlQBHwCqcYLYKRmTsSjdfSdgN8+qQsXYOjeNFU2GUga
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(54906003)(26005)(6636002)(478600001)(4326008)(2616005)(40460700003)(8936002)(5660300002)(8676002)(40480700001)(86362001)(110136005)(316002)(6666004)(4744005)(7696005)(70586007)(16526019)(70206006)(356005)(82310400005)(426003)(83380400001)(34020700004)(336012)(41300700001)(2906002)(81166007)(82740400003)(47076005)(186003)(1076003)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:19:01.7970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb36e906-df8b-4c8b-649f-08da61b5f8e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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

