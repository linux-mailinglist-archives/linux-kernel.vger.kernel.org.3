Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45453BDDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiFBSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237945AbiFBSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:18:36 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0904E39D;
        Thu,  2 Jun 2022 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=KPxyHl5McdIBsrZVYzmedsuwOe9Hs+sIzKMYT+CRgdg=; b=LrSxondlmjxzZxumaLp+VeRQmL
        +w29AInQ3Q5NOcs2iyjAo8P1tOCCAdrn2QglNlg7cBAfz8mUSwyE59rJwCEaj2qqdW/IpSxBdkJ69
        qBtVxXDt8alIh8LRXVDde0zJPaoajE5Q6+N2M966Oy7YZQMDJO1vOlbmGusYi7ic1L7hXqJHqh3+V
        TEcNUmWG3wNoO+32fdszC037WEzcF7Okw5gvPh1W70Z6lzq9ybdMJ/wyQOEcqOYxD5o4rLyLKozSk
        fLfK5ywNlZP4kFUNTvY8kBU3ckFYJkspm8bZlcLUF+L08srAfP2Nh0I9EmHuSaP3moj7EiUtMCTZw
        /w7aY6dQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOo-00EPmV-R8; Thu, 02 Jun 2022 12:18:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nwpOm-000DDP-52; Thu, 02 Jun 2022 12:18:20 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  2 Jun 2022 12:18:11 -0600
Message-Id: <20220602181818.50729-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602181818.50729-1-logang@deltatee.com>
References: <20220602181818.50729-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v3 05/11] md/raid5-cache: Drop RCU usage of conf->log
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only place that uses RCU to access conf->log is in
r5l_log_disk_error(). This function is mostly used in the IO path
and once with mddev_lock() held in raid5_change_consistency_policy().

It is known that the IO will be suspended before the log is freed and
r5l_log_exit() is called with the mddev_lock() held.

This should mean that conf->log can not be freed while the function is
being called, so the RCU protection is not necessary. Drop the
rcu_read_lock() as well as the synchronize_rcu() and
rcu_assign_pointer() usage.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 69b95005abca..48020d36b334 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1590,18 +1590,13 @@ void r5l_quiesce(struct r5l_log *log, int quiesce)
 
 bool r5l_log_disk_error(struct r5conf *conf)
 {
-	struct r5l_log *log;
-	bool ret;
-	/* don't allow write if journal disk is missing */
-	rcu_read_lock();
-	log = rcu_dereference(conf->log);
+	struct r5l_log *log = conf->log;
 
+	/* don't allow write if journal disk is missing */
 	if (!log)
-		ret = test_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
+		return test_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
 	else
-		ret = test_bit(Faulty, &log->rdev->flags);
-	rcu_read_unlock();
-	return ret;
+		return test_bit(Faulty, &log->rdev->flags);
 }
 
 #define R5L_RECOVERY_PAGE_POOL_SIZE 256
@@ -3148,7 +3143,7 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	spin_lock_init(&log->stripe_in_journal_lock);
 	atomic_set(&log->stripe_in_journal_count, 0);
 
-	rcu_assign_pointer(conf->log, log);
+	conf->log = log;
 
 	set_bit(MD_HAS_JOURNAL, &conf->mddev->flags);
 	return 0;
@@ -3173,7 +3168,6 @@ void r5l_exit_log(struct r5conf *conf)
 	lockdep_assert_held(&conf->mddev->reconfig_mutex);
 
 	conf->log = NULL;
-	synchronize_rcu();
 
 	/* Ensure disable_writeback_work wakes up and exits */
 	wake_up(&conf->mddev->sb_wait);
-- 
2.30.2

