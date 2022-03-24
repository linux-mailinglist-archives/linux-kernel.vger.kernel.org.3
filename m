Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7864E5F02
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348312AbiCXHBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCXHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:00:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5053A42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220324065921epoutp01a0e2871ed7455cdd7b4a7c70d182dbf9~fPumkQRFl3018930189epoutp01V
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220324065921epoutp01a0e2871ed7455cdd7b4a7c70d182dbf9~fPumkQRFl3018930189epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105161;
        bh=i1obRaKln+JV61/ToEUs1DW8bLXWehO+ng6Tc5bG6zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzdlgRHlaOzAYWMzIJb3U7mRDZz934P/diMTh0e+zsTieV1w7RkuzAvIrJBtCXd8K
         ioTA09KlrJFwPl/OxfokJ2PSnLj3HNppu9UA+yotTiRAfKq9aT4mLuqeL8RTPpEEqa
         lSk+kZQfdAH/0K0XhydL7z4B+yIkJG27xduPyEas=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220324065921epcas1p120c094af8495d5028a21a4ffe0b787ba~fPumClA0W2490124901epcas1p1G;
        Thu, 24 Mar 2022 06:59:21 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KPGKz6Z2bz4x9Qd; Thu, 24 Mar
        2022 06:59:19 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.5E.21932.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p35bafcd9151cf0469e4e933250c491a88~fPukU-vay0539605396epcas1p3f;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp251e68bae4cabf8123ba8522925b42157~fPukUQ-yk2562225622epsmtrp2a;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-07-623c16c7f41b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.E5.29871.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip26222ae87a5e323ea9be0c16449612469~fPukGV93K3063230632epsmtip28;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 1/8] memblock: introduce memsize showing reserved memory
Date:   Thu, 24 Mar 2022 16:01:51 +0900
Message-Id: <20220324070158.22969-2-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmru5xMZskg7eLdCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMm2tvMBXccqxomb+FtYHxkUkXIyeHhICJxJWlU5m7GLk4hAR2
        MEr0LPrFBuF8YpSYtfgbVOYbo8S1V2dYYVqWzLzHApHYyyixd/lWVgjnB6PEizdfmUGq2AS0
        Jd4vmATWISJgJ/Ft9gGwImaBLkaJBx8OsoAkhAU8JDYtm8YIYrMIqErMbZnJBGLzCthKTPt/
        lQ1inbzE6g0HwIZyAg1aueQAI0T8EbvEkSZHCNtF4ui8Fqi4sMSr41vYIWwpic/v9kLNyZZ4
        evII0BwOIDtHomGDLIRpL/H+kgWIySygKbF+lz5EsaLEzt9zwQYyC/BJvPvawwpRzSvR0SYE
        UaIm0fLsKzRIZCT+/nsGZXtInJrxGRqIExklbjYcZp/AKDcLYcMCRsZVjGKpBcW56anFhgUm
        8AhLzs/dxAhOc1oWOxjnvv2gd4iRiYPxEKMEB7OSCO/9y9ZJQrwpiZVVqUX58UWlOanFhxhN
        gSE3kVlKNDkfmGjzSuINTSwNTMyMTCyMLY3NlMR5e6eeThQSSE8sSc1OTS1ILYLpY+LglGpg
        ml3FueiUsU/Au812QYw/Ohu2+Vm8M/rZ9E39zJlPdoorDH5/Kjt7XeO1+B+hd4aORWv5T118
        G+n9qf9C1q2NmUztVstbVacu9X/Oz+G/eIVc0y2e1fYl8cLJJXs2PrlowS6Vnukk8OinqPUS
        w4Mm0U1mz6b5edSLtJt3zpmffdZmxfHDuflfOW/ejXZhrE79UcXorCy+/VXJleVVbscm+XYd
        WZnbwnxvv9nLntNZOz9zLhK04zt444/51lOH1N4X3broLGMkYvI0YIHWrNwieVZ5YceTv1dP
        uONZ5rJ2ddDmylkPixgZut/cmSxo+q5qXtGXZP9lyv71Vziq419ZNkwQ3XOzUnpX+Vyty4qe
        SizFGYmGWsxFxYkAPm+ZhPwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskg8lLhSzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV8bNtTeYCm45VrTM38LawPjIpIuRk0NC
        wERiycx7LF2MXBxCArsZJd7dX8IOkZCReHP+KVCCA8gWljh8uBgkLCTwjVFi/zJZEJtNQFvi
        /YJJrCC2iICTxIYrq8HmMAtMYJRYuewTC0hCWMBDYtOyaYwgNouAqsTclplMIDavgK3EtP9X
        2SB2yUus3nCAGcTmFLCTWLnkACPEMluJsycPsE1g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgx
        t7g0L10vOT93EyM4ILU0dzBuX/VB7xAjEwfjIUYJDmYlEd77l62ThHhTEiurUovy44tKc1KL
        DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBqF9fzr/RwjpXxjGixfxYh/NFW2O+j
        +JdtDj3Bi20E77xTUVfenrRkyWHX07MZZzH+Dz7mJfnE/tzhBUeCSlm2lu6u2nzvUt+CyLKb
        J8Kj619HfzwY3v1Bo5tjmqyR+1d25k2LCo7/+hI0+W+G8L8tIv8TvhvMZTjEkT3JsMxz5o+v
        NtvbmB36lby2MxxxYXyT0Rm5+/d7zYPB/+drX2SZUdt3KDdkmzib/Vp7v7fnPvc9dKpRkfqw
        MXN1jfAO/pTwwGv2bAvjdVd3LHfmXsy7KC7bvtxB79+xGTz/Kzmf1Hz8Jldvv26i95bEqzyB
        q8I4w57tr5l6ubTIp+V0l13wlbsfBVgYb5peEbW41K7EUpyRaKjFXFScCACmpwo/twIAAA==
X-CMS-MailID: 20220324065919epcas1p35bafcd9151cf0469e4e933250c491a88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p35bafcd9151cf0469e4e933250c491a88
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p35bafcd9151cf0469e4e933250c491a88@epcas1p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of memory regions can be reserved for a specific purpose. They are
usually defined through reserved-memory in device tree. If only size
without address is specified in device tree, the address of the region
will be determined at boot time.

We may find the address of the memory regions through booting log, but
it does not show all. And it could be hard to catch the very beginning
log. The memblock_dump_all shows all memblock status but it does not
show region name and its information is difficult to summarize.

This patch introduce a debugfs node, memblock/memsize, to see reserved
memory easily.

The first patch here will show the only reserved-memory in device tree
like following example. The next patches will show more information.

$ cat debugfs/memblock/memsize
0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2

.unusable  :   4096 KB
.reusable  :  32768 KB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/fdt.c             |   2 +
 drivers/of/of_reserved_mem.c |   7 ++-
 include/linux/memblock.h     |   9 +++
 kernel/dma/contiguous.c      |   2 +
 mm/Kconfig                   |   7 +++
 mm/memblock.c                | 103 +++++++++++++++++++++++++++++++++++
 6 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ec315b060cd5..ec2f60a78f8f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -619,6 +619,7 @@ static void __init fdt_reserve_elfcorehdr(void)
 	}
 
 	memblock_reserve(elfcorehdr_addr, elfcorehdr_size);
+	memblock_memsize_record("elfcorehdr", elfcorehdr_addr, size, false, false);
 
 	pr_info("Reserving %llu KiB of memory at 0x%llx for elfcorehdr\n",
 		elfcorehdr_size >> 10, elfcorehdr_addr);
@@ -645,6 +646,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		if (!size)
 			break;
 		early_init_dt_reserve_memory_arch(base, size, false);
+		memblock_memsize_record("memreserve", base, size, false, false);
 	}
 
 	fdt_scan_reserved_mem();
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 75caa6f5d36f..40323751efb2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -261,9 +261,10 @@ void __init fdt_init_reserved_mem(void)
 		int len;
 		const __be32 *prop;
 		int err = 0;
-		bool nomap;
+		bool nomap, reusable;
 
 		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+		reusable = of_get_flat_dt_prop(node, "reusable", NULL) != NULL;
 		prop = of_get_flat_dt_prop(node, "phandle", &len);
 		if (!prop)
 			prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
@@ -283,6 +284,10 @@ void __init fdt_init_reserved_mem(void)
 				else
 					memblock_phys_free(rmem->base,
 							   rmem->size);
+			} else {
+				memblock_memsize_record(rmem->name, rmem->base,
+							rmem->size, nomap,
+							reusable);
 			}
 		}
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..468b016e179b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -604,5 +604,14 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end)
 }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+extern void memblock_memsize_record(const char *name, phys_addr_t base,
+				    phys_addr_t size, bool nomap,
+				    bool reusable);
+#else
+static inline void memblock_memsize_record(const char *name, phys_addr_t base,
+				    phys_addr_t size, bool nomap,
+				    bool reusable) { }
+#endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42622..7415c1135afa 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -239,6 +239,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 	dma_contiguous_early_fixup(cma_get_base(*res_cma),
 				cma_get_size(*res_cma));
 
+	memblock_memsize_record("dma_cma", cma_get_base(*res_cma),
+				cma_get_size(*res_cma), false, true);
 	return 0;
 }
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 761f5021ba51..e29f6cd8394e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -96,6 +96,13 @@ config HAVE_FAST_GUP
 	depends on MMU
 	bool
 
+config MEMBLOCK_MEMSIZE
+	bool "memblock based reserved memory profiling"
+	default n
+	help
+	  This patch introduce a debugfs node, memblock/memsize, to see reserved
+	  memory easily.
+
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
diff --git a/mm/memblock.c b/mm/memblock.c
index b12a364f2766..8492757f7192 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -19,6 +19,7 @@
 
 #include <asm/sections.h>
 #include <linux/io.h>
+#include <linux/sort.h>
 
 #include "internal.h"
 
@@ -1928,6 +1929,49 @@ static int __init early_memblock(char *p)
 }
 early_param("memblock", early_memblock);
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+
+#define NAME_SIZE	30
+struct memsize_rgn_struct {
+	phys_addr_t	base;
+	long		size;
+	bool		nomap;			/*  1/32 byte */
+	bool		reusable;		/*  1/32 byte */
+	char		name[NAME_SIZE];	/* 30/32 byte */
+};
+
+#define MAX_MEMSIZE_RGN	64
+static struct memsize_rgn_struct memsize_rgn[MAX_MEMSIZE_RGN] __initdata_memblock;
+static int memsize_rgn_count __initdata_memblock;
+
+void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
+			     phys_addr_t size, bool nomap, bool reusable)
+{
+	struct memsize_rgn_struct *rgn;
+	phys_addr_t end;
+
+	if (memsize_rgn_count == MAX_MEMSIZE_RGN) {
+		pr_err("not enough space on memsize_rgn\n");
+		return;
+	}
+	rgn = &memsize_rgn[memsize_rgn_count++];
+	rgn->base = base;
+	rgn->size = size;
+	rgn->nomap = nomap;
+	rgn->reusable = reusable;
+
+	if (!name) {
+		strcpy(rgn->name, "unknown");
+	} else {
+		strncpy(rgn->name, name, NAME_SIZE - 1);
+		rgn->name[NAME_SIZE - 1] = '\0';
+	}
+	end = base + size - 1;
+	memblock_dbg("%s %pa..%pa nomap:%d reusable:%d\n",
+		     __func__, &base, &end, nomap, reusable);
+}
+#endif /* MEMBLOCK_MEMSIZE */
+
 static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;
@@ -2138,6 +2182,61 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 }
 DEFINE_SHOW_ATTRIBUTE(memblock_debug);
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+
+static int memsize_rgn_cmp(const void *a, const void *b)
+{
+	const struct memsize_rgn_struct *ra = a, *rb = b;
+
+	if (ra->base > rb->base)
+		return -1;
+
+	if (ra->base < rb->base)
+		return 1;
+
+	return 0;
+}
+
+static int memblock_memsize_show(struct seq_file *m, void *private)
+{
+	int i;
+	struct memsize_rgn_struct *rgn;
+	unsigned long reserved = 0, reusable = 0;
+
+	sort(memsize_rgn, memsize_rgn_count,
+	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
+	for (i = 0; i < memsize_rgn_count; i++) {
+		phys_addr_t base, end;
+		long size;
+
+		rgn = &memsize_rgn[i];
+		base = rgn->base;
+		size = rgn->size;
+		end = base + size;
+
+		seq_printf(m, "0x%09lx-0x%09lx 0x%08lx ( %7lu KB ) %s %s %s\n",
+			   &base, &end,
+			   size, DIV_ROUND_UP(size, SZ_1K),
+			   rgn->nomap ? "nomap" : "  map",
+			   rgn->reusable ? "reusable" : "unusable",
+			   rgn->name);
+		if (rgn->reusable)
+			reusable += (unsigned long)rgn->size;
+		else
+			reserved += (unsigned long)rgn->size;
+	}
+
+	seq_printf(m, "\n");
+	seq_printf(m, " .unusable  : %7lu KB\n",
+		   DIV_ROUND_UP(reserved, SZ_1K));
+	seq_printf(m, " .reusable  : %7lu KB\n",
+		   DIV_ROUND_UP(reusable, SZ_1K));
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(memblock_memsize);
+#endif
+
 static int __init memblock_init_debugfs(void)
 {
 	struct dentry *root = debugfs_create_dir("memblock", NULL);
@@ -2150,6 +2249,10 @@ static int __init memblock_init_debugfs(void)
 	debugfs_create_file("physmem", 0444, root, &physmem,
 			    &memblock_debug_fops);
 #endif
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+	debugfs_create_file("memsize", 0444, root,
+			    NULL, &memblock_memsize_fops);
+#endif
 
 	return 0;
 }
-- 
2.17.1

