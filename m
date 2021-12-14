Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9269A474C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhLNU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:26:58 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43887 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbhLNU0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:26:54 -0500
Received: by mail-oi1-f176.google.com with SMTP id o4so28767325oia.10;
        Tue, 14 Dec 2021 12:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zoA5Z8TrkhyO9VpXkw4vVgVTvX1m0JlpyPfyrdFngu4=;
        b=4Gx4rfyRACGcVR1kIPOOpsvFqM31uJxVfhgtC8dN61FudGPSfKnXrAkOHwq3G2q3bk
         wz8/6IX1hgzGpTXOdJSbJKmBBIr2cBVWPNxQNMtpxtpMP0gKkOAxW0Pi0cXGOoYkXMwI
         OWr8pYZTw5+r+MgCFMognHbNaxQTwPx1TIUKl/KKyoAl4E8wsMsIeECEWirehFMbs3Jv
         fPVrbwuqfYtUUSwMResTtc3gDyGkP7Pzfacp6xnXX9PfnuyCTl4MGCN4F2MwVCqqSRqm
         4vEU0+rtAfQLj17kTtYSOFQpsnBWuMml/O1eUPJXpaQ71qg2M4QlrQo9c+ZKk/Nc4DB5
         eA6Q==
X-Gm-Message-State: AOAM531uORS/TVmYXQGq6GtuCYzowluBoJ/dgvMNyfxeLB2cXBO6amQo
        It+mfjjR4NSdgbjjAv2s6g==
X-Google-Smtp-Source: ABdhPJw0zliiKLsHvNnJ7zXg7WFegzRRUZqy33/B0czNpd/RWUhOX058+lN4XGpG8555QCmRZ2KvoA==
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr6173359oiw.154.1639513613845;
        Tue, 14 Dec 2021 12:26:53 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id m12sm177454ots.59.2021.12.14.12.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:26:53 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Frank Rowand <frank.rowand@sony.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3] of/fdt: Rework early_init_dt_scan_memory() to call directly
Date:   Tue, 14 Dec 2021 14:26:51 -0600
Message-Id: <20211214202652.3894707-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of the of_scan_flat_dt() function predates libfdt and is discouraged
as libfdt provides a nicer set of APIs. Rework
early_init_dt_scan_memory() to be called directly and use libfdt.

Cc: John Crispin <john@phrozen.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Fix powerpc when /ibm,dynamic-reconfiguration-memory is present
v2:
 - ralink: Use 'if' instead of 'else if'
 - early_init_dt_scan_memory: continue instead of return on no reg
 - Fix indentation
---
 arch/mips/ralink/of.c      | 19 +++--------
 arch/powerpc/kernel/prom.c | 21 ++++++------
 drivers/of/fdt.c           | 67 +++++++++++++++++++-------------------
 include/linux/of_fdt.h     |  3 +-
 4 files changed, 49 insertions(+), 61 deletions(-)

diff --git a/arch/mips/ralink/of.c b/arch/mips/ralink/of.c
index 0135376c5de5..35a87a2da10b 100644
--- a/arch/mips/ralink/of.c
+++ b/arch/mips/ralink/of.c
@@ -53,17 +53,6 @@ void __init device_tree_init(void)
 	unflatten_and_copy_device_tree();
 }
 
-static int memory_dtb;
-
-static int __init early_init_dt_find_memory(unsigned long node,
-				const char *uname, int depth, void *data)
-{
-	if (depth == 1 && !strcmp(uname, "memory@0"))
-		memory_dtb = 1;
-
-	return 0;
-}
-
 void __init plat_mem_setup(void)
 {
 	void *dtb;
@@ -77,10 +66,10 @@ void __init plat_mem_setup(void)
 	dtb = get_fdt();
 	__dt_setup_arch(dtb);
 
-	of_scan_flat_dt(early_init_dt_find_memory, NULL);
-	if (memory_dtb)
-		of_scan_flat_dt(early_init_dt_scan_memory, NULL);
-	else if (soc_info.mem_detect)
+	if (!early_init_dt_scan_memory())
+		return;
+
+	if (soc_info.mem_detect)
 		soc_info.mem_detect();
 	else if (soc_info.mem_size)
 		memblock_add(soc_info.mem_base, soc_info.mem_size * SZ_1M);
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6e1a106f02eb..ad1230c4f3fe 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -532,19 +532,18 @@ static int  __init early_init_drmem_lmb(struct drmem_lmb *lmb,
 }
 #endif /* CONFIG_PPC_PSERIES */
 
-static int __init early_init_dt_scan_memory_ppc(unsigned long node,
-						const char *uname,
-						int depth, void *data)
+static int __init early_init_dt_scan_memory_ppc(void)
 {
 #ifdef CONFIG_PPC_PSERIES
-	if (depth == 1 &&
-	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
+	const void *fdt = initial_boot_params;
+	int node = fdt_path_offset(fdt, "/ibm,dynamic-reconfiguration-memory");
+
+	if (node > 0)
 		walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
-		return 0;
-	}
+
 #endif
-	
-	return early_init_dt_scan_memory(node, uname, depth, data);
+
+	return early_init_dt_scan_memory();
 }
 
 /*
@@ -749,7 +748,7 @@ void __init early_init_devtree(void *params)
 
 	/* Scan memory nodes and rebuild MEMBLOCKs */
 	early_init_dt_scan_root();
-	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
+	early_init_dt_scan_memory_ppc();
 
 	parse_early_param();
 
@@ -858,7 +857,7 @@ void __init early_get_first_memblock_info(void *params, phys_addr_t *size)
 	 */
 	add_mem_to_memblock = 0;
 	early_init_dt_scan_root();
-	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
+	early_init_dt_scan_memory_ppc();
 	add_mem_to_memblock = 1;
 
 	if (size)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 5e216555fe4f..97d7607625ec 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1078,49 +1078,50 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
 /*
  * early_init_dt_scan_memory - Look for and parse memory nodes
  */
-int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
-				     int depth, void *data)
+int __init early_init_dt_scan_memory(void)
 {
-	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	const __be32 *reg, *endp;
-	int l;
-	bool hotpluggable;
-
-	/* We are scanning "memory" nodes only */
-	if (type == NULL || strcmp(type, "memory") != 0)
-		return 0;
+	int node;
+	const void *fdt = initial_boot_params;
 
-	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-	if (reg == NULL)
-		reg = of_get_flat_dt_prop(node, "reg", &l);
-	if (reg == NULL)
-		return 0;
+	for (node = fdt_node_offset_by_prop_value(fdt, -1, "device_type", "memory", 6);
+	     node != -FDT_ERR_NOTFOUND;
+	     node = fdt_node_offset_by_prop_value(fdt, node, "device_type", "memory", 6)) {
+		const __be32 *reg, *endp;
+		int l;
+		bool hotpluggable;
+
+		reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+		if (reg == NULL)
+			reg = of_get_flat_dt_prop(node, "reg", &l);
+		if (reg == NULL)
+			continue;
 
-	endp = reg + (l / sizeof(__be32));
-	hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
+		endp = reg + (l / sizeof(__be32));
+		hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
 
-	pr_debug("memory scan node %s, reg size %d,\n", uname, l);
+		pr_debug("memory scan node %s, reg size %d,\n",
+			 fdt_get_name(fdt, node, NULL), l);
 
-	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
-		u64 base, size;
+		while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+			u64 base, size;
 
-		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+			base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+			size = dt_mem_next_cell(dt_root_size_cells, &reg);
 
-		if (size == 0)
-			continue;
-		pr_debug(" - %llx, %llx\n", base, size);
+			if (size == 0)
+				continue;
+			pr_debug(" - %llx, %llx\n", base, size);
 
-		early_init_dt_add_memory_arch(base, size);
+			early_init_dt_add_memory_arch(base, size);
 
-		if (!hotpluggable)
-			continue;
+			if (!hotpluggable)
+				continue;
 
-		if (memblock_mark_hotplug(base, size))
-			pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
-				base, base + size);
+			if (memblock_mark_hotplug(base, size))
+				pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
+					base, base + size);
+		}
 	}
-
 	return 0;
 }
 
@@ -1271,7 +1272,7 @@ void __init early_init_dt_scan_nodes(void)
 		pr_warn("No chosen node found, continuing without\n");
 
 	/* Setup memory, calling early_init_dt_add_memory_arch */
-	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
+	early_init_dt_scan_memory();
 
 	/* Handle linux,usable-memory-range property */
 	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index df3d31926c3c..914739f3c192 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -59,8 +59,7 @@ extern unsigned long of_get_flat_dt_root(void);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
 extern int early_init_dt_scan_chosen(char *cmdline);
-extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
-				     int depth, void *data);
+extern int early_init_dt_scan_memory(void);
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
-- 
2.32.0

