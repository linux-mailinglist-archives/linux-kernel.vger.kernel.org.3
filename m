Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FBA5661F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiGEDtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiGEDtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:49:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7112748
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 20:49:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q82so3151691pgq.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 20:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8W5VXSsMR9SIWfIFdd/+qIMKQzpXYNtEC9shhUXWyA=;
        b=yTwRafuNQfMiOZKlJUe3g3ODrRNEvzMm28lOhNj1X0MgwQODD9lPwqJ5LYMSEnuVwD
         K8bV07NN4UeyNpGqBlKha/cGRnSuFHQU0g4Wu0Iackun2GyW5x7h1KvMO4dQzhQif9fS
         ZBsrWVnb4EMtA+LecCu7h0U0AuR0WQIX9ywup/Sb8UXLwuA8A3HPibNgriXtYKqRiwAc
         xxfl291CLwWlJIFmy6V+dnHkf6wW2iJ6sIou6jyo/m8Vtt6ueqFrlJHpey2yfGn1xXqw
         AYQDPvPoL/5yl/t8aBv6lpWeF0oLjTps0AYVCqrHL58Ce6pUj1ZltI6MpdyvVJttCqeE
         446Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8W5VXSsMR9SIWfIFdd/+qIMKQzpXYNtEC9shhUXWyA=;
        b=oBg411ahmXy3JgzVZmrbonxZxxMK9v/psZK7b5rO9V94vjSxRJX55JDlOqadQml8BA
         r3/Lgzt8H4aCx84JMR6XZ0cpf/z53uSgj/Dlc4l1ijbrCr0hrJhoZTLe7yDbTAP/3AKE
         H0b/xPxb9iC5mTpAMJNcFWGFMAwaEbN1THgsnIZ9ZCt+l8Uyme+b6pa+MZ46uChW7J9E
         FhgFK6AmF/m5fE0shTMD/0siRVll/6wOqPC5RS5YNVfP3QIrcr8D5vKCnDeuJUv3zvis
         2y2fHYae3zugRZ+gWaisDtMiN6gDbnopTHmObifAG30eAKAdfJoIeiGUQDw1y02O0Yts
         fAIw==
X-Gm-Message-State: AJIora/hag23BYH2iwkOBi+ozwklkxz7xeOh8SfvoCKENvW8DpWscfm/
        U/yTR529vwRKiu693DZM8JFX0A==
X-Google-Smtp-Source: AGRyM1uKg1CAEOtf50oeywo6H4iwYYQyg4ajAsUic6maJyQPqlo+e65AJ5ML4Y2oBCkIVlDDQwz3hw==
X-Received: by 2002:a63:64c1:0:b0:411:e736:a790 with SMTP id y184-20020a6364c1000000b00411e736a790mr16838370pgb.45.1656992949862;
        Mon, 04 Jul 2022 20:49:09 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b0052527ca27b2sm22484842pfn.143.2022.07.04.20.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:49:09 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm, hugetlb: skip irrelevant nodes in show_free_areas()
Date:   Tue,  5 Jul 2022 11:48:40 +0800
Message-Id: <20220705034841.40931-1-ligang.bdlg@bytedance.com>
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
show hugetlb on all nodes, which is redundant and unnecessary.

Use show_mem_node_skip() to skip irrelevant nodes. And replace
hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
v2: replace hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid) to avoid
    exporting show_mem_node_skip.
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 21 ++++++++-------------
 mm/page_alloc.c         | 10 ++++++++--
 3 files changed, 18 insertions(+), 17 deletions(-)

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
index ca081078e814..c87049c4126e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4490,22 +4490,17 @@ int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 			     nid, h->surplus_huge_pages_node[nid]);
 }
 
-void hugetlb_show_meminfo(void)
+void hugetlb_show_meminfo_node(int nid)
 {
 	struct hstate *h;
-	int nid;
 
-	if (!hugepages_supported())
-		return;
-
-	for_each_node_state(nid, N_MEMORY)
-		for_each_hstate(h)
-			pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
-				nid,
-				h->nr_huge_pages_node[nid],
-				h->free_huge_pages_node[nid],
-				h->surplus_huge_pages_node[nid],
-				huge_page_size(h) / SZ_1K);
+	for_each_hstate(h)
+		pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
+			nid,
+			h->nr_huge_pages_node[nid],
+			h->free_huge_pages_node[nid],
+			h->surplus_huge_pages_node[nid],
+			huge_page_size(h) / SZ_1K);
 }
 
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2eb6ad5a650a..684c2e410923 100644
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
 
@@ -6202,7 +6202,13 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		printk(KERN_CONT "= %lukB\n", K(total));
 	}
 
-	hugetlb_show_meminfo();
+	if (hugepages_supported()) {
+		for_each_node_state(nid, N_MEMORY) {
+			if (show_mem_node_skip(filter, nid, nodemask))
+				continue;
+			hugetlb_show_meminfo_node(nid);
+		}
+	}
 
 	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
 
-- 
2.20.1

