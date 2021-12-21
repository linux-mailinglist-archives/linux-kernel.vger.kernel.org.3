Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9047C221
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbhLUPCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbhLUPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE483C061747
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:52 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id fo11so12669196qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jaGLmQY52APl8v98fQta2llNqqHuAoOAllJQBEPRHxk=;
        b=eBNsLd7ARojSEaIKr1fNBnwoyaIGKyZ1YHAKdIfcl9DOJfyYTkckGPZbs6qzYnm8KF
         UJGzZZh8frzcL5dLuDfj2s2helG8nS8rsopxSfDzz9tw/cLdXPv2mCjPvrstIh/YQPYO
         MbaoqWmM6lsBlKCaN1uZQkuIZ41kY/Gcg1uwL/9zkiAhhYTohOSNbbZBjIn2BSzk9Nm0
         q/s7BnOn/guBwmkQKFZUpYCqMI3XtWH6SDbIOS1QqygMsL4z0JmE0xbqcgBZAaN02AU7
         azLIyYmAUcTHEF5X85XZmwKKXfDKkG6YkmrdODo9qNwJSKd0aZg2I6SaJzvz7h66dyAp
         JdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaGLmQY52APl8v98fQta2llNqqHuAoOAllJQBEPRHxk=;
        b=nxmwcr2RRv8oPLisMfkYz8gPmWQ3D+wGB1T5w5SlTq+IUFhcqX9aXJDX+9B0NN9HEi
         +BcGwmnqffBLnTao5T/MUOdMLYIFIX6ElhmF4GTla2Dn+GT4lh7mxgoxM006/phaB+n+
         WxH3LRUhJQ0bF6YwVTAkKaslC03Ewtb/LXCsk6nhXm/Vqv/bIqew/C0mxAhl8UVMOj4S
         FfaeuOUV1K8p5owG3z5JNOdB7CONUbGibLS5/BuCzu5iSVTUSJdPP8x+Rwn2LUPJnyGC
         UabDF5pnj7B5JIXHkxrioErybDBltvieRKJZ5MbKyFcXg2cjNfD779ODUJemv1uQcqJt
         tFFw==
X-Gm-Message-State: AOAM531TAkZjTYaJmqNVfHoxeYxkZkt73px6mOvUJ/YG58yAcj6Qe/oI
        +TmGlvNVyhxw3QJR3Z2+rf1w/g==
X-Google-Smtp-Source: ABdhPJwMlFRiSYhQumZA31hM2R0ePuuAlQ2ZhyLXodIAC4YlYRRVox4HfZF1uSX5tXZr7Hd0UOKJ3A==
X-Received: by 2002:a0c:8e08:: with SMTP id v8mr2635635qvb.93.1640098910549;
        Tue, 21 Dec 2021 07:01:50 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4sm1991371qkn.79.2021.12.21.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:01:50 -0800 (PST)
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
Subject: [PATCH v2 7/9] mm: simplify page_ref_* functions
Date:   Tue, 21 Dec 2021 15:01:38 +0000
Message-Id: <20211221150140.988298-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221150140.988298-1-pasha.tatashin@soleen.com>
References: <20211221150140.988298-1-pasha.tatashin@soleen.com>
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
2.34.1.307.g9b7440fafd-goog

