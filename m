Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FE46FAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhLJHAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:00:37 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16356 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbhLJHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:00:15 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J9MB72zBlz92jX;
        Fri, 10 Dec 2021 14:55:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:56:39 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 14:56:38 +0800
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
Subject: [PATCH v17 08/10] of: fdt: Aggregate the processing of "linux,usable-memory-range"
Date:   Fri, 10 Dec 2021 14:55:31 +0800
Message-ID: <20211210065533.2023-9-thunder.leizhen@huawei.com>
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

Currently, we parse the "linux,usable-memory-range" property in
early_init_dt_scan_chosen(), to obtain the specified memory range of the
crash kernel. We then reserve the required memory after
early_init_dt_scan_memory() has identified all available physical memory.
Because the two pieces of code are separated far, the readability and
maintainability are reduced. So bring them together.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 drivers/of/fdt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bdca35284cebd56..37b477a51175359 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -965,8 +965,7 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
 		 elfcorehdr_addr, elfcorehdr_size);
 }
 
-static phys_addr_t cap_mem_addr;
-static phys_addr_t cap_mem_size;
+static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
 
 /**
  * early_init_dt_check_for_usable_mem_range - Decode usable memory range
@@ -977,6 +976,11 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 {
 	const __be32 *prop;
 	int len;
+	phys_addr_t cap_mem_addr;
+	phys_addr_t cap_mem_size;
+
+	if ((long)node < 0)
+		return;
 
 	pr_debug("Looking for usable-memory-range property... ");
 
@@ -989,6 +993,8 @@ static void __init early_init_dt_check_for_usable_mem_range(unsigned long node)
 
 	pr_debug("cap_mem_start=%pa cap_mem_size=%pa\n", &cap_mem_addr,
 		 &cap_mem_size);
+
+	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
 }
 
 #ifdef CONFIG_SERIAL_EARLYCON
@@ -1137,9 +1143,10 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
 		return 0;
 
+	chosen_node_offset = node;
+
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
-	early_init_dt_check_for_usable_mem_range(node);
 
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
@@ -1275,7 +1282,7 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Handle linux,usable-memory-range property */
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	early_init_dt_check_for_usable_mem_range(chosen_node_offset);
 }
 
 bool __init early_init_dt_scan(void *params)
-- 
2.25.1

