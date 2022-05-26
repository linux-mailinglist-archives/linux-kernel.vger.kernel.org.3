Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9CC535233
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbiEZQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348185AbiEZQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:37 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E344F471;
        Thu, 26 May 2022 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Vtrw1h6V0YuxVxDvHliU2zCW8YmoFTF3FBe7fyBj6JM=; b=NTsJ0mYQB0JcH8HNTkanYMfwYP
        hJyPSo4rfmQQUN+DBDPoBysTmJiMT5LvYJaUYl3GzUS3bVDyRRb9IcloHOe9G+6xFONsxMQb66cRB
        LWJRB8oKr1/o7rUWEAUIZpAfZW2KIpiCi05dGjSa5qE4BOksd9LGInH1liVaGWZf+toVdblV6YEDU
        Tuk8HAhYeNM6utTM81CW2/2mIsgas5vXyuIUjosm3ahdY6zvPzXXD9A0uluFXZMA47U/cqNTtP6zJ
        uKsENqw6ZeDlxr78mJlsijdZnSrk6ybq5xKuFFrP64xmdCIj2nU2+pN5PbyDlDigSSlDMI2baqEUT
        QFnOsdQA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTG-008A7W-T5; Thu, 26 May 2022 10:36:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGT8-0008XO-Ul; Thu, 26 May 2022 10:36:15 -0600
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
Date:   Thu, 26 May 2022 10:35:54 -0600
Message-Id: <20220526163604.32736-8-logang@deltatee.com>
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
Subject: [PATCH v2 07/17] md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppl_handle_flush_request() takes an struct r5log argument but doesn't
use it. It has no buisiness taking this argument as it is only used
by raid5-cache and has no way to derference it anyway. Remove
the argument.

No functional changes intended.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-log.h | 4 ++--
 drivers/md/raid5-ppl.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index e39db84c5de0..1c184fe20939 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -41,7 +41,7 @@ void ppl_write_stripe_run(struct r5conf *conf);
 void ppl_stripe_write_finished(struct stripe_head *sh);
 int ppl_modify_log(struct r5conf *conf, struct md_rdev *rdev, bool add);
 void ppl_quiesce(struct r5conf *conf, int quiesce);
-int ppl_handle_flush_request(struct r5l_log *log, struct bio *bio);
+int ppl_handle_flush_request(struct bio *bio);
 extern struct md_sysfs_entry ppl_write_hint;
 
 static inline bool raid5_has_log(struct r5conf *conf)
@@ -108,7 +108,7 @@ static inline int log_handle_flush_request(struct r5conf *conf, struct bio *bio)
 	if (conf->log)
 		ret = r5l_handle_flush_request(conf, bio);
 	else if (raid5_has_ppl(conf))
-		ret = ppl_handle_flush_request(conf->log, bio);
+		ret = ppl_handle_flush_request(bio);
 
 	return ret;
 }
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 973e2e06f19c..4f5bdb4cad2b 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -679,7 +679,7 @@ void ppl_quiesce(struct r5conf *conf, int quiesce)
 	}
 }
 
-int ppl_handle_flush_request(struct r5l_log *log, struct bio *bio)
+int ppl_handle_flush_request(struct bio *bio)
 {
 	if (bio->bi_iter.bi_size == 0) {
 		bio_endio(bio);
-- 
2.30.2

