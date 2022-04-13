Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550EE5002CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiDMXwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbiDMXwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:52:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF623E0CB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p10so3271188plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sj2r+1mAjOUKlt7+Wq917atgiw1yhu7tQvGsGnE62eE=;
        b=UL37UhtyLGdU/4BmV48pF7FtOHXCK4o3yxIMzuVDdoasQm4t4wYaXKt8v2EjYXTmya
         oN3CSaVrQiLDsgbBMb6Gw0larTB/48InB5JqBKm7OZFRVgLBPl5/e4MUk7vL2s3ihHKr
         yRwMFoS0ZZCPGtujKnGIZCkzg0cc6CDxKuMQzCgBeqZ5F16n3IHLnWXVP73pguxEWFWz
         hyVusMBzNE72ssuVaEtXJ8QBx2uJ6YSrmyIbOsQ12K/AnW4malqnUKFSid3i3kAZXWJk
         2jecDTALKmEkfvhyG/Ky3cckwFYaapwYC4mvyQ78gGiEbaABsszklNIs/XHFhplrvIti
         EYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sj2r+1mAjOUKlt7+Wq917atgiw1yhu7tQvGsGnE62eE=;
        b=fwNxyOTNhx886fFWeJAHMrIsB5OgQuVsf/tTsTeoE6xViKpyU4Vfa3iJDr9wlqDrXx
         t7AMm7hJOKt7CLJO/SyUkVQgQVHoLf005OKwfBJ+f9fkWX9Sy9+kPuOqj79avF05aZeO
         vMZkhdGtP5U43gv1eE0tLRInDYYwgkeMlIetZQF1DmcH6gCzjfpc7oYc64wVrMd+pMGh
         v+rJ/+irjJLr0W0AruZuqA+J3/FtZdRNA66P7UzalOFnfXUSpRqNx8G3aEF3WFTGpROk
         GvSDoFbipkOI7/RmH6MbsA9iu5kIIaxDsS6urMV63Srupo3b/EDu8w/ND/TJycLYzCx6
         Ahug==
X-Gm-Message-State: AOAM532T/y8S5xnrHS38ThcxjL2uqfIkBGCNuCEb3BBvIl0Muycvd2Db
        LAV4Dc5bIYS58e99ZyOPVEk=
X-Google-Smtp-Source: ABdhPJx/ylC7tdyCKXX9fALkR9q3gdZnvqaWMrtd1u6qYarVuiO3w4TCAxYASVm1gHRa4I8AZSVUsw==
X-Received: by 2002:a17:90b:4a4a:b0:1c7:82e9:1014 with SMTP id lb10-20020a17090b4a4a00b001c782e91014mr1336612pjb.0.1649893788922;
        Wed, 13 Apr 2022 16:49:48 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:389b:6ba3:7cbd:d8d])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b005060849909esm197075pfl.176.2022.04.13.16.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:49:48 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] xtensa: extract vmalloc_fault code into a function
Date:   Wed, 13 Apr 2022 16:49:29 -0700
Message-Id: <20220413234930.1212335-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
References: <20220413234930.1212335-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move full MMU-specific code into a separate function to isolate it from
more generic do_page_fault code. No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/mm/fault.c | 107 +++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index 2a120c024334..01e66da4a6b0 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -23,6 +23,55 @@
 
 void bad_page_fault(struct pt_regs*, unsigned long, int);
 
+static void vmalloc_fault(struct pt_regs *regs, unsigned int address)
+{
+	/* Synchronize this task's top level page-table
+	 * with the 'reference' page table.
+	 */
+	struct mm_struct *act_mm = current->active_mm;
+	int index = pgd_index(address);
+	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
+	pud_t *pud, *pud_k;
+	pmd_t *pmd, *pmd_k;
+	pte_t *pte_k;
+
+	if (act_mm == NULL)
+		goto bad_page_fault;
+
+	pgd = act_mm->pgd + index;
+	pgd_k = init_mm.pgd + index;
+
+	if (!pgd_present(*pgd_k))
+		goto bad_page_fault;
+
+	pgd_val(*pgd) = pgd_val(*pgd_k);
+
+	p4d = p4d_offset(pgd, address);
+	p4d_k = p4d_offset(pgd_k, address);
+	if (!p4d_present(*p4d) || !p4d_present(*p4d_k))
+		goto bad_page_fault;
+
+	pud = pud_offset(p4d, address);
+	pud_k = pud_offset(p4d_k, address);
+	if (!pud_present(*pud) || !pud_present(*pud_k))
+		goto bad_page_fault;
+
+	pmd = pmd_offset(pud, address);
+	pmd_k = pmd_offset(pud_k, address);
+	if (!pmd_present(*pmd) || !pmd_present(*pmd_k))
+		goto bad_page_fault;
+
+	pmd_val(*pmd) = pmd_val(*pmd_k);
+	pte_k = pte_offset_kernel(pmd_k, address);
+
+	if (!pte_present(*pte_k))
+		goto bad_page_fault;
+	return;
+
+bad_page_fault:
+	bad_page_fault(regs, address, SIGKILL);
+}
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -48,8 +97,10 @@ void do_page_fault(struct pt_regs *regs)
 	/* We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
 	 */
-	if (address >= TASK_SIZE && !user_mode(regs))
-		goto vmalloc_fault;
+	if (address >= TASK_SIZE && !user_mode(regs)) {
+		vmalloc_fault(regs, address);
+		return;
+	}
 
 	/* If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -113,7 +164,7 @@ void do_page_fault(struct pt_regs *regs)
 
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
-			goto bad_page_fault;
+			bad_page_fault(regs, address, SIGKILL);
 		return;
 	}
 
@@ -180,56 +231,6 @@ void do_page_fault(struct pt_regs *regs)
 	if (!user_mode(regs))
 		bad_page_fault(regs, address, SIGBUS);
 	return;
-
-vmalloc_fault:
-	{
-		/* Synchronize this task's top level page-table
-		 * with the 'reference' page table.
-		 */
-		struct mm_struct *act_mm = current->active_mm;
-		int index = pgd_index(address);
-		pgd_t *pgd, *pgd_k;
-		p4d_t *p4d, *p4d_k;
-		pud_t *pud, *pud_k;
-		pmd_t *pmd, *pmd_k;
-		pte_t *pte_k;
-
-		if (act_mm == NULL)
-			goto bad_page_fault;
-
-		pgd = act_mm->pgd + index;
-		pgd_k = init_mm.pgd + index;
-
-		if (!pgd_present(*pgd_k))
-			goto bad_page_fault;
-
-		pgd_val(*pgd) = pgd_val(*pgd_k);
-
-		p4d = p4d_offset(pgd, address);
-		p4d_k = p4d_offset(pgd_k, address);
-		if (!p4d_present(*p4d) || !p4d_present(*p4d_k))
-			goto bad_page_fault;
-
-		pud = pud_offset(p4d, address);
-		pud_k = pud_offset(p4d_k, address);
-		if (!pud_present(*pud) || !pud_present(*pud_k))
-			goto bad_page_fault;
-
-		pmd = pmd_offset(pud, address);
-		pmd_k = pmd_offset(pud_k, address);
-		if (!pmd_present(*pmd) || !pmd_present(*pmd_k))
-			goto bad_page_fault;
-
-		pmd_val(*pmd) = pmd_val(*pmd_k);
-		pte_k = pte_offset_kernel(pmd_k, address);
-
-		if (!pte_present(*pte_k))
-			goto bad_page_fault;
-		return;
-	}
-bad_page_fault:
-	bad_page_fault(regs, address, SIGKILL);
-	return;
 }
 
 
-- 
2.30.2

