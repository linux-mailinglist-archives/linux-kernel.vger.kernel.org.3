Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977AB5905B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbiHKRTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbiHKRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:18:36 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D2699B7D;
        Thu, 11 Aug 2022 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=SgHT/zfKxTbDAmqhpgq66pRNjKFLXPKimkzOnUBsB3Q=; b=CT3gsWB96MLXcXizgWnaQl7RFN
        fWcF58gHWIJ13AWjQ2tkOF3/G4DPC3pyG6Ym8twKUUh/32oRa+MWBc8WgkgoMvPUYfmQhN1ZLzHAW
        npsq3JGtpwRNmMqCcDtMLBzRykbBw7rW5NHlSLzlHO2Vi+tW3YEwM6fKi6CU7ZoTXq2qicCTvbms/
        e+su+jq8lmb4FZ4wbf06y1esQfFQMST32BuUl8Klhyr0JhPK76cNO56Bq9BnI5N6ZsOW+845C8nYY
        vygsLlqFDj1VeZvwbu2GZV8cYOA9IbaB3gV1y+vUHU71PwOusmkV7Pw9frMDwvd17alNaKS7fd+wG
        FVv5OlQw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlK-00EAyh-NK; Thu, 11 Aug 2022 11:14:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlI-000cRJ-EV; Thu, 11 Aug 2022 11:14:24 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Aug 2022 11:14:17 -0600
Message-Id: <20220811171417.147697-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811171417.147697-1-logang@deltatee.com>
References: <20220811171417.147697-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 5/5] md/raid5: Don't read ->active_stripes if it's not needed
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomic_read() is not needed in many cases so only do
the read after the first checks are done.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7e7205bb40f1..0b73eeea1b19 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -789,15 +789,14 @@ struct stripe_request_ctx {
  */
 static bool is_inactive_blocked(struct r5conf *conf, int hash)
 {
-	int active = atomic_read(&conf->active_stripes);
-
 	if (list_empty(conf->inactive_list + hash))
 		return false;
 
 	if (!test_bit(R5_INACTIVE_BLOCKED, &conf->cache_state))
 		return true;
 
-	return active < (conf->max_nr_stripes * 3 / 4);
+	return (atomic_read(&conf->active_stripes) <
+		(conf->max_nr_stripes * 3 / 4));
 }
 
 struct stripe_head *raid5_get_active_stripe(struct r5conf *conf,
-- 
2.30.2

