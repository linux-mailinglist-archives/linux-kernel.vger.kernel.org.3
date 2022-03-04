Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B964CD15F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiCDJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiCDJh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:37:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573021A6F9F;
        Fri,  4 Mar 2022 01:36:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA4B3B827B8;
        Fri,  4 Mar 2022 09:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFBEC340E9;
        Fri,  4 Mar 2022 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386594;
        bh=lWejqATEW/q/CLKjFBnZqv7CVO31Bvbype7mwXlAaeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GI2nN/+6HjKlLdzdV0ABzzFeInz2eKYuT+/y97A3fZny4xYw7xVhybVYDXcoPYpcN
         iAk8mYFd8dAzXHh2u4komRgMzHs5Y1BfU1qX8B8bqduaqTZ/1F0WBha1BhBcgovAnO
         +F2gQrx41i6SAop0K9eicxfUq1qD0lC1uPO2nsNgEuxUqQXHq4Y8LG3rEFqN5Y7z8U
         Dwd5khixjFGCgoLFYWc1TaiyFNhadGW3ym9qpnCFugnWY62mw/WsFyXJdJiusBaGdv
         6L2acejjScdL/wEaqkyMkcL8Hb6qlC1WRYBhl75F0dcjegBYWX+sRB45ykQU3fnE1G
         1oTWigRNmOaxg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RFC PATCH v2.1 08/30] x86/sgx: Export sgx_encl_ewb_cpumask()
Date:   Fri,  4 Mar 2022 11:35:02 +0200
Message-Id: <20220304093524.397485-8-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Using sgx_encl_ewb_cpumask() to learn which CPUs might have executed
an enclave is useful to ensure that TLBs are cleared when changes are
made to enclave pages.

sgx_encl_ewb_cpumask() is used within the reclaimer when an enclave
page is evicted. The upcoming SGX2 support enables changes to be
made to enclave pages and will require TLBs to not refer to the
changed pages and thus will be needing sgx_encl_ewb_cpumask().

Relocate sgx_encl_ewb_cpumask() to be with the rest of the enclave
code in encl.c now that it is no longer unique to the reclaimer.

Take care to ensure that any future usage maintains the
current context requirement that ETRACK has been called first.
Expand the existing comments to highlight this while moving them
to a more prominent location before the function.

No functional change.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 67 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h |  1 +
 arch/x86/kernel/cpu/sgx/main.c | 29 ---------------
 3 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 6d25f7ed1294..353866e1b16f 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -595,6 +595,73 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 	return 0;
 }
 
+/**
+ * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * @encl: the enclave
+ *
+ * Some SGX functions require that no cached linear-to-physical address
+ * mappings are present before they can succeed. For example, ENCLS[EWB]
+ * copies a page from the enclave page cache to regular main memory but
+ * it fails if it cannot ensure that there are no cached
+ * linear-to-physical address mappings referring to the page.
+ *
+ * SGX hardware flushes all cached linear-to-physical mappings on a CPU
+ * when an enclave is exited via ENCLU[EEXIT] or an Asynchronous Enclave
+ * Exit (AEX). Exiting an enclave will thus ensure cached linear-to-physical
+ * address mappings are cleared but coordination with the tracking done within
+ * the SGX hardware is needed to support the SGX functions that depend on this
+ * cache clearing.
+ *
+ * When the ENCLS[ETRACK] function is issued on an enclave the hardware
+ * tracks threads operating inside the enclave at that time. The SGX
+ * hardware tracking require that all the identified threads must have
+ * exited the enclave in order to flush the mappings before a function such
+ * as ENCLS[EWB] will be permitted
+ *
+ * The following flow is used to support SGX functions that require that
+ * no cached linear-to-physical address mappings are present:
+ * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
+ * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ *    accessing the enclave.
+ * 3) Send IPI to identified CPUs, kicking them out of the enclave and
+ *    thus flushing all locally cached linear-to-physical address mappings.
+ * 4) Execute SGX function.
+ *
+ * Context: It is required to call this function after ENCLS[ETRACK].
+ *          This will ensure that if any new mm appears (racing with
+ *          sgx_encl_mm_add()) then the new mm will enter into the
+ *          enclave with fresh linear-to-physical address mappings.
+ *
+ *          It is required that all IPIs are completed before a new
+ *          ENCLS[ETRACK] is issued so be sure to protect steps 1 to 3
+ *          of the above flow with the enclave's mutex.
+ *
+ * Return: cpumask of CPUs that might be accessing @encl
+ */
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+{
+	cpumask_t *cpumask = &encl->cpumask;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	cpumask_clear(cpumask);
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
+
+		mmput_async(encl_mm->mm);
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return cpumask;
+}
+
 static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
 					      pgoff_t index)
 {
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..2b15615be8c6 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,6 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4b41efc9e367..d481e8b0e7bc 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -203,35 +203,6 @@ static void sgx_ipi_cb(void *info)
 {
 }
 
-static const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
-{
-	cpumask_t *cpumask = &encl->cpumask;
-	struct sgx_encl_mm *encl_mm;
-	int idx;
-
-	/*
-	 * Can race with sgx_encl_mm_add(), but ETRACK has already been
-	 * executed, which means that the CPUs running in the new mm will enter
-	 * into the enclave with a fresh epoch.
-	 */
-	cpumask_clear(cpumask);
-
-	idx = srcu_read_lock(&encl->srcu);
-
-	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
-		if (!mmget_not_zero(encl_mm->mm))
-			continue;
-
-		cpumask_or(cpumask, cpumask, mm_cpumask(encl_mm->mm));
-
-		mmput_async(encl_mm->mm);
-	}
-
-	srcu_read_unlock(&encl->srcu, idx);
-
-	return cpumask;
-}
-
 /*
  * Swap page to the regular memory transformed to the blocked state by using
  * EBLOCK, which means that it can no longer be referenced (no new TLB entries).
-- 
2.35.1

