Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A94E5F09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbiCXHBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348293AbiCXHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:01:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0829053B42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220324065922epoutp038cda4819a886f037cceaaedacff06b09~fPum_h9Ac2275722757epoutp03E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220324065922epoutp038cda4819a886f037cceaaedacff06b09~fPum_h9Ac2275722757epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105162;
        bh=KyBdZg8CThIyXolubx/7sGIn+ypooiLqPM4nQuxNNcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/F8+jQJnqAcCruZ1LHJv3s2D5EeFE9uc/DAPnXzMUbMCBtDN4oE2+be0W6plmVh8
         xXn1JSY/llGkikbr9ZuTjrYvJA/FpuZ7EXs/OXW9N2Ru2ienSZTr2CiOWwQ5WEfrQT
         w/+fhPVod3jnWj3FJrVWJCvWzhOVpmoq7VWytMtI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220324065921epcas1p3b26228c7923bad0615f453f252832899~fPumTg15a0544405444epcas1p3J;
        Thu, 24 Mar 2022 06:59:21 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.226]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KPGKz6rNvz4x9QX; Thu, 24 Mar
        2022 06:59:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.0A.64085.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p256ff799f37a765a432475808e708d639~fPukWGpZ80342903429epcas1p28;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp17a689e995e1ebee583756cc406048a8b~fPukVPaz92225222252epsmtrp1U;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-0c-623c16c78af8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip28837454c5e037d06492410f49713d2ec~fPukNtTfb3186931869epsmtip2c;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 4/8] memblock: track memblock changed at early param
Date:   Thu, 24 Mar 2022 16:01:54 +0900
Message-Id: <20220324070158.22969-5-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmge5xMZskgwsLdCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMfdOusxdct6xYunUPawPjTd0uRk4OCQETieZL/WxdjFwcQgI7
        GCWWXnrADpIQEvjEKLG3hRci8ZlR4urPqSwwHZ27fjFCJHYxSjQeOc4M4fxglHh19BwbSBWb
        gLbE+wWTWEFsEQE7iW+zD7CCFDELdDFKPPhwEGyUsICLxL+P/8EaWARUJR7OuApm8wrYSrx/
        dRZqnbzE6g0HmEFsTqBBK5ccAFstIXCPXWLa/1VQRS4SzX9mMEPYwhKvjm9hh7ClJF72t0HZ
        2RJPTx4BquEAsnMkGjbIQpj2Eu8vWYCYzAKaEut36UMUK0rs/D2XEcRmFuCTePe1hxWimlei
        o00IokRNouXZV1YIW0bi779nULaHxOmdfdAQncgo0fTtKfsERrlZCBsWMDKuYhRLLSjOTU8t
        NiwwhEdYcn7uJkZwmtMy3cE48e0HvUOMTByMhxglOJiVRHjvX7ZOEuJNSaysSi3Kjy8qzUkt
        PsRoCgy6icxSosn5wESbVxJvaGJpYGJmZGJhbGlspiTOu2ra6UQhgfTEktTs1NSC1CKYPiYO
        TqkGpoZL/VdqJvHmvLyS82ftqcP8bEWpk/YKis9aLsvv1r5s5/3kXVXx5cqsfgdn/Pme8fFL
        xZ6p70NXMXYp9/nGPdukL345QOn0688zmM3D4za8jHvBV9qyfUnWdSUGPbdpMie/lX9Z/jfG
        5Omjnl9GulvZ81ndp0+ov1us9nLlVcbS2VyqGiK8Ar77fqp9U1d63rD+q2i0/p6a6ilic20t
        Tv+26Jix30Lasa3++ga7YzWeR14/2ZGVtD8w4pCjrr/JpIuRmwTLN50XWpV18+q7D13nvqpc
        +nTdu3YOx634HRN3aaTM+M16Wn3WhR0TvonEXUw/y5Yp1PiAjeXr64xFi/9y8L72tZASqUh7
        9c+pLUqJpTgj0VCLuag4EQDDMAiP/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskgxPnJSzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV8a+adfZC65bVizduoe1gfGmbhcjJ4eE
        gIlE565fjCC2kMAORolf+4wg4jISb84/Zeli5ACyhSUOHy7uYuQCKvnGKNFz9yIzSA2bgLbE
        +wWTWEFsEQEniQ1XVrOAFDELTGCUWLnsEwtIQljAReLfx/9sIDaLgKrEwxlXwWxeAVuJ96/O
        skAsk5dYveEA2FBOATuJlUsOQB1kK3H25AG2CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YW
        l+al6yXn525iBAekltYOxj2rPugdYmTiYDzEKMHBrCTCe/+ydZIQb0piZVVqUX58UWlOavEh
        RmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTAb/lF2K/u87uqp+sVT3sw7jnMZptsHv
        p88IrrLTFan2N+Gbt+TH0uIWLZ7/tVYmlzldm6cVmqT6LT/Hd3TR/d2xTpJLPu/oydrfmmUo
        yOg1j3Xff7aN+07Pd62X6ft3vo19haf0OrYMTdlyj7L/bX51s62u38r7faXywMdO10/ry2YY
        8jtZJ812FA373lu29feVfXwZ55ZHJwbNFbOUX84hF53wxFP0nc+S1FzJO47WLfaPNC77zVft
        Oz1TfO76aXPF7E9ZMW6dn7vdwmm9VW9qtK2vq/GCzqCl77+nV+X7LCv5VX5I9ovR8uTZh3Ki
        Zm86ccqVy2nqlscVTx+bpj4yzMsPTzZ7vOps6/EdSizFGYmGWsxFxYkA3wxP9bcCAAA=
X-CMS-MailID: 20220324065919epcas1p256ff799f37a765a432475808e708d639
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p256ff799f37a765a432475808e708d639
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p256ff799f37a765a432475808e708d639@epcas1p2.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to reserved-memory in device tree, an option in cmdline may
result in memblock allocation. This patch tries to distinguish memblock
changes done at early param.

A region in memsize will be created with name as the param string. And
the region size will be updated during the param function.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/memblock.h |   4 ++
 init/main.c              |  13 ++++-
 mm/memblock.c            | 101 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 201f8723dfd8..4be4e0e6baf4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -609,11 +609,15 @@ extern void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable);
 extern void memblock_memsize_detect_hole(void);
+extern void memblock_memsize_set_name(const char *name);
+extern void memblock_memsize_unset_name(void);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable) { }
 static inline void memblock_memsize_detect_hole(void) { }
+static inline void memblock_memsize_set_name(const char *name) { }
+static inline void memblock_memsize_unset_name(void) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/init/main.c b/init/main.c
index 560f45c27ffe..ce59521b5ae5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -214,8 +214,15 @@ static bool __init obsolete_checksetup(char *line)
 				pr_warn("Parameter %s is obsolete, ignored\n",
 					p->str);
 				return true;
-			} else if (p->setup_func(line + n))
-				return true;
+			} else {
+				int ret;
+
+				memblock_memsize_set_name(p->str);
+				ret = p->setup_func(line + n);
+				memblock_memsize_unset_name();
+				if (ret)
+					return true;
+			}
 		}
 		p++;
 	} while (p < __setup_end);
@@ -736,8 +743,10 @@ static int __init do_early_param(char *param, char *val,
 		    (strcmp(param, "console") == 0 &&
 		     strcmp(p->str, "earlycon") == 0)
 		) {
+			memblock_memsize_set_name(p->str);
 			if (p->setup_func(val) != 0)
 				pr_warn("Malformed early option '%s'\n", param);
+			memblock_memsize_unset_name();
 		}
 	}
 	/* We accept everything at this stage. */
diff --git a/mm/memblock.c b/mm/memblock.c
index 9195a51bfa5d..4f21b596687e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -169,6 +169,18 @@ static inline phys_addr_t memblock_cap_size(phys_addr_t base, phys_addr_t *size)
 	return *size = min(*size, PHYS_ADDR_MAX - base);
 }
 
+#ifdef CONFIG_MEMBLOCK_MEMSIZE
+static void memblock_memsize_record_add(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size);
+static void memblock_memsize_record_remove(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size);
+#else
+static inline void memblock_memsize_record_add(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size) { }
+static inline void memblock_memsize_record_remove(struct memblock_type *type,
+			phys_addr_t base, phys_addr_t size) { }
+#endif /* CONFIG_MEMBLOCK_MEMSIZE */
+
 /*
  * Address comparison utilities
  */
@@ -578,6 +590,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
+	phys_addr_t new_size = 0;
 	int idx, nr_new;
 	struct memblock_region *rgn;
 
@@ -592,7 +605,8 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		type->regions[0].flags = flags;
 		memblock_set_region_node(&type->regions[0], nid);
 		type->total_size = size;
-		return 0;
+		new_size = size;
+		goto done;
 	}
 repeat:
 	/*
@@ -621,10 +635,12 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #endif
 			WARN_ON(flags != rgn->flags);
 			nr_new++;
-			if (insert)
+			if (insert) {
 				memblock_insert_region(type, idx++, base,
 						       rbase - base, nid,
 						       flags);
+				new_size += rbase - base;
+			}
 		}
 		/* area below @rend is dealt with, forget about it */
 		base = min(rend, end);
@@ -633,9 +649,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	/* insert the remaining portion */
 	if (base < end) {
 		nr_new++;
-		if (insert)
+		if (insert) {
 			memblock_insert_region(type, idx, base, end - base,
 					       nid, flags);
+			new_size += end - base;
+		}
 	}
 
 	if (!nr_new)
@@ -653,8 +671,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		goto repeat;
 	} else {
 		memblock_merge_regions(type);
-		return 0;
 	}
+done:
+	if (new_size == size)
+		memblock_memsize_record_add(type, obase, size);
+	return 0;
 }
 
 /**
@@ -790,6 +811,7 @@ static int __init_memblock memblock_remove_range(struct memblock_type *type,
 
 	for (i = end_rgn - 1; i >= start_rgn; i--)
 		memblock_remove_region(type, i);
+	memblock_memsize_record_remove(type, base, size);
 	return 0;
 }
 
@@ -2091,6 +2113,77 @@ void __init memblock_memsize_detect_hole(void)
 		}
 	}
 }
+
+/* assume that freeing region is NOT bigger than the previous region */
+static void __init_memblock memblock_memsize_free(phys_addr_t free_base,
+						  phys_addr_t free_size)
+{
+	int i;
+	struct memsize_rgn_struct *rgn;
+	phys_addr_t free_end, end;
+
+	free_end = free_base + free_size - 1;
+	memblock_dbg("%s %pa..%pa\n",
+		     __func__, &free_base, &free_end);
+
+	for (i = 0; i < memsize_rgn_count; i++) {
+		rgn = &memsize_rgn[i];
+
+		end = rgn->base + rgn->size;
+		if (free_base < rgn->base ||
+		    free_base >= end)
+			continue;
+
+		free_end = free_base + free_size;
+		if (free_base == rgn->base) {
+			rgn->size -= free_size;
+			if (rgn->size != 0)
+				rgn->base += free_size;
+		} else if (free_end == end) {
+			rgn->size -= free_size;
+		} else {
+			memblock_memsize_record(rgn->name, free_end,
+				end - free_end, rgn->nomap, rgn->reusable);
+			rgn->size = free_base - rgn->base;
+		}
+	}
+}
+
+static const char *memblock_memsize_name;
+
+void __init memblock_memsize_set_name(const char *name)
+{
+	memblock_memsize_name = name;
+}
+
+void __init memblock_memsize_unset_name(void)
+{
+	memblock_memsize_name = NULL;
+}
+
+static void __init_memblock memblock_memsize_record_add(struct memblock_type *type,
+				phys_addr_t base, phys_addr_t size)
+{
+	if (memblock_memsize_name) {
+		if (type == &memblock.reserved)
+			memblock_memsize_record(memblock_memsize_name,
+						base, size, false, false);
+		else if (type == &memblock.memory)
+			memblock_memsize_free(base, size);
+	}
+}
+
+static void __init_memblock memblock_memsize_record_remove(struct memblock_type *type,
+				phys_addr_t base, phys_addr_t size)
+{
+	if (memblock_memsize_name) {
+		if (type == &memblock.reserved)
+			memblock_memsize_free(base, size);
+		else if (type == &memblock.memory)
+			memblock_memsize_record(memblock_memsize_name,
+						base, size, true, false);
+	}
+}
 #endif /* MEMBLOCK_MEMSIZE */
 
 static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
-- 
2.17.1

