Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A933552DD74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiESTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243667AbiESTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:20 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C4AF1C3;
        Thu, 19 May 2022 12:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=dSu96yR6ZugLzOhfDKsQwl8s7vH3k/NFK97qtP5EIkM=; b=tCY6LC/sF1/Y319c0bypRuDxmy
        S59l0y5uEbuPdEmuUqfLSZO2vo2rr8aU4aX4iNrWZhNjp6vJ22W/PeRAvR+alQL+jc2ykkGOWJjtz
        kOX+4f9Tq8mPFPiJTSTXyhWCMHkH+5XEW5IeQYzpJ4diN4mT1pzws9xZ+rPPbwxiTliVdjwDpfie+
        NpWv2ov0LlEB1S0IJzYY+OrPmvi452XFD8IUHytZpV8dG5CYTGW0SX10/4/Y9yY0EB/thZwzqfu+Z
        NLHWdWCEnWKrVQM1oQOYvikOipQKKAYd5VPeX7N5OvNblISySj0U9TqmY6J73dFjtCYpsOSNAbA8o
        DR2QM+oA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaF-002TqU-7D; Thu, 19 May 2022 13:13:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaD-0004TL-OW; Thu, 19 May 2022 13:13:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:13:00 -0600
Message-Id: <20220519191311.17119-5-logang@deltatee.com>
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
Subject: [PATCH v1 04/15] md/raid5-cache: Refactor r5l_flush_stripe_to_raid() to take a struct r5conf
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All calls to r5l_flush_stripe_to_raid() have to dereference conf to
get the log. The log pointer should be protected by RCU, but isn't. Push
the dereference of conf->log into r5l_flush_stripe_to_raid() to reduce
the number of sites that dereference conf->log so this can be improved.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 3 ++-
 drivers/md/raid5-log.h   | 4 ++--
 drivers/md/raid5.c       | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0049c4f45e9c..6db8040fb01b 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1287,8 +1287,9 @@ static void r5l_log_flush_endio(struct bio *bio)
  * only write stripes of an io_unit to raid disks till the io_unit is the first
  * one whose data/parity is in log.
  */
-void r5l_flush_stripe_to_raid(struct r5l_log *log)
+void r5l_flush_stripe_to_raid(struct r5conf *conf)
 {
+	struct r5l_log *log = conf->log;
 	bool do_flush;
 
 	if (!log || !log->need_cache_flush)
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index c6f877df4f3e..ead541075528 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -6,7 +6,7 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev);
 void r5l_exit_log(struct r5conf *conf);
 int r5l_write_stripe(struct r5l_log *log, struct stripe_head *head_sh);
 void r5l_write_stripe_run(struct r5l_log *log);
-void r5l_flush_stripe_to_raid(struct r5l_log *log);
+void r5l_flush_stripe_to_raid(struct r5conf *conf);
 void r5l_stripe_write_finished(struct stripe_head *sh);
 int r5l_handle_flush_request(struct r5l_log *log, struct bio *bio);
 void r5l_quiesce(struct r5l_log *log, int quiesce);
@@ -96,7 +96,7 @@ static inline void log_write_stripe_run(struct r5conf *conf)
 static inline void log_flush_stripe_to_raid(struct r5conf *conf)
 {
 	if (conf->log)
-		r5l_flush_stripe_to_raid(conf->log);
+		r5l_flush_stripe_to_raid(conf);
 	else if (raid5_has_ppl(conf))
 		ppl_write_stripe_run(conf);
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 355760f34cb6..436be2a42cc1 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6427,7 +6427,7 @@ static int handle_active_stripes(struct r5conf *conf, int group,
 	release_inactive_stripe_list(conf, temp_inactive_list,
 				     NR_STRIPE_HASH_LOCKS);
 
-	r5l_flush_stripe_to_raid(conf->log);
+	r5l_flush_stripe_to_raid(conf);
 	if (release_inactive) {
 		spin_lock_irq(&conf->device_lock);
 		return 0;
@@ -6483,7 +6483,7 @@ static void raid5_do_work(struct work_struct *work)
 
 	flush_deferred_bios(conf);
 
-	r5l_flush_stripe_to_raid(conf->log);
+	r5l_flush_stripe_to_raid(conf);
 
 	async_tx_issue_pending_all();
 	blk_finish_plug(&plug);
@@ -6570,7 +6570,7 @@ static void raid5d(struct md_thread *thread)
 
 	flush_deferred_bios(conf);
 
-	r5l_flush_stripe_to_raid(conf->log);
+	r5l_flush_stripe_to_raid(conf);
 
 	async_tx_issue_pending_all();
 	blk_finish_plug(&plug);
-- 
2.30.2

