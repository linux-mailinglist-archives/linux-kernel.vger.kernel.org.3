Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA549F30B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiA1F3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:29:24 -0500
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:25441
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243094AbiA1F3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:29:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd6BLejFbwrGgN2zU48gYjjhFsqp/8D6UPY2zqdFxmrhBrefPTnFdKVjJsAkI/HIi7gZT3EMyZSalgecw4DI3ZYmOAOPoe3Qp4rffwG3dMulKWbh0BHBCQJiiifcKUNd5IP+Q6MbJQDqx5HR2lv6GVI8YJ10pK3RIa4xTmJzsEwo9UkxIiOsG7IiHgF/lp8PRseunyARwabBEG+GNYOygtxlgBkVc1w3/7ZPplatgesOry7V1RmXv/PGqb0TvMltw5G2Z56S8sIkRzddwbXHi3noOyrsVn0fRQppY8Ocixn2d0ZAD47LCgK4QpZvwhVfX9kI1kT8nLHVJYanME1E/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+9wXZVPFFKK3I8JhFqv7WSxDQv49n9zI/mDOCSw3bo=;
 b=DJN1qX9A0fH1mOikFgbuZOsmzjLHOccz7JelKo4DzYB1tJv00mxekrciw3sXMAsMHMiF975C/WAFrffG3FT9tcKzu9VXqIn7HVLSFetHkXC6FtvM77PmhDycB0z9v/ZPbFZwp7IPMTS6hbjq686wNQV0o/fZrZrR2of6LFsXkSR3YNE8MVpkVlRVLsr0sZLLOvI4Nb7H75IELhiasotM6cl7ydicToCXkNMgSMCUxVeBtXyDgaaUGTNj5Wir9bCvl6UyGvWCwaAMj8mZsGMy1JXwAtMkIBJgQ5FSwXxHaugMz/pxRKbUGOa/1XLBHj/NuhxkboXOVbX7DE0ZUQgexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+9wXZVPFFKK3I8JhFqv7WSxDQv49n9zI/mDOCSw3bo=;
 b=HGhUdXvAsMObAL5OmOQcHqzhxUe7igx2CfrswYpy2BuJ7vJIRDgctgPgwpDMAXLCgS29N3dcZxwSRvW8bs0UP/+9iN7yOPUIgh3rbqUutUnLFgKuMaOePHihsoqPZ/cVfl1W97husnfF6oGx8IFwLGh1k07FpLe+TjSkVxDdQwQ=
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 05:29:18 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::1d) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 05:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 05:29:18 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 23:29:12 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <dishaa.talreja@amd.com>, Wei Huang <wei.huang2@amd.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v0 2/3] sched/numa: Add cumulative history of per-process fault stats
Date:   Fri, 28 Jan 2022 10:58:50 +0530
Message-ID: <20220128052851.17162-3-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128052851.17162-1-bharata@amd.com>
References: <20220128052851.17162-1-bharata@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3dd799a-5009-4fcb-24fb-08d9e21f21ab
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB48651ECACBFE341651F9272FB0229@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAbsx9oUxkPf6JjseY2tpcRoT1o6NlJg2Z7ddxAknHokE9imLR1ba8XlE/UJRh2YE0IJFgZ546aaU4UAAWkVAhRdVJslKvQPLgVwI0Osqq6x4IHrMNPfONE5T7bc52l14nd9mR97KI1X19Wbc8EQyD7xnknMa/mNDuqj0DdJukL8CsvkuTEjqvpDRcXeeYJi5bZv/OOcalpIISWNLyMgxN4iJVFo7UWntN5rSvuUtlZzwx1zozvmj3NXuCS6c5z45THD3n5hdQvxsqHLzNhdt6KV5KY5SacwH4gVGO5xJYpc7lZSFvM7RnJmvchpaOYkucJReUnU/eJprVaB6E4+NYKhZBcUV+hnlazBv5Np0kSy8COPsvJBFbBZQCV+XgHt2Uc3FwsC9WypzzNRIPoH/o+AF2rydQhV/v8VS/30NBNW5k0avJtImG8BanFE38I/zOJWYpYOcir4XuvhErKWjrk/VFLmJMkiBCSzpIt0OthRy2UUtCrtmLH+AZm6FGkEQPRsu5IyAbCPay985rYYPyNdVjV2FvSAHRSBFgdskxYk1LphYAXtStBzgePj+dMEOs1sTHW05j9834VZ3pV4XSp6Pft/lltw2qA4dCqI9fYiafbduFpimRLgiWOcylSljleAer1ABB0Szo8YQC9A7eh9MaXMYKQ7yWC9ct7drdYGKWpaEGrg17+vJYkYUv6JWARZSp0cxmlXSyigQ4ziZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(5660300002)(7696005)(336012)(2906002)(36860700001)(2616005)(426003)(83380400001)(36756003)(86362001)(82310400004)(8676002)(81166007)(6666004)(508600001)(40460700003)(186003)(47076005)(16526019)(1076003)(26005)(356005)(6916009)(316002)(70206006)(4326008)(8936002)(70586007)(54906003)(7416002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 05:29:18.5269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3dd799a-5009-4fcb-24fb-08d9e21f21ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Disha Talreja <dishaa.talreja@amd.com>

The cumulative history of local/remote (lr) and private/shared (ps)
will be used for calculating adaptive scan period.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/mm_types.h |  2 ++
 kernel/sched/fair.c      | 49 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4f978c09d3db..2c6f119b947f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -614,6 +614,8 @@ struct mm_struct {
 		/* Process-based Adaptive NUMA */
 		atomic_long_t faults_locality[2];
 		atomic_long_t faults_shared[2];
+		unsigned long faults_locality_history[2];
+		unsigned long faults_shared_history[2];
 
 		spinlock_t pan_numa_lock;
 		unsigned int numa_scan_period;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d6404b2d42e..4911b3841d00 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2102,14 +2102,56 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
 /**********************************************/
 /*  Process-based Adaptive NUMA (PAN) Design  */
 /**********************************************/
+/*
+ * Update the cumulative history of local/remote and private/shared
+ * statistics. If the numbers are too small worthy of updating,
+ * return FALSE, otherwise return TRUE.
+ */
+static bool pan_update_history(struct task_struct *p)
+{
+	unsigned long local, remote, shared, private;
+	long diff;
+	int i;
+
+	remote = atomic_long_read(&p->mm->faults_locality[0]);
+	local = atomic_long_read(&p->mm->faults_locality[1]);
+	shared = atomic_long_read(&p->mm->faults_shared[0]);
+	private = atomic_long_read(&p->mm->faults_shared[1]);
+
+	/* skip if the activities in this window are too small */
+	if (local + remote < 100)
+		return false;
+
+	/* decay over the time window by 1/4 */
+	diff = local - (long)(p->mm->faults_locality_history[1] / 4);
+	p->mm->faults_locality_history[1] += diff;
+	diff = remote - (long)(p->mm->faults_locality_history[0] / 4);
+	p->mm->faults_locality_history[0] += diff;
+
+	/* decay over the time window by 1/2 */
+	diff = shared - (long)(p->mm->faults_shared_history[0] / 2);
+	p->mm->faults_shared_history[0] += diff;
+	diff = private - (long)(p->mm->faults_shared_history[1] / 2);
+	p->mm->faults_shared_history[1] += diff;
+
+	/* clear the statistics for the next window */
+	for (i = 0; i < 2; i++) {
+		atomic_long_set(&(p->mm->faults_locality[i]), 0);
+		atomic_long_set(&(p->mm->faults_shared[i]), 0);
+	}
+
+	return true;
+}
+
 /*
  * Updates mm->numa_scan_period under mm->pan_numa_lock.
- *
  * Returns p->numa_scan_period now but updated to return
  * p->mm->numa_scan_period in a later patch.
  */
 static unsigned long pan_get_scan_period(struct task_struct *p)
 {
+	pan_update_history(p);
+
 	return p->numa_scan_period;
 }
 
@@ -2836,10 +2878,15 @@ static void task_numa_work(struct callback_head *work)
 static void pan_init_numa(struct task_struct *p)
 {
 	struct mm_struct *mm = p->mm;
+	int i;
 
 	spin_lock_init(&mm->pan_numa_lock);
 	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
 
+	for (i = 0; i < 2; i++) {
+		mm->faults_locality_history[i] = 0;
+		mm->faults_shared_history[i] = 0;
+	}
 }
 
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
-- 
2.25.1

