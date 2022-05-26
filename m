Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960F535239
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiEZQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348192AbiEZQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:37 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA694FC5D;
        Thu, 26 May 2022 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=rT5G8qxq1d10C0jx/Qw/01z/duQzbK3ZzkhAFxNw4j4=; b=j7sD+dEOmb6nZOW+8VnttqLZAl
        OcE3FwlRX6FC1LFGbzUX4Xh43gqGyzcMio1PBXhC5T3ITchUJM1JUfQBnIuPXZkB2funUTavAQqnv
        206hHNGPz7AH9YGAz3Pc3vP3+JDxZVGmBXfTOZJqey6shjSFnbw3PBwC4eAm2en5WWkhcSMwTyEfC
        V3XfQx0+VvtlwXSOCNp1UwAEaf0v4rOBbfMgSpUHfjl8Rywc1o3jEJ5hAt3ShaMRFzCnrVdCqNXkO
        BgVBz4BL7TwdDQRCsEgMN9odrDI1YaEe88jBoVAc5l2W/MsxGNOiyBsWnBv+oKBWR+E/70O28GUl1
        w8gTv+Hw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTG-008A7T-Sf; Thu, 26 May 2022 10:36:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGT8-0008XL-P6; Thu, 26 May 2022 10:36:14 -0600
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
Date:   Thu, 26 May 2022 10:35:53 -0600
Message-Id: <20220526163604.32736-7-logang@deltatee.com>
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
Subject: [PATCH v2 06/17] md/raid5-cache: Refactor remaining functions to take a r5conf
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the interface functions dereference conf->log in inline
helpers in raid5-log.h. Refactor all off these to dereference
conf->log inside the function instead. This will help to fix the
rcu locking when accessing conf->log.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 18 +++++++++++-------
 drivers/md/raid5-log.h   | 20 ++++++++++----------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 3427f95cb358..24110b687055 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1006,9 +1006,9 @@ static inline void r5l_add_no_space_stripe(struct r5l_log *log,
  * running in raid5d, where reclaim could wait for raid5d too (when it flushes
  * data from log to raid disks), so we shouldn't wait for reclaim here
  */
-int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
+int r5l_write_stripe(struct r5conf *conf, struct stripe_head *sh)
 {
-	struct r5conf *conf = sh->raid_conf;
+	struct r5l_log *log = conf->log;
 	int write_disks = 0;
 	int data_pages, parity_pages;
 	int reserve;
@@ -1104,8 +1104,9 @@ int r5l_write_stripe(struct r5l_log *log, struct stripe_head *sh)
 	return 0;
 }
 
-void r5l_write_stripe_run(struct r5l_log *log)
+void r5l_write_stripe_run(struct r5conf *conf)
 {
+	struct r5l_log *log = conf->log;
 	if (!log)
 		return;
 	mutex_lock(&log->io_mutex);
@@ -1113,8 +1114,10 @@ void r5l_write_stripe_run(struct r5l_log *log)
 	mutex_unlock(&log->io_mutex);
 }
 
-int r5l_handle_flush_request(struct r5l_log *log, struct bio *bio)
+int r5l_handle_flush_request(struct r5conf *conf, struct bio *bio)
 {
+	struct r5l_log *log = conf->log;
+
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH) {
 		/*
 		 * in write through (journal only)
@@ -1582,8 +1585,9 @@ void r5l_wake_reclaim(struct r5conf *conf, sector_t space)
 	__r5l_wake_reclaim(conf->log, space);
 }
 
-void r5l_quiesce(struct r5l_log *log, int quiesce)
+void r5l_quiesce(struct r5conf *conf, int quiesce)
 {
+	struct r5l_log *log = conf->log;
 	struct mddev *mddev;
 
 	if (quiesce) {
@@ -2892,9 +2896,9 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 		set_bit(STRIPE_HANDLE, &sh->state);
 }
 
-int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh)
+int r5c_cache_data(struct r5conf *conf, struct stripe_head *sh)
 {
-	struct r5conf *conf = sh->raid_conf;
+	struct r5l_log *log = conf->log;
 	int pages = 0;
 	int reserve;
 	int i;
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 7594d2d80520..e39db84c5de0 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -4,12 +4,12 @@
 
 int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev);
 void r5l_exit_log(struct r5conf *conf);
-int r5l_write_stripe(struct r5l_log *log, struct stripe_head *head_sh);
-void r5l_write_stripe_run(struct r5l_log *log);
+int r5l_write_stripe(struct r5conf *conf, struct stripe_head *head_sh);
+void r5l_write_stripe_run(struct r5conf *conf);
 void r5l_flush_stripe_to_raid(struct r5conf *conf);
 void r5l_stripe_write_finished(struct stripe_head *sh);
-int r5l_handle_flush_request(struct r5l_log *log, struct bio *bio);
-void r5l_quiesce(struct r5l_log *log, int quiesce);
+int r5l_handle_flush_request(struct r5conf *conf, struct bio *bio);
+void r5l_quiesce(struct r5conf *conf, int quiesce);
 bool r5l_log_disk_error(struct r5conf *conf);
 bool r5c_conf_is_writeback(struct r5conf *conf);
 int r5c_try_caching_write(struct r5conf *conf, struct stripe_head *sh,
@@ -21,7 +21,7 @@ void r5c_use_extra_page(struct stripe_head *sh);
 void r5l_wake_reclaim(struct r5conf *conf, sector_t space);
 void r5c_handle_cached_data_endio(struct r5conf *conf,
 				  struct stripe_head *sh, int disks);
-int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh);
+int r5c_cache_data(struct r5conf *conf, struct stripe_head *sh);
 void r5c_make_stripe_write_out(struct stripe_head *sh);
 void r5c_flush_cache(struct r5conf *conf, int num);
 void r5c_check_stripe_cache_usage(struct r5conf *conf);
@@ -63,10 +63,10 @@ static inline int log_stripe(struct stripe_head *sh, struct stripe_head_state *s
 			/* writing out phase */
 			if (s->waiting_extra_page)
 				return 0;
-			return r5l_write_stripe(conf->log, sh);
+			return r5l_write_stripe(conf, sh);
 		} else if (test_bit(STRIPE_LOG_TRAPPED, &sh->state)) {
 			/* caching phase */
-			return r5c_cache_data(conf->log, sh);
+			return r5c_cache_data(conf, sh);
 		}
 	} else if (raid5_has_ppl(conf)) {
 		return ppl_write_stripe(conf, sh);
@@ -88,7 +88,7 @@ static inline void log_stripe_write_finished(struct stripe_head *sh)
 static inline void log_write_stripe_run(struct r5conf *conf)
 {
 	if (conf->log)
-		r5l_write_stripe_run(conf->log);
+		r5l_write_stripe_run(conf);
 	else if (raid5_has_ppl(conf))
 		ppl_write_stripe_run(conf);
 }
@@ -106,7 +106,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
 	int ret = -ENODEV;
 
 	if (conf->log)
-		ret = r5l_handle_flush_request(conf->log, bio);
+		ret = r5l_handle_flush_request(conf, bio);
 	else if (raid5_has_ppl(conf))
 		ret = ppl_handle_flush_request(conf->log, bio);
 
@@ -116,7 +116,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
 static inline void log_quiesce(struct r5conf *conf, int quiesce)
 {
 	if (conf->log)
-		r5l_quiesce(conf->log, quiesce);
+		r5l_quiesce(conf, quiesce);
 	else if (raid5_has_ppl(conf))
 		ppl_quiesce(conf, quiesce);
 }
-- 
2.30.2

