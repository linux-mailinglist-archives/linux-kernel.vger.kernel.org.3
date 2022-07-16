Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D89577254
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiGPXSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiGPXR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0364D22BCC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:44 -0700 (PDT)
Message-ID: <20220716230953.738288030@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sFncniQWCWFsoBIPdxcaL179NgZVykSQzUetuwoc3AM=;
        b=PL93QLSh3uV4HEBJbTcb7BC8MtTc9SjR+uT3D8LvzsJn8zwmSgojcfEEozpAFiOuP5zxBZ
        bqpqyMDtE1t+72rRcKCL87pt01ejps5pRPj+MmPqRq4BDGsGDWI/6VQ7ztBgh0L/y5R7Vn
        7amUunaJxj+O2qHlkxajDijm3UsWHaIttoMBWbZ+erWBREx9sa+Mcuw7LkjUV6zfV4Up15
        YuF90HLR8XTGv+Yisk/FRG8eYKciQ0YbGFhfiSBZenEMaCbaHeG5lb0eA54QkIPmzYVSPz
        52cw72YkHQvzbxSI1ju1UpHAUMIibcQmg0P6s9SwhZ1MyfMFvKSZbeoylb+2yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=sFncniQWCWFsoBIPdxcaL179NgZVykSQzUetuwoc3AM=;
        b=OK/agc9RiD69sFyUzsaN7zbo1HHl/VF89+eGNZcPi5/CX/96OhlLPD2zF+pvCRssvY0yNk
        Mv0oCBIRK5BVs9AQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 18/38] mm/vmalloc: Provide huge page mappings
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:38 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Provide VM_HUGE_VMAP, which unconditionally tries to use huge
mappings. Unlike VM_ALLOW_HUGE_VMAP it doesn't care about the number
of NUMA nodes or the size of the allocation.

If the page allocator fails to provide huge pages, it will silently
fall back.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/vmalloc.h |    3 ++-
 mm/vmalloc.c            |   33 +++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 15 deletions(-)

--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -27,10 +27,11 @@ struct notifier_block;		/* in notifier.h
 #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 #define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
+#define VM_HUGE_VMAP		0x00000800      /* Force for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
-#define VM_DEFER_KMEMLEAK	0x00000800	/* defer kmemleak object creation */
+#define VM_DEFER_KMEMLEAK	0x00001000	/* defer kmemleak object creation */
 #else
 #define VM_DEFER_KMEMLEAK	0
 #endif
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3099,23 +3099,28 @@ void *__vmalloc_node_range(unsigned long
 		return NULL;
 	}
 
-	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
-		unsigned long size_per_node;
+	if (vmap_allow_huge && (vm_flags & (VM_HUGE_VMAP|VM_ALLOW_HUGE_VMAP))) {
 
-		/*
-		 * Try huge pages. Only try for PAGE_KERNEL allocations,
-		 * others like modules don't yet expect huge pages in
-		 * their allocations due to apply_to_page_range not
-		 * supporting them.
-		 */
+		if (vm_flags & VM_ALLOW_HUGE_VMAP) {
+			unsigned long size_per_node;
 
-		size_per_node = size;
-		if (node == NUMA_NO_NODE)
-			size_per_node /= num_online_nodes();
-		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
+			/*
+			 * Try huge pages. Only try for PAGE_KERNEL allocations,
+			 * others like modules don't yet expect huge pages in
+			 * their allocations due to apply_to_page_range not
+			 * supporting them.
+			 */
+
+			size_per_node = size;
+			if (node == NUMA_NO_NODE)
+				size_per_node /= num_online_nodes();
+			if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
+				shift = PMD_SHIFT;
+			else
+				shift = arch_vmap_pte_supported_shift(size_per_node);
+		} else {
 			shift = PMD_SHIFT;
-		else
-			shift = arch_vmap_pte_supported_shift(size_per_node);
+		}
 
 		align = max(real_align, 1UL << shift);
 		size = ALIGN(real_size, 1UL << shift);

