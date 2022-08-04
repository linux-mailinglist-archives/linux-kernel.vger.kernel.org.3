Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335E589613
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiHDCUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbiHDCU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:20:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C746050C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:19:03 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lyslf23Zjz1M8cY;
        Thu,  4 Aug 2022 10:15:58 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:19:01 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 10:19:00 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] ftrace: Fix NULL pointer dereference in is_ftrace_trampoline when ftrace is dead
Date:   Thu, 4 Aug 2022 10:16:10 +0800
Message-ID: <20220804021610.209791-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_startup does not remove ops from ftrace_ops_list when
ftrace_startup_enable fails:

register_ftrace_function
  ftrace_startup
    __register_ftrace_function
      ...
      add_ftrace_ops(&ftrace_ops_list, ops)
      ...
    ...
    ftrace_startup_enable // if ftrace failed to modify, ftrace_disabled is set to 1
    ...
  return 0 // ops is in the ftrace_ops_list.

When ftrace_disabled = 1, unregister_ftrace_function simply returns without doing anything:
unregister_ftrace_function
  ftrace_shutdown
    if (unlikely(ftrace_disabled))
            return -ENODEV;  // return here, __unregister_ftrace_function is not executed,
                             // as a result, ops is still in the ftrace_ops_list
    __unregister_ftrace_function
    ...

If ops is dynamically allocated, it will be free later, in this case,
is_ftrace_trampoline accesses NULL pointer:

is_ftrace_trampoline
  ftrace_ops_trampoline
    do_for_each_ftrace_op(op, ftrace_ops_list) // OOPS! op may be NULL!

Syzkaller reports as follows:
[ 1203.506103] BUG: kernel NULL pointer dereference, address: 000000000000010b
[ 1203.508039] #PF: supervisor read access in kernel mode
[ 1203.508798] #PF: error_code(0x0000) - not-present page
[ 1203.509558] PGD 800000011660b067 P4D 800000011660b067 PUD 130fb8067 PMD 0
[ 1203.510560] Oops: 0000 [#1] SMP KASAN PTI
[ 1203.511189] CPU: 6 PID: 29532 Comm: syz-executor.2 Tainted: G    B   W         5.10.0 #8
[ 1203.512324] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[ 1203.513895] RIP: 0010:is_ftrace_trampoline+0x26/0xb0
[ 1203.514644] Code: ff eb d3 90 41 55 41 54 49 89 fc 55 53 e8 f2 00 fd ff 48 8b 1d 3b 35 5d 03 e8 e6 00 fd ff 48 8d bb 90 00 00 00 e8 2a 81 26 00 <48> 8b ab 90 00 00 00 48 85 ed 74 1d e8 c9 00 fd ff 48 8d bb 98 00
[ 1203.518838] RSP: 0018:ffffc900012cf960 EFLAGS: 00010246
[ 1203.520092] RAX: 0000000000000000 RBX: 000000000000007b RCX: ffffffff8a331866
[ 1203.521469] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000000000000010b
[ 1203.522583] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8df18b07
[ 1203.523550] R10: fffffbfff1be3160 R11: 0000000000000001 R12: 0000000000478399
[ 1203.524596] R13: 0000000000000000 R14: ffff888145088000 R15: 0000000000000008
[ 1203.525634] FS:  00007f429f5f4700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
[ 1203.526801] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1203.527626] CR2: 000000000000010b CR3: 0000000170e1e001 CR4: 00000000003706e0
[ 1203.528611] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1203.529605] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Therefore, when ftrace_startup_enable fails, we need to rollback registration
process and remove ops from ftrace_ops_list.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 kernel/trace/ftrace.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 601ccf1b2f09..63bf7b67ab2e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2922,24 +2922,36 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
 	ops->flags |= FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_ADDING;
 
 	ret = ftrace_hash_ipmodify_enable(ops);
-	if (ret < 0) {
-		/* Rollback registration process */
-		__unregister_ftrace_function(ops);
-		ftrace_start_up--;
-		ops->flags &= ~FTRACE_OPS_FL_ENABLED;
-		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
-			ftrace_trampoline_free(ops);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_rollback_registration;
 
 	if (ftrace_hash_rec_enable(ops, 1))
 		command |= FTRACE_UPDATE_CALLS;
 
 	ftrace_startup_enable(command);
 
+	/*
+	 * If ftrace_startup_enable fails,
+	 * we need to rollback registration process.
+	 */
+	if (unlikely(ftrace_disabled)) {
+		ret = -ENODEV;
+		goto out_rollback_registration;
+	}
+
 	ops->flags &= ~FTRACE_OPS_FL_ADDING;
 
 	return 0;
+
+out_rollback_registration:
+	/* Rollback registration process */
+	__unregister_ftrace_function(ops);
+	ftrace_start_up--;
+	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
+	if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
+		ftrace_trampoline_free(ops);
+
+	return ret;
 }
 
 int ftrace_shutdown(struct ftrace_ops *ops, int command)
-- 
2.30.GIT

