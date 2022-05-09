Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDEA51FAAD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiEILFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiEILE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:04:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E06222C2C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:01:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so16671946pjv.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh8Q/KvNuhUqACFeqsQV2T1sVIozPsF9U1lcARGxZeI=;
        b=ZxSdbIS2ZWZlnQRxzJ9+QdFDYogt3VJySniueW++bzx/HyauWYkmgTLRR+0vFxIGtj
         KsOT7SkViIB3J13U7og8tKuvd4DS3rawovJxNXug3FgyVblYaj95VZr/TbPrfqkw4OwB
         uUmJxH4y0zUWiamwK3ZcS8fH8m8MiZ9IWeVtXYghqAQbpeiUTSUONGLNCa+FjIxRkgtr
         I2AhQ/5O5ZKkCUBup3/zcTMPWw3vY33vj/tT3aaGogUtfI584oTfWsxyQToDzKqqqRVo
         lmocWhOmcYkeS3M760hkIGGe4Pfgp4ytK+w/4TZHIERGD3ZpSGXjhARW07eLbSCQs6Zf
         kS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh8Q/KvNuhUqACFeqsQV2T1sVIozPsF9U1lcARGxZeI=;
        b=D6hkVJgB2CkV0hWe+o3R++EE55Aw3XKdC75aZgcRUQAubQGhCda9Ms3nXkBMBjEsuM
         Defh1K1AkSj4Xq8qNaNAxjZGFCKQldOjo/6Jx2ufbqdNnNfBcdrrebjeQXH/nG77pEnx
         DLqjRt3UrP78ugPy9/3gmMMMroiilUqzkJtS0rU2qlo1ToXWYFEDYLMF3mByQAv6kKGm
         tq78zjRgu0x5iR3CxHzUy8j9IgM5xU4swbHANCvwk6AqvDLcMM3YOIwd71YzxqxoV2v5
         TMyxb6s6gDzsfYQOL6EUo0QiNAqpWRnTpCnDII5JbQfx53jXNUgF2IBMSM3iV5hmy5DZ
         oFgw==
X-Gm-Message-State: AOAM532eHI1VadcvTMPf2PTdyCDjCdKA0RhiwLWqFYhzEnwBA6pX+EUt
        lxdgUsgg+rr9NM34oWpe/+Irpg==
X-Google-Smtp-Source: ABdhPJx+fU8dUrM5IVwoZn/ILMFer/x3N87PdLxZhj/Brm/n0VW9GFWDnNWNGaOBopn9Ncaaz3NanA==
X-Received: by 2002:a17:902:bc4c:b0:15f:12dc:7c85 with SMTP id t12-20020a170902bc4c00b0015f12dc7c85mr4518856plz.108.1652094061885;
        Mon, 09 May 2022 04:01:01 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0015e8d4eb244sm6813303plp.142.2022.05.09.04.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:01:01 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/5] mm/memory-failure.c: move clear_hwpoisoned_pages
Date:   Mon,  9 May 2022 18:56:37 +0800
Message-Id: <20220509105641.491313-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509105641.491313-1-pizhenwei@bytedance.com>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
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

clear_hwpoisoned_pages() clears HWPoison flag and decreases the number
of poisoned pages, this actually works as part of memory failure.

Move this function from sparse.c to memory-failure.c, finally there
is no CONFIG_MEMORY_FAILURE in sparse.c.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/internal.h       | 11 +++++++++++
 mm/memory-failure.c | 21 +++++++++++++++++++++
 mm/sparse.c         | 27 ---------------------------
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cf16280ce132..84dd6aa7ba97 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -634,6 +634,9 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
 }
 #endif
 
+/*
+ * mm/memory-failure.c
+ */
 extern int hwpoison_filter(struct page *p);
 
 extern u32 hwpoison_filter_dev_major;
@@ -643,6 +646,14 @@ extern u64 hwpoison_filter_flags_value;
 extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
 
+#ifdef CONFIG_MEMORY_FAILURE
+void clear_hwpoisoned_pages(struct page *memmap, int nr_pages);
+#else
+static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+{
+}
+#endif
+
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
         unsigned long, unsigned long);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 27760c19bad7..46d9fb612dcc 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2401,3 +2401,24 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 	return ret;
 }
+
+void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+{
+	int i;
+
+	/*
+	 * A further optimization is to have per section refcounted
+	 * num_poisoned_pages.  But that would need more space per memmap, so
+	 * for now just do a quick global check to speed up this routine in the
+	 * absence of bad pages.
+	 */
+	if (atomic_long_read(&num_poisoned_pages) == 0)
+		return;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (PageHWPoison(&memmap[i])) {
+			num_poisoned_pages_dec();
+			ClearPageHWPoison(&memmap[i]);
+		}
+	}
+}
diff --git a/mm/sparse.c b/mm/sparse.c
index 952f06d8f373..e983c38fac8f 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -916,33 +916,6 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	return 0;
 }
 
-#ifdef CONFIG_MEMORY_FAILURE
-static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
-{
-	int i;
-
-	/*
-	 * A further optimization is to have per section refcounted
-	 * num_poisoned_pages.  But that would need more space per memmap, so
-	 * for now just do a quick global check to speed up this routine in the
-	 * absence of bad pages.
-	 */
-	if (atomic_long_read(&num_poisoned_pages) == 0)
-		return;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (PageHWPoison(&memmap[i])) {
-			num_poisoned_pages_dec();
-			ClearPageHWPoison(&memmap[i]);
-		}
-	}
-}
-#else
-static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
-{
-}
-#endif
-
 void sparse_remove_section(struct mem_section *ms, unsigned long pfn,
 		unsigned long nr_pages, unsigned long map_offset,
 		struct vmem_altmap *altmap)
-- 
2.20.1

