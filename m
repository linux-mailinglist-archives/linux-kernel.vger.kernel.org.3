Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CDD4D9A69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiCOLce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347342AbiCOLcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:32:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383954DF57
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:31:15 -0700 (PDT)
X-UUID: 5540667e3a5a4bf3a40b41640f294bf4-20220315
X-UUID: 5540667e3a5a4bf3a40b41640f294bf4-20220315
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <cheng-jui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 741151367; Tue, 15 Mar 2022 19:26:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Mar 2022 19:25:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 19:25:52 +0800
From:   Cheng Jui Wang <cheng-jui.wang@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        <wsd_upstream@mediatek.com>,
        Eason-YH Lin <eason-yh.lin@mediatek.com>,
        Kobe-CP Wu <kobe-cp.wu@mediatek.com>,
        "Jeff-cc Hsu" <jeff-cc.hsu@mediatek.com>,
        Cheng Jui Wang <cheng-jui.wang@mediatek.com>
Subject: [PATCH] lockdep: Zap lock classes with debug_locks == false again
Date:   Tue, 15 Mar 2022 19:25:21 +0800
Message-ID: <20220315112521.29093-1-cheng-jui.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a lock_class_key has been registered but lockdep_unregister_key() is
called with debug_locks == false. The lockdep_unregister_key() will not
unregister the key and just return without error.
Users may assume lockdep_unregister_key() always succeed and free the
lock_class_key even if it is still remained in lockdep structures.

Which lead to following crash when 'cat /proc/lockdep' after
debug_locks == false:

==================================================================
BUG: KASAN: invalid-access in string+0x50/0x10c
Read at addr f2ffff81ac61c880 by ...
Pointer tag: [f2], memory tag: [fb]
...
Call trace:
 dump_backtrace.cfi_jt+0x0/0x8
 show_stack+0x1c/0x2c
 dump_stack_lvl+0xd8/0x16c
 print_address_description+0x90/0x2e8
 __kasan_report+0x144/0x224
 kasan_report+0x50/0xa0
 __do_kernel_fault+0xf4/0x2a8
 do_bad_area+0x34/0xf8
 do_tag_check_fault+0x24/0x38
 do_mem_abort+0x68/0x168
 el1_abort+0x4c/0x74
 el1_sync_handler+0x4c/0x8c
 el1_sync+0x8c/0x140
 string+0x50/0x10c
 vsnprintf+0x468/0x69c
 seq_printf+0x8c/0xd8
 print_name+0x64/0xf4
 l_show+0x1a8/0x278
 seq_read_iter+0x3cc/0x5fc
 proc_reg_read_iter+0xdc/0x1d4
 vfs_read+0x2e0/0x354
 ksys_read+0x7c/0xec
 __arm64_sys_read+0x20/0x30
 el0_svc_common.llvm.8008154191216078041+0xd8/0x20c
 do_el0_svc+0x28/0xa0
 el0_svc+0x24/0x38
 el0_sync_handler+0x88/0xec
 el0_sync+0x1b4/0x1c0

...
==================================================================

Allow lockdep_unregister_key to zap lock classes with
debug_locks == false again.
Remove the WARN_ON_ONCE(!found) and only zap lock classes when the key
can be found.

Fixes: 8b39adbee805 ("locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' again")
Signed-off-by: Cheng Jui Wang <cheng-jui.wang@mediatek.com>
---
 kernel/locking/lockdep.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f8a0212189ca..90dadecb2577 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6305,8 +6305,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	lockdep_lock();
 
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
@@ -6316,11 +6315,11 @@ void lockdep_unregister_key(struct lock_class_key *key)
 			break;
 		}
 	}
-	WARN_ON_ONCE(!found);
-	__lockdep_free_key_range(pf, key, 1);
-	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	if (found) {
+		__lockdep_free_key_range(pf, key, 1);
+		call_rcu_zapped(pf);
+	}
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
2.18.0

