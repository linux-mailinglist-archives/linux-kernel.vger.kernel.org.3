Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC253522C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348251AbiEZQgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348148AbiEZQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44624CD40;
        Thu, 26 May 2022 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=ikRjs5UJZGQWBAATZMqTcVeSb4A/Fwku2+gm6UjqWh0=; b=mYjtZSuQTpE/WrxjnvOl4Ht9Dh
        ZMTk//H6ZUgBXcsCoVQiTVjwJlDPg+ewhYZpNGNXWPl9//kyjPgwVMus/GpnbIlD6pm/7MfliKCw5
        U2oALwSH4pb4269W8BJUWPftGFfWtB+Educpt0ANyCOGz4z8JoySIxgz8GadaPTd+0gfCkriEdgwf
        Eaz7tVg1J9Qce4ZbOHOnL4FG5V8eKZ6p2BJ/TXwtO5xFL7KruG79S9euc/O3AiTT4ajIpRPES0ff9
        xlgZxFORuvg548UjE/qALVv2UAs5geTOKxC/dWpUR99PoMRYb6PzVrastUlbEJN0wAA/b0hVmm8mv
        RqHBHRqg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTD-008A7W-8b; Thu, 26 May 2022 10:36:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGT8-0008XF-EQ; Thu, 26 May 2022 10:36:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 26 May 2022 10:35:51 -0600
Message-Id: <20220526163604.32736-5-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526163604.32736-1-logang@deltatee.com>
References: <20220526163604.32736-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com, hch@lst.de
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 04/17] md/raid5-cache: Refactor r5l_flush_stripe_to_raid() to take a struct r5conf
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 3 ++-
 drivers/md/raid5-log.h   | 4 ++--
 drivers/md/raid5.c       | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 7c5dc45b1ea8..edff4e8d07dc 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1289,8 +1289,9 @@ static void r5l_log_flush_endio(struct bio *bio)
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
index db4c1262b380..5ace25d11ea4 100644
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
index 83911affcd88..f1b55495de53 100644
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

