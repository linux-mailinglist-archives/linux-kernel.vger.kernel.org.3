Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BBB553265
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350784AbiFUMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbiFUMos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:44:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232101705F;
        Tue, 21 Jun 2022 05:44:45 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LS5jW1zbyzSgs6;
        Tue, 21 Jun 2022 20:41:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 20:44:42 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 20:44:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v2 1/3] arm64: kdump: Provide default size when crashkernel=Y,low is not specified
Date:   Tue, 21 Jun 2022 20:42:46 +0800
Message-ID: <20220621124249.1315-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220621124249.1315-1-thunder.leizhen@huawei.com>
References: <20220621124249.1315-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistent with the implementation of x86 and improve cross-platform
user experience. Try to allocate at least 256 MiB low memory automatically
for the case that crashkernel=,high is explicitly specified, while
crashkenrel=,low is omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +-------
 arch/arm64/mm/init.c                            | 12 +++++++++++-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f239..65a2c3a22a4b57d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -843,7 +843,7 @@
 			available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, X86-64] range under 4G. When crashkernel=X,high
+			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
@@ -857,12 +857,6 @@
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 
-			[KNL, ARM64] range in low memory.
-			This one lets the user specify a low range in the
-			DMA zone for the crash dump kernel.
-			It will be ignored when crashkernel=X,high is not used
-			or memory reserved is located in the DMA zones.
-
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 339ee84e5a61a0b..5390f361208ccf7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
 
+/*
+ * This is an empirical value in x86_64 and taken here directly. Please
+ * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
+ * details.
+ */
+#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
+	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
+
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base;
@@ -147,7 +155,9 @@ static void __init reserve_crashkernel(void)
 		 * is not allowed.
 		 */
 		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
-		if (ret && (ret != -ENOENT))
+		if (ret == -ENOENT)
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+		else if (ret)
 			return;
 
 		crash_max = CRASH_ADDR_HIGH_MAX;
-- 
2.25.1

