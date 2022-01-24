Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE44497AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiAXItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:49:04 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17796 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbiAXItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:49:02 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jj3XF4WwPz9sM5;
        Mon, 24 Jan 2022 16:47:41 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:48:59 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 16:48:58 +0800
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
Subject: [PATCH v20 1/5] arm64: Use insert_resource() to simplify code
Date:   Mon, 24 Jan 2022 16:47:04 +0800
Message-ID: <20220124084708.683-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220124084708.683-1-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

insert_resource() traverses the subtree layer by layer from the root node
until a proper location is found. Compared with request_resource(), the
parent node does not need to be determined in advance.

In addition, move the insertion of node 'crashk_res' into function
reserve_crashkernel() to make the associated code close together.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/kernel/setup.c | 17 +++--------------
 arch/arm64/mm/init.c      |  1 +
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f70573928f1bff0..a81efcc359e4e78 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -225,6 +225,8 @@ static void __init request_standard_resources(void)
 	kernel_code.end     = __pa_symbol(__init_begin - 1);
 	kernel_data.start   = __pa_symbol(_sdata);
 	kernel_data.end     = __pa_symbol(_end - 1);
+	insert_resource(&iomem_resource, &kernel_code);
+	insert_resource(&iomem_resource, &kernel_data);
 
 	num_standard_resources = memblock.memory.cnt;
 	res_size = num_standard_resources * sizeof(*standard_resources);
@@ -246,20 +248,7 @@ static void __init request_standard_resources(void)
 			res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
 		}
 
-		request_resource(&iomem_resource, res);
-
-		if (kernel_code.start >= res->start &&
-		    kernel_code.end <= res->end)
-			request_resource(res, &kernel_code);
-		if (kernel_data.start >= res->start &&
-		    kernel_data.end <= res->end)
-			request_resource(res, &kernel_data);
-#ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
-		if (crashk_res.end && crashk_res.start >= res->start &&
-		    crashk_res.end <= res->end)
-			request_resource(res, &crashk_res);
-#endif
+		insert_resource(&iomem_resource, res);
 	}
 }
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index db63cc885771a52..90f276d46b93bc6 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -109,6 +109,7 @@ static void __init reserve_crashkernel(void)
 	kmemleak_ignore_phys(crash_base);
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
+	insert_resource(&iomem_resource, &crashk_res);
 }
 #else
 static void __init reserve_crashkernel(void)
-- 
2.25.1

