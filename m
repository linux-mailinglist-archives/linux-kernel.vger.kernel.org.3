Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5B5A1E45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 03:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbiHZBlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 21:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHZBlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 21:41:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C6A1AF0F;
        Thu, 25 Aug 2022 18:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B18DB82F5A;
        Fri, 26 Aug 2022 01:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E63BC433C1;
        Fri, 26 Aug 2022 01:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661478095;
        bh=tGZRkwknFxZK4l3IP4cq+hwiJG4dh7EVsR1gbNjrfeE=;
        h=From:To:Cc:Subject:Date:From;
        b=jDRT5eMTE+fyJkc47w8oZJj1pQ/7iS1DsDlNca4/oT7ym9fCP3bWgub+Jq9Z3ZmFl
         B0j2dmZx9i2CMyJwylR3t9zyO2xrGEo4De1MPwXMdEQD/OfAJLLZ6RzSHUP+NBe4Cy
         6U4a21PrCHN6hE5i9NDeBoOwFBk6LsAAiTeFM6Iwc2KbFE+5HXmQ3YYKoAzHbbQnYx
         4l7+X0Y/hynAAK4a2Jw6eMx0eVxvNTByxGBxmstgnPvA4lu3dvxlPmweVYc9YPxSpP
         DrfraUEYcU2uim/8zkwwMy16Mvy5KdtHNcy0sGbjNWd2QFZiI881/FWoZslNjLpUBd
         AjgGhamCrQL5w==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v4] x86/sgx: Do not consider unsanitized pages an error
Date:   Fri, 26 Aug 2022 04:41:26 +0300
Message-Id: <20220826014126.291156-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.1
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

In sgx_init(), if misc_register() for the provision device fails, and
neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
prematurely stopped.

This triggers WARN_ON() because sgx_dirty_page_list ends up being
non-empty. Ultimately this can crash the kernel, depending on the kernel
command line, which is not correct behavior because SGX driver is not
working incorrectly.

Print simple warning instead, and improve the output by printing the
number of unsanitized pages.

Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Cc: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>

v4:
- Explain expectations for dirty_page_list in the function header, instead
  of an inline comment.
- Improve commit message to explain the conditions better.
- Return the number of pages left dirty to ksgxd() and print warning after
  the 2nd call, if there are any.

v3:
- Remove WARN_ON().
- Tuned comments and the commit message a bit.

v2:
- Replaced WARN_ON() with optional pr_info() inside
  __sgx_sanitize_pages().
- Rewrote the commit message.
- Added the fixes tag.
---
 arch/x86/kernel/cpu/sgx/main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..903100fcfce3 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -49,17 +49,20 @@ static LIST_HEAD(sgx_dirty_page_list);
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
+ *
+ * Contents of the @dirty_page_list must be thread-local, i.e.
+ * not shared by multiple threads.
  */
-static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
+static int __sgx_sanitize_pages(struct list_head *dirty_page_list)
 {
 	struct sgx_epc_page *page;
+	int left_dirty = 0;
 	LIST_HEAD(dirty);
 	int ret;
 
-	/* dirty_page_list is thread-local, no need for a lock: */
 	while (!list_empty(dirty_page_list)) {
 		if (kthread_should_stop())
-			return;
+			break;
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
@@ -92,12 +95,14 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 		} else {
 			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
+			left_dirty++;
 		}
 
 		cond_resched();
 	}
 
 	list_splice(&dirty, dirty_page_list);
+	return left_dirty;
 }
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
@@ -388,6 +393,8 @@ void sgx_reclaim_direct(void)
 
 static int ksgxd(void *p)
 {
+	int left_dirty;
+
 	set_freezable();
 
 	/*
@@ -395,10 +402,10 @@ static int ksgxd(void *p)
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
 	__sgx_sanitize_pages(&sgx_dirty_page_list);
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
 
-	/* sanity check: */
-	WARN_ON(!list_empty(&sgx_dirty_page_list));
+	left_dirty = __sgx_sanitize_pages(&sgx_dirty_page_list);
+	if (left_dirty)
+		pr_warn("%d unsanitized pages\n", left_dirty);
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
-- 
2.37.1

