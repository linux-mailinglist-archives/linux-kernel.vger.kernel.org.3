Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F549CE19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiAZPXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:23:20 -0500
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:21921
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242785AbiAZPXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:23:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYtdzWGZtVdhw8DcriFNPS9M0gvMevldnzEBfI62RSCezqEGc49+4H5RR4NwKe1Ex+0HIR2W4h93YvI7Xuu/9IzoP7G9jR+kPiCS2hcPZEu0fRJdzyXCYrElO2C9gXbQ1zYB7+4jFzjtRN3K9lLCkUbiSX0akWBoDiBrjxuNP0og3Gg1LrTrgun/WBy74c16YnW9zCoNFeMxOjL1t3b6vbGwPTStfGXkSzlUyvWot/ADG6tGoEHJG2tNTvmqDmIpn39p0W4YW4BP/ILc795f9XyLRRt3/geVkXcli+kgHWuRwKlfQP8lbC9ARL6iueF+DdX5pIVKeZHe/cPZk7wDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I59a/cJoIEEbcnLt4X9O1M6tJxwYsCriST2wKIHDnn8=;
 b=MN8kHaS57szt99iTuHt07+ORdBMJgsJQtPpwbrg12d1xkr7m+NCC71gwtiXf+hng9p6eRN84PniKFrLtWwJeKbKK3d1sTpz/T7oac8XYvZ6/d5e8TQPHz/3F2cGDYpfrj85Up1AlYb7pcxVv1cYxYYBndUGTBwqR83D8Y8E4D/2xeqpXjeFJ8vdfLQew5pzVGzZwoVVQwwGUdLbvSuU4+GU1clpXb74KFEVmzqvSxgzX9jfNpL0uyvtVVo+I4JaWIKtA3zNswAsKGz25dGY8nbKoP8Y1F7OVma+ZVabCMto38WEd9//XKQ8Ph7gK0jbVzhHrKJw6kofjUn0HohigYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I59a/cJoIEEbcnLt4X9O1M6tJxwYsCriST2wKIHDnn8=;
 b=5qefqZb+Ne0+K2SB1KWsVXLCYMi8aPCyconteqfYl0dyK5sQriD4KbQ3neSrtrYxeDsHvr7u1fFNjXBB3xpoRnYi77rq1anh6NEdDugi50PS/FIttxCrG2MrbasR4Q6dzde1eci9jg3l8CHtI7mW7LSHkH5qqMymrdWtF9IxgCU=
Received: from DM5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:3:117::17)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 15:23:16 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::5a) by DM5PR13CA0055.outlook.office365.com
 (2603:10b6:3:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.6 via Frontend
 Transport; Wed, 26 Jan 2022 15:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 15:23:15 +0000
Received: from ethanolx1ade-milan-b0-babu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 09:23:14 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <peterz@infradead.org>, <juri.lelli@redhat.com>
CC:     <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] kernel/sched: Update schedstats when migrating threads
Date:   Wed, 26 Jan 2022 09:22:23 -0600
Message-ID: <20220126152222.5429-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73d28150-d77b-43bf-c895-08d9e0dfc63a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2385:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2385DEAFD42AC84574945999F8209@BL0PR12MB2385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqj3Mll6SH32ak7CPNCS5IAeC8jxyHOyQ+oWedkl9gMwXuEuaMbsPoJ8a6iB4vwkwNQJIgON/AgPfdohwdxKc6UFupf0vn6/zxTg9WrUAyKpahWhtyiYMxhOIlffJ5R85yNZSP1xAv6MFR12SWuoEEvm0KmTLzgAPlu/YP/JhyoWLtZrDXzUU3CnASkUTfdu56w8OnNZ5sIYuU3RpoKa78d93S0/7sIBmRZ/lTpaXhkzn3nioOpBkbgq6G7BnDt7iERAKj5dHbAMuCI5cKvuVzw5gEm65osq461VCCRLNSnO/QbRU0tIxqmebwnxkzByU390zP9nM+QFs2qgpTTM+QtG2B+ofcAFlyJFwT5NImxAVkJUw8kXu3XViDZcOLKcZPIrJ4KWEWbUSFTKbFvcpOTAqLPcDSfalQNUvKy0lZYrlCRrGhTamR5kH8j77EBfsF7ScW4PepWg6q80/lFmW4hfSfCbwjjiAGwKQbjoac7oteNYYKJnwXePVpgv/TaEXl62WD2BBmk6C185FfQxLchAaYCqfcAOqsLRXyGQc29/r0OzXatVQA6+N/XoUCpEBbHwaJlKF7biGa+5G5vVQ7kNtrc6Hvn4LSOE+NujdjzZQH/SHDx5RKKuIvpGuW6JIeaY2NwLFzx1O6y8YngUB4imwuoXVmSKaacWgCmJOrPO+VqS/iGr3qQDH21j3fnhhhbaVeUeZ8Ux+hss6CKAbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(508600001)(6666004)(44832011)(7416002)(2906002)(5660300002)(7696005)(86362001)(36756003)(26005)(110136005)(16526019)(316002)(8676002)(81166007)(4326008)(54906003)(70206006)(8936002)(70586007)(83380400001)(40460700003)(82310400004)(426003)(2616005)(47076005)(356005)(336012)(186003)(1076003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 15:23:15.6455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d28150-d77b-43bf-c895-08d9e0dfc63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel manages per-task scheduler statistics or schedstats. Such
counters should be reinitialized when the thread is migrated to a
different core rq, except for the values recording number of migrations.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 kernel/sched/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe53e510e711..d64c2a290176 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
 int migrate_task_to(struct task_struct *p, int target_cpu)
 {
 	struct migration_arg arg = { p, target_cpu };
+	uint64_t forced_migrations, migrations_cold;
 	int curr_cpu = task_cpu(p);
 
 	if (curr_cpu == target_cpu)
@@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
-	/* TODO: This is not properly updating schedstats */
+	if (schedstat_enabled()) {
+		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
+		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
+		memset(&p->stats, 0, sizeof(p->stats));
+		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
+		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
+		schedstat_inc(p->stats.nr_migrations_cold);
+	}
 
 	trace_sched_move_numa(p, curr_cpu, target_cpu);
 	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
-- 
2.27.0

