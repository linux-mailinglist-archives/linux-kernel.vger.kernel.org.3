Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C46E55C9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbiF1JYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbiF1JX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:23:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829851FCCD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bo5so11484366pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7r3zVYj3AvZ/3UidUc2ZI4PPOhwx3ZhlpO+4x/MXUA=;
        b=ZYRQ8+sE6n9u6F2XY8JCvWXwHfsNJkVRmGXVGMzdq4PLG7Ih9aIItBZtXjebp94oKv
         T+Z9BoixwlavlGo+fFGrnwD3vCjYJRtNsy222z6cPADrh7hflTPGEeo3ucVxuDoYjb4o
         ki+9urDmDyjqQL8kLeirpGizj19pLNX7gNAoQYWLOMo25EWLz4jS7SG9P+JNSckHpEja
         2w8vIIVz6z01MSnU2CdAJJ/NE93gXAnpbvuifKgCGo3MwIRCXV/pQsfePV6oYDDIdODy
         MDYXzHlS2AE50nCgEZ824ZZ8+L9zEp7ZgSqZSE/XpB5kq+1QBNshwojokY/+y3EkoEW1
         BH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7r3zVYj3AvZ/3UidUc2ZI4PPOhwx3ZhlpO+4x/MXUA=;
        b=BKOv3SDm4URI0P8idhqCotwT5/sbDK/MzloS/6Tu9P9HErv0ys4HOsFhav+Ew4Tcr2
         HGxBxCh0SkaUxxpmWJuNcU22XyAxQiPArzEtHrP9Izw/bL8WSa7rQkKwer+JsBemkqAw
         tUsDEPKg0+iKqJtFU9BZuuo83Xk0BG1abZQNYl0a/ZTZJpt6uot0+8pHxcs8c9ICGMFl
         /nLu7AN4Asi8ccyTySOpq8XI6WhNz4gqPhOUEJpUx6uihjs+a17FmYq7PQJcAZKx/VzJ
         T77ifaUP0JvMha4XoGBs371Tq+MX2nKOVj3HD4PxTktX50c9lLNBfCd7fXlv5hS7Lgr4
         Vm3Q==
X-Gm-Message-State: AJIora847gx6T94ErrcFV5nLQBN/xiZsqgS9gSJZduBrkU0kEppPD1N4
        69Fyt/5dj14NvcKO35Gf0DsHIg==
X-Google-Smtp-Source: AGRyM1v73L30amWxnk++qspTkF6VOQbffCogWNAnLP39+fpa769TYG6jfye+TfEhzCX83mAbbsbeug==
X-Received: by 2002:aa7:81c1:0:b0:522:81c0:a646 with SMTP id c1-20020aa781c1000000b0052281c0a646mr3724444pfn.33.1656408233086;
        Tue, 28 Jun 2022 02:23:53 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:23:52 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v2 1/8] mm: hugetlb_vmemmap: delete hugetlb_optimize_vmemmap_enabled()
Date:   Tue, 28 Jun 2022 17:22:28 +0800
Message-Id: <20220628092235.91270-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220628092235.91270-1-songmuchun@bytedance.com>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name hugetlb_optimize_vmemmap_enabled() a bit confusing as it tests
two conditions (enabled and pages in use).  Instead of coming up to
an appropriate name, we could just delete it.  There is already a
discussion about deleting it in thread [1].

There is only one user of hugetlb_optimize_vmemmap_enabled() outside of
hugetlb_vmemmap, that is flush_dcache_page() in arch/arm64/mm/flush.c.
However, it does not need to call hugetlb_optimize_vmemmap_enabled()
in flush_dcache_page() since HugeTLB pages are always fully mapped and
only head page will be set PG_dcache_clean meaning only head page's flag
may need to be cleared (see commit cf5a501d985b).  So it is easy to
remove hugetlb_optimize_vmemmap_enabled().

Link: https://lore.kernel.org/all/c77c61c8-8a5a-87e8-db89-d04d8aaab4cc@oracle.com/ [1]
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/flush.c      | 13 +++----------
 include/linux/page-flags.h | 14 ++------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c
index fc4f710e9820..5f9379b3c8c8 100644
--- a/arch/arm64/mm/flush.c
+++ b/arch/arm64/mm/flush.c
@@ -76,17 +76,10 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
 void flush_dcache_page(struct page *page)
 {
 	/*
-	 * Only the head page's flags of HugeTLB can be cleared since the tail
-	 * vmemmap pages associated with each HugeTLB page are mapped with
-	 * read-only when CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP is enabled (more
-	 * details can refer to vmemmap_remap_pte()).  Although
-	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
-	 * page struct, there is more than one page struct with PG_dcache_clean
-	 * associated with the HugeTLB page since the head vmemmap page frame
-	 * is reused (more details can refer to the comments above
-	 * page_fixed_fake_head()).
+	 * HugeTLB pages are always fully mapped and only head page will be
+	 * set PG_dcache_clean (see comments in __sync_icache_dcache()).
 	 */
-	if (hugetlb_optimize_vmemmap_enabled() && PageHuge(page))
+	if (PageHuge(page))
 		page = compound_head(page);
 
 	if (test_bit(PG_dcache_clean, &page->flags))
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ea19528564d1..2455405ab82b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -208,12 +208,6 @@ enum pageflags {
 DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
 			 hugetlb_optimize_vmemmap_key);
 
-static __always_inline bool hugetlb_optimize_vmemmap_enabled(void)
-{
-	return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
-				   &hugetlb_optimize_vmemmap_key);
-}
-
 /*
  * If the feature of optimizing vmemmap pages associated with each HugeTLB
  * page is enabled, the head vmemmap page frame is reused and all of the tail
@@ -232,7 +226,8 @@ static __always_inline bool hugetlb_optimize_vmemmap_enabled(void)
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!hugetlb_optimize_vmemmap_enabled())
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_optimize_vmemmap_key))
 		return page;
 
 	/*
@@ -260,11 +255,6 @@ static inline const struct page *page_fixed_fake_head(const struct page *page)
 {
 	return page;
 }
-
-static inline bool hugetlb_optimize_vmemmap_enabled(void)
-{
-	return false;
-}
 #endif
 
 static __always_inline int page_is_fake_head(struct page *page)
-- 
2.11.0

