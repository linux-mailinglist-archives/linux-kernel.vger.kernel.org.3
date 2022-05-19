Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF3752DD7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244358AbiESTNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiESTNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:20 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7915AF1DF;
        Thu, 19 May 2022 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=j4L/XPYYEfFzXpoVRqDE1CRG3X1VA3oTznBZSlprtvg=; b=iVdrkp7aLR2IT3sgxwgx6NIcVA
        gGSI/SXySWCia4cpRosHzONucBlL4evS/MiyM7ZjzuRxwzWfAzOq77i6iOIH9KgGkQfXEgxav+fh9
        NWEAN413EQV3op1ea9Fzx/lTvhn5F80vXLQtpZgvbpPuFL2BTJqNgiuFOqSLWfN8pdpaG1qf5B+YS
        /2DKFPzebGKw1NMwebClS74OSoDuXYNqo3BQNEoMtO4kxr2liGK+VbR/0wuq1wk1HNDyPbCHhEgZs
        pMMWH4Eib/VsglnulWnNGZ4ghAVmbLEZGp2ohhaUAPTIKH0bwjdbNHInz4iytB/5S+dtGovqcnxP8
        J/ShP5uA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaF-002TqT-7E; Thu, 19 May 2022 13:13:17 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaD-0004TH-IE; Thu, 19 May 2022 13:13:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:12:59 -0600
Message-Id: <20220519191311.17119-4-logang@deltatee.com>
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
Subject: [PATCH v1 03/15] md/raid5-cache: Refactor r5l_start() to take a struct r5conf
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All calls to r5l_start() have to dereference conf to get the
log. The log pointer should be protected by RCU, but isn't. Push
the dereference of conf->log into r5l_start() to reduce
the number of sites that dereference conf->log so this can be improved.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 9 +++------
 drivers/md/raid5-log.h   | 2 +-
 drivers/md/raid5.c       | 4 ++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 241c271e836d..0049c4f45e9c 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3032,20 +3032,17 @@ static int r5l_load_log(struct r5l_log *log)
 	return ret;
 }
 
-int r5l_start(struct r5l_log *log)
+int r5l_start(struct r5conf *conf)
 {
+	struct r5l_log *log = conf->log;
 	int ret;
 
 	if (!log)
 		return 0;
 
 	ret = r5l_load_log(log);
-	if (ret) {
-		struct mddev *mddev = log->rdev->mddev;
-		struct r5conf *conf = mddev->private;
-
+	if (ret)
 		r5l_exit_log(conf);
-	}
 	return ret;
 }
 
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 8a98b5e8c04b..c6f877df4f3e 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -29,7 +29,7 @@ void r5c_check_cached_full_stripe(struct r5conf *conf);
 extern struct md_sysfs_entry r5c_journal_mode;
 void r5c_update_on_rdev_error(struct mddev *mddev, struct md_rdev *rdev);
 bool r5c_big_stripe_cached(struct r5conf *conf, sector_t sect);
-int r5l_start(struct r5l_log *log);
+int r5l_start(struct r5conf *conf);
 
 struct dma_async_tx_descriptor *
 ops_run_partial_parity(struct stripe_head *sh, struct raid5_percpu *percpu,
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index bbc0e1101d0f..355760f34cb6 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8040,7 +8040,7 @@ static int raid5_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		if (ret)
 			return ret;
 
-		ret = r5l_start(conf->log);
+		ret = r5l_start(conf);
 		if (ret)
 			return ret;
 
@@ -8743,7 +8743,7 @@ static int raid5_start(struct mddev *mddev)
 {
 	struct r5conf *conf = mddev->private;
 
-	return r5l_start(conf->log);
+	return r5l_start(conf);
 }
 
 static struct md_personality raid6_personality =
-- 
2.30.2

