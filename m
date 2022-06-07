Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9269053CBDC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbiFCO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245260AbiFCO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:56:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E361140DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:56:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c2so10490307edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plkRHxZRk9CMIn7YOznv+vuUGRy66YRIHBjRF967Ovg=;
        b=OFHroXywrVa28TjmeuM2CMND/lkHNeB16Lt8Jq4E+glKJ+M7g6kanfCClZ/vFLbsov
         r8u80hXBHLksypvSYoPqwzFpAvd//6QXleUWoJK13uqoAIkBMosyf14qgs97WAoRRFMS
         2KC6Aydv3OfnpRsyHYsxy5s2+idac3Jr5ftWPg1lOOMhX2cY9q1vxiYomkU9wyA37TPs
         y092tj0B+WAidkzySllTdAu4D4oFoTQV5zFbZgVofWXuBfipvdQrWKcYFYeiqnrtaMUH
         4A/YjJ4MwVGW9fEPcYOu8uvC7WZOVe5qBOe1jEhd3lz2/ZtjlZn/oDr2bvMun5l0roiS
         2EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plkRHxZRk9CMIn7YOznv+vuUGRy66YRIHBjRF967Ovg=;
        b=MCDJSDFkVXxaMvmyMMb90wrTOGCYkeK47Wq0wVrwfD2aj2MVi3AFkDoECVbk5BH/lr
         0umAK+VdW791MIPdPaRd1tGeL7CDcK80PoFiqFy0mDd2o2J69uxORxBXq9kyaV7U2mOW
         DJa+EP4r9K+ZS8qaqMvr5DwyMyd5TQB/6RSOCmL6XWH7AfsL0NhGN1wn4ubDXD7PzkmL
         2pDz6hx0cRkXzPwsQP/cnMPBnPFmsXYBZmOkj1oMwQiMONQrn4QfpE8xaw8xv00L5pFu
         DyaktMX1AyYfgspz8iBdMCWi5v7J6XTf1YHjjwRqWp+mAkBHjuheKK3Q8boVPKWROAb5
         tcvw==
X-Gm-Message-State: AOAM5328Ri5rrARgz249O2DA8ya7UfFcKBA0Sy86bJoj+/Lyw8k4OpYX
        mFOrxls+f2fA7Rxl5e1anvM=
X-Google-Smtp-Source: ABdhPJx1tqTWq+bg3K48QBR4njKSxXrtNNk36G7Ebems4gSc3jniGgD8tYlpAFClGJES+20LMJVByg==
X-Received: by 2002:a05:6402:b45:b0:42d:bf43:8db1 with SMTP id bx5-20020a0564020b4500b0042dbf438db1mr11221191edb.100.1654268210815;
        Fri, 03 Jun 2022 07:56:50 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id e2-20020a1709062d4200b006fec2097d53sm2917509eji.118.2022.06.03.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 07:56:46 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id AEEECA0366; Fri,  3 Jun 2022 16:57:20 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH v4 2/2] [PATCH 2/2] mm: add merging after mremap resize
Date:   Fri,  3 Jun 2022 16:57:19 +0200
Message-Id: <20220603145719.1012094-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220603145719.1012094-1-matenajakub@gmail.com>
References: <20220603145719.1012094-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mremap call results in expansion, it might be possible to merge the
VMA with the next VMA which might become adjacent. This patch adds
vma_merge call after the expansion is done to try and merge.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mremap.c                              | 19 +++++++++-
 tools/testing/selftests/vm/mremap_test.c | 47 +++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0b93fac76851..66970dcd636a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/shm.h>
 #include <linux/ksm.h>
@@ -23,6 +24,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/uaccess.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mempolicy.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
@@ -1014,6 +1016,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		/* can we just expand the current mapping? */
 		if (vma_expandable(vma, new_len - old_len)) {
 			long pages = (new_len - old_len) >> PAGE_SHIFT;
+			unsigned long extension_start = addr + old_len;
+			unsigned long extension_end = addr + new_len;
+			pgoff_t extension_pgoff = vma->vm_pgoff + (old_len >> PAGE_SHIFT);
 
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
@@ -1022,8 +1027,18 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 				}
 			}
 
-			if (vma_adjust(vma, vma->vm_start, addr + new_len,
-				       vma->vm_pgoff, NULL)) {
+			/*
+			 * Function vma_merge() is called on the extension we are adding to
+			 * the already existing vma, vma_merge() will merge this extension with
+			 * the already existing vma (expand operation itself) and possibly also
+			 * with the next vma if it becomes adjacent to the expanded vma and
+			 * otherwise compatible.
+			 */
+			vma = vma_merge(mm, vma, extension_start, extension_end,
+					vma->vm_flags, vma->anon_vma, vma->vm_file,
+					extension_pgoff, vma_policy(vma),
+					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			if (!vma) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
 				goto out;
diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index db0270127aeb..0865a6cb5bdb 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -118,6 +118,48 @@ static unsigned long long get_mmap_min_addr(void)
 	return addr;
 }
 
+/*
+ * This test validates that merge is called when expanding a mapping.
+ * Mapping containing three pages is created, middle page is unmapped
+ * and then the mapping containing the first page is expanded so that
+ * it fills the created hole. The two parts should merge creating
+ * single mapping with three pages.
+ */
+static void mremap_expand_merge(unsigned long page_size)
+{
+	char *test_name = "mremap expand merge";
+	FILE *fp;
+	char *line = NULL;
+	size_t len = 0;
+	bool success = false;
+
+	char *start = mmap(NULL, 3 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	munmap(start + page_size, page_size);
+	mremap(start, page_size, 2 * page_size, 0);
+
+	fp = fopen("/proc/self/maps", "r");
+	if (fp == NULL) {
+		ksft_test_result_fail("%s\n", test_name);
+		return;
+	}
+
+	while(getline(&line, &len, fp) != -1) {
+		char *first = strtok(line,"- ");
+		void *first_val = (void *) strtol(first, NULL, 16);
+		char *second = strtok(NULL,"- ");
+		void *second_val = (void *) strtol(second, NULL, 16);
+		if (first_val == start && second_val == start + 3 * page_size) {
+			success = true;
+			break;
+		}
+	}
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+	fclose(fp);
+}
+
 /*
  * Returns the start address of the mapping on success, else returns
  * NULL on failure.
@@ -336,6 +378,7 @@ int main(int argc, char **argv)
 	int i, run_perf_tests;
 	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
 	unsigned int pattern_seed;
+	int num_expand_tests = 1;
 	struct test test_cases[MAX_TEST];
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -407,12 +450,14 @@ int main(int argc, char **argv)
 				(threshold_mb * _1MB >= _1GB);
 
 	ksft_set_plan(ARRAY_SIZE(test_cases) + (run_perf_tests ?
-		      ARRAY_SIZE(perf_test_cases) : 0));
+		      ARRAY_SIZE(perf_test_cases) : 0) + num_expand_tests);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
 		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
 				     pattern_seed);
 
+	mremap_expand_merge(page_size);
+
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
 		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");
-- 
2.35.1

