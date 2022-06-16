Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903E054D8F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350500AbiFPDjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350019AbiFPDi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:38:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EE51CFDF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:38:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x4so354395pfj.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aA0bMLWCkX8joHM6kPyEJlVGECicVquhYI8922nCQz4=;
        b=ErYObbUHDVmgvnYdsWtz3niZfP5DYxbLeCOUtZgeWlKf0L9+ZDj0vFxlsunSw7B0CP
         EG+l69sWFVL15VSVbXEgMYqXhthBc4nFZmg9Cab3qwnYpBFvObiJTLVLR6ieFcstYNAX
         5FTuobf27g+Hy9kMI1iKncJXhpUhipwL2QnA8ekZq3XtMjHXb3ktTsCOiDIVvvHKpk4C
         Nhq38qJBY+a3p7UQoAniqj/elhforsnXbi3hRqf/XvehRihXA3FaVWkQauau1Lfwg6lU
         Z52/f18hEm2Jxa5xF5t4lQvA+jD7VV/vDo/0rFH7H5yZUyzw6fzfjD9eXudckKgFxIRe
         X14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aA0bMLWCkX8joHM6kPyEJlVGECicVquhYI8922nCQz4=;
        b=ZXpvmSZd0UrE1x2gXheIWHMR6G8tx/jZ+8Zw4/G8R4ZicJPzA5IEcltERb+Uu0gUrs
         +hHRucLCUMMxrVRU0BCge7hqQpPVtCBUgTBQl0gB6Xv+Kozgengz30qUhKSfzKFhekEg
         vLrqEvmkaymymDlfbD6Xh8aDn6phhuZQUU48EAbkLUj2Z+pJ0zRLCqxc5WDBdFAC0XEe
         d8+LWcKKb+yScBLotnqY9/11FmSOUL9cOTMHAbJ4B7+/KWLJXKSKmZrgYemxE6cEVNWS
         wVPhBe1nVNCe0RvAgbe3A6TYf2bXNJBJhNWJl7JlifV18w0f4j9tiCc9vGj38Wiphli1
         ho3Q==
X-Gm-Message-State: AJIora/6YcjQ+CPXMelnU6Y8XvM5CcwAV6KjTSsFIA/IvhpnzA2gyz8H
        SIgA0UH85eqiiPvN4zUq3fatxQ==
X-Google-Smtp-Source: AGRyM1tXAvYaFZ/5GuRhLfbNjT24Z2aXZm5tmRhpuKjL0KuJWz9SCQ8gTxJg7ujAwbdGV2E3KSMLEQ==
X-Received: by 2002:a65:5b08:0:b0:401:cf39:c35c with SMTP id y8-20020a655b08000000b00401cf39c35cmr2688285pgq.396.1655350736495;
        Wed, 15 Jun 2022 20:38:56 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h189-20020a62dec6000000b0050dc762813csm441308pfg.22.2022.06.15.20.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 20:38:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: hugetlb: remove minimum_order variable
Date:   Thu, 16 Jun 2022 11:38:46 +0800
Message-Id: <20220616033846.96937-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit:

  commit 641844f5616d ("mm/hugetlb: introduce minimum hugepage order")

fixed a static checker warning and introduced a global variable minimum_order
to fix the warning.  However, the local variable in dissolve_free_huge_pages()
can be initialized to huge_page_order(&default_hstate) to fix the warning.
So remove minimum_order to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8ea4e51d8186..405d1c7441c9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -66,12 +66,6 @@ static bool hugetlb_cma_page(struct page *page, unsigned int order)
 #endif
 static unsigned long hugetlb_cma_size __initdata;
 
-/*
- * Minimum page order among possible hugepage sizes, set to a proper value
- * at boot time.
- */
-static unsigned int minimum_order __read_mostly = UINT_MAX;
-
 __initdata LIST_HEAD(huge_boot_pages);
 
 /* for command line parsing */
@@ -2161,11 +2155,17 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned long pfn;
 	struct page *page;
 	int rc = 0;
+	unsigned int order;
+	struct hstate *h;
 
 	if (!hugepages_supported())
 		return rc;
 
-	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
+	order = huge_page_order(&default_hstate);
+	for_each_hstate(h)
+		order = min(order, huge_page_order(h));
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << order) {
 		page = pfn_to_page(pfn);
 		rc = dissolve_free_huge_page(page);
 		if (rc)
@@ -3157,9 +3157,6 @@ static void __init hugetlb_init_hstates(void)
 	struct hstate *h, *h2;
 
 	for_each_hstate(h) {
-		if (minimum_order > huge_page_order(h))
-			minimum_order = huge_page_order(h);
-
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
@@ -3184,7 +3181,6 @@ static void __init hugetlb_init_hstates(void)
 				h->demote_order = h2->order;
 		}
 	}
-	VM_BUG_ON(minimum_order == UINT_MAX);
 }
 
 static void __init report_hugepages(void)
-- 
2.11.0

