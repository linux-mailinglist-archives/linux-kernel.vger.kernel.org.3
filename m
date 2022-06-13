Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FB85481B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiFMIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiFMILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:11:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A71EAE7;
        Mon, 13 Jun 2022 01:11:39 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM42C4Z3rzRj2S;
        Mon, 13 Jun 2022 16:08:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:07 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:05 +0800
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
Subject: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash high memory
Date:   Mon, 13 Jun 2022 16:09:32 +0800
Message-ID: <20220613080932.663-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220613080932.663-1-thunder.leizhen@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
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

If the crashkernel has both high memory above DMA zones and low memory
in DMA zones, kexec always loads the content such as Image and dtb to the
high memory instead of the low memory. This means that only high memory
requires write protection based on page-level mapping. The allocation of
high memory does not depend on the DMA boundary. So we can reserve the
high memory first even if the crashkernel reservation is deferred.

This means that the block mapping can still be performed on other kernel
linear address spaces, the TLB miss rate can be reduced and the system
performance will be improved.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/init.c | 71 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index fb24efbc46f5ef4..ae0bae2cafe6ab0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -141,15 +141,44 @@ static void __init reserve_crashkernel(int dma_state)
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
 	int dma_enabled = IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
-	int ret;
+	int ret, skip_res = 0, skip_low_res = 0;
 	bool fixed_base;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	if ((!dma_enabled && (dma_state != DMA_PHYS_LIMIT_UNKNOWN)) ||
-	     (dma_enabled && (dma_state != DMA_PHYS_LIMIT_KNOWN)))
-		return;
+	/*
+	 * In the following table:
+	 * X,high  means crashkernel=X,high
+	 * unknown means dma_state = DMA_PHYS_LIMIT_UNKNOWN
+	 * known   means dma_state = DMA_PHYS_LIMIT_KNOWN
+	 *
+	 * The first two columns indicate the status, and the last two
+	 * columns indicate the phase in which crash high or low memory
+	 * needs to be reserved.
+	 *  ---------------------------------------------------
+	 * | DMA enabled | X,high used |  unknown  |   known   |
+	 *  ---------------------------------------------------
+	 * |      N            N       |    low    |    NOP    |
+	 * |      Y            N       |    NOP    |    low    |
+	 * |      N            Y       |  high/low |    NOP    |
+	 * |      Y            Y       |    high   |    low    |
+	 *  ---------------------------------------------------
+	 *
+	 * But in this function, the crash high memory allocation of
+	 * crashkernel=Y,high and the crash low memory allocation of
+	 * crashkernel=X[@offset] for crashk_res are mixed at one place.
+	 * So the table above need to be adjusted as below:
+	 *  ---------------------------------------------------
+	 * | DMA enabled | X,high used |  unknown  |   known   |
+	 *  ---------------------------------------------------
+	 * |      N            N       |    res    |    NOP    |
+	 * |      Y            N       |    NOP    |    res    |
+	 * |      N            Y       |res/low_res|    NOP    |
+	 * |      Y            Y       |    res    |  low_res  |
+	 *  ---------------------------------------------------
+	 *
+	 */
 
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
@@ -169,10 +198,33 @@ static void __init reserve_crashkernel(int dma_state)
 		else if (ret)
 			return;
 
+		/* See the third row of the second table above, NOP */
+		if (!dma_enabled && (dma_state == DMA_PHYS_LIMIT_KNOWN))
+			return;
+
+		/* See the fourth row of the second table above */
+		if (dma_enabled) {
+			if (dma_state == DMA_PHYS_LIMIT_UNKNOWN)
+				skip_low_res = 1;
+			else
+				skip_res = 1;
+		}
+
 		crash_max = CRASH_ADDR_HIGH_MAX;
 	} else if (ret || !crash_size) {
 		/* The specified value is invalid */
 		return;
+	} else {
+		/* See the 1-2 rows of the second table above, NOP */
+		if ((!dma_enabled && (dma_state == DMA_PHYS_LIMIT_KNOWN)) ||
+		     (dma_enabled && (dma_state == DMA_PHYS_LIMIT_UNKNOWN)))
+			return;
+	}
+
+	if (skip_res) {
+		crash_base = crashk_res.start;
+		crash_size = crashk_res.end - crashk_res.start + 1;
+		goto check_low;
 	}
 
 	fixed_base = !!crash_base;
@@ -202,9 +254,18 @@ static void __init reserve_crashkernel(int dma_state)
 		return;
 	}
 
+	crashk_res.start = crash_base;
+	crashk_res.end = crash_base + crash_size - 1;
+
+check_low:
+	if (skip_low_res)
+		return;
+
 	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
 	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
 		memblock_phys_free(crash_base, crash_size);
+		crashk_res.start = 0;
+		crashk_res.end = 0;
 		return;
 	}
 
@@ -219,8 +280,6 @@ static void __init reserve_crashkernel(int dma_state)
 	if (crashk_low_res.end)
 		kmemleak_ignore_phys(crashk_low_res.start);
 
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
 }
 
-- 
2.25.1

