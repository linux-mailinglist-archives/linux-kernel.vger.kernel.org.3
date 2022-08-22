Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA259BEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiHVLiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiHVLiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:38:18 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E72608
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:38:16 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1oQ5jW-00Gyo9-Jf;
        Mon, 22 Aug 2022 13:38:05 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 2/4] Enable balloon drivers to report inflated memory
Date:   Mon, 22 Aug 2022 14:37:45 +0300
Message-Id: <20220822113747.3630776-3-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822113747.3630776-1-alexander.atanasov@virtuozzo.com>
References: <20220822113747.3630776-1-alexander.atanasov@virtuozzo.com>
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
 include/linux/balloon.h | 18 ++++++++++++++++++
 mm/balloon.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/include/linux/balloon.h b/include/linux/balloon.h
index 46ac8f61f607..59657da77d95 100644
--- a/include/linux/balloon.h
+++ b/include/linux/balloon.h
@@ -57,6 +57,24 @@ struct balloon_dev_info {
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
+int register_balloon_notifier(struct notifier_block *nb);
+void unregister_balloon_notifier(struct notifier_block *nb);
+
+#define balloon_notifier(fn, pri) ({						\
+	static struct notifier_block fn##_mem_nb __meminitdata =\
+		{ .notifier_call = fn, .priority = pri };			\
+	register_balloon_notifier(&fn##_mem_nb);				\
+})
+
 struct page *balloon_page_alloc(void);
 void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct page *page);
diff --git a/mm/balloon.c b/mm/balloon.c
index 22b3e876bc78..8e1d5855fef8 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -7,8 +7,44 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/notifier.h>
 #include <linux/balloon.h>
 
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
+EXPORT_SYMBOL(balloon_set_inflated_total);
+
+void balloon_set_inflated_free(long inflated_kb)
+{
+	atomic_long_set(&mem_balloon_inflated_free_kb, inflated_kb);
+	balloon_notify(BALLOON_CHANGED_FREE);
+}
+EXPORT_SYMBOL(balloon_set_inflated_free);
+
 static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
 				     struct page *page)
 {
-- 
2.31.1

