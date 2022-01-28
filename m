Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE349F30A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiA1F3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:29:18 -0500
Received: from mail-mw2nam08on2079.outbound.protection.outlook.com ([40.107.101.79]:32736
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238975AbiA1F3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:29:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBCE9HLXwOyirykV886S6PqLovUiyjvVRkPVcwd8sX+FdDOp1mHISnpmV5KZQ29XlmEbBFBtoAiJaqPxswl/SVu8GaViiMPn99yD8vPx9LX0oexSA/VvvvPX+I6YnetbkAtFu8QduXjwGHKCuT4Bp75Dm6BRfFb34DVYuNiGkI1QCdvhvNBbwR4JuCj9q2iIWvkMXo/X6xKDiBDhGF6bfWinG1piag8KZjKArE071NvPknBiv8nmen7X6dt5o8sblkQV5F/owksQCrhvK3THVbbjR7k6PxPoLlXsQS2nWA07e3Zg7ZNyGMYfRrqh8KzsG4ilUgZn28py3VLoO4rNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWjLsyxWnfKMQw/gTvbL/swrp/QOuIQroTL3TLEQ9pQ=;
 b=Ydjx7+bTvySnWTAgwDRu8N3OxNgCtYIIBdlt28L/TGp3nxm9e32k+5BLzufnieRPMKYH3B2GEWkkdWKQ2l0VIKSqdP/lg+WbO5g5HvUZBx4QuFkfY254qT4gzqa223A/8HLkopAAuOztXxS8BKVyuerRPhTJyN79RVR91+57l+WoBd+mWDFcjusr7TS4tCqInPZW4oYItKlR8illJFQuxdfUKq+YHvVD6VxCDPPHOCi3OaxXxcyUl82ht4qcg5Cz71HZl8dym/pkaFialPFH9ftlecM7YXZVgkRLxp3Je8M6ccyrfQuD5fEI275ZN5viyGX+Udh88lnoL4tgHeMkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWjLsyxWnfKMQw/gTvbL/swrp/QOuIQroTL3TLEQ9pQ=;
 b=dCVnyZdXauBEHszTdxYjmTTVlJlbqpinyjBXRV5izWgY0OvHB53Ha3XVAt3i2yy9eGJzl43DupBljkFvkAxaJ8jyjMK7HCNOBlCkwakD13rKpYJw33bYp2bfn/Tapqlz8GlZ682xDl7P4gWxhOumPMkhTf3pXKE0hNDctLP0WNs=
Received: from DM5PR10CA0016.namprd10.prod.outlook.com (2603:10b6:4:2::26) by
 SN6PR12MB4720.namprd12.prod.outlook.com (2603:10b6:805:e6::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 05:29:12 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::a4) by DM5PR10CA0016.outlook.office365.com
 (2603:10b6:4:2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 05:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 05:29:12 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 23:29:07 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <dishaa.talreja@amd.com>, Wei Huang <wei.huang2@amd.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v0 1/3] sched/numa: Process based autonuma scan period framework
Date:   Fri, 28 Jan 2022 10:58:49 +0530
Message-ID: <20220128052851.17162-2-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 56ecd8e3-b29c-492f-d49e-08d9e21f1e1f
X-MS-TrafficTypeDiagnostic: SN6PR12MB4720:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4720BCE70D73A3A051C1376DB0229@SN6PR12MB4720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctS+Vzlbnlh7Ykk9AtdF63mpWQnf4WV2gd9iRL3AEPbD3Q+WVVn/le9WR81rpRU19zVWWLixaj9+jKxNqZyEpwcQay+S6snFdJVWeCP1YgDJXyHBnzEfW6wvl8aseM6OoMlUU7+wjS9EXgyRCHCH3NW7+R2vL1IAHEKgEGTAziyJvYBkJd0CKNV5oxl86LTePgzwsWMj6cwiefq+MlU3/svMvGQOuLVA2MAjp+DUZsZ21cK0+v6qOG5eVrP+vEzkr5dtLg3bb63GYeulP/vEDrAVDHyZvtrwJPeYWt6gaoYqPDOvvhsAlOn4ddjEZzHgVKD8NLOL7C6goQQ9GwfRf7iqBqD2JKK9X/dT2EtQ7+5xkpCnZq/bWhxvaepabYv4g5Spw0HoQ8PzxfrQxsCxYzZN+PwygECiLayF1+OyLsm5NqW3QRW1OSIl3D56Bd39Yv/ZCJAO4Z/JpfLnVkmW2Lm6V0bghKsjxAJ+H0ke1h91OWELOBbbLK3SYI87nMwf+iDN/YaztFxV8tSRIBjfjnEGNN/EwXr1ewNFGFrAp8brdmGIi9ocks7jSUuB0chgz5FjFcH5iXrjfM7K3jg+lob/BsdaJkd18BLjeqSPe2BED0l+aOuZqB7Mm1+Cvt/Fq2hayzPKx1aHpWS3SaVG3Lv0TJpxmINDZC9kfaodZQ8a4rY70ITVe1h4ZAsbUy5SSislBbBInrttZJ4vGIYLqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(40460700003)(336012)(426003)(186003)(6916009)(54906003)(82310400004)(4326008)(86362001)(1076003)(47076005)(26005)(83380400001)(8676002)(16526019)(8936002)(2616005)(70206006)(6666004)(5660300002)(70586007)(2906002)(36756003)(36860700001)(356005)(81166007)(7416002)(7696005)(508600001)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 05:29:12.5808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ecd8e3-b29c-492f-d49e-08d9e21f1e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4720
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Disha Talreja <dishaa.talreja@amd.com>

Add a new framework that calculates autonuma scan period
based on per-process NUMA fault stats.

NUMA faults can be classified into different categories, such
as local vs. remote, or private vs. shared. It is also important
to understand such behavior from the perspective of a process.
The per-process fault stats added here will be used for
calculating the scan period in the adaptive NUMA algorithm.

The actual scan period is still using the original value
p->numa_scan_period before the real implementation is added in
place in a later commit.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/mm_types.h |  7 +++++++
 kernel/sched/fair.c      | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9db36dc5d4cf..4f978c09d3db 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -610,6 +610,13 @@ struct mm_struct {
 
 		/* numa_scan_seq prevents two threads setting pte_numa */
 		int numa_scan_seq;
+
+		/* Process-based Adaptive NUMA */
+		atomic_long_t faults_locality[2];
+		atomic_long_t faults_shared[2];
+
+		spinlock_t pan_numa_lock;
+		unsigned int numa_scan_period;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..1d6404b2d42e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2099,6 +2099,20 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
 	numa_group->active_nodes = active_nodes;
 }
 
+/**********************************************/
+/*  Process-based Adaptive NUMA (PAN) Design  */
+/**********************************************/
+/*
+ * Updates mm->numa_scan_period under mm->pan_numa_lock.
+ *
+ * Returns p->numa_scan_period now but updated to return
+ * p->mm->numa_scan_period in a later patch.
+ */
+static unsigned long pan_get_scan_period(struct task_struct *p)
+{
+	return p->numa_scan_period;
+}
+
 /*
  * When adapting the scan rate, the period is divided into NUMA_PERIOD_SLOTS
  * increments. The more local the fault statistics are, the higher the scan
@@ -2616,6 +2630,9 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 			task_numa_group(p, last_cpupid, flags, &priv);
 	}
 
+	atomic_long_add(pages, &(p->mm->faults_locality[local]));
+	atomic_long_add(pages, &(p->mm->faults_shared[priv]));
+
 	/*
 	 * If a workload spans multiple NUMA nodes, a shared fault that
 	 * occurs wholly within the set of nodes that the workload is
@@ -2702,12 +2719,20 @@ static void task_numa_work(struct callback_head *work)
 	if (time_before(now, migrate))
 		return;
 
-	if (p->numa_scan_period == 0) {
+	if (p->mm->numa_scan_period == 0) {
+		p->numa_scan_period_max = task_scan_max(p);
+		p->numa_scan_period = task_scan_start(p);
+		mm->numa_scan_period = p->numa_scan_period;
+	} else if (p->numa_scan_period == 0) {
 		p->numa_scan_period_max = task_scan_max(p);
 		p->numa_scan_period = task_scan_start(p);
 	}
 
-	next_scan = now + msecs_to_jiffies(p->numa_scan_period);
+	if (!spin_trylock(&p->mm->pan_numa_lock))
+		return;
+	next_scan = now + msecs_to_jiffies(pan_get_scan_period(p));
+	spin_unlock(&p->mm->pan_numa_lock);
+
 	if (cmpxchg(&mm->numa_next_scan, migrate, next_scan) != migrate)
 		return;
 
@@ -2807,6 +2832,16 @@ static void task_numa_work(struct callback_head *work)
 	}
 }
 
+/* Init Process-based Adaptive NUMA */
+static void pan_init_numa(struct task_struct *p)
+{
+	struct mm_struct *mm = p->mm;
+
+	spin_lock_init(&mm->pan_numa_lock);
+	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
+
+}
+
 void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 {
 	int mm_users = 0;
@@ -2817,6 +2852,7 @@ void init_numa_balancing(unsigned long clone_flags, struct task_struct *p)
 		if (mm_users == 1) {
 			mm->numa_next_scan = jiffies + msecs_to_jiffies(sysctl_numa_balancing_scan_delay);
 			mm->numa_scan_seq = 0;
+			pan_init_numa(p);
 		}
 	}
 	p->node_stamp			= 0;
-- 
2.25.1

