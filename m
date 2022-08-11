Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802295905AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbiHKRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiHKRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:18:35 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C385AB2;
        Thu, 11 Aug 2022 10:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=KCWC1BAEeEOwJreUQh1JdYR/8BO5Nhl2E/sklHpn2Ck=; b=sXLYh49k+1n6XS6E8KFAq2f63I
        9fzc/JF/Q7zJfb+MEHo/tt/JCJysj2k299OPy7tiKEj/MzFEtQFjdyG2a4Z7CXj0jgd+t9j97wrOW
        o3JEIaEdBgVX88dnCbuCsgEXsm7o9SnAacPAcFeWS2kikUKUM4gbLJ0bxIQ32euHFah+BJddzZhHw
        DhIButxjqoAudX1AmcFkBDood03WdsbwqtLcH8bozKlAMW7JOCCmBHrhcl0yfm8qc244IIR2ce0x9
        YFfiUyr5gq0sn1p8/0WkLDaPmMKITkenrPOsgfrd9DstuBzaAXm4LPsLXKCzqzjDMpzS8tXM4Wznz
        fccuWofg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlJ-00EAyh-Rj; Thu, 11 Aug 2022 11:14:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlH-000cRA-VO; Thu, 11 Aug 2022 11:14:24 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Aug 2022 11:14:14 -0600
Message-Id: <20220811171417.147697-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811171417.147697-1-logang@deltatee.com>
References: <20220811171417.147697-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 2/5] md/raid5: Refactor raid5_get_active_stripe()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor raid5_get_active_stripe() without the gotos with an
explicit infinite loop and some additional nesting.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 82 +++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4456ac51f7c5..1288ef9e1571 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -811,54 +811,54 @@ static struct stripe_head *__raid5_get_active_stripe(struct r5conf *conf,
 
 	spin_lock_irq(conf->hash_locks + hash);
 
-retry:
-	if (!noquiesce && conf->quiesce) {
-		/*
-		 * Must release the reference to batch_last before waiting,
-		 * on quiesce, otherwise the batch_last will hold a reference
-		 * to a stripe and raid5_quiesce() will deadlock waiting for
-		 * active_stripes to go to zero.
-		 */
-		if (ctx && ctx->batch_last) {
-			raid5_release_stripe(ctx->batch_last);
-			ctx->batch_last = NULL;
-		}
-
-		wait_event_lock_irq(conf->wait_for_quiescent, !conf->quiesce,
-				    *(conf->hash_locks + hash));
-	}
+	for (;;) {
+		if (!noquiesce && conf->quiesce) {
+			/*
+			 * Must release the reference to batch_last before
+			 * waiting, on quiesce, otherwise the batch_last will
+			 * hold a reference to a stripe and raid5_quiesce()
+			 * will deadlock waiting for active_stripes to go to
+			 * zero.
+			 */
+			if (ctx && ctx->batch_last) {
+				raid5_release_stripe(ctx->batch_last);
+				ctx->batch_last = NULL;
+			}
 
-	sh = find_get_stripe(conf, sector, conf->generation - previous, hash);
-	if (sh)
-		goto out;
+			wait_event_lock_irq(conf->wait_for_quiescent,
+					    !conf->quiesce,
+					    *(conf->hash_locks + hash));
+		}
 
-	if (test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state))
-		goto wait_for_stripe;
+		sh = find_get_stripe(conf, sector, conf->generation - previous,
+				     hash);
+		if (sh)
+			break;
 
-	sh = get_free_stripe(conf, hash);
-	if (sh) {
-		r5c_check_stripe_cache_usage(conf);
-		init_stripe(sh, sector, previous);
-		atomic_inc(&sh->count);
-		goto out;
-	}
+		if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state)) {
+			sh = get_free_stripe(conf, hash);
+			if (sh) {
+				r5c_check_stripe_cache_usage(conf);
+				init_stripe(sh, sector, previous);
+				atomic_inc(&sh->count);
+				break;
+			}
 
-	if (!test_bit(R5_DID_ALLOC, &conf->cache_state))
-		set_bit(R5_ALLOC_MORE, &conf->cache_state);
+			if (!test_bit(R5_DID_ALLOC, &conf->cache_state))
+				set_bit(R5_ALLOC_MORE, &conf->cache_state);
+		}
 
-wait_for_stripe:
-	if (noblock)
-		goto out;
+		if (noblock)
+			break;
 
-	set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
-	r5l_wake_reclaim(conf->log, 0);
-	wait_event_lock_irq(conf->wait_for_stripe,
-			    is_inactive_blocked(conf, hash),
-			    *(conf->hash_locks + hash));
-	clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
-	goto retry;
+		set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
+		r5l_wake_reclaim(conf->log, 0);
+		wait_event_lock_irq(conf->wait_for_stripe,
+				    is_inactive_blocked(conf, hash),
+				    *(conf->hash_locks + hash));
+		clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
+	}
 
-out:
 	spin_unlock_irq(conf->hash_locks + hash);
 	return sh;
 }
-- 
2.30.2

