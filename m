Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D8D575F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiGOKF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiGOKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C184EC4;
        Fri, 15 Jul 2022 03:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLAhyVdCLLNKYbsg3wUc/Cev2S2QrFvpqKgjeI7rfC5AovzZs3zewlcmDnOWskeeJ8vDnRaItNgdoRHuwMgWUcZF40I4dk2AJQw2e5eD7QeaGkobZ0OIc9JXadZK+h2rX3W+nhY2NzKnhLSHsYYoBuYeDLNAwM6YN5OkQkKiHZQ3YQ6pHwowzfGT829U9KH/ycmqQkDQyF/tGSQiCrTgUqZij2vxCK8Y/HT3aIsQ9ImZdSb0oxiKuUwX0LNf+c5HAK3N8TpTyIKAdwdbTHlfWR5iDdAdzot1+9j7Z4WX8QljkXHLWAJeieDfDhBX8F28LsPIPYXMgbhqWVGWgun5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tstHPiTPGZyIIUpZRPQPnBlc8CCgMG9WDEwA/OgWIII=;
 b=E8RPCo4hrVb5bWLVddgzsslDnBfjoyNtC0TW1KF3N9WEIMmHpMsQX1dNQwUEa+IIbN3PwQP7P6Nx7u5Ob2/Yd0Zsy2EZI+csKjEZraEWYjgFFr0afMV6j/zuWN1Fw+0g590HV+l+KqNe8HZge1lxhkrjxupBN4g7+qqiyOW/tj3bRW19X5TWkkEd/x7Uswf1GGW/fRvoD0j0JRgw3hdp5IwUUlmgO60WnUOU4fwGqXMkm4iG1gez/gAlBU2t3ElnAz4G38TlTSNtbN9hARMrFyNIP/STXq2sgHUZioMQQ6zxcBcCgPRdRdMGZwHgcHp3VZM0SWmhOmRX7XbMshOeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tstHPiTPGZyIIUpZRPQPnBlc8CCgMG9WDEwA/OgWIII=;
 b=s+kyLWhoJ7e7T0eIObaT/+D70SI/W2Ztey8qcWY1PHXpNMJuZQBLZq9qU+A5Hd0jlXnbRHSNZaqPUW5V0TVzInZ9rBiMJ9I9HHtvBvCGHT4aQIofOSZbH9YzNJvvUFp6HkQT4yj3iYsgyHHrwQsMMnVowBA+K4ZDwOluHCIHMbY=
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.15; Fri, 15 Jul 2022 10:05:09 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::e) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:09 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:05:05 -0500
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
Subject: [PATCH v4 06/13] cpufreq: amd_pstate: fix wrong lowest perf fetch
Date:   Fri, 15 Jul 2022 06:04:25 -0400
Message-ID: <7091e6ddb8605bdd870bad3273b03eea67354bdc.1657876961.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 495bd8bd-ad69-4d31-df72-08da66498032
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E3I+9OipyWXTu1E84fz3K/dxECxXp63vY12bzcCQ8T4YP1NBa78/SGXYtDP5hsZpQtMmgkxwx3Fc6erc+yEvp6zz2drXr0QftovjQvvplQl8hSgSNf3R7m9ItfMOmXFfirKybFSR+nCwMZ4rkMn7SZH7rhYhZaxWrMayFkm19c9j3YR6yHkCEZIB7aVXkwJ8GOC3AEyfYIr9yL4q+GFWvGmTIXk1rOSvRbC95Dw4TlsBN+wa45EY36jDNObJ0oo6OM79pkZqzTDegyNcZJR2FbnvbBrGUUwVo2aQtQAaL2O6NJiK/ng0TGqllFsWsEVWEPRKJoI0/CwSCrjrgaJVXO0Szk73wQhmM3CpYHsSsqro+mlLUoSHqvYm1NZaqjMYi6NbXIsxNGuq1sdMEqwad0eLKn88aWVX5P6fXLcOJdje7R4vuaweLte4luJYznx1u5DeIi8pKE6cBMLmlbOR5ibPF3V1k9y896HFWCUtcS2sRao+FWWa8jLS04EJD8DD0ofTRd9sw8m8fnnotvw6WlAXHN4AKcNTi8Z+nBM7Oh0gvMwYWnMS8qq1jLHZtxvqQY5uX0eahVWVRG3C8jDwlyZVIU0DFUxVVRv0oy/fRiillP5m8gHaqbgdylZtCKO82F/c5IA+bcVQ8vVnWysjtZdQX02yt9XjVk6fXcVJTh3qaoFlCKpXGst1EsToQHUvRNOAtwogeffnWvuUj9D8xeRfkBGlKcQD1NBrbByb7FXtIY5FWOqOD4F5Lsc/FEbj0i/TL43MhkSJ0QL24vgq/EGvczWhKxjnf1iW0da4vfxy0yM6Qfe70xKzuNwbsQkqWVSyiuRRuJkCKLoXfNgnWM3dwCLFzp55VJluKyxn+8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(40470700004)(46966006)(36840700001)(4744005)(4326008)(5660300002)(8936002)(8676002)(40480700001)(82310400005)(40460700003)(36860700001)(2906002)(86362001)(36756003)(356005)(82740400003)(83380400001)(81166007)(70206006)(478600001)(316002)(6636002)(426003)(26005)(47076005)(336012)(16526019)(186003)(110136005)(70586007)(54906003)(7696005)(2616005)(41300700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:09.5028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 495bd8bd-ad69-4d31-df72-08da66498032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the wrong lowest perf value reading which is used for new
des_perf calculation by governor requested, the incorrect min_perf will
get incorrect des_perf to be set , that will cause the system frequency
changing unexpectedly.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 0c8256638ed7..4b764870035e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -311,7 +311,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 		return -ENODEV;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
-	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
 
 	freqs.old = policy->cur;
-- 
2.32.0

