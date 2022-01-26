Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6749D1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbiAZSeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242305AbiAZSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:38 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44780C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:38 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b22so353380qkk.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aBUwytSQMfy2PxxuYrxKtq3rfi9+4lfxfuQGWEZYavU=;
        b=l3wPcJdVsThu2Fd/44toWOV3aZBf2u1UKyJRPPbZryrarAUeut+CJwDZ8ZBn8Iu6Z1
         9gfTp4Bv075j/BwF+Ngy6Ay6sMzIDMcqa4X8TTgaUs+Im6V7S3ofLK7W93oJ0z4lz3xr
         Qq5pM6XuZ4+WM30Swh3KI2BP+9imuy0GGJRJc3Y7t/ct2om5THUg1HsY771nUugjwhNB
         o6yhRFb/OKjGZiUe0daItrOPgtpA/FyZgE2RgrIndndd8D7dpKNP5udwWejZmB+vBbc1
         b7IDp70VdgRBYRugGCONiyNlFJLAo0NVlGsvjEU/xzgfMrMAzq/Q9HVB0NvZ4Aa8v4++
         +MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBUwytSQMfy2PxxuYrxKtq3rfi9+4lfxfuQGWEZYavU=;
        b=M2VKgdYNCzOYnEn1JH39Au5T3cdsKnRhbhkh1AUeMDNM/lDvEPXUvfHu6miKhVlX9n
         o/pAj27Ey+m3kG6ud1zy6b+qJB1oKvImhTiCamyCpBIvPjO7Uc+n2Yvw/RvHcsnibpYF
         rl87Sq5jrm2jyIIjlzIe/4aRLrxoDYJGHmT3nulwRl2PddeqrctefcMPItZSWL1s+/cD
         YJ9Ey5wRPPKvXgAZMoBd1bo1ERA0MXQZ8SK+XmutE9ads/sL9DjACZF9ts2pMvz5AZYN
         TyaVV9OvDRve6XAbnqdQ++EpHBgGz+JK2cwlHLm/TexXKXgXExt4V4Lt4BDtmnO4vAEC
         6foA==
X-Gm-Message-State: AOAM531Hksuk5IxDnB1qzhcHFsyi0zCsW/8LmBiVX7mHgytg/5bnGj7r
        QU1iOBsuBQp56YuvZXTemhSP7g==
X-Google-Smtp-Source: ABdhPJzoa7OWWtfZhqM2BvNvH16AEuWpcEepXXHuHzqnh7Po9LG5Z02BFoetP3Q074/fbmgo2SkhZA==
X-Received: by 2002:a05:620a:ecb:: with SMTP id x11mr18649qkm.399.1643222077431;
        Wed, 26 Jan 2022 10:34:37 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:37 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com, hughd@google.com
Subject: [PATCH v3 5/9] mm: rename init_page_count() -> page_ref_init()
Date:   Wed, 26 Jan 2022 18:34:25 +0000
Message-Id: <20220126183429.1840447-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that set_page_count() is not called from outside anymore and about
to be removed, init_page_count() is the only function that is going to
be used to unconditionally set _refcount, however it is restricted to set
it only to 1.

Make init_page_count() aligned with the other page_ref_*
functions by renaming it.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/mm/motorola.c  |  2 +-
 include/linux/mm.h       |  2 +-
 include/linux/page_ref.h | 10 +++++++---
 mm/page_alloc.c          |  2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index ecbe948f4c1a..dd3b77d03d5c 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -133,7 +133,7 @@ void __init init_pointer_table(void *table, int type)
 
 	/* unreserve the page so it's possible to free that page */
 	__ClearPageReserved(PD_PAGE(dp));
-	init_page_count(PD_PAGE(dp));
+	page_ref_init(PD_PAGE(dp));
 
 	return;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 45bcd6f78141..cd8b9a592235 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2467,7 +2467,7 @@ extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 static inline void free_reserved_page(struct page *page)
 {
 	ClearPageReserved(page);
-	init_page_count(page);
+	page_ref_init(page);
 	__free_page(page);
 	adjust_managed_page_count(page, 1);
 }
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 03e21ce2f1bd..1af12a0d7ba1 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -107,10 +107,14 @@ static inline void folio_set_count(struct folio *folio, int v)
 }
 
 /*
- * Setup the page count before being freed into the page allocator for
- * the first time (boot or memory hotplug)
+ * Setup the page refcount to one before being freed into the page allocator.
+ * The memory might not be initialized and therefore there cannot be any
+ * assumptions about the current value of page->_refcount. This call should be
+ * done during boot when memory is being initialized, during memory hotplug
+ * when new memory is added, or when a previous reserved memory is unreserved
+ * this is the first time kernel take control of the given memory.
  */
-static inline void init_page_count(struct page *page)
+static inline void page_ref_init(struct page *page)
 {
 	set_page_count(page, 1);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0fa100152a2a..cbe444d74e8a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1570,7 +1570,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 {
 	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
-	init_page_count(page);
+	page_ref_init(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
-- 
2.35.0.rc0.227.g00780c9af4-goog

