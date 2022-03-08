Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C038F4D105E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiCHGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiCHGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:39:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6716839146
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:38:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdIh5dqmO7hVCx0iLxjAWp4oMHeXE9S0mXhY07agTwMv6yB2ExW8vwNTR5rld0iBxwalAYUqdnVj6PwmRgBKVD2bkbVBi7HBLf9mcOpJf3O0idxF9z7IWlu9eXNm6BeRU6jYS4u1plkYXXkgx/4Dr8ZROIK3gmNSC03oxYDQG1j/A9APs0Qvdq8+OWaynJn91+r6xPf/fEecbOzRNM3/RmKL4+1BQUMmoNRSouBA5B0QVSq919Jgl9srfJyD3wk8c0lxjhXCUrHOrpoABOQR0XlrtG25usu/fWFLyYeRc9gXLdpamda9i9i4LYqooue7Yo4OQpMl9gAbAKmgAJ1qwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8cc0dGx80OiMjc/3EQdVO17ptdQQaA71wChiLChBUU=;
 b=IdtJXYOQY+2DEBvO4xvR1Fq+/f+zv+/uEUmaOCxz2884vw5UlrN8i3Gr4G89QTsBB5OihDTtrcJ1VkLxGfb9mtnOmSkJOlMnjuHuQbwVDNWGLQR16wvtOA6MNT2x1sOr/GEsh3qZSrEdQxFJdmaFBLTArXLUWsCsYhpCaFktBgJuB3czPz0hOT8jSLzS+pUe4iJ6kphd9fEPL4fsknZoaq73/jVVNdIsot8GkOXwMD3enW6Z6YUhp4KNUJNqIbw/afad5hCJx/4V+kJyvP9r1M2mWyH8jSd92B90A/OJkiFt11iP6ZQP0zrSIaJy6n+s23y2+8AAG7fbRWWQ0FQpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8cc0dGx80OiMjc/3EQdVO17ptdQQaA71wChiLChBUU=;
 b=vEO1+RnZUMx4TnXeUaX99ni+2C1JsGmHz8YziAPTenG7Gtvr0dJenAsA+qxkEh9ub8UXnxIDMDc5XNU8Der5qyJMl7SMoDsr2M7mn8l9Qd/H8fiNDssrxSi0hL/rjN0+8uXAIh/GfMBaHibTbtdRWhQd8hiB6fRABTI+hqRuEtg=
Received: from DM5PR10CA0014.namprd10.prod.outlook.com (2603:10b6:4:2::24) by
 MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 8 Mar
 2022 06:38:08 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::ec) by DM5PR10CA0014.outlook.office365.com
 (2603:10b6:4:2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 06:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 06:38:07 +0000
Received: from BLR5CG134614W.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 00:38:02 -0600
From:   K Prateek Nayak <kprateek.nayak@amd.com>
To:     <peterz@infradead.org>
CC:     <aubrey.li@linux.intel.com>, <efault@gmx.de>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, <mingo@kernel.org>,
        <song.bao.hua@hisilicon.com>, <srikar@linux.vnet.ibm.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA imbalance in find_idlest_group
Date:   Tue, 8 Mar 2022 12:07:49 +0530
Message-ID: <20220308063749.6929-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae593872-1c0a-4361-61aa-08da00ce34fd
X-MS-TrafficTypeDiagnostic: MW4PR12MB5668:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56685DEA7EEA27AADBD1564098099@MW4PR12MB5668.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72DddjfkOGr2BHb3b8LLFBwizkpDwEGDxtUhbKXoodeknS9m65pS3uBTWHH7OpwWrbp9TZ/RyVKF4CwfSgBFT3M5lcldh5v9AhM8cSLwr0yOOWlXMBo3FhWE4rJXbLciYtSNf7bFxsk03N+WFZ/4hSl1gExMEWDJJcMSCvocnSpFsgjxQ0x9d+Hn2W02icQ2DX/1XF1gt18z2kfuhZHEbboOW4Bl2ev0BWFV0Xoyfa9CBRc0TalNlg0RJVmYz6A2grlodPmcXKJLgkkNJGv4ubt3L0BsFCl7p7mxKrDs4aBCeJKifUm1bxI3jcT40krqiDSmUCcnRtiZdwY7HApPDWKFld6CNdQo0keVtmhHcX+wWxK4yiw7MxT5wjPbHHQezG2mKLJGPFuLerv9TEpzadK+KylQcjo34ifUBWMmu5yq/A1mIfgQkQ5logWfOzaeTm4+/2rg0+kaS+N2iIMYmhVXesIKlPbDTM8eTkz39/Mh46tP53higbWTMRnrlD11xlTjJBN0+NG45BlralKPFkWt9gcX4CIVeGde3o7DqJR3avC2kDu+qJ+Y09Hik7O8GdvBFkt7rUYJyA6pRwFWv0y18cUTj2ENHYG4/o5CogDIlVlW6n75iaQfLsxAXyN7HmUvOsUGQYHMxNKngtRR/IYRZBE/ALGdIg7VWScQQF2OL0+NHRBwXdL4Cl0Smb2Sr6siAZ+HFLj4aCcPrXieLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(8936002)(40460700003)(36860700001)(356005)(81166007)(82310400004)(5660300002)(7416002)(70586007)(47076005)(16526019)(70206006)(83380400001)(8676002)(4326008)(86362001)(36756003)(26005)(316002)(186003)(6916009)(54906003)(1076003)(7696005)(6666004)(508600001)(426003)(2616005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:38:07.7536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae593872-1c0a-4361-61aa-08da00ce34fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of systems containing multiple LLCs per socket, like
AMD Zen systems, users want to spread bandwidth hungry applications
across multiple LLCs. Stream is one such representative workload where
the best performance is obtained by limiting one stream thread per LLC.
To ensure this, users are known to pin the tasks to a specify a subset
of the CPUs consisting of one CPU per LLC while running such bandwidth
hungry tasks.

Suppose we kickstart a multi-threaded task like stream with 8 threads
using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
server where each socket contains 128 CPUs
(0-63,128-191 in one socket, 64-127,192-255 in another socket)

Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8

Here each CPU in the list is from a different LLC and 4 of those LLCs
are on one socket, while the other 4 are on another socket.

Ideally we would prefer that each stream thread runs on a different
CPU from the allowed list of CPUs. However, the current heuristics in
find_idlest_group() do not allow this during the initial placement.

Suppose the first socket (0-63,128-191) is our local group from which
we are kickstarting the stream tasks. The first four stream threads
will be placed in this socket. When it comes to placing the 5th
thread, all the allowed CPUs are from the local group (0,16,32,48)
would have been taken.

However, the current scheduler code simply checks if the number of
tasks in the local group is fewer than the allowed numa-imbalance
threshold. This threshold was previously 25% of the NUMA domain span
(in this case threshold = 32) but after the v6 of Mel's patchset
"Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
in the NUMA domain, for processors with multiple LLCs.
(in this case threshold = 8).

For this example, the number of tasks will always be within threshold
and thus all the 8 stream threads will be woken up on the first socket
thereby resulting in sub-optimal performance.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in the current tip/sched/core on the Zen3 machine:

stream-5045    [032] d..2.   167.914699: sched_wakeup_new: comm=stream pid=5047 prio=120 target_cpu=048
stream-5045    [032] d..2.   167.914746: sched_wakeup_new: comm=stream pid=5048 prio=120 target_cpu=000
stream-5045    [032] d..2.   167.914846: sched_wakeup_new: comm=stream pid=5049 prio=120 target_cpu=016
stream-5045    [032] d..2.   167.914891: sched_wakeup_new: comm=stream pid=5050 prio=120 target_cpu=032
stream-5045    [032] d..2.   167.914928: sched_wakeup_new: comm=stream pid=5051 prio=120 target_cpu=032
stream-5045    [032] d..2.   167.914976: sched_wakeup_new: comm=stream pid=5052 prio=120 target_cpu=032
stream-5045    [032] d..2.   167.915011: sched_wakeup_new: comm=stream pid=5053 prio=120 target_cpu=032

Once the first four threads are distributed among the allowed CPUs of
socket one, the rest of the treads start piling on these same CPUs
when clearly there are CPUs on the second socket that can be used.

Following the initial pile up on a small number of CPUs, though the
load-balancer eventually kicks in, it takes a while to get to {4}{4}
and even {4}{4} isn't stable as we observe a bunch of ping ponging
between {4}{4} to {5}{3} and back before a stable state is reached
much later (1 Stream thread per allowed CPU) and no more migration is
required.

We can detect this piling and avoid it by checking if the number of
allowed CPUs in the local group are fewer than the number of tasks
running in the local group and use this information to spread the
5th task out into the next socket (after all, the goal in this
slowpath is to find the idlest group and the idlest CPU during the
initial placement!).

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks after adding this fix on the Zen3 machine:

stream-4733    [032] d..2.   116.017980: sched_wakeup_new: comm=stream pid=4735 prio=120 target_cpu=048
stream-4733    [032] d..2.   116.018032: sched_wakeup_new: comm=stream pid=4736 prio=120 target_cpu=000
stream-4733    [032] d..2.   116.018127: sched_wakeup_new: comm=stream pid=4737 prio=120 target_cpu=064
stream-4733    [032] d..2.   116.018185: sched_wakeup_new: comm=stream pid=4738 prio=120 target_cpu=112
stream-4733    [032] d..2.   116.018235: sched_wakeup_new: comm=stream pid=4739 prio=120 target_cpu=096
stream-4733    [032] d..2.   116.018289: sched_wakeup_new: comm=stream pid=4740 prio=120 target_cpu=016
stream-4733    [032] d..2.   116.018334: sched_wakeup_new: comm=stream pid=4741 prio=120 target_cpu=080

We see that threads are using all of the allowed CPUs and there is
no pileup.

No output is generated for tracepoint sched_migrate_task with this
patch due to a perfect initial placement which removes the need
for balancing later on - both across NUMA boundaries and within
NUMA boundaries for stream.

Following are the results from running 8 Stream threads with and
without pinning on a dual socket Zen3 Machine (2 x 64C/128T):

Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8

	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:    97699.28 (0.00 pct)     95933.60  (-1.80 pct)    156578.91 (60.26 pct)
Scale:   107754.15 (0.00 pct)     91869.88 (-14.74 pct)    149783.25 (39.00 pct)
  Add:   126383.29 (0.00 pct)    105730.86 (-16.34 pct)    186493.09 (47.56 pct)
Triad:   124896.78 (0.00 pct)    106394.38 (-14.81 pct)    184733.48 (47.90 pct)

Pinning currently hurts the performance compared to unbound case on
tip/sched/core. With the addition of this patch, we are able to
outperform tip/sched/core by a good margin with pinning.

Following are the results from running 16 Stream threads with and
without pinning on a dual socket Skylake Machine (2 x 24C/48T):

Pinning is done using: numactl -C 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ./stream16

	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:   126620.67 (0.00 pct)     141062.10 (11.40 pct)    147615.44 (16.58 pct)
Scale:   91313.51 (0.00 pct)      112879.61 (23.61 pct)    122591.28 (34.25 pct)
  Add:   102035.43 (0.00 pct)     125889.98 (23.37 pct)    138179.01 (35.42 pct)
Triad:   102281.91 (0.00 pct)     123743.48 (20.98 pct)    138940.41 (35.84 pct)

In case of Skylake machine, with single LLC per socket, we see good
improvement brought about by pinning which is further benefited by
this patch.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
Changelog v5-->v6:
 -  Move the cpumask variable declaration to the block it is
    used in.
 -  Collect tags from v5.
Changelog v4-->v5:
 -  Only perform cpumask operations if nr_cpus_allowed is not
    equal to num_online_cpus based on Mel's suggestion.
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 16874e112fe6..6cc90d76250f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9183,6 +9183,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_has_spare:
 		if (sd->flags & SD_NUMA) {
+			int imb;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9200,10 +9201,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
 			 * would remain below threshold where an imbalance is
-			 * allowed. If there is a real need of migration,
-			 * periodic load balance will take care of it.
+			 * allowed while accounting for the possibility the
+			 * task is pinned to a subset of CPUs. If there is a
+			 * real need of migration, periodic load balance will
+			 * take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
+			imb = sd->imb_numa_nr;
+			if (p->nr_cpus_allowed != num_online_cpus()) {
+				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+
+				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			}
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
 				return NULL;
 		}
 
-- 
2.25.1

