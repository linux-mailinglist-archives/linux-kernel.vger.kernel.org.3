Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B35147D2D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbhLVNMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:12:48 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15961 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbhLVNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:12:29 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JJtvK3JFvzZddm;
        Wed, 22 Dec 2021 21:09:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:26 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 21:12:25 +0800
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
Subject: [PATCH v18 08/17] x86/setup: Add build option ARCH_WANT_RESERVE_CRASH_KERNEL
Date:   Wed, 22 Dec 2021 21:08:11 +0800
Message-ID: <20211222130820.1754-9-thunder.leizhen@huawei.com>
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

There are multiple ARCHs that implement reserve_crashkernel(), all of them
are marked as static. Currently, we want to combine the implementations on
x86 and arm64 into one, and move it to public crash_core.c. To avoid
symbol conflicts on other platforms, add a new build option
ARCH_WANT_RESERVE_CRASH_KERNEL. And change CONFIG_X86_64 to CONFIG_64BIT,
so it can be shared with arm64, or other users in future.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Co-developed-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/Kconfig            |  3 +++
 arch/x86/Kconfig        |  2 ++
 arch/x86/kernel/setup.c | 10 +++++-----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d3c4ab249e9c275..f53dd7852290b9a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -11,6 +11,9 @@ source "arch/$(SRCARCH)/Kconfig"
 
 menu "General architecture-dependent options"
 
+config ARCH_WANT_RESERVE_CRASH_KERNEL
+	bool
+
 config CRASH_CORE
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
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index abff57ffbe92884..beb73cce4b8b826 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -390,9 +390,9 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  * --------- Crashkernel reservation ------------------------------
  */
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_64BIT
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base = 0;
@@ -456,7 +456,7 @@ static int __init parse_crashkernel_in_order(char *cmdline,
 	if (!ret && crash_size > 0)
 		return CRASHKERNEL_MEM_CLASSIC;
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_64BIT
 	/* crashkernel=X,high */
 	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
 	if (ret || crash_size <= 0)
@@ -522,7 +522,7 @@ static void __init reserve_crashkernel(void)
 		}
 	}
 
-#ifdef CONFIG_X86_64
+#ifdef CONFIG_64BIT
 	if (crash_base >= CRASH_ADDR_LOW_MAX) {
 		/*
 		 * Ensure that at least 256M extra low memory is allocated for
@@ -556,7 +556,7 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end   = crash_base + crash_size - 1;
 }
-#endif
+#endif	/* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
 
 static struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
-- 
2.25.1

