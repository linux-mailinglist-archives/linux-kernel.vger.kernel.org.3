Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ECC543901
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbiFHQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245176AbiFHQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:08 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32841FE4FF;
        Wed,  8 Jun 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=h96dBIKEAm/DsfIwdPq6LxyO+XAba9V5/jkC7qhftCQ=; b=svRIwObpXGVgaFkKi8XlFSQCMa
        Im7WRRlOb5pZtuN+RiJ3U5q5lABEijSvZ+EbE+Csp9VWXGZofjeAG3WJchdfP3a2sDXUQ2jrzAFVi
        CiDACUlFxslzMuioYJQxhf9FpkJNOjwvEMrBofb0V2zeJk0Vs3vduAp6ot2gDIrYDL/lOxxXEiolT
        shTb03osbhliuKnjvVQHbw+x3NIUumXedediRQuyU8N1JX7qYLe0YQ69J4hA7sM7hFPbnCYHm9XcI
        zh+RqmmxHRdt7a63wRNArUjscQgss1dTt9A0AyGHnO+5Q1IKXa/qcJCeyNyHIDh5+J0qnakhGgAJe
        9BbnlHbw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXN-0026n9-0T; Wed, 08 Jun 2022 10:28:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXH-000bdV-3L; Wed, 08 Jun 2022 10:27:59 -0600
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
Date:   Wed,  8 Jun 2022 10:27:51 -0600
Message-Id: <20220608162756.144600-7-logang@deltatee.com>
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
Subject: [PATCH v4 06/11] md/raid5-cache: Drop RCU usage of conf->log
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index ca8fc317da95..b1fc65e113f8 100644
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
@@ -3171,7 +3166,6 @@ void r5l_exit_log(struct r5conf *conf)
 	struct r5l_log *log = conf->log;
 
 	conf->log = NULL;
-	synchronize_rcu();
 
 	/* Ensure disable_writeback_work wakes up and exits */
 	wake_up(&conf->mddev->sb_wait);
-- 
2.30.2

