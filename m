Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8447C21F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbhLUPCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhLUPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:01:50 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91972C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:48 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l17so603577qtk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=z2VhwZJp+CYNkMvAFgED+Ch239FJE+mqbH+kwAZRtjs=;
        b=Isqh/qtjAM6CifMsfjDdrpzprBY88bVNe++QqbYGtWKvcFBuirzAI8eSLjED3Yr8q+
         K7oDPwFcOSairohgieMo5fJaUSk3ooSZuchaU6ouPnieVyBf+Z59FeGZDN+/F0u1b5Nl
         GrT5P6lCepWEXlpHRGEpkNm6qhtg9jSC7cSG1N4qf4C6+XirC+wMJAFVTFCPxeHMeONP
         cVrb23Wr6/HQ33ydNc0n+tMa8LJY0iVIUicZuVRXqOe0MxFIZmGEdMuYvosUMV3neE7k
         9Scs7dNJ/vV1gn2dv0CVxKWBB5vpDAPau9zo11fySBO4QlfQCVXtinoeU+NScgXZ/d8T
         jm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2VhwZJp+CYNkMvAFgED+Ch239FJE+mqbH+kwAZRtjs=;
        b=PpYUEDU2pYQ29Y4xjDB1saC742nDW4l2FzFz//p9NWnYvTlEefoxIVhk8cj8GQEA3o
         Wnn5T8P5r8sRf67EffZEDP17qbLrnxiqDHIWRqpE0P+fIbbUsD4iOP7QbI2qU3jVeAmM
         wEx5QiJ39CIPF/AlcyptbcwZlrN2m1MxFQMyiL5ta6B0kkodozETWSV2vxTLqe6DHe2h
         WkiuvtrBSn//3dF8ox9l9VjT8ULC6dGzZGieOaqZWABjieP10ZNnjtikT9wsbK8DRfYR
         bWnDMgtD+E1BcmFoq4iYyOEm8nij7cprCseTVgUy7PUeS6o9LJk8JLGNyyxLR6QnCS6F
         dzTA==
X-Gm-Message-State: AOAM533tCfNQVLTtkg02qupvJmwBAVxcK2gxsaQ5h58/1QHNWis7B/kq
        0oOSEt+zHi2YBVXlt4vZ/sFJ2w==
X-Google-Smtp-Source: ABdhPJz6AlBZ8QhXsFxyNCcVEnd/n/MyhBcR1fXsh3p0kndyZdbgogIw17CApmd9zqCEKn07vnlowQ==
X-Received: by 2002:ac8:5a51:: with SMTP id o17mr2530376qta.180.1640098907723;
        Tue, 21 Dec 2021 07:01:47 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d4sm1991371qkn.79.2021.12.21.07.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:01:47 -0800 (PST)
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
Subject: [PATCH v2 4/9] mm: avoid using set_page_count() when pages are freed into allocator
Date:   Tue, 21 Dec 2021 15:01:35 +0000
Message-Id: <20211221150140.988298-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221150140.988298-1-pasha.tatashin@soleen.com>
References: <20211221150140.988298-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When struct pages are first initialized the page->_refcount field is
set 1. However, later when pages are freed into allocator we set
_refcount to 0 via set_page_count(). Unconditionally resetting
_refcount is dangerous.

Instead use page_ref_dec_return(), and verify that the _refcount is
what is expected.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/page_alloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5554767b9de..13d989d62012 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1667,6 +1667,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	unsigned int nr_pages = 1 << order;
 	struct page *p = page;
 	unsigned int loop;
+	int refcnt;
 
 	/*
 	 * When initializing the memmap, __init_single_page() sets the refcount
@@ -1677,10 +1678,12 @@ void __free_pages_core(struct page *page, unsigned int order)
 	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
 		prefetchw(p + 1);
 		__ClearPageReserved(p);
-		set_page_count(p, 0);
+		refcnt = page_ref_dec_return(p);
+		VM_BUG_ON_PAGE(refcnt, p);
 	}
 	__ClearPageReserved(p);
-	set_page_count(p, 0);
+	refcnt = page_ref_dec_return(p);
+	VM_BUG_ON_PAGE(refcnt, p);
 
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 
@@ -2252,10 +2255,12 @@ void __init init_cma_reserved_pageblock(struct page *page)
 {
 	unsigned i = pageblock_nr_pages;
 	struct page *p = page;
+	int refcnt;
 
 	do {
 		__ClearPageReserved(p);
-		set_page_count(p, 0);
+		refcnt = page_ref_dec_return(p);
+		VM_BUG_ON_PAGE(refcnt, p);
 	} while (++p, --i);
 
 	set_pageblock_migratetype(page, MIGRATE_CMA);
-- 
2.34.1.307.g9b7440fafd-goog

