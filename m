Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F252A4B0DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbiBJMhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241599AbiBJMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:28 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A725F9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a39so9130073pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/ARb1Au1FcGhHT5OSe5P8uQ767qWIf49sbqK0ZF8no=;
        b=vH5ZsS3PT2z/Kj1kRUC91t3vQ/3r4wzvj9kOFOgiv2XuirXjyqCONSJ/51PQ+9kRrK
         me7yzHej8KCOSngIj9caZ8TYmD6yjv+OipS0Zh++ztGJnNTQv16Q7RRYXhTYPGAmroqD
         8m5j3krUJ5T7ngC61kzmUoO7LQUaIz2LEx+1pTMuFaVjauZ+az7YgVOMXYNt/EgUzglJ
         CeNzs5L0I0SGoqAREdYhRiJAtewRFVJhmU7qPU751vHJEyUnYbv9HmWNYc2VVD/9t+9P
         RXlLPEDx6qiWtpgfwcD3oePkZ1C9Ng9PvZ1jiTdIVXdZgfWlIljgvFq369BTQ+OK00/n
         CUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/ARb1Au1FcGhHT5OSe5P8uQ767qWIf49sbqK0ZF8no=;
        b=nyXqtTbk8CIqfjpIi5y4HFHjnzd9S2ZqMDcSBLa5zWOx4nsHuJe2D26oUyF/TYYUzC
         PRaqs5WuDzN6smLcRwbpaWbXVE3KfPq/aEp0J9/bgT8VdqdjydorrFBCifJFIPv3rIF5
         X35599DAWCU7nWf0Nto7bmL4qZQm8urCau5seeR2DzWPRzXViH9TOYhrg8NILJkdbzpT
         IKqFq1FGcuOJqDdlzX6TivOsS+J/QKVrksLN+vhJdpJ7jUAAcOjJgM75dZVxbnEBhtmg
         +rLH+jv6scpx70fsvk8IbKdRTc2kj8Or/x8TOqtnnUxov4fuTPNamluGh3ERBocEJN0d
         lSzQ==
X-Gm-Message-State: AOAM532FrBfpgr3tr/joy7Rt9CeAq5Uc7iIClEX/h1JDs+fVaHHI3nLk
        Gsyl9RkCGxj+YZAC5k/0rOVzsA==
X-Google-Smtp-Source: ABdhPJwl1X1ncYwB3dcpyVNk3GZyIIA7yD1CzabbhXJpnxAOqkc97+qhRQDMOf2nz7oIH9laIqf+NA==
X-Received: by 2002:a65:681a:: with SMTP id l26mr5933154pgt.365.1644496649737;
        Thu, 10 Feb 2022 04:37:29 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:29 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 2/7] mm: fix missing cache flush for all tail pages of compound page
Date:   Thu, 10 Feb 2022 20:30:53 +0800
Message-Id: <20220210123058.79206-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220210123058.79206-1-songmuchun@bytedance.com>
References: <20220210123058.79206-1-songmuchun@bytedance.com>
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

