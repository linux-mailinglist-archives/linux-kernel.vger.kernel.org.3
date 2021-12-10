Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCC46FAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhLJHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:00:47 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32900 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbhLJHAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:00:13 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9MBZ6NW3zcdMX;
        Fri, 10 Dec 2021 14:56:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:56:36 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:56:35 +0800
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
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: [PATCH v17 05/10] x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
Date:   Fri, 10 Dec 2021 14:55:28 +0800
Message-ID: <20211210065533.2023-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211210065533.2023-1-thunder.leizhen@huawei.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

Make the functions reserve_crashkernel[_low]() as generic. Since
reserve_crashkernel[_low]() implementations are quite similar on other
architectures as well, we can have more users of this later.

So have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in arch/Kconfig and
select this by X86.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/Kconfig                 |   3 +
 arch/x86/Kconfig             |   2 +
 arch/x86/include/asm/elf.h   |   3 +
 arch/x86/include/asm/kexec.h |  28 ++++++-
 arch/x86/kernel/setup.c      | 143 +-------------------------------
 include/linux/crash_core.h   |   3 +
 include/linux/kexec.h        |   2 -
 kernel/crash_core.c          | 156 +++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c          |  17 ----
 9 files changed, 194 insertions(+), 163 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d3c4ab249e9c275..7bdb32c41985dc5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -24,6 +24,9 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config ARCH_WANT_RESERVE_CRASH_KERNEL
+	bool
+
 config SET_FS
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2efb86..bd78ed8193079b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -12,6 +12,7 @@ config X86_32
 	depends on !64BIT
 	# Options that are inherently 32-bit kernel only:
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
 	select GENERIC_VDSO_32
@@ -28,6 +29,7 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 29fea180a6658e8..7a6c36cff8331f5 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -94,6 +94,9 @@ extern unsigned int vdso32_enabled;
 
 #define elf_check_arch(x)	elf_check_arch_ia32(x)
 
+/* We can also handle crash dumps from 64 bit kernel. */
+# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
+
 /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
    contains a pointer to a function which might be registered using `atexit'.
    This provides a mean for the dynamic linker to call DT_FINI functions for
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 3a22e65262aa70b..3ff38a1353a2b86 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -21,6 +21,27 @@
 /* 16M alignment for crash kernel regions */
 #define CRASH_ALIGN		SZ_16M
 
+/*
+ * Keep the crash kernel below this limit.
+ *
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
+ * due to mapping restrictions.
+ *
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
+ */
+#ifdef CONFIG_X86_32
+# define CRASH_ADDR_LOW_MAX	SZ_512M
+# define CRASH_ADDR_HIGH_MAX	SZ_512M
+#else
+# define CRASH_ADDR_LOW_MAX	SZ_4G
+# define CRASH_ADDR_HIGH_MAX	SZ_64T
+#endif
+
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
@@ -51,9 +72,6 @@ struct kimage;
 
 /* The native architecture */
 # define KEXEC_ARCH KEXEC_ARCH_386
-
-/* We can also handle crash dumps from 64 bit kernel. */
-# define vmcore_elf_check_arch_cross(x) ((x)->e_machine == EM_X86_64)
 #else
 /* Maximum physical address we can use pages from */
 # define KEXEC_SOURCE_MEMORY_LIMIT      (MAXMEM-1)
@@ -195,6 +213,10 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_KEXEC_CORE
+extern void __init reserve_crashkernel(void);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 7ae00716a208f82..5519baa7f4b964e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -39,6 +39,7 @@
 #include <asm/io_apic.h>
 #include <asm/kasan.h>
 #include <asm/kaslr.h>
+#include <asm/kexec.h>
 #include <asm/mce.h>
 #include <asm/mtrr.h>
 #include <asm/realmode.h>
@@ -386,147 +387,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	}
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-
-#ifdef CONFIG_KEXEC_CORE
-
-/*
- * Keep the crash kernel below this limit.
- *
- * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
- * due to mapping restrictions.
- *
- * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
- * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jump could be from 5-level paging to 4-level paging, the jump will fail if
- * the kernel is put above 64 TB, and during the 1st kernel bootup there's
- * no good way to detect the paging mode of the target kernel which will be
- * loaded for dumping.
- */
-#ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	SZ_512M
-# define CRASH_ADDR_HIGH_MAX	SZ_512M
-#else
-# define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	SZ_64T
-#endif
-
-static int __init reserve_crashkernel_low(void)
-{
-#ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long low_mem_limit;
-	int ret;
-
-	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
-	if (ret) {
-		/*
-		 * two parts from kernel/dma/swiotlb.c:
-		 * -swiotlb size: user-specified with swiotlb= or default.
-		 *
-		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-		 * to 8M for other buffers that may need to stay low too. Also
-		 * make sure we allocate enough extra low memory so that we
-		 * don't run out of DMA buffers for 32-bit devices.
-		 */
-		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-	} else {
-		/* passed with crashkernel=0,low ? */
-		if (!low_size)
-			return 0;
-	}
-
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
-			CRASH_ADDR_LOW_MAX);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(low_mem_limit >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-#endif
-	return 0;
-}
-
-static void __init reserve_crashkernel(void)
-{
-	unsigned long long crash_size, crash_base, total_mem;
-	bool high = false;
-	int ret;
-
-	total_mem = memblock_phys_mem_size();
-
-	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
-	if (ret != 0 || crash_size <= 0) {
-		/* crashkernel=X,high */
-		ret = parse_crashkernel_high(boot_command_line, total_mem,
-					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
-			return;
-		high = true;
-	}
-
-	/* 0 means: find the address automatically */
-	if (!crash_base) {
-		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
-		 * also allocates 256M extra low memory for DMA buffers
-		 * and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
-		 */
-		if (!high)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX);
-		if (!crash_base)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
-
-		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
-						  crash_base + crash_size);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-
-	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
-
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-}
-#else
+#ifndef CONFIG_KEXEC_CORE
 static void __init reserve_crashkernel(void)
 {
 }
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e7db..f6b99da4ed08ecf 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -73,6 +73,9 @@ extern unsigned char *vmcoreinfo_data;
 extern size_t vmcoreinfo_size;
 extern u32 *vmcoreinfo_note;
 
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729e1e..cd744d962f6f417 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -352,8 +352,6 @@ extern int kexec_load_disabled;
 
 /* Location of a reserved region to hold the crash kernel.
  */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
 /* flag to track if kexec reboot is in progress */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index eb53f5ec62c900f..b23cfc0ca8905fd 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -8,6 +8,12 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
+
+#ifdef CONFIG_KEXEC_CORE
+#include <asm/kexec.h>
+#endif
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -22,6 +28,22 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+/* Location of the reserved area for the crash kernel */
+struct resource crashk_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+struct resource crashk_low_res = {
+	.name  = "Crash kernel",
+	.start = 0,
+	.end   = 0,
+	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+	.desc  = IORES_DESC_CRASH_KERNEL
+};
+
 /*
  * parsing the "crashkernel" commandline
  *
@@ -295,6 +317,140 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+/*
+ * --------- Crashkernel reservation ------------------------------
+ */
+
+#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
+static int __init reserve_crashkernel_low(void)
+{
+#ifdef CONFIG_64BIT
+	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long low_mem_limit;
+	int ret;
+
+	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
+	if (ret) {
+		/*
+		 * two parts from kernel/dma/swiotlb.c:
+		 * -swiotlb size: user-specified with swiotlb= or default.
+		 *
+		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+		 * to 8M for other buffers that may need to stay low too. Also
+		 * make sure we allocate enough extra low memory so that we
+		 * don't run out of DMA buffers for 32-bit devices.
+		 */
+		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+	} else {
+		/* passed with crashkernel=0,low ? */
+		if (!low_size)
+			return 0;
+	}
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
+			CRASH_ADDR_LOW_MAX);
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
+/*
+ * reserve_crashkernel() - reserves memory for crash kernel
+ *
+ * This function reserves memory area given in "crashkernel=" kernel command
+ * line parameter. The memory reserved is used by dump capture kernel when
+ * primary kernel is crashing.
+ */
+void __init reserve_crashkernel(void)
+{
+	unsigned long long crash_size, crash_base, total_mem;
+	bool high = false;
+	int ret;
+
+	total_mem = memblock_phys_mem_size();
+
+	/* crashkernel=XM */
+	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
+	if (ret != 0 || crash_size <= 0) {
+		/* crashkernel=X,high */
+		ret = parse_crashkernel_high(boot_command_line, total_mem,
+					     &crash_size, &crash_base);
+		if (ret != 0 || crash_size <= 0)
+			return;
+		high = true;
+	}
+
+	/* 0 means: find the address automatically */
+	if (!crash_base) {
+		/*
+		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
+		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
+		 * also allocates 256M extra low memory for DMA buffers
+		 * and swiotlb.
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
+			return;
+		}
+	} else {
+		/* User specifies base address explicitly. */
+		unsigned long long start;
+
+		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
+			pr_warn("cannot reserve crashkernel: base address is not %ldMB aligned\n",
+				(unsigned long)CRASH_ALIGN >> 20);
+			return;
+		}
+
+		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
+						  crash_base + crash_size);
+		if (start != crash_base) {
+			pr_info("crashkernel reservation failed - memory is in use.\n");
+			return;
+		}
+	}
+
+	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
+	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
+		(unsigned long)(crash_size >> 20),
+		(unsigned long)(crash_base >> 20),
+		(unsigned long)(total_mem >> 20));
+
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+}
+#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5a5d192a89ac307..1e0d4909bbb6b77 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -54,23 +54,6 @@ note_buf_t __percpu *crash_notes;
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
-
-/* Location of the reserved area for the crash kernel */
-struct resource crashk_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-struct resource crashk_low_res = {
-	.name  = "Crash kernel",
-	.start = 0,
-	.end   = 0,
-	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
-	.desc  = IORES_DESC_CRASH_KERNEL
-};
-
 int kexec_should_crash(struct task_struct *p)
 {
 	/*
-- 
2.25.1

