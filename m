Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E419946B126
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhLGDDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:03:00 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29094 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLGDDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:03:00 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4J7Q1N1l1sz1DK17;
        Tue,  7 Dec 2021 10:56:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:59:28 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:59:28 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] lib/list_debug.c: print more list debugging context in __list_del_entry_valid()
Date:   Tue, 7 Dec 2021 10:58:35 +0800
Message-ID: <20211207025835.1909-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the entry->prev and entry->next are considered to be valid as
long as they are not LIST_POISON{1|2}. However, the memory may be
corrupted. The prev->next is invalid probably because 'prev' is invalid,
not because prev->next's content is illegal.

Unfortunately, the printk and its subfunctions will modify the registers
that hold the 'prev' and 'next', and we don't see this valuable
information in the BUG context.

So print the contents of 'entry->prev' and 'entry->next'.

Here's an example:
list_del corruption. prev->next should be c0ecbf74, but was c08410dc
kernel BUG at lib/list_debug.c:53!
... ...
PC is at __list_del_entry_valid+0x58/0x98
LR is at __list_del_entry_valid+0x58/0x98
psr: 60000093
sp : c0ecbf30  ip : 00000000  fp : 00000001
r10: c08410d0  r9 : 00000001  r8 : c0825e0c
r7 : 20000013  r6 : c08410d0  r5 : c0ecbf74  r4 : c0ecbf74
r3 : c0825d08  r2 : 00000000  r1 : df7ce6f4  r0 : 00000044
... ...
Stack: (0xc0ecbf30 to 0xc0ecc000)
bf20:                                     c0ecbf74 c0164fd0 c0ecbf70 c0165170
bf40: c0eca000 c0840c00 c0840c00 c0824500 c0825e0c c0189bbc c088f404 60000013
bf60: 60000013 c0e85100 000004ec 00000000 c0ebcdc0 c0ecbf74 c0ecbf74 c0825d08
bf80: c0e807c0 c018965c 00000000 c013f2a0 c0e807c0 c013f154 00000000 00000000
bfa0: 00000000 00000000 00000000 c01001b0 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
(__list_del_entry_valid) from (__list_del_entry+0xc/0x20)
(__list_del_entry) from (finish_swait+0x60/0x7c)
(finish_swait) from (rcu_gp_kthread+0x560/0xa20)
(rcu_gp_kthread) from (kthread+0x14c/0x15c)
(kthread) from (ret_from_fork+0x14/0x24)

At first, I thought prev->next was overwritten. Later, I carefully
analyzed the RCU code and the disassembly code. The error occurred when
deleting a node from the list rcu_state.gp_wq. The System.map shows that
the address of rcu_state is c0840c00. Then I use gdb to obtain the offset
of rcu_state.gp_wq.task_list.

(gdb) p &((struct rcu_state *)0)->gp_wq.task_list
$1 = (struct list_head *) 0x4dc

Again:
list_del corruption. prev->next should be c0ecbf74, but was c08410dc

c08410dc = c0840c00 + 0x4dc = &rcu_state.gp_wq.task_list

Because rcu_state.gp_wq has at most one node, so I can guess that
"prev = &rcu_state.gp_wq.task_list". But for other scenes, maybe I wasn't
so lucky, I cannot figure out the value of 'prev'.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/list_debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/list_debug.c b/lib/list_debug.c
index 5d5424b51b746fe..9daa3fb9d1cd615 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -49,11 +49,11 @@ bool __list_del_entry_valid(struct list_head *entry)
 			"list_del corruption, %px->prev is LIST_POISON2 (%px)\n",
 			entry, LIST_POISON2) ||
 	    CHECK_DATA_CORRUPTION(prev->next != entry,
-			"list_del corruption. prev->next should be %px, but was %px\n",
-			entry, prev->next) ||
+			"list_del corruption. prev->next should be %px, but was %px. (prev=%px)\n",
+			entry, prev->next, prev) ||
 	    CHECK_DATA_CORRUPTION(next->prev != entry,
-			"list_del corruption. next->prev should be %px, but was %px\n",
-			entry, next->prev))
+			"list_del corruption. next->prev should be %px, but was %px. (next=%px)\n",
+			entry, next->prev, next))
 		return false;
 
 	return true;
-- 
2.25.1

