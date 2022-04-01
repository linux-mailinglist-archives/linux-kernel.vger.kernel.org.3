Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F281A4EE581
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbiDAAvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDAAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:51:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC219D625;
        Thu, 31 Mar 2022 17:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52C73B82296;
        Fri,  1 Apr 2022 00:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A7CC340ED;
        Fri,  1 Apr 2022 00:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648774194;
        bh=k2NWL0oVgQKreKhbC4I/NAVwEIag4IqjGx4i3YT4Y/M=;
        h=Date:From:To:Cc:Subject:From;
        b=dEPEV/kaWDJhphxLwbUmMXxTm85wSDZfOyljX0PxPwugbI3V7xCxB/kBGz7ygoeBQ
         HTtN4qNa8V5I0hGdd3HvKiMGu3bUfBNpCYm9fD/XIYiborxQP23CBmxJqGxxJ55pAE
         tS8aNWiGBQuBjsaneVa+A2kc+Bl/zY/Gi4WlCtTr71qgzvtxH7i8vQpFaezw1XhyZr
         xUDR+EhdUBHTuLFPwzT033Jbv60ohBsJ2aaYPYsBtVuhIusHmcnBINQjQH1l/HMv5P
         WFNiGmYesPIwbzoeWasLm3lirLJe0ydWK0hSfiNBGoBOkFJ2r7eY9rL8+HRNQgweaG
         Aots0W7XUyytg==
Date:   Thu, 31 Mar 2022 19:58:34 -0500
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
Subject: [PATCH][next] x86/mm/pgtable: Fix Wstringop-overflow warnings
Message-ID: <20220401005834.GA182932@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Fix the following -Wstringop-overflow warnings when building with GCC-11:

.arch/x86/mm/pgtable.c: In function ‘pgd_alloc’:
arch/x86/mm/pgtable.c:437:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  437 |         if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:437:13: note: referencing argument 2 of type ‘pmd_t **’
arch/x86/mm/pgtable.c:225:12: note: in a call to function ‘preallocate_pmds.constprop’
  225 | static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
      |            ^~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:440:13: warning: ‘preallocate_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  440 |         if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:440:13: note: referencing argument 2 of type ‘pmd_t **’
arch/x86/mm/pgtable.c:225:12: note: in a call to function ‘preallocate_pmds.constprop’
  225 | static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
      |            ^~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:462:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  462 |         free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:462:9: note: referencing argument 2 of type ‘pmd_t **’
arch/x86/mm/pgtable.c:213:13: note: in a call to function ‘free_pmds.constprop’
  213 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
      |             ^~~~~~~~~
arch/x86/mm/pgtable.c:455:9: warning: ‘pgd_prepopulate_user_pmd’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  455 |         pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:455:9: note: referencing argument 3 of type ‘pmd_t **’
arch/x86/mm/pgtable.c:320:13: note: in a call to function ‘pgd_prepopulate_user_pmd’
  320 | static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:464:9: warning: ‘free_pmds.constprop’ accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  464 |         free_pmds(mm, pmds, PREALLOCATED_PMDS);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:464:9: note: referencing argument 2 of type ‘pmd_t **’
arch/x86/mm/pgtable.c:213:13: note: in a call to function ‘free_pmds.constprop’
  213 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
      |             ^~~~~~~~~

by using pointer notation instead of array notation as a workaround for
the above GCC warnings.

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/181
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/mm/pgtable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 3481b35cb4ec..aecaebf3c3d0 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -210,7 +210,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 #define MAX_PREALLOCATED_USER_PMDS 0
 #endif	/* CONFIG_X86_PAE */
 
-static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
+static void free_pmds(struct mm_struct *mm, pmd_t **pmds, int count)
 {
 	int i;
 
@@ -222,7 +222,7 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		}
 }
 
-static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
+static int preallocate_pmds(struct mm_struct *mm, pmd_t **pmds, int count)
 {
 	int i;
 	bool failed = false;
@@ -318,7 +318,7 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
-				     pgd_t *k_pgd, pmd_t *pmds[])
+				     pgd_t *k_pgd, pmd_t **pmds)
 {
 	pgd_t *s_pgd = kernel_to_user_pgdp(swapper_pg_dir);
 	pgd_t *u_pgd = kernel_to_user_pgdp(k_pgd);
-- 
2.27.0

