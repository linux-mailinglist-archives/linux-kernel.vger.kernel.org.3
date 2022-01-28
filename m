Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5548749F30C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346180AbiA1F32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:29:28 -0500
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:39379
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237144AbiA1F31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:29:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG/LCVpW7taxE77mZbFjlcROs4hSqakqlzSR9kl0mvu67jeDi9BDO8KGwseKsGoGCE6Ahi5WTaXedYaY8ww1aaQvyJ4YoCuZ8oGhxbgfH7mrriy37HguM9kMZkbfgwsO3k2yTOBvbDl20zM8TxMuEvMj8zpJqUtJx3yIWvuJif7XCdGeGwOkORu97rfmPUuRWaHhdXmbwBK7oU4gWWlS1kJLQuyTaX02QHuNHrNdlL50DOUbsoefhMAYRS0hUjz0wlwf9kTCyOu/NvF0LhQTWSWKSu+IseDeV14xAYwV6iJHanbBnTnulVRxnaUFmrLHScpMT8V2FZciQI31C2jcew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42ThFpp0OJIWsL99ZQgdkO2klUZledaBlBjFPCCTh1w=;
 b=UgIazdFrx296VzL7MC34/rWmbZCc9RSHYBfL8LVLOMq6kpKABUkxmAK9YaZZz5SxFM06LioPwVd2q1xNsIsMX9s+bnSq21Xs3I8AFuAoIUVqFCyvA/yMz5MJXRwTvjfa0JUelcm/0hMF1RE930RHr40/t+y81ljfQ/JcbZnemkKdsQhJqrXkrz8pv5c/yu74P0r3GETNgVIo9zfMawPZ3oAvP33Rdo5EjjkZ6UXs9lEjJaAM+04MCO94DkEv69KOURBb1T3TAuToL0IJH4TTfbTjW1nEwiQ1bgHYVdJhCyBkkcv+PVUldumt9dD5RsiBzYoeW2f1DKOZFsDB72g3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42ThFpp0OJIWsL99ZQgdkO2klUZledaBlBjFPCCTh1w=;
 b=H3gQD2cM511edDs9qWp6fMQu5veSpgJuv3NqJpkDckeLIzsgnbXfvng7RmJ7eAclk07gHCMNCrjamjZBXy+PYGpIeD1IwRlWFloNAqwRZ63ZMd+KDE/NdHgRHWkAbZfNOsj/UHkygZijjqt5wvn6zo2ROIA/uzT7FWeRinBOPMo=
Received: from DM3PR12CA0082.namprd12.prod.outlook.com (2603:10b6:0:57::26) by
 BN8PR12MB2851.namprd12.prod.outlook.com (2603:10b6:408:9f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.14; Fri, 28 Jan 2022 05:29:24 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::f5) by DM3PR12CA0082.outlook.office365.com
 (2603:10b6:0:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Fri, 28 Jan 2022 05:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 05:29:24 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 23:29:18 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <dishaa.talreja@amd.com>, Wei Huang <wei.huang2@amd.com>,
        Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v0 3/3] sched/numa: Add adaptive scan period calculation
Date:   Fri, 28 Jan 2022 10:58:51 +0530
Message-ID: <20220128052851.17162-4-bharata@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bad8d73-c8d7-4ab6-89ad-08d9e21f2521
X-MS-TrafficTypeDiagnostic: BN8PR12MB2851:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2851D056F9ED0996A55F4C0CB0229@BN8PR12MB2851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKNlDeJy+8GngI2svatL/W7TMZnzpnn/3g1RuNsxOAuf+fGpjaY7xxwugioQV+UFs+uOwjnwBqmxdZmR/tDoCo9/0nTLr/atJg1jb5CIDTp9zzRa5mvbVsM4hkVzsxXrmPgsPFbKDROH6F614+/E1YlnFDz2l0Y3DIPltITamKeogZAOCQyqN5pQjYd43Nw4GS5wOnfopjScLHBDE6d+jy3X6HQ8jR8RbTBtfC2ltbT3dFmeWIO/zuUoEJ86J51Bl+2x7aEcF4yWZ5YvI09M3BziQFC/a4vkzuSd3mBTfqvvd2bwf2nJz8G9NzzY7GCtMFqCfvswvtAKoiLJoHB4iCU3nBGy5Rjai9gLcURfNkNTIjpHiyrE+YzT/RCGY1ubqeL2kf6UfzSlqawcL15tZqYvOaLHvZeN6a2+OLYkOgDe9VLI9etBDYuxPp9kbJBmxJj64HPTgjatcVtee4+tycqi4Iqy7Y9SLD1laYS7mg0hSMFkX+jlR7J6XIri0GUnMV20Qy740W1GM+40Qzw0sePvCMeJstfXTztr8PUO75+wG2QeJeTFMutiv8SiguudS7KwEqS7KqpmUyMEMHI4OyTBniFx/jnX+Lfx6KqeVezHE7pbrbDr+GA5m1XDqARvJAik2RESruy651P+iKxjtrk2YHbOsy65FuPdzQvmbQ7Bxp8znNQ7GcqLPDWzsSNu0gkYTENokrOaY/f3NkxPpM51zZJEf5NOl04lkJ6XKljpK0q+tAX64f/r8xhJcoqsPKAdbjVTbo7oE5z9ppj3x4t5wjA7Qf2BEpDUnyYJFek=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(7416002)(81166007)(54906003)(426003)(336012)(7696005)(6666004)(70586007)(86362001)(30864003)(498600001)(8936002)(36756003)(356005)(70206006)(186003)(47076005)(2906002)(5660300002)(83380400001)(26005)(82310400004)(36860700001)(16526019)(4326008)(2616005)(1076003)(40460700003)(8676002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 05:29:24.3355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bad8d73-c8d7-4ab6-89ad-08d9e21f2521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2851
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Disha Talreja <dishaa.talreja@amd.com>

This patch implements an adaptive algorithm for calculating
the autonuma scan period. In the existing mechanism of scan
period calculation,

- scan period is derived from the per-thread stats.
- static threshold (NUMA_PERIOD_THRESHOLD) is used for changing
  the scan rate.

In this new approach (Process Adaptive autoNUMA), we gather NUMA
fault stats at per-process level which allows for capturing the
application behaviour better. In addition, the algorithm learns
and adjusts the scan rate based on remote fault rate. By not
sticking to a static threshold, the algorithm can respond better
to different workload behaviours.

Since the threads of a processes are already considered as a group,
we add a bunch of metrics to the task's mm to track the various
types of faults and derive the scan rate from them.

The new per-process fault stats contribute only to the per-process
scan period calculation, while the existing per-thread stats
continue to contribute towards the numa_group stats which
eventually determine the thresholds for migrating memory and
threads across nodes.

In this algorithm, the remote fault rates are maintained for
the previous two scan windows. These historical remote fault
rates along with the remote fault rate from the current window
are used to determine the intended trend of the scanning period.

An increase in the trend implies an increased period thereby
resulting in slower scanning. A decrease in the trend implies
decreased period and hence faster scanning.

The intended trends for the last two windows are tracked and
the actual trend is reversed (thereby increasing or decreasing
the scan period in that window) only if the same trend reversal
has been intended in the previous two windows.

While the remote fault rate metric is derived from the accumulated
remote and local faults from all the threads of the mm, the
per-mm private and shared faults also contribute in deciding
the trend of the scan period.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Disha Talreja <dishaa.talreja@amd.com>
Signed-off-by: Bharata B Rao <bharata@amd.com>
---
 include/linux/mm_types.h |   5 +
 kernel/sched/debug.c     |   2 +
 kernel/sched/fair.c      | 265 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h     |   2 +
 4 files changed, 268 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2c6f119b947f..d57cd96d8df0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -619,6 +619,11 @@ struct mm_struct {
 
 		spinlock_t pan_numa_lock;
 		unsigned int numa_scan_period;
+		int remote_fault_rates[2]; /* histogram of remote fault rate */
+		long scanned_pages;
+		bool trend;
+		int slope;
+		u8 hist_trend;
 #endif
 		/*
 		 * An operation with batched TLB flushing is going on. Anything
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index aa29211de1bf..060bb46166a6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -334,6 +334,8 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
 	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
+	debugfs_create_u32("pan_scan_period_min", 0644, numa, &sysctl_pan_scan_period_min);
+	debugfs_create_u32("pan_scan_period_max", 0644, numa, &sysctl_pan_scan_period_max);
 #endif
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4911b3841d00..5a9cacfbf9ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1026,6 +1026,10 @@ unsigned int sysctl_numa_balancing_scan_size = 256;
 /* Scan @scan_size MB every @scan_period after an initial @scan_delay in ms */
 unsigned int sysctl_numa_balancing_scan_delay = 1000;
 
+/* Clips of max and min scanning periods */
+unsigned int sysctl_pan_scan_period_min = 50;
+unsigned int sysctl_pan_scan_period_max = 5000;
+
 struct numa_group {
 	refcount_t refcount;
 
@@ -2102,6 +2106,242 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
 /**********************************************/
 /*  Process-based Adaptive NUMA (PAN) Design  */
 /**********************************************/
+#define SLOPE(N, D) ((N)/(D))
+
+static unsigned int pan_scan_max(struct task_struct *p)
+{
+	unsigned long smax, nr_scan_pages;
+	unsigned long rss = 0;
+
+	smax = sysctl_pan_scan_period_max;
+	nr_scan_pages = sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT);
+
+	rss = get_mm_rss(p->mm);
+	if (!rss)
+		rss = nr_scan_pages;
+
+	if (READ_ONCE(p->mm->numa_scan_seq) == 0) {
+		smax = p->mm->scanned_pages * sysctl_pan_scan_period_max;
+		smax = smax / rss;
+		smax = max_t(unsigned long, sysctl_pan_scan_period_min, smax);
+	}
+
+	return smax;
+}
+
+/*
+ * Process-based Adaptive NUMA scan period update alogirthm
+ *
+ * These are the important concepts behind the scan period update:
+ *
+ * - increase trend (of scan period)
+ *   scan period => up, memory coverage => down, overhead => down,
+ *   accuracy => down
+ * - decrease trend
+ *   scan period => down, memory coverage => up, overhead => up,
+ *   accuracy => up
+ * - trend: Reflects the current active trend
+ *   1 means increasing trend, 0 means decreasing trend
+ * - slope
+ *   it controls scan_period: new_scan_period = current_scan_period *
+ *                                              100 / slope
+ * - hist_trend: Reflects the intended trend in the last two
+ *   windows. Uses the last two bits (bit0 and bit1) for the same.
+ *   1 if increasing trend was intended, 0 if decreasing was intended.
+ */
+
+/*
+ * Check if the scan period needs updation when the remote fault
+ * rate has changed (delta > 5)
+ *
+ * Returns TRUE if scan period needs updation, else FALSE.
+ */
+static bool pan_changed_rate_update(struct mm_struct *mm, int ps_ratio,
+				    int oldest_remote_fault_rate,
+				    int fault_rate_diff)
+{
+	u8 value;
+
+	/*
+	 * Set the intended trend for the current window.
+	 * - If the remote fault rate has decreased, set the
+	 *   intended trend to increasing.
+	 * - Otherwise leave the intended trend as decreasing.
+	 */
+	mm->hist_trend = mm->hist_trend << 1;
+	if (fault_rate_diff < 5)
+		mm->hist_trend |= 0x01;
+
+	value = mm->hist_trend & 0x03;
+
+	if (fault_rate_diff < -5 && value == 3) {
+		/*
+		 * The remote fault rate has decreased and the intended
+		 * trend was set to increasing in the previous window.
+		 *
+		 * If on decreasing trend, reverse the trend and change
+		 * the slope using the fault rates from (current-1)
+		 * and (current-2) windows.
+		 *
+		 * If already on increasing trend, change the slope using
+		 * the fault rates from (current) and (current-1) windows.
+		 */
+		if (!mm->trend) {
+			mm->trend = true;
+			mm->slope = SLOPE(mm->remote_fault_rates[0] * 100,
+					  oldest_remote_fault_rate);
+		} else {
+			mm->slope = SLOPE(mm->remote_fault_rates[1] * 100,
+					  mm->remote_fault_rates[0]);
+		}
+	} else if (fault_rate_diff > 5 && value == 0) {
+		/*
+		 * The remote fault rate has increased and the intended
+		 * trend was set to decreasing in the previous window.
+		 *
+		 * If on increasing trend,
+		 *  - If shared fault ratio is more than 30%, don't yet
+		 *  reverse the trend, just mark the intended trend as
+		 *  increasing.
+		 *  - Otherwise reverse the trend. Change the slope using
+		 *  the fault rates from (current-1) and (current-2) windows.
+		 *
+		 *  If on decreasing trend
+		 *  - Continue with a changed slope using the fault
+		 *  rates from (current) and (current-1) windows.
+		 */
+		if (mm->trend) {
+			if (ps_ratio < 7) {
+				mm->hist_trend |= 0x01;
+				return true;
+			}
+
+			mm->trend = false;
+			mm->slope = SLOPE(mm->remote_fault_rates[0] * 100,
+					  oldest_remote_fault_rate);
+		} else {
+			mm->slope = SLOPE(mm->remote_fault_rates[1] * 100,
+					  mm->remote_fault_rates[0]);
+		}
+	} else if (value == 1 || value == 2) {
+		/*
+		 * The intended trend is oscillating
+		 *
+		 * If on decreasing trend and the shared fault ratio
+		 * is more than 30%, reverse the trend and change the slope.
+		 *
+		 * If on increasing trend, continue as is.
+		 */
+		if (!mm->trend && ps_ratio < 7) {
+			mm->hist_trend |= 0x01;
+			mm->trend = true;
+			mm->slope = SLOPE(100 * 100,
+					  100 + ((7 - ps_ratio) * 10));
+		}
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Check if the scan period needs updation when the remote fault
+ * rate has remained more or less the same (delta <= 5)
+ *
+ * Returns TRUE if scan period needs updation, else FALSE.
+ */
+static bool pan_const_rate_update(struct mm_struct *mm, int ps_ratio,
+				  int oldest_remote_fault_rate)
+{
+	int diff1, diff2;
+
+	mm->hist_trend = mm->hist_trend << 1;
+
+	/*
+	 * If we are in the increasing trend, don't change anything
+	 * except the intended trend for this window that was reset
+	 * to decreasing by default.
+	 */
+	if (mm->trend)
+		return false;
+
+	/* We are in the decreasing trend, reverse under some condidtions. */
+	diff1 = oldest_remote_fault_rate - mm->remote_fault_rates[0];
+	diff2 = mm->remote_fault_rates[0] - mm->remote_fault_rates[1];
+
+	if (ps_ratio < 7) {
+		/*
+		 * More than 30% of the pages are shared, so no point in
+		 * further reducing the scan period. If increasing trend
+		 * was intended in the previous window also, then reverse
+		 * the trend to increasing. Else just record the increasing
+		 * intended trend for this window and return.
+		 */
+		mm->hist_trend |= 0x01;
+		if ((mm->hist_trend & 0x03) == 3) {
+			mm->trend = true;
+			mm->slope = SLOPE(100 * 100,
+					  (100 + ((7 - ps_ratio) * 10)));
+		} else
+			return false;
+	} else if (diff1 >= 0 && diff2 >= 0 && mm->numa_scan_seq > 1) {
+		/*
+		 * Remote fault rate has reduced successively in the last
+		 * two windows and address space has been scanned at least
+		 * once. If increasing trend was intended in the previous
+		 * window also, then reverse the trend to increasing. Else
+		 * just record the increasing trend for this window and return.
+		 */
+		mm->hist_trend |= 0x01;
+		if ((mm->hist_trend & 0x03) == 3) {
+			mm->trend = true;
+			mm->slope = SLOPE(100 * 100, 110);
+			mm->hist_trend |= 0x03;
+		} else
+			return false;
+	}
+	return true;
+}
+
+static void pan_calculate_scan_period(struct task_struct *p)
+{
+	int remote_fault_rate, oldest_remote_fault_rate, ps_ratio, i, diff;
+	struct mm_struct *mm = p->mm;
+	unsigned long remote_hist = mm->faults_locality_history[0];
+	unsigned long local_hist = mm->faults_locality_history[1];
+	unsigned long shared_hist = mm->faults_shared_history[0];
+	unsigned long priv_hist = mm->faults_shared_history[1];
+	bool need_update;
+
+	ps_ratio = (priv_hist * 10) / (priv_hist + shared_hist + 1);
+	remote_fault_rate = (remote_hist * 100) / (local_hist + remote_hist + 1);
+
+	/* Keep the remote fault ratio at least 1% */
+	remote_fault_rate = max(remote_fault_rate, 1);
+	for (i = 0; i < 2; i++)
+		if (mm->remote_fault_rates[i] == 0)
+			mm->remote_fault_rates[i] = 1;
+
+	/* Shift right in mm->remote_fault_rates[] to keep track of history */
+	oldest_remote_fault_rate = mm->remote_fault_rates[0];
+	mm->remote_fault_rates[0] = mm->remote_fault_rates[1];
+	mm->remote_fault_rates[1] = remote_fault_rate;
+	diff = remote_fault_rate - oldest_remote_fault_rate;
+
+	if (abs(diff) <= 5)
+		need_update = pan_const_rate_update(mm, ps_ratio,
+						    oldest_remote_fault_rate);
+	else
+		need_update = pan_changed_rate_update(mm, ps_ratio,
+						      oldest_remote_fault_rate,
+						      diff);
+
+	if (need_update) {
+		if (mm->slope == 0)
+			mm->slope = 100;
+		mm->numa_scan_period = (100 * mm->numa_scan_period) / mm->slope;
+	}
+}
+
 /*
  * Update the cumulative history of local/remote and private/shared
  * statistics. If the numbers are too small worthy of updating,
@@ -2145,14 +2385,17 @@ static bool pan_update_history(struct task_struct *p)
 
 /*
  * Updates mm->numa_scan_period under mm->pan_numa_lock.
- * Returns p->numa_scan_period now but updated to return
- * p->mm->numa_scan_period in a later patch.
  */
 static unsigned long pan_get_scan_period(struct task_struct *p)
 {
-	pan_update_history(p);
+	if (pan_update_history(p))
+		pan_calculate_scan_period(p);
+
+	p->mm->numa_scan_period = clamp(p->mm->numa_scan_period,
+					READ_ONCE(sysctl_pan_scan_period_min),
+					pan_scan_max(p));
 
-	return p->numa_scan_period;
+	return p->mm->numa_scan_period;
 }
 
 /*
@@ -2860,6 +3103,7 @@ static void task_numa_work(struct callback_head *work)
 		mm->numa_scan_offset = start;
 	else
 		reset_ptenuma_scan(p);
+	mm->scanned_pages += ((sysctl_numa_balancing_scan_size << (20 - PAGE_SHIFT)) - pages);
 	mmap_read_unlock(mm);
 
 	/*
@@ -2882,10 +3126,15 @@ static void pan_init_numa(struct task_struct *p)
 
 	spin_lock_init(&mm->pan_numa_lock);
 	mm->numa_scan_period = sysctl_numa_balancing_scan_delay;
+	mm->scanned_pages = 0;
+	mm->trend = false;
+	mm->hist_trend = 0;
+	mm->slope = 100;
 
 	for (i = 0; i < 2; i++) {
 		mm->faults_locality_history[i] = 0;
 		mm->faults_shared_history[i] = 0;
+		mm->remote_fault_rates[i] = 1;
 	}
 }
 
@@ -2948,6 +3197,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
+	if (!spin_trylock(&curr->mm->pan_numa_lock))
+		return;
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
@@ -2955,16 +3207,17 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	 * NUMA placement.
 	 */
 	now = curr->se.sum_exec_runtime;
-	period = (u64)curr->numa_scan_period * NSEC_PER_MSEC;
+	period = (u64)curr->mm->numa_scan_period * NSEC_PER_MSEC;
 
 	if (now > curr->node_stamp + period) {
 		if (!curr->node_stamp)
-			curr->numa_scan_period = task_scan_start(curr);
+			curr->mm->numa_scan_period = task_scan_start(curr);
 		curr->node_stamp += period;
 
 		if (!time_before(jiffies, curr->mm->numa_next_scan))
 			task_work_add(curr, work, TWA_RESUME);
 	}
+	spin_unlock(&curr->mm->pan_numa_lock);
 }
 
 static void update_scan_period(struct task_struct *p, int new_cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..635f96bc989d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2424,6 +2424,8 @@ extern unsigned int sysctl_numa_balancing_scan_delay;
 extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
+extern unsigned int sysctl_pan_scan_period_min;
+extern unsigned int sysctl_pan_scan_period_max;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
-- 
2.25.1

