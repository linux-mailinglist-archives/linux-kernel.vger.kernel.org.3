Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF847D2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbhLVNNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:13:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15964 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245364AbhLVNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:35 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJtvR5tZ9zZdmv;
        Wed, 22 Dec 2021 21:09:23 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:32 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:31 +0800
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
Subject: [PATCH v18 14/17] arm64: kdump: reimplement crashkernel=X
Date:   Wed, 22 Dec 2021 21:08:17 +0800
Message-ID: <20211222130820.1754-15-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211222130820.1754-1-thunder.leizhen@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which
will fail when there is no enough low memory.
2. If reserving crashkernel above 4G, in this case, crash dump
kernel will boot failure because there is no low memory available
for allocation.

To solve these issues, change the behavior of crashkernel=X and
introduce crashkernel=X,[high,low]. crashkernel=X tries low allocation
in DMA zone, and fall back to high allocation if it fails.
We can also use "crashkernel=X,high" to select a region above DMA zone,
which also tries to allocate at least 256M in DMA zone automatically.
"crashkernel=Y,low" can be used to allocate specified size low memory.

Another minor change, there may be two regions reserved for crash
dump kernel, in order to distinct from the high region and make no
effect to the use of existing kexec-tools, rename the low region as
"Crash kernel (low)".

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/arm64/Kconfig                     |  1 +
 arch/arm64/include/asm/kexec.h         |  4 ++
 arch/arm64/kernel/machine_kexec_file.c | 12 +++++-
 arch/arm64/kernel/setup.c              | 13 +++++-
 arch/arm64/mm/init.c                   | 59 +++++---------------------
 5 files changed, 38 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17ffb..4b99efa36da3793 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,7 @@ config ARM64
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 1b9edc69f0244ca..3bde0079925d771 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,6 +96,10 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+extern void __init reserve_crashkernel(void);
+#endif
+
 #if defined(CONFIG_KEXEC_CORE)
 void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 		      unsigned long arg0, unsigned long arg1,
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848886..889951291cc0f9c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -65,10 +65,18 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 
 	/* Exclude crashkernel region */
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
+
+	if (crashk_low_res.end) {
+		ret = crash_exclude_mem_range(cmem, crashk_low_res.start, crashk_low_res.end);
+		if (ret)
+			goto out;
+	}
 
-	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);
 
+out:
 	kfree(cmem);
 	return ret;
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index be5f85b0a24de69..4bb2e55366be64d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -248,7 +248,18 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		/*
+		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
+		 * region in /proc/iomem.
+		 * In order to distinct from the high region and make no effect
+		 * to the use of existing kexec-tools, rename the low region as
+		 * "Crash kernel (low)".
+		 */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+				crashk_low_res.end <= res->end) {
+			crashk_low_res.name = "Crash kernel (low)";
+			request_resource(res, &crashk_low_res);
+		}
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index be4595dc7459115..85c83e4eff2b6c4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -36,6 +36,7 @@
 #include <asm/fixmap.h>
 #include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/kvm_host.h>
 #include <asm/memory.h>
 #include <asm/numa.h>
@@ -64,57 +65,11 @@ EXPORT_SYMBOL(memstart_addr);
  */
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
-#ifdef CONFIG_KEXEC_CORE
-/*
- * reserve_crashkernel() - reserves memory for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
- */
+#ifndef CONFIG_KEXEC_CORE
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_base, crash_size;
-	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
-	int ret;
-
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
-				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
-		return;
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	/* User specifies base address explicitly. */
-	if (crash_base)
-		crash_max = crash_base + crash_size;
-
-	/* Current arm64 boot protocol requires 2MB alignment */
-	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       crash_base, crash_max);
-	if (!crash_base) {
-		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-			crash_size);
-		return;
-	}
-
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
-
-	/*
-	 * The crashkernel memory will be removed from the kernel linear
-	 * map. Inform kmemleak so that it won't try to access it.
-	 */
-	kmemleak_ignore_phys(crash_base);
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
 }
-#else
-static void __init reserve_crashkernel(void)
-{
-}
-#endif /* CONFIG_KEXEC_CORE */
+#endif
 
 /*
  * Return the maximum physical address for a zone accessible by the given bits
@@ -362,6 +317,14 @@ void __init bootmem_init(void)
 	 * reserved, so do it here.
 	 */
 	reserve_crashkernel();
+#ifdef CONFIG_KEXEC_CORE
+	/*
+	 * The low region is intended to be used for crash dump kernel devices,
+	 * just mark the low region as "nomap" simply.
+	 */
+	if (crashk_low_res.end)
+		memblock_mark_nomap(crashk_low_res.start, resource_size(&crashk_low_res));
+#endif
 
 	memblock_dump_all();
 }
-- 
2.25.1

