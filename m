Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F654AD245
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348315AbiBHHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348298AbiBHHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:36:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024CC0401F1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 23:36:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w20so3900756plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 23:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/ARb1Au1FcGhHT5OSe5P8uQ767qWIf49sbqK0ZF8no=;
        b=hIUCyUYTQeWIyj0y3xa/lyJzJfBL9YeIpDkgIOVfa9Clb0wtstmPR610H1IH10cyNC
         IG+zGUOO/ZeEVHE8BfrdZHeMAPXZJrhPIZ5Fm2Tamk5Xsyp2QOnEPsMIAJkaPCHR1gfa
         U32l7A+wL1flsdi7qlpHY+HbrTGtygA2afkAodp9Xx4VKZDhbKB5Md2FpFPw1lKz1Us7
         lJvwf8JjE0koHnrQ1fNx3hwWEWzZMKQl0hl921uE1+/CB+qidA3V6kqFUA7qx1owiBSo
         ZKfSFuUUUODfiZlV0CGELceZ3dOxNuZQUzREfn5T/pI5Po6WOrr2dQ3HwuByV8LbMakC
         SBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/ARb1Au1FcGhHT5OSe5P8uQ767qWIf49sbqK0ZF8no=;
        b=wLFjKP6b304Yl8MRJ0IFGMav8hhbYD5Ql/9zl1GcrE4h2jxhvTRtK7Dmx9vZ92uiXb
         DPGqOZDAWugGlPfFYIAl+L0tKmQjmAp32Gmkwq89z7Y9JHumN8g/YQ1y2DEKuMmmU+zB
         B1u0Ae1dEAmNUqvMP4ZOKV24EriN//fhOXyVvX2B9UmnNqI8DWBWPE9ukPyJ01WKi1Am
         fV9tHclk2fN/An7O3kLsOvIY9XxG16qr7kL7Bc8TWdBjKDNrXCQ16gxN9oYCjPL8A0qK
         vWi4XtLDiPZN8ArBzpBw4UA07D/ZSkQhhjztjG6vb6LU0WDFdoRLrgj7tDCaOsuuWYT0
         Fp+A==
X-Gm-Message-State: AOAM532ecybxGDuKs5nZelCI2/ZNyAl9AXxqELBtBDnWKOy7s/AVext6
        FWXhDx09R6BglYRjdjZHnJbAyA==
X-Google-Smtp-Source: ABdhPJwsZdtiU96OKE7UAsec4IC2Z4kjKKWlUx3J30L+vHnc5YKdB/6S38QvVd5szKB7Y7RVjoAr2w==
X-Received: by 2002:a17:902:bf4a:: with SMTP id u10mr3025261pls.113.1644305802222;
        Mon, 07 Feb 2022 23:36:42 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id gx10sm1621017pjb.7.2022.02.07.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 23:36:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/5] mm: fix missing cache flush for all tail pages of compound page
Date:   Tue,  8 Feb 2022 15:36:14 +0800
Message-Id: <20220208073617.70342-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220208073617.70342-1-songmuchun@bytedance.com>
References: <20220208073617.70342-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The D-cache maintenance inside move_to_new_page() only consider one page,
there is still D-cache maintenance issue for tail pages of compound page
(e.g. THP or HugeTLB).  THP migration is only enabled on x86_64, ARM64
and powerpc, while powerpc and arm64 need to maintain the consistency
between I-Cache and D-Cache, which depends on flush_dcache_page() to
maintain the consistency between I-Cache and D-Cache.  But there is no
issues on arm64 and powerpc since they already considers the compound
page cache flushing in their icache flush function.  HugeTLB migration
is enabled on arm, arm64, mips, parisc, powerpc, riscv, s390 and sh, while
arm has handled the compound page cache flush in flush_dcache_page(), but
most others do not.  In theory, the issue exists on many architectures.
Fix this by not using flush_dcache_folio() since it is not backportable.

Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c9296d63878d..c418e8d92b9c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -933,9 +933,12 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 		if (!PageMappingFlags(page))
 			page->mapping = NULL;
 
-		if (likely(!is_zone_device_page(newpage)))
-			flush_dcache_page(newpage);
+		if (likely(!is_zone_device_page(newpage))) {
+			int i, nr = compound_nr(newpage);
 
+			for (i = 0; i < nr; i++)
+				flush_dcache_page(newpage + i);
+		}
 	}
 out:
 	return rc;
-- 
2.11.0

