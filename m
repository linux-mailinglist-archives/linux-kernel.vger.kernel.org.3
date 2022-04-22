Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4033050B010
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiDVGEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiDVGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD9F4F9F1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:28 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so7043775pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCtPEUmganS3WW6hgnqPl75q8FroRAr1REDTeJ7X0R0=;
        b=I478Ghar3KWh63quvKkgtK9ltlcIKE6xMB4aGC1ywBJ0fiu1rd4oq8FEIaZBiWG2Vy
         XdbNKsmyGSP2SzgBZMBPoMsVEnZqXfDub+b+tWxI5A3JPJ1L8SI5CvfK/RZ7oiWTdrTs
         FdMzKDGt5hJLtxYG4I0kYObvHpro/xHMdZ4fyK3XldXONdspWEsbo2tUWCQ57yPGDRlv
         7gxnJJPW/H1V57G81YCRPeId/zxr4D7+CuH31t3RjSlJkRSqfQ8r39R4IMHRqDvvwP8D
         SWkGvKF3f1V902b3YuPg0HZJWLCsAMMmt9RzHu2kAgZqExJk0t8zhWPL0x2+MCIVs/Y0
         WnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCtPEUmganS3WW6hgnqPl75q8FroRAr1REDTeJ7X0R0=;
        b=jpjZsqu+qLgyUMtkiZYahFws8dyikprMet9zop4z8YiOQEm9iAnCmDPQPHwtLA88Bb
         9L/v9lB0fy9MI0epsmFI146qSps1buWcCDyuvtyK8rZNlEmVqmCHFALG+2rjic7CNlqR
         WHBGAMtQnAuJ0f0ry1VMIPEdKGkMe6BJWB589SyWnPEZBvr7VnPiFsEjThI0zdI0j/L4
         ECWHWp3gwaIE4CZPod6lonskVEd3VMb72F5T7XfsK3QSCaiC2vwHwduAj3yalr1e0HEv
         by3I+nxI3ltYbQIyslL37VDf599YMdjGaM2/4C8ITAgTZUFKRUVuJ8lm2kiqXl01XnKa
         9OWQ==
X-Gm-Message-State: AOAM532bLkaW1q+fa33b1ptwL+yuEYOWnY7fR2YlJv4CxO34N+xNAgqA
        c3owAkMUBxe+SrZU2lF0z8Q=
X-Google-Smtp-Source: ABdhPJychbw03HI4297NZJB2yHoXqNJYk8ferxJW1V428PntpJtqiVa6H3q8JY2D4MExZdVRlMhXOw==
X-Received: by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP id z5-20020a056a00240500b004e15008adccmr3352801pfh.35.1650607287854;
        Thu, 21 Apr 2022 23:01:27 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-116-20.tpgi.com.au. [193.116.116.20])
        by smtp.gmail.com with ESMTPSA id y16-20020a637d10000000b00381268f2c6fsm998607pgc.4.2022.04.21.23.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:01:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] Revert "vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLOW_HUGE_VMAP"
Date:   Fri, 22 Apr 2022 16:01:06 +1000
Message-Id: <20220422060107.781512-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422060107.781512-1-npiggin@gmail.com>
References: <20220422060107.781512-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 559089e0a93d44280ec3ab478830af319c56dbe3

The previous commit fixes huge vmalloc for drivers that use the
vmalloc_to_page() struct pages.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig                 |  6 ++++--
 arch/powerpc/kernel/module.c |  2 +-
 arch/s390/kvm/pv.c           |  7 ++++++-
 include/linux/vmalloc.h      |  4 ++--
 mm/vmalloc.c                 | 17 +++++++----------
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..29b0167c088b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -854,8 +854,10 @@ config HAVE_ARCH_HUGE_VMAP
 
 #
 #  Archs that select this would be capable of PMD-sized vmaps (i.e.,
-#  arch_vmap_pmd_supported() returns true). The VM_ALLOW_HUGE_VMAP flag
-#  must be used to enable allocations to use hugepages.
+#  arch_vmap_pmd_supported() returns true), and they must make no assumptions
+#  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VMAP flag
+#  can be used to prohibit arch-specific allocations from using hugepages to
+#  help with this (e.g., modules may require it).
 #
 config HAVE_ARCH_HUGE_VMALLOC
 	depends on HAVE_ARCH_HUGE_VMAP
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 97a76a8619fb..40a583e9d3c7 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -101,7 +101,7 @@ __module_alloc(unsigned long size, unsigned long start, unsigned long end, bool
 	 * too.
 	 */
 	return __vmalloc_node_range(size, 1, start, end, gfp, prot,
-				    VM_FLUSH_RESET_PERMS,
+				    VM_FLUSH_RESET_PERMS | VM_NO_HUGE_VMAP,
 				    NUMA_NO_NODE, __builtin_return_address(0));
 }
 
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index cc7c9599f43e..7f7c0d6af2ce 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -137,7 +137,12 @@ static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
 	/* Allocate variable storage */
 	vlen = ALIGN(virt * ((npages * PAGE_SIZE) / HPAGE_SIZE), PAGE_SIZE);
 	vlen += uv_info.guest_virt_base_stor_len;
-	kvm->arch.pv.stor_var = vzalloc(vlen);
+	/*
+	 * The Create Secure Configuration Ultravisor Call does not support
+	 * using large pages for the virtual memory area.
+	 * This is a hardware limitation.
+	 */
+	kvm->arch.pv.stor_var = vmalloc_no_huge(vlen);
 	if (!kvm->arch.pv.stor_var)
 		goto out_err;
 	return 0;
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index b159c2789961..3b1df7da402d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -26,7 +26,7 @@ struct notifier_block;		/* in notifier.h */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
 #define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
 #define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
-#define VM_ALLOW_HUGE_VMAP	0x00000400      /* Allow for huge pages on archs with HAVE_ARCH_HUGE_VMALLOC */
+#define VM_NO_HUGE_VMAP		0x00000400	/* force PAGE_SIZE pte mapping */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 	!defined(CONFIG_KASAN_VMALLOC)
@@ -153,7 +153,7 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			const void *caller) __alloc_size(1);
 void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 		int node, const void *caller) __alloc_size(1);
-void *vmalloc_huge(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
+void *vmalloc_no_huge(unsigned long size) __alloc_size(1);
 
 extern void *__vmalloc_array(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index cadfbb5155ea..09470361dc03 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3101,7 +3101,7 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
-	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
+	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
 		unsigned long size_per_node;
 
 		/*
@@ -3268,24 +3268,21 @@ void *vmalloc(unsigned long size)
 EXPORT_SYMBOL(vmalloc);
 
 /**
- * vmalloc_huge - allocate virtually contiguous memory, allow huge pages
- * @size:      allocation size
- * @gfp_mask:  flags for the page level allocator
+ * vmalloc_no_huge - allocate virtually contiguous memory using small pages
+ * @size:    allocation size
  *
- * Allocate enough pages to cover @size from the page level
+ * Allocate enough non-huge pages to cover @size from the page level
  * allocator and map them into contiguous kernel virtual space.
- * If @size is greater than or equal to PMD_SIZE, allow using
- * huge pages for the memory
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_huge(unsigned long size, gfp_t gfp_mask)
+void *vmalloc_no_huge(unsigned long size)
 {
 	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+				    GFP_KERNEL, PAGE_KERNEL, VM_NO_HUGE_VMAP,
 				    NUMA_NO_NODE, __builtin_return_address(0));
 }
-EXPORT_SYMBOL_GPL(vmalloc_huge);
+EXPORT_SYMBOL(vmalloc_no_huge);
 
 /**
  * vzalloc - allocate virtually contiguous memory with zero fill
-- 
2.35.1

