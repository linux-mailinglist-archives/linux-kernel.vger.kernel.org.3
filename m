Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E071C50D6F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiDYC2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbiDYC2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:28:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABAB12772
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:25:02 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KmpkP4LRbzhYj7;
        Mon, 25 Apr 2022 10:24:45 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 10:25:00 +0800
Received: from DESKTOP-E0KHRBE.china.huawei.com (10.67.111.5) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 10:24:59 +0800
From:   Shaobo Huang <huangshaobo6@huawei.com>
To:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <young.liuyang@huawei.com>, <zengweilin@huawei.com>,
        <chenzefeng2@huawei.com>, <nixiaoming@huawei.com>,
        <wangbing6@huawei.com>, <huangshaobo6@huawei.com>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>
Subject: [PATCH v3] kfence: enable check kfence canary on panic via boot param
Date:   Mon, 25 Apr 2022 10:24:56 +0800
Message-ID: <20220425022456.44300-1-huangshaobo6@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20220424105949.50016-1-huangshaobo6@huawei.com>
References: <20220424105949.50016-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.111.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huangshaobo <huangshaobo6@huawei.com>

Out-of-bounds accesses that aren't caught by a guard page will result
in corruption of canary memory. In pathological cases, where an object
has certain alignment requirements, an out-of-bounds access might
never be caught by the guard page. Such corruptions, however, are only
detected on kfree() normally. If the bug causes the kernel to panic
before kfree(), KFENCE has no opportunity to report the issue. Such
corruptions may also indicate failing memory or other faults.

To provide some more information in such cases, add the option to
check canary bytes on panic. This might help narrow the search for the
panic cause; but, due to only having the allocation stack trace, such
reports are difficult to use to diagnose an issue alone. In most
cases, such reports are inactionable, and is therefore an opt-in
feature (disabled by default).

Suggested-by: chenzefeng <chenzefeng2@huawei.com>
Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
---
v3:
- use Marco's description replace the commit message
- keep these includes sorted alphabetically
- "in panic" replaced with "on panic" in title and comments
- Blank line between /* === ... */ and function.
v2:
- it is only detected in panic.
- it is disabled by default.
- can only be enabled via boot parameter.
- the code is moved to the specified partition.
  https://lore.kernel.org/all/20220424105949.50016-1-huangshaobo6@huawei.com/
v1:
  https://lore.kernel.org/all/20220420104927.59056-1-huangshaobo6@huawei.com/
Thanks again Marco for the suggestion.
---
 mm/kfence/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 9b2b5f56f4ae..06232d51e021 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -21,6 +21,8 @@
 #include <linux/log2.h>
 #include <linux/memblock.h>
 #include <linux/moduleparam.h>
+#include <linux/notifier.h>
+#include <linux/panic_notifier.h>
 #include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/clock.h>
@@ -99,6 +101,10 @@ module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644)
 static bool kfence_deferrable __read_mostly = IS_ENABLED(CONFIG_KFENCE_DEFERRABLE);
 module_param_named(deferrable, kfence_deferrable, bool, 0444);
 
+/* If true, check all canary bytes on panic. */
+static bool kfence_check_on_panic;
+module_param_named(check_on_panic, kfence_check_on_panic, bool, 0444);
+
 /* The pool of pages used for guard pages and objects. */
 char *__kfence_pool __read_mostly;
 EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
@@ -727,6 +733,31 @@ static int __init kfence_debugfs_init(void)
 
 late_initcall(kfence_debugfs_init);
 
+/* === Panic Notifier ====================================================== */
+
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
 /* === Allocation Gate Timer ================================================ */
 
 static struct delayed_work kfence_timer;
@@ -804,6 +835,9 @@ static void kfence_init_enable(void)
 	else
 		INIT_DELAYED_WORK(&kfence_timer, toggle_allocation_gate);
 
+	if (kfence_check_on_panic)
+		atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
+
 	WRITE_ONCE(kfence_enabled, true);
 	queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
 
-- 
2.12.3

