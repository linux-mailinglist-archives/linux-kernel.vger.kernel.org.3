Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A185834B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiG0VJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiG0VIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:08:38 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DA8664E8;
        Wed, 27 Jul 2022 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=X02B8Yte5mrHvbzJA1C8/u0TiqFcT/7kiaDoAehrDmE=; b=HfWyIa/RTtuECHabDqoiD/3dy8
        sOFQtL1ukve4az5RriUk4fUedKiBCHtWztTwmnlGIoPiZc5JKdPZfSZNzcDHn6wnbmMbH2ldVgX66
        HsLRrU0C6OVDb49K6lR8p4dJrptlglXtcc39TKdZg9Xi34nsX8xNSun5LfgMYO+mLhZkihuTK26Ne
        fehu9EV+P3+fnb3p2kKwnY7+uq3nZC5eHscYytDNwYAdJSPXqnqM9c9moxv9uoeTU5PjiQ05N8pZY
        PrMZ54eFJgRhGk4W7VsnqCldGMV8mtpPF48eOBbdBt/XeUFpOy/XaJcWBnPlrNdQUn0FVL6fV53ZO
        d2+9pEUA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEG-001pyF-GI; Wed, 27 Jul 2022 15:06:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oGoEE-000VI3-UZ; Wed, 27 Jul 2022 15:06:02 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>
Date:   Wed, 27 Jul 2022 15:05:58 -0600
Message-Id: <20220727210600.120221-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220727210600.120221-1-logang@deltatee.com>
References: <20220727210600.120221-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, logang@deltatee.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, martin.oliveira@eideticom.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 3/5] md/raid5: Drop unnecessary call to r5c_check_stripe_cache_usage()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that raid5_get_active_stripe() has been refactored it is appearant
that r5c_check_stripe_cache_usage() doesn't need to be called in
the wait_for_stripe branch.

r5c_check_stripe_cache_usage() will only conditionally call
r5l_wake_reclaim(), but that function is called two lines later.

Drop the call for cleanup.

Reported-by: Martin Oliveira <martin.oliveira@eideticom.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e7e02a979670..e09fa55960cc 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -810,7 +810,6 @@ raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
 	if (noblock)
 		goto out;
 
-	r5c_check_stripe_cache_usage(conf);
 	set_bit(R5_INACTIVE_BLOCKED, &conf->cache_state);
 	r5l_wake_reclaim(conf->log, 0);
 	wait_event_lock_irq(conf->wait_for_stripe,
-- 
2.30.2

