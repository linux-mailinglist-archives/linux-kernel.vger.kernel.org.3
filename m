Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9A53523D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiEZQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348154AbiEZQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC1E3B3C0;
        Thu, 26 May 2022 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=QyHrnH5ZuXktkhsga6G9I5lk9psWpw8ft+8WQu8yre4=; b=SGF2gA9OrU3pLiVsW/FZQRJago
        JPn8NFyCFlLAhhLSKCOPdFrg+2ZaD62MRS8+Mf9euTicQJDdWT9fumN5CZKBSF8RLATO+lO2E6J/V
        V5cTyn7QfpB4D7WjTB6N0oqR6POltT3STWuv6HzCW9EULMGkw+d2pyTiWrH3bKl0ENN9qtykN0NM8
        QRab/EX5hzeTDzY8NKGBzzEalOOVBOjjXjLUbxt78ClUplEnU6Hyshrzi29hdd0uI74ibJID2iy2p
        eyj7CRN9xEXhznyhD/oYRd92gXQ4pfXUKk9dGKab4aCPp8RXp1ZD2pAl9kQeFSeHglqx8fonrU94h
        AduRxbpA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTF-008A7R-Rs; Thu, 26 May 2022 10:36:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGT9-0008Xf-VQ; Thu, 26 May 2022 10:36:16 -0600
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
Date:   Thu, 26 May 2022 10:35:58 -0600
Message-Id: <20220526163604.32736-12-logang@deltatee.com>
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
Subject: [PATCH v2 11/17] md/raid5: Ensure array is suspended for calls to log_exit()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raid5-cache code relies on there being no IO in flight when
log_exit() is called. There are two places where this is not
guaranteed so add mddev_suspend() and mddev_resume() calls to these
sites.

The site in raid5_remove_disk() has a comment saying that it is
called in raid5d and thus cannot wait for pending writes; however that
does not appear to be correct anymore (if it ever was) as
raid5_remove_disk() is called from hot_remove_disk() which only
appears to be called in the md_ioctl(). Thus, the comment is removed,
as well as the racy check and replaced with calls to suspend/resume.

The site in raid5_change_consistency_policy() is in the error path,
and another similar call site already has suspend/resume calls just
below it; so it should be equally safe to make that change here.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0d486f8aaf87..4b25a0262cb5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7938,18 +7938,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 
 	print_raid5_conf(conf);
 	if (test_bit(Journal, &rdev->flags) && conf->log) {
-		/*
-		 * we can't wait pending write here, as this is called in
-		 * raid5d, wait will deadlock.
-		 * neilb: there is no locking about new writes here,
-		 * so this cannot be safe.
-		 */
-		if (atomic_read(&conf->active_stripes) ||
-		    atomic_read(&conf->r5c_cached_full_stripes) ||
-		    atomic_read(&conf->r5c_cached_partial_stripes)) {
-			return -EBUSY;
-		}
+		mddev_suspend(mddev);
 		log_exit(conf);
+		mddev_resume(mddev);
 		return 0;
 	}
 	if (rdev == rcu_access_pointer(p->rdev))
@@ -8697,8 +8688,11 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
 			err = log_init(conf, NULL, true);
 			if (!err) {
 				err = resize_stripes(conf, conf->pool_size);
-				if (err)
+				if (err) {
+					mddev_suspend(mddev);
 					log_exit(conf);
+					mddev_resume(mddev);
+				}
 			}
 		} else
 			err = -EINVAL;
-- 
2.30.2

