Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9F5AA71B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiIBE5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiIBE52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:57:28 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5EFB028C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 21:57:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VO4p.oH_1662094633;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VO4p.oH_1662094633)
          by smtp.aliyun-inc.com;
          Fri, 02 Sep 2022 12:57:23 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: fix pcluster use-after-free on UP platforms
Date:   Fri,  2 Sep 2022 12:57:10 +0800
Message-Id: <20220902045710.109530-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During stress testing with CONFIG_SMP disabled, KASAN reports as below:

==================================================================
BUG: KASAN: use-after-free in __mutex_lock+0xe5/0xc30
Read of size 8 at addr ffff8881094223f8 by task stress/7789
[ 3482.258885]
CPU: 0 PID: 7789 Comm: stress Not tainted 6.0.0-rc1-00002-g0d53d2e882f9 #3
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
Call Trace:
 <TASK>
..
 __mutex_lock+0xe5/0xc30
..
 z_erofs_do_read_page+0x8ce/0x1560
..
 z_erofs_readahead+0x31c/0x580
..
Freed by task 7787
 kasan_save_stack+0x1e/0x40
 kasan_set_track+0x20/0x30
 kasan_set_free_info+0x20/0x40
 __kasan_slab_free+0x10c/0x190
 kmem_cache_free+0xed/0x380
 rcu_core+0x3d5/0xc90
 __do_softirq+0x12d/0x389
[ 3482.295630]
Last potentially related work creation:
 kasan_save_stack+0x1e/0x40
 __kasan_record_aux_stack+0x97/0xb0
 call_rcu+0x3d/0x3f0
 erofs_shrink_workstation+0x11f/0x210
 erofs_shrink_scan+0xdc/0x170
 shrink_slab.constprop.0+0x296/0x530
 drop_slab+0x1c/0x70
 drop_caches_sysctl_handler+0x70/0x80
 proc_sys_call_handler+0x20a/0x2f0
 vfs_write+0x555/0x6c0
 ksys_write+0xbe/0x160
 do_syscall_64+0x3b/0x90

The root cause is that erofs_workgroup_unfreeze() doesn't reset
to orig_val thus it causes a race that the pcluster reuses unexpectedly
before freeing.

Since UP platforms are quite rare now, such path becomes unnecessary.
Let's drop such specific-designed path directly instead.

Fixes: 73f5c66df3e2 ("staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..a01cc82795a2 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -195,7 +195,6 @@ struct erofs_workgroup {
 	atomic_t refcount;
 };
 
-#if defined(CONFIG_SMP)
 static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
 						 int val)
 {
@@ -224,34 +223,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 	return atomic_cond_read_relaxed(&grp->refcount,
 					VAL != EROFS_LOCKED_MAGIC);
 }
-#else
-static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
-						 int val)
-{
-	preempt_disable();
-	/* no need to spin on UP platforms, let's just disable preemption. */
-	if (val != atomic_read(&grp->refcount)) {
-		preempt_enable();
-		return false;
-	}
-	return true;
-}
-
-static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
-					    int orig_val)
-{
-	preempt_enable();
-}
-
-static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
-{
-	int v = atomic_read(&grp->refcount);
-
-	/* workgroup is never freezed on uniprocessor systems */
-	DBG_BUGON(v == EROFS_LOCKED_MAGIC);
-	return v;
-}
-#endif	/* !CONFIG_SMP */
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* we strictly follow PAGE_SIZE and no buffer head yet */
-- 
2.24.4

