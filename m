Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600AB514CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377290AbiD2O3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377285AbiD2O3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:29:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9AFA204B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so7440876pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGExzK6t7dd69Krcot/v5EkylhF9Hy7HssTipfBZX74=;
        b=Bkz2/5SRLbrHbVzULhavc/a1oIXG99dDy7QXZHOZj5UhtxUk8y+cyNNxkJnTmy7nAj
         6drqFLY5zpKQISTwcY2skEr3ddI9vvIcxAYBcRIzQVXdYQwGQqPuIKKDw4SmBcrADFjO
         Hsgc0vHImTWdDqW7xeb26itD5h+E3sXVm6cAolgrPFDwe/xoa/M+T3Lq22KMGvmdhm/W
         brBD+6isKt1TgDq68Wr4m7hq6sniSpXM0/AvdpUHlPI8wM1srSdmmgve4JElnyfkY+e2
         lrXSMIsGRtlYMM1BgxG5798w0aNSqA2jtQSumpI60SFMKEcTH/H2wCXauFn9k2TNP7hx
         nsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGExzK6t7dd69Krcot/v5EkylhF9Hy7HssTipfBZX74=;
        b=nGlhcdKYB2mks/4JWEs/ai51yhpe8i5Sh+3bkxRtOjLGK9SogEXYzlZpagZHmAfg0Y
         PpJZdw/i8nPlS8TkGqcNF+hlsH1vtgNRnW3RquDTJeccYAfOJaZODDacpuYRkwgtkRob
         WlFMk/gP85dWf4muBfjg7iB9Gg0p1NESZFSwzq148seQXYq7c+zgRDW5bywV7bBdQFOS
         uBPZtsapCrUBtJM4uS0ZpcayW168fskUO/OnJwaWQc23/IzVKAXw9oHV3deO5NTE9zYm
         x0AMoIxcsI7rU4Fo7A+Vl2Mm3EFp54FGmeys8AiZMIl/Z5neThGyDSu0HfLuH59OhX/j
         YGmA==
X-Gm-Message-State: AOAM530pHqhqmPLn1E7pYC+bajny+EW0q2uWmep496xqI/zebOCBvRwa
        MShXz9NVUGAXsAewf/RGdh5/Trs9U9So1A==
X-Google-Smtp-Source: ABdhPJxP8Q5SO8edgR+USzWqy4H5Ykj0bNqW2c6nuPK6WA0RgU1MELBsfC5sVatzu38ZTdzy+BJNsg==
X-Received: by 2002:a17:90b:1c87:b0:1ca:f4e:4fbe with SMTP id oo7-20020a17090b1c8700b001ca0f4e4fbemr4184643pjb.159.1651242371947;
        Fri, 29 Apr 2022 07:26:11 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm3494734pfx.72.2022.04.29.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:26:11 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/4] mm/memofy-failure.c:: simplify num_poisoned_pages_dec
Date:   Fri, 29 Apr 2022 22:22:04 +0800
Message-Id: <20220429142206.294714-3-pizhenwei@bytedance.com>
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

Don't descrease the number of poisoned pages in page_alloc.c, let the
memory-failure.c do inc/dec poisoned pages only.

Also simplify unpoison_memory(), only descrease the number of
poisoned pages when:
 - TestClearPageHWPoison() succeed
 - put_page_back_buddy succeed

After descreasing, print necessary log.

Finally, remove clear_page_hwpoison() and unpoison_taken_off_page().

Cc: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 37 +++++++++----------------------------
 mm/page_alloc.c     |  1 -
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 46d9fb612dcc..ece05858568f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2101,28 +2101,6 @@ core_initcall(memory_failure_init);
 		pr_info(fmt, pfn);			\
 })
 
-static inline int clear_page_hwpoison(struct ratelimit_state *rs, struct page *p)
-{
-	if (TestClearPageHWPoison(p)) {
-		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
-				 page_to_pfn(p), rs);
-		num_poisoned_pages_dec();
-		return 1;
-	}
-	return 0;
-}
-
-static inline int unpoison_taken_off_page(struct ratelimit_state *rs,
-					  struct page *p)
-{
-	if (put_page_back_buddy(p)) {
-		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
-				 page_to_pfn(p), rs);
-		return 0;
-	}
-	return -EBUSY;
-}
-
 /**
  * unpoison_memory - Unpoison a previously poisoned page
  * @pfn: Page number of the to be unpoisoned page
@@ -2140,6 +2118,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *page;
 	struct page *p;
 	int ret = -EBUSY;
+	int freeit = 0;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2180,18 +2159,15 @@ int unpoison_memory(unsigned long pfn)
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
-		if (clear_page_hwpoison(&unpoison_rs, page))
-			ret = 0;
-		else
-			ret = -EBUSY;
+		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {
-			ret = unpoison_taken_off_page(&unpoison_rs, p);
+			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
 		} else
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
 	} else {
-		int freeit = clear_page_hwpoison(&unpoison_rs, p);
+		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
 		if (freeit && !(pfn == my_zero_pfn(0) && page_count(p) == 1)) {
@@ -2202,6 +2178,11 @@ int unpoison_memory(unsigned long pfn)
 
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
+	if (!ret || freeit) {
+		num_poisoned_pages_dec();
+		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
+				 page_to_pfn(p), &unpoison_rs);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(unpoison_memory);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e42038382c1..d710846ef653 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9625,7 +9625,6 @@ bool put_page_back_buddy(struct page *page)
 		ClearPageHWPoisonTakenOff(page);
 		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
 		if (TestClearPageHWPoison(page)) {
-			num_poisoned_pages_dec();
 			ret = true;
 		}
 	}
-- 
2.20.1

