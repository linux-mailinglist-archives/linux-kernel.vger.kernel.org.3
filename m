Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46C58472C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiG1Upg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiG1Up0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B552E7D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha11so3058024pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=fEJL5O/8Mtexvm+J+r1cHRwPR897J/MIFhWHBeDpdlE=;
        b=LJO5mQsP4juN5xvNbTYM56FRLCmFDkgErNYmMEF/d4UxE93cf83tbCdmy5z9y3tTVw
         zvtIXcmCccQhzroNCgyJKAXd9xJJQsAEqwOqLtqm9LlRTlYodX54TFGQXZVrPzhKisjf
         ChA407NCENtAqKPBqnbCxq/18lGmRNyh0MQK7F5s22aUwo2e0C6+KqbziljzayQo10gM
         TF/fBk6+QiGIeXVyuO+eA5L3yFx/xmDbeudT6Ro6V7LI7awXDV/TljUZmi1Q/LkVlJUZ
         h/FvZe9wQP0L7CXI7zUqjl+XOisurJZgww1fpxRVLGX4AZDvUy5D45vYb6oeAUKy0Orr
         varA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=fEJL5O/8Mtexvm+J+r1cHRwPR897J/MIFhWHBeDpdlE=;
        b=4Zt6OzofHlT7hfwYxFxiGgSFsv+uUcmIpBctF2ITPxqtCR71ab+senNPZUioL72sw4
         T7XXsu7uNrWe1WgHoaMyao51zbqP/8mQdgw1Rwsp/QoISTB4NALATXFPTRaTyjxMQUVX
         9VtMM9P07EgYAxAo/iC5Cb6Zz8dAUseye3Q2z6ySyAn2+votP8nA8q1o3PT+y16UMcCy
         sfGT92RAARkr8BXf62y9kQRMfyPThJlRB7G4HugoqUXSpLU/ft1LSPpNlXCG2VZmnzKT
         TUhHS8T6l6PkDOcxfyyUzMJhYep7n6eLYm/W0MmZL4iWb8Md5KSJj5OTwUsGmehav4R3
         9Z+w==
X-Gm-Message-State: ACgBeo3cJeJBqPyz4dUT1ARTrXExgOpwPfVukFzBngjxcVYEtix2pRSI
        /T3Gm0KZquPk4rrPNlGIlac=
X-Google-Smtp-Source: AA6agR7gaJDHwuNty0e2Q772Que215+AfrAqz2a4Nol+uHZaE2IVzWbEJW8m+7P6ryUuMNqvlr67dA==
X-Received: by 2002:a17:90b:4c03:b0:1f2:b977:c64e with SMTP id na3-20020a17090b4c0300b001f2b977c64emr473596pjb.211.1659041122887;
        Thu, 28 Jul 2022 13:45:22 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:22 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 2/7] mm: move check_mm to memory.c
Date:   Fri, 29 Jul 2022 04:45:06 +0800
Message-Id: <20220728204511.56348-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

No function change, make it possible to do extra mm operation on mm exit,
prepare for following commits.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h |  3 +++
 kernel/fork.c      | 33 ---------------------------------
 mm/memory.c        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6346f7e77dc7..81ad91621078 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1993,6 +1993,9 @@ static inline bool get_user_page_fast_only(unsigned long addr,
 {
 	return get_user_pages_fast_only(addr, 1, gup_flags, pagep) == 1;
 }
+
+void check_mm(struct mm_struct *mm);
+
 /*
  * per-process(per-mm_struct) statistics.
  */
diff --git a/kernel/fork.c b/kernel/fork.c
index c090ebd55063..86a239772208 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -128,15 +128,6 @@ int nr_threads;			/* The idle threads do not count.. */
 
 static int max_threads;		/* tunable limit on nr_threads */
 
-#define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x)
-
-static const char * const resident_page_types[] = {
-	NAMED_ARRAY_INDEX(MM_FILEPAGES),
-	NAMED_ARRAY_INDEX(MM_ANONPAGES),
-	NAMED_ARRAY_INDEX(MM_SWAPENTS),
-	NAMED_ARRAY_INDEX(MM_SHMEMPAGES),
-};
-
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -748,30 +739,6 @@ static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
 
-static void check_mm(struct mm_struct *mm)
-{
-	int i;
-
-	BUILD_BUG_ON_MSG(ARRAY_SIZE(resident_page_types) != NR_MM_COUNTERS,
-			 "Please make sure 'struct resident_page_types[]' is updated as well");
-
-	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = atomic_long_read(&mm->rss_stat.count[i]);
-
-		if (unlikely(x))
-			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
-				 mm, resident_page_types[i], x);
-	}
-
-	if (mm_pgtables_bytes(mm))
-		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
-				mm_pgtables_bytes(mm));
-
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
-#endif
-}
-
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
diff --git a/mm/memory.c b/mm/memory.c
index 6bf7826e666b..c0597214f9b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -179,6 +179,38 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
 #define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
 #define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
 
+#define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x)
+static const char * const resident_page_types[] = {
+	NAMED_ARRAY_INDEX(MM_FILEPAGES),
+	NAMED_ARRAY_INDEX(MM_ANONPAGES),
+	NAMED_ARRAY_INDEX(MM_SWAPENTS),
+	NAMED_ARRAY_INDEX(MM_SHMEMPAGES),
+};
+
+void check_mm(struct mm_struct *mm)
+{
+	int i;
+
+	BUILD_BUG_ON_MSG(ARRAY_SIZE(resident_page_types) != NR_MM_COUNTERS,
+			 "Please make sure 'struct resident_page_types[]' is updated as well");
+
+	for (i = 0; i < NR_MM_COUNTERS; i++) {
+		long x = atomic_long_read(&mm->rss_stat.count[i]);
+
+		if (unlikely(x))
+			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
+				 mm, resident_page_types[i], x);
+	}
+
+	if (mm_pgtables_bytes(mm))
+		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
+				mm_pgtables_bytes(mm));
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
+	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
+#endif
+}
+
 /*
  * Note: this doesn't free the actual pages themselves. That
  * has been handled earlier when unmapping all the memory regions.
-- 
2.35.2

