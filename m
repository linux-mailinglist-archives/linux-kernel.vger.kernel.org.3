Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A554D91EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbiCOBEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiCOBD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:03:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077DBCA9;
        Mon, 14 Mar 2022 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306166; x=1678842166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=l+yH9nBz4V3uz+TKWynE71jSMITSSmD5RuCSKkIUr3c=;
  b=HQAl5Cabe6CTBCuMexGqdfpqi0fEK1Yjo/Kp+PdsN1itTvRHqwshEZfi
   sHOUK4Avn7P1jjxYu7X5aeGkZJz/ru7jAAv4rRDr+IgmDlEFu6GopTue6
   X46nIPgW1ry0ITQ6ttjtQaRG/kTdXsJ2XA+U1faoPQDU02j1eNgBnHD1X
   fuNke19o2vBtpH4BDCGH0QTtC1b5oq16KB3fXEkdtfFPo9SMH6npxOAnu
   VGLicdyN14VzgDA3Eq8P6ELT/WGAdaH4HpWAagT/y2Hq5/sp+I/0iFSly
   z9eFkTLp4b3sXLj59UAd7SBvsiCpZev7VH3Q+9XmWoWJD1UeH6tMcwRiz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912365"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912365"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669345"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:42 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 06/10] x86/sgx: Forced EPC page zapping for EUPDATESVN
Date:   Tue, 15 Mar 2022 09:02:56 +0800
Message-Id: <20220315010300.10199-7-cathy.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315010300.10199-1-cathy.zhang@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before an EUPDATESVN instruction can be successful, all enclave
pages (EPC) must be marked as unused in the SGX hardware
metadata (EPCM).

A page becomes unused when an issued EREMOVE instruction succeeds.
To prepare for EUPDATESVN, loop over all SGX pages and attempt
to EREMOVE them. This is fatal to running enclaves and destroys
all enclave state and memory contents. This destruction is by
design and mitigates any compromise of enclaves or the SGX
hardware itself which occurred before the microcode update.

An EREMOVE operation on a page may fail for a few reasons. Each
has its own mitigations.

First, EREMOVE will fail if an enclave that uses the page is
executing. Send an IPI to all CPUs that might be running the
enclave to force it out of the enclave long enough to EREMOVE
the page. Other CPUs might enter the enclave in the meantime,
so this is not a rock-solid guarantee.

Second, EREMOVE can fail on special SGX metadata pages, such as
SECS and VA. EREMOVE will work on them only after the normal SGX
pages that depend on them have been EREMOVE'd. Defer handling those
pages and repeat EREMOVE after the dependency has been addressed.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
---
 arch/x86/kernel/cpu/sgx/sgx.h  |  13 ++
 arch/x86/kernel/cpu/sgx/encl.c |  14 +-
 arch/x86/kernel/cpu/sgx/main.c | 347 +++++++++++++++++++++++++++++++++
 3 files changed, 373 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 8fa0f9c64a13..192c6a56ecf0 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -32,6 +32,17 @@
 #define SGX_EPC_PAGE_VA			BIT(2)
 /* Pages allocated for KVM guest */
 #define SGX_EPC_PAGE_GUEST		BIT(3)
+/*
+ * Pages, failed to be zapped (EREMOVED)
+ * by SGX CPUSVN update process.
+ */
+#define SGX_EPC_PAGE_ZAP_TRACKED	BIT(4)
+/*
+ * Pages, the associated enclave is being
+ * released while SGX CPUSVN update is
+ * running.
+ */
+#define SGX_EPC_PAGE_IN_RELEASE		BIT(5)
 
 struct sgx_epc_page {
 	unsigned int section;
@@ -111,5 +122,7 @@ void sgx_update_lepubkeyhash(u64 *lepubkeyhash);
 
 extern struct srcu_struct sgx_lock_epc_srcu;
 bool sgx_epc_is_locked(void);
+void sgx_zap_wakeup(void);
+void sgx_zap_abort(void);
 
 #endif /* _X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index a78428aa4465..68e8985bcc31 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -651,6 +651,12 @@ void sgx_encl_release(struct kref *ref)
 	WARN_ON_ONCE(encl->secs_child_cnt);
 	WARN_ON_ONCE(encl->secs.epc_page);
 
+	/*
+	 * EPC pages were freed and EREMOVE was executed. Wake
+	 * up any zappers which were waiting for this.
+	 */
+	sgx_zap_wakeup();
+
 	kfree(encl);
 }
 
@@ -1077,8 +1083,14 @@ void sgx_encl_free_epc_page(struct sgx_epc_page *page)
 	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
 
 	ret = __eremove(sgx_get_epc_virt_addr(page));
-	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
+	if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret)) {
+		/*
+		 * The EREMOVE failed. If a CPUSVN is in progress,
+		 * it is now expected to fail. Notify it.
+		 */
+		sgx_zap_abort();
 		return;
+	}
 
 	sgx_free_epc_page(page);
 }
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index c9331f6ba034..f3dd3757ef9f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -34,6 +34,16 @@ static bool __rcu sgx_epc_locked;
  * will be prevented from starting during an SVN update.
  */
 DEFINE_SRCU(sgx_lock_epc_srcu);
+static DECLARE_WAIT_QUEUE_HEAD(sgx_zap_waitq);
+
+/* The flag means to abort the SGX CPUSVN update process */
+static bool sgx_zap_abort_wait;
+/*
+ * Track the number of SECS and VA pages associated with enclaves
+ * in releasing. SGX CPUSVN update will wait for them EREMOVEd by
+ * enclave exiting process.
+ */
+static atomic_t zap_waiting_count;
 
 /*
  * These variables are part of the state of the reclaimer, and must be accessed
@@ -607,6 +617,24 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	spin_lock(&node->lock);
 
+	/*
+	 * The page is EREMOVEd, stop tracking it
+	 * as a deferred target for CPUSVN update
+	 * process.
+	 */
+	if ((page->flags & SGX_EPC_PAGE_ZAP_TRACKED) &&
+	    (!list_empty(&page->list)))
+		list_del(&page->list);
+
+	/*
+	 * The page is EREMOVEd, decrease
+	 * "zap_waiting_count" to stop counting it
+	 * as a waiting target for CPUSVN update
+	 * process.
+	 */
+	if (page->flags & SGX_EPC_PAGE_IN_RELEASE)
+		atomic_dec_if_positive(&zap_waiting_count);
+
 	page->owner = NULL;
 	if (page->poison)
 		list_add(&page->list, &node->sgx_poison_page_list);
@@ -981,3 +1009,322 @@ bool sgx_epc_is_locked(void)
 	lockdep_assert_held(&sgx_lock_epc_srcu);
 	return sgx_epc_locked;
 }
+
+/**
+ * sgx_zap_encl_page - unuse one EPC page
+ * @section:		EPC section
+ * @epc_page:		EPC page
+ * @secs_pages_list:	list to trac SECS pages failed to be EREMOVEd
+ *
+ * Zap an EPC page if it's used by an enclave.
+ *
+ * Returns:
+ * 0:			EPC page is unused or EREMOVE succeeds.
+ * -EBUSY:		EREMOVE failed for other threads executing
+ *			in enclave.
+ * -EIO:		Other EREMOVE failures, like EPC leaks.
+ */
+static int sgx_zap_encl_page(struct sgx_epc_section *section,
+			     struct sgx_epc_page *epc_page,
+			     struct list_head *secs_pages_list)
+{
+	struct sgx_encl *encl;
+	struct sgx_encl_page *encl_page;
+	struct sgx_va_page *va_page;
+	int retry_count = 10;
+	int ret;
+
+	/*
+	 * Holding the per-section lock to ensure the
+	 * "owner" field will not be cleared while
+	 * checking.
+	 */
+	spin_lock(&section->node->lock);
+
+	/*
+	 * The "owner" field is NULL, it means the page
+	 * is unused.
+	 */
+	if (!epc_page->owner) {
+		spin_unlock(&section->node->lock);
+		return 0;
+	}
+
+	if (epc_page->flags & SGX_EPC_PAGE_VA) {
+		va_page = epc_page->owner;
+		encl = va_page->encl;
+	} else {
+		encl_page = epc_page->owner;
+		encl = encl_page->encl;
+	}
+
+	if (!encl) {
+		spin_unlock(&section->node->lock);
+		/*
+		 * The page has owner, but without an Enclave
+		 * associated with. This might be caused by
+		 * EPC leaks happen in enclave's release path.
+		 */
+		ret = __eremove(sgx_get_epc_virt_addr(epc_page));
+		if (WARN_ONCE(ret, EREMOVE_ERROR_MESSAGE, ret, ret))
+			ret = -EIO;
+		else
+			sgx_free_epc_page(epc_page);
+		return ret;
+	}
+
+	/*
+	 * Wait for any enclave already being released to complete
+	 * but prevent any additional enclave from starting release
+	 * while we operate on it.
+	 */
+	if (!kref_get_unless_zero(&encl->refcount)) {
+
+		/*
+		 * The enclave is exiting. The EUPDATESVN
+		 * procedure needs to wait for the EREMOVE
+		 * operation which happens as a part of
+		 * the enclave exit operation. Use
+		 * "zap_waiting_count" to indicate to the
+		 * EUPDATESVN code when it needs to wait.
+		 */
+		if (((epc_page->flags & SGX_EPC_PAGE_VA) ||
+		     (encl_page->type == SGX_PAGE_TYPE_SECS)) &&
+		    !(epc_page->flags & SGX_EPC_PAGE_IN_RELEASE)) {
+			atomic_inc(&zap_waiting_count);
+			epc_page->flags |= SGX_EPC_PAGE_IN_RELEASE;
+		}
+
+		spin_unlock(&section->node->lock);
+		return 0;
+	}
+
+	spin_unlock(&section->node->lock);
+
+	/*
+	 * This EREMOVE has two main purposes:
+	 * 1. Getting EPC pages into the "unused" state.
+	 *    Every EPC page must be unused before an
+	 *    EUPDATESVN can be succeed.
+	 * 2. Forcing enclaves to exit more frequently.
+	 *    EREMOVE will not succeed while any thread is
+	 *    running in the enclave. Every successful
+	 *    EREMOVE increases the chance that an enclave
+	 *    will trip over this page, fault, and exit.
+	 *    This, in turn, increases the likelihood of
+	 *    success for every future EREMOVE attempt.
+	 */
+	ret = __eremove(sgx_get_epc_virt_addr(epc_page));
+
+	if (!ret) {
+		/*
+		 * The SECS page is EREMOVEd successfully this time.
+		 * Remove it from the list to stop tracking it.
+		 */
+		if ((epc_page->flags & SGX_EPC_PAGE_ZAP_TRACKED) &&
+		    !list_empty(&epc_page->list)) {
+			list_del_init(&epc_page->list);
+			epc_page->flags &= ~SGX_EPC_PAGE_ZAP_TRACKED;
+		}
+		goto out;
+	}
+
+	if (ret == SGX_CHILD_PRESENT) {
+		/*
+		 * The SECS page is failed to be EREMOVEd due
+		 * to associations. Add it to "secs_pages_list"
+		 * for deferred handling.
+		 */
+		if (!(epc_page->flags & SGX_EPC_PAGE_ZAP_TRACKED) &&
+		    secs_pages_list) {
+			epc_page->flags |= SGX_EPC_PAGE_ZAP_TRACKED;
+			list_add_tail(&epc_page->list, secs_pages_list);
+		}
+		ret = 0;
+		goto out;
+	}
+
+	if (ret) {
+		/*
+		 * EREMOVE will fail on a page if the owning
+		 * enclave is executing. An IPI will cause the
+		 * enclave to exit, providing an opportunity to
+		 * EREMOVE the page, but it does not guarantee
+		 * the page will be EREMOVEd successfully. Retry
+		 * for several times, if it keeps on failing,
+		 * return -EBUSY to notify userspace for retry.
+		 */
+		do {
+			on_each_cpu_mask(sgx_encl_cpumask(encl), sgx_ipi_cb, NULL, true);
+			ret = __eremove(sgx_get_epc_virt_addr(epc_page));
+			if (!ret)
+				break;
+			retry_count--;
+		} while (retry_count);
+
+		if (ret)
+			ret = -EBUSY;
+	}
+
+out:
+	kref_put(&encl->refcount, sgx_encl_release);
+	return ret;
+}
+
+/**
+ * sgx_zap_section_pages - unuse one EPC section's pages
+ * @section:		EPC section
+ * @secs_pages_list:	list to track SECS pages failed to be EREMOVEd
+ *
+ * Iterate through pages in one EPC section, unuse the pages
+ * initialized for enclaves on bare metal.
+ *
+ * TODO: EPC pages for KVM guest will be handled in future.
+ *
+ * Returns:
+ * 0:			EPC page is unused.
+ * -EBUSY:		EREMOVE failed for other threads executing
+ *			in enclave.
+ * -EIO:		Other EREMOVE failures, like EPC leaks.
+ */
+static int sgx_zap_section_pages(struct sgx_epc_section *section,
+				 struct list_head *secs_pages_list)
+{
+	struct sgx_epc_page *epc_page;
+	int i, ret;
+	unsigned long nr_pages = section->size >> PAGE_SHIFT;
+
+	for (i = 0; i < nr_pages; i++) {
+		epc_page = &section->pages[i];
+
+		/*
+		 * EPC page has "NULL" owner, indicating
+		 * it's unused. No action required for
+		 * this case.
+		 *
+		 * No new owner can be assigned when SGX
+		 * is "frozen".
+		 */
+		if (!epc_page->owner)
+			continue;
+
+		/*
+		 * Try to "unuse" all SGX memory used by enclaves
+		 * on bare-metal.
+		 *
+		 * Failures might be caused by the following reasons:
+		 * 1. EREMOVE failure due to other threads executing
+		 *    in enclave. Return -EBUSY to notify userspace
+		 *    for a later retry.
+		 * 2. Other EREMOVE failures. For example, a bug in
+		 *    SGX memory management like a leak that lost
+		 *    track of an SGX EPC page. Upon these failures,
+		 *    do not even attempt EUPDATESVN.
+		 */
+		if (!(epc_page->flags & SGX_EPC_PAGE_GUEST)) {
+			ret = sgx_zap_encl_page(section, epc_page, secs_pages_list);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * sgx_zap_pages - unuse all EPC sections' pages
+ *
+ * Context: This function is called while microcode_mutex lock
+ *	    is held by the caller, it ensures that the update
+ *	    process will not run concurrently.
+ *
+ * Returns:
+ * 0:			All enclaves have been torn down and
+ *			all EPC pages are unused.
+ * -ERESTARTSYS:	Interrupted by a signal.
+ * -EBUSY:		EREMOVE failed for other threads executing
+ *			in enclave.
+ * -EIO:		Other EREMOVE failures, like EPC leaks.
+ */
+static int sgx_zap_pages(void)
+{
+	struct sgx_epc_page *epc_page, *tmp;
+	struct sgx_epc_section *section;
+	int i, ret;
+
+	LIST_HEAD(secs_pages_list);
+
+	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
+		section = &sgx_epc_sections[i];
+		if (!section->pages)
+			break;
+		/*
+		 * Go through the section's pages and try to EREMOVE
+		 * each one, except the ones associated with enclaves
+		 * in releasing.
+		 */
+		ret = sgx_zap_section_pages(section, &secs_pages_list);
+		if (WARN_ON_ONCE(ret))
+			goto out;
+	}
+
+	/*
+	 * The SECS page should have no associations now, try
+	 * EREMOVE them again.
+	 */
+	list_for_each_entry_safe(epc_page, tmp, &secs_pages_list, list) {
+		section = &sgx_epc_sections[epc_page->section];
+		ret = sgx_zap_encl_page(section, epc_page, NULL);
+		if (ret)
+			goto out;
+	}
+
+	/*
+	 * There might be pages in the process of being freed
+	 * by exiting enclaves. Wait for the exiting process
+	 * to succeed or fail.
+	 */
+	ret = wait_event_interruptible(sgx_zap_waitq,
+				       (!atomic_read(&zap_waiting_count) ||
+					sgx_zap_abort_wait));
+	if (ret == -ERESTARTSYS) {
+		pr_err("CPUSVN update is not finished yet, but killed by userspace\n");
+		goto out;
+	}
+
+	if (sgx_zap_abort_wait) {
+		ret = -EIO;
+		pr_err("exit-side EREMOVE failure. Aborting CPUSVN update\n");
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
+/**
+ * sgx_zap_wakeup - wake up CPUSVN update process
+ *
+ * Whenever enclave is freed, this function will
+ * be called to check if all EPC pages are unused.
+ * Wake up the CPUSVN update process if it's true.
+ */
+void sgx_zap_wakeup(void)
+{
+	if (wq_has_sleeper(&sgx_zap_waitq) &&
+	    !atomic_read(&zap_waiting_count))
+		wake_up(&sgx_zap_waitq);
+}
+
+/**
+ * sgx_zap_abort - abort SGX CPUSVN update process
+ *
+ * When EPC leaks happen in enclave release process,
+ * it will set flag sgx_zap_abort_wait as true to
+ * abort the CPUSVN update process.
+ */
+void sgx_zap_abort(void)
+{
+	sgx_zap_abort_wait = true;
+	wake_up(&sgx_zap_waitq);
+}
-- 
2.17.1

