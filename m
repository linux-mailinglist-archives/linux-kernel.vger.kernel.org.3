Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E5C497AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbiAXItP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:49:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16732 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiAXItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:49:03 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jj3TK69wGzZfKT;
        Mon, 24 Jan 2022 16:45:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:49:01 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:49:00 +0800
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
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v20 3/5] arm64: kdump: reimplement crashkernel=X
Date:   Mon, 24 Jan 2022 16:47:06 +0800
Message-ID: <20220124084708.683-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220124084708.683-1-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
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

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/machine_kexec.c      |  9 +++-
 arch/arm64/kernel/machine_kexec_file.c | 12 ++++-
 arch/arm64/mm/init.c                   | 68 ++++++++++++++++++++++++--
 3 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e16b248699d5c3c..19c2d487cb08feb 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -329,8 +329,13 @@ bool crash_is_nosave(unsigned long pfn)
 
 	/* in reserved memory? */
 	addr = __pfn_to_phys(pfn);
-	if ((addr < crashk_res.start) || (crashk_res.end < addr))
-		return false;
+	if ((addr < crashk_res.start) || (crashk_res.end < addr)) {
+		if (!crashk_low_res.end)
+			return false;
+
+		if ((addr < crashk_low_res.start) || (crashk_low_res.end < addr))
+			return false;
+	}
 
 	if (!kexec_crash_image)
 		return true;
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
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6c653a2c7cff052..a5d43feac0d7d96 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -71,6 +71,30 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 #define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
 
+static int __init reserve_crashkernel_low(unsigned long long low_size)
+{
+	unsigned long long low_base;
+
+	/* passed with crashkernel=0,low ? */
+	if (!low_size)
+		return 0;
+
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
+	if (!low_base) {
+		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
+		return -ENOMEM;
+	}
+
+	pr_info("crashkernel low memory reserved: 0x%llx - 0x%llx (%lld MB)\n",
+		low_base, low_base + low_size, low_size >> 20);
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+	insert_resource(&iomem_resource, &crashk_low_res);
+
+	return 0;
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -81,29 +105,62 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
+	unsigned long long crash_low_size = SZ_256M;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	int ret;
+	bool fixed_base;
+	char *cmdline = boot_command_line;
 
-	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
-	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
-		return;
+	if (ret || !crash_size) {
+		unsigned long long low_size;
 
+		/* crashkernel=X,high */
+		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+
+		/* crashkernel=X,low */
+		ret = parse_crashkernel_low(cmdline, 0, &low_size, &crash_base);
+		if (!ret)
+			crash_low_size = low_size;
+
+		crash_max = CRASH_ADDR_HIGH_MAX;
+	}
+
+	fixed_base = !!crash_base;
 	crash_size = PAGE_ALIGN(crash_size);
 
 	/* User specifies base address explicitly. */
 	if (crash_base)
 		crash_max = crash_base + crash_size;
 
+retry:
 	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       crash_base, crash_max);
 	if (!crash_base) {
+		/*
+		 * Attempt to fully allocate low memory failed, fall back
+		 * to high memory, the minimum required low memory will be
+		 * reserved later.
+		 */
+		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+			crash_max = CRASH_ADDR_HIGH_MAX;
+			goto retry;
+		}
+
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
 	}
 
+	if (crash_base >= SZ_4G && reserve_crashkernel_low(crash_low_size)) {
+		memblock_phys_free(crash_base, crash_size);
+		return;
+	}
+
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
@@ -112,6 +169,9 @@ static void __init reserve_crashkernel(void)
 	 * map. Inform kmemleak so that it won't try to access it.
 	 */
 	kmemleak_ignore_phys(crash_base);
+	if (crashk_low_res.end)
+		kmemleak_ignore_phys(crashk_low_res.start);
+
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
-- 
2.25.1

