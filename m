Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1825A514CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377282AbiD2O3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377276AbiD2O31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:29:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A67A146B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:09 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so7266546pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bv/fStdq6ItGSIRgfJIMLGnpap9t2FGZ2OvlOaFaeWo=;
        b=B9bahcbgBihTWUcGpr1y9wdTOE681iugnbfHR9qCDQA4YABUzHRuUKS27S18bX3/ok
         AHi/ufJYHhcOLpBWgPszCtyGT5POqSKIi23SH7fqKhKnfDw4YX5504HVLTUe3Il3kbga
         +Yr5187+ILwCXa9r3uOa4P7oXT7DqOmioyrLtU2ZEt6W1aTejmcK/48UJFhwVPshNcPS
         Uj26EpLI6dgRChSmFpizSZMaSWhrtQ6LgIiw22sJROjdcIEHk/bdbDHnOvuyJtFXA4VU
         ziC1PuRgCVhN4C6xJweBqxxuKQWGjDr5AXoq0jKMmuRLjMjKkz4sYHcpjcPU9Q1BxU5u
         JidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bv/fStdq6ItGSIRgfJIMLGnpap9t2FGZ2OvlOaFaeWo=;
        b=pRF5fiV7MrvmyneQWCjrSWBgSalfcdTVexDc/qsC+98wqEXpF+d3ZoGxXfFSYwPlyh
         AnrXqCfA+q+Fp2Lu7HICoYUkL+uytjmJXwVSP09Mu6cAG49z0TJf3CetdbKhs3Syhd5r
         DVXDS76IkBgDugJxU2pF+KRuFqD4x3s8mDCAgyDnn/vSk96kuRNlGgb0Zbk8FBEA+zGp
         NC4vD2rR40Xyg+FIbxKJkhNPRtWVIwoMw3IJd7nUQc92ovuG7D/yCmit+T2zXiqoKi3F
         e/mT39FXYADWjeKKsVZfw7d6Ra2qmok5QGBpmYuDpeg4WwArUmuEnH28vAWMxrmqrGxT
         SWJA==
X-Gm-Message-State: AOAM531jkjxFZOK9CA87g4AFikAMege99wxbHVIjeLsA0b7qUjFreTa9
        TilrqCmAIil4lDVdKd++W2usOw==
X-Google-Smtp-Source: ABdhPJyDytkpIn1JuFR5NC67SSAiS8dbKsZT5/R63KZRQjoACdv5mT58ogS7YGaoccx35GcYCqcZHg==
X-Received: by 2002:a17:902:db0e:b0:15e:60a0:7b9 with SMTP id m14-20020a170902db0e00b0015e60a007b9mr8572959plx.55.1651242368521;
        Fri, 29 Apr 2022 07:26:08 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm3494734pfx.72.2022.04.29.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:26:07 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 1/4] mm/memory-failure.c: move clear_hwpoisoned_pages
Date:   Fri, 29 Apr 2022 22:22:03 +0800
Message-Id: <20220429142206.294714-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429142206.294714-1-pizhenwei@bytedance.com>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_hwpoisoned_pages() clears HWPoison flag and decreases the number
of poisoned pages, this actually works as part of memory failure.

Move this function from sparse.c to memory-failure.c, finally there
is no CONFIG_MEMORY_FAILURE in sparse.c.

Cc: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/internal.h       | 11 +++++++++++
 mm/memory-failure.c | 21 +++++++++++++++++++++
 mm/sparse.c         | 27 ---------------------------
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cf16280ce132..e8add8df4e0f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -758,4 +758,15 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
 
 DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
+/*
+ * mm/memory-failure.c
+ */
+#ifdef CONFIG_MEMORY_FAILURE
+void clear_hwpoisoned_pages(struct page *memmap, int nr_pages);
+#else
+static inline void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
+{
+}
+#endif
+
 #endif	/* __MM_INTERNAL_H */
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

