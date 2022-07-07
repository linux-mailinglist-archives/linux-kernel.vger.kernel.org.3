Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C06456AAB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiGGS3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiGGS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327935C9F6;
        Thu,  7 Jul 2022 11:27:55 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/EC0+ttTLb5H5RDb6DP0fnWWqIhKj58Ky8eU3SvlxzM=;
        b=BzMIw5DUo4NfnVFY9egtkioaFhzOcDZ2KtXJY40G47Jqlw+Gysgn3cjDi62t0KPUGFN3f8
        ZIUrZmxJUppuNRwcHObRUwD3IiPRMNn0Hk8UyHY6/5n5zCKCKFYCoK6Z1TSI3qlvEFtsI6
        V/dCjbhS/me/9+884T6kKgPHe2iWn7p+198e1qXTRg8ch2TPW7x86oR6sKFAu0+3hwMJM/
        UeuFD6807tkWJhTFK0s0P4A0TB9ZbJzj94H/PpaFrdDsJcHWsUR5mKOvTmUslMjB+Yvv81
        M5qwDUXZYMZ9s8pxWQXJ2r8GPw0+DlmfQCag6s3HRaB6FqL1dstPlpkHyLMEnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/EC0+ttTLb5H5RDb6DP0fnWWqIhKj58Ky8eU3SvlxzM=;
        b=yqbmhrUOUZ+SmD01GLs61DVPOCN6s6HLE5xB1KugxpUy0ROSbvPxrT9YwM4iDvpX//UDnP
        TR8zgPyVO1FvPBCQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Export sgx_encl_ewb_cpumask()
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C05b60747fd45130cf9fc6edb1c373a69a18a22c5=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C05b60747fd45130cf9fc6edb1c373a69a18a22c5=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847246.15455.2659475596375801755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     7f391752d4adac10cfc1e5d7a76bab0ab5c9c9d4
Gitweb:        https://git.kernel.org/tip/7f391752d4adac10cfc1e5d7a76bab0ab5c9c9d4
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:42 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:01 -07:00

x86/sgx: Export sgx_encl_ewb_cpumask()

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/05b60747fd45130cf9fc6edb1c373a69a18a22c5.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encl.c | 67 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |  1 +-
 arch/x86/kernel/cpu/sgx/main.c | 29 +--------------
 3 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 7ad8b47..6953d33 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -714,6 +714,73 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
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
index 522a17e..c6afa58 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,6 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ab4ec54..2a92627 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -205,35 +205,6 @@ static void sgx_ipi_cb(void *info)
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
