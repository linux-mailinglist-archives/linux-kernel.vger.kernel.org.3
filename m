Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C05438FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245576AbiFHQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245143AbiFHQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:28:07 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E201FD9C9;
        Wed,  8 Jun 2022 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=6Vkeh6rAlHW/X/6dpPN/qr4LppXBSj/dDsDAYd6JEKk=; b=jYNt0eAlkIQO/1/rgoGT804axE
        jlCS62BGwks0k2Vj6fYsoj/DNRh7eRcxtPSHGHDoGTG+2tyLy7yPwff0lZz4bX6m3EjF7N7wB8kDi
        BWhH5pOREGEaxbavsbD0Em9glWqZ8HRq6+g94ziDYLrqK2SIn7mRUq9tsY/G/5Zq3uPHLPwnJOx+d
        L0P7j2pP3Adx1fbypHVwga6M4g2u4O5oq6YnlJ0czsT/4Cf5Vs/w4v+l66EC2DNTJXZGXv/BpzqIe
        /yAVolXNTGkOu551/tiO2/ZxzWneF5txlx+zYavXXnaQc2mNN4T9yyP35rDc3VcFaKijXt+POF5US
        CHKBZiRQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXK-0026n8-HO; Wed, 08 Jun 2022 10:28:03 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nyyXG-000bdM-F6; Wed, 08 Jun 2022 10:27:58 -0600
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
Date:   Wed,  8 Jun 2022 10:27:48 -0600
Message-Id: <20220608162756.144600-4-logang@deltatee.com>
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
Subject: [PATCH v4 03/11] md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
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
index 270ced4f770f..c8332502669e 100644
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
 		ret = r5l_handle_flush_request(conf->log, bio);
 	else if (raid5_has_ppl(conf))
-		ret = ppl_handle_flush_request(conf->log, bio);
+		ret = ppl_handle_flush_request(bio);
 
 	return ret;
 }
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 0a2e4806b1ec..db49edec362a 100644
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

