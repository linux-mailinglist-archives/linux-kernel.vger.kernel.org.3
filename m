Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB547D2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbhLVNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:52 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16852 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbhLVNMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:33 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JJty52rqVz91td;
        Wed, 22 Dec 2021 21:11:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:31 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:30 +0800
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
Subject: [PATCH v18 13/17] arm64: kdump: introduce some macros for crash kernel reservation
Date:   Wed, 22 Dec 2021 21:08:16 +0800
Message-ID: <20211222130820.1754-14-thunder.leizhen@huawei.com>
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

Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
upper bound of high crash memory, use macros instead.

Besides, keep consistent with x86, use CRASH_ALIGN as the lower bound
of crash kernel reservation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 arch/arm64/include/asm/kexec.h | 6 ++++++
 arch/arm64/mm/init.c           | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9839bfc163d7147..1b9edc69f0244ca 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -25,6 +25,12 @@
 
 #define KEXEC_ARCH KEXEC_ARCH_AARCH64
 
+/* 2M alignment for crash kernel regions */
+#define CRASH_ALIGN	SZ_2M
+
+#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
+#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a8834434af99ae0..be4595dc7459115 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -75,7 +75,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
-	unsigned long long crash_max = arm64_dma_phys_limit;
+	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
@@ -91,7 +91,7 @@ static void __init reserve_crashkernel(void)
 		crash_max = crash_base + crash_size;
 
 	/* Current arm64 boot protocol requires 2MB alignment */
-	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
+	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
 					       crash_base, crash_max);
 	if (!crash_base) {
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-- 
2.25.1

