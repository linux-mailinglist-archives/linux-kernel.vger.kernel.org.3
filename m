Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F045840C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiG1ONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiG1ONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80641033;
        Thu, 28 Jul 2022 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lFLuDGPlqkNDa/zEoJSr26bGwaBIGwbl7RjFAJrM96U=; b=1AMo3p2GTsK9zZQ5tLu73rIo4p
        fRmi3FPF3sq0P6USgQ9LhnvhBLPJYMG1O3uaR6p4Pm1hoW/8Swa5kEIEt1By7LSJ5KynKfPcv8Y9p
        Yx54a3XbJ11wmih1rVO6FDefDpz2eDr97UtFZCY5iBqr9iQkTDiFQierMorQBhTlnGW1N22dp5XdQ
        Z8ZCSjgzWTBlETQ2B+IUVUq5ASk1PQAhJ/+8mgl1h+zvN/7/Vzemq4rBt9xDYfYwOiYnPBnzp9eWp
        eP/TTenbUtXxe6UJYF4lSCqt02VBqJS1O2qBacUJ/mbRwvsCUvPOwISe3UFHlORGeNY3npvSuysOF
        2Cdr7yMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oH4Go-00A1rc-Jv; Thu, 28 Jul 2022 14:13:46 +0000
Date:   Thu, 28 Jul 2022 07:13:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
Message-ID: <YuKZmloAcZWY5of8@infradead.org>
References: <20220727210600.120221-1-logang@deltatee.com>
 <20220727210600.120221-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727210600.120221-2-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 03:05:56PM -0600, Logan Gunthorpe wrote:
> Refactor the raid5_get_active_stripe() to read more linearly in
> the order it's typically executed.
> 
> The init_stripe() call is called if a free stripe is found and the
> function is exited early which removes a lot of if (sh) checks and
> unindents the following code.
> 
> Remove the while loop in favour of the 'goto retry' pattern, which
> reduces indentation further. And use a 'goto wait_for_stripe' instead
> of an additional indent seeing it is the unusual path and this makes
> the code easier to read.
> 
> No functional changes intended. Will make subsequent changes
> in patches easier to understand.

I find the new loop even more confusing than the old one.  I'd go
with something like the version below (on top of the whol md-next tree
that pulled this in way too fast..)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 4456ac51f7c53..cd8ec4995a49b 100644
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
+			 * waiting on quiesce, otherwise the batch_last will
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
