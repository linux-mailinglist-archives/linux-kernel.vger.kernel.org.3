Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6286751FAB8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiEILFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiEILE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:04:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D959F223851
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:01:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q18so555847pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dwecl2Kr1urUIZir4QecyhUGT2o+Jo6GQteEXIEdnc4=;
        b=bYuFJNt6ZEGQO5O5z5nIFxsS6dk83OgKxaii7XuPjAdM2s4k3cG/HlVgCLphAahc+o
         2Mpv157r4aX42F2I6pzx/WdVj+6wRp+FU6wrRNZPt2cnEjVPmCVzBBrYwvq8JgeqI/iS
         ztXJfWYwkpBFJ+QgSUjs9bIUtesCdKcOdR061A/gxIWqFcvFqGxVyX/YNxVsR62MNC26
         ePn2L11yNJ2Ax3SGGXklYIJRaaNwCGpqGwmQEveG2X7CnRg5SYtCM87bgCnMdIQmwMuD
         Zbm1EZ+YkoycHRb3kC7CWaPWFbirQPR+3S2O52B58bJOpC5uqfnq6AaydXWS5JU0cXZb
         LUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dwecl2Kr1urUIZir4QecyhUGT2o+Jo6GQteEXIEdnc4=;
        b=kmcR4JExN81D/uMc/3bF92x+D12WGOdAN7ekTgbavoUwkfpFLkoJe9NxtXaDyE4uvy
         AZdTAytbKLZjCCAPEv8N2YhFF/0Tqrcov+NhOVy5zG7jTxApioQXAIJX26dc6CASTmhO
         0+KPMUADAZj5Ef+HKHE/q9hyM3fk5MBrZlVtPPPTZkW5xJnRUCwf99S7Ul9Iuca/GJ96
         wNzDANxtnfMILWOlzwJtxi6bFie0eCs3Vk3Y249xMmXzkc8l7gGbcW0TWuWQ2yvDejIb
         AOFoEZ1jMTqh8d90egJ/bHM8jlgIMBf+H88FSSav2bfh1jaZY17M1nmcUimnhbsvL2xz
         azcA==
X-Gm-Message-State: AOAM531KpDYj+gP2qdA9GRbEWcAEDJhTcN3juZcKLJlwXMjBArFBTTPA
        nkqX8XBFxUPtJJaicWkK1+5JNw==
X-Google-Smtp-Source: ABdhPJy1uR5B7Z3hoJSkWWt6S8aIJC8MM9+evsRCGhS7NW+twaifPSICrJjYgfX9wH3uhyeq/gCA1g==
X-Received: by 2002:a17:903:22cf:b0:15e:cf4e:79c9 with SMTP id y15-20020a17090322cf00b0015ecf4e79c9mr15891618plg.54.1652094065144;
        Mon, 09 May 2022 04:01:05 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0015e8d4eb244sm6813303plp.142.2022.05.09.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:01:04 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 2/5] mm/memory-failure.c: simplify num_poisoned_pages_dec
Date:   Mon,  9 May 2022 18:56:38 +0800
Message-Id: <20220509105641.491313-3-pizhenwei@bytedance.com>
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

Don't decrease the number of poisoned pages in page_alloc.c, let the
memory-failure.c do inc/dec poisoned pages only.

Also simplify unpoison_memory(), only decrease the number of
poisoned pages when:
 - TestClearPageHWPoison() succeed
 - put_page_back_buddy succeed

After decreasing, print necessary log.

Finally, remove clear_page_hwpoison() and unpoison_taken_off_page().

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
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

