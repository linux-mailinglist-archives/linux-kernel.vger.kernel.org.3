Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8746DD28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhLHUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbhLHUjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:23 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89765C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:51 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id b11so3295252qvm.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I9hjX1+HYuhymLX54rLUMz7Fb9EGj/+yboeTN9cuaik=;
        b=HosY8k6M8KwXj6waxDnv3fHeVcX5Kq3aV4Cio/Yqj+URHnbpB1uDy980igrfzOtCWb
         IV9Ql7Hv0H+V5EqD5k3wF/nsGUQ+40ZLc8aHxm26PeReE38pz8SXuKeey3xF3jlqLwUI
         KUJM84C2WGGHz6BSz5IuHVeTT7qrRplmwkA6hiUew2pn/l1xkLhtd1r96vvL/S+nxcjz
         qPLWOYhkqO1+TaLW7xQEzG8fBueeiJrbFZQfAVZntDUxxB1sGQFJInZLOByVOf/pIzoP
         cenMjmG35J+4kOLZhasRGfFkQGoehZ6qUqF32ewLoCsiMacqDVT9D5390hBA3Kko0bqP
         kNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9hjX1+HYuhymLX54rLUMz7Fb9EGj/+yboeTN9cuaik=;
        b=zcQeDRAuGoLndnisfMJ5h5h4hHwL1yU9djUizJbjhsJpTKOHg8xQzdIH7+CHUovxYb
         SnFdsUAy4ot6Zey9xbXlwgcyEpQDB6qlbvGvAIHUw8hJ0yZKuBJNhyQzCVvY7/aKq53x
         eRMVTHXSxbxWLCnNcSFn+GcECeK4CvMZvszEPFtS3gzrY6YM0AFQL85Q87Tj5w0YSmfQ
         rM0HjxZw8XhBZFQUwycOcFY35GXDIT9UUovCLPGlJueoiarrO1Fw0Pr964SxyvKBAWWR
         +zkinMilUTnt79B9mh8Rxa8w7jh5o/pW4mtTA7dqGXcMgVA1aKl3nJox9fdSKmwrPK29
         S3vA==
X-Gm-Message-State: AOAM530gsyfbXTw0rGmIsHG6nNA4zc9ynDDcFLZ9rLAnHhbGlbZREsdH
        fpAbx+JMYSbxOn5ImZAOZwyLCVsVEmUuRQ==
X-Google-Smtp-Source: ABdhPJyB+Xz22eIWfi+LFrWo3avfTpkeZv3Hz7oSjfE9RUr8pK1GkW6k4oxFk4Q5BcZpLm8kYBqxSQ==
X-Received: by 2002:ad4:5bac:: with SMTP id 12mr10895900qvq.63.1638995750347;
        Wed, 08 Dec 2021 12:35:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:49 -0800 (PST)
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
Subject: [PATCH 02/10] mm: add overflow and underflow checks for page->_refcount
Date:   Wed,  8 Dec 2021 20:35:36 +0000
Message-Id: <20211208203544.2297121-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problems with page->_refcount are hard to debug, because usually
when they are detected, the damage has occurred a long time ago. Yet,
the problems with invalid page refcount may be catastrophic and lead to
memory corruptions.

Reduce the scope of when the _refcount problems manifest themselves by
adding checks for underflows and overflows into functions that modify
_refcount.

Use atomic_fetch_* functions to get the old values of the _refcount,
and use it to check for overflow/underflow.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 59 +++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 1903af5fb087..f3c61dc6344a 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -117,7 +117,10 @@ static inline void init_page_count(struct page *page)
 
 static inline void page_ref_add(struct page *page, int nr)
 {
-	atomic_add(nr, &page->_refcount);
+	int old_val = atomic_fetch_add(nr, &page->_refcount);
+	int new_val = old_val + nr;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, nr);
 }
@@ -129,7 +132,10 @@ static inline void folio_ref_add(struct folio *folio, int nr)
 
 static inline void page_ref_sub(struct page *page, int nr)
 {
-	atomic_sub(nr, &page->_refcount);
+	int old_val = atomic_fetch_sub(nr, &page->_refcount);
+	int new_val = old_val - nr;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, -nr);
 }
@@ -141,11 +147,13 @@ static inline void folio_ref_sub(struct folio *folio, int nr)
 
 static inline int page_ref_sub_return(struct page *page, int nr)
 {
-	int ret = atomic_sub_return(nr, &page->_refcount);
+	int old_val = atomic_fetch_sub(nr, &page->_refcount);
+	int new_val = old_val - nr;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -nr, ret);
-	return ret;
+		__page_ref_mod_and_return(page, -nr, new_val);
+	return new_val;
 }
 
 static inline int folio_ref_sub_return(struct folio *folio, int nr)
@@ -155,7 +163,10 @@ static inline int folio_ref_sub_return(struct folio *folio, int nr)
 
 static inline void page_ref_inc(struct page *page)
 {
-	atomic_inc(&page->_refcount);
+	int old_val = atomic_fetch_inc(&page->_refcount);
+	int new_val = old_val + 1;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, 1);
 }
@@ -167,7 +178,10 @@ static inline void folio_ref_inc(struct folio *folio)
 
 static inline void page_ref_dec(struct page *page)
 {
-	atomic_dec(&page->_refcount);
+	int old_val = atomic_fetch_dec(&page->_refcount);
+	int new_val = old_val - 1;
+
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod))
 		__page_ref_mod(page, -1);
 }
@@ -179,8 +193,11 @@ static inline void folio_ref_dec(struct folio *folio)
 
 static inline int page_ref_sub_and_test(struct page *page, int nr)
 {
-	int ret = atomic_sub_and_test(nr, &page->_refcount);
+	int old_val = atomic_fetch_sub(nr, &page->_refcount);
+	int new_val = old_val - nr;
+	int ret = new_val == 0;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -nr, ret);
 	return ret;
@@ -193,11 +210,13 @@ static inline int folio_ref_sub_and_test(struct folio *folio, int nr)
 
 static inline int page_ref_inc_return(struct page *page)
 {
-	int ret = atomic_inc_return(&page->_refcount);
+	int old_val = atomic_fetch_inc(&page->_refcount);
+	int new_val = old_val + 1;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, 1, ret);
-	return ret;
+		__page_ref_mod_and_return(page, 1, new_val);
+	return new_val;
 }
 
 static inline int folio_ref_inc_return(struct folio *folio)
@@ -207,8 +226,11 @@ static inline int folio_ref_inc_return(struct folio *folio)
 
 static inline int page_ref_dec_and_test(struct page *page)
 {
-	int ret = atomic_dec_and_test(&page->_refcount);
+	int old_val = atomic_fetch_dec(&page->_refcount);
+	int new_val = old_val - 1;
+	int ret = new_val == 0;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_test))
 		__page_ref_mod_and_test(page, -1, ret);
 	return ret;
@@ -221,11 +243,13 @@ static inline int folio_ref_dec_and_test(struct folio *folio)
 
 static inline int page_ref_dec_return(struct page *page)
 {
-	int ret = atomic_dec_return(&page->_refcount);
+	int old_val = atomic_fetch_dec(&page->_refcount);
+	int new_val = old_val - 1;
 
+	VM_BUG_ON_PAGE((unsigned int)new_val > (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_mod_and_return))
-		__page_ref_mod_and_return(page, -1, ret);
-	return ret;
+		__page_ref_mod_and_return(page, -1, new_val);
+	return new_val;
 }
 
 static inline int folio_ref_dec_return(struct folio *folio)
@@ -235,8 +259,11 @@ static inline int folio_ref_dec_return(struct folio *folio)
 
 static inline bool page_ref_add_unless(struct page *page, int nr, int u)
 {
-	bool ret = atomic_add_unless(&page->_refcount, nr, u);
+	int old_val = atomic_fetch_add_unless(&page->_refcount, nr, u);
+	int new_val = old_val + nr;
+	int ret = old_val != u;
 
+	VM_BUG_ON_PAGE(ret && (unsigned int)new_val < (unsigned int)old_val, page);
 	if (page_ref_tracepoint_active(page_ref_add_unless))
 		__page_ref_add_unless(page, nr, u, ret);
 	return ret;
-- 
2.34.1.400.ga245620fadb-goog

