Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD36053BB43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiFBO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiFBO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:56:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDFF2AD98E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:56:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fu3so8998403ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plkRHxZRk9CMIn7YOznv+vuUGRy66YRIHBjRF967Ovg=;
        b=HftDeftCoaRwOnKYKg0+jnbxtHNvBbjODuhXYFO2QbjQW5f2p1vZ7QR7lSPhi1Tpo6
         zQIf0SsRnaoMYlNDJFjxwnMh0QxywoReN/NUiqPmEw9khk+s1id55epnrkyctNSlBng6
         yZgze0/sBJmFciSLBnov0zru92Wm/r0oJ/bJQETbLT9tapPwyTQklrP8gqMqqvP6OWGS
         AUb1idz8HGGjiiKLtrWKIUKRczniTp5YLo1dlGC7Zlj0qRCzdWwvRhOIqYYXPuIxSM13
         SoaHQWmF9A4AIz75alU5K+N87Ip4goG9RRLb7djoRNAixjUaLSzb+gafziTdUn3BhBUu
         J7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plkRHxZRk9CMIn7YOznv+vuUGRy66YRIHBjRF967Ovg=;
        b=i3/g9l0tFvNGkPbh/c0i/xbmq8QPrmPUFzaNCyVBXpVSHlszSyGyaP6q4lOavLXzNQ
         g+tSGdGVv6+J3M0UMehMUwj88vkVQSlVvmsZTofr9Wf9AtpQ8amsQMxOPBiyvyY4Kc4h
         KODeFw9jST9Pf1BrWqbedRYHvM0dCGCVmBXwWvHWbcH2CPOZqPCwm1yC/1YglmfV5ugX
         O9Uu4r/Mu0BDxI9qEwCpgyJbJFNpJuklzOB/TMMYMFDP8LshaM1CcPeH7agLZ9GhVH20
         NkE/Z1gS3/J+9Okm4ZjWn2SIAj/hafAnoc58PGwjW2cX47rvMXH4tLQx/ptNEwRkjIHj
         Ukow==
X-Gm-Message-State: AOAM532AbRH2x/nhxbYEVWVyp60070S5DI47GoP44w3R9Ol9Q87J6VzQ
        /oh9Fqb2wiFQyKRLUr546UM=
X-Google-Smtp-Source: ABdhPJydHQyQWjXz9p+kXVNMSBYSkBhpBXvIgTo6+N7WpZ4t+zvxXoay5Q2cKcCAKpn4Duv4qsQt0A==
X-Received: by 2002:a17:907:728a:b0:6fe:f10b:80cc with SMTP id dt10-20020a170907728a00b006fef10b80ccmr4452079ejc.22.1654181784494;
        Thu, 02 Jun 2022 07:56:24 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906590f00b007081c5ce04dsm1589173ejq.58.2022.06.02.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:56:23 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 2E073A0887; Thu,  2 Jun 2022 16:56:57 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH 2/2] [PATCH 2/2] mm: add merging after mremap resize
Date:   Thu,  2 Jun 2022 16:56:42 +0200
Message-Id: <20220602145642.16948-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602145642.16948-1-matenajakub@gmail.com>
References: <20220602145642.16948-1-matenajakub@gmail.com>
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

