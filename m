Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48915438EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiFHQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbiFHQ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:08 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB01FE8C2;
        Wed,  8 Jun 2022 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=MiCPhTWWfi3d1Han0tZIW/P4zdztR1K7Ax/z77ioJXs=; b=Ikr+r7qGi3R7CGGV5QudeUQyj0
        aiv3j6f0hDZssW68VZ/cb6ff7X4zqa2lnU1P+3qfx4lGOH4BywiZhQs7OiG4yDtKyFjKihYkYyiUN
        Ho4RbMKkl7e9BNNC96dAFz22E6WZBElOc5vhehSGMQEaLnJwyXtReKHDCiaQQ/D93prb8UYizX5IH
        3cHoYn/f5NFmTJ+5nkZoaHkA5KyoOgkgiLEPxvyxxSxeB5PtiltCfgGuzni+02Y813BTT1JRGPZ39
        wOA/GkPP6NJ2Am5Bmbhe9S1UJj8LaE4I5efueiePh3kaLME5hv/6e09rNuKnT3iPbGV6szqw/2juV
        H97nIw3Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXN-0026n5-Ft; Wed, 08 Jun 2022 10:28:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXG-000bdS-Pt; Wed, 08 Jun 2022 10:27:59 -0600
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
Date:   Wed,  8 Jun 2022 10:27:50 -0600
Message-Id: <20220608162756.144600-6-logang@deltatee.com>
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
Subject: [PATCH v4 05/11] md/raid5-cache: Take mddev_lock in r5c_journal_mode_show()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mddev->lock spinlock doesn't protect against the removal of
conf->log in r5l_exit_log() so conf->log may be freed before it
is used.

To fix this, take the mddev_lock() insteaad of the mddev->lock spinlock.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 83c184eddbda..ca8fc317da95 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2534,12 +2534,13 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 	struct r5conf *conf;
 	int ret;
 
-	spin_lock(&mddev->lock);
+	ret = mddev_lock(mddev);
+	if (ret)
+		return ret;
+
 	conf = mddev->private;
-	if (!conf || !conf->log) {
-		spin_unlock(&mddev->lock);
-		return 0;
-	}
+	if (!conf || !conf->log)
+		goto out_unlock;
 
 	switch (conf->log->r5c_journal_mode) {
 	case R5C_JOURNAL_MODE_WRITE_THROUGH:
@@ -2557,7 +2558,9 @@ static ssize_t r5c_journal_mode_show(struct mddev *mddev, char *page)
 	default:
 		ret = 0;
 	}
-	spin_unlock(&mddev->lock);
+
+out_unlock:
+	mddev_unlock(mddev);
 	return ret;
 }
 
-- 
2.30.2

