Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D645834B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiG0VIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiG0VI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:08:29 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF9664D8;
        Wed, 27 Jul 2022 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=HhOI3hGzyoxvTH1ppc65L0p8gCIRg/9KN6nIT4rDGSU=; b=M4azOJKu6pkULnQP5RF/RO9/VI
        h+72Xg3/Qqfw4U8MrBKKJwqUhCtdyVatB6jx7im5pNuOef+MqWEcrwYjXupgqKeIE27RLs9X/SSP4
        AjzExZJRTo5KpAl+Of2eonMg+8sVPB/dryupdvcbcmgQdZF6+AYOtvNViS+IFyB0n3yxP3fu23qD6
        XdGuRZm38F1GvKOL4/IySlNqb7cIunw/VGCKqwSS4960+W1k5oKTfbIpJ89aL+9VhYsxgoHi3WIqZ
        3FmT25CIr9CVkTaAOKCOeW2e8roSqzvzRw6HeaebUwl/QSAPDMMZImvw5hGASPIvbI+OPBV95yDOM
        JPsgy0/A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEG-001pyD-GI; Wed, 27 Jul 2022 15:06:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEE-000VHx-MT; Wed, 27 Jul 2022 15:06:02 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 27 Jul 2022 15:05:56 -0600
Message-Id: <20220727210600.120221-2-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727210600.120221-1-logang@deltatee.com>
References: <20220727210600.120221-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 1/5] md/raid5: Refactor raid5_get_active_stripe()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the raid5_get_active_stripe() to read more linearly in
the order it's typically executed.

The init_stripe() call is called if a free stripe is found and the
function is exited early which removes a lot of if (sh) checks and
unindents the following code.

Remove the while loop in favour of the 'goto retry' pattern, which
reduces indentation further. And use a 'goto wait_for_stripe' instead
of an additional indent seeing it is the unusual path and this makes
the code easier to read.

No functional changes intended. Will make subsequent changes
in patches easier to understand.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 67 +++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 3b7887428cd0..b1cb0be8fa67 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -766,41 +766,46 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 
 	spin_lock_irq(conf->hash_locks + hash);
 
-	do {
-		wait_event_lock_irq(conf->wait_for_quiescent,
-				    conf->quiesce == 0 || noquiesce,
-				    *(conf->hash_locks + hash));
-		sh = find_get_stripe(conf, sector, conf->generation - previous,
-				     hash);
-		if (sh)
-			break;
+retry:
+	wait_event_lock_irq(conf->wait_for_quiescent,
+			    conf->quiesce == 0 || noquiesce,
+			    *(conf->hash_locks + hash));
+	sh = find_get_stripe(conf, sector, conf->generation - previous, hash);
+	if (sh)
+		goto out;
 
-		if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state)) {
-			sh = get_free_stripe(conf, hash);
-			if (!sh && !test_bit(R5_DID_ALLOC, &conf->cache_state))
-				set_bit(R5_ALLOC_MORE, &conf->cache_state);
-		}
-		if (noblock && !sh)
-			break;
+	if (test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state))
+		goto wait_for_stripe;
 
+	sh = get_free_stripe(conf, hash);
+	if (sh) {
 		r5c_check_stripe_cache_usage(conf);
-		if (!sh) {
-			set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
-			r5l_wake_reclaim(conf->log, 0);
-			wait_event_lock_irq(conf->wait_for_stripe,
-					!list_empty(conf->inactive_list + hash) &&
-					(atomic_read(&conf->active_stripes)
-					 < (conf->max_nr_stripes * 3 / 4)
-					 || !test_bit(R5_INACTIVE_BLOCKED,
-						      &conf->cache_state)),
-					*(conf->hash_locks + hash));
-			clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
-		} else {
-			init_stripe(sh, sector, previous);
-			atomic_inc(&sh->count);
-		}
-	} while (sh == NULL);
+		init_stripe(sh, sector, previous);
+		atomic_inc(&sh->count);
+		goto out;
+	}
 
+	if (!test_bit(R5_DID_ALLOC, &conf->cache_state))
+		set_bit(R5_ALLOC_MORE, &conf->cache_state);
+
+wait_for_stripe:
+	if (noblock)
+		goto out;
+
+	r5c_check_stripe_cache_usage(conf);
+	set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
+	r5l_wake_reclaim(conf->log, 0);
+	wait_event_lock_irq(conf->wait_for_stripe,
+			    !list_empty(conf->inactive_list + hash) &&
+			    (atomic_read(&conf->active_stripes)
+				  < (conf->max_nr_stripes * 3 / 4)
+				 || !test_bit(R5_INACTIVE_BLOCKED,
+					      &conf->cache_state)),
+			    *(conf->hash_locks + hash));
+	clear_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
+	goto retry;
+
+out:
 	spin_unlock_irq(conf->hash_locks + hash);
 	return sh;
 }
-- 
2.30.2

