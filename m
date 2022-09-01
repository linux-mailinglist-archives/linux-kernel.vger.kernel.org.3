Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D8D5A8B17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiIABzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiIABzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:55:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BCC2CC91
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:55:34 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJ3x45FKfzHnZx;
        Thu,  1 Sep 2022 09:53:44 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 09:55:32 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 09:55:32 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        wangkefeng 00584194 <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/kmemleak: make create_object return void
Date:   Thu, 1 Sep 2022 10:30:07 +0800
Message-ID: <20220901023007.3471887-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No user cares about the return value of create_object,
so make it return void.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/kmemleak.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eddc0132f7f..37af2dc8dac9 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -604,9 +604,8 @@ static int __save_stack_trace(unsigned long *trace)
  * memory block and add it to the object_list and object_tree_root (or
  * object_phys_tree_root).
  */
-static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp,
-					     bool is_phys)
+static void __create_object(unsigned long ptr, size_t size,
+			    int min_count, gfp_t gfp, bool is_phys)
 {
 	unsigned long flags;
 	struct kmemleak_object *object, *parent;
@@ -618,7 +617,7 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
-		return NULL;
+		return;
 	}
 
 	INIT_LIST_HEAD(&object->object_list);
@@ -687,7 +686,6 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 			 */
 			dump_object_info(parent);
 			kmem_cache_free(object_cache, object);
-			object = NULL;
 			goto out;
 		}
 	}
@@ -698,21 +696,20 @@ static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
-	return object;
 }
 
 /* Create kmemleak object which allocated with virtual address. */
-static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+static void create_object(unsigned long ptr, size_t size,
+			  int min_count, gfp_t gfp)
 {
-	return __create_object(ptr, size, min_count, gfp, false);
+	__create_object(ptr, size, min_count, gfp, false);
 }
 
 /* Create kmemleak object which allocated with physical address. */
-static struct kmemleak_object *create_object_phys(unsigned long ptr, size_t size,
-					     int min_count, gfp_t gfp)
+static void create_object_phys(unsigned long ptr, size_t size,
+			       int min_count, gfp_t gfp)
 {
-	return __create_object(ptr, size, min_count, gfp, true);
+	__create_object(ptr, size, min_count, gfp, true);
 }
 
 /*
-- 
2.25.1

