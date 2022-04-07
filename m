Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3024F85E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346233AbiDGRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346131AbiDGRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:24:09 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854B286C3;
        Thu,  7 Apr 2022 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=43ieDeq7qFS7TQx+ySkeNxmmOsQba+pv9Ms1C88DsoQ=; b=UT1Tb1sWIBWWtUp5Pt5mUWoiaV
        eJV1QDZ5uo4Rj3wEDshNlOop6MGUpDaWDOC02aRGwC1s3G3oGChKenS0eDSeSBpUN/0h3GrdFigqR
        GE7XbCeYNc1mPdovxP3VRKUK3TdLtDS3uaIidNAPWNUGhlbS1Y0KxZW+AqLdZkKs2YAZohqOKsi9N
        Y4J7zRP2yTttz+JNegEhw1m8hnAtzyK8EafCqONYZJSovEmnbwxvuCC/KlAHE57xLiBvwNpgVgzWr
        MvMCZvxo7p9rg5J5FK3BI6L3H4guSBVPJWcM+y4yFJSEacziraPVBWI658GLBF4OQPyzXq1vQlmf0
        xg0ezj9Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG1-002CHn-9w; Thu, 07 Apr 2022 10:45:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncVG0-0002Dh-8S; Thu, 07 Apr 2022 10:45:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Shaohua Li <shli@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Apr 2022 10:45:06 -0600
Message-Id: <20220407164511.8472-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407164511.8472-1-logang@deltatee.com>
References: <20220407164511.8472-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, shli@kernel.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v1 3/8] md/raid5: Move common stripe count increment code into __find_stripe()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both uses of find_stripe() require a fairly complicated dance to
increment the reference count. Move this into a common place in
__find_stripe()

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 118 +++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 69 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e3c75b3b8923..be01c4515f0e 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -605,16 +605,42 @@ static void init_stripe(struct stripe_head *sh, sector_t sector, int previous)
 }
 
 static struct stripe_head *__find_stripe(struct r5conf *conf, sector_t sector,
-					 short generation)
+					 short generation, int hash)
 {
+	int inc_empty_inactive_list_flag;
 	struct stripe_head *sh;
 
 	pr_debug("__find_stripe, sector %llu\n", (unsigned long long)sector);
 	hlist_for_each_entry(sh, stripe_hash(conf, sector), hash)
 		if (sh->sector == sector && sh->generation == generation)
-			return sh;
+			goto found;
 	pr_debug("__stripe %llu not in cache\n", (unsigned long long)sector);
 	return NULL;
+
+found:
+	if (!atomic_inc_not_zero(&sh->count)) {
+		spin_lock(&conf->device_lock);
+		if (!atomic_read(&sh->count)) {
+			if (!test_bit(STRIPE_HANDLE, &sh->state))
+				atomic_inc(&conf->active_stripes);
+			BUG_ON(list_empty(&sh->lru) &&
+			       !test_bit(STRIPE_EXPANDING, &sh->state));
+			inc_empty_inactive_list_flag = 0;
+			if (!list_empty(conf->inactive_list + hash))
+				inc_empty_inactive_list_flag = 1;
+			list_del_init(&sh->lru);
+			if (list_empty(conf->inactive_list + hash) &&
+			    inc_empty_inactive_list_flag)
+				atomic_inc(&conf->empty_inactive_list_nr);
+			if (sh->group) {
+				sh->group->stripes_cnt--;
+				sh->group = NULL;
+			}
+		}
+		atomic_inc(&sh->count);
+		spin_unlock(&conf->device_lock);
+	}
+	return sh;
 }
 
 /*
@@ -705,7 +731,6 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 {
 	struct stripe_head *sh;
 	int hash = stripe_hash_locks_hash(conf, sector);
-	int inc_empty_inactive_list_flag;
 
 	pr_debug("get_stripe, sector %llu\n", (unsigned long long)sector);
 
@@ -715,57 +740,34 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
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
+		sh = __find_stripe(conf, sector, conf->generation - previous,
+				   hash);
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
 
@@ -819,7 +821,6 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 	sector_t head_sector, tmp_sec;
 	int hash;
 	int dd_idx;
-	int inc_empty_inactive_list_flag;
 
 	/* Don't cross chunks, so stripe pd_idx/qd_idx is the same */
 	tmp_sec = sh->sector;
@@ -829,28 +830,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 
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
+	head = __find_stripe(conf, head_sector, conf->generation, hash);
 	spin_unlock_irq(conf->hash_locks + hash);
 
 	if (!head)
-- 
2.30.2

