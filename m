Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3804751F635
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiEIHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiEIHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:44:46 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A3E62E8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:40:51 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220509073954epoutp0430003e04b6355b8fc3e316eed5889f06~tX9IpiVom1131511315epoutp04U
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:39:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220509073954epoutp0430003e04b6355b8fc3e316eed5889f06~tX9IpiVom1131511315epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652081994;
        bh=rRe3C0Q8ATjSIOb08O8/klpyddeuBgZBmXw+O02/wG8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=W69BJpF10Enj+We6lqF84BW1dnchR1zx2WwxN08LWPR+6YOQmQMeLkezOLBMBmlH8
         /UvOOIaRX1fcsW4qCDxBXSJEcaF6jaoKAQxlHkRM6dfqx28qNvCKQiY9qx7F0E0l0q
         XDdGYEt+nfT4x6uCuxdG6SIS0i5sEm4nt1fbw038=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220509073954epcas1p4258dee46bc81eb06eae1cb458752d9d3~tX9IXUE_S2991229912epcas1p4E;
        Mon,  9 May 2022 07:39:54 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.223]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KxY3Y5Fq9z4x9Pr; Mon,  9 May
        2022 07:39:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.14.10038.945C8726; Mon,  9 May 2022 16:39:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4~tX9HiwVnC2388723887epcas1p1K;
        Mon,  9 May 2022 07:39:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220509073953epsmtrp1ff76061dfbae49c1d3f0b4636c4352dc~tX9HhkE5i1674016740epsmtrp1h;
        Mon,  9 May 2022 07:39:53 +0000 (GMT)
X-AuditID: b6c32a37-111ff70000002736-75-6278c549122a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.86.08924.945C8726; Mon,  9 May 2022 16:39:53 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220509073953epsmtip265c272ca8e262f75384d56b250e7910a~tX9HXuIeM2917129171epsmtip2z;
        Mon,  9 May 2022 07:39:53 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH] page_ext: create page extension for all memblock memory
 regions
Date:   Mon,  9 May 2022 16:43:30 +0900
Message-Id: <20220509074330.4822-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7bCmvq7n0Yokg7Pf1S3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8Xsxj5GBzaPnbPusnts+jSJ3ePEjN8sHn1bVjF6nFlwhN3j8ya5
        ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoDOU
        FMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCF
        CdkZ3x9vZSu4IFrx+Cx3A+MfgS5GTg4JAROJ/mvbWbsYuTiEBHYwSkzZ1McO4XxilLh/B8b5
        zCixfe96RpiWhjkToBK7GCXWrHkI5fxglHh7aTorSBWbgLbE+wWTwGwRAV2Jgz0tzCA2s0Cp
        xNs3J8BsYYEwiYPvnwPZHBwsAqoS/x6VgYR5BWwk3h66wgSxTF5i9YYDzCDzJQQ2sUtsv9jJ
        CpFwkdj4/SxUkbDEq+Nb2CFsKYmX/W1QdrbE05NHwOZLCORINGyQhTDtJd5fsgAxmQU0Jdbv
        0ocoVpTY+XsuI8SRfBLvvvawQlTzSnS0CUGUqEm0PPsKtV9G4u+/Z1C2h8SVRYfB9ggJxEq8
        3681gVF2FsL8BYyMqxjFUguKc9NTiw0LjOERlJyfu4kRnKq0zHcwTnv7Qe8QIxMH4yFGCQ5m
        JRHe/X0VSUK8KYmVValF+fFFpTmpxYcYTYFhNZFZSjQ5H5gs80riDU0sDUzMjEwsjC2NzZTE
        eVdNO50oJJCeWJKanZpakFoE08fEwSnVwDSXo/J0QkVrlsQOvyRRjewttd9OLavc6me3aX3Y
        75WyZ7Jbu30+Cr/2ZPgo4/7HiDvb58dhn7VuT25+frz1rMjfR51d+2Ubvq47bhw67dCsBapV
        c6aIabevVX+UsOYV6x2lxDvfEh/oVumqbN7yZbKTFveroBV/3z141PIoN974zT8rIeeo1ytr
        b59Uujn5j67EHuMl9Vw906qy69w7XxeI6dR95FtYIrvX7nq0yk4psfc7b1ho/IvIv+o5NeCa
        NsO2Z2FrH+vzxH+ULNI5dCP4hU7GVraOP5fvOr96bs1Q3Vr0sUnLd6Lq//B1crzGhXc7l2xu
        7+e735j6UmnzBvPGzv8OwtvzTx8PqPluuVyJpTgj0VCLuag4EQDpjvIU3gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSvK7n0Yokg50zBS3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8Xsxj5GBzaPnbPusnts+jSJ3ePEjN8sHn1bVjF6nFlwhN3j8ya5
        ALYoLpuU1JzMstQifbsErozvj7eyFVwQrXh8lruB8Y9AFyMnh4SAiUTDnAnsXYxcHEICOxgl
        Tr35xAaRkJF4c/4pSxcjB5AtLHH4cDFEzTdGieVn74PVsAloS7xfMIkVxBYR0JfYu2oSC4jN
        LFAp8e/2LVaQXmGBEIlZn0pATBYBVYl/j8pAKngFbCTeHrrCBLFJXmL1hgPMExh5FjAyrGKU
        TC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA4fLa0djHtWfdA7xMjEwXiIUYKDWUmEd39f
        RZIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTNN12b7y
        ezOlOZ/tf35SZTnnFL2jR+8c39Adk77ITamzSMJ0m38S+z+pY0v3xG3lUvp5z0ml0f6WE1vy
        0zDXU1f5WjwP8SkGKvzwu/Nz6razO+ouSQeWBU+5PuPHFrkdzxXil7zuu3j0r9OUlyePutd3
        bZt8YP+t0tccXzuDFt14KjA58cveKberlwl+W2Z582ZP4I5z95wbVhwTbNvb8TBns6rYp7wD
        RVrPEl/cWs9uVjGJ97FTTtJeMY+Jpj+CFOwWbe2+ZvY2xOH1hryLnufi+Huu8L46mMckp9Pb
        ZRdnkGNatfXcJPOpe++d89+1Q+Uii+CPJNV1+SkKUn9y93dfNYwyWr387kofy5kvlisqsRRn
        JBpqMRcVJwIA7iuqCI4CAAA=
X-CMS-MailID: 20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page extension can be prepared for each section. But if the first
page is not valid, the page extension for the section was not
initialized though there were many other valid pages within the section.

To support the page extension for all sections, refer to memblock memory
regions. If the page is valid use the nid from pfn_to_nid, otherwise use
the previous nid.

Also this pagech changed log to include total sections and a section
size.

i.e.
allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x8000000)

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/page_ext.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 2e66d934d63f..506d58b36a1d 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct notifier_block *self,
 void __init page_ext_init(void)
 {
 	unsigned long pfn;
-	int nid;
+	int nid = 0;
+	struct memblock_region *rgn;
+	int nr_section = 0;
+	unsigned long next_section_pfn = 0;
 
 	if (!invoke_need_callbacks())
 		return;
 
-	for_each_node_state(nid, N_MEMORY) {
+	/*
+	 * iterate each memblock memory region and do not skip a section having
+	 * !pfn_valid(pfn)
+	 */
+	for_each_mem_region(rgn) {
 		unsigned long start_pfn, end_pfn;
 
-		start_pfn = node_start_pfn(nid);
-		end_pfn = node_end_pfn(nid);
-		/*
-		 * start_pfn and end_pfn may not be aligned to SECTION and the
-		 * page->flags of out of node pages are not initialized.  So we
-		 * scan [start_pfn, the biggest section's pfn < end_pfn) here.
-		 */
+		start_pfn = (unsigned long)(rgn->base >> PAGE_SHIFT);
+		end_pfn = start_pfn + (unsigned long)(rgn->size >> PAGE_SHIFT);
+
+		if (start_pfn < next_section_pfn)
+			start_pfn = next_section_pfn;
+
 		for (pfn = start_pfn; pfn < end_pfn;
 			pfn = ALIGN(pfn + 1, PAGES_PER_SECTION)) {
 
-			if (!pfn_valid(pfn))
-				continue;
-			/*
-			 * Nodes's pfns can be overlapping.
-			 * We know some arch can have a nodes layout such as
-			 * -------------pfn-------------->
-			 * N0 | N1 | N2 | N0 | N1 | N2|....
-			 */
-			if (pfn_to_nid(pfn) != nid)
-				continue;
+			if (pfn_valid(pfn))
+				nid = pfn_to_nid(pfn);
+			nr_section++;
 			if (init_section_page_ext(pfn, nid))
 				goto oom;
 			cond_resched();
 		}
+		next_section_pfn = pfn;
 	}
+
 	hotplug_memory_notifier(page_ext_callback, 0);
-	pr_info("allocated %ld bytes of page_ext\n", total_usage);
+	pr_info("allocated %ld bytes of page_ext for %d sections (1 section : 0x%x)\n",
+		total_usage, nr_section, (1 << SECTION_SIZE_BITS));
 	invoke_init_callbacks();
 	return;
 
-- 
2.17.1

