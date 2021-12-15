Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C9475B49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbhLOPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:01:09 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46845 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:01:06 -0500
Received: by mail-ot1-f46.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so25144727oto.13;
        Wed, 15 Dec 2021 07:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jq0x8iVALaGMJU7xAVYGCo3xMt/B1pDw6eEI2Wc91JY=;
        b=jUmpvdTkFpdp3iHTVgIXDwfvwb4W8pdNu7Mdces0shez+0MncmrY16u2DESQaXi8yA
         eHsbMCZ98nULBXxV1ieRe7KH27AB9VnSE9lhDzMwlTtpVp8Ptm8U8B3QcPRVqhhopdPl
         zgsbWuzBMYmzvykLTeRQrnJYaMzQeHoHStWK9oKFsxYI9GM2mF8HB9zqvMVIX79dk3oL
         s5VNZwlNhWNPNTp+Pihh6/w58PtaDBoyA7pYkxPnrGMkGdqNrjQDBldSgGGr7ZI0Gn6G
         DEBEvRgN20rInTIjRKoAdeYw3mozbwBYUDw1ZS8FIZvJFJS0+k7EWrSLXxyMrTSerhaM
         xjQw==
X-Gm-Message-State: AOAM531uHqL3FURdWDgGkZDLUzOw1YHx/xweonPZ1jbgABjFDl20iIjy
        2eT8XQt2uX5daghAiN5DNg==
X-Google-Smtp-Source: ABdhPJy9pSAKcn/6iGV5Hbw1t6r2jfryKDONyLlWKGyr+6nX1um5VXoLr8WiphSTjUPLS5R9dSYbpw==
X-Received: by 2002:a9d:70ce:: with SMTP id w14mr8776986otj.77.1639580464571;
        Wed, 15 Dec 2021 07:01:04 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r22sm387007oij.36.2021.12.15.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:01:03 -0800 (PST)
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
Subject: [PATCH v4] of/fdt: Rework early_init_dt_scan_memory() to call directly
Date:   Wed, 15 Dec 2021 09:01:02 -0600
Message-Id: <20211215150102.1303588-1-robh@kernel.org>
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
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Link: https://lore.kernel.org/r/20211208155839.4084795-1-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Revert the changes to search for memory nodes at any level which were
   accidentally committed.
v3:
 - Fix powerpc when /ibm,dynamic-reconfiguration-memory is present
v2:
 - ralink: Use 'if' instead of 'else if'
 - early_init_dt_scan_memory: continue instead of return on no reg
 - Fix indentation
---
 arch/mips/ralink/of.c      | 19 +++--------
 arch/powerpc/kernel/prom.c | 21 ++++++------
 drivers/of/fdt.c           | 68 ++++++++++++++++++++------------------
 include/linux/of_fdt.h     |  3 +-
 4 files changed, 51 insertions(+), 60 deletions(-)

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
index 5e216555fe4f..a835c458f50a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1078,49 +1078,53 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
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
+	int node;
+	const void *fdt = initial_boot_params;
 
-	/* We are scanning "memory" nodes only */
-	if (type == NULL || strcmp(type, "memory") != 0)
-		return 0;
+	fdt_for_each_subnode(node, fdt, 0) {
+		const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+		const __be32 *reg, *endp;
+		int l;
+		bool hotpluggable;
 
-	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-	if (reg == NULL)
-		reg = of_get_flat_dt_prop(node, "reg", &l);
-	if (reg == NULL)
-		return 0;
+		/* We are scanning "memory" nodes only */
+		if (type == NULL || strcmp(type, "memory") != 0)
+			continue;
 
-	endp = reg + (l / sizeof(__be32));
-	hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
+		reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
+		if (reg == NULL)
+			reg = of_get_flat_dt_prop(node, "reg", &l);
+		if (reg == NULL)
+			continue;
 
-	pr_debug("memory scan node %s, reg size %d,\n", uname, l);
+		endp = reg + (l / sizeof(__be32));
+		hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
 
-	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
-		u64 base, size;
+		pr_debug("memory scan node %s, reg size %d,\n",
+			 fdt_get_name(fdt, node, NULL), l);
 
-		base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-		size = dt_mem_next_cell(dt_root_size_cells, &reg);
+		while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+			u64 base, size;
 
-		if (size == 0)
-			continue;
-		pr_debug(" - %llx, %llx\n", base, size);
+			base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+			size = dt_mem_next_cell(dt_root_size_cells, &reg);
 
-		early_init_dt_add_memory_arch(base, size);
+			if (size == 0)
+				continue;
+			pr_debug(" - %llx, %llx\n", base, size);
 
-		if (!hotpluggable)
-			continue;
+			early_init_dt_add_memory_arch(base, size);
 
-		if (memblock_mark_hotplug(base, size))
-			pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
-				base, base + size);
-	}
+			if (!hotpluggable)
+				continue;
 
+			if (memblock_mark_hotplug(base, size))
+				pr_warn("failed to mark hotplug range 0x%llx - 0x%llx\n",
+					base, base + size);
+		}
+	}
 	return 0;
 }
 
@@ -1271,7 +1275,7 @@ void __init early_init_dt_scan_nodes(void)
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

