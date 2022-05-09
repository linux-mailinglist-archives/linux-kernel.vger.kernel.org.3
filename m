Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B20520560
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiEITkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbiEITkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72200AE274;
        Mon,  9 May 2022 12:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59CBC60C5A;
        Mon,  9 May 2022 19:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA623C385B2;
        Mon,  9 May 2022 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652124988;
        bh=lbXpF2CBFxt8r9QI1yEWANwIKiW6h9ySSfu5r+RItXE=;
        h=Date:From:To:Cc:Subject:From;
        b=WwJQsdSTkKOhnWYM5jHl2ukngRRMRxtCHsznGqYFhuMpMYePeboun+nwvXrwBv7eY
         /A93AFWuLj83PmGU9Pgd6Wx2jhmpZalNh/xubw0u/FTuotUahIlchDF5QgePWy6H5y
         6eh2vXjx9/gFT5WME5Kqbo3Vmqq0HiZUsejwcUdj3ZFv/AWSCGlVGy9ddjgZk4axKY
         gQcbcUseXdcwsb+PmKYxEXBfaCO94ADFZMBquvV95sLZuhIzBKYqSf5fBHKOBi79fY
         5O1a16hHCCJQcQTn+fqbDgE36XMDY7alsN5in+m/YWtIKyA1cpVHU2oYkSLNRR7Ldx
         vOV/bfofI1ErA==
Date:   Mon, 9 May 2022 14:45:41 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] x86/mm/pgtable: Fix -Wstringop-overflow warnings
Message-ID: <20220509194541.GA91598@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following -Wstringop-overflow warnings when building with GCC-12.1:

arch/x86/mm/pgtable.c:437:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:440:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:462:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:454:9: warning: 'pgd_prepopulate_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:455:9: warning: 'pgd_prepopulate_user_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]

There is a case in which PREALLOCATED_PMDS, MAX_PREALLOCATED_PMDS,
PREALLOCATED_USER_PMDS and MAX_PREALLOCATED_USER_PMDS are defined as
zero:

204 #else  /* !CONFIG_X86_PAE */
205 
206 /* No need to prepopulate any pagetable entries in non-PAE modes. */
207 #define PREALLOCATED_PMDS       0
208 #define MAX_PREALLOCATED_PMDS   0
209 #define PREALLOCATED_USER_PMDS   0
210 #define MAX_PREALLOCATED_USER_PMDS 0
211 #endif  /* CONFIG_X86_PAE */

It seems that GCC is legitimately complaining about the fact that, under
certain circumstances, u_pmds and pmds are declared as zero-length arrays
in the stack and, of course, they are not flexible arrays.

424 pgd_t *pgd_alloc(struct mm_struct *mm)
425 {
426         pgd_t *pgd;
427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];
429

Notice that "Accessing elements of zero-length arrays declared in such
contexts is undefined and may be diagnosed."[1]

We can fix this by checking that MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
are different than zero, prior to passing u_pmds amd pmds as arguments to any
function, in this case to functions preallocate_pmds(), pgd_prepopulate_pmd()
and free_pmds().

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html

Link: https://github.com/KSPP/linux/issues/181
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Check MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
   instead of using pointer notation.
   Link: https://lore.kernel.org/linux-hardening/20220401005834.GA182932@embeddedor/
 - Update changelog text.

 arch/x86/mm/pgtable.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f16059e9a85e..96c3f402a1da 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -434,14 +434,18 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	mm->pgd = pgd;
 
-	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
-		goto out_free_pgd;
+	if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
+		if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
+			goto out_free_pgd;
 
-	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
-		goto out_free_pmds;
+		if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
+			goto out_free_pmds;
 
-	if (paravirt_pgd_alloc(mm) != 0)
-		goto out_free_user_pmds;
+		if (paravirt_pgd_alloc(mm) != 0)
+			goto out_free_user_pmds;
+	} else {
+		goto out_free_pgd;
+	}
 
 	/*
 	 * Make sure that pre-populating the pmds is atomic with
-- 
2.27.0

