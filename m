Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C384BC2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 23:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiBRWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 17:43:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbiBRWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 17:43:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926440A15
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 14:43:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9F0E41F37F;
        Fri, 18 Feb 2022 22:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645224203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZI7eb1YtnV7jiyH1+LFtBKo1YQC7gG8qhsVdB0DfRqg=;
        b=na0AmMrBG3/DqP2YtYj6dlBCBUmzAiEDPEZi0BVj+4TwwMKxqrPIDMHiwL+t2E9s63FBks
        Eyckr+wNZYo/L3EN/i8i38fF2Q5XIknlk45hvYgf7qRfAy4Og2WVehb0X/jT4XGWfHdkVP
        x9VEgkTBWqf+MmwGWf/mFUCrnYc1i08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645224203;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZI7eb1YtnV7jiyH1+LFtBKo1YQC7gG8qhsVdB0DfRqg=;
        b=tibGjMo6uoy/D73l37bvC/dIWVQIDNM+eNCMR7LqsHMRndigXcvdTAnkEHZQPBic7jwsVy
        geGnD3ZnyWxeYLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E07FF13CCE;
        Fri, 18 Feb 2022 22:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IDOIMwohEGKMQwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 18 Feb 2022 22:43:22 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/1] arch/x86/mm/numa: Do not initialize nodes twice
Date:   Fri, 18 Feb 2022 23:43:02 +0100
Message-Id: <20220218224302.5282-2-osalvador@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218224302.5282-1-osalvador@suse.de>
References: <20220218224302.5282-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86, prior to ("mm: handle uninitialized numa nodes gracecully"),
NUMA nodes could be allocated at three different places.

- numa_register_memblks
- init_cpu_to_node
- init_gi_nodes

All these calls happen at setup_arch, and have the following order:

setup_arch
  ...
  x86_numa_init
   numa_init
    numa_register_memblks
  ...
  init_cpu_to_node
   init_memory_less_node
    alloc_node_data
    free_area_init_memoryless_node
  init_gi_nodes
   init_memory_less_node
    alloc_node_data
    free_area_init_memoryless_node

numa_register_memblks() is only interested in those nodes which have memory,
so it skips over any memoryless node it founds.
Later on, when we have read ACPI's SRAT table, we call init_cpu_to_node()
and init_gi_nodes(), which initialize any memoryless node we might have
that have either CPU or Initiator affinity, meaning we allocate pg_data_t
struct for them and we mark them as ONLINE.

So far so good, but the thing is that after ("mm: handle uninitialized numa
nodes gracefully"), we allocate all possible NUMA nodes in free_area_init(),
meaning we have a picture like the following:

setup_arch
  x86_numa_init
   numa_init
    numa_register_memblks  <-- allocate non-memoryless node
  x86_init.paging.pagetable_init
   ...
    free_area_init
     free_area_init_memoryless <-- allocate memoryless node
  init_cpu_to_node
   alloc_node_data             <-- allocate memoryless node with CPU
   free_area_init_memoryless_node
  init_gi_nodes
   alloc_node_data             <-- allocate memoryless node with Initiator
   free_area_init_memoryless_node

free_area_init() already allocates all possible NUMA nodes, but
init_cpu_to_node() and init_gi_nodes() are clueless about that,
so they go ahead and allocate a new pg_data_t struct without
checking anything, meaning we end up allocating twice.

It should be mad clear that this only happens in the case where
memoryless NUMA node happens to have a CPU/Initiator affinity.

So get rid of init_memory_less_node() and just set the node online.

Note that setting the node online is needed, otherwise we choke
down the chain when bringup_nonboot_cpus() ends up calling
__try_online_node()->register_one_node()->... and we blow up in
bus_add_device(). Like can be seen here:

=========
[    0.585060] BUG: kernel NULL pointer dereference, address: 0000000000000060
[    0.586091] #PF: supervisor read access in kernel mode
[    0.586831] #PF: error_code(0x0000) - not-present page
[    0.586930] PGD 0 P4D 0
[    0.586930] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
[    0.586930] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc4-1-default+ #45
[    0.586930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/4
[    0.586930] RIP: 0010:bus_add_device+0x5a/0x140
[    0.586930] Code: 8b 74 24 20 48 89 df e8 84 96 ff ff 85 c0 89 c5 75 38 48 8b 53 50 48 85 d2 0f 84 bb 00 004
[    0.586930] RSP: 0000:ffffc9000022bd10 EFLAGS: 00010246
[    0.586930] RAX: 0000000000000000 RBX: ffff888100987400 RCX: ffff8881003e4e19
[    0.586930] RDX: ffff8881009a5e00 RSI: ffff888100987400 RDI: ffff888100987400
[    0.586930] RBP: 0000000000000000 R08: ffff8881003e4e18 R09: ffff8881003e4c98
[    0.586930] R10: 0000000000000000 R11: ffff888100402bc0 R12: ffffffff822ceba0
[    0.586930] R13: 0000000000000000 R14: ffff888100987400 R15: 0000000000000000
[    0.586930] FS:  0000000000000000(0000) GS:ffff88853fc00000(0000) knlGS:0000000000000000
[    0.586930] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.586930] CR2: 0000000000000060 CR3: 000000000200a001 CR4: 00000000001706b0
[    0.586930] Call Trace:
[    0.586930]  <TASK>
[    0.586930]  device_add+0x4c0/0x910
[    0.586930]  __register_one_node+0x97/0x2d0
[    0.586930]  __try_online_node+0x85/0xc0
[    0.586930]  try_online_node+0x25/0x40
[    0.586930]  cpu_up+0x4f/0x100
[    0.586930]  bringup_nonboot_cpus+0x4f/0x60
[    0.586930]  smp_init+0x26/0x79
[    0.586930]  kernel_init_freeable+0x130/0x2f1
[    0.586930]  ? rest_init+0x100/0x100
[    0.586930]  kernel_init+0x17/0x150
[    0.586930]  ? rest_init+0x100/0x100
[    0.586930]  ret_from_fork+0x22/0x30
[    0.586930]  </TASK>
[    0.586930] Modules linked in:
[    0.586930] CR2: 0000000000000060
[    0.586930] ---[ end trace 0000000000000000 ]---
=========

The reason is simple, by the time bringup_nonboot_cpus() gets called,
we did not register the node_subsys bus yet, so we crash when bus_add_device()
tries to dereference bus()->p.

The following shows the order of the calls:

kernel_init_freeable
 smp_init
  bringup_nonboot_cpus
   ...
     bus_add_device()      <- we did not register node_subsys yet
 do_basic_setup
  do_initcalls
   postcore_initcall(register_node_type);
    register_node_type
     subsys_system_register
      subsys_register
       bus_register         <- register node_subsys bus

Why setting the node online saves us then? Well, simply because
__try_online_node() backs off when the node is online, meaning
we do not end up calling register_one_node() in the first place.

This is subtle, broken and deserves a deep analysis and thought
about how to put this into shape, but for now let us have this
easy fix for the leaking memory issue.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Fixes: da4490c958ad ("mm: handle uninitialized numa nodes gracefully")
---
 arch/x86/mm/numa.c | 15 ++-------------
 include/linux/mm.h |  1 -
 mm/page_alloc.c    |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c6b1213086d6..37039a6af8ae 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -738,17 +738,6 @@ void __init x86_numa_init(void)
 	numa_init(dummy_numa_init);
 }
 
-static void __init init_memory_less_node(int nid)
-{
-	/* Allocate and initialize node data. Memory-less node is now online.*/
-	alloc_node_data(nid);
-	free_area_init_memoryless_node(nid);
-
-	/*
-	 * All zonelists will be built later in start_kernel() after per cpu
-	 * areas are initialized.
-	 */
-}
 
 /*
  * A node may exist which has one or more Generic Initiators but no CPUs and no
@@ -768,7 +757,7 @@ void __init init_gi_nodes(void)
 
 	for_each_node_state(nid, N_GENERIC_INITIATOR)
 		if (!node_online(nid))
-			init_memory_less_node(nid);
+			node_set_online(nid);
 }
 
 /*
@@ -799,7 +788,7 @@ void __init init_cpu_to_node(void)
 			continue;
 
 		if (!node_online(node))
-			init_memory_less_node(node);
+			node_set_online(node);
 
 		numa_set_node(cpu, node);
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..9ff1c4c8449e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2453,7 +2453,6 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
 }
 
 extern void __init pagecache_init(void);
-extern void __init free_area_init_memoryless_node(int nid);
 extern void free_initmem(void);
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 83da2279be72..967085c1c78a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7698,7 +7698,7 @@ static void __init free_area_init_node(int nid)
 	free_area_init_core(pgdat);
 }
 
-void __init free_area_init_memoryless_node(int nid)
+static void __init free_area_init_memoryless_node(int nid)
 {
 	free_area_init_node(nid);
 }
-- 
2.34.1

