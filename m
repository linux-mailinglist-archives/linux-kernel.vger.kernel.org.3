Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1F0480C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236745AbhL1R2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhL1R2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:28:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D95CC061574;
        Tue, 28 Dec 2021 09:28:01 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id t187so3221885pfb.11;
        Tue, 28 Dec 2021 09:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=iK3TYSqepfTI2FEHIHzErbmP5hk0m9mmdnNtxXuTqFc=;
        b=JWsZh1bsuFqCG3YghtU1JwycqrojJy7elCAvbaFmncbhbSf8Ij5Dxg2C2g9rrE6r89
         zh9toGN/Pxxan9okNXvstE7ST5BolB7YTqgoL1AKnh/tCJ6rTMwqFib6nFRkPZRdqlWe
         EDidt3b67Gr37u/5luHlEys8s66OJ7BnomQBQEMf7mCpLLreJzEo6JZc2nj4fLe7zzUa
         cTd5ugiNtD9Qz6MCRsb/gopCh8q+HONTWAqcPlC6sEQSfHCaEhXBUWfgkiYNHTD/YOKJ
         gFihT+KXLdjq4WDzo/YTIG2pm7Zdj3s8dhKsiH3ICX2JmKmKfR/6HS2esNWAqu2lkQQ5
         VbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iK3TYSqepfTI2FEHIHzErbmP5hk0m9mmdnNtxXuTqFc=;
        b=LZ9hJ8yPtEZ2Lyc49KZ+vdOZHAvsjaWXbyrEfpCJdHZ1DqxPBbMbsqMtOGWkFRRz1U
         jlt/dkOm8mUAX6wK77MZU04jRqJzLTV+xnJCUNQpUTN1EcqVCuJzmEdWq4jQH4loLSyn
         g4tfgQuPn0Q9GsJOl5KGuywqvNu59+Xq+E4OU6exhCHJNDEXiv+i9agVUeYglcbaA5z5
         6dui4kIhu06Qt/c5ytpbDNrLqque7l6CeuiwBqjOp8mv8QVu9WCsoCvrZ1zthSBNHk/a
         PN+2SF864LohG9ffV7ih1z2ODH6YGAbG/C16Tc9XA+HIWGUl4P2A/fCP2BNlMdBpED+i
         q+zQ==
X-Gm-Message-State: AOAM530/5pO+uFNDhCrjNQQ54Tm9wexUZjglM7rwiLXNQBwWmeHfeHlR
        pf6XiH3/6t674h0JIn9cZwmPFld97QE=
X-Google-Smtp-Source: ABdhPJwZ1LRCjSXnwbw2oscxPEHPLsjr6Alh4grg3kIVl6fo3XVuFVrtKY1izuqH8jSOxZEW8cb6UA==
X-Received: by 2002:a63:744d:: with SMTP id e13mr5040403pgn.183.1640712481014;
        Tue, 28 Dec 2021 09:28:01 -0800 (PST)
Received: from carrot.localdomain (i60-36-87-165.s42.a014.ap.plala.or.jp. [60.36.87.165])
        by smtp.gmail.com with ESMTPSA id me3sm22104680pjb.47.2021.12.28.09.27.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Dec 2021 09:27:59 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: remove redundant pointer sbufs
Date:   Wed, 29 Dec 2021 02:27:56 +0900
Message-Id: <1640712476-15136-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

Pointer sbufs is being assigned a value but it's not being used
later on. The pointer is redundant and can be removed. Cleans up
scan-build static analysis warning:

fs/nilfs2/page.c:203:8: warning: Although the value stored to 'sbufs'
is used in the enclosing expression, the value is never actually read
from 'sbufs' [deadcode.DeadStores]
        sbh = sbufs = page_buffers(src);

Link: https://lkml.kernel.org/r/20211211180955.550380-1-colin.i.king@gmail.com
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
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
1.8.3.1

