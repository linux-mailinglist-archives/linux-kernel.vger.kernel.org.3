Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7747FDDE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbhL0Otq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:49:46 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30117 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbhL0Otp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:49:45 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JN0q76hTkz1DKFm;
        Mon, 27 Dec 2021 22:46:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 22:49:43 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 22:49:42 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/3] arm64: Support huge vmalloc mappings
Date:   Mon, 27 Dec 2021 22:59:02 +0800
Message-ID: <20211227145903.187152-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch select HAVE_ARCH_HUGE_VMALLOC to let arm64 support huge
vmalloc mappings.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 arch/arm64/Kconfig                              | 1 +
 arch/arm64/kernel/module.c                      | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7b2f900fd243..e3f9fd7ec106 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1639,7 +1639,7 @@
 			precedence over memory_hotplug.memmap_on_memory.
 
 
-	hugevmalloc=	[PPC] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
+	hugevmalloc=	[KNL,PPC,ARM64] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
 			Format: { on | off }
 			Default set by CONFIG_HUGE_VMALLOC_DEFAULT_ENABLED.
 
@@ -3424,7 +3424,7 @@
 
 	nohugeiomap	[KNL,X86,PPC,ARM64] Disable kernel huge I/O mappings.
 
-	nohugevmalloc	[PPC] Disable kernel huge vmalloc mappings.
+	nohugevmalloc	[KNL,PPC,ARM64] Disable kernel huge vmalloc mappings.
 
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3bb0b67292b5..c34bbb4482b0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -142,6 +142,7 @@ config ARM64
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
 	select HAVE_ARCH_COMPILER_H
+	select HAVE_ARCH_HUGE_VMALLOC
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 309a27553c87..af7b4cbace2b 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -36,7 +36,8 @@ void *module_alloc(unsigned long size)
 		module_alloc_end = MODULES_END;
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
-				module_alloc_end, gfp_mask, PAGE_KERNEL, VM_DEFER_KMEMLEAK,
+				module_alloc_end, gfp_mask, PAGE_KERNEL,
+				VM_DEFER_KMEMLEAK | VM_NO_HUGE_VMAP,
 				NUMA_NO_NODE, __builtin_return_address(0));
 
 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
@@ -55,7 +56,7 @@ void *module_alloc(unsigned long size)
 		 */
 		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
 				module_alloc_base + SZ_2G, GFP_KERNEL,
-				PAGE_KERNEL, 0, NUMA_NO_NODE,
+				PAGE_KERNEL, VM_NO_HUGE_VMAP, NUMA_NO_NODE,
 				__builtin_return_address(0));
 
 	if (p && (kasan_module_alloc(p, size, gfp_mask) < 0)) {
-- 
2.26.2

