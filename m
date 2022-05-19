Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAE852DD8C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiESTOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244332AbiESTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:13:25 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AE1AFAFD;
        Thu, 19 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=iGKyeE3hyk0q9jmoVwSEHBFtpjdddjD8HiW/2+TcCpo=; b=FUexMxuw0kjZzHdkmuIxFkYQnM
        kSDpO/lp1PyYqiB7qIcmWCT0vUxHaXsjzlBAByiRv3zN3mXW9YyzGQdIDLN7xof6wo78+K3o2Zxp7
        tTtaOC4uvHA5vonPw6yAN/Wv9dTJE6pUZUzm8DkZTqLniJEymv45m7SNcQZiSRnWyOZJsDWT3lC+3
        E/KuDIaHYWROJZgutD7d58tWeNgeRAuN/DvR2MGnrpdPt55K5fam/ySh9BAn8zVFPQvALxmFzGvlO
        X/4zGlSqGnGf6rgsg7/s+24qUpvRw6UUbptjdA14v1nMkLbz0k9HMf3Vac+3dUQTRq5hTNxxCqyxF
        MOQA+bfA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaJ-002TqS-53; Thu, 19 May 2022 13:13:19 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nrlaF-0004Tt-LF; Thu, 19 May 2022 13:13:15 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 19 May 2022 13:13:09 -0600
Message-Id: <20220519191311.17119-14-logang@deltatee.com>
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
Subject: [PATCH v1 13/15] md/raid5-cache: Annotate pslot with __rcu notation
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
---
 drivers/md/raid5-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 1dbc7c4b9a15..a541d17f84f6 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2683,7 +2683,7 @@ int r5c_try_caching_write(struct r5conf *conf,
 	int i;
 	struct r5dev *dev;
 	int to_cache = 0;
-	void **pslot;
+	void __rcu **pslot;
 	sector_t tree_index;
 	int ret;
 	uintptr_t refcount;
@@ -2850,7 +2850,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 	int i;
 	int do_wakeup = 0;
 	sector_t tree_index;
-	void **pslot;
+	void __rcu **pslot;
 	uintptr_t refcount;
 
 	if (!log || !test_bit(R5_InJournal, &sh->dev[sh->pd_idx].flags))
-- 
2.30.2

