Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D58535230
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbiEZQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348147AbiEZQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:23 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8D34C7AA;
        Thu, 26 May 2022 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=/WD2ehsnnbCNIuVIODA1HdN2V1ZCmC9syKI4aXJHfpQ=; b=KapnB+8SWlmnlWl89nEjcyvn7M
        VI5+n1DSCnhWLcUSdtGIvXIBi6A72nhIXHMV/WkKTM5w00AvPxuY+TMaydl737990T4R/Eg0QFF6X
        K5Z5bHpIwqzcEq5eaZg/D1YOaElz8K+zyo0HoLqfZCtZY/9ngzjn6w4o6Cy2e9g1sApnPjcq5l0Ip
        fE1eNHwBEbrnnvEFM89tYIjw7y/knRzJphEo/q4bxjCHg22qCgeFBpxrdRLHdD5xiZrXOMmv1po9n
        mr4M+3F1CPd0Q9z2H3U3DB+VdF3J8Hww31B2/or5RfcHu3R1DDlNLRg8fYqcEz5WOFVNaocygwNe9
        IWPq+hZA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTF-008A7R-1W; Thu, 26 May 2022 10:36:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTA-0008Xr-Lo; Thu, 26 May 2022 10:36:16 -0600
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
Date:   Thu, 26 May 2022 10:36:01 -0600
Message-Id: <20220526163604.32736-15-logang@deltatee.com>
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
Subject: [PATCH v2 14/17] md/raid5-cache: Annotate pslot with __rcu notation
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radix_tree_lookup_slot() and radix_tree_replace_slot() API expect the
slot returned and looked up to be marked with __rcu. Otherwise
sparse warnings are generated:

  drivers/md/raid5-cache.c:2939:23: warning: incorrect type in
			assignment (different address spaces)
  drivers/md/raid5-cache.c:2939:23:    expected void **pslot
  drivers/md/raid5-cache.c:2939:23:    got void [noderef] __rcu **

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 7c56ee977c3a..5ddfe29bc26a 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2609,7 +2609,7 @@ int r5c_try_caching_write(struct r5conf *conf,
 	int i;
 	struct r5dev *dev;
 	int to_cache = 0;
-	void **pslot;
+	void __rcu **pslot;
 	sector_t tree_index;
 	int ret;
 	uintptr_t refcount;
@@ -2776,7 +2776,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 	int i;
 	int do_wakeup = 0;
 	sector_t tree_index;
-	void **pslot;
+	void __rcu **pslot;
 	uintptr_t refcount;
 
 	if (!log || !test_bit(R5_InJournal, &sh->dev[sh->pd_idx].flags))
-- 
2.30.2

