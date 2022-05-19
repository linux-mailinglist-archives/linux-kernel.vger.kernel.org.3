Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45C52DD85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbiESTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiESTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:25 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB439AF300;
        Thu, 19 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=/lPQYIoRU2uev649WIcZ/U8eDmQ8LvVgKqafkl+iHLg=; b=DpI6S1tAI7JENbM07q6U8cyqoq
        0OQBL5AKmwL079/P8ff0T4iYVJtaf/3UoOFrvPWfXRWUhX0cD9UUKN/h9D/oAQ7Ep/wQcuWWWSqD1
        IVk8QkQoHyqNVkmNZW/xRnYq4B5ZI5Wff4Ulpnro1SH6pFcEIeh1qLRB4g6zdlKhcGAcBFUskP/6X
        E2nmwM2VZuMT4tn6vJkv9Ofmqw2tDsbvnH1z3ajIRlx3hiuid0oTW22cnGckNGTDzsMN+ISpT59tI
        rKbrinmFq/8FVHXlBTNh6jXp6Fpz4Jq5ibXMyruQnitTaRQeCWcaQdVevs+abx1M0CargH8psgPoe
        BTSlXnjw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaJ-002TqT-CX; Thu, 19 May 2022 13:13:20 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaE-0004TY-Et; Thu, 19 May 2022 13:13:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:13:04 -0600
Message-Id: <20220519191311.17119-9-logang@deltatee.com>
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
Subject: [PATCH v1 08/15] md/raid5-cache: Pass the log through to r5c_finish_cache_stripe()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r5c_finish_cache_stripe() dereferences conf->log, which will need an
rcu_read_lock(). But that is not necessary here as the log is already
available in the call sites through other means.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index cddc2c37d2c5..f7d013479a68 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -505,10 +505,9 @@ static void r5c_handle_parity_cached(struct stripe_head *sh)
  * Setting proper flags after writing (or flushing) data and/or parity to the
  * log device. This is called from r5l_log_endio() or r5l_log_flush_endio().
  */
-static void r5c_finish_cache_stripe(struct stripe_head *sh)
+static void r5c_finish_cache_stripe(struct r5l_log *log,
+				    struct stripe_head *sh)
 {
-	struct r5l_log *log = sh->raid_conf->log;
-
 	if (log->r5c_journal_mode == R5C_JOURNAL_MODE_WRITE_THROUGH) {
 		BUG_ON(test_bit(STRIPE_R5C_CACHING, &sh->state));
 		/*
@@ -526,14 +525,14 @@ static void r5c_finish_cache_stripe(struct stripe_head *sh)
 	}
 }
 
-static void r5l_io_run_stripes(struct r5l_io_unit *io)
+static void r5l_io_run_stripes(struct r5l_log *log, struct r5l_io_unit *io)
 {
 	struct stripe_head *sh, *next;
 
 	list_for_each_entry_safe(sh, next, &io->stripe_list, log_list) {
 		list_del_init(&sh->log_list);
 
-		r5c_finish_cache_stripe(sh);
+		r5c_finish_cache_stripe(log, sh);
 
 		set_bit(STRIPE_HANDLE, &sh->state);
 		raid5_release_stripe(sh);
@@ -552,7 +551,7 @@ static void r5l_log_run_stripes(struct r5l_log *log)
 			break;
 
 		list_move_tail(&io->log_sibling, &log->finished_ios);
-		r5l_io_run_stripes(io);
+		r5l_io_run_stripes(log, io);
 	}
 }
 
@@ -1282,7 +1281,7 @@ static void r5l_log_flush_endio(struct bio *bio)
 
 	spin_lock_irqsave(&log->io_list_lock, flags);
 	list_for_each_entry(io, &log->flushing_ios, log_sibling)
-		r5l_io_run_stripes(io);
+		r5l_io_run_stripes(log, io);
 	list_splice_tail_init(&log->flushing_ios, &log->finished_ios);
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
 
-- 
2.30.2

