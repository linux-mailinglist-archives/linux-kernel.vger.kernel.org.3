Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329375A0865
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiHYFSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiHYFSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:18:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7666D9E69A;
        Wed, 24 Aug 2022 22:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F28B826BE;
        Thu, 25 Aug 2022 05:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D4C433C1;
        Thu, 25 Aug 2022 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661404717;
        bh=fxlXoI0BcD8fsY3aXrOKEQ/2X/05DBMUWFtJX8AD4Pw=;
        h=From:To:Cc:Subject:Date:From;
        b=Mlo8Lc6memWV3g/OVDBSFHdaKPkoXWyN5Bk6d2hIDAXVbDkLwFq/pOvdkR3zhlIn7
         KfcK3pO48mJ5r+Tzs87UFaVg4oqRF0qT5J2zGAGeu0u+9PlRBCO+omo7ZMPtDYR6NA
         61ndSbqHbrHG2shPJ1NhPOxwItwaCETHWnBeADsH7goCKsBYlm3ESAOF076k62DfyY
         KzhJKdniISxznAuEIEaGgFcio2dxNSxUSl6AdTtP0r4mrnIny1ZNvcsjnaOSv4PT7Y
         /Iba5z4cAeUKX8nNVPV0dXdmGilkG9uIQl1E9tKl6VCPjYp2N6bihAuy9eXUbCPDaT
         0K2VijtR9H58Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/sgx: Print EREMOVE return value in __sgx_sanitize_pages()
Date:   Thu, 25 Aug 2022 08:18:27 +0300
Message-Id: <20220825051827.246698-1-jarkko@kernel.org>
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

In the 2nd run of __sgx_sanitize_pages() print the error
message. All EREMOVE's should succeed. This will allow to
provide some additional clues, if not.

Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 515e2a5f25bb..33354921c59f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -50,7 +50,7 @@ static LIST_HEAD(sgx_dirty_page_list);
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
  */
-static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
+static void __sgx_sanitize_pages(struct list_head *dirty_page_list, bool verbose)
 {
 	struct sgx_epc_page *page;
 	LIST_HEAD(dirty);
@@ -90,6 +90,9 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 			list_del(&page->list);
 			sgx_free_epc_page(page);
 		} else {
+			if (verbose)
+				pr_err_ratelimited(EREMOVE_ERROR_MESSAGE, ret, ret);
+
 			/* The page is not yet clean - move to the dirty list. */
 			list_move_tail(&page->list, &dirty);
 		}
@@ -394,8 +397,8 @@ static int ksgxd(void *p)
 	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
 	 * required for SECS pages, whose child pages blocked EREMOVE.
 	 */
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
-	__sgx_sanitize_pages(&sgx_dirty_page_list);
+	__sgx_sanitize_pages(&sgx_dirty_page_list, false);
+	__sgx_sanitize_pages(&sgx_dirty_page_list, true);
 
 	/* sanity check: */
 	WARN_ON(!list_empty(&sgx_dirty_page_list));
-- 
2.37.1

