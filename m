Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A055958C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiHPKpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiHPKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:44:53 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216E4330B
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:54:43 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oNt3o-00FxfB-BO;
        Tue, 16 Aug 2022 11:41:43 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/4] Enable balloon drivers to report inflated memory
Date:   Tue, 16 Aug 2022 12:41:15 +0300
Message-Id: <20220816094117.3144881-3-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add counters to be updated by the balloon drivers.
Create balloon notifier to propagate changes.

Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
---
 include/linux/balloon_common.h | 18 ++++++++++++++++++
 mm/balloon_common.c            | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/balloon_common.h b/include/linux/balloon_common.h
index a45e9fd76235..e707f57f58da 100644
--- a/include/linux/balloon_common.h
+++ b/include/linux/balloon_common.h
@@ -59,6 +59,24 @@ struct balloon_dev_info {
 			struct page *page, enum migrate_mode mode);
 };
 
+extern atomic_long_t mem_balloon_inflated_total_kb;
+extern atomic_long_t mem_balloon_inflated_free_kb;
+
+void balloon_set_inflated_total(long inflated_kb);
+void balloon_set_inflated_free(long inflated_kb);
+
+#define BALLOON_CHANGED_TOTAL 0
+#define BALLOON_CHANGED_FREE  1
+
+extern int register_balloon_notifier(struct notifier_block *nb);
+extern void unregister_balloon_notifier(struct notifier_block *nb);
+
+#define balloon_notifier(fn, pri) ({						\
+	static struct notifier_block fn##_mem_nb __meminitdata =\
+		{ .notifier_call = fn, .priority = pri };			\
+	register_balloon_notifier(&fn##_mem_nb);				\
+})
+
 extern struct page *balloon_page_alloc(void);
 extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct page *page);
diff --git a/mm/balloon_common.c b/mm/balloon_common.c
index 54ed98653c78..abeee6882649 100644
--- a/mm/balloon_common.c
+++ b/mm/balloon_common.c
@@ -9,8 +9,42 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/notifier.h>
 #include <linux/balloon_common.h>
 
+atomic_long_t mem_balloon_inflated_total_kb = ATOMIC_LONG_INIT(0);
+atomic_long_t mem_balloon_inflated_free_kb = ATOMIC_LONG_INIT(0);
+SRCU_NOTIFIER_HEAD_STATIC(balloon_chain);
+
+int register_balloon_notifier(struct notifier_block *nb)
+{
+	return srcu_notifier_chain_register(&balloon_chain, nb);
+}
+EXPORT_SYMBOL(register_balloon_notifier);
+
+void unregister_balloon_notifier(struct notifier_block *nb)
+{
+	srcu_notifier_chain_unregister(&balloon_chain, nb);
+}
+EXPORT_SYMBOL(unregister_balloon_notifier);
+
+static int balloon_notify(unsigned long val)
+{
+	return srcu_notifier_call_chain(&balloon_chain, val, NULL);
+}
+
+void balloon_set_inflated_total(long inflated_kb)
+{
+	atomic_long_set(&mem_balloon_inflated_total_kb, inflated_kb);
+	balloon_notify(BALLOON_CHANGED_TOTAL);
+}
+
+void balloon_set_inflated_free(long inflated_kb)
+{
+	atomic_long_set(&mem_balloon_inflated_free_kb, inflated_kb);
+	balloon_notify(BALLOON_CHANGED_FREE);
+}
+
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
 {
-- 
2.31.1

