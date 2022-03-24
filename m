Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACFE4E5F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348381AbiCXHBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbiCXHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:01:01 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9953A65
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220324065923epoutp0287eb53b5a37ca3fbe8fa66e47ee1a94f~fPuoTA2YI1471914719epoutp02I
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220324065923epoutp0287eb53b5a37ca3fbe8fa66e47ee1a94f~fPuoTA2YI1471914719epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105163;
        bh=Bqm/uYAUxy26yMvY4oGKIsXAEx3p7iHRdLjtnHs2oTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbruOS4pLz4J6X/p21E4Xg00qDE+HW1p8xe+EeBvtkugsYa0F32S7rlv9nlTs9U94
         7iNAfYNhTM7hgEJ/TSOm2wNjUg7IXfMrnjBHhinzy5GofyYnB2Y85A/0u9ybxBBJIV
         HM0YDG++MxslSqbcpJqJjfYCX1a3zrkGGDCGVQjg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220324065922epcas1p287d475f1da44cd5157aa68723aa7fc64~fPunicYXx0552505525epcas1p2W;
        Thu, 24 Mar 2022 06:59:22 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KPGL11p4Wz4x9QC; Thu, 24 Mar
        2022 06:59:21 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.68.09592.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p3a3a267c4348be4fd3bb8437d4e6db142~fPukZTpC50544405444epcas1p3H;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp143dd5c0a9b1565df9fecce82a4a1d18b~fPukYGkAZ2225322253epsmtrp1O;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-f1-623c16c75437
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2f6256c3ab39428720f6e8985cbb638fe~fPukP_OPb3186531865epsmtip2e;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 5/8] memblock: track kernel size on memsize
Date:   Thu, 24 Mar 2022 16:01:55 +0900
Message-Id: <20220324070158.22969-6-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmnu5xMZskg9n3TC3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMN6t2sxQctau4dreLqYHxnHEXIyeHhICJxLlnU9i7GLk4hAR2
        MEpsn/aLEcL5xChx6vVzVgjnM6PEt+9dbF2MHGAtG7eHg3QLCexilNi2JhWi5gejxMcD7Uwg
        CTYBbYn3CyaxgtgiAnYS32YfABvELNDFKPHgw0EWkISwgLXE+xO3wIpYBFQlXj6aDbaAV8BW
        YvkVU4jz5CVWbzjADGJzAs1ZueQA2HUSAvfYJT7uaWeHKHKRuHyjgRnCFpZ4dXwLVFxK4mV/
        G5SdLfH05BFmiAdyJBo2yEKY9hLvL1mAmMwCmhLrd+lDFCtK7Pw9lxHEZhbgk3j3tYcVoppX
        oqNNCKJETaLl2VdWCFtG4u+/Z1AlHhLdRzkhATKRUWLnuxdsExjlZiEsWMDIuIpRLLWgODc9
        tdiwwBgeW8n5uZsYwQlOy3wH47S3H/QOMTJxMB5ilOBgVhLhvX/ZOkmINyWxsiq1KD++qDQn
        tfgQoykw4CYyS4km5wNTbF5JvKGJpYGJmZGJhbGlsZmSOO+qaacThQTSE0tSs1NTC1KLYPqY
        ODilGpjslJtDPNOO3IyX3GC5tGRx1LHsSyuiY69Una3K1494ovf/rum0ba9lWzY/jVPh7Fpx
        oK9D9BOnVanYMWkZzZ9adoaz6i7dd/t4rV/DYIFdR0uZE+exAqM702q/v3kvZ8CrnPIgyKjf
        RlJp3lqN3JnFf1YcXSvzQ0N28pIEhQMpv99qp87YvXGe+epmLv0v0vnP4r83/2Wb+ys974aC
        p8X6zOlSvMduHTJ3f5WltfD1p+kPn3E2v/Nx7twr/17t20YXe8+zQklvO9Zwf+Az22pk0lZ0
        rPeG9d8NFQLn01RXnfY43Fz86IrJl57HjdEGfz+YF1oU/75SoxNg1WqeGnI/bX7lmmb+CWoT
        tx85w6HEUpyRaKjFXFScCAAzJ1yd+QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskg39bpC3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV8abVbtZCo7aVVy728XUwHjOuIuRg0NC
        wERi4/bwLkYuDiGBHYwSG28tY+li5ASKy0i8Of+UBaJGWOLw4WKImm+MEjsebgCrYRPQlni/
        YBIriC0i4CSx4cpqFpAiZoEJjBIrl30CKxIWsJZ4f+IWWBGLgKrEy0ez2UCG8grYSiy/Ygqx
        S15i9YYDzCA2p4CdxMolBxhBbCGgkrMnD7BNYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOBy1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe+5etk4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgsi5S+1jtbagnEFu37N4Cb6eDRyMOV+Vx
        KJxKOnTYdOkrRV2eeeJlZVOFqs6I1k57+jL48aazTpMF4jaXMLCdWunrdXXPBMbdv6cpr3rz
        dNLx7Ed36g69y+ftT1Hz3VF0Udf2Q4j2Qztjzkfb8rmXi85+L6wkVqq2/Q2b2JVXvVVKTD+t
        d52pi5iQIbm6iS/mL08Fo+KlnSy/Of2+G5zez/7P7qR4ROGX8DcRaxcGrdry1t+Zt6Xn2/On
        Vf5FOR33JRQnaH5cOkcivKRN/kG7yb42z/92oW8de8VaX3d5bPu7RHy7Rp/AMc9zqpc37L4g
        5GS5Kzs7nE96hso6y/97BSfe7s/MSnoW3v9xdcIRJZbijERDLeai4kQA6tE0GrYCAAA=
X-CMS-MailID: 20220324065919epcas1p3a3a267c4348be4fd3bb8437d4e6db142
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p3a3a267c4348be4fd3bb8437d4e6db142
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p3a3a267c4348be4fd3bb8437d4e6db142@epcas1p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memory regions are already being tracked by previous patches. But
there are many memory allocations from memblock and frees to memblock
during the boot time.

This patch tracks the memblock size used for the common kernel. To to
this, tracking memblock size is disabled for some memory handling logics
like early param, device tree, and default cma size.

For precise kernel size, this patch counts not actually freed size to
buddy at boot time, and does not count freed size from ramdisk and init
section.

Additionally this patch does one important thing. This patch blocks
memblock_add_range of memblock_remove_range not to update memsize if
free pages were already released to the buddy allocator.

This is an example. The kernel size is newly added by this patch.

 .kernel    :  135137 KB
 .unusable  :  788073 KB
 .reusable  :  294912 KB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/fdt.c         |  6 ++++++
 include/linux/memblock.h |  6 ++++++
 kernel/dma/contiguous.c  |  7 ++++--
 mm/memblock.c            | 46 ++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c          |  9 +++++++-
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 9721a3d7b7ae..8d38d1499d71 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -640,6 +640,8 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
+	memblock_memsize_disable_tracking();
+
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
@@ -652,6 +654,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	fdt_scan_reserved_mem();
 	fdt_reserve_elfcorehdr();
 	fdt_init_reserved_mem();
+	memblock_memsize_enable_tracking();
 }
 
 /**
@@ -1289,12 +1292,15 @@ void __init early_init_dt_scan_nodes(void)
 	if (rc)
 		pr_warn("No chosen node found, continuing without\n");
 
+	memblock_memsize_disable_tracking();
+
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	early_init_dt_scan_memory();
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
 
+	memblock_memsize_enable_tracking();
 	memblock_memsize_detect_hole();
 }
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 4be4e0e6baf4..6d59c6e68467 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -611,6 +611,9 @@ extern void memblock_memsize_record(const char *name, phys_addr_t base,
 extern void memblock_memsize_detect_hole(void);
 extern void memblock_memsize_set_name(const char *name);
 extern void memblock_memsize_unset_name(void);
+extern void memblock_memsize_enable_tracking(void);
+extern void memblock_memsize_disable_tracking(void);
+extern void memblock_memsize_mod_kernel_size(long size);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
@@ -618,6 +621,9 @@ static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 static inline void memblock_memsize_detect_hole(void) { }
 static inline void memblock_memsize_set_name(const char *name) { }
 static inline void memblock_memsize_unset_name(void) { }
+static inline void memblock_memsize_enable_tracking(void){ }
+static inline void memblock_memsize_disable_tracking(void){ }
+static inline void memblock_memsize_mod_kernel_size(long size) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 7415c1135afa..2a3ecf6a6b22 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -230,10 +230,11 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 {
 	int ret;
 
+	memblock_memsize_disable_tracking();
 	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed,
 					"reserved", res_cma);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(cma_get_base(*res_cma),
@@ -241,7 +242,9 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 
 	memblock_memsize_record("dma_cma", cma_get_base(*res_cma),
 				cma_get_size(*res_cma), false, true);
-	return 0;
+out:
+	memblock_memsize_enable_tracking();
+	return ret;
 }
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index 4f21b596687e..aee22dbc2500 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1965,6 +1965,23 @@ struct memsize_rgn_struct {
 #define MAX_MEMSIZE_RGN	64
 static struct memsize_rgn_struct memsize_rgn[MAX_MEMSIZE_RGN] __initdata_memblock;
 static int memsize_rgn_count __initdata_memblock;
+static long kernel_init_size;
+static bool do_memsize __initdata_memblock = true;
+
+void __init memblock_memsize_enable_tracking(void)
+{
+	do_memsize = true;
+}
+
+void __init memblock_memsize_disable_tracking(void)
+{
+	do_memsize = false;
+}
+
+void memblock_memsize_mod_kernel_size(long size)
+{
+	kernel_init_size += size;
+}
 
 static inline struct memsize_rgn_struct * __init_memblock memsize_get_new_rgn(void)
 {
@@ -2170,6 +2187,12 @@ static void __init_memblock memblock_memsize_record_add(struct memblock_type *ty
 						base, size, false, false);
 		else if (type == &memblock.memory)
 			memblock_memsize_free(base, size);
+	} else if (do_memsize) {
+		if (type == &memblock.reserved) {
+			memblock_dbg("%s: kernel %lu %+ld\n", __func__,
+				     kernel_init_size, (unsigned long)size);
+			kernel_init_size += size;
+		}
 	}
 }
 
@@ -2182,6 +2205,12 @@ static void __init_memblock memblock_memsize_record_remove(struct memblock_type
 		else if (type == &memblock.memory)
 			memblock_memsize_record(memblock_memsize_name,
 						base, size, true, false);
+	} else if (do_memsize) {
+		if (type == &memblock.reserved) {
+			memblock_dbg("%s: kernel %lu %+ld\n", __func__,
+				     kernel_init_size, (unsigned long)size);
+			kernel_init_size -= size;
+		}
 	}
 }
 #endif /* MEMBLOCK_MEMSIZE */
@@ -2289,6 +2318,19 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	unsigned long end_pfn = min_t(unsigned long,
 				      PFN_DOWN(end), max_low_pfn);
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+	unsigned long start_align_up = PFN_ALIGN(start);
+	unsigned long end_align_down = PFN_PHYS(end_pfn);
+
+	if (start_pfn >= end_pfn) {
+		memblock_memsize_mod_kernel_size(end - start);
+	} else {
+		if (start_align_up > start)
+			memblock_memsize_mod_kernel_size(start_align_up - start);
+		if (end_pfn != max_low_pfn && end_align_down < end)
+			memblock_memsize_mod_kernel_size(end - end_align_down);
+	}
+#endif
 	if (start_pfn >= end_pfn)
 		return 0;
 
@@ -2374,6 +2416,8 @@ void __init memblock_free_all(void)
 
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
+
+	memblock_memsize_disable_tracking();
 }
 
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
@@ -2441,6 +2485,8 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 	}
 
 	seq_printf(m, "\n");
+	seq_printf(m, " .kernel    : %7lu KB\n",
+		   DIV_ROUND_UP(kernel_init_size, SZ_1K));
 	seq_printf(m, " .unusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reserved, SZ_1K));
 	seq_printf(m, " .reusable  : %7lu KB\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6e0b4596cde9..bbbe314850b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8230,8 +8230,15 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 		free_reserved_page(page);
 	}
 
-	if (pages && s)
+	if (pages && s) {
 		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
+		if (!strcmp(s, "initrd") || !strcmp(s, "unused kernel")) {
+			long size;
+
+			size = -1 * (long)(pages << PAGE_SHIFT);
+			memblock_memsize_mod_kernel_size(size);
+		}
+	}
 
 	return pages;
 }
-- 
2.17.1

