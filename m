Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79BF5090D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381897AbiDTT6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiDTT5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:57:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306014003;
        Wed, 20 Apr 2022 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=1+vyla/uaazPWsKpL3zLeU/4Q484AsJ5Xk5mcUxpJCo=; b=pE7ZqxnLRObgKJju9kdNMv2oDL
        Ku/79G3fV2XH55cw1A7MaP9p08FLNAUpOX6VWebqsBZZMl/lbU9t8h2IxPGAPcpnwu5R/u1MqY2Ab
        7xQqJqBGbD/9YwwPhSvWAKSQY8JvK8UgdKr1wgWNi3ntNx/0K/5DUZBouNf6+/c3VH4k3datAJmx1
        AOTuPf9dLopWtnGqrnWPzLKI6PgRQ6POvfs9jRoDzVsNbUwC81wMyXtD1oUFA/p3tPZxcJhsgIWIk
        RB9EdRh5UUvmJdnaA3aOail9DHCOiB8+Jv99lGUf9tq3/SPC+nPkHzNQMN0ytloJ63UEakyVe6ss9
        sHrPoJHQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPp-00CRsI-J8; Wed, 20 Apr 2022 13:55:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nhGPp-00096H-5u; Wed, 20 Apr 2022 13:55:05 -0600
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
Date:   Wed, 20 Apr 2022 13:54:16 -0600
Message-Id: <20220420195425.34911-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420195425.34911-1-logang@deltatee.com>
References: <20220420195425.34911-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 03/12] md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stripe_add_to_batch_list() is better done in the loop in make_request
instead of inside add_stripe_bio(). This is clearer and allows for
storing the batch_head state outside the loop in a subsequent patch.

The call to add_stripe_bio() in retry_aligned_read() is for read
and batching only applies to write. So it's impossible for batching
to happen at that call site.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index cda6857e6207..8e1ece5ce984 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3534,8 +3534,6 @@ static int add_stripe_bio(struct stripe_head *sh, struct bio *bi, int dd_idx,
 	}
 	spin_unlock_irq(&sh->stripe_lock);
 
-	if (stripe_can_batch(sh))
-		stripe_add_to_batch_list(conf, sh);
 	return 1;
 
  overlap:
@@ -5955,6 +5953,9 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 			goto retry;
 		}
 
+		if (stripe_can_batch(sh))
+			stripe_add_to_batch_list(conf, sh);
+
 		if (do_flush) {
 			set_bit(STRIPE_R5C_PREFLUSH, &sh->state);
 			/* we only need flush for one stripe */
-- 
2.30.2

