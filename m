Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280FC54EA01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378358AbiFPTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377934AbiFPTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:57 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3956414;
        Thu, 16 Jun 2022 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=2kM9OhtMeK3+AUYfV6JzJmyz2Q8SE9IesWpL15reZBk=; b=H0wyD1biHpxXf4h6aSGqICapAV
        t3aiECR2E0lx7h7f6tCG2nx0LobskvQu0XuN1MJNXY+hriDzUTN1OsCEPchmobyDQDypOe28jGY86
        t4APkMuWNPZncaFIc4X1djPWGo3EAsh3BykHvjQd6OAmY/soUzjYDb0gNT9fsxZUauk70nJcWV9iq
        KwD6BobwI+9urJiuOx/aHL19ipskVIRq4KbntcPVC+ohMB4iAjEivHlRTXoYgr3sNIRqFu8zmOING
        r5TODyqs8/3RZ4E3qMf10yrDjeBs1amEkU3yYwZo0LGMT0DphIftSAT6rmhVt4ZVHXmmRNeQXtrA+
        ZVLpjS6w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v21-0092ij-90; Thu, 16 Jun 2022 13:19:54 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o1v1v-0006FJ-Bp; Thu, 16 Jun 2022 13:19:47 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 16 Jun 2022 13:19:35 -0600
Message-Id: <20220616191945.23935-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220616191945.23935-1-logang@deltatee.com>
References: <20220616191945.23935-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 05/15] md/raid5: Move common stripe get code into new find_get_stripe() helper
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both uses of find_stripe() require a fairly complicated dance to
increment the reference count. Move this into a common find_get_stripe()
helper.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/md/raid5.c | 131 ++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 67 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 969609b7114b..1bbf87d15bc8 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -624,6 +624,49 @@ static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
 	return NULL;
 }
 
+static struct stripe_head *find_get_stripe(struct r5conf *conf,
+		sector_t sector, short generation, int hash)
+{
+	int inc_empty_inactive_list_flag;
+	struct stripe_head *sh;
+
+	sh = __find_stripe(conf, sector, generation);
+	if (!sh)
+		return NULL;
+
+	if (atomic_inc_not_zero(&sh->count))
+		return sh;
+
+	/*
+	 * Slow path. The reference count is zero which means the stripe must
+	 * be on a list (sh->lru). Must remove the stripe from the list that
+	 * references it with the device_lock held.
+	 */
+
+	spin_lock(&conf->device_lock);
+	if (!atomic_read(&sh->count)) {
+		if (!test_bit(STRIPE_HANDLE, &sh->state))
+			atomic_inc(&conf->active_stripes);
+		BUG_ON(list_empty(&sh->lru) &&
+		       !test_bit(STRIPE_EXPANDING, &sh->state));
+		inc_empty_inactive_list_flag = 0;
+		if (!list_empty(conf->inactive_list + hash))
+			inc_empty_inactive_list_flag = 1;
+		list_del_init(&sh->lru);
+		if (list_empty(conf->inactive_list + hash) &&
+		    inc_empty_inactive_list_flag)
+			atomic_inc(&conf->empty_inactive_list_nr);
+		if (sh->group) {
+			sh->group->stripes_cnt--;
+			sh->group = NULL;
+		}
+	}
+	atomic_inc(&sh->count);
+	spin_unlock(&conf->device_lock);
+
+	return sh;
+}
+
 /*
  * Need to check if array has failed when deciding whether to:
  *  - start an array
@@ -716,7 +759,6 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 {
 	struct stripe_head *sh;
 	int hash = stripe_hash_locks_hash(conf, sector);
-	int inc_empty_inactive_list_flag;
 
 	pr_debug("get_stripe, sector %llu\n", (unsigned long long)sector);
 
@@ -726,57 +768,34 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 		wait_event_lock_irq(conf->wait_for_quiescent,
 				    conf->quiesce == 0 || noquiesce,
 				    *(conf->hash_locks + hash));
-		sh = __find_stripe(conf, sector, conf->generation - previous);
-		if (!sh) {
-			if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state)) {
-				sh = get_free_stripe(conf, hash);
-				if (!sh && !test_bit(R5_DID_ALLOC,
-						     &conf->cache_state))
-					set_bit(R5_ALLOC_MORE,
-						&conf->cache_state);
-			}
-			if (noblock && sh == NULL)
-				break;
+		sh = find_get_stripe(conf, sector, conf->generation - previous,
+				     hash);
+		if (sh)
+			break;
 
-			r5c_check_stripe_cache_usage(conf);
-			if (!sh) {
-				set_bit(R5_INACTIVE_BLOCKED,
-					&conf->cache_state);
-				r5l_wake_reclaim(conf->log, 0);
-				wait_event_lock_irq(
-					conf->wait_for_stripe,
+		if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state)) {
+			sh = get_free_stripe(conf, hash);
+			if (!sh && !test_bit(R5_DID_ALLOC, &conf->cache_state))
+				set_bit(R5_ALLOC_MORE, &conf->cache_state);
+		}
+		if (noblock && !sh)
+			break;
+
+		r5c_check_stripe_cache_usage(conf);
+		if (!sh) {
+			set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
+			r5l_wake_reclaim(conf->log, 0);
+			wait_event_lock_irq(conf->wait_for_stripe,
 					!list_empty(conf->inactive_list + hash) &&
 					(atomic_read(&conf->active_stripes)
 					 < (conf->max_nr_stripes * 3 / 4)
 					 || !test_bit(R5_INACTIVE_BLOCKED,
 						      &conf->cache_state)),
 					*(conf->hash_locks + hash));
-				clear_bit(R5_INACTIVE_BLOCKED,
-					  &conf->cache_state);
-			} else {
-				init_stripe(sh, sector, previous);
-				atomic_inc(&sh->count);
-			}
-		} else if (!atomic_inc_not_zero(&sh->count)) {
-			spin_lock(&conf->device_lock);
-			if (!atomic_read(&sh->count)) {
-				if (!test_bit(STRIPE_HANDLE, &sh->state))
-					atomic_inc(&conf->active_stripes);
-				BUG_ON(list_empty(&sh->lru) &&
-				       !test_bit(STRIPE_EXPANDING, &sh->state));
-				inc_empty_inactive_list_flag = 0;
-				if (!list_empty(conf->inactive_list + hash))
-					inc_empty_inactive_list_flag = 1;
-				list_del_init(&sh->lru);
-				if (list_empty(conf->inactive_list + hash) && inc_empty_inactive_list_flag)
-					atomic_inc(&conf->empty_inactive_list_nr);
-				if (sh->group) {
-					sh->group->stripes_cnt--;
-					sh->group = NULL;
-				}
-			}
+			clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
+		} else {
+			init_stripe(sh, sector, previous);
 			atomic_inc(&sh->count);
-			spin_unlock(&conf->device_lock);
 		}
 	} while (sh == NULL);
 
@@ -830,7 +849,6 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 	sector_t head_sector, tmp_sec;
 	int hash;
 	int dd_idx;
-	int inc_empty_inactive_list_flag;
 
 	/* Don't cross chunks, so stripe pd_idx/qd_idx is the same */
 	tmp_sec = sh->sector;
@@ -840,28 +858,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 
 	hash = stripe_hash_locks_hash(conf, head_sector);
 	spin_lock_irq(conf->hash_locks + hash);
-	head = __find_stripe(conf, head_sector, conf->generation);
-	if (head && !atomic_inc_not_zero(&head->count)) {
-		spin_lock(&conf->device_lock);
-		if (!atomic_read(&head->count)) {
-			if (!test_bit(STRIPE_HANDLE, &head->state))
-				atomic_inc(&conf->active_stripes);
-			BUG_ON(list_empty(&head->lru) &&
-			       !test_bit(STRIPE_EXPANDING, &head->state));
-			inc_empty_inactive_list_flag = 0;
-			if (!list_empty(conf->inactive_list + hash))
-				inc_empty_inactive_list_flag = 1;
-			list_del_init(&head->lru);
-			if (list_empty(conf->inactive_list + hash) && inc_empty_inactive_list_flag)
-				atomic_inc(&conf->empty_inactive_list_nr);
-			if (head->group) {
-				head->group->stripes_cnt--;
-				head->group = NULL;
-			}
-		}
-		atomic_inc(&head->count);
-		spin_unlock(&conf->device_lock);
-	}
+	head = find_get_stripe(conf, head_sector, conf->generation, hash);
 	spin_unlock_irq(conf->hash_locks + hash);
 
 	if (!head)
-- 
2.30.2

