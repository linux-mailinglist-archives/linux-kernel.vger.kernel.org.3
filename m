Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035A4F71E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiDGCL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDGCLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:11:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9F1D7639
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:09:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f10so3611949plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+O7LWtD3njsRsXh/enOovxdjHInOFNE0TrUJIhcwQg=;
        b=M1XrD/HjeUe2Pse7ZbeBbFFcct4bE2pD6MXo42RO6THqxXPfare2aRyBfEUsR1fCQK
         5DXA9NUtPWnRTBaCu+d5xpzIOIFSWEC23I7u5btu33iytlsr94MCYwfAikqwr2r7Ac9O
         /0+sph2VOWDQo3WLXx10bnnr6dsrv7Aku2GPgfGMWSm/NZsgyvJ0ZYcEKR9luOVrmypM
         eDAi4CCFWA1j7FwUteawBfrLByL2Pz+vTpGviuG4ksoCPze8EyNLu7fYXh0yJv1tPmzl
         5NxX/4N55d5Q6ALrn4OC0ZD0KzYK3L5L1IgTSHzdrmgd31xbAD6/t3G8vv+9MgbpZ+WK
         jZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+O7LWtD3njsRsXh/enOovxdjHInOFNE0TrUJIhcwQg=;
        b=mRE7kPkYlwvKfP78Q7qer1qbT12zmIPs7LfdvHOIZvy8mR8BIGmkRkhKeEQYj6aIG9
         e0FxeLSpqeXpTPMyfG4HDjrtdxGUgne5a8tBjf2ctI4387tqZPwmGu1HQmkPC7h0J73F
         UPXxWXVw8+uMuUkNq9VIsWco241pT0VTYZNHPFp9po5uoYsse3KSq31iJmIBpgYrjODG
         4mLt3ARDKxz59LI5nKdZnRJnT4+aeSvNOt40WH4z6QoJburxx5wUVCAUl0IDFCFBz+JB
         pgYO2qTnEm2NOtrPUgioSU5uSZuQI8wpJRg9OIHDM6t1NDe90ccbPNO90MIyh4nWqZa3
         /0KQ==
X-Gm-Message-State: AOAM532PGDoZjO5fYjyYq2pXtN0i+21t1dRBuWdBkuiDa4lQATqxTM+P
        KhkxUBdqaGt10Qu5D8Giwlk/MYW29XU=
X-Google-Smtp-Source: ABdhPJyOrw6bfZu5Yoop0ZZnjQWY1vVVpBUP/2p9EGqB1+jb8JJiep3qFIiqeHMkga2FYITHQ/aw7g==
X-Received: by 2002:a17:90a:de82:b0:1ca:b7e7:c794 with SMTP id n2-20020a17090ade8200b001cab7e7c794mr13097442pjv.181.1649297395265;
        Wed, 06 Apr 2022 19:09:55 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id a11-20020a056a000c8b00b004fade889fb3sm21703716pfv.18.2022.04.06.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 19:09:54 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     ying.huang@intel.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swap: determine swap device by using page nid
Date:   Wed,  6 Apr 2022 19:09:53 -0700
Message-Id: <20220407020953.475626-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The swap devices are linked to per node priority lists, the swap device
closer to the node has higher priority on that node's priority list.
This is supposed to improve I/O latency, particularly for some fast
devices.  But the current code gets nid by calling numa_node_id() which
actually returns the nid that the reclaimer is running on instead of the
nid that the page belongs to.

Pass the page's nid dow to get_swap_pages() in order to pick up the
right swap device.  But it doesn't work for the swap slots cache which
is per cpu.  We could skip swap slots cache if the current node is not
the page's node, but it may be overkilling. So keep using the current
node's swap slots cache.  The issue was found by visual code inspection
so it is not sure how much improvement could be achieved due to lack of
suitable testing device.  But anyway the current code does violate the
design.

Cc: Huang Ying <ying.huang@intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/swap.h | 3 ++-
 mm/swap_slots.c      | 7 ++++---
 mm/swapfile.c        | 5 ++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 27093b477c5f..e442cf6b61ea 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -497,7 +497,8 @@ extern void si_swapinfo(struct sysinfo *);
 extern swp_entry_t get_swap_page(struct page *page);
 extern void put_swap_page(struct page *page, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
-extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
+extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size,
+			  int node);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 2b5531840583..a1c5cf6a4302 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	cache->cur = 0;
 	if (swap_slot_cache_active)
 		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
-					   cache->slots, 1);
+					   cache->slots, 1, numa_node_id());
 
 	return cache->nr;
 }
@@ -305,12 +305,13 @@ swp_entry_t get_swap_page(struct page *page)
 {
 	swp_entry_t entry;
 	struct swap_slots_cache *cache;
+	int nid = page_to_nid(page);
 
 	entry.val = 0;
 
 	if (PageTransHuge(page)) {
 		if (IS_ENABLED(CONFIG_THP_SWAP))
-			get_swap_pages(1, &entry, HPAGE_PMD_NR);
+			get_swap_pages(1, &entry, HPAGE_PMD_NR, nid);
 		goto out;
 	}
 
@@ -342,7 +343,7 @@ swp_entry_t get_swap_page(struct page *page)
 			goto out;
 	}
 
-	get_swap_pages(1, &entry, 1);
+	get_swap_pages(1, &entry, 1, nid);
 out:
 	if (mem_cgroup_try_charge_swap(page, entry)) {
 		put_swap_page(page, entry);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..151fffe0fd60 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1036,13 +1036,13 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
 
-int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
+int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size,
+		   int node)
 {
 	unsigned long size = swap_entry_size(entry_size);
 	struct swap_info_struct *si, *next;
 	long avail_pgs;
 	int n_ret = 0;
-	int node;
 
 	/* Only single cluster request supported */
 	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
@@ -1060,7 +1060,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	atomic_long_sub(n_goal * size, &nr_swap_pages);
 
 start_over:
-	node = numa_node_id();
 	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
 		/* requeue si to after same-priority siblings */
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
-- 
2.26.3

