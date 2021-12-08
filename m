Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B0346DD2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbhLHUjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbhLHUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:33 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D10C061D7E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:59 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 193so3106894qkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YwWL6Z/o+fBQkn272GUHrOKwFpx5GVVpY9HiBMHqSDs=;
        b=E/r1UW/nMI23U617YwZO+vjXw+OKz6DlXAYuajBIxQwLf3T3vkFd7Gx3U/+g/+8pzP
         MsHRp5v5mN6kE+Y7/d0xUWxmlo/ogk9drp/nNqcv08CU9uWvYB3gEIxPY8OC4ueGG2Vx
         nfpnaUMHxVVtt6IedABv1h32rAgQFs2/oDHWUUinKS+Xjdc7EPP5I2/XR2rd8m9GO3r9
         LP1eGNDYDEzz6Wn+7agY3wNr2DrgufEHrPGBbqAo05It5qkj8f+vZqbo8tZV96Z1C5VH
         GPfAkx5Zuh5aKZ5kHxLn0Ly0RyWB7OTjBHdclRxbH9mCZHuXCUulAXvvy7abpkGXT/sN
         4rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwWL6Z/o+fBQkn272GUHrOKwFpx5GVVpY9HiBMHqSDs=;
        b=pChCoSpC2tm5/H5J7NnpliP1s2R4ajSjHxbn6zTKBMPJlh76KO2aTSRdpxLQEQbWZG
         z6BR/Y/sZscqRMNi9NvqIuoEO9EkKF0iDo9WYI8rw10BIrypWyObHEd6MDhSU+uVRGu6
         qfzMklCAvrRCjol2M7uH0dRyWYVVlfMRLhLjxDanSCw/+Iwo5IWQWf73BJi9dT4zLeSq
         meVA5QisdPwDbT9hyJ2a1+gj8O9d59nq1oSABmdeM36nblI6nDP3N6KFYYvV/1Eo9Swt
         cAOEoU+Tt7pvflr+w66O7zH/7g3BWG2lO5AUmfobrQZwz3Lmzw9w6vl94WXTXf7VusF0
         ezJQ==
X-Gm-Message-State: AOAM531Z+mTT0J+OECgaoL5ys3sJ6rcKIIWLnzGuutkrmjc0gElcXHr4
        kU4jpM49cLmkIdRxs8BdEyuNcw==
X-Google-Smtp-Source: ABdhPJw8PsTjimMkXokwcJPuWrBR8MiYuAdRR0FVOvY9hXv7QDJPR7++qhOXgzPxoUlHi6ZzdxmsAQ==
X-Received: by 2002:a05:620a:85e:: with SMTP id u30mr9299824qku.765.1638995758934;
        Wed, 08 Dec 2021 12:35:58 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:58 -0800 (PST)
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
Subject: [PATCH 08/10] mm: simplify page_ref_* functions
Date:   Wed,  8 Dec 2021 20:35:42 +0000
Message-Id: <20211208203544.2297121-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
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
 include/trace/events/page_ref.h |  24 ++------
 mm/debug_page_ref.c             |  14 -----
 3 files changed, 34 insertions(+), 106 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index c7033f506d68..8c76bf3bf7e1 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -8,8 +8,6 @@
 #include <linux/tracepoint-defs.h>
 
 DECLARE_TRACEPOINT(page_ref_init);
-DECLARE_TRACEPOINT(page_ref_mod);
-DECLARE_TRACEPOINT(page_ref_mod_and_test);
 DECLARE_TRACEPOINT(page_ref_mod_and_return);
 DECLARE_TRACEPOINT(page_ref_add_unless);
 DECLARE_TRACEPOINT(page_ref_freeze);
@@ -27,8 +25,6 @@ DECLARE_TRACEPOINT(page_ref_unfreeze);
 #define page_ref_tracepoint_active(t) tracepoint_enabled(t)
 
 extern void __page_ref_init(struct page *page);
-extern void __page_ref_mod(struct page *page, int v);
-extern void __page_ref_mod_and_test(struct page *page, int v, int ret);
 extern void __page_ref_mod_and_return(struct page *page, int v, int ret);
 extern void __page_ref_add_unless(struct page *page, int v, int u, int ret);
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
index 2b8e5a4df53b..600ea20c3e11 100644
--- a/include/trace/events/page_ref.h
+++ b/include/trace/events/page_ref.h
@@ -49,7 +49,7 @@ DEFINE_EVENT(page_ref_init_template, page_ref_init,
 	TP_ARGS(page)
 );
 
-DECLARE_EVENT_CLASS(page_ref_mod_template,
+DECLARE_EVENT_CLASS(page_ref_unfreeze_template,
 
 	TP_PROTO(struct page *page, int v),
 
@@ -83,14 +83,7 @@ DECLARE_EVENT_CLASS(page_ref_mod_template,
 		__entry->val)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_mod,
-
-	TP_PROTO(struct page *page, int v),
-
-	TP_ARGS(page, v)
-);
-
-DECLARE_EVENT_CLASS(page_ref_mod_and_test_template,
+DECLARE_EVENT_CLASS(page_ref_mod_template,
 
 	TP_PROTO(struct page *page, int v, int ret),
 
@@ -163,14 +156,7 @@ DECLARE_EVENT_CLASS(page_ref_add_unless_template,
 		__entry->val, __entry->unless, __entry->ret)
 );
 
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_test,
-
-	TP_PROTO(struct page *page, int v, int ret),
-
-	TP_ARGS(page, v, ret)
-);
-
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_mod_and_return,
+DEFINE_EVENT(page_ref_mod_template, page_ref_mod_and_return,
 
 	TP_PROTO(struct page *page, int v, int ret),
 
@@ -184,14 +170,14 @@ DEFINE_EVENT(page_ref_add_unless_template, page_ref_add_unless,
 	TP_ARGS(page, v, u, ret)
 );
 
-DEFINE_EVENT(page_ref_mod_and_test_template, page_ref_freeze,
+DEFINE_EVENT(page_ref_mod_template, page_ref_freeze,
 
 	TP_PROTO(struct page *page, int v, int ret),
 
 	TP_ARGS(page, v, ret)
 );
 
-DEFINE_EVENT(page_ref_mod_template, page_ref_unfreeze,
+DEFINE_EVENT(page_ref_unfreeze_template, page_ref_unfreeze,
 
 	TP_PROTO(struct page *page, int v),
 
diff --git a/mm/debug_page_ref.c b/mm/debug_page_ref.c
index ad21abfec463..f5f39a77c6da 100644
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
2.34.1.400.ga245620fadb-goog

