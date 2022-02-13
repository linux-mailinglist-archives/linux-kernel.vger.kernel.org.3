Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F87E4B3D8D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbiBMUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:50:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiBMUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:50:23 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC1453707;
        Sun, 13 Feb 2022 12:50:16 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 3D420200C43;
        Sun, 13 Feb 2022 20:50:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id CBC488087D; Sun, 13 Feb 2022 21:48:08 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 1/4] hw_random: do not bother to order list of devices by quality
Date:   Sun, 13 Feb 2022 21:46:28 +0100
Message-Id: <20220213204631.354247-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213204631.354247-1-linux@dominikbrodowski.net>
References: <20220213204631.354247-1-linux@dominikbrodowski.net>
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

There is no real reason why this list needs to be kept ordered by
the driver-provided quality value -- a value which is set only by
a handful of hw_random devices anyway.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/char/hw_random/core.c | 36 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index f327f7493585..6f09f4e5af20 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -31,7 +31,7 @@ static struct hwrng *current_rng;
 /* the current rng has been explicitly chosen by user via sysfs */
 static int cur_rng_set_by_user;
 static struct task_struct *hwrng_fill;
-/* list of registered rngs, sorted decending by quality */
+/* list of registered rngs */
 static LIST_HEAD(rng_list);
 /* Protects rng_list and current_rng */
 static DEFINE_MUTEX(rng_mutex);
@@ -297,24 +297,28 @@ static struct miscdevice rng_miscdev = {
 
 static int enable_best_rng(void)
 {
+	struct hwrng *rng, *new_rng = NULL;
 	int ret = -ENODEV;
 
 	BUG_ON(!mutex_is_locked(&rng_mutex));
 
-	/* rng_list is sorted by quality, use the best (=first) one */
-	if (!list_empty(&rng_list)) {
-		struct hwrng *new_rng;
-
-		new_rng = list_entry(rng_list.next, struct hwrng, list);
-		ret = ((new_rng == current_rng) ? 0 : set_current_rng(new_rng));
-		if (!ret)
-			cur_rng_set_by_user = 0;
-	} else {
+	/* no rng to use? */
+	if (list_empty(&rng_list)) {
 		drop_current_rng();
 		cur_rng_set_by_user = 0;
-		ret = 0;
+		return 0;
 	}
 
+	/* use the rng which offers the best quality */
+	list_for_each_entry(rng, &rng_list, list) {
+		if (!new_rng || rng->quality > new_rng->quality)
+			new_rng = rng;
+	}
+
+	ret = ((new_rng == current_rng) ? 0 : set_current_rng(new_rng));
+	if (!ret)
+		cur_rng_set_by_user = 0;
+
 	return ret;
 }
 
@@ -475,7 +479,6 @@ int hwrng_register(struct hwrng *rng)
 {
 	int err = -EINVAL;
 	struct hwrng *tmp;
-	struct list_head *rng_list_ptr;
 	bool is_new_current = false;
 
 	if (!rng->name || (!rng->data_read && !rng->read))
@@ -489,18 +492,11 @@ int hwrng_register(struct hwrng *rng)
 		if (strcmp(tmp->name, rng->name) == 0)
 			goto out_unlock;
 	}
+	list_add_tail(&rng->list, &rng_list);
 
 	init_completion(&rng->cleanup_done);
 	complete(&rng->cleanup_done);
 
-	/* rng_list is sorted by decreasing quality */
-	list_for_each(rng_list_ptr, &rng_list) {
-		tmp = list_entry(rng_list_ptr, struct hwrng, list);
-		if (tmp->quality < rng->quality)
-			break;
-	}
-	list_add_tail(&rng->list, rng_list_ptr);
-
 	if (!current_rng ||
 	    (!cur_rng_set_by_user && rng->quality > current_rng->quality)) {
 		/*
-- 
2.35.1

