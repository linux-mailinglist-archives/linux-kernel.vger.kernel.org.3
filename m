Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61ED5481E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiFMILf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbiFMILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:11:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3C21E3FA;
        Mon, 13 Jun 2022 01:11:06 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LM44w0PKbzDqqK;
        Mon, 13 Jun 2022 16:10:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:03 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:02 +0800
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
Subject: [PATCH 2/5] arm64: kdump: Support crashkernel=X fall back to reserve region above DMA zones
Date:   Mon, 13 Jun 2022 16:09:29 +0800
Message-ID: <20220613080932.663-3-thunder.leizhen@huawei.com>
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

For crashkernel=X without '@offset', select a region within DMA zones
first, and fall back to reserve region above DMA zones. This allows
users to use the same configuration on multiple platforms.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/arm64/mm/init.c                            | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 61b179232b68001..fdac18beba5624e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -823,7 +823,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64] Select a region under 4G first, and
+			[KNL, X86-64, ARM64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5390f361208ccf7..8539598f9e58b4d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -138,6 +138,7 @@ static void __init reserve_crashkernel(void)
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
 	int ret;
+	bool fixed_base;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
@@ -166,15 +167,28 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
+	fixed_base = !!crash_base;
 	crash_size = PAGE_ALIGN(crash_size);
 
 	/* User specifies base address explicitly. */
-	if (crash_base)
+	if (fixed_base)
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
+			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
+			goto retry;
+		}
+
 		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 			crash_size);
 		return;
-- 
2.25.1

