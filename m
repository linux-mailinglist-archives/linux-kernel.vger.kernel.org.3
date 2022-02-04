Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ABF4A91B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 01:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356271AbiBDAlR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 19:41:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236660AbiBDAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 19:41:16 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 213NnqhP018720
        for <linux-kernel@vger.kernel.org>; Thu, 3 Feb 2022 16:41:16 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e05snf850-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 16:41:16 -0800
Received: from twshared9880.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 16:41:13 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 16922295C7F35; Thu,  3 Feb 2022 16:41:09 -0800 (PST)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH] perf: fix GPF in perf_cgroup_switch()
Date:   Thu, 3 Feb 2022 16:40:57 -0800
Message-ID: <20220204004057.2961252-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YT3ZI8ePkyEZ3NslsHI_OXBwq9sQAwQR
X-Proofpoint-GUID: YT3ZI8ePkyEZ3NslsHI_OXBwq9sQAwQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPF is observed in perf_cgroup_switch():

[ 2683.232477] general protection fault, probably for non-canonical address 0xdeacffffffffff90: 0000 [#1] SMP
[ 2683.251802] CPU: 30 PID: 0 Comm: swapper/30 Kdump: loaded Tainted: G S
[ 2683.273726] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP,
[ 2683.291129] RIP: 0010:perf_cgroup_switch+0xc0/0x170
[ 2683.300889] Code: 85 ff ff 48 8b 83 00 01 00 00 48 85 c0 74 04 c6 40 08 \
         00 c6 43 08 00 48 8b 83 70 01 00 00 48 8d 98 90 fe ff ff 48 39 c5 \
         74 7d <8b> 83 e4 00 00 00 85 c0 0f 84 89 00 00 00 4c 8b bb 00 01 00 00 48
[ 2683.338455] RSP: 0018:ffffc9000021fdb0 EFLAGS: 00010002
[ 2683.348904] RAX: dead000000000100 RBX: deacffffffffff90 RCX: 000000000000038f
[ 2683.363176] RDX: 0000000000000007 RSI: 0000000000000400 RDI: 0000000000000000
[ 2683.377447] RBP: ffff88903ffa77b0 R08: 0000000300000003 R09: 0000000000000004
[ 2683.391718] R10: 0000000000000003 R11: 0000000000000001 R12: 0000000000000002
[ 2683.405989] R13: 0000000000000000 R14: ffff8881013fdc00 R15: 0000000000000000
[ 2683.420261] FS:  0000000000000000(0000) GS:ffff88903ff80000(0000) knlGS:0000000000000000
[ 2683.436446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2683.447937] CR2: 00007ffafb956020 CR3: 0000000141cd7005 CR4: 00000000007706e0
[ 2683.462209] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2683.476481] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2683.490752] PKRU: 55555554
[ 2683.496160] Call Trace:
[ 2683.501048]  __perf_event_task_sched_in+0xb3/0x200
[ 2683.510632]  finish_task_switch+0x186/0x270
[ 2683.518999]  __schedule+0x3b1/0x850
[ 2683.525973]  ? cpuidle_enter_state+0xa7/0x340
[ 2683.534687]  ? update_ts_time_stats+0x51/0x70
[ 2683.543399]  schedule_idle+0x1e/0x40
[ 2683.550548]  do_idle+0x148/0x200
[ 2683.557001]  cpu_startup_entry+0x19/0x20
[ 2683.564843]  start_secondary+0x104/0x140
[ 2683.572688]  secondary_startup_64_no_verify+0xb0/0xbb

which indicates list corruption on cgrp_cpuctx_list. This happens on the
following path:

  perf_cgroup_switch: list_for_each_entry(cgrp_cpuctx_list)
      cpu_ctx_sched_in
         ctx_sched_in
            ctx_pinned_sched_in
              merge_sched_in
                  perf_cgroup_event_disable: remove the event from the list

To repro this on Intel CPUs:

  /* occupy all counters with pinned events (watchdog uses another) */
  perf stat -e cycles:D,cycles:D,cycles:D,cycles:D,cycles:D -a &
  /* add a pinned cgroup event */
  perf stat -e cycles:D -G my-cgroup
  /* GPF immediately */

Fix this with list_for_each_entry_safe().

Cc: Yonghong Song <yhs@fb.com>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index afbf388a5176..46babdf76d8f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -839,7 +839,7 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
  */
 static void perf_cgroup_switch(struct task_struct *task, int mode)
 {
-	struct perf_cpu_context *cpuctx;
+	struct perf_cpu_context *cpuctx, *tmp;
 	struct list_head *list;
 	unsigned long flags;
 
@@ -850,7 +850,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
 	local_irq_save(flags);
 
 	list = this_cpu_ptr(&cgrp_cpuctx_list);
-	list_for_each_entry(cpuctx, list, cgrp_cpuctx_entry) {
+	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
 		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
 
 		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
-- 
2.30.2

