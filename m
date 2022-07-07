Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9708A56ABAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiGGTQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiGGTPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:15:53 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874859248;
        Thu,  7 Jul 2022 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=bv+xibSJuetvs73oiK2dm/107wfS06Uz0XkG7QDbNRQ=; b=dDmRm6VLL+LC8JDXhKPueTtiJc
        6OLJbYTl27c7Fd09ewO6WEJnNvGwLoRs8jH7GWqusbF/o3JTqwnZiUt++KN7eIZzq87AXo53gndkS
        N+hCRy3OEFASOwkCK+G4Zs/qXXm5TM5xa95JHw6gzCLK+hJDayNtP8G9w9xHjgXXficzZcAcWXj4c
        bU18gYOvikwKCSkZXz3yKA2ttil5g3OsZhwGP1EAX7xlQyHeWICSBmcebZf1ziJ5d2etxCPUZVqRg
        UOyzywEXH0w0aESWOiSleyzTB75ymxmT+rh7aNTsXS2iuGlvNDscr2Z+w5MLVCAl2VR+PzGPXHtHN
        gCidj5+A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9Wyb-0099KT-L6; Thu, 07 Jul 2022 13:15:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9Wya-001ERV-AV; Thu, 07 Jul 2022 13:15:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Jul 2022 13:15:32 -0600
Message-Id: <20220707191533.293795-2-logang@deltatee.com>
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
Subject: [PATCH 1/2] md/raid5: Fix sectors_to_do bitmap overflow in raid5_make_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unaligned IO that have nearly maximum sectors, the number of stripes
will end up being one greater than the size of the bitmap. When this
happens, the last stripe in the IO will not be processed as it should
be, resulting in data corruption.

However, this is not normally seen when the backing block devices have
4K physical block sizes seeing the block layer will split the request
before that happens.

To fix this increase the bitmap size by one bit and ensure the full
number of stripes are checked when calling find_first_bit().

Reported-by: David Sloan <David.Sloan@eideticom.com>
Fixes: a5b9c6a653fb ("md/raid5: Pivot raid5_make_request()")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 184145b49b7c..e37ed93d130f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5872,8 +5872,11 @@ struct stripe_request_ctx {
 	/* last sector in the request */
 	sector_t last_sector;
 
-	/* bitmap to track stripe sectors that have been added to stripes */
-	DECLARE_BITMAP(sectors_to_do, RAID5_MAX_REQ_STRIPES);
+	/*
+	 * bitmap to track stripe sectors that have been added to stripes
+	 * add one to account for unaligned requests
+	 */
+	DECLARE_BITMAP(sectors_to_do, RAID5_MAX_REQ_STRIPES + 1);
 
 	/* the request had REQ_PREFLUSH, cleared after the first stripe_head */
 	bool do_flush;
@@ -6046,7 +6049,7 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	const int rw = bio_data_dir(bi);
 	enum stripe_result res;
 	DEFINE_WAIT(w);
-	int s;
+	int s, stripe_cnt;
 
 	if (unlikely(bi->bi_opf & REQ_PREFLUSH)) {
 		int ret = log_handle_flush_request(conf, bi);
@@ -6090,9 +6093,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 	ctx.last_sector = bio_end_sector(bi);
 	bi->bi_next = NULL;
 
-	bitmap_set(ctx.sectors_to_do, 0,
-		   DIV_ROUND_UP_SECTOR_T(ctx.last_sector - logical_sector,
-					 RAID5_STRIPE_SECTORS(conf)));
+	stripe_cnt = DIV_ROUND_UP_SECTOR_T(ctx.last_sector - logical_sector,
+					   RAID5_STRIPE_SECTORS(conf));
+	bitmap_set(ctx.sectors_to_do, 0, stripe_cnt);
 
 	pr_debug("raid456: %s, logical %llu to %llu\n", __func__,
 		 bi->bi_iter.bi_sector, ctx.last_sector);
@@ -6137,8 +6140,8 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			continue;
 		}
 
-		s = find_first_bit(ctx.sectors_to_do, RAID5_MAX_REQ_STRIPES);
-		if (s == RAID5_MAX_REQ_STRIPES)
+		s = find_first_bit(ctx.sectors_to_do, stripe_cnt);
+		if (s == stripe_cnt)
 			break;
 
 		logical_sector = ctx.first_sector +
-- 
2.30.2

