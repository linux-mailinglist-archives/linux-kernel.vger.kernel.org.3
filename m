Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3961146FAE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhLJHA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:00:29 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29168 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbhLJHAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:00:16 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J9M8S5Zz5z8wh6;
        Fri, 10 Dec 2021 14:54:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:56:40 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:56:39 +0800
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
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: [PATCH v17 09/10] of: fdt: Add memory for devices by DT property "linux,usable-memory-range"
Date:   Fri, 10 Dec 2021 14:55:32 +0800
Message-ID: <20211210065533.2023-10-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211210065533.2023-1-thunder.leizhen@huawei.com>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
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

From: Chen Zhou <chenzhou10@huawei.com>

When reserving crashkernel in high memory, some low memory is reserved
for crash dump kernel devices and never mapped by the first kernel.
This memory range is advertised to crash dump kernel via DT property
under /chosen,
        linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>

We reused the DT property linux,usable-memory-range and made the low
memory region as the second range "BASE2 SIZE2", which keeps compatibility
with existing user-space and older kdump kernels.

Crash dump kernel reads this property at boot time and call memblock_add()
to add the low memory region after memblock_cap_memory_range() has been
called.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 drivers/of/fdt.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 37b477a51175359..f7b72fa773250ad 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -967,6 +967,15 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 
 static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
+/*
+ * The main usage of linux,usable-memory-range is for crash dump kernel.
+ * Originally, the number of usable-memory regions is one. Now there may
+ * be two regions, low region and high region.
+ * To make compatibility with existing user-space and older kdump, the low
+ * region is always the last range of linux,usable-memory-range if exist.
+ */
+#define MAX_USABLE_RANGES		2
+
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
  * location from flat tree
@@ -974,10 +983,9 @@ static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
  */
 static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 {
-	const __be32 *prop;
-	int len;
-	phys_addr_t cap_mem_addr;
-	phys_addr_t cap_mem_size;
+	struct memblock_region rgn[MAX_USABLE_RANGES] = {0};
+	const __be32 *prop, *endp;
+	int len, i;
 
 	if ((long)node < 0)
 		return;
@@ -985,16 +993,21 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 	pr_debug("Looking for usable-memory-range property... ");
 
 	prop = of_get_flat_dt_prop(node, "linux,usable-memory-range", &len);
-	if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
+	if (!prop || (len % (dt_root_addr_cells + dt_root_size_cells)))
 		return;
 
-	cap_mem_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
-	cap_mem_size = dt_mem_next_cell(dt_root_size_cells, &prop);
+	endp = prop + (len / sizeof(__be32));
+	for (i = 0; i < MAX_USABLE_RANGES && prop < endp; i++) {
+		rgn[i].base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		rgn[i].size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
-		 &cap_mem_size);
+		pr_debug("cap_mem_regions[%d]: base=%pa, size=%pa\n",
+			 i, &rgn[i].base, &rgn[i].size);
+	}
 
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	memblock_cap_memory_range(rgn[0].base, rgn[0].size);
+	for (i = 1; i < MAX_USABLE_RANGES && rgn[i].size; i++)
+		memblock_add(rgn[i].base, rgn[i].size);
 }
 
 #ifdef CONFIG_SERIAL_EARLYCON
-- 
2.25.1

