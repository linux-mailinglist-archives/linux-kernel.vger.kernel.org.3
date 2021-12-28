Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C84809A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhL1N3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:29:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:29302 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhL1N3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:29:04 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JNb2n6H2VzbjSb;
        Tue, 28 Dec 2021 21:28:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 21:29:02 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 21:29:00 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>
Subject: [PATCH v19 07/13] kdump: Add helper reserve_crashkernel_mem[_low]()
Date:   Tue, 28 Dec 2021 21:26:06 +0800
Message-ID: <20211228132612.1860-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211228132612.1860-1-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper reserve_crashkernel_mem[_low]() to reserve high and low memory
for crash kernel. The implementation of these two functions is based on
function reserve_crashkernel[_low]() in arch/x86/kernel/setup.c. But the
following adaptations are made:
1. To avoid compilation problems on other architectures, provide default
   values for macro CRASH[_BASE]_ALIGN, CRASH_ADDR_{LOW|HIGH}_MAX, and add
   new macro CRASH_LOW_SIZE_MIN.
2. Only functions that reserve crash memory are extracted from
   reserve_crashkernel(), excluding functions such as parse_crashkernel()
   and insert_resource().
3. Change "return;" in reserve_crashkernel() to "return -ENOMEM;".
4. Change call reserve_crashkernel_low() to call
   reserve_crashkernel_mem_low().
5. Change CONFIG_X86_64 to CONFIG_64BIT.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h |   6 ++
 kernel/crash_core.c        | 154 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index f5437c9c9411fce..2e19632f8d45a60 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -86,5 +86,11 @@ int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 int __init parse_crashkernel_high_low(char *cmdline,
 				      unsigned long long *high_size,
 				      unsigned long long *low_size);
+int __init reserve_crashkernel_mem_low(unsigned long long low_size);
+int __init reserve_crashkernel_mem(unsigned long long system_ram,
+				   unsigned long long crash_size,
+				   unsigned long long crash_base,
+				   unsigned long long low_size,
+				   bool high);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 686d8a65e12a337..4bd30098534a184 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -5,7 +5,9 @@
  */
 
 #include <linux/buildid.h>
-#include <linux/crash_core.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 
@@ -345,6 +347,156 @@ int __init parse_crashkernel_high_low(char *cmdline,
 	return 0;
 }
 
+/* alignment for crash kernel dynamic regions */
+#ifndef CRASH_ALIGN
+#define CRASH_ALIGN		SZ_2M
+#endif
+
+/* alignment for crash kernel fixed region */
+#ifndef CRASH_BASE_ALIGN
+#define CRASH_BASE_ALIGN	SZ_2M
+#endif
+
+/* upper bound for crash low memory */
+#ifndef CRASH_ADDR_LOW_MAX
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+#define CRASH_ADDR_LOW_MAX	SZ_4G
+#else
+#define CRASH_ADDR_LOW_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
+#endif
+#endif
+
+/* upper bound for crash high memory */
+#ifndef CRASH_ADDR_HIGH_MAX
+#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
+#endif
+
+#ifdef CONFIG_SWIOTLB
+/*
+ * two parts from kernel/dma/swiotlb.c:
+ * -swiotlb size: user-specified with swiotlb= or default.
+ *
+ * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+ * to 8M for other buffers that may need to stay low too. Also
+ * make sure we allocate enough extra low memory so that we
+ * don't run out of DMA buffers for 32-bit devices.
+ */
+#define CRASH_LOW_SIZE_MIN	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
+#else
+#define CRASH_LOW_SIZE_MIN	(256UL << 20)
+#endif
+
+/**
+ * reserve_crashkernel_mem_low - Reserve crash kernel low memory.
+ *
+ * @low_size:	The memory size specified by "crashkernel=Y,low" or "-1"
+ *		if it's not specified.
+ *
+ * Returns 0 on success, else a negative status code.
+ */
+int __init reserve_crashkernel_mem_low(unsigned long long low_size)
+{
+#ifdef CONFIG_64BIT
+	unsigned long long low_base = 0;
+	unsigned long low_mem_limit;
+
+	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
+
+	/* crashkernel=Y,low is not specified */
+	if ((long)low_size < 0) {
+		low_size = CRASH_LOW_SIZE_MIN;
+	} else {
+		/* passed with crashkernel=0,low ? */
+		if (!low_size)
+			return 0;
+	}
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
+		       (unsigned long)(low_size >> 20));
+		return -ENOMEM;
+	}
+
+	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
+		(unsigned long)(low_size >> 20),
+		(unsigned long)(low_base >> 20),
+		(unsigned long)(low_mem_limit >> 20));
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+#endif
+	return 0;
+}
+
+/**
+ * reserve_crashkernel_mem - Reserve crash kernel memory.
+ *
+ * @system_ram: Total system memory size.
+ * @crash_size: The memory size specified by "crashkernel=X[@offset]" or
+ *		"crashkernel=X,high".
+ * @crash_base: The base address specified by "crashkernel=X@offset"
+ * @low_size:	The memory size specified by "crashkernel=Y,low" or "-1"
+ *		if it's not specified.
+ * @high:	Whether "crashkernel=X,high" is specified.
+ *
+ * Returns 0 on success, else a negative status code.
+ */
+int __init reserve_crashkernel_mem(unsigned long long system_ram,
+				   unsigned long long crash_size,
+				   unsigned long long crash_base,
+				   unsigned long long low_size,
+				   bool high)
+{
+	/* 0 means: find the address automatically */
+	if (!crash_base) {
+		/*
+		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
+		 * crashkernel=x,high reserves memory over 4G, also allocates
+		 * 256M extra low memory for DMA buffers and swiotlb.
+		 * But the extra memory is not required for all machines.
+		 * So try low memory first and fall back to high memory
+		 * unless "crashkernel=size[KMG],high" is specified.
+		 */
+		if (!high)
+			crash_base = memblock_phys_alloc_range(crash_size,
+						CRASH_ALIGN, CRASH_ALIGN,
+						CRASH_ADDR_LOW_MAX);
+		if (!crash_base)
+			crash_base = memblock_phys_alloc_range(crash_size,
+						CRASH_ALIGN, CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX);
+		if (!crash_base) {
+			pr_info("crashkernel reservation failed - No suitable area found.\n");
+			return -ENOMEM;
+		}
+	} else {
+		unsigned long long start;
+
+		start = memblock_phys_alloc_range(crash_size, CRASH_BASE_ALIGN, crash_base,
+						  crash_base + crash_size);
+		if (start != crash_base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return -ENOMEM;
+		}
+	}
+
+	if (crash_base >= (1ULL << 32) && reserve_crashkernel_mem_low(low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return -ENOMEM;
+	}
+
+	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
+		(unsigned long)(crash_size >> 20),
+		(unsigned long)(crash_base >> 20),
+		(unsigned long)(system_ram >> 20));
+
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.25.1

