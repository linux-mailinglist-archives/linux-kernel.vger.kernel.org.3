Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC58352DD90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbiESTOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244380AbiESTNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:41 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB44AFAE6;
        Thu, 19 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=vTNpCK9VH4FT14otqpB35kroOHgecD5A4kscpWltdTo=; b=RmQ8WSWWwk0rvMUQNhaTIJXbEa
        xEboSGo6/lWHDEvcPXTgjCtC1JmNkQuqpr+kGoj5h46pECUmqh3THPqLnXSxmiyo3jP6a/gK/9F7g
        xyfYMyGRllspPu1U2If8vd/pKR5+u7rhlhwTZnIIHGoAm4walPF5ETeIh2zgdX/kysXuoxDjXap1Y
        mmWtG/nHLfilZJITegHzDJyU20UURl2pfaJ9vNSZ4FqTJf2f5arQGcUBaDOd4rg+bzs8cxAH3OUPB
        AZp5zvOhpZoOGroxkonAkT6iL3QdNES8ogUhdcfoZ4ENSuWJvPCSdVRK4ptzsflgIIqxmeAkFS+Fp
        hpb/B65w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaJ-002TqU-8B; Thu, 19 May 2022 13:13:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaE-0004Td-O5; Thu, 19 May 2022 13:13:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:13:05 -0600
Message-Id: <20220519191311.17119-10-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220519191311.17119-1-logang@deltatee.com>
References: <20220519191311.17119-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 09/15] md/raid5-cache: Don't pass conf to r5c_calculate_new_cp()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r5c_calculate_new_cp() only uses conf to dereference the log which
both callers already have a pointer to and no longer need to
obtain a conf through a complicated dereference chain for this use.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index f7d013479a68..0ecff63202f8 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1166,10 +1166,9 @@ static void r5l_run_no_space_stripes(struct r5l_log *log)
  * for write through mode, returns log->next_checkpoint
  * for write back, returns log_start of first sh in stripe_in_journal_list
  */
-static sector_t r5c_calculate_new_cp(struct r5conf *conf)
+static sector_t r5c_calculate_new_cp(struct r5l_log *log)
 {
 	struct stripe_head *sh;
-	struct r5l_log *log = conf->log;
 	sector_t new_cp;
 	unsigned long flags;
 
@@ -1177,12 +1176,12 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
 		return log->next_checkpoint;
 
 	spin_lock_irqsave(&log->stripe_in_journal_lock, flags);
-	if (list_empty(&conf->log->stripe_in_journal_list)) {
+	if (list_empty(&log->stripe_in_journal_list)) {
 		/* all stripes flushed */
 		spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
 		return log->next_checkpoint;
 	}
-	sh = list_first_entry(&conf->log->stripe_in_journal_list,
+	sh = list_first_entry(&log->stripe_in_journal_list,
 			      struct stripe_head, r5c);
 	new_cp = sh->log_start;
 	spin_unlock_irqrestore(&log->stripe_in_journal_lock, flags);
@@ -1191,10 +1190,8 @@ static sector_t r5c_calculate_new_cp(struct r5conf *conf)
 
 static sector_t r5l_reclaimable_space(struct r5l_log *log)
 {
-	struct r5conf *conf = log->rdev->mddev->private;
-
 	return r5l_ring_distance(log, log->last_checkpoint,
-				 r5c_calculate_new_cp(conf));
+				 r5c_calculate_new_cp(log));
 }
 
 static void r5l_run_no_mem_stripe(struct r5l_log *log)
@@ -1515,7 +1512,6 @@ static void r5c_do_reclaim(struct r5conf *conf)
 
 static void r5l_do_reclaim(struct r5l_log *log)
 {
-	struct r5conf *conf = log->rdev->mddev->private;
 	sector_t reclaim_target = xchg(&log->reclaim_target, 0);
 	sector_t reclaimable;
 	sector_t next_checkpoint;
@@ -1544,7 +1540,7 @@ static void r5l_do_reclaim(struct r5l_log *log)
 				    log->io_list_lock);
 	}
 
-	next_checkpoint = r5c_calculate_new_cp(conf);
+	next_checkpoint = r5c_calculate_new_cp(log);
 	spin_unlock_irq(&log->io_list_lock);
 
 	if (reclaimable == 0 || !write_super)
-- 
2.30.2

