Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5D56ABA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiGGTP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiGGTPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:15:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A121B5723F;
        Thu,  7 Jul 2022 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=xel/L+sXXPOAh9iZSjFTyQINk5NqdFAPgrfWzmM//Q4=; b=BVpADDpCVjvq4lOhUUL/pghWDs
        JqnodTxLfzAuOkPjYx5wXWvzFT0HNH2Mj3OraSySfZis+NMmJQtyJ0CX43XBpgtR4jxz4nKTPKfzT
        K7mf1/DqpUSKQhSgMQGUBkIr0Gwu8CWYjaCWbnbbc03qjS+aOWm97aTVrTAtDQ7/n5UQXodkrJdoM
        q1E772ezkvpGIfSBEJ+Or1nxisx1LJxwaiHo7/LOy/Z2K19CiwUU40m4jL8oYoiVhcCD6a10ASACD
        YGQ45sJb1Fq7fXbK0FcosT43yxfFeH3z96vCNsbyCXyJPWxT+jBKyMrLS88V//zXgOAsKio2vD0L+
        Lm7ANzvw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9Wyb-0099KU-L6; Thu, 07 Jul 2022 13:15:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9Wya-001ERY-DT; Thu, 07 Jul 2022 13:15:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Jul 2022 13:15:33 -0600
Message-Id: <20220707191533.293795-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707191533.293795-1-logang@deltatee.com>
References: <20220707191533.293795-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 2/2] md/raid5: Convert prepare_to_wait() to wait_woken() api
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

raid5_get_active_stripe() can sleep in various situations and it
is called by make_stripe_request() while inside the
prepare_to_wait()/finish_wait() section. Nested waits like this are
not supported.

This was noticed while making other changes that add different sleeps
to raid5_get_active_stripe() that caused a WARNING with and
CONFIG_DEBUG_ATOMIC_SLEEP.

No ill effects have been noticed with the code as is, but theoretically
a nested and here could cause a dead lock so it should be fixed.

To fix this, convert the prepare_to_wait() call to use wake_woken()
which supports nested sleeps.

Link: https://lwn.net/Articles/628628/
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e37ed93d130f..88c22a5cc09a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6043,12 +6043,12 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 {
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct r5conf *conf = mddev->private;
 	sector_t logical_sector;
 	struct stripe_request_ctx ctx = {};
 	const int rw = bio_data_dir(bi);
 	enum stripe_result res;
-	DEFINE_WAIT(w);
 	int s, stripe_cnt;
 
 	if (unlikely(bi->bi_opf & REQ_PREFLUSH)) {
@@ -6111,7 +6111,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		return true;
 	}
 	md_account_bio(mddev, &bi);
-	prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
+
+	add_wait_queue(&conf->wait_for_overlap, &wait);
 	while (1) {
 		res = make_stripe_request(mddev, conf, &ctx, logical_sector,
 					  bi);
@@ -6134,9 +6135,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				ctx.batch_last = NULL;
 			}
 
-			schedule();
-			prepare_to_wait(&conf->wait_for_overlap, &w,
-					TASK_UNINTERRUPTIBLE);
+			wait_woken(&wait, TASK_UNINTERRUPTIBLE,
+				   MAX_SCHEDULE_TIMEOUT);
 			continue;
 		}
 
@@ -6147,8 +6147,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 		logical_sector = ctx.first_sector +
 			(s << RAID5_STRIPE_SHIFT(conf));
 	}
-
-	finish_wait(&conf->wait_for_overlap, &w);
+	remove_wait_queue(&conf->wait_for_overlap, &wait);
 
 	if (ctx.batch_last)
 		raid5_release_stripe(ctx.batch_last);
-- 
2.30.2

