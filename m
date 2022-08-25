Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67BE5A0B13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiHYIIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiHYII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:08:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DA2A286F;
        Thu, 25 Aug 2022 01:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C722B8275D;
        Thu, 25 Aug 2022 08:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88BFC433C1;
        Thu, 25 Aug 2022 08:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661414903;
        bh=XfOFqfzXCa+k6af03iVwJecCGx56YZxl1KlR3f3DDwo=;
        h=From:To:Cc:Subject:Date:From;
        b=k7a8g6XEzoLLalTff7jdXR7oSs5dsEF5weJVHSYu2BF1hpeWN+/X7jsgozSdbvSnB
         ReC+X45k6PHHHFn0DipHpSjyHzMV63uAhLIw6DWFlFKgl6HKZnVKzbA1LvfAMhdRIf
         DRdKaYfeYc9TVf1ck/xLK2sKM/blZ+3PvFrsnuNrc5rBKrcgzQKLtzyzHymL3UmPWr
         4fsP1912cmlmoe0FtM3uFidIgLI9xE6+nt42KDeyLFHXnGfz98vIJRMCsRjWrH9HyD
         TggA+jXNRdx+G0vYdZIlnUMDcop8C1DLzHsI7/JihiwmwfpOwq8dni2HE8WK61WHDS
         N/5ftX8RLPYZQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v3] x86/sgx: Do not consider unsanitized pages an error
Date:   Thu, 25 Aug 2022 11:08:02 +0300
Message-Id: <20220825080802.259528-1-jarkko@kernel.org>
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

If sgx_dirty_page_list ends up being non-empty, currently this triggers
WARN_ON(), which produces a lot of noise, and can potentially crash the
kernel, depending on the kernel command line.

However, if the SGX subsystem initialization is retracted, the sanitization
process could end up in the middle, and sgx_dirty_page_list be left
non-empty for legit reasons.

Replace this faulty behavior with more verbose version
__sgx_sanitize_pages(), which can optionally print EREMOVE error code and
the number of unsanitized pages.

Link: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Fixes: 51ab30eb2ad4 ("x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Cc: Haitao Huang <haitao.huang@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
---
v3:
- Remove WARN_ON().
- Tuned comments and the commit message a bit.

v2:
- Replaced WARN_ON() with optional pr_info() inside
  __sgx_sanitize_pages().
- Rewrote the commit message.
- Added the fixes tag.
---
 arch/x86/kernel/cpu/sgx/main.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..d204520a5e26 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -50,16 +50,17 @@ static LIST_HEAD(sgx_dirty_page_list);
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
  */
-static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
+static void __sgx_sanitize_pages(struct list_head *dirty_page_list, bool verbose)
 {
 	struct sgx_epc_page *page;
+	int dirty_count = 0;
 	LIST_HEAD(dirty);
 	int ret;
 
 	/* dirty_page_list is thread-local, no need for a lock: */
 	while (!list_empty(dirty_page_list)) {
 		if (kthread_should_stop())
-			return;
+			break;
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
@@ -90,14 +91,22 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 			list_del(&page->list);
 			sgx_free_epc_page(page);
 		} else {
+			if (verbose)
+				pr_err_ratelimited(EREMOVE_ERROR_MESSAGE, ret, ret);
+
 			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
+			dirty_count++;
 		}
 
 		cond_resched();
 	}
 
 	list_splice(&dirty, dirty_page_list);
+
+	/* Can happen, when the initialization is retracted: */
+	if (verbose && dirty_count > 0)
+		pr_info("%d unsanitized pages\n", dirty_count);
 }
 
 static bool sgx_reclaimer_age(struct sgx_epc_page *epc_page)
@@ -394,11 +403,8 @@ static int ksgxd(void *p)
 	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
-
-	/* sanity check: */
-	WARN_ON(!list_empty(&sgx_dirty_page_list));
+	__sgx_sanitize_pages(&sgx_dirty_page_list, false);
+	__sgx_sanitize_pages(&sgx_dirty_page_list, true);
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
-- 
2.37.1

