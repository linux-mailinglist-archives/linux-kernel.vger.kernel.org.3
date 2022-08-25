Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006735A12A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbiHYNqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiHYNqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:46:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262932CC86
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:46:00 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MD4024WzdzkWcm;
        Thu, 25 Aug 2022 21:42:26 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 21:45:58 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 25 Aug
 2022 21:45:57 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next 2/3] mm/zswap: delay the initializaton of zswap until the first enablement
Date:   Thu, 25 Aug 2022 22:20:36 +0800
Message-ID: <20220825142037.3214152-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825142037.3214152-1-liushixin2@huawei.com>
References: <20220825142037.3214152-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

In the initialization of zswap, about 18MB memory will be allocated for
zswap_pool in my machine. Since not all users use zswap, the memory may be
wasted. Save the memory for these users by delaying the initialization of
zswap to first enablement.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 84e38300f571..90df72aceb08 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
 
 #define ZSWAP_PARAM_UNSET ""
 
+static int zswap_setup(void);
+
 /* Enable/disable zswap */
 static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
@@ -220,6 +222,8 @@ static atomic_t zswap_pools_count = ATOMIC_INIT(0);
 
 /* init state */
 static int zswap_init_state;
+/* used to ensure the integrity of initialization */
+static DEFINE_MUTEX(zswap_init_lock);
 
 /* init completed, but couldn't create the initial pool */
 static bool zswap_has_pool;
@@ -273,13 +277,13 @@ static void zswap_update_total_size(void)
 **********************************/
 static struct kmem_cache *zswap_entry_cache;
 
-static int __init zswap_entry_cache_create(void)
+static int zswap_entry_cache_create(void)
 {
 	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
 	return zswap_entry_cache == NULL;
 }
 
-static void __init zswap_entry_cache_destroy(void)
+static void zswap_entry_cache_destroy(void)
 {
 	kmem_cache_destroy(zswap_entry_cache);
 }
@@ -664,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	return NULL;
 }
 
-static __init struct zswap_pool *__zswap_pool_create_fallback(void)
+static struct zswap_pool *__zswap_pool_create_fallback(void)
 {
 	bool has_comp, has_zpool;
 
@@ -782,11 +786,17 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
 		return 0;
 
-	/* if this is load-time (pre-init) param setting,
+	/*
+	 * if zswap has not been initialized,
 	 * don't create a pool; that's done during init.
 	 */
-	if (zswap_init_state == ZSWAP_UNINIT)
-		return param_set_charp(s, kp);
+	mutex_lock(&zswap_init_lock);
+	if (zswap_init_state == ZSWAP_UNINIT) {
+		ret = param_set_charp(s, kp);
+		mutex_unlock(&zswap_init_lock);
+		return ret;
+	}
+	mutex_unlock(&zswap_init_lock);
 
 	if (!type) {
 		if (!zpool_has_pool(s)) {
@@ -876,6 +886,14 @@ static int zswap_zpool_param_set(const char *val,
 static int zswap_enabled_param_set(const char *val,
 				   const struct kernel_param *kp)
 {
+	if (system_state == SYSTEM_RUNNING) {
+		mutex_lock(&zswap_init_lock);
+		if (zswap_setup()) {
+			mutex_unlock(&zswap_init_lock);
+			return -ENODEV;
+		}
+		mutex_unlock(&zswap_init_lock);
+	}
 	if (zswap_init_state == ZSWAP_INIT_FAILED) {
 		pr_err("can't enable, initialization failed\n");
 		return -ENODEV;
@@ -1432,7 +1450,7 @@ static const struct frontswap_ops zswap_frontswap_ops = {
 
 static struct dentry *zswap_debugfs_root;
 
-static int __init zswap_debugfs_init(void)
+static int zswap_debugfs_init(void)
 {
 	if (!debugfs_initialized())
 		return -ENODEV;
@@ -1463,7 +1481,7 @@ static int __init zswap_debugfs_init(void)
 	return 0;
 }
 #else
-static int __init zswap_debugfs_init(void)
+static int zswap_debugfs_init(void)
 {
 	return 0;
 }
@@ -1472,11 +1490,14 @@ static int __init zswap_debugfs_init(void)
 /*********************************
 * module init and exit
 **********************************/
-static int __init init_zswap(void)
+static int zswap_setup(void)
 {
 	struct zswap_pool *pool;
 	int ret;
 
+	if (zswap_init_state != ZSWAP_UNINIT)
+		return 0;
+
 	if (zswap_entry_cache_create()) {
 		pr_err("entry cache creation failed\n");
 		goto cache_fail;
@@ -1534,6 +1555,15 @@ static int __init init_zswap(void)
 	zswap_enabled = false;
 	return -ENOMEM;
 }
+
+static int __init init_zswap(void)
+{
+	/* skip init if zswap is disabled when system startup */
+	if (!zswap_enabled)
+		return 0;
+	return zswap_setup();
+}
+
 /* must be late so crypto has time to come up */
 late_initcall(init_zswap);
 
-- 
2.25.1

