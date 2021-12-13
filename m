Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C647328E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbhLMQ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbhLMQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:56:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B5C061751
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so13813841pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m98RC8bY9ry625Z8i2nXVNyOqqfMLEW5ul5yLfq7Yzk=;
        b=hR6fGZqCqI8yFwwU5LToWe8M1UCp5xIdyt8/AVOUEJ/WBqoxOqIpJsNjjVEgdYI7jp
         PwVPRjbkz/8KsoV+eb6BeHYNBF6ZdUKrRFwh1uk+LiFLg7yubTp8nkoyzbCnrclWW28m
         2ZY5czGQCEghFBQaUd4jvRpWoZlhdOmShL8OTDBnlp0TyrE1R9bEHqS9TlhoVRfL/pbd
         GyTQEhIU30vJpxh8f2vlBgAC9fvBHsQWyRjcfp6pHARd0jKlSMptuxtj0rwXaGpV5/OB
         0omsd2/p1eEkMHfceqVmgwvKngpT8ObD87J/CEjplAzO5GuLhX1JlEvEhf59cOlq9uPf
         QPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m98RC8bY9ry625Z8i2nXVNyOqqfMLEW5ul5yLfq7Yzk=;
        b=bPHoJj8H7ZhFbEXXPbIijbrGuRg5AwceZo4Fgub0pxd3t+O+hU3wTusYnXZvNrVX4q
         PC5X/PaY0WWwK6YgvuhW26JqoDDtGTcEsby5DfPFX9RXC9iW3UiW3vzkx5pI8wLeRx+A
         rXGx4IIsdR9rXaJ/1GvSVWGGmqUGgyPTHxw93IPcljL8l8kIjGU2zsQpEnd+Uur4PfC3
         1T2mnMN1f+C5ZxCca0B6HIBZ9DpPrCIkAtncQVjgu48xMryodwi4v60DEuLeYKLvVokd
         88DZfscHhIclCxLk1OI1Jt8uoUWZml3z0Ip3GnUZpv08lhDQe505U7cwKYy87wH4BYRN
         p9dQ==
X-Gm-Message-State: AOAM531pzWwAw44bsWYWBD/DayL+fsTky1u71kXZF7Y3FgEyqNXqzcXL
        Ak1uJ3Ueqh2UtWfGYVMidx2hpw==
X-Google-Smtp-Source: ABdhPJzqSJg9VWLkIG3uPnAi/6ZEdCkfsvwI9s4dHakptKaLRcr2lvcthKwpEtEYSIlgy7Onx7sgvg==
X-Received: by 2002:a17:902:ee95:b0:141:f28f:7296 with SMTP id a21-20020a170902ee9500b00141f28f7296mr97113270pld.50.1639414613627;
        Mon, 13 Dec 2021 08:56:53 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.56.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:56:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 17/17] mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
Date:   Tue, 14 Dec 2021 00:53:42 +0800
Message-Id: <20211213165342.74704-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memcg_cache_id() introduced by commit 2633d7a02823 ("slab/slub:
consider a memcg parameter in kmem_create_cache") is used to index
in the kmem_cache->memcg_params->memcg_caches array. Since
kmem_cache->memcg_params.memcg_caches has been removed by commit
9855609bde03 ("mm: memcg/slab: use a single set of kmem_caches for
all accounted allocations"). So the name does not need to reflect
cache related. Just rename it to memcg_kmem_id. And it can reflect
kmem related.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/list_lru.c              | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7b472f805d77..94ed3a124191 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1735,7 +1735,7 @@ static inline void memcg_kmem_uncharge_page(struct page *page, int order)
  * A helper for accessing memcg's kmem_id, used for getting
  * corresponding LRU lists.
  */
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return memcg ? memcg->kmemcg_id : -1;
 }
@@ -1773,7 +1773,7 @@ static inline bool memcg_kmem_enabled(void)
 	return false;
 }
 
-static inline int memcg_cache_id(struct mem_cgroup *memcg)
+static inline int memcg_kmem_id(struct mem_cgroup *memcg)
 {
 	return -1;
 }
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 589146fd3770..9c0682ed9dda 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -74,7 +74,7 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 	if (!memcg)
 		goto out;
 
-	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 out:
 	if (memcg_ptr)
 		*memcg_ptr = memcg;
@@ -181,7 +181,7 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 	long count;
 
 	rcu_read_lock();
-	l = list_lru_from_memcg_idx(lru, nid, memcg_cache_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 	count = l ? READ_ONCE(l->nr_items) : 0;
 	rcu_read_unlock();
 
@@ -272,7 +272,7 @@ list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock(&nlru->lock);
-	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+	ret = __list_lru_walk_one(lru, nid, memcg_kmem_id(memcg), isolate,
 				  cb_arg, nr_to_walk);
 	spin_unlock(&nlru->lock);
 	return ret;
@@ -288,7 +288,7 @@ list_lru_walk_one_irq(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long ret;
 
 	spin_lock_irq(&nlru->lock);
-	ret = __list_lru_walk_one(lru, nid, memcg_cache_id(memcg), isolate,
+	ret = __list_lru_walk_one(lru, nid, memcg_kmem_id(memcg), isolate,
 				  cb_arg, nr_to_walk);
 	spin_unlock_irq(&nlru->lock);
 	return ret;
-- 
2.11.0

