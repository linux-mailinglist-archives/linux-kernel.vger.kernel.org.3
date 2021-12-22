Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5547D2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245354AbhLVNMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30163 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbhLVNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:26 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JJtwC0WRgz8vyV;
        Wed, 22 Dec 2021 21:10:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:23 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:22 +0800
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
Subject: [PATCH v18 05/17] x86/setup: Use parse_crashkernel_in_order() to make code logic clear
Date:   Wed, 22 Dec 2021 21:08:08 +0800
Message-ID: <20211222130820.1754-6-thunder.leizhen@huawei.com>
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

Currently, the parsing of "crashkernel=X,high" and the parsing of
"crashkernel=X,low" are not in the same function, but they are strongly
dependent, which affects readability. Use parse_crashkernel_in_order() to
bring them together.

In addition, the operation to ensure at least 256M low memory is moved out
of reserve_craskernel_low() so that it only needs to focus on low memory
allocation.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 69 ++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f997074d36f2484..07a58313db5c5f7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -393,32 +393,16 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #ifdef CONFIG_KEXEC_CORE
 
 #ifdef CONFIG_X86_64
-static int __init reserve_crashkernel_low(void)
+static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
-	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long long low_base = 0;
 	unsigned long low_mem_limit;
-	int ret;
 
 	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
 
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
+	/* passed with crashkernel=0,low ? */
+	if (!low_size)
+		return 0;
 
 	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
 	if (!low_base) {
@@ -457,7 +441,6 @@ static int __init reserve_crashkernel_low(void)
  * Returns the status flag of the parsing result of "crashkernel=", such as
  * CRASHKERNEL_MEM_NONE, CRASHKERNEL_MEM_HIGH.
  */
-__maybe_unused
 static int __init parse_crashkernel_in_order(char *cmdline,
 					     unsigned long long system_ram,
 					     unsigned long long *crash_size,
@@ -492,22 +475,15 @@ static int __init parse_crashkernel_in_order(char *cmdline,
 
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
-	bool high = false;
-	int ret;
+	unsigned long long crash_size, crash_base, total_mem, low_size;
+	int flag;
 
 	total_mem = memblock_phys_mem_size();
 
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
+	flag = parse_crashkernel_in_order(boot_command_line, total_mem,
+					  &crash_size, &crash_base, &low_size);
+	if (flag == CRASHKERNEL_MEM_NONE)
+		return;
 
 	/* 0 means: find the address automatically */
 	if (!crash_base) {
@@ -519,7 +495,7 @@ static void __init reserve_crashkernel(void)
 		 * So try low memory first and fall back to high memory
 		 * unless "crashkernel=size[KMG],high" is specified.
 		 */
-		if (!high)
+		if (!(flag & CRASHKERNEL_MEM_HIGH))
 			crash_base = memblock_phys_alloc_range(crash_size,
 						CRASH_ALIGN, CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX);
@@ -543,9 +519,24 @@ static void __init reserve_crashkernel(void)
 	}
 
 #ifdef CONFIG_X86_64
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
+	if (crash_base >= (1ULL << 32)) {
+		if (!(flag & CRASHKERNEL_MEM_LOW)) {
+			/*
+			 * two parts from kernel/dma/swiotlb.c:
+			 * -swiotlb size: user-specified with swiotlb= or default.
+			 *
+			 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+			 * to 8M for other buffers that may need to stay low too. Also
+			 * make sure we allocate enough extra low memory so that we
+			 * don't run out of DMA buffers for 32-bit devices.
+			 */
+			low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+		}
+
+		if (reserve_crashkernel_low(low_size)) {
+			memblock_phys_free(crash_base, crash_size);
+			return;
+		}
 	}
 #endif
 
-- 
2.25.1

