Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0E47F5DD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 09:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhLZI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 03:29:52 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15977 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhLZI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 03:29:51 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JMDRH0Tw8zZdkM;
        Sun, 26 Dec 2021 16:26:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 16:29:49 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 26 Dec 2021 16:29:48 +0800
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
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] mm: vmalloc: Let user to control huge vmalloc default behavior
Date:   Sun, 26 Dec 2021 16:39:10 +0800
Message-ID: <20211226083912.166512-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
References: <20211226083912.166512-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HUGE_VMALLOC_DEFAULT_ENABLED to let user to choose whether or
not enable huge vmalloc mappings by default, and this could make
more architectures to enable huge vmalloc mappings feature but
don't want to enable it by default.

Add hugevmalloc=on/off parameter to enable or disable this feature
at boot time, nohugevmalloc is still supported and equivalent to
hugevmalloc=off.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../admin-guide/kernel-parameters.txt          | 12 ++++++++++++
 arch/powerpc/Kconfig                           |  1 +
 mm/Kconfig                                     |  7 +++++++
 mm/vmalloc.c                                   | 18 +++++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2fba82431efb..4107136097a6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1629,6 +1629,18 @@
 			If both parameters are enabled, hugetlb_free_vmemmap takes
 			precedence over memory_hotplug.memmap_on_memory.
 
+
+	hugevmalloc=	[PPC] Reguires CONFIG_HAVE_ARCH_HUGE_VMALLOC
+			Format: { on | off }
+			Default set by CONFIG_HUGE_VMALLOC_DEFAULT_ENABLED.
+
+			This parameter enables/disables kernel huge vmalloc
+			mappings at boot time.
+
+			on:  Enable the feature
+			off: Disable the feature
+			     Equivalent to: nohugevmalloc
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..d59b221be264 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,6 +246,7 @@ config PPC
 	select HAVE_STATIC_CALL			if PPC32
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HUGE_VMALLOC_DEFAULT_ENABLED	if HAVE_ARCH_HUGE_VMALLOC
 	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64 && HUGETLB_PAGE
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
diff --git a/mm/Kconfig b/mm/Kconfig
index 356f4f2c779e..4ba91c0359bd 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -262,6 +262,13 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 	  HUGETLB_PAGE_ORDER when there are multiple HugeTLB page sizes available
 	  on a platform.
 
+config HUGE_VMALLOC_DEFAULT_ENABLED
+	bool "Enable huge vmalloc mappings by default"
+	depends on HAVE_ARCH_HUGE_VMALLOC
+	help
+	  Enable huge vmalloc mappings by default, this value could be overridden
+	  by hugevmalloc=off|on.
+
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d2a00ad4e1dd..3b6f99753816 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -58,7 +58,7 @@ static const unsigned int ioremap_max_page_shift = PAGE_SHIFT;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
-static bool __ro_after_init vmap_allow_huge = true;
+static bool __ro_after_init vmap_allow_huge = IS_ENABLED(CONFIG_HUGE_VMALLOC_DEFAULT_ENABLED);
 
 static int __init set_nohugevmalloc(char *str)
 {
@@ -66,6 +66,22 @@ static int __init set_nohugevmalloc(char *str)
 	return 0;
 }
 early_param("nohugevmalloc", set_nohugevmalloc);
+
+static int __init set_hugevmalloc(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "on"))
+		vmap_allow_huge = true;
+	else if (!strcmp(str, "off"))
+		vmap_allow_huge = true;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugevmalloc=", set_hugevmalloc);
 #else /* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
 static const bool vmap_allow_huge = false;
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMALLOC */
-- 
2.26.2

