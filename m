Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED155411A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356201AbiFVEBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiFVEBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:01:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7626F33EAE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:01:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bo5so14936834pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYa4yiJ07M3lgAUara1ddh2Fl/2EMqAxZqq+KQ/z45A=;
        b=2yBsnXHi0sJ5gksnfpXBlu6OIcXsiyZ8E3CKsc1rFx/zdoQHwR0GIDkgQoEpHQn5xc
         3oahsnfTh5X7fL0qelOXgwPDDCtIjqL3rZl48ID7UDkxXCCHl5Hqma12n/8ce+JSHqwO
         UiHhuACbNgvHA1pVAfqqMdjeLUE79q9EkUb/8y3GweUvZVQamPv5UaLY0aYMxcZWcM4U
         6ZxmCtIQxUpILv6F4BoFY3c6o4jERnG/u2I75R01yyYpwjFJvIIlJ/2F52EQy8+gYe6O
         XRe3q4aAitZCZ9JSOFc2/Hp7m3E27pGzU8xYvbkQ6pO4xuUyZ8K0Jy1+M96AF2+Nb6NA
         URFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYa4yiJ07M3lgAUara1ddh2Fl/2EMqAxZqq+KQ/z45A=;
        b=AubepHPmdCETIksDZg8CR1P6l5AablfbB70rwGb4NgS9ryWvtsTKUB1XEaSg+Rppml
         BvdAaRoFKmyrM4nAjwOPJmnG8d7I7oXOaeKUbOUNsmut/qCKj8tIO9D600YvkQaJs/jd
         hykPLaacHe2LfAlTMJWlRc4CgjjWWIhIy5M+FtbDJzD6bv7mugBABIt578yBTOltmGwU
         QBD0qZOsQlTmWIvt/ScqhtkqwiY4HJtwqwBukt1NeJfsp/kAerFkCQJ6IzHgX7F1tYqc
         RF5SFIsEjvwbu8R+DlMOxSi4HJAEQMijIebxh41j4Dzi4zQQCn3Mde3JbDGbwWr3ps1F
         doQQ==
X-Gm-Message-State: AJIora/neW9Eu3un/wDpaRf2k2LAIiAJfX6SDfatEHQexX/DEZ6783hs
        DRjfTuWvfnSme6PLYRpkdA/8MA==
X-Google-Smtp-Source: AGRyM1vd6fmMfsIYhhjorbNqQH/xakz3eNiYI12x3eZPYGIlasO/NTSUnQBFu+lH5JNe2Bd3nX3K2A==
X-Received: by 2002:a63:7a49:0:b0:40c:ca38:aed7 with SMTP id j9-20020a637a49000000b0040cca38aed7mr1192901pgn.11.1655870496958;
        Tue, 21 Jun 2022 21:01:36 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id t66-20020a637845000000b004088f213f68sm12091082pgc.56.2022.06.21.21.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:01:36 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Gang Li <ligang.bdlg@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, hugetlb: skip irrelevant nodes in hugetlb_show_meminfo()
Date:   Wed, 22 Jun 2022 12:00:42 +0800
Message-Id: <20220622040043.25462-1-ligang.bdlg@bytedance.com>
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

Use show_mem_node_skip() to skip irrelevant nodes in
hugetlb_show_meminfo().

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/hugetlb.h | 4 ++--
 include/linux/mm.h      | 1 +
 mm/hugetlb.c            | 7 +++++--
 mm/page_alloc.c         | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 642a39016f9a..1913ac6bf10a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -155,7 +155,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 			  struct page *ref_page, zap_flags_t zap_flags);
 void hugetlb_report_meminfo(struct seq_file *);
 int hugetlb_report_node_meminfo(char *buf, int len, int nid);
-void hugetlb_show_meminfo(void);
+void hugetlb_show_meminfo(unsigned int filter, nodemask_t *nodemask);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
@@ -300,7 +300,7 @@ static inline int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 	return 0;
 }
 
-static inline void hugetlb_show_meminfo(void)
+static inline void hugetlb_show_meminfo(unsigned int filter, nodemask_t *nodemask)
 {
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 764dc0fdae5e..f72c1b21cde3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1873,6 +1873,7 @@ extern void pagefault_out_of_memory(void);
  */
 #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
 
+extern bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask);
 extern void show_free_areas(unsigned int flags, nodemask_t *nodemask);
 
 #ifdef CONFIG_MMU
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 98492733cc64..632826e6fea5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4486,7 +4486,7 @@ int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 			     nid, h->surplus_huge_pages_node[nid]);
 }
 
-void hugetlb_show_meminfo(void)
+void hugetlb_show_meminfo(unsigned int filter, nodemask_t *nodemask)
 {
 	struct hstate *h;
 	int nid;
@@ -4494,7 +4494,9 @@ void hugetlb_show_meminfo(void)
 	if (!hugepages_supported())
 		return;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY) {
+		if (show_mem_node_skip(filter, nid, nodemask))
+			continue;
 		for_each_hstate(h)
 			pr_info("Node %d hugepages_total=%u hugepages_free=%u hugepages_surp=%u hugepages_size=%lukB\n",
 				nid,
@@ -4502,6 +4504,7 @@ void hugetlb_show_meminfo(void)
 				h->free_huge_pages_node[nid],
 				h->surplus_huge_pages_node[nid],
 				huge_page_size(h) / SZ_1K);
+	}
 }
 
 void hugetlb_report_usage(struct seq_file *m, struct mm_struct *mm)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 84781094b478..5896b5a9101f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5951,7 +5951,7 @@ void si_meminfo_node(struct sysinfo *val, int nid)
  * Determine whether the node should be displayed or not, depending on whether
  * SHOW_MEM_FILTER_NODES was passed to show_free_areas().
  */
-static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
+bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
 {
 	if (!(flags & SHOW_MEM_FILTER_NODES))
 		return false;
@@ -6196,7 +6196,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		printk(KERN_CONT "= %lukB\n", K(total));
 	}
 
-	hugetlb_show_meminfo();
+	hugetlb_show_meminfo(filter, nodemask);
 
 	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
 
-- 
2.20.1

