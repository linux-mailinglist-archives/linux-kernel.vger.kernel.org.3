Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF15438FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbiFHQ21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245158AbiFHQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:07 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662961FE38D;
        Wed,  8 Jun 2022 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=IWEOZJwft2vuBCToQwiXtUQwH05rs0AR5scLKqJJLCk=; b=btAxGMSVRgHFmCK197hVXoh9Zx
        C+/uWI8QREegvfVVNcmCHa2d92iykla85OM1SDOpxJaZbJdjgvCtzUZOV2W5k0dzniDfbIy8N7mbe
        Y+t/ccp8Tlagwapin8JrzhtA0JKyrW7CvP5wDgM4SvbW9y+WKa29CuC/MDw18b+YWqEgouu2UoRvT
        MoaMUdqtcH+xhxLdRZIOOhDkADqwNdT04z3EpSAYgmV/M08hpXXeh75UELpJEJlHNLc8MUxYa4IT2
        +eZIV4ATs4CRjb2f/m26U0RihqzYtUKPMFeJX56oBmYOcKYFr2aecSNXR0lEzj2ymHkuDsCvCWVwx
        ryfDIj8Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXK-0026n7-HO; Wed, 08 Jun 2022 10:28:04 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXG-000bdJ-AH; Wed, 08 Jun 2022 10:27:58 -0600
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
Date:   Wed,  8 Jun 2022 10:27:47 -0600
Message-Id: <20220608162756.144600-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220608162756.144600-1-logang@deltatee.com>
References: <20220608162756.144600-1-logang@deltatee.com>
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
Subject: [PATCH v4 02/11] md/raid5-log: Drop extern decorators for function prototypes
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extern is not necessary and recommended against when defining prototype
functions in headers. checkpatch.pl complains about these. So remove
them.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-log.h | 75 ++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 43c714a8798c..270ced4f770f 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -2,49 +2,46 @@
 #ifndef _RAID5_LOG_H
 #define _RAID5_LOG_H
 
-extern int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev);
-extern void r5l_exit_log(struct r5conf *conf);
-extern int r5l_write_stripe(struct r5l_log *log, struct stripe_head *head_sh);
-extern void r5l_write_stripe_run(struct r5l_log *log);
-extern void r5l_flush_stripe_to_raid(struct r5l_log *log);
-extern void r5l_stripe_write_finished(struct stripe_head *sh);
-extern int r5l_handle_flush_request(struct r5l_log *log, struct bio *bio);
-extern void r5l_quiesce(struct r5l_log *log, int quiesce);
-extern bool r5l_log_disk_error(struct r5conf *conf);
-extern bool r5c_is_writeback(struct r5l_log *log);
-extern int
-r5c_try_caching_write(struct r5conf *conf, struct stripe_head *sh,
-		      struct stripe_head_state *s, int disks);
-extern void
-r5c_finish_stripe_write_out(struct r5conf *conf, struct stripe_head *sh,
-			    struct stripe_head_state *s);
-extern void r5c_release_extra_page(struct stripe_head *sh);
-extern void r5c_use_extra_page(struct stripe_head *sh);
-extern void r5l_wake_reclaim(struct r5l_log *log, sector_t space);
-extern void r5c_handle_cached_data_endio(struct r5conf *conf,
-	struct stripe_head *sh, int disks);
-extern int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh);
-extern void r5c_make_stripe_write_out(struct stripe_head *sh);
-extern void r5c_flush_cache(struct r5conf *conf, int num);
-extern void r5c_check_stripe_cache_usage(struct r5conf *conf);
-extern void r5c_check_cached_full_stripe(struct r5conf *conf);
+int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev);
+void r5l_exit_log(struct r5conf *conf);
+int r5l_write_stripe(struct r5l_log *log, struct stripe_head *head_sh);
+void r5l_write_stripe_run(struct r5l_log *log);
+void r5l_flush_stripe_to_raid(struct r5l_log *log);
+void r5l_stripe_write_finished(struct stripe_head *sh);
+int r5l_handle_flush_request(struct r5l_log *log, struct bio *bio);
+void r5l_quiesce(struct r5l_log *log, int quiesce);
+bool r5l_log_disk_error(struct r5conf *conf);
+bool r5c_is_writeback(struct r5l_log *log);
+int r5c_try_caching_write(struct r5conf *conf, struct stripe_head *sh,
+			  struct stripe_head_state *s, int disks);
+void r5c_finish_stripe_write_out(struct r5conf *conf, struct stripe_head *sh,
+				 struct stripe_head_state *s);
+void r5c_release_extra_page(struct stripe_head *sh);
+void r5c_use_extra_page(struct stripe_head *sh);
+void r5l_wake_reclaim(struct r5l_log *log, sector_t space);
+void r5c_handle_cached_data_endio(struct r5conf *conf,
+				  struct stripe_head *sh, int disks);
+int r5c_cache_data(struct r5l_log *log, struct stripe_head *sh);
+void r5c_make_stripe_write_out(struct stripe_head *sh);
+void r5c_flush_cache(struct r5conf *conf, int num);
+void r5c_check_stripe_cache_usage(struct r5conf *conf);
+void r5c_check_cached_full_stripe(struct r5conf *conf);
 extern struct md_sysfs_entry r5c_journal_mode;
-extern void r5c_update_on_rdev_error(struct mddev *mddev,
-				     struct md_rdev *rdev);
-extern bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect);
-extern int r5l_start(struct r5l_log *log);
+void r5c_update_on_rdev_error(struct mddev *mddev, struct md_rdev *rdev);
+bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect);
+int r5l_start(struct r5l_log *log);
 
-extern struct dma_async_tx_descriptor *
+struct dma_async_tx_descriptor *
 ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
 		       struct dma_async_tx_descriptor *tx);
-extern int ppl_init_log(struct r5conf *conf);
-extern void ppl_exit_log(struct r5conf *conf);
-extern int ppl_write_stripe(struct r5conf *conf, struct stripe_head *sh);
-extern void ppl_write_stripe_run(struct r5conf *conf);
-extern void ppl_stripe_write_finished(struct stripe_head *sh);
-extern int ppl_modify_log(struct r5conf *conf, struct md_rdev *rdev, bool add);
-extern void ppl_quiesce(struct r5conf *conf, int quiesce);
-extern int ppl_handle_flush_request(struct r5l_log *log, struct bio *bio);
+int ppl_init_log(struct r5conf *conf);
+void ppl_exit_log(struct r5conf *conf);
+int ppl_write_stripe(struct r5conf *conf, struct stripe_head *sh);
+void ppl_write_stripe_run(struct r5conf *conf);
+void ppl_stripe_write_finished(struct stripe_head *sh);
+int ppl_modify_log(struct r5conf *conf, struct md_rdev *rdev, bool add);
+void ppl_quiesce(struct r5conf *conf, int quiesce);
+int ppl_handle_flush_request(struct r5l_log *log, struct bio *bio);
 extern struct md_sysfs_entry ppl_write_hint;
 
 static inline bool raid5_has_log(struct r5conf *conf)
-- 
2.30.2

