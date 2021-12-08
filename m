Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024346DD2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbhLHUji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbhLHUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:29 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68FC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:57 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id s9so3267923qvk.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fl012lbYwxHxKLRGEaFCBukqf325ONY6vMrvhFzajc4=;
        b=Om3EKJa9JkBQ3/exYw2B3y8QcQXr3XLHAWmrsf1qrbGoMy+A2cGu5jReBvGVCPkR4+
         hDBjqch1JjgL2dikAiy5MOULE1bwntbfSVyT4+pceFLvXwveMW3o+Af3gExKwl068JS8
         nMaKnEQUNNnHWgl27+yFR+aLuie6VxwdMa2Twg6vh9I/RhI9u9ewOILF8ekONEAKfdOy
         n0U8XSXFs1uRKi/7Y4+a2EmEqIHl/h6UuyQk/KCCT29WCO5RX6Jb4/SwhT1lY6YMkO3c
         n5jqn+4cKGoNBN4nHw0Hm0EHXkQzfjvDQQ1+mkDUNr82JvE/5Tr304ypL3ylLkxC9Ztp
         hG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fl012lbYwxHxKLRGEaFCBukqf325ONY6vMrvhFzajc4=;
        b=ik32Xmr2W/C4lL9hUG1sWRS5G2aD+rC/bDe+jYXQ8EOxtgIHJayc1HBqobZHrvcb7n
         UYFF/PPNpBG0abJZYDd5521fU/eCQzI/5aFmCIwkyQKN/qvUclX2EKiIpsb3F+X/AUgY
         y5K+yf7hKqQZHJZXxAtL8JvgQm7BZcZw2YNRvKwRqcghx0yPg9INeXboB2Qt2QuwFV1w
         N71Oz7U7A1gKcKZrFYLPsjy1stiKilxsHm2IlynyirTnWcQMoEXC/7tgCWdUAbCb2hle
         kdcRYUas9eoAsnzjtP6zUOA/bwiRS+A81hsmrDpTKdEXSWZofYqyu+jHKaIvsDV/ZLrL
         0UWA==
X-Gm-Message-State: AOAM5315bX9aNX1l9SKlEphWzE7G1yPUP+asolzskIvHx8CQMEKknRzG
        VO5+F9hL2Lj9BhMZtvAZ9r6b7A==
X-Google-Smtp-Source: ABdhPJz0AXqWQx1xH0f1dHb3b35gcDCp0zKrnLcKzYEmnuKLPzBR55Tmt/GsDZa4yfAJbxQLl1V2kA==
X-Received: by 2002:a05:6214:21ae:: with SMTP id t14mr10996719qvc.66.1638995756224;
        Wed, 08 Dec 2021 12:35:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:55 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [PATCH 06/10] mm: rename init_page_count() -> page_ref_init()
Date:   Wed,  8 Dec 2021 20:35:40 +0000
Message-Id: <20211208203544.2297121-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
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
index 44d75a8d1b92..9a0ba44d4cde 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2470,7 +2470,7 @@ extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
 static inline void free_reserved_page(struct page *page)
 {
 	ClearPageReserved(page);
-	init_page_count(page);
+	page_ref_init(page);
 	__free_page(page);
 	adjust_managed_page_count(page, 1);
 }
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 27880aca2e2f..ff946d753df8 100644
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
index 13d989d62012..000c057a2d24 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1569,7 +1569,7 @@ static void __meminit __init_single_page(struct page *page, unsigned long pfn,
 {
 	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
-	init_page_count(page);
+	page_ref_init(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
-- 
2.34.1.400.ga245620fadb-goog

