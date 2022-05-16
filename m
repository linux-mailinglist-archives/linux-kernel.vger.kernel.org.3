Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78105281EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiEPKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiEPKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:24:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79BDDF5F
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso823174pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jSjHlEJZ1lWJ5sUgf+NErUi604xPZiJFf+96LoXPZRA=;
        b=tvaEqhT5/0VShTdmGcoV7QtkaEOFtFRpQgSee1AARQzV7qYhbtTSIUiemTABLiPqRJ
         wO0IWpVnGfUGXIuoRzl/oYax5/wlxFS7PIMUc9w28HhTQ9vupeD5RBq5b+SWjGq4BUQ+
         daFSBYXRBJyH7Mb0rqkhKeUBYrwF2/lSQtUUcPp9B5FpIXRdP+dp11fvmMhY3RQwUct8
         Qn6SF5MYrU6EgxrBpTj+oTe7c8e/pZXcdGtirgqcBmgBpO8pECK6KjYP7pzgUhQvU8BN
         XmKyNkvkbG2dH7BgTbrwpssZKSaxayfFF0JxUZ9QyiXXmkeT0M59bXNImnZ/bz6nZsY5
         ASBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jSjHlEJZ1lWJ5sUgf+NErUi604xPZiJFf+96LoXPZRA=;
        b=KNd539p0MMSveEwmMozo6y0kuY4VxZwtPYlsjziYZpJGSvEEDtdRgc+nsvUntghcg4
         KilaYPC3JPf2SVx8Z0DBBfsWaC8ManXapYmA/lPe7sqN3gFCfOLKy3QUHqMf3O4DwpeP
         1PZOWRfp0cHFqb4+qM8RIO4vbWHBi5kY1rIcImFUW47CwZhcdDxmO0TDL5jFLW8XvxRe
         V0fHNeLVEgiG7QrB//KRlYhL20AGzymz7Qrqq1gV7TI+PVKbLJyvHWZxSacekiPNzvYn
         h1Y0MFpiXHygnCOeZn30hA+uGoKtEEI/6zxRxgMGCIum1F1RGHO+QabcnBsR0tHd8H0X
         bjag==
X-Gm-Message-State: AOAM533g08FlRttA3+EueQdghmISIe4inpH0PYZc7pEGMTE64Q3PWJ1A
        SytRqOZBrEV1Ca7QsLJfVYVWNQ==
X-Google-Smtp-Source: ABdhPJz8RxTwBuh5VCxsEKPELii/OLyV7DdKmnwjxoTMtu2gqnnHrzqm70OoYqtS83/xrVBs05SXow==
X-Received: by 2002:a17:90b:1249:b0:1df:257a:539a with SMTP id gx9-20020a17090b124900b001df257a539amr9957427pjb.47.1652696612277;
        Mon, 16 May 2022 03:23:32 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0050dc76281e4sm6472731pfa.190.2022.05.16.03.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:23:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v12 5/7] mm: hugetlb_vmemmap: remove hugetlb_optimize_vmemmap_enabled()
Date:   Mon, 16 May 2022 18:22:09 +0800
Message-Id: <20220516102211.41557-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220516102211.41557-1-songmuchun@bytedance.com>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
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

There is only one user of hugetlb_optimize_vmemmap_enabled() outside of
hugetlb_vmemmap, that is flush_dcache_page() in arch/arm64/mm/flush.c.
However, it does not need to call hugetlb_optimize_vmemmap_enabled()
in flush_dcache_page() since HugeTLB pages are always fully mapped
and only head page will be set PG_dcache_clean meaning only head page
's flag may need to be cleared (see commit cf5a501d985b).  After this
change, there is no users of hugetlb_optimize_vmemmap_enabled() outside
of hugetlb_vmemmap. So remove hugetlb_optimize_vmemmap_enabled() to
simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/flush.c      | 13 +++----------
 include/linux/page-flags.h | 14 ++------------
 mm/hugetlb_vmemmap.c       |  3 ++-
 3 files changed, 7 insertions(+), 23 deletions(-)

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
index b70124b9c7c1..404f4ede17f5 100644
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
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 970c36b8935f..d1fea65fec98 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -124,7 +124,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_optimize_vmemmap_enabled())
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_optimize_vmemmap_key))
 		return;
 
 	if (!is_power_of_2(sizeof(struct page))) {
-- 
2.11.0

