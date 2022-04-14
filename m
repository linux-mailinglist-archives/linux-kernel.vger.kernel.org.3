Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F903500CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbiDNMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiDNMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:00:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99C588784;
        Thu, 14 Apr 2022 04:58:34 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfHxP3vv7zgYQ7;
        Thu, 14 Apr 2022 19:56:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 19:58:32 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 19:58:31 +0800
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
Subject: [PATCH v22 4/9] arm64: kdump: Don't force page-level mappings for memory above 4G
Date:   Thu, 14 Apr 2022 19:57:15 +0800
Message-ID: <20220414115720.1887-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the crashkernel reservation is deferred, such boundaries are not known
when the linear mapping is created. But its upper limit is fixed, cannot
above 4G. Therefore, unless otherwise required, block mapping should be
used for memory above 4G to improve performance.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/mmu.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7666b4955e45cb3..8c6666cbc7f2216 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -504,7 +504,7 @@ static void __init map_mem(pgd_t *pgdp)
 	phys_addr_t kernel_start = __pa_symbol(_stext);
 	phys_addr_t kernel_end = __pa_symbol(__init_begin);
 	phys_addr_t start, end;
-	int flags = NO_EXEC_MAPPINGS;
+	int flags = NO_EXEC_MAPPINGS, eflags = 0;
 	u64 i;
 
 	/*
@@ -530,7 +530,7 @@ static void __init map_mem(pgd_t *pgdp)
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map &&
 	    (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)))
-		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+		eflags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 	else if (crashk_res.end)
 		memblock_mark_nomap(crashk_res.start,
 				    resource_size(&crashk_res));
@@ -540,13 +540,31 @@ static void __init map_mem(pgd_t *pgdp)
 	for_each_mem_range(i, &start, &end) {
 		if (start >= end)
 			break;
+
+#ifdef CONFIG_KEXEC_CORE
+		if (eflags && (end >= SZ_4G)) {
+			/*
+			 * The memory block cross the 4G boundary.
+			 * Forcibly use page-level mappings for memory under 4G.
+			 */
+			if (start < SZ_4G) {
+				__map_memblock(pgdp, start, SZ_4G - 1,
+					       pgprot_tagged(PAGE_KERNEL), flags | eflags);
+				start  = SZ_4G;
+			}
+
+			/* Page-level mappings is not mandatory for memory above 4G */
+			eflags = 0;
+		}
+#endif
+
 		/*
 		 * The linear map must allow allocation tags reading/writing
 		 * if MTE is present. Otherwise, it has the same attributes as
 		 * PAGE_KERNEL.
 		 */
 		__map_memblock(pgdp, start, end, pgprot_tagged(PAGE_KERNEL),
-			       flags);
+			       flags | eflags);
 	}
 
 	/*
-- 
2.25.1

