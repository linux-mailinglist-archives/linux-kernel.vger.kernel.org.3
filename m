Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC23849D1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbiAZSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiAZSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:34:38 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8BFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:37 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id k4so619703qvt.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ie3wyi01fH7CgmQYiqIN+tfxdxDxn1n1+kzHm4Q9RTE=;
        b=Bh400EnOT890ni7sht/44ozXW/6kzxp07ZHx7PHxWuPEpO5UWUblrE8yWYYEvyOZpy
         MEeDREPxYzJitlr3ychWp4Zzd53yjtbV1lTT6U4sXKY5QOs8eT0Ao/oZIAnwcHjyATZz
         tvRrEJaOpgFl+PLRLGNYDmv7E1xAUepdJHaTNhjB3fefVxY+fVJFRhn6o2dRH5BjqRJo
         syBZkBNB2cBomk/aVeT/u9aFQAkG7UcRC0tnPO4eZmPSZcT6zo03CZ/wyTukDnwagYtN
         RZjniCisA268LqO5pXzQ5ABPwHsfQoiYEfCJwAa8+UqYzT3ImXNuyo7FY6tV1pzS48q6
         1hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie3wyi01fH7CgmQYiqIN+tfxdxDxn1n1+kzHm4Q9RTE=;
        b=PJ61KNsnoyNP98n2lrokeiNRIgLhqS7BOIo89p+RAAT56oCTmIwXRr3OpUTgNfWO/0
         Xl7Zd9BMcAFtANwyRx2uFXcmMpPmjYcIk/JcVR4CH1OtQlx7E/ir+eSg2PjHD0XeICXe
         sk2N7dCA3t5MjDg7jS7qSgyDsztwwtZO+3QtKjLrgzrCxpL3w0CqCvrFp425U7+uUaGf
         29AX9Un/MHzgd2YsSER4zuMY8luBceBuU0LPY3+aZHRYz0UyaKAThtR6SCfN1zD/DeiX
         +FPqFmL3ceC57390psp3djnkuIcjDHWsZZJmRKTcsEFxdCVzGpENQ2y5n/U4Y8J2Mjyl
         8+AA==
X-Gm-Message-State: AOAM530T3IdQ7NXeci4j3vKQhDoQfZCAyM0Kdi4WrTmP0acdYZFrG6mH
        SP6sFpKUX09CREAAMF84rNAnug==
X-Google-Smtp-Source: ABdhPJzoIdGrjBW0d47PH4jGXBlBszWnfJdkQI7JvZmOWO27z83YtLTGz3Vk6XtP2izWkdLA7bnMTg==
X-Received: by 2002:a05:6214:21c4:: with SMTP id d4mr22950102qvh.90.1643222076515;
        Wed, 26 Jan 2022 10:34:36 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id u17sm35886qki.12.2022.01.26.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:34:35 -0800 (PST)
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
Subject: [PATCH v3 4/9] mm: avoid using set_page_count() when pages are freed into allocator
Date:   Wed, 26 Jan 2022 18:34:24 +0000
Message-Id: <20220126183429.1840447-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
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
index 5a9167bda279..0fa100152a2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1668,6 +1668,7 @@ void __free_pages_core(struct page *page, unsigned int order)
 	unsigned int nr_pages = 1 << order;
 	struct page *p = page;
 	unsigned int loop;
+	int refcnt;
 
 	/*
 	 * When initializing the memmap, __init_single_page() sets the refcount
@@ -1678,10 +1679,12 @@ void __free_pages_core(struct page *page, unsigned int order)
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
 
@@ -2253,10 +2256,12 @@ void __init init_cma_reserved_pageblock(struct page *page)
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
2.35.0.rc0.227.g00780c9af4-goog

