Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82072547F90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiFMGfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiFMGfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:35:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37950BC81
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso2167947pja.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B72Ua44K+e6NGA36blstxa09i97avcKmfrwwXvB2UR0=;
        b=qwkYRnZuS/W9slMWkIAwYldruSCyscLX8/wyF7kLD8G4uAeT2sqkPMDJ9FLteGBkba
         jPtSNz9K5I6n2/vLHYGNDpiJsEr6w0AdooLipoVAUAZ8Y4EBOxLw9+mQhljpgwFEQzqf
         yztz6xnzmXcan/IcMsTOWEk5Pil7u0lNfnQePAdqkP+93elHBvBPF44pEJT1wFoWpLse
         3kVLIYgT3gyvTFurcJnYDGckq9NnRYCNM90frf7MuhOYmtrIXMfiKNc7i4JsrOf8flV7
         yS3Q7pWIirK0dCxNgn28AalTjpfE0oz8lfmYe0RuwZiDGEikCM0cN6ykGA39pbDhQ8x8
         Fgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B72Ua44K+e6NGA36blstxa09i97avcKmfrwwXvB2UR0=;
        b=e8EAbUM06WgrF/va5WMIkTGZZ0FAod6Wrkr7ORrws+aj2IFMwTjZiWccvnrQecVRQu
         3jwZOPvUdt/MGP4CL1bI0Qyi1EUtMlXzXvV/1HCqTJp3u26n0U4RpR30DZT9Fqbp2dhr
         bUOYuKU6xc6T0VWAsXVuUSin0YYeVA/RoUfAnPbtn1urKzifdH97urYJ8796k4dmQ4o4
         +rK0/pYdB5muhwkzb3A3SI7lGMWONSlvqGtSacDYkYLMeuoSTLantONuOUqOIsB4CP/V
         WyI8a/e/XJSXn+Zjm/L3vnZmWodbc5Th0h10ygZ1In5eUbwj3hp7arzbx8UB+e46600+
         79MA==
X-Gm-Message-State: AOAM530w8CZSw1vuhnDUmDzV6tJWTcPGnhXIcDP6yaj9JbAAlgZZcONq
        rRDRx1qURJ1z5y0hkO+/NvqJUdQznQgGJ2KFiyk=
X-Google-Smtp-Source: ABdhPJy8ePrJh8eNpFPc7r+hoH67PAyb+LUzYIz//Skci1r3NK3WQ1UlwXpoXXJMTLqE6uQnUgUeXg==
X-Received: by 2002:a17:902:d2c9:b0:167:1195:3a41 with SMTP id n9-20020a170902d2c900b0016711953a41mr51441419plc.126.1655102131696;
        Sun, 12 Jun 2022 23:35:31 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id v3-20020aa799c3000000b0051bc538baadsm4366554pfi.184.2022.06.12.23.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 23:35:31 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 1/6] mm: hugetlb_vmemmap: delete hugetlb_optimize_vmemmap_enabled()
Date:   Mon, 13 Jun 2022 14:35:07 +0800
Message-Id: <20220613063512.17540-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220613063512.17540-1-songmuchun@bytedance.com>
References: <20220613063512.17540-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index de80f0c26b2f..b8b992cb201c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -203,12 +203,6 @@ enum pageflags {
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
@@ -227,7 +221,8 @@ static __always_inline bool hugetlb_optimize_vmemmap_enabled(void)
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!hugetlb_optimize_vmemmap_enabled())
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_optimize_vmemmap_key))
 		return page;
 
 	/*
@@ -255,11 +250,6 @@ static inline const struct page *page_fixed_fake_head(const struct page *page)
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

