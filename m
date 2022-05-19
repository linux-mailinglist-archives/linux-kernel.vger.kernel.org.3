Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCAF52DD87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiESTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244359AbiESTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:32 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1947AFAED;
        Thu, 19 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=DRCQ7jkTEXAxi00P1wDBuXPsBq4R7e4xvI9iMn5bbys=; b=nfyb9mLWnvWJcMQC/1GZEFY5WB
        FWBk6feeLzF6+K5QASLBltjwhDCkGL77z8IOht107q41gGCwIk3RnMNbdsye2ytrdBweWRmKTkIn0
        IsmqFDxC1J/4BqURk3ZdKwORXX98PNbsYT9+Uq4K+ZUJaBjnbnn0cVye0kheJOKVD4U8f2iSPym20
        Zgnh4pbbTnc4803wOJQE1bD38P0T/nfrUo8zN6OQpLyOLaC2jjrM+DTrxrZ8Ik7UBCPnqProCE7BL
        lBFh/dz0GvbRYXo3O7lroQhYdbtG8lhp0YBZC65hn95DL4FBXcRIBA9wSkK+SbWat5u+HWzyiBhYa
        xEovFL4w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaJ-002TqQ-5W; Thu, 19 May 2022 13:13:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaE-0004Th-Up; Thu, 19 May 2022 13:13:15 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:13:06 -0600
Message-Id: <20220519191311.17119-11-logang@deltatee.com>
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
Subject: [PATCH v1 10/15] md/raid5-cache: Take struct r5l_log in r5c_log_required_to_flush_cache()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only call site of r5c_log_required_to_flush_cache() already has
a log pointer and has already checked that it is writeback. So the
derference and writeback check is redundant. Just pass the log pointer.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0ecff63202f8..f7b402138d16 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -411,13 +411,9 @@ void r5c_check_cached_full_stripe(struct r5conf *conf)
  *     (stripe_in_journal_count) * (max_degraded + 1) +
  *     (group_cnt + 1) * (raid_disks - max_degraded)
  */
-static sector_t r5c_log_required_to_flush_cache(struct r5conf *conf)
+static sector_t r5c_log_required_to_flush_cache(struct r5conf *conf,
+						struct r5l_log *log)
 {
-	struct r5l_log *log = conf->log;
-
-	if (!r5c_is_writeback(conf))
-		return 0;
-
 	return BLOCK_SECTORS *
 		((conf->max_degraded + 1) * atomic_read(&log->stripe_in_journal_count) +
 		 (conf->raid_disks - conf->max_degraded) * (conf->group_cnt + 1));
@@ -442,7 +438,7 @@ static inline void r5c_update_log_state(struct r5l_log *log)
 
 	free_space = r5l_ring_distance(log, log->log_start,
 				       log->last_checkpoint);
-	reclaim_space = r5c_log_required_to_flush_cache(conf);
+	reclaim_space = r5c_log_required_to_flush_cache(conf, log);
 	if (free_space < 2 * reclaim_space)
 		set_bit(R5C_LOG_CRITICAL, &conf->cache_state);
 	else {
-- 
2.30.2

