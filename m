Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E74A6564
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiBAUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiBAUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:08:28 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67D2C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:08:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id p29-20020a634f5d000000b003624b087f05so10986650pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yMqEmKjIL/Dc6vWQPZwvkUpxPtUZ6gJbN9NcOUwsK3w=;
        b=L+XtFUyq5B1aDF185x8JYbmuJblnU+fteeKu2W4ISb+MNg9UGcd2hMR5YgaskLQBqh
         9oFQVDQ5vlYh6GLDTHiC/Wg9FEfzVbr+oh0oo523Cjsms5YTWL01nUYqQhQ12at6Qtuo
         bE/fB1we2A6ihLqnTLH+mATi4wKRovBX+h+tnoohasfCvPOVWyDMcC7TyA+f0j9IJGm/
         xZqCl5YhwMkOqwEzwfYpQYRQ5FymaCtNob61HePZA7YfyfBNpzn0gYn+cJPrYMgYFnj5
         0wy+cR3Srf2eV92bNfFvv6OUSqz900DuGNJ6MhhsKKYkY25KIxeQSbwLeZA3aIBnZ6Eo
         VUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yMqEmKjIL/Dc6vWQPZwvkUpxPtUZ6gJbN9NcOUwsK3w=;
        b=WC0ZZCjzuDO+ZSF9tjQq9cHYEduVGlzdOlTgGtTX8Sagde2/1IUSbuFZHqVYKnSPoP
         o7kDTm9zzfejAkXcNWLzyqck4qCcRY3u+yZVzrurqWKI+L56tIE594jvi7s1JY+SakNu
         fQFYGzcoe8zj8pShfKFeeYxnO2dupLcaHRjlJlrdQUFmRYiQqnrv07KrStFEXPxDbW+A
         zHu64lAnE8USSu7A+HS1s4BvYguOB0QjB64fR0jlVv6C/RAOrN0yEAhqG9SJU3saUZgJ
         BM7p6mLn2i+MqK4QbiZ2SIadPQ6nABRKtGGg7ut0JvrZbDXFUeRqCmYO7JXSPlwJRaqJ
         WPAA==
X-Gm-Message-State: AOAM5311aokSNLJIw1j9cNXkxSEmnPl/dlkBHSZP04qI3MaXBl0M1bMZ
        Deb+cRjK2/y1Ul8AzR7e1Vd7TSyKOtI0EV/p
X-Google-Smtp-Source: ABdhPJy9fCU+ODtk1dalQvAMOMuRNnRknobATjnzPy737g+xgIYG6wXb+h99zc6NZowhdArbhPEi3LqrFn/QGqFj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:7c92:: with SMTP id
 y18mr26526801pll.131.1643746108101; Tue, 01 Feb 2022 12:08:28 -0800 (PST)
Date:   Tue,  1 Feb 2022 20:08:23 +0000
Message-Id: <20220201200823.3283171-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] memcg: add per-memcg total kernel memory stat
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently memcg stats show several types of kernel memory:
kernel stack, page tables, sock, vmalloc, and slab.
However, there are other allocations with __GFP_ACCOUNT
(or supersets such as GFP_KERNEL_ACCOUNT) that are not accounted
in any of those stats, a few examples are:
- various kvm allocations (e.g. allocated pages to create vcpus)
- io_uring
- tmp_page in pipes during pipe_write()
- bpf ringbuffers
- unix sockets

Keeping track of the total kernel memory is essential for the ease of
migration from cgroup v1 to v2 as there are large discrepancies between
v1's kmem.usage_in_bytes and the sum of the available kernel memory stats
in v2. Adding separate memcg stats for all __GFP_ACCOUNT kernel
allocations is an impractical maintenance burden as there a lot of those
all over the kernel code, with more use cases likely to show up in the
future.

Therefore, add a "kernel" memcg stat that is analogous to kmem
page counter, with added benefits such as using rstat infrastructure
which aggregates stats more efficiently. Additionally, this provides a
lighter alternative in case the legacy kmem is deprecated in the future

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  5 +++++
 include/linux/memcontrol.h              |  1 +
 mm/memcontrol.c                         | 24 ++++++++++++++++++------
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5aa368d165da..a0027d570a7f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1317,6 +1317,11 @@ PAGE_SIZE multiple when read back.
 	  vmalloc (npn)
 		Amount of memory used for vmap backed memory.
 
+	  kernel (npn)
+		Amount of total kernel memory, including
+		(kernel_stack, pagetables, percpu, vmalloc, slab) in
+		addition to other kernel memory use cases.
+
 	  shmem
 		Amount of cached filesystem data that is swap-backed,
 		such as tmpfs, shm segments, shared anonymous mmap()s
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b72d75141e12..fa51986365a4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -34,6 +34,7 @@ enum memcg_stat_item {
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
 	MEMCG_VMALLOC,
+	MEMCG_KMEM,
 	MEMCG_NR_STAT,
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 09d342c7cbd0..c55d7056ac98 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1376,6 +1376,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "percpu",			MEMCG_PERCPU_B			},
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			MEMCG_VMALLOC			},
+	{ "kernel",			MEMCG_KMEM			},
 	{ "shmem",			NR_SHMEM			},
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -2979,6 +2980,19 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
 
+static void mem_cgroup_kmem_record(struct mem_cgroup *memcg,
+				   int nr_pages)
+{
+	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		if (nr_pages > 0)
+			page_counter_charge(&memcg->kmem, nr_pages);
+		else
+			page_counter_uncharge(&memcg->kmem, -nr_pages);
+	}
+}
+
+
 /*
  * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a objcg
  * @objcg: object cgroup to uncharge
@@ -2991,8 +3005,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_uncharge(&memcg->kmem, nr_pages);
+	mem_cgroup_kmem_record(memcg, -nr_pages);
 	refill_stock(memcg, nr_pages);
 
 	css_put(&memcg->css);
@@ -3018,8 +3031,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_charge(&memcg->kmem, nr_pages);
+	mem_cgroup_kmem_record(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
 
@@ -6801,8 +6813,8 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
-		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
-			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
+		if (ug->nr_kmem)
+			mem_cgroup_kmem_record(ug->memcg, -ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
 	}
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

