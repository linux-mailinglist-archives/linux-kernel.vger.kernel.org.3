Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67449D1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbiAZSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbiAZSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:40 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A5C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:40 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d8so644559qvv.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C+eeUKO5CVQ7ifoeaB9j3JsCJ7+YnH2kUfg22hZzWck=;
        b=XlIIm3wFS2VYZgNZKO5PJxQyYem5gwT2tE11aOfFUFxbLG8yhzwPtal/KkTwyPV6jq
         hq7je5EMTfT6eIOKF0UtJyZGr1AEA80ucW0fZFZ+kF+1ZAhRp7G19Ib/V2EsejOfjrI1
         0k35qJFNU3ZaGcaTggA7hfMLQZc+gq+K8Fh2KbqC7/Dwdv9U7IVlrAAUt0EeGa5cz6ae
         SDb/wUBW1tkvRbnTEIoKDAiSr7Qy5GL0TJ9Eq+cgV9VvvI5FZtpeXiyi9roHEEO0sGY7
         owIqf2CsLI7NGOad5+EtsSD7l8LN6widewoojQRFBiDTVsa0S9IXPM5RqIvlqslly+iL
         xLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+eeUKO5CVQ7ifoeaB9j3JsCJ7+YnH2kUfg22hZzWck=;
        b=UVE/jluTClGLedVZ6ppMpXNz7gK8WjUpKWOGCqQE+sMmnU7rNTrRuuSN0xE2gNr9G8
         xPXaOEXpWpu/3RqgbJDmpwfInRfXfIP3J/DKUdEyoSA6QWX5juOnSpgjg8LmQIrRDe7q
         xNY2oA0Nf2A7Fc9GbOUnree2cj02VCLh6muRGoAeQJV9ytdz1SfKjgyDqcWZv44wwlo/
         Xj4gsHRX3KuKvIhzJ3Sxmknc1RZ+/ABcszBqtHhdT8XPxyZEmU+lZc8yZel5I4wAsEgZ
         xNSv+kckrf7aeLc3I/aoRCR4M4KJCaLmR2WzYEOzer8JaKWQNtQ4dmAkil7TwPuGgU8f
         QC3w==
X-Gm-Message-State: AOAM532E2Tr3rr/JVXfzNEYTkXHKTzxJCu4MJkGPKTIJUlbyRUjS0+Ey
        p+z/lAmJCDJjwkjQOV8n7J3zpg==
X-Google-Smtp-Source: ABdhPJwtx1adUUMZjurVfu5lfu5E+GD/aExk1KJah16hTOTHhksPValmJe7VDZJFddjF2UR8dJc5hg==
X-Received: by 2002:a05:6214:c82:: with SMTP id r2mr6785664qvr.81.1643222079173;
        Wed, 26 Jan 2022 10:34:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:38 -0800 (PST)
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
Subject: [PATCH v3 7/9] mm: simplify page_ref_* functions
Date:   Wed, 26 Jan 2022 18:34:27 +0000
Message-Id: <20220126183429.1840447-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we are using atomic_fetch* variants to add/sub/inc/dec page
_refcount, it makes sense to combined page_ref_* return and non return
functions.

Also remove some extra trace points for non-return  variants. This
improves the tracability by always recording the new _refcount value
after the modifications has occurred.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h        | 102 +++++++++-----------------------
 include/trace/events/page_ref.h |  18 +-----
 mm/debug_page_ref.c             |  14 -----
 3 files changed, 31 insertions(+), 103 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index d7316881626c..243fc60ae6c8 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -8,8 +8,6 @@
 #include <linux/tracepoint-defs.h>
 
 DECLARE_TRACEPOINT(page_ref_init);
-DECLARE_TRACEPOINT(page_ref_mod);
-DECLARE_TRACEPOINT(page_ref_mod_and_test);
 DECLARE_TRACEPOINT(page_ref_mod_and_return);
 DECLARE_TRACEPOINT(page_ref_mod_unless);
 DECLARE_TRACEPOINT(page_ref_freeze);
@@ -27,8 +25,6 @@ DECLARE_TRACEPOINT(page_ref_unfreeze);
 #define page_ref_tracepoint_active(t) tracepoint_enabled(t)
 
 extern void __page_ref_init(struct page *page);
-extern void __page_ref_mod(struct page *page, int v);
-extern void __page_ref_mod_and_test(struct page *page, int v, int ret);
 extern void __page_ref_mod_and_return(struct page *page, int v, int ret);
 extern void __page_ref_mod_unless(struct page *page, int v, int u);
 extern void __page_ref_freeze(struct page *page, int v, int ret);
@@ -41,12 +37,6 @@ extern void __page_ref_unfreeze(struct page *page, int v);
 static inline void __page_ref_init(struct page *page)
 {
 }
-static inline void __page_ref_mod(struct page *page, int v)
-{
-}
-static inline void __page_ref_mod_and_test(struct page *page, int v, int ret)
-{
-}
 static inline void __page_ref_mod_and_return(struct page *page, int v, int ret)
 {
 }
@@ -127,12 +117,7 @@ static inline int page_ref_add_return(struct page *page, int nr)
 
 static inline void page_ref_add(struct page *page, int nr)
 {
-	int old_val = atomic_fetch_add(nr, &page->_refcount);
-	int new_val = old_val + nr;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, nr);
+	page_ref_add_return(page, nr);
 }
 
 static inline void folio_ref_add(struct folio *folio, int nr)
@@ -140,30 +125,25 @@ static inline void folio_ref_add(struct folio *folio, int nr)
 	page_ref_add(&folio->page, nr);
 }
 
-static inline void page_ref_sub(struct page *page, int nr)
+static inline int page_ref_sub_return(struct page *page, int nr)
 {
 	int old_val = atomic_fetch_sub(nr, &page->_refcount);
 	int new_val = old_val - nr;
 
 	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, -nr);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, -nr, new_val);
+	return new_val;
 }
 
-static inline void folio_ref_sub(struct folio *folio, int nr)
+static inline void page_ref_sub(struct page *page, int nr)
 {
-	page_ref_sub(&folio->page, nr);
+	page_ref_sub_return(page, nr);
 }
 
-static inline int page_ref_sub_return(struct page *page, int nr)
+static inline void folio_ref_sub(struct folio *folio, int nr)
 {
-	int old_val = atomic_fetch_sub(nr, &page->_refcount);
-	int new_val = old_val - nr;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -nr, new_val);
-	return new_val;
+	page_ref_sub(&folio->page, nr);
 }
 
 static inline int folio_ref_sub_return(struct folio *folio, int nr)
@@ -171,14 +151,20 @@ static inline int folio_ref_sub_return(struct folio *folio, int nr)
 	return page_ref_sub_return(&folio->page, nr);
 }
 
-static inline void page_ref_inc(struct page *page)
+static inline int page_ref_inc_return(struct page *page)
 {
 	int old_val = atomic_fetch_inc(&page->_refcount);
 	int new_val = old_val + 1;
 
 	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, 1);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, 1, new_val);
+	return new_val;
+}
+
+static inline void page_ref_inc(struct page *page)
+{
+	page_ref_inc_return(page);
 }
 
 static inline void folio_ref_inc(struct folio *folio)
@@ -186,14 +172,20 @@ static inline void folio_ref_inc(struct folio *folio)
 	page_ref_inc(&folio->page);
 }
 
-static inline void page_ref_dec(struct page *page)
+static inline int page_ref_dec_return(struct page *page)
 {
 	int old_val = atomic_fetch_dec(&page->_refcount);
 	int new_val = old_val - 1;
 
 	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod))
-		__page_ref_mod(page, -1);
+	if (page_ref_tracepoint_active(page_ref_mod_and_return))
+		__page_ref_mod_and_return(page, -1, new_val);
+	return new_val;
+}
+
+static inline void page_ref_dec(struct page *page)
+{
+	page_ref_dec_return(page);
 }
 
 static inline void folio_ref_dec(struct folio *folio)
@@ -203,14 +195,7 @@ static inline void folio_ref_dec(struct folio *folio)
 
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
-	int old_val = atomic_fetch_sub(nr, &page->_refcount);
-	int new_val = old_val - nr;
-	int ret = new_val == 0;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_test))
-		__page_ref_mod_and_test(page, -nr, ret);
-	return ret;
+	return page_ref_sub_return(page, nr) == 0;
 }
 
 static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
@@ -218,17 +203,6 @@ static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
 	return page_ref_sub_and_test(&folio->page, nr);
 }
 
-static inline int page_ref_inc_return(struct page *page)
-{
-	int old_val = atomic_fetch_inc(&page->_refcount);
-	int new_val = old_val + 1;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, 1, new_val);
-	return new_val;
-}
-
 static inline int folio_ref_inc_return(struct folio *folio)
 {
 	return page_ref_inc_return(&folio->page);
@@ -236,14 +210,7 @@ static inline int folio_ref_inc_return(struct folio *folio)
 
 static inline int page_ref_dec_and_test(struct page *page)
 {
-	int old_val = atomic_fetch_dec(&page->_refcount);
-	int new_val = old_val - 1;
-	int ret = new_val == 0;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_test))
-		__page_ref_mod_and_test(page, -1, ret);
-	return ret;
+	return page_ref_dec_return(page) == 0;
 }
 
 static inline int folio_ref_dec_and_test(struct folio *folio)
@@ -251,17 +218,6 @@ static inline int folio_ref_dec_and_test(struct folio *folio)
 	return page_ref_dec_and_test(&folio->page);
 }
 
-static inline int page_ref_dec_return(struct page *page)
-{
-	int old_val = atomic_fetch_dec(&page->_refcount);
-	int new_val = old_val - 1;
-
-	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
-	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -1, new_val);
-	return new_val;
-}
-
 static inline int folio_ref_dec_return(struct folio *folio)
 {
 	return page_ref_dec_return(&folio->page);
diff --git a/include/trace/events/page_ref.h b/include/trace/events/page_ref.h
index 87551bb1df9e..35cd795aa7c6 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -49,7 +49,7 @@ DEFINE_EVENT(page_ref_init_template, page_ref_init,
 	TP_ARGS(page)
 );
 
-DECLARE_EVENT_CLASS(page_ref_mod_template,
+DECLARE_EVENT_CLASS(page_ref_unfreeze_template,
 
 	TP_PROTO(struct page *page, int v),
 
@@ -83,13 +83,6 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_mod,
-
-	TP_PROTO(struct page *page, int v),
-
-	TP_ARGS(page, v)
-);
-
 DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 
 	TP_PROTO(struct page *page, int v, int ret),
@@ -126,13 +119,6 @@ DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
 		__entry->val, __entry->ret)
 );
 
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_test,
-
-	TP_PROTO(struct page *page, int v, int ret),
-
-	TP_ARGS(page, v, ret)
-);
-
 DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_return,
 
 	TP_PROTO(struct page *page, int v, int ret),
@@ -154,7 +140,7 @@ DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_freeze,
 	TP_ARGS(page, v, ret)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_unfreeze,
+DEFINE_EVENT(page_ref_unfreeze_template, page_ref_unfreeze,
 
 	TP_PROTO(struct page *page, int v),
 
diff --git a/mm/debug_page_ref.c b/mm/debug_page_ref.c
index e32149734122..1de9d93cca25 100644
--- a/mm/debug_page_ref.c
+++ b/mm/debug_page_ref.c
@@ -12,20 +12,6 @@ void __page_ref_init(struct page *page)
 EXPORT_SYMBOL(__page_ref_init);
 EXPORT_TRACEPOINT_SYMBOL(page_ref_init);
 
-void __page_ref_mod(struct page *page, int v)
-{
-	trace_page_ref_mod(page, v);
-}
-EXPORT_SYMBOL(__page_ref_mod);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_mod);
-
-void __page_ref_mod_and_test(struct page *page, int v, int ret)
-{
-	trace_page_ref_mod_and_test(page, v, ret);
-}
-EXPORT_SYMBOL(__page_ref_mod_and_test);
-EXPORT_TRACEPOINT_SYMBOL(page_ref_mod_and_test);
-
 void __page_ref_mod_and_return(struct page *page, int v, int ret)
 {
 	trace_page_ref_mod_and_return(page, v, ret);
-- 
2.35.0.rc0.227.g00780c9af4-goog

