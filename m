Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67724F85C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbiDGRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiDGRXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:23:52 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D270BC0F;
        Thu,  7 Apr 2022 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=wpn/cFs7ICqDTKdxfQRTWuXVXhkklSg4ezYfXgfOPzE=; b=j+1wU3y0FcEcwb25+1IusqjMCD
        fjuyD0pji3sns2Syg1LqjS8C0aS9qh+PYurWg4idi1CEC9lNYz//3U5OwqCJXa3C6RZWGwR+U0TOz
        hzEBtQLnCUvCqixN8V16o8fIi3w1nWdfcHtQppY65JHvkpcVZzH67xQpEXL3HiCNqOJrM5HFZnNni
        EosTrt05nmIp/4j2NtrkNkoLUjMUDqmzDdlVHMp0EGCQ3IIS4veD1mctF9IlMDXef9gbUwYoM1v2g
        3agmhkzHCNLPx/s8LdBs13CeyvM3BEhUjTUXl3xa+22+/7p3nI90n8uP4CX8HRLhtPyri6DfI88Bz
        CDxBoQzg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRg-002CRe-Bt; Thu, 07 Apr 2022 10:57:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVRf-0002QJ-PW; Thu, 07 Apr 2022 10:57:19 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:57:13 -0600
Message-Id: <20220407165713.9243-8-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407165713.9243-1-logang@deltatee.com>
References: <20220407165713.9243-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 7/7] md/raid5: Annotate functions that hold device_lock with __must_hold
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of functions note the device_lock must be held with a comment
but this is not comprehensive. Many other functions hold the lock when
taken so add an __must_hold() to each call to annotate when the lock is
held.

This makes it a bit easier to analyse device_lock.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index fa955d23c88f..b53000a917df 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -79,18 +79,21 @@ static inline int stripe_hash_locks_hash(struct r5conf *conf, sector_t sect)
 }
 
 static inline void lock_device_hash_lock(struct r5conf *conf, int hash)
+	__acquires(&conf->device_lock)
 {
 	spin_lock_irq(conf->hash_locks + hash);
 	spin_lock(&conf->device_lock);
 }
 
 static inline void unlock_device_hash_lock(struct r5conf *conf, int hash)
+	__releases(&conf->device_lock)
 {
 	spin_unlock(&conf->device_lock);
 	spin_unlock_irq(conf->hash_locks + hash);
 }
 
 static inline void lock_all_device_hash_locks_irq(struct r5conf *conf)
+	__acquires(&conf->device_lock)
 {
 	int i;
 	spin_lock_irq(conf->hash_locks);
@@ -100,6 +103,7 @@ static inline void lock_all_device_hash_locks_irq(struct r5conf *conf)
 }
 
 static inline void unlock_all_device_hash_locks_irq(struct r5conf *conf)
+	__releases(&conf->device_lock)
 {
 	int i;
 	spin_unlock(&conf->device_lock);
@@ -164,6 +168,7 @@ static bool stripe_is_lowprio(struct stripe_head *sh)
 }
 
 static void raid5_wakeup_stripe_thread(struct stripe_head *sh)
+	__must_hold(&sh->raid_conf->device_lock)
 {
 	struct r5conf *conf = sh->raid_conf;
 	struct r5worker_group *group;
@@ -211,6 +216,7 @@ static void raid5_wakeup_stripe_thread(struct stripe_head *sh)
 
 static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 			      struct list_head *temp_inactive_list)
+	__must_hold(&conf->device_lock)
 {
 	int i;
 	int injournal = 0;	/* number of date pages with R5_InJournal */
@@ -296,6 +302,7 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 
 static void __release_stripe(struct r5conf *conf, struct stripe_head *sh,
 			     struct list_head *temp_inactive_list)
+	__must_hold(&conf->device_lock)
 {
 	if (atomic_dec_and_test(&sh->count))
 		do_release_stripe(conf, sh, temp_inactive_list);
@@ -350,9 +357,9 @@ static void release_inactive_stripe_list(struct r5conf *conf,
 	}
 }
 
-/* should hold conf->device_lock already */
 static int release_stripe_list(struct r5conf *conf,
 			       struct list_head *temp_inactive_list)
+	__must_hold(&conf->device_lock)
 {
 	struct stripe_head *sh, *t;
 	int count = 0;
@@ -629,6 +636,10 @@ static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
  * This is because some failed devices may only affect one
  * of the two sections, and some non-in_sync devices may
  * be insync in the section most affected by failed devices.
+ *
+ * Most calls to this function hold &conf->device_lock. Calls
+ * in raid5_run() do not require the lock as no other threads
+ * have been started yet.
  */
 int raid5_calc_degraded(struct r5conf *conf)
 {
@@ -5278,6 +5289,7 @@ static void handle_stripe(struct stripe_head *sh)
 }
 
 static void raid5_activate_delayed(struct r5conf *conf)
+	__must_hold(&conf->device_lock)
 {
 	if (atomic_read(&conf->preread_active_stripes) < IO_THRESHOLD) {
 		while (!list_empty(&conf->delayed_list)) {
@@ -5295,9 +5307,9 @@ static void raid5_activate_delayed(struct r5conf *conf)
 }
 
 static void activate_bit_delay(struct r5conf *conf,
-	struct list_head *temp_inactive_list)
+		struct list_head *temp_inactive_list)
+	__must_hold(&conf->device_lock)
 {
-	/* device_lock is held */
 	struct list_head head;
 	list_add(&head, &conf->bitmap_list);
 	list_del_init(&conf->bitmap_list);
@@ -5522,6 +5534,7 @@ static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
  * handle_list.
  */
 static struct stripe_head *__get_priority_stripe(struct r5conf *conf, int group)
+	__must_hold(&conf->device_lock)
 {
 	struct stripe_head *sh, *tmp;
 	struct list_head *handle_list = NULL;
@@ -6393,8 +6406,7 @@ static int  retry_aligned_read(struct r5conf *conf, struct bio *raid_bio,
 static int handle_active_stripes(struct r5conf *conf, int group,
 				 struct r5worker *worker,
 				 struct list_head *temp_inactive_list)
-		__releases(&conf->device_lock)
-		__acquires(&conf->device_lock)
+		__must_hold(&conf->device_lock)
 {
 	struct stripe_head *batch[MAX_STRIPE_BATCH], *sh;
 	int i, batch_size = 0, hash;
-- 
2.30.2

