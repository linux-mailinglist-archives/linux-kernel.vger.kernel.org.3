Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C8476FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhLPLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:14:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15746 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbhLPLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:14:02 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JF8YY3DLSzZdcZ;
        Thu, 16 Dec 2021 19:10:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 19:13:58 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 19:13:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <dennis@kernel.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <tj@kernel.org>, <gregkh@linuxfoundation.org>, <cl@linux.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <tsbogend@alpha.franken.de>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <sparclinux@vger.kernel.org>, <x86@kernel.org>,
        <wangkefeng.wang@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/4] mm: percpu: Add pcpu_fc_cpu_to_node_fn_t typedef
Date:   Thu, 16 Dec 2021 19:23:57 +0800
Message-ID: <20211216112359.103822-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211216112359.103822-1-wangkefeng.wang@huawei.com>
References: <20211216112359.103822-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcpu_fc_cpu_to_node_fn_t and pass it into pcpu_fc_alloc_fn_t,
pcpu first chunk allocation will call it to alloc memblock on the
corresponding node by it, this is prepare for the next patch.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/mips/mm/init.c            | 12 +++++++++---
 arch/powerpc/kernel/setup_64.c | 15 +++++++++++----
 arch/sparc/kernel/smp_64.c     | 13 ++++++++++---
 arch/x86/kernel/setup_percpu.c | 18 +++++++++++++-----
 drivers/base/arch_numa.c       |  8 +++++---
 include/linux/percpu.h         |  7 +++++--
 mm/percpu.c                    | 14 +++++++++-----
 7 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 325e1552cbea..1d8f2844704c 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -519,12 +519,17 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 	return node_distance(cpu_to_node(from), cpu_to_node(to));
 }
 
-static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
-				       size_t align)
+static int __init pcpu_cpu_to_node(int cpu)
+{
+	return cpu_to_node(cpu);
+}
+
+static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align,
+				   pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
 	return memblock_alloc_try_nid(size, align, __pa(MAX_DMA_ADDRESS),
 				      MEMBLOCK_ALLOC_ACCESSIBLE,
-				      cpu_to_node(cpu));
+				      cpu_to_nd_fn(cpu));
 }
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
@@ -545,6 +550,7 @@ void __init setup_per_cpu_areas(void)
 	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
 				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
 				    pcpu_cpu_distance,
+				    pcpu_cpu_to_node,
 				    pcpu_fc_alloc, pcpu_fc_free);
 	if (rc < 0)
 		panic("Failed to initialize percpu areas.");
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6052f5d5ded3..b79b10ae466f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -784,12 +784,12 @@ void __init emergency_stack_init(void)
  * RETURNS:
  * Pointer to the allocated area on success, NULL on failure.
  */
-static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
-					size_t align)
+static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size, size_t align,
+					pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
 	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
 #ifdef CONFIG_NUMA
-	int node = early_cpu_to_node(cpu);
+	int node = cpu_to_nd_fun(cpu);
 	void *ptr;
 
 	if (!node_online(node) || !NODE_DATA(node)) {
@@ -823,6 +823,11 @@ static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 		return REMOTE_DISTANCE;
 }
 
+static __init int pcpu_cpu_to_node(int cpu)
+{
+	return early_cpu_to_node(cpu);
+}
+
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
@@ -891,6 +896,7 @@ void __init setup_per_cpu_areas(void)
 
 	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
 		rc = pcpu_embed_first_chunk(0, dyn_size, atom_size, pcpu_cpu_distance,
+					    pcpu_cpu_to_node,
 					    pcpu_alloc_bootmem, pcpu_free_bootmem);
 		if (rc)
 			pr_warn("PERCPU: %s allocator failed (%d), "
@@ -899,7 +905,8 @@ void __init setup_per_cpu_areas(void)
 	}
 
 	if (rc < 0)
-		rc = pcpu_page_first_chunk(0, pcpu_alloc_bootmem, pcpu_free_bootmem,
+		rc = pcpu_page_first_chunk(0, pcpu_cpu_to_node,
+					   pcpu_alloc_bootmem, pcpu_free_bootmem,
 					   pcpu_populate_pte);
 	if (rc < 0)
 		panic("cannot initialize percpu area (err=%d)", rc);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b98a7bbe6728..14d719aa318d 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1539,12 +1539,12 @@ void smp_send_stop(void)
  * RETURNS:
  * Pointer to the allocated area on success, NULL on failure.
  */
-static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
-					size_t align)
+static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size, size_t align,
+					pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
 	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
 #ifdef CONFIG_NUMA
-	int node = cpu_to_node(cpu);
+	int node = cpu_to_nd_fn(cpu);
 	void *ptr;
 
 	if (!node_online(node) || !NODE_DATA(node)) {
@@ -1578,6 +1578,11 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 		return REMOTE_DISTANCE;
 }
 
+static int __init pcpu_cpu_to_node(int cpu)
+{
+	return cpu_to_node(cpu);
+}
+
 static void __init pcpu_populate_pte(unsigned long addr)
 {
 	pgd_t *pgd = pgd_offset_k(addr);
@@ -1641,6 +1646,7 @@ void __init setup_per_cpu_areas(void)
 		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
 					    PERCPU_DYNAMIC_RESERVE, 4 << 20,
 					    pcpu_cpu_distance,
+					    pcpu_cpu_to_node,
 					    pcpu_alloc_bootmem,
 					    pcpu_free_bootmem);
 		if (rc)
@@ -1650,6 +1656,7 @@ void __init setup_per_cpu_areas(void)
 	}
 	if (rc < 0)
 		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
+					   pcpu_cpu_to_node,
 					   pcpu_alloc_bootmem,
 					   pcpu_free_bootmem,
 					   pcpu_populate_pte);
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 7b65275544b2..1d41f4844149 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -97,12 +97,12 @@ static bool __init pcpu_need_numa(void)
  * RETURNS:
  * Pointer to the allocated area on success, NULL on failure.
  */
-static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
-					unsigned long align)
+static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size, unsigned long align,
+					pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
 	const unsigned long goal = __pa(MAX_DMA_ADDRESS);
 #ifdef CONFIG_NUMA
-	int node = early_cpu_to_node(cpu);
+	int node = cpu_to_nd_fn(cpu);
 	void *ptr;
 
 	if (!node_online(node) || !NODE_DATA(node)) {
@@ -128,9 +128,10 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 /*
  * Helpers for first chunk memory allocation
  */
-static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
+static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align,
+				   pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
-	return pcpu_alloc_bootmem(cpu, size, align);
+	return pcpu_alloc_bootmem(cpu, size, align, cpu_to_nd_fn);
 }
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
@@ -150,6 +151,11 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 #endif
 }
 
+static int __init pcpu_cpu_to_node(int cpu)
+{
+	return early_cpu_to_node(cpu);
+}
+
 static void __init pcpup_populate_pte(unsigned long addr)
 {
 	populate_extra_pte(addr);
@@ -205,6 +211,7 @@ void __init setup_per_cpu_areas(void)
 		rc = pcpu_embed_first_chunk(PERCPU_FIRST_CHUNK_RESERVE,
 					    dyn_size, atom_size,
 					    pcpu_cpu_distance,
+					    pcpu_cpu_to_node,
 					    pcpu_fc_alloc, pcpu_fc_free);
 		if (rc < 0)
 			pr_warn("%s allocator failed (%d), falling back to page size\n",
@@ -212,6 +219,7 @@ void __init setup_per_cpu_areas(void)
 	}
 	if (rc < 0)
 		rc = pcpu_page_first_chunk(PERCPU_FIRST_CHUNK_RESERVE,
+					   pcpu_cpu_to_node,
 					   pcpu_fc_alloc, pcpu_fc_free,
 					   pcpup_populate_pte);
 	if (rc < 0)
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index bc1876915457..dae861838535 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -155,10 +155,10 @@ static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
 	return node_distance(early_cpu_to_node(from), early_cpu_to_node(to));
 }
 
-static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
-				       size_t align)
+static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align,
+				   pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
-	int nid = early_cpu_to_node(cpu);
+	int nid = cpu_to_nd_fn(cpu);
 
 	return  memblock_alloc_try_nid(size, align,
 			__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, nid);
@@ -229,6 +229,7 @@ void __init setup_per_cpu_areas(void)
 		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
 					    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
 					    pcpu_cpu_distance,
+					    early_cpu_to_node,
 					    pcpu_fc_alloc, pcpu_fc_free);
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
 		if (rc < 0)
@@ -240,6 +241,7 @@ void __init setup_per_cpu_areas(void)
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
 	if (rc < 0)
 		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
+					   early_cpu_to_node,
 					   pcpu_fc_alloc,
 					   pcpu_fc_free,
 					   pcpu_populate_pte);
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index ae4004e7957e..e4078bf45fd5 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -94,8 +94,9 @@ extern const char * const pcpu_fc_names[PCPU_FC_NR];
 
 extern enum pcpu_fc pcpu_chosen_fc;
 
-typedef void * (*pcpu_fc_alloc_fn_t)(unsigned int cpu, size_t size,
-				     size_t align);
+typedef int (pcpu_fc_cpu_to_node_fn_t)(int cpu);
+typedef void * (*pcpu_fc_alloc_fn_t)(unsigned int cpu, size_t size, size_t align,
+				     pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn);
 typedef void (*pcpu_fc_free_fn_t)(void *ptr, size_t size);
 typedef void (*pcpu_fc_populate_pte_fn_t)(unsigned long addr);
 typedef int (pcpu_fc_cpu_distance_fn_t)(unsigned int from, unsigned int to);
@@ -111,12 +112,14 @@ extern void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 extern int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 				size_t atom_size,
 				pcpu_fc_cpu_distance_fn_t cpu_distance_fn,
+				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
 				pcpu_fc_alloc_fn_t alloc_fn,
 				pcpu_fc_free_fn_t free_fn);
 #endif
 
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
 extern int __init pcpu_page_first_chunk(size_t reserved_size,
+				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
 				pcpu_fc_alloc_fn_t alloc_fn,
 				pcpu_fc_free_fn_t free_fn,
 				pcpu_fc_populate_pte_fn_t populate_pte_fn);
diff --git a/mm/percpu.c b/mm/percpu.c
index f5b2c2ea5a54..267a4d295fcf 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3001,6 +3001,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
  * @dyn_size: minimum free size for dynamic allocation in bytes
  * @atom_size: allocation atom size
  * @cpu_distance_fn: callback to determine distance between cpus, optional
+ * @cpu_to_nd_fn: callback to convert cpu to it's node, optional
  * @alloc_fn: function to allocate percpu page
  * @free_fn: function to free percpu page
  *
@@ -3030,6 +3031,7 @@ static struct pcpu_alloc_info * __init __flatten pcpu_build_alloc_info(
 int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 				  size_t atom_size,
 				  pcpu_fc_cpu_distance_fn_t cpu_distance_fn,
+				  pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
 				  pcpu_fc_alloc_fn_t alloc_fn,
 				  pcpu_fc_free_fn_t free_fn)
 {
@@ -3066,7 +3068,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 		BUG_ON(cpu == NR_CPUS);
 
 		/* allocate space for the whole group */
-		ptr = alloc_fn(cpu, gi->nr_units * ai->unit_size, atom_size);
+		ptr = alloc_fn(cpu, gi->nr_units * ai->unit_size, atom_size, cpu_to_nd_fn);
 		if (!ptr) {
 			rc = -ENOMEM;
 			goto out_free_areas;
@@ -3143,6 +3145,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 /**
  * pcpu_page_first_chunk - map the first chunk using PAGE_SIZE pages
  * @reserved_size: the size of reserved percpu area in bytes
+ * @cpu_to_nd_fn: callback to convert cpu to it's node, optional
  * @alloc_fn: function to allocate percpu page, always called with PAGE_SIZE
  * @free_fn: function to free percpu page, always called with PAGE_SIZE
  * @populate_pte_fn: function to populate pte
@@ -3157,6 +3160,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
  * 0 on success, -errno on failure.
  */
 int __init pcpu_page_first_chunk(size_t reserved_size,
+				 pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn,
 				 pcpu_fc_alloc_fn_t alloc_fn,
 				 pcpu_fc_free_fn_t free_fn,
 				 pcpu_fc_populate_pte_fn_t populate_pte_fn)
@@ -3201,7 +3205,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		for (i = 0; i < unit_pages; i++) {
 			void *ptr;
 
-			ptr = alloc_fn(cpu, PAGE_SIZE, PAGE_SIZE);
+			ptr = alloc_fn(cpu, PAGE_SIZE, PAGE_SIZE, cpu_to_nd_fn);
 			if (!ptr) {
 				pr_warn("failed to allocate %s page for cpu%u\n",
 						psize_str, cpu);
@@ -3278,8 +3282,8 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-static void * __init pcpu_dfl_fc_alloc(unsigned int cpu, size_t size,
-				       size_t align)
+static void * __init pcpu_dfl_fc_alloc(unsigned int cpu, size_t size, size_t align,
+				       pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
 {
 	return  memblock_alloc_from(size, align, __pa(MAX_DMA_ADDRESS));
 }
@@ -3300,7 +3304,7 @@ void __init setup_per_cpu_areas(void)
 	 * what the legacy allocator did.
 	 */
 	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE, NULL,
+				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE, NULL, NULL,
 				    pcpu_dfl_fc_alloc, pcpu_dfl_fc_free);
 	if (rc < 0)
 		panic("Failed to initialize percpu areas.");
-- 
2.18.0.huawei.25

