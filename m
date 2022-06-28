Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96EA55DA7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbiF1JZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344163AbiF1JY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C9821AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q140so11632031pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcU70QMaMfr3g25zaA8M15gvbgJmAnvOkNkO5LYq9Xk=;
        b=nxmq2NL1AsajSBuAASKmt7L1Ndphc4w4VDOV8lBInHq4/aQsuByXWdxEZnI9OjDrgz
         EHF5dVo71EC7lBBR1SdcpIM4kymuL6tfuB/WSHGErVoaOEdagQ4urXNcFRhXJnqVBe6q
         GgmY+X6nkhHeYXVaogO6IWsCqj8/A7AGDUdY21r4Tl00bHDdFT8JpzM54bnf6xpQOnQJ
         pDECDo2F2Zpct3+7IZx6V1+6Wq3gSI1fcI9Q278MtG+mnjiNWWGVr3ea+CBns4LgBg6K
         dvrHpnBYs2FdLlM2U0GTT75Lbrbqq8jprIO7BoXCtofAbd4lMzGPSnJIu5i/hn2lUu7Q
         ll8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcU70QMaMfr3g25zaA8M15gvbgJmAnvOkNkO5LYq9Xk=;
        b=bvdQISRLbbxw9W+JDhg5RX5v6MnNCfcUu8RQq1CxOCZS5D3NgXUx34asGXBI6q9VqU
         kNnla2D4GMHVSBsBlVKbhHjz0vgQIG7h7h6Xus08eLvd2l6/rm5Gr+Yte9H7SuMmSbfD
         72dVuiEWa5ua7eNqB3oQMMc5FyXb/MkjlH01E54YnHUToc6TzzlGVzza80CLSL56ZbDt
         I/YcYfq0gWSnsUaGr7lDnDOrqBiiAh7alpywjh3UntqJ2UPNf0FABrDnmMqj+7QTcyeA
         wsG3awCYMu1eo5siQ7zZEmaPK8+zxEdKGwWGF4zqhlt5QlfU7QT4NE5kDkBSYK9LZcck
         KzOQ==
X-Gm-Message-State: AJIora9CocZo+d1QvZBvlH18dhK5eXBhyaWoYX/IsIyChZx1f9eDdb1c
        CanEns0CCCfxS091A5S9YoX2zA==
X-Google-Smtp-Source: AGRyM1tICWGYY59eelLzcQWEILTXv80hvBvwVj1VoT/MD0xt3s4Kr1fmosQR+9g95CUba/+n3Pje0g==
X-Received: by 2002:a63:eb0e:0:b0:40d:c8d5:3fa7 with SMTP id t14-20020a63eb0e000000b0040dc8d53fa7mr13895023pgh.331.1656408258490;
        Tue, 28 Jun 2022 02:24:18 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:24:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 7/8] mm: hugetlb_vmemmap: move code comments to vmemmap_dedup.rst
Date:   Tue, 28 Jun 2022 17:22:34 +0800
Message-Id: <20220628092235.91270-8-songmuchun@bytedance.com>
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

All the comments which explains how HVO works are moved to vmemmap_dedup.rst since

  commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")

except some comments above page_fixed_fake_head(). This commit move those comments
to vmemmap_dedup.rst and improve vmemmap_dedup.rst as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/vm/vmemmap_dedup.rst | 70 +++++++++++++++++++++++++-------------
 include/linux/page-flags.h         | 15 ++------
 2 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/Documentation/vm/vmemmap_dedup.rst b/Documentation/vm/vmemmap_dedup.rst
index 7d7a161aa364..a4b12ff906c4 100644
--- a/Documentation/vm/vmemmap_dedup.rst
+++ b/Documentation/vm/vmemmap_dedup.rst
@@ -9,23 +9,23 @@ HugeTLB
 
 This section is to explain how HugeTLB Vmemmap Optimization (HVO) works.
 
-The struct page structures (page structs) are used to describe a physical
-page frame. By default, there is a one-to-one mapping from a page frame to
-it's corresponding page struct.
+The ``struct page`` structures are used to describe a physical page frame. By
+default, there is a one-to-one mapping from a page frame to it's corresponding
+``struct page``.
 
 HugeTLB pages consist of multiple base page size pages and is supported by many
 architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
 details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
 currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
 consists of 512 base pages and a 1GB HugeTLB page consists of 4096 base pages.
-For each base page, there is a corresponding page struct.
+For each base page, there is a corresponding ``struct page``.
 
-Within the HugeTLB subsystem, only the first 4 page structs are used to
-contain unique information about a HugeTLB page. __NR_USED_SUBPAGE provides
-this upper limit. The only 'useful' information in the remaining page structs
+Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to
+contain unique information about a HugeTLB page. ``__NR_USED_SUBPAGE`` provides
+this upper limit. The only 'useful' information in the remaining ``struct page``
 is the compound_head field, and this field is the same for all tail pages.
 
-By removing redundant page structs for HugeTLB pages, memory can be returned
+By removing redundant ``struct page`` for HugeTLB pages, memory can be returned
 to the buddy allocator for other uses.
 
 Different architectures support different HugeTLB pages. For example, the
@@ -46,7 +46,7 @@ page.
 |              |   64KB    |    2MB    |  512MB    |    16GB   |           |
 +--------------+-----------+-----------+-----------+-----------+-----------+
 
-When the system boot up, every HugeTLB page has more than one struct page
+When the system boot up, every HugeTLB page has more than one ``struct page``
 structs which size is (unit: pages)::
 
    struct_size = HugeTLB_Size / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
@@ -76,10 +76,10 @@ Where n is how many pte entries which one page can contains. So the value of
 n is (PAGE_SIZE / sizeof(pte_t)).
 
 This optimization only supports 64-bit system, so the value of sizeof(pte_t)
-is 8. And this optimization also applicable only when the size of struct page
-is a power of two. In most cases, the size of struct page is 64 bytes (e.g.
+is 8. And this optimization also applicable only when the size of ``struct page``
+is a power of two. In most cases, the size of ``struct page`` is 64 bytes (e.g.
 x86-64 and arm64). So if we use pmd level mapping for a HugeTLB page, the
-size of struct page structs of it is 8 page frames which size depends on the
+size of ``struct page`` structs of it is 8 page frames which size depends on the
 size of the base page.
 
 For the HugeTLB page of the pud level mapping, then::
@@ -88,7 +88,7 @@ For the HugeTLB page of the pud level mapping, then::
                = PAGE_SIZE / 8 * 8 (pages)
                = PAGE_SIZE (pages)
 
-Where the struct_size(pmd) is the size of the struct page structs of a
+Where the struct_size(pmd) is the size of the ``struct page`` structs of a
 HugeTLB page of the pmd level mapping.
 
 E.g.: A 2MB HugeTLB page on x86_64 consists in 8 page frames while 1GB
@@ -96,7 +96,7 @@ HugeTLB page consists in 4096.
 
 Next, we take the pmd level mapping of the HugeTLB page as an example to
 show the internal implementation of this optimization. There are 8 pages
-struct page structs associated with a HugeTLB page which is pmd mapped.
+``struct page`` structs associated with a HugeTLB page which is pmd mapped.
 
 Here is how things look before optimization::
 
@@ -124,10 +124,10 @@ Here is how things look before optimization::
  +-----------+
 
 The value of page->compound_head is the same for all tail pages. The first
-page of page structs (page 0) associated with the HugeTLB page contains the 4
-page structs necessary to describe the HugeTLB. The only use of the remaining
-pages of page structs (page 1 to page 7) is to point to page->compound_head.
-Therefore, we can remap pages 1 to 7 to page 0. Only 1 page of page structs
+page of ``struct page`` (page 0) associated with the HugeTLB page contains the 4
+``struct page`` necessary to describe the HugeTLB. The only use of the remaining
+pages of ``struct page`` (page 1 to page 7) is to point to page->compound_head.
+Therefore, we can remap pages 1 to 7 to page 0. Only 1 page of ``struct page``
 will be used for each HugeTLB page. This will allow us to free the remaining
 7 pages to the buddy allocator.
 
@@ -169,13 +169,37 @@ entries that can be cached in a single TLB entry.
 
 The contiguous bit is used to increase the mapping size at the pmd and pte
 (last) level. So this type of HugeTLB page can be optimized only when its
-size of the struct page structs is greater than 1 page.
+size of the ``struct page`` structs is greater than **1** page.
 
 Notice: The head vmemmap page is not freed to the buddy allocator and all
 tail vmemmap pages are mapped to the head vmemmap page frame. So we can see
-more than one struct page struct with PG_head (e.g. 8 per 2 MB HugeTLB page)
-associated with each HugeTLB page. The compound_head() can handle this
-correctly (more details refer to the comment above compound_head()).
+more than one ``struct page`` struct with ``PG_head`` (e.g. 8 per 2 MB HugeTLB
+page) associated with each HugeTLB page. The ``compound_head()`` can handle
+this correctly. There is only **one** head ``struct page``, the tail
+``struct page`` with ``PG_head`` are fake head ``struct page``.  We need an
+approach to distinguish between those two different types of ``struct page`` so
+that ``compound_head()`` can return the real head ``struct page`` when the
+parameter is the tail ``struct page`` but with ``PG_head``. The following code
+snippet describes how to distinguish between real and fake head ``struct page``.
+
+.. code-block:: c
+
+	if (test_bit(PG_head, &page->flags)) {
+		unsigned long head = READ_ONCE(page[1].compound_head);
+
+		if (head & 1) {
+			if (head == (unsigned long)page + 1)
+				/* head struct page */
+			else
+				/* tail struct page */
+		} else {
+			/* head struct page */
+		}
+	}
+
+We can safely access the field of the **page[1]** with ``PG_head`` because the
+page is a compound page composed with at least two contiguous pages.
+The implementation refers to ``page_fixed_fake_head()``.
 
 Device DAX
 ==========
@@ -189,7 +213,7 @@ PMD_SIZE (2M on x86_64) and PUD_SIZE (1G on x86_64).
 
 The differences with HugeTLB are relatively minor.
 
-It only use 3 page structs for storing all information as opposed
+It only use 3 ``struct page`` for storing all information as opposed
 to 4 on HugeTLB pages.
 
 There's no remapping of vmemmap given that device-dax memory is not part of
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 78ed46ae6ee5..62864cad4a2a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -208,19 +208,8 @@ enum pageflags {
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
 /*
- * If HVO is enabled, the head vmemmap page frame is reused and all of the tail
- * vmemmap addresses map to the head vmemmap page frame (furture details can
- * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
- * words, there are more than one page struct with PG_head associated with each
- * HugeTLB page.  We __know__ that there is only one head page struct, the tail
- * page structs with PG_head are fake head page structs.  We need an approach
- * to distinguish between those two different types of page structs so that
- * compound_head() can return the real head page struct when the parameter is
- * the tail page struct but with PG_head.
- *
- * The page_fixed_fake_head() returns the real head page struct if the @page is
- * fake page head, otherwise, returns @page which can either be a true page
- * head or tail.
+ * Return the real head page struct iff the @page is a fake head page, otherwise
+ * return the @page itself. See Documentation/vm/vmemmap_dedup.rst.
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-- 
2.11.0

