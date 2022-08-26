Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B825A214E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiHZHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbiHZHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:00:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB773311
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:00:05 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDVwB6HWMzYcqW;
        Fri, 26 Aug 2022 14:55:38 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:59:58 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 14:59:57 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 1/3] mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
Date:   Fri, 26 Aug 2022 15:34:30 +0800
Message-ID: <20220826073432.4168976-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826073432.4168976-1-liushixin2@huawei.com>
References: <20220826073432.4168976-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

zswap_init_started indicates that the initialization is started. And
zswap_init_failed indicates that the initialization is failed. As we will
support to init zswap after system startup, it's necessary to add a state
to indicate the initialization is complete and succeed to avoid
concurrency issues. Since we don't care about the difference between
init started with init completion. We only need three states:
uninitialized, initial failed, initial succeed.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..84e38300f571 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -214,11 +214,12 @@ static DEFINE_SPINLOCK(zswap_pools_lock);
 /* pool counter to provide unique names to zpool */
 static atomic_t zswap_pools_count = ATOMIC_INIT(0);
 
-/* used by param callback function */
-static bool zswap_init_started;
+#define ZSWAP_UNINIT		0
+#define ZSWAP_INIT_SUCCEED	1
+#define ZSWAP_INIT_FAILED	2
 
-/* fatal error during init */
-static bool zswap_init_failed;
+/* init state */
+static int zswap_init_state;
 
 /* init completed, but couldn't create the initial pool */
 static bool zswap_has_pool;
@@ -772,7 +773,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	char *s = strstrip((char *)val);
 	int ret;
 
-	if (zswap_init_failed) {
+	if (zswap_init_state == ZSWAP_INIT_FAILED) {
 		pr_err("can't set param, initialization failed\n");
 		return -ENODEV;
 	}
@@ -784,7 +785,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	/* if this is load-time (pre-init) param setting,
 	 * don't create a pool; that's done during init.
 	 */
-	if (!zswap_init_started)
+	if (zswap_init_state == ZSWAP_UNINIT)
 		return param_set_charp(s, kp);
 
 	if (!type) {
@@ -875,11 +876,11 @@ static int zswap_zpool_param_set(const char *val,
 static int zswap_enabled_param_set(const char *val,
 				   const struct kernel_param *kp)
 {
-	if (zswap_init_failed) {
+	if (zswap_init_state == ZSWAP_INIT_FAILED) {
 		pr_err("can't enable, initialization failed\n");
 		return -ENODEV;
 	}
-	if (!zswap_has_pool && zswap_init_started) {
+	if (!zswap_has_pool && zswap_init_state == ZSWAP_INIT_SUCCEED) {
 		pr_err("can't enable, no pool configured\n");
 		return -ENODEV;
 	}
@@ -1476,8 +1477,6 @@ static int __init init_zswap(void)
 	struct zswap_pool *pool;
 	int ret;
 
-	zswap_init_started = true;
-
 	if (zswap_entry_cache_create()) {
 		pr_err("entry cache creation failed\n");
 		goto cache_fail;
@@ -1517,6 +1516,7 @@ static int __init init_zswap(void)
 		goto destroy_wq;
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
+	zswap_init_state = ZSWAP_INIT_SUCCEED;
 	return 0;
 
 destroy_wq:
@@ -1530,7 +1530,7 @@ static int __init init_zswap(void)
 	zswap_entry_cache_destroy();
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */
-	zswap_init_failed = true;
+	zswap_init_state = ZSWAP_INIT_FAILED;
 	zswap_enabled = false;
 	return -ENOMEM;
 }
-- 
2.25.1

