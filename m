Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E623E5665FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGEJVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGEJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:21:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF15F57
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:21:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fz10so5491216pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LgwF/oY7NUpKw/Y/fMnLZAeLVExnQU2R9m9v7nVaDfc=;
        b=QFcU4rwbVJLltnJDdJe0qNVzQqeQSyTrpb6QqV+dnZ6F/eKt9/zSvyqo9YgLi8aUlW
         SuB/BeRaKA1BBQcU0P4C72BEzZy2gLXEQa0SOH7g4238RuKwe7BdrFZ4fMwXnDVDNzOF
         AhOvTt4Z1FPlOytEFYw9q3OfPJp4O/gfdmhYkyXPLE3hPSRNIgHOpXZrUPXQihKQnnQy
         VG1ieRoDAEnE0dhWfCYMo4S6Z7WmDIuA37dFiw1b5xBV5OZPXSsaOsl70r2yyYXkkvcS
         S/OlK7zmlXNJLKWccNLomxHSNFRAnAroETwsCZNN/06LrdpVo6ej0pN3DLaq9IzvxKit
         rg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LgwF/oY7NUpKw/Y/fMnLZAeLVExnQU2R9m9v7nVaDfc=;
        b=2dTkogotLYULo+HEgzvYlnZld4vbfAULUKFsGjOnBK6GU/DTk6qAqVF9FrZ4pXihnD
         SpAcFlfR7Clac7i3HcdhZO1yN4YiDxkiUOm7GRvKGzz8LA2VU3gMeG24c+qvRYBPFcWL
         EOYf1ZWT399AD3sHxuWGkO3YV2g9BsttKnVGWRVTvXv2J7LqblAsVFGPaJwSL7exAcjI
         p2PcGWPRJd4JnU6DQ0vrcgp3xFGJaL1KhZMp9boPgxv1ffJhL/NIl27EEohkOTRJ5llU
         gKML8kDU4tNDuNNgBEhrfJEML8OMztrsuRk/C8PgSttNUOcvyRLfefx3EU6BcjS5DkdL
         CS7w==
X-Gm-Message-State: AJIora8DmuLJEpVedvI6XvLs/SRhC5cl/PQ3XnO5YfwwjJwI4kpLG0ic
        k8KpaAo6PITVKqU8GSqIJkiCLQ==
X-Google-Smtp-Source: AGRyM1tGo7DPRa4WK2JmH6Fn7rMd2tCaLxNf/EeSOMS0olIUAncthgFKn+tGrFH4UrwYMNKpwFDjbg==
X-Received: by 2002:a17:90b:4d05:b0:1e0:b53:f4a3 with SMTP id mw5-20020a17090b4d0500b001e00b53f4a3mr42262948pjb.3.1657012889165;
        Tue, 05 Jul 2022 02:21:29 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id n19-20020a635913000000b0040df0c9a1aasm16816025pgb.14.2022.07.05.02.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 02:21:28 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm, hugetlb: skip irrelevant nodes in show_free_areas()
Date:   Tue,  5 Jul 2022 17:21:19 +0800
Message-Id: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
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

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
v3: move for_each_hstate() into hugetlb_show_meminfo_node().
v2: replace hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid) to avoid
    exporting show_mem_node_skip.
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

