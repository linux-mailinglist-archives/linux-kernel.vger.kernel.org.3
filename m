Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE85ADDD3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiIFDMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiIFDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:12:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1E3341C;
        Mon,  5 Sep 2022 20:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 133FA6009F;
        Tue,  6 Sep 2022 03:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CC5C433D6;
        Tue,  6 Sep 2022 03:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662433961;
        bh=tmrdgH/WlSuQiDKL64aa6Wi96JA6uPdX+zlQQqPwLKI=;
        h=From:To:Cc:Subject:Date:From;
        b=GRbQonXft3unMrDvMWdWn4g8HAYEUjaDotDHRi3qdwNtcZAy4zMwJ/brBNVxbwlMt
         HtVduZNE8gmGH/j+QybnseLjkDB0Q4PBWlubx7zMrmQtz5Tgu2rt+3E3oN58UQ4EqW
         C0Gy2cTzGqmWrptufmHunRVhaz036ywLN1ZKJcXQDax9IVdr2vDMOL7acaz7fCXXHY
         MB5fWRR5cz2cTsBUihZq7N1oSyVlP0R0hB7jII+pUWm8lQVfoXttLfp5LnBuaAgMG0
         rA2jZr+QTlDG96IOVrdVhNkCxX0YUjqPtNR8SfIL1GVwYfxZLZXXSXfNLO3AceHxtl
         /Xbq4Ba2p24Bg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH RFC] x86/sgx: Use a heap allocated list head for unsanitized pages
Date:   Tue,  6 Sep 2022 06:12:30 +0300
Message-Id: <20220906031230.107108-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate the list head for the unsanitized pages from heap, and transfer
its to ownership to ksgxd, which takes care of destroying it. Remove
sgx_dirty_page_list, as a global list is no longer required.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Depends on https://lore.kernel.org/linux-sgx/20220906000221.34286-1-jarkko@kernel.org/T/#t
Would this be plausible?
---
 arch/x86/kernel/cpu/sgx/main.c | 44 ++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 0aad028f04d4..6d0e38078d28 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -43,8 +43,6 @@ static nodemask_t sgx_numa_mask;
  */
 static struct sgx_numa_node *sgx_numa_nodes;
 
-static LIST_HEAD(sgx_dirty_page_list);
-
 /*
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
  * from the input list, and made available for the page allocator. SECS pages
@@ -392,16 +390,23 @@ void sgx_reclaim_direct(void)
 		sgx_reclaim_pages();
 }
 
-static int ksgxd(void *p)
+/*
+ * The page list head must be allocated from the heap, and its ownership is
+ * transferred to ksgxd, which takes care of destroying it.
+ */
+static int ksgxd(void *page_list_ptr)
 {
+	struct list_head *page_list = page_list_ptr;
+
 	set_freezable();
 
 	/*
 	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
-	WARN_ON(__sgx_sanitize_pages(&sgx_dirty_page_list));
+	__sgx_sanitize_pages(page_list);
+	WARN_ON(__sgx_sanitize_pages(page_list));
+	kfree(page_list);
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
@@ -420,11 +425,11 @@ static int ksgxd(void *p)
 	return 0;
 }
 
-static bool __init sgx_page_reclaimer_init(void)
+static bool __init sgx_page_reclaimer_init(struct list_head *page_list)
 {
 	struct task_struct *tsk;
 
-	tsk = kthread_run(ksgxd, NULL, "ksgxd");
+	tsk = kthread_run(ksgxd, page_list, "ksgxd");
 	if (IS_ERR(tsk))
 		return false;
 
@@ -619,7 +624,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 					 unsigned long index,
-					 struct sgx_epc_section *section)
+					 struct sgx_epc_section *section,
+					 struct list_head *page_list)
 {
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	unsigned long i;
@@ -643,7 +649,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
 		section->pages[i].poison = 0;
-		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
+		list_add_tail(&section->pages[i].list, page_list);
 	}
 
 	return true;
@@ -784,7 +790,7 @@ static void __init arch_update_sysfs_visibility(int nid)
 static void __init arch_update_sysfs_visibility(int nid) {}
 #endif
 
-static bool __init sgx_page_cache_init(void)
+static bool __init sgx_page_cache_init(struct list_head *page_list)
 {
 	u32 eax, ebx, ecx, edx, type;
 	u64 pa, size;
@@ -812,7 +818,7 @@ static bool __init sgx_page_cache_init(void)
 
 		pr_info("EPC section 0x%llx-0x%llx\n", pa, pa + size - 1);
 
-		if (!sgx_setup_epc_section(pa, size, i, &sgx_epc_sections[i])) {
+		if (!sgx_setup_epc_section(pa, size, i, &sgx_epc_sections[i], page_list)) {
 			pr_err("No free memory for an EPC section\n");
 			break;
 		}
@@ -912,20 +918,32 @@ EXPORT_SYMBOL_GPL(sgx_set_attribute);
 
 static int __init sgx_init(void)
 {
+	struct list_head *page_list;
 	int ret;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SGX))
 		return -ENODEV;
 
-	if (!sgx_page_cache_init())
+	page_list = kzalloc(sizeof(*page_list), GFP_KERNEL);
+	if (!page_list)
 		return -ENOMEM;
 
-	if (!sgx_page_reclaimer_init()) {
+	INIT_LIST_HEAD(page_list);
+
+	if (!sgx_page_cache_init(page_list)) {
+		kfree(page_list);
+		return -ENOMEM;
+	}
+
+	if (!sgx_page_reclaimer_init(page_list)) {
+		kfree(page_list);
 		ret = -ENOMEM;
 		goto err_page_cache;
 	}
 
+	/* page_list is now owned by ksgxd. */
+
 	ret = misc_register(&sgx_dev_provision);
 	if (ret)
 		goto err_kthread;
-- 
2.37.2

