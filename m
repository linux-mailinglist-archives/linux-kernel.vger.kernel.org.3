Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967945AB757
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiIBRQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiIBRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:16:18 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8BEEA8B6;
        Fri,  2 Sep 2022 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=UtIc2s5DOuFL/LiP/yVuzjVDm/kIIglMbjnjGz9/+n0=; b=PEb7B8vhw5w852popqsgrKAW+y
        /q2RnK/f7LzokRm1wXH/sZyIUlG9G/PAsR7E+DOdCEw1XYXXq1mPrBn/e9YWC6Zt55bN2n9PLKrlY
        XytEHpp/oyAFH6/e8gYhaLfOxXvTyrxGEOZqQKYENrBZvPk1eE5DwtlB/QqqzZOROpoWBJ7l8gdlr
        vNBAM19FELnj75Oud/REMqjQCrCm1X7qfGYEkEaezmJdnia0BRbbPozlLt3rAo/8iStRWW0BDB2Zo
        CCoWMBCe9cTrYAgV1mhS/917VZMf0wtqs5PF/zJ58oiqDYC0D49O002kYvKursj+N1Z7S5wJNAUTX
        vYFlSNAQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oUAH8-00Ejng-GV; Fri, 02 Sep 2022 11:16:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oUAH7-00065w-1j; Fri, 02 Sep 2022 11:16:13 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri,  2 Sep 2022 11:16:09 -0600
Message-Id: <20220902171609.23376-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220902171609.23376-1-logang@deltatee.com>
References: <20220902171609.23376-1-logang@deltatee.com>
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
Subject: [PATCH 2/2] md: Remove extra mddev_get() in md_seq_start()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A regression is seen where mddev devices stay permanently after they
are stopped due to an elevated reference count.

This was tracked down to an extra mddev_get() in md_seq_start().

It only happened rarely because most of the time the md_seq_start()
is called with a zero offset. The path with an extra mddev_get() only
happens when it starts with a non-zero offset.

The commit noted below changed an mddev_get() to check its success
but inadevrtantly left the original call in. Remove the extra call.

Fixes: 12a6caf27324 ("md: only delete entries from all_mddevs when the disk is freed")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index afaf36b2f6ab..9dc0175280b4 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8154,7 +8154,6 @@ static void *md_seq_start(struct seq_file *seq, loff_t *pos)
 	list_for_each(tmp,&all_mddevs)
 		if (!l--) {
 			mddev = list_entry(tmp, struct mddev, all_mddevs);
-			mddev_get(mddev);
 			if (!mddev_get(mddev))
 				continue;
 			spin_unlock(&all_mddevs_lock);
-- 
2.30.2

