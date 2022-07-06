Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB6E567CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiGFDui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiGFDuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:50:10 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696C1CFD7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:48:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y18so4605284plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vO0ibtZ+G9xkuV+PcEvkoLdb5M0LHVa95jNt+v4jHr8=;
        b=FVZFdqd/sveybWuB17SKf5U66wsYwfbA6oOkfyj/92C+lDDgN8lmLbq4HCfE6pqVV7
         4sPhYZa6rjtwFjU0BCsxeYfG7T/UMWPO/afLG5p463TDAQHhyOY3Y7RpCI1UeoHKCbsV
         c4ssgFikv0deFfkyurQDrP/ErVVysB1GeUrol7EaFWOIs8UF8woniH10nZY07lcMbnnw
         kCIrVeJ2aazOVEuyeHOZQ0q0uFQlVGJJ38J5gcZeeDqq5yiRmXhKkOsYWAiJ6b8z+Mvm
         OtGwLQTHryzjClCFzJQflj3RxXonvh30uuV4Yj+j2jeWQjO1VcypByEYV2MoPNzORARi
         /dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vO0ibtZ+G9xkuV+PcEvkoLdb5M0LHVa95jNt+v4jHr8=;
        b=U7DXbt/MUhguWrdJ29wUPQGzfgz/oIxslbewsGviRpUl+19ULpZDnU8KkDS0nVfFRn
         XcmeUIAHd8BeE0r/kuoJH2I9l+fPVIvsnCOmxWQVLPqeBXpp4RJnmz8/TOmcJ4kFSmTI
         y+Wy1k1rUBDLBr4thXKzddyK9uOcrFIAyMPQRaVYuFCsUqjjUJw2GkWiEg8lweW1/YPl
         qYp1DCneLgr+2EpktwhWs5sYa2Hular4qrdjAHT4c62n2mAIpNHcVnqmVviwlWK8H/Zj
         pb/uH89b5z3WgxEPualrdr+erC/8bT/2lICriZ4+kaiSIw4YC4nbcuzfWJge9bX/pfKm
         rTqw==
X-Gm-Message-State: AJIora/GMwFujWlKNEkDaOB9yw+O5OXpmv1QsJ9btuZ0RpXsvI2PtRul
        20yEy73qe3F14eyLzT3OOIjurg==
X-Google-Smtp-Source: AGRyM1v0bTBAale1x4Kc9Cg6jv4aP0ydNajpRAzJD9jLi1ytuYgxp/4bpSZyXv1zCgZJ8Aki0Ha0YA==
X-Received: by 2002:a17:902:9307:b0:166:41a8:abc0 with SMTP id bc7-20020a170902930700b0016641a8abc0mr45898229plb.135.1657079326192;
        Tue, 05 Jul 2022 20:48:46 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id u27-20020a62d45b000000b0050dc7628148sm23723282pfl.34.2022.07.05.20.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 20:48:45 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm, hugetlb: skip irrelevant nodes in show_free_areas()
Date:   Wed,  6 Jul 2022 11:46:54 +0800
Message-Id: <20220706034655.1834-1-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_free_areas() allows to filter out node specific data which is
irrelevant to the allocation request. But hugetlb_show_meminfo() still
shows hugetlb on all nodes, which is redundant and unnecessary.

Use show_mem_node_skip() to skip irrelevant nodes. And replace
hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).

before-and-after sample output of OOM:

before:
```
[  214.362453] Node 1 active_anon:148kB inactive_anon:4050920kB active_file:112kB inactive_file:100kB
[  214.375429] Node 1 Normal free:45100kB boost:0kB min:45576kB low:56968kB high:68360kB reserved_hig
[  214.388334] lowmem_reserve[]: 0 0 0 0 0
[  214.390251] Node 1 Normal: 423*4kB (UE) 320*8kB (UME) 187*16kB (UE) 117*32kB (UE) 57*64kB (UME) 20
[  214.397626] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[  214.401518] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
```

after:
```
[  145.069705] Node 1 active_anon:128kB inactive_anon:4049412kB active_file:56kB inactive_file:84kB u
[  145.110319] Node 1 Normal free:45424kB boost:0kB min:45576kB low:56968kB high:68360kB reserved_hig
[  145.152315] lowmem_reserve[]: 0 0 0 0 0
[  145.155244] Node 1 Normal: 470*4kB (UME) 373*8kB (UME) 247*16kB (UME) 168*32kB (UE) 86*64kB (UME) 
[  145.164119] Node 1 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
```

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
v3->v4:
 - add before-and-after sample output text. (Andrew Morton)

v2->v3:
 - move for_each_hstate() into hugetlb_show_meminfo_node(). (Muchun Song)

v1->v2:
 - replace hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid) to avoid
   exporting show_mem_node_skip. (Muchun Song)
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 18 ++++++++----------
 mm/page_alloc.c         |  8 ++++++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 29c4d0883d36..21795e62398b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -155,7 +155,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct page *ref_page, zap_flags_t zap_flags);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
-void hugetlb_show_meminfo(void);
+void hugetlb_show_meminfo_node(int nid);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
@@ -301,7 +301,7 @@ static inline int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 	return 0;
 }
 
-static inline void hugetlb_show_meminfo(void)
+static inline void hugetlb_show_meminfo_node(int nid)
 {
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ca081078e814..e7f12edb120c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4490,22 +4490,20 @@ int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 			     nid, h->surplus_huge_pages_node[nid]);
 }
 
-void hugetlb_show_meminfo(void)
+void hugetlb_show_meminfo_node(int nid)
 {
 	struct hstate *h;
-	int nid;
 
 	if (!hugepages_supported())
 		return;
 
-	for_each_node_state(nid, N_MEMORY)
-		for_each_hstate(h)
-			pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
-				nid,
-				h->nr_huge_pages_node[nid],
-				h->free_huge_pages_node[nid],
-				h->surplus_huge_pages_node[nid],
-				huge_page_size(h) / SZ_1K);
+	for_each_hstate(h)
+		printk("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
+			nid,
+			h->nr_huge_pages_node[nid],
+			h->free_huge_pages_node[nid],
+			h->surplus_huge_pages_node[nid],
+			huge_page_size(h) / SZ_1K);
 }
 
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2eb6ad5a650a..93f032f32812 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6014,7 +6014,7 @@ static void show_migration_types(unsigned char type)
 void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 {
 	unsigned long free_pcp = 0;
-	int cpu;
+	int cpu, nid;
 	struct zone *zone;
 	pg_data_t *pgdat;
 
@@ -6202,7 +6202,11 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		printk(KERN_CONT "= %lukB\n", K(total));
 	}
 
-	hugetlb_show_meminfo();
+	for_each_online_node(nid) {
+		if (show_mem_node_skip(filter, nid, nodemask))
+			continue;
+		hugetlb_show_meminfo_node(nid);
+	}
 
 	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
 
-- 
2.20.1

