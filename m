Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5D558BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiFWXwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFWXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D660C4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k7so614310plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9qDM1SEwhJHNMkiAW+9hnn1MZNaGCub7B2p3sdAevGo=;
        b=a7P7HnrlqqsSBAv8Rh9l5P0qKEPodg3DsKsYr1Ea4M2Kn+QsYmKyxzF6uMI7LIyD90
         D7dQ6KAxhdboYEDc65+ew8MRy8m7dAcgAw/XN9mFluukHhigzZK9AlkGJoXVhUYCDYxB
         iLNdAr+Lt1+Hhj13KaJVx531dr/ndkA5+wn+Xx0ZMBms/VzRGeN93f23HV3Fivmq0x4S
         wekPTJ7XFlXQdG1L1/GEkg4Y9ZXaUdt5cHqskGHTeZ1REkKnnlA7yUZkP2sRj28BTcsr
         1SpvYWYgizD/bL6oe+cCC39Of/ccsD5GQvut0an6oon8bsbqSxFnCig0gv8wbdTZOacr
         re2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9qDM1SEwhJHNMkiAW+9hnn1MZNaGCub7B2p3sdAevGo=;
        b=PNB7tLOviX0eLEO3z3r1y/eF/J+V99W4opgSBf2g1aKscUlf4sDq5ISFPI1RWGt928
         xl7GL1bWDqDfkILLkHgHckWMaN2c2AxtBwTZdbpBX8UatXd7AmUmMYO0bU76jKXCj5tf
         t+qNHf+XRafsa4ogRz2Fd8kpkXVCgDlLHDqOO0OqntDHg5DNhUF1nNRFnwbLESiKoyp2
         G2HGJFsIoIlpd8Zd8b4+ppvfGXWJQneXfTc9R7nH40mH0AlMtuY3UK+qGgB5e4pCUBkl
         4kI0MAgUJbb/e+9vmbpR5Ok43y2J0UUcPvqwhCb1nKeH8DmxEC2+Rw9+sLHp1VRHojp/
         dAOw==
X-Gm-Message-State: AJIora/zp1h33FDvTa6SPYK4tE1O9krUE35cjTLyB4xIe/zL3QOyojnU
        9ih/dboIabZ9PDkdbSVwUCQYa5m1sg==
X-Google-Smtp-Source: AGRyM1to5MI42NBV7wBN2fu1N3JmUZLbmtHx8xzIu63b/rMAvK85lhxS+WOmvPyJdXJd+RprgZCMnw==
X-Received: by 2002:a17:90a:1588:b0:1e0:a45c:5c1 with SMTP id m8-20020a17090a158800b001e0a45c05c1mr550853pja.65.1656028363425;
        Thu, 23 Jun 2022 16:52:43 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:43 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
Date:   Fri, 24 Jun 2022 08:51:49 +0900
Message-Id: <20220623235153.2623702-6-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Raw error info list needs to be removed when hwpoisoned hugetlb is
unpoisioned.  And unpoison handler needs to know how many errors there
are in the target hugepage. So add them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/swapops.h |  9 +++++++++
 mm/memory-failure.c     | 34 +++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 9584c2e1c54a..ad62776ee99c 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -494,6 +494,11 @@ static inline void num_poisoned_pages_dec(void)
 	atomic_long_dec(&num_poisoned_pages);
 }
 
+static inline void num_poisoned_pages_sub(long i)
+{
+	atomic_long_sub(i, &num_poisoned_pages);
+}
+
 #else
 
 static inline swp_entry_t make_hwpoison_entry(struct page *page)
@@ -514,6 +519,10 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
 static inline void num_poisoned_pages_inc(void)
 {
 }
+
+static inline void num_poisoned_pages_sub(long i)
+{
+}
 #endif
 
 static inline int non_swap_entry(swp_entry_t entry)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index af571fa6f2af..6005e953d011 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1571,23 +1571,34 @@ static inline int hugetlb_set_page_hwpoison(struct page *hpage,
 	return ret;
 }
 
-inline int hugetlb_clear_page_hwpoison(struct page *hpage)
+static inline long free_raw_hwp_pages(struct page *hpage, bool move_flag)
 {
 	struct llist_head *head;
 	struct llist_node *t, *tnode;
+	long count = 0;
 
-	if (raw_hwp_unreliable(hpage))
-		return -EBUSY;
-	ClearPageHWPoison(hpage);
 	head = raw_hwp_list_head(hpage);
 	llist_for_each_safe(tnode, t, head->first) {
 		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
 
-		SetPageHWPoison(p->page);
+		if (move_flag)
+			SetPageHWPoison(p->page);
 		kfree(p);
+		count++;
 	}
 	llist_del_all(head);
-	return 0;
+	return count;
+}
+
+inline int hugetlb_clear_page_hwpoison(struct page *hpage)
+{
+	int ret = -EBUSY;
+
+	if (raw_hwp_unreliable(hpage))
+		return ret;
+	ret = !TestClearPageHWPoison(hpage);
+	free_raw_hwp_pages(hpage, true);
+	return ret;
 }
 
 /*
@@ -1729,6 +1740,10 @@ static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *
 {
 	return 0;
 }
+
+static inline void free_raw_hwp_pages(struct page *hpage, bool move_flag)
+{
+}
 #endif
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
@@ -2188,6 +2203,7 @@ int unpoison_memory(unsigned long pfn)
 	struct page *p;
 	int ret = -EBUSY;
 	int freeit = 0;
+	long count = 1;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
 
@@ -2235,6 +2251,8 @@ int unpoison_memory(unsigned long pfn)
 
 	ret = get_hwpoison_page(p, MF_UNPOISON);
 	if (!ret) {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
 	} else if (ret < 0) {
 		if (ret == -EHWPOISON) {
@@ -2243,6 +2261,8 @@ int unpoison_memory(unsigned long pfn)
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
 	} else {
+		if (PageHuge(p))
+			count = free_raw_hwp_pages(page, false);
 		freeit = !!TestClearPageHWPoison(p);
 
 		put_page(page);
@@ -2255,7 +2275,7 @@ int unpoison_memory(unsigned long pfn)
 unlock_mutex:
 	mutex_unlock(&mf_mutex);
 	if (!ret || freeit) {
-		num_poisoned_pages_dec();
+		num_poisoned_pages_sub(count);
 		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
 				 page_to_pfn(p), &unpoison_rs);
 	}
-- 
2.25.1

