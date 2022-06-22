Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04A755432D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiFVGrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFVGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:47:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5297134BA2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:47:35 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 184so15250734pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MnU5LUELxG6gx7YQQM1Li9d9/Gs3+ISx1Ie+xQK2vw4=;
        b=LM38fHr/TXkTvB/XeJ3vbofHjMo5Ph/M5PZa3JYpKEbN5q1FQ1o3wZ2l6ZJpDw1/9K
         yEaPwVDl39hROyWDkrA+iPbBhT12qnuF8gpf5TARt5u7yMqRu/t7lGmkBXhA13lfFp69
         Gdr1ESfGBczS5yTSQFSkvOi2jPzYP45IVHsnZ2dCTbdolEBYs6Ibd/U0H7qoWmmsBy6q
         ks6oeRu7ZlohGqF6KEV3x8v4C36ARiItnptlAlKMj/nzRic+u5Qo60pCmDkcJGOacNIm
         vQ21NWa0qqr4cqH/b4W035yGFrpD9DHNP8+Sg0GudniwPJKgW/hc8nPS9xGIw7fNUWtY
         vQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MnU5LUELxG6gx7YQQM1Li9d9/Gs3+ISx1Ie+xQK2vw4=;
        b=r4A8j5/Ksn2GMzVqf9eMIWswiZBj4IhZMxdHJE291wEsCgOwMjveQ+d72eKZq39tvX
         ++EGqCjnd6HQ9jVHgxJQN7U9KMWGjLLv4nGaCiKhbZMeI4XTkaPsNp6KaoshR3/6A4UN
         FtDxWPSg8rhDjcxTrGa2bCNakYy4WZV/pe0Qd0LSv3eZVZtJMDya7QWVdzDU3+ueax1E
         Gh/aZj/lIW3c8Wmoqm32Ncw5j6hY8A5C6lPN3GUUn7lmsxoWP+U+B5z8Tu57oEHK7mdS
         OLKB0cRGAEvEv2z+1riRplgLt7YPq4tEfjU9rfhCNag5ftCIshK5AeI3SsCIYembRLmI
         2d4Q==
X-Gm-Message-State: AJIora8Gd9/edig3nwClJS8XOd4tJzQGLj8W2PP0+KztlBxC/UocU4zv
        WnLVnNvlbeh+pUH3BRNzyrxLyjxkbBQ=
X-Google-Smtp-Source: AGRyM1tVQ9VHmV6wlz213cHyQb9Cpmf/RBoLpTYsIAlIBQr/thHEP11V6fBPKUGGaqWBZi51dCihGw==
X-Received: by 2002:aa7:818d:0:b0:525:1f1d:185d with SMTP id g13-20020aa7818d000000b005251f1d185dmr16026782pfi.23.1655880454835;
        Tue, 21 Jun 2022 23:47:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s17-20020a17090a881100b001ec7d979da1sm8734501pjn.15.2022.06.21.23.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:47:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] mm/page_alloc: make the annotations of available memory more accurate
Date:   Wed, 22 Jun 2022 06:47:13 +0000
Message-Id: <20220622064712.959479-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Not all the systems use swap, so estimating available memory would
help to prevent swapping or OOM of system that not use swap.

And we need to reserve some page cache to prevent swapping or
thrashing. If somebody is accessing the pages in pagecache,
and if too much would be freed, most accesses might mean
reading data from disk, i.e. thrashing.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e538dde2c1c0..233f68d31cdd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5889,14 +5889,14 @@ long si_mem_available(void)
 
 	/*
 	 * Estimate the amount of memory available for userspace allocations,
-	 * without causing swapping.
+	 * without causing swapping or OOM.
 	 */
 	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
 
 	/*
 	 * Not all the page cache can be freed, otherwise the system will
-	 * start swapping. Assume at least half of the page cache, or the
-	 * low watermark worth of cache, needs to stay.
+	 * start swapping or thrashing. Assume at least half of the page
+	 * cache, or the low watermark worth of cache, needs to stay.
 	 */
 	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
 	pagecache -= min(pagecache / 2, wmark_low);
-- 
2.25.1

