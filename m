Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322E948F755
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiAOOmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 09:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiAOOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 09:42:05 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF24C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 06:42:05 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j37-20020a634a65000000b00349a11dc809so3782901pgl.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vQu2YGnyaem/WDCb/1ixVe4jFBzHYp6XDPfE+l97NRQ=;
        b=RAFTf5fJoVhrySxFeclsltYyb9p2i1twuPM/kLWQ+AFQ0Wh4oUI+8TVolsH83OcqBj
         nk/EF88RqtYjKHpmjifQ5+xGMnzVLUpYZuKU0LsDwODppMPNL/NusBwFSngJ8jGgVjB4
         8Hd8NAsMTlBAIYnqa2CKkW3Z7NYdyLGxFaKkHL7QAwZZWCwTrKtg/74BAqqzr5omvKpG
         Gcb0uEB9LaPxJouoiwL5DNLazEiRrev8MFAm+lz0ThqXFWJbtWhzyG3h14nKMnNQ6fAD
         BvCiWA4yTnQnwRCDXK0K2c2Ed5ebeyYF51MrZvkKWbKAx2fSFPVDfmfeAivojQxhkRo5
         HlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vQu2YGnyaem/WDCb/1ixVe4jFBzHYp6XDPfE+l97NRQ=;
        b=5zA4MrGQ8OAQMIKkdw0Ap/LmnoARxW3HmgkEJUE33IHXUfAi0T9JZGbKe1wfoot+xC
         iovumdzSByC7kOqcpdQW6gHZhsjVJJR/Rn2BRoPgOZzVWcaJ6uiCCT69pSiCQPODVCDR
         k3myeZOIIdANxvG5tiIQFjOlv7Dc3NG/r51onKGiEG4m4mKdrRoFZhgBZ1NG9kz/iptL
         5PGVDk8RsD9y4+pGbtjIGdbQCz2VMoWRkebhk7ZBmf8XBz4tdGyubuiKbYo2U/2Guuw1
         O8xgbpykDvY025008OKKZ0RFdnUuZj1JZTtsVl6LaP61o3jrKsJhTSlN59ATiVEbMRuY
         EbyQ==
X-Gm-Message-State: AOAM532dbETN7MApI9W+XL7icsAtOsm6QRCM4DzvDWgkERSpo4dtnE1B
        tCishjOefF3U+9Q1izP4ICyNpk7OjNAAgA==
X-Google-Smtp-Source: ABdhPJzDJ6OuCMhPiZXw84Q7hz0CXiTS8JIsrrIAXlT+ZM3uGrKf7jUah/OPOJXY4kS0xiWjZNQkDozDXW4OSw==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:5db:c608:dd2d:a4b])
 (user=shakeelb job=sendgmr) by 2002:a17:903:41c1:b0:14a:6879:9333 with SMTP
 id u1-20020a17090341c100b0014a68799333mr14741762ple.36.1642257724752; Sat, 15
 Jan 2022 06:42:04 -0800 (PST)
Date:   Sat, 15 Jan 2022 06:41:50 -0800
Message-Id: <20220115144150.1195590-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] mpage: remove ineffective __GFP_HIGH flag
From:   Shakeel Butt <shakeelb@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 8a5c743e308dd ("mm, memcg: use consistent gfp flags
during readahead") mpage_alloc is clearing all the flag bits other than
bits in GFP_KERNEL internally. Simply remove __GFP_HIGH from the call to
mpage_alloc as it is cleared by it.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/mpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 87f5cfef6caa..477ccc3f3ac3 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -609,7 +609,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 				goto out;
 		}
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-				BIO_MAX_VECS, GFP_NOFS|__GFP_HIGH);
+				  BIO_MAX_VECS, GFP_NOFS);
 		if (bio == NULL)
 			goto confused;
 
-- 
2.34.1.703.g22d0c6ccf7-goog

