Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEC46DD2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhLHUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbhLHUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:30 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67761C061B38
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:58 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id a24so3309013qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nFlqSAxjHRTohPVW75pf8hfyBbKzHbgE+SMNZ8WyTOw=;
        b=W8Cl1HqSgamLrsbyj88V9dAY9gM+b3j959c+eLQP6RfgNi1HBomES3PqdfvKvNP/mL
         c9Fsd55wwvkoiO3iUJ4uO2ItAZO8Q/1TgyPGRf2JNqB/9EHeNj4Y60cVhbjNWosx4Ob1
         IenzOcVguLX75xLpGoonD29DI7NDe4SRvRPE7agbiwDMNyNuicf6xTp78XMFmX3wibd3
         zPp0Rf0q8uS7U3chIPlS9ZkkCREyjbpYCtHW3ecEAOkILiQszfu58rgVkvTPkOmSBWQP
         nM29S+Gcro5luZ5vtdR+fc8QXlec6Ueec4u9znIOVOSgAndCFNJYVpEh10mbc+p/SEWJ
         qHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFlqSAxjHRTohPVW75pf8hfyBbKzHbgE+SMNZ8WyTOw=;
        b=REyjyHkhCRNtCb9zJrXSF1l4Rpo6m4w8xf3V9TyRmQmhmQxYZuJv+5PR5in5kVnTUM
         4vlhVgNMC3gBAUOeBmR5fmdrjyPQwBULqNA/8wkHd3Hai1gVIJWwxH+SWiVgxSDuD0Va
         CFXlRoBjKSUthac44Bdm5GuuLv5EOZHO8+2LS7r6OsDssUg2VYF7T4IcFW3JgmzibkAO
         yEL36Pkh4ccDyN3isdzZUyrcLUboR38/paxEt8cjrNziWHn4Acl8t+ClvdzqqD2BTjEW
         trhwUFsX6J1krDTdMysIOtIpLZYsLw75Cd0GY7gO9WtL5jK/KGSHZDiu+faYUORCjBhH
         e8cA==
X-Gm-Message-State: AOAM532K/DluWj7e+dLHBcMJYD9XDpBAVBg/n9RMZv5Kvyij66DGLaji
        lESQvFfc3cOV6ejZYL590F04cA==
X-Google-Smtp-Source: ABdhPJxZHH62p453Nmc2nRkAwRrMlxRykexAEhKok4wf3RDqtJOIhBUDkUS9nroexMlzP1I7Vj7ACg==
X-Received: by 2002:ad4:50c7:: with SMTP id e7mr10269127qvq.53.1638995757597;
        Wed, 08 Dec 2021 12:35:57 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:56 -0800 (PST)
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
Subject: [PATCH 07/10] mm: remove set_page_count()
Date:   Wed,  8 Dec 2021 20:35:41 +0000
Message-Id: <20211208203544.2297121-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_count() is dangerous because it resets _refcount to an
arbitrary value. Instead we now initialize _refcount to 1 only once,
and the rest of the time we are using add/dec/cmpxchg to have a
contiguous track of the counter.

Remove set_page_count() and add new tracing hooks to page_ref_init().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h        | 27 ++++++++-----------
 include/trace/events/page_ref.h | 46 ++++++++++++++++++++++++++++-----
 mm/debug_page_ref.c             |  8 +++---
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index ff946d753df8..c7033f506d68 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -7,7 +7,7 @@
 #include <linux/page-flags.h>
 #include <linux/tracepoint-defs.h>
 
-DECLARE_TRACEPOINT(page_ref_set);
+DECLARE_TRACEPOINT(page_ref_init);
 DECLARE_TRACEPOINT(page_ref_mod);
 DECLARE_TRACEPOINT(page_ref_mod_and_test);
 DECLARE_TRACEPOINT(page_ref_mod_and_return);
@@ -26,7 +26,7 @@ DECLARE_TRACEPOINT(page_ref_unfreeze);
  */
 #define page_ref_tracepoint_active(t) tracepoint_enabled(t)
 
-extern void __page_ref_set(struct page *page, int v);
+extern void __page_ref_init(struct page *page);
 extern void __page_ref_mod(struct page *page, int v);
 extern void __page_ref_mod_and_test(struct page *page, int v, int ret);
 extern void __page_ref_mod_and_return(struct page *page, int v, int ret);
@@ -38,7 +38,7 @@ extern void __page_ref_unfreeze(struct page *page, int v);
 
 #define page_ref_tracepoint_active(t) false
 
-static inline void __page_ref_set(struct page *page, int v)
+static inline void __page_ref_init(struct page *page)
 {
 }
 static inline void __page_ref_mod(struct page *page, int v)
@@ -94,18 +94,6 @@ static inline int page_count(const struct page *page)
 	return folio_ref_count(page_folio(page));
 }
 
-static inline void set_page_count(struct page *page, int v)
-{
-	atomic_set(&page->_refcount, v);
-	if (page_ref_tracepoint_active(page_ref_set))
-		__page_ref_set(page, v);
-}
-
-static inline void folio_set_count(struct folio *folio, int v)
-{
-	set_page_count(&folio->page, v);
-}
-
 /*
  * Setup the page refcount to one before being freed into the page allocator.
  * The memory might not be initialized and therefore there cannot be any
@@ -116,7 +104,14 @@ static inline void folio_set_count(struct folio *folio, int v)
  */
 static inline void page_ref_init(struct page *page)
 {
-	set_page_count(page, 1);
+	atomic_set(&page->_refcount, 1);
+	if (page_ref_tracepoint_active(page_ref_init))
+		__page_ref_init(page);
+}
+
+static inline void folio_ref_init(struct folio *folio)
+{
+	page_ref_init(&folio->page);
 }
 
 static inline int page_ref_add_return(struct page *page, int nr)
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index c32d6d161cdb..2b8e5a4df53b 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -10,6 +10,45 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+DECLARE_EVENT_CLASS(page_ref_init_template,
+
+	TP_PROTO(struct page *page),
+
+	TP_ARGS(page),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned long, flags)
+		__field(int, count)
+		__field(int, mapcount)
+		__field(void *, mapping)
+		__field(int, mt)
+		__field(int, val)
+	),
+
+	TP_fast_assign(
+		__entry->pfn = page_to_pfn(page);
+		__entry->flags = page->flags;
+		__entry->count = page_ref_count(page);
+		__entry->mapcount = page_mapcount(page);
+		__entry->mapping = page->mapping;
+		__entry->mt = get_pageblock_migratetype(page);
+	),
+
+	TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d",
+		__entry->pfn,
+		show_page_flags(__entry->flags & PAGEFLAGS_MASK),
+		__entry->count,
+		__entry->mapcount, __entry->mapping, __entry->mt)
+);
+
+DEFINE_EVENT(page_ref_init_template, page_ref_init,
+
+	TP_PROTO(struct page *page),
+
+	TP_ARGS(page)
+);
+
 DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_PROTO(struct page *page, int v),
@@ -44,13 +83,6 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_set,
-
-	TP_PROTO(struct page *page, int v),
-
-	TP_ARGS(page, v)
-);
-
 DEFINE_EVENT(page_ref_mod_template, page_ref_mod,
 
 	TP_PROTO(struct page *page, int v),
diff --git a/mm/debug_page_ref.c b/mm/debug_page_ref.c
index 1426d6887b01..ad21abfec463 100644
--- a/mm/debug_page_ref.c
+++ b/mm/debug_page_ref.c
@@ -5,12 +5,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_ref.h>
 
-void __page_ref_set(struct page *page, int v)
+void __page_ref_init(struct page *page)
 {
-	trace_page_ref_set(page, v);
+	trace_page_ref_init(page);
 }
-EXPORT_SYMBOL(__page_ref_set);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_set);
+EXPORT_SYMBOL(__page_ref_init);
+EXPORT_TRACEPOINT_SYMBOL(page_ref_init);
 
 void __page_ref_mod(struct page *page, int v)
 {
-- 
2.34.1.400.ga245620fadb-goog

