Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE24A8C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353806AbiBCTjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353818AbiBCTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:39:17 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B94FC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:39:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id k92-20020a17090a3ee500b001b7f89d8ab5so4611982pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ejpLrWVX9GOVqNzPyB3Ntlcxx6B++bVOxcTZPfjRPDM=;
        b=i5BnQt9PMTql7bmkuSjJZmVciGJFwFrLYd2ESpv+K9+CWXuaLHaTU2hf3StWLCi2H7
         y0If7uONfLmjiUadR4hVVUwhOAp83x59jMOlAfiBzX09fuTrR0gmIrGqlNSs7E0xOAvr
         iao7CwfrSFsvE/Ce46uIhm06FUm8Hz+4WbpZ8Gqmzp1A3xa1RtiLyrOZvFCiDDYTckAH
         jXDq3QNDrPdj6AFZK9nRql/+GFIsDBBVq2Nu+fMqvc228xtbOkXvAchqN8scTRazZURO
         opf22qMQ9AXuMyR0zjGaHiGrBawCwDmDJCmNK8cZTdyX5ajVcKzSj6WW9BphFJR5VdNa
         aB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ejpLrWVX9GOVqNzPyB3Ntlcxx6B++bVOxcTZPfjRPDM=;
        b=MsDYuas6XkV1Ew0r9V8cvXUGNhFC3GIkjiQGjsE4V4SVny6BIPKVsy7cPKkQNRvs9h
         VDE2FZlYWmaFujTEOTciZdP6SDPL6u5I5VVdP/SG1/P9ULU+WYReuBj30H0NQCXvhBus
         zdcg7vbzSmPknYgvKNlqNqoayioyVGs16fPP03wUZHDp6qe9QQmbFA7qRDwpMXav2kNf
         Ec6kUCKL2jYQ2JS/b5r7LxD6gwweHSnYpeXRv4IQtMXOZr2Gq5U88VgbvkUHKi6E/cfq
         k8cBEBcjH6/wn5k9CgpGehT2N2dpkfazPHQBd52QIKsFBL+0g1zEzk3eZTDEvcHlMxOm
         5Lfw==
X-Gm-Message-State: AOAM5315pLQjXXeyq4wOaXFKZE69r3TH1WLWwTFbrPOkwkN20CA8TsKK
        vGbVTbvV3gc2WzMeIBGyN5UoXjzdfNcL4VKQ
X-Google-Smtp-Source: ABdhPJxnaH9Im4E14cXfMftsLRc4WRLaoPVtXjvD+GPI8pyu7gpRajMDJJ4WLPuG+aMtbreX1oiEi78UEhU9FR2Q
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:360e:: with SMTP id
 ml14mr145pjb.1.1643917156253; Thu, 03 Feb 2022 11:39:16 -0800 (PST)
Date:   Thu,  3 Feb 2022 19:38:56 +0000
Message-Id: <20220203193856.972500-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v2] memcg: add per-memcg total kernel memory stat
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>,
        kernel test robot <lkp@intel.com>
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
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: kernel test robot <lkp@intel.com>

---
Changelog since v1:
- Moved "kernel" stat ahead of other subset kernel stats.
- Renamed mem_cgroup_kmem_record() to memcg_account_kmem(), following
  Johannes's review to avoid the line wrap, but keeping a memcg_ prefix
  to stay consistent with other static functions in the file.
- Fixed a build error when CONFIG_MEMCG_KMEM is not set (added an empty
  version if the config is not set).
---
 Documentation/admin-guide/cgroup-v2.rst |  5 +++++
 include/linux/memcontrol.h              |  1 +
 mm/memcontrol.c                         | 27 +++++++++++++++++++------
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 5aa368d165da..69d7a6983f78 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1301,6 +1301,11 @@ PAGE_SIZE multiple when read back.
 		Amount of memory used to cache filesystem data,
 		including tmpfs and shared memory.
 
+	  kernel (npn)
+		Amount of total kernel memory, including
+		(kernel_stack, pagetables, percpu, vmalloc, slab) in
+		addition to other kernel memory use cases.
+
 	  kernel_stack
 		Amount of memory allocated to kernel stacks.
 
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
index 09d342c7cbd0..c61dc03a3333 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1371,6 +1371,7 @@ struct memory_stat {
 static const struct memory_stat memory_stats[] = {
 	{ "anon",			NR_ANON_MAPPED			},
 	{ "file",			NR_FILE_PAGES			},
+	{ "kernel",			MEMCG_KMEM			},
 	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
 	{ "pagetables",			NR_PAGETABLE			},
 	{ "percpu",			MEMCG_PERCPU_B			},
@@ -2114,6 +2115,7 @@ static DEFINE_MUTEX(percpu_charge_mutex);
 static void drain_obj_stock(struct obj_stock *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
+static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 
 #else
 static inline void drain_obj_stock(struct obj_stock *stock)
@@ -2124,6 +2126,9 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	return false;
 }
+static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
+{
+}
 #endif
 
 /**
@@ -2979,6 +2984,18 @@ static void memcg_free_cache_id(int id)
 	ida_simple_remove(&memcg_cache_ida, id);
 }
 
+static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
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
@@ -2991,8 +3008,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_uncharge(&memcg->kmem, nr_pages);
+	memcg_account_kmem(memcg, -nr_pages);
 	refill_stock(memcg, nr_pages);
 
 	css_put(&memcg->css);
@@ -3018,8 +3034,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-		page_counter_charge(&memcg->kmem, nr_pages);
+	memcg_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
 
@@ -6801,8 +6816,8 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
-		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
-			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
+		if (ug->nr_kmem)
+			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
 	}
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

