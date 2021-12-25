Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F847F28A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 08:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhLYH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 02:26:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16860 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhLYH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 02:26:37 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JLb7V2Ctvz91rc;
        Sat, 25 Dec 2021 15:25:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:35 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 15:26:33 +0800
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
Subject: [PATCH 2/4] x86/setup: Use parse_crashkernel_high_low() to simplify code
Date:   Sat, 25 Dec 2021 15:23:25 +0800
Message-ID: <20211225072327.1807-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211225072327.1807-1-thunder.leizhen@huawei.com>
References: <20211225072327.1807-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use parse_crashkernel_high_low() to bring the parsing of
"crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
are strongly dependent, make code logic clear and more readable.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/x86/kernel/setup.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6a190c7f4d71b05..93d78aae1937db3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -416,18 +416,16 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_HIGH_MAX	SZ_64T
 #endif
 
-static int __init reserve_crashkernel_low(void)
+static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 #ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long long low_base = 0;
 	unsigned long low_mem_limit;
-	int ret;
 
 	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
 
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
-	if (ret) {
+	/* crashkernel=Y,low is not specified */
+	if ((long)low_size < 0) {
 		/*
 		 * two parts from kernel/dma/swiotlb.c:
 		 * -swiotlb size: user-specified with swiotlb= or default.
@@ -465,7 +463,7 @@ static int __init reserve_crashkernel_low(void)
 
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
+	unsigned long long crash_size, crash_base, total_mem, low_size;
 	bool high = false;
 	int ret;
 
@@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
 	/* crashkernel=XM */
 	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
 	if (ret != 0 || crash_size <= 0) {
-		/* crashkernel=X,high */
-		ret = parse_crashkernel_high(boot_command_line, total_mem,
-					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
+		/* crashkernel=X,high and possible crashkernel=Y,low */
+		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
+		if (ret)
 			return;
 		high = true;
 	}
@@ -520,7 +517,7 @@ static void __init reserve_crashkernel(void)
 		}
 	}
 
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
+	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low(low_size)) {
 		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
-- 
2.25.1

