Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07947D2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245407AbhLVNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33896 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbhLVNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:26 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJtyT3TtlzcbyR;
        Wed, 22 Dec 2021 21:12:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:24 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:23 +0800
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
Subject: [PATCH v18 06/17] x86/setup: Update comments in reserve_crashkernel()
Date:   Wed, 22 Dec 2021 21:08:09 +0800
Message-ID: <20211222130820.1754-7-thunder.leizhen@huawei.com>
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

Add comments to describe which bootup parameters are processed by the
code, and make comments close to the code being commented.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 07a58313db5c5f7..52aa925877ca787 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -485,20 +485,20 @@ static void __init reserve_crashkernel(void)
 	if (flag == CRASHKERNEL_MEM_NONE)
 		return;
 
-	/* 0 means: find the address automatically */
 	if (!crash_base) {
 		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
+		 * For the case of crashkernel=X[@offset] and offset is omitted,
+		 * try the low memory first.
 		 */
 		if (!(flag & CRASHKERNEL_MEM_HIGH))
 			crash_base = memblock_phys_alloc_range(crash_size,
 						CRASH_ALIGN, CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX);
+
+		/*
+		 * If low memory allocation failed above, or for the case of
+		 * crashkernel=X,high, try the high memory.
+		 */
 		if (!crash_base)
 			crash_base = memblock_phys_alloc_range(crash_size,
 						CRASH_ALIGN, CRASH_ALIGN,
@@ -510,6 +510,10 @@ static void __init reserve_crashkernel(void)
 	} else {
 		unsigned long long start;
 
+		/*
+		 * The case of crashkernel=X@offset and offset is specified.
+		 * Only user-specified space can be reserved.
+		 */
 		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
 						  crash_base + crash_size);
 		if (start != crash_base) {
@@ -520,6 +524,10 @@ static void __init reserve_crashkernel(void)
 
 #ifdef CONFIG_X86_64
 	if (crash_base >= (1ULL << 32)) {
+		/*
+		 * Ensure that at least 256M extra low memory is allocated for
+		 * DMA buffers and swiotlb, if low memory size is not specified.
+		 */
 		if (!(flag & CRASHKERNEL_MEM_LOW)) {
 			/*
 			 * two parts from kernel/dma/swiotlb.c:
-- 
2.25.1

