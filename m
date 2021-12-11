Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3647154A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhLKSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhLKSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:09:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E583C061714;
        Sat, 11 Dec 2021 10:09:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p18so9076956wmq.5;
        Sat, 11 Dec 2021 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zA92V1btmrTrQKYhZyZjsNIHT2URvEbAj4KA4p/lKAY=;
        b=TSvkTe2LbjI08HFOsXQoUB44oUbVFIbH8+rZ8sj176haMNUQuvdORHM/2G9niiMIqM
         lhfDm0VOHIQ9hnZvat3NTIw8AM6qSUGFnU7D+iZWNdumFncXmrJ1kOPId/OeUqxK+kYs
         uq0oMVW1dWSCA3vvffKxV/Aam3WOQdrhXeLz+Wg6FfCKWB/Jr7WV3eSSA6FDp/TTkydq
         tXP28aSP2ScgT4d/KuHMGL2COCHfpaAUVhFNG/eG9/W2/b1nWheliIl07ZqlamO5B0HI
         sjLGnKD+fvW8eoy3eH0Yw57bg7p9W5U+40+wxirgxGKPqH43g6OemiEZTCPiN1jsmWFQ
         UrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zA92V1btmrTrQKYhZyZjsNIHT2URvEbAj4KA4p/lKAY=;
        b=bpbDt9HnhVDLTe9ZveicGfTLrVBg3elOoqymTsIKfVRvyEQrhA1vM7nCGCXo42mGuc
         SDc5NfBNIrbkjFOr6LOP3v3roEXMnKXEGo8W2PXunM6BiPuku5nCWY6vYZVEdcQ4Wzxh
         tdq2EfLBCXkNtrdyYpUzKcvBDNlihn6zgkMhbkxxKdjJS9F6wClWsNWrzi8vLfQO+JF2
         HyysQTHnDFD1J8OTBpUZe3+dfbcUQNTpJDBp29GJ3bVTLcFN83wF3PlT0ebKAo8RKWJz
         Zv5efy1aBrT/WE7kdHtgCWhuzoxEw1U9ewW+ROH05sEkFRsxydpjJAaV4lwJQdR2rxTv
         zybA==
X-Gm-Message-State: AOAM532n9NOa2VyD0cegPMJ/Rjwx0kfC4wF8CW/qwkldP0DbMF25+ZyI
        tatCVtipQvYwlljLhQTS025R/Y/OHu5Ae8FF
X-Google-Smtp-Source: ABdhPJyfr/+qyNj7EVGW/LU9V1sTrzoTLBRcl8C0CJQgQQYbFeMNxL1/sm0g3FRmeJ9gbC005AafHA==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr25088757wmh.60.1639246196992;
        Sat, 11 Dec 2021 10:09:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w22sm2049694wmi.27.2021.12.11.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:09:56 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: remove redundant pointer sbufs
Date:   Sat, 11 Dec 2021 18:09:55 +0000
Message-Id: <20211211180955.550380-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer sbufs is being assigned a value but it's not being used
later on. The pointer is redundant and can be removed. Cleans up
scan-build static analysis warning:

fs/nilfs2/page.c:203:8: warning: Although the value stored to 'sbufs'
is used in the enclosing expression, the value is never actually read
from 'sbufs' [deadcode.DeadStores]
        sbh = sbufs = page_buffers(src);

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/nilfs2/page.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index bc3e2cd4117f..063dd16d75b5 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -195,12 +195,12 @@ void nilfs_page_bug(struct page *page)
  */
 static void nilfs_copy_page(struct page *dst, struct page *src, int copy_dirty)
 {
-	struct buffer_head *dbh, *dbufs, *sbh, *sbufs;
+	struct buffer_head *dbh, *dbufs, *sbh;
 	unsigned long mask = NILFS_BUFFER_INHERENT_BITS;
 
 	BUG_ON(PageWriteback(dst));
 
-	sbh = sbufs = page_buffers(src);
+	sbh = page_buffers(src);
 	if (!page_has_buffers(dst))
 		create_empty_buffers(dst, sbh->b_size, 0);
 
-- 
2.33.1

