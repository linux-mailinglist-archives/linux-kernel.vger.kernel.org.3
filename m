Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82B348416B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiADMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiADMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 07:02:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A175C061761;
        Tue,  4 Jan 2022 04:02:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i22so75677922wrb.13;
        Tue, 04 Jan 2022 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iJCchn2X34ne9iX0z8o1f3UymboTeZK5qbmX+dn9QQI=;
        b=JfiVlhnMPzA+jvSKV4ITc/KrSQp97QQgaA1FBiNnZBb/UhPU8YPlvD0Wi4KnX7GFNh
         KsIZ62/drSwobPTlpHyv9+p64BkxYbnzdGN7gYnuE+kKw2XLeSR9Pziq3CVBlThgJ1VR
         rh/plbAUSzyuFtQ6b04EAig8a6N2JSNHaZqdHdk3eoajmQt/jWcYhGZArGs33OUzMp9E
         vozF9lM2hCwD0fkpRK+GlhNKrbcQRjO6I3JPxiJocAU6ZDxJZI+bkjiURUTceENPU1Gh
         5kfTWHNSu+3lWCmRowMi2FsfAObcCH2Ix6SzwkLTOBLl7sRm74iyCoKn0K7CCOPHrhL4
         Mp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iJCchn2X34ne9iX0z8o1f3UymboTeZK5qbmX+dn9QQI=;
        b=Ziwp5k0p4Jo4lW3n+XxtmfG6SqBLKt5QUFJQBPuNYTieqh/e4Q2Zy8zo/jbkQ0u9Fm
         GGbE4I9VoyoIOSpS/X97u098bbY+UuvJsBguBK2iDAxkCtymxMLCgn5O8djrGJW/4r8O
         ETPQ4RFeGArv0goF6oliqp4MNsswV0znOSEwEzZR5BWbc91rAMY9QTOGSuzJ545ygaXj
         1juotqpI1dr94IGPcy9XPYma45xEXtZdBqUxN6jnOaRaa83N6zectUXW5455S9bYw5vS
         zDxt9x2IHpf6m6FB22gAPHfy1CcMRL3Kuk41poHVB3RBZF8z0PGpetpJ5D3yKPRaA5EK
         HtZg==
X-Gm-Message-State: AOAM532kCIawGRP5PQw7+Yo/Bq2WGfY2K2vFTX5of1LCfW7XDDfZu/g4
        Km27r+1OAUqE2v6OvElUbpM=
X-Google-Smtp-Source: ABdhPJwnvPlI2K3oopQjvmwG366MYxq9KF8B8OhI6kbksvbCi5nwHkvDJATS7pFQNkB5wh1PL+emoQ==
X-Received: by 2002:adf:de84:: with SMTP id w4mr41123010wrl.67.1641297732567;
        Tue, 04 Jan 2022 04:02:12 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2647:5a00:918:9389:3260:d714])
        by smtp.gmail.com with ESMTPSA id d5sm15640703wrs.61.2022.01.04.04.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 04:02:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] block: remove dead queue_dma_alignment branch from bio_map_user_iov()
Date:   Tue,  4 Jan 2022 13:01:58 +0100
Message-Id: <20220104120158.20177-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If queue_dma_alignment(rq->q), then blk_rq_map_user_iov() will call
bio_copy_user_iov() and not bio_map_user_iov(). So, bio_map_user_iov() does
not need to handle the queue_dma_alignment(rq->q) case in any special way.

Remove this dead branch from bio_map_user_iov().

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 block/blk-map.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..1cccdb776905 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -260,31 +260,26 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-		if (unlikely(offs & queue_dma_alignment(rq->q))) {
-			ret = -EINVAL;
-			j = 0;
-		} else {
-			for (j = 0; j < npages; j++) {
-				struct page *page = pages[j];
-				unsigned int n = PAGE_SIZE - offs;
-				bool same_page = false;
-
-				if (n > bytes)
-					n = bytes;
-
-				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
-					if (same_page)
-						put_page(page);
-					break;
-				}
-
-				added += n;
-				bytes -= n;
-				offs = 0;
+		for (j = 0; j < npages; j++) {
+			struct page *page = pages[j];
+			unsigned int n = PAGE_SIZE - offs;
+			bool same_page = false;
+
+			if (n > bytes)
+				n = bytes;
+
+			if (!bio_add_hw_page(rq->q, bio, page, n, offs,
+					     max_sectors, &same_page)) {
+				if (same_page)
+					put_page(page);
+				break;
 			}
-			iov_iter_advance(iter, added);
+
+			added += n;
+			bytes -= n;
+			offs = 0;
 		}
+		iov_iter_advance(iter, added);
 		/*
 		 * release the pages we didn't map into the bio, if any
 		 */
-- 
2.17.1

