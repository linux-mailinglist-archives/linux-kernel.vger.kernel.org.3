Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FD56F997
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGKJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiGKJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:04:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BD3C36;
        Mon, 11 Jul 2022 02:04:49 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhHvs54cgzkWbt;
        Mon, 11 Jul 2022 17:02:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 17:04:42 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 17:04:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v3 1/2] arm64: kdump: Provide default size when crashkernel=Y,low is not specified
Date:   Mon, 11 Jul 2022 17:03:18 +0800
Message-ID: <20220711090319.1604-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220711090319.1604-1-thunder.leizhen@huawei.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

