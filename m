Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1EE463497
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241970AbhK3Mly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:41:54 -0500
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:14304
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233380AbhK3MlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:41:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0KoqHQPBn3gb1h6TVgeMlXacC9av59VenIRXoCIpGg+86DqQ8aNUebJy2muOurEbCIc1SimBwDxEfXUOrSTioFNLIAWJHspjQbtpfRxoM2rOU3KcbW7veek/ix2ht5Bf/7DLewcgTqLJlQQPNKB2QuPOhtZxX3UYts0ZcC5bY9B/lGsh4lNED4+46ub9Vh3fVV8D5E1Gg0EfQAaRpa9C+oPvvGBtEFLVcMnEHKdyDHqSeJ3FfVqi+XYUqMjPorYdv3OwA9rAfgo+Hio5NIBxg072eIflcjS1eWXe7sJ0XZYwYkmNmkZh5BQyyplVaC4XP5zNQ3MDa3dD/leEhUq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfWIDe1EJej8mh4zOsSKWNNBsYw808aMLAtiEg28ST0=;
 b=YGPxaZlWfQ59YGtnZfvCu3qEW/OtnCV/9VDxywaL7g75yVfVxiND5JY2QzIRyrbacfATvFd2QiAkFZ0SDpbaD0jwAd+R91AAuczdEVflcKimhymkzNe7wBp7LU3JrALf9QpT5IBUJlQsiSC2+UJpb/LGLKGgWhAUtq/vzFm8ybdLQ9zivrB0VO/6kzu+L8Pfql/TH5LU17Oek3P+Ep+bq+hAIievikrGoLSsGmv/IbEqpUfxrO9VL9GIfL0+F+f8NF7FbhvJ1aZjXAKXtqjMsAinYOfPJp2J3Hla8biQUYY+8vgMNK4dM1lCJODcElga8Ifzs1m6BQowkzoFfE6oTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfWIDe1EJej8mh4zOsSKWNNBsYw808aMLAtiEg28ST0=;
 b=Qf/VPS0Z02oxIWS0dZtzgdj7+BGDzwLjkTT3Z341EtyOd7bCl9idFiVyD4oR3JE7bPH9inLKymf61YsxtAAYT2oqH8bRwBmhyKQPYiFdeet++AwahFyl8QJ0py45BpJ84V0zEFKNmjNen0amwhNwHo1fE6qq41GgJYuRHUedXY4=
Received: from BN6PR22CA0051.namprd22.prod.outlook.com (2603:10b6:404:ca::13)
 by SN6PR12MB2701.namprd12.prod.outlook.com (2603:10b6:805:6f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Tue, 30 Nov
 2021 12:37:57 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::d5) by BN6PR22CA0051.outlook.office365.com
 (2603:10b6:404:ca::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 12:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 12:37:56 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 06:37:52 -0600
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        <linux-pm@vger.kernel.org>
CC:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH v5 12/22] cpufreq: amd: add amd-pstate performance attributes
Date:   Tue, 30 Nov 2021 20:36:31 +0800
Message-ID: <20211130123641.1449041-13-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211130123641.1449041-1-ray.huang@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7ba157-87d4-4943-a8dd-08d9b3fe3ca0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2701:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2701C9EAD243451C2C6B93F7EC679@SN6PR12MB2701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0e/HjG3qldqD5zWUizZn9TizoN18VpSs++4arALHmB6z1j4CBGL6LX261M4Ws4c3tbYNuprGxv2xVJJGPLq000jQ3w7G+SoZh55/6Xta1BoROw1gt8X0HS2WMfQyXs/d0nU6Y+grlgH/Uqrv3hZHOA08JbdssGVUVQOjZYB/uNT+tl7i1puSs/FUTY25YQJ7yv41EID5sRM/aTOAQgXCG27S3ErxYdcBHgL3maQaRumKV6zIYrbBfGClEV8yUekPjvesNrfER7xS+6bgSTsGrtZFH8TY4iRPk4B6+Rb1IldOzpbPTXNzCip97NBrBfPsUYAKOlnQMOEfKSPkKO7dw2K3ew8roC+imm3VnF9zMC2ySvrva9duwRvh2XOe0eJHhiB4MgT9uFt4le1JKb8snE2wEfN/hZBZ/yfr/Lg7lAIS6bkEnarHXmZlsobbgvKENZp6As1PnzNDZkEAMDoTH9h9SA+TNvUEx5ZgG0aYJPOG8GJlDRtKYeUfAu3Iy2Qas/xpWKYFlUGEounjYenTYM27EL9G35fTuX6xUdG+MrenV0etZhhfqHNGn3Sor5Q3lCmjBFyZxiPjTUNciMXNvveCtD3FwIIF0z8Al6wkGK2Va+r9i7y3KXTAQpxtpYc931oWVQnbGETqos7DneuW8RK7TslW8oW8oawnNNrWY5sALGQI8uNuQAH09tAHyKJUD++HVUbUzlWBvc8w2YOH7Ru4ozx8kBxFO9kzf9TYH43VW8YP1wbwG5EsRObNaKVakjq253LJVRUQfROvKGPV+cvD8JlXjNx2gCxNyvqx8+w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(7416002)(508600001)(36860700001)(6666004)(2616005)(86362001)(81166007)(7696005)(83380400001)(356005)(70586007)(16526019)(8936002)(36756003)(2906002)(70206006)(1076003)(110136005)(54906003)(47076005)(186003)(316002)(8676002)(426003)(5660300002)(336012)(40460700001)(26005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 12:37:56.9413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7ba157-87d4-4943-a8dd-08d9b3fe3ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2701
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce sysfs attributes to get the different level amd-pstate
performances.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d462d5a28e08..c70274ae4046 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -513,12 +513,29 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	return sprintf(&buf[0], "%u\n", freq);
 }
 
+/* In some of ASICs, the highest_perf is not the one in the _CPC table, so we
+ * need to expose it to sysfs.
+ */
+static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
+					    char *buf)
+{
+	u32 perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	perf = READ_ONCE(cpudata->highest_perf);
+
+	return sprintf(&buf[0], "%u\n", perf);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
 	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_highest_perf,
 	NULL,
 };
 
-- 
2.25.1

