Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C476539430
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiEaPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242996AbiEaPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:43:59 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9738CB10
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 08:43:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654011834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEpZdGz90JlT1Su1SZxeM3e97n4OjIjhauOVgJs/x+Q=;
        b=ce+LyTosve/iVH9saoGKtCpSbSXfRease5nqKzuWRouhIjfI3dDzxtv5+qtA5s+Y92VtF2
        wmJc5Qx8+aVF8+Uy8hMCmvAxR0hDqKOY8q+ijFj7KZt2K+NkCDldH2Z2GMZLcCO9Z4X82d
        Ki5a5OuzdcgrA4nhqYI0GSIKITJBrVM=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 2/3] mm: introduce clear_highpage_tagged
Date:   Tue, 31 May 2022 17:43:49 +0200
Message-Id: <d6ba060f18999a00052180c2c10536226b50438a.1654011120.git.andreyknvl@google.com>
In-Reply-To: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
References: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add a clear_highpage_tagged() helper that does clear_highpage() on a
page potentially tagged by KASAN.

This helper is used by the following patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/highmem.h | 11 +++++++++++
 mm/page_alloc.c         |  8 ++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330..df76a0db7cec 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -243,6 +243,17 @@ static inline void clear_highpage(struct page *page)
 	kunmap_local(kaddr);
 }
 
+static inline void clear_highpage_tagged(struct page *page)
+{
+	u8 tag;
+
+	tag = page_kasan_tag(page);
+	page_kasan_tag_reset(page);
+	clear_highpage(page);
+	page_kasan_tag_set(page, tag);
+
+}
+
 #ifndef __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
 
 static inline void tag_clear_highpage(struct page *page)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 66ef8c310dce..d82ea983a7a3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1302,12 +1302,8 @@ static void kernel_init_pages(struct page *page, int numpages)
 
 	/* s390's use of memset() could override KASAN redzones. */
 	kasan_disable_current();
-	for (i = 0; i < numpages; i++) {
-		u8 tag = page_kasan_tag(page + i);
-		page_kasan_tag_reset(page + i);
-		clear_highpage(page + i);
-		page_kasan_tag_set(page + i, tag);
-	}
+	for (i = 0; i < numpages; i++)
+		clear_highpage_tagged(page + i);
 	kasan_enable_current();
 }
 
-- 
2.25.1

