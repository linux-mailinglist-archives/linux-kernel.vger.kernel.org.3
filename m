Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92511508659
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377820AbiDTKxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377248AbiDTKxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:53:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AF426120
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:50:33 -0700 (PDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kjy7N1D3NzFq0Q;
        Wed, 20 Apr 2022 18:48:00 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 18:50:30 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 18:50:30 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <young.liuyang@huawei.com>, <zengweilin@huawei.com>,
        <chenzefeng2@huawei.com>, <nixiaoming@huawei.com>,
        <wangbing6@huawei.com>, <huangshaobo6@huawei.com>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>
Subject: [PATCH] kfence: check kfence canary in panic and reboot
Date:   Wed, 20 Apr 2022 18:49:27 +0800
Message-ID: <20220420104927.59056-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.111.5]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huangshaobo <huangshaobo6@huawei.com>

when writing out of bounds to the red zone, it can only be detected at
kfree. However, there were many scenarios before kfree that caused this
out-of-bounds write to not be detected. Therefore, it is necessary to
provide a method for actively detecting out-of-bounds writing to the red
zone, so that users can actively detect, and can be detected in the
system reboot or panic.

for example, if the application memory is out of bounds and written to
the red zone in the kfence object, the system suddenly panics, and the
following log can be seen during system reset:
BUG: KFENCE: memory corruption in atomic_notifier_call_chain+0x49/0x70

Corrupted memory at 0x(____ptrval____) [ ! ] (in kfence-#59):
 atomic_notifier_call_chain+0x49/0x70
 panic+0x134/0x278
 sysrq_handle_crash+0x11/0x20
 __handle_sysrq+0x99/0x160
 write_sysrq_trigger+0x26/0x30
 proc_reg_write+0x51/0x70
 vfs_write+0xb6/0x290
 ksys_write+0x9c/0xd0
 __do_fast_syscall_32+0x67/0xe0
 do_fast_syscall_32+0x2f/0x70
 entry_SYSCALL_compat_after_hwframe+0x45/0x4d

kfence-#59: 0x(____ptrval____)-0x(____ptrval____),size=100,cache=kmalloc-128
 allocated by task 77 on cpu 0 at 28.018073s:
 0xffffffffc007703d
 do_one_initcall+0x3c/0x1e0
 do_init_module+0x46/0x1d8
 load_module+0x2397/0x2860
 __do_sys_init_module+0x160/0x190
 __do_fast_syscall_32+0x67/0xe0
 do_fast_syscall_32+0x2f/0x70
 entry_SYSCALL_compat_after_hwframe+0x45/0x4d

Suggested-by: chenzefeng <chenzefeng2@huawei.com>
Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
---
 mm/kfence/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 9b2b5f56f4ae..85cc3ca4b71c 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -29,6 +29,9 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/panic_notifier.h>
 
 #include <asm/kfence.h>
 
@@ -716,6 +719,29 @@ static const struct file_operations objects_fops = {
 	.release = seq_release,
 };
 
+static void kfence_check_all_canary(void)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
+		struct kfence_metadata *meta = &kfence_metadata[i];
+
+		if (meta->state == KFENCE_OBJECT_ALLOCATED)
+			for_each_canary(meta, check_canary_byte);
+	}
+}
+
+static int kfence_check_canary_callback(struct notifier_block *nb,
+					unsigned long reason, void *arg)
+{
+	kfence_check_all_canary();
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kfence_check_canary_notifier = {
+	.notifier_call = kfence_check_canary_callback,
+};
+
 static int __init kfence_debugfs_init(void)
 {
 	struct dentry *kfence_dir = debugfs_create_dir("kfence", NULL);
@@ -806,6 +832,8 @@ static void kfence_init_enable(void)
 
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
+	register_reboot_notifier(&kfence_check_canary_notifier);
+	atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
 
 	pr_info("initialized - using %lu bytes for %d objects at 0x%p-0x%p\n", KFENCE_POOL_SIZE,
 		CONFIG_KFENCE_NUM_OBJECTS, (void *)__kfence_pool,
-- 
2.12.3

