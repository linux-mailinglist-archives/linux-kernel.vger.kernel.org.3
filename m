Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B791C52A888
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351163AbiEQQrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351171AbiEQQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:47:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D94EF50;
        Tue, 17 May 2022 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652806048; x=1684342048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pFrlG/jLKFzpLJVweZ20xehKFD4QV202aDt+sp57KbM=;
  b=l2l+0rpBC3zh41v7SF7eZaug8bH4L2uavegy+tMCXgPVdAJ9luoruMPy
   KmUVsIqLzUe5O+pZtX0oosmb2kApgl05umgog+ZPwfPs34KnV35oSnism
   fmMJPbZDnfYTnzJtbjqX9tMYTzY3A7vwA4ItBdfsRtPFbE/TZsM17gvD3
   ITf2EzheC/X1hFI2aoOxDpHMdeiAZU6iMXsf9v4o7MG+31AnBjAjtGeUJ
   hY6ii/5C6tAlHg89Z9MYfR1c4zic+PicquQBCsb+U5af8fjhkoNIBgJT2
   /SEk25qks4q3p2BhcIE2PkQyAAyzEPuHHOiJEV/tDfHZSKJhBPO2Hr/Zg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="253295374"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="253295374"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:47:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="816980699"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.37.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:47:26 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] x86/sgx: Set active memcg prior to shmem allocation
Date:   Tue, 17 May 2022 09:47:13 -0700
Message-Id: <20220517164713.4610-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system runs out of enclave memory, SGX can reclaim EPC pages
by swapping to normal RAM. These backing pages are allocated via a
per-enclave shared memory area. Since SGX allows unlimited over
commit on EPC memory, the reclaimer thread can allocate a large
number of backing RAM pages in response to EPC memory pressure.

When the shared memory backing RAM allocation occurs during
the reclaimer thread context, the shared memory is charged to
the root memory control group, and the shmem usage of the enclave
is not properly accounted for, making cgroups ineffective at
limiting the amount of RAM an enclave can consume.

For example, when using a cgroup to launch a set of test
enclaves, the kernel does not properly account for 50% - 75% of
shmem page allocations on average. In the worst case, when
nearly all allocations occur during the reclaimer thread, the
kernel accounts less than a percent of the amount of shmem used
by the enclave's cgroup to the correct cgroup.

SGX currently stores a list of mm_structs that are associated with
an enclave. In order to allow the enclave's cgroup to more accurately
reflect the shmem usage, the memory control group (struct mem_cgroup)
of one of these mm_structs can be set as the active memory cgroup
prior to allocating any EPC backing pages. This will make any shmem
allocations be charged to a memory control group associated with the
enclave's cgroup. This will allow memory cgroup limits to restrict
RAM usage more effectively.

This patch will create a new function - sgx_encl_alloc_backing().
This function will be used whenever a new backing storage page
needs to be allocated. Previously the same function was used for
page allocation as well as retrieving a previously allocated page.
Prior to backing page allocation, if there is a mm_struct associated
with the enclave that is requesting the allocation, it will be set
as the active memory control group.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 111 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |   6 +-
 arch/x86/kernel/cpu/sgx/main.c |   4 +-
 3 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 001808e3901c..c3a5e57040bc 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -32,7 +32,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	else
 		page_index = PFN_DOWN(encl->size);
 
-	ret = sgx_encl_get_backing(encl, page_index, &b);
+	ret = sgx_encl_lookup_backing(encl, page_index, &b);
 	if (ret)
 		return ret;
 
@@ -574,7 +574,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
  *   0 on success,
  *   -errno otherwise.
  */
-int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing)
 {
 	pgoff_t pcmd_index = PFN_DOWN(encl->size) + 1 + (page_index >> 5);
@@ -601,6 +601,113 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 	return 0;
 }
 
+static struct mem_cgroup * sgx_encl_set_active_memcg(struct sgx_encl *encl)
+{
+	struct mm_struct *mm = current->mm;
+	struct sgx_encl_mm *encl_mm;
+	struct mem_cgroup *memcg;
+	int idx;
+
+	/*
+	 * If current->mm is NULL, get_mem_cgroup_from_mm() will return
+	 * the currently active mem_cgroup. This may be the root mem_cgroup
+	 * if there is no active mem_cgroup set.
+	 */
+	memcg = get_mem_cgroup_from_mm(mm);
+
+	/*
+	 * If we already have an mm, we are not in thread context and the
+	 * mem_cgroup for the enclave will be charged for any allocations.
+	 */
+	if (mm)
+		return memcg;
+
+	/*
+	 * If there is no mm, it means that we are in thread context,
+	 * and any backing RAM allocations would be charged to the root
+	 * mem_cgroup unless the active mem_cgroup is set. Search the
+	 * enclave's mm_list to find any mm associated with this enclave.
+	 */
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (encl_mm->mm == NULL)
+			continue;
+
+		mm = encl_mm->mm;
+		break;
+
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	/*
+	 * If an associated mm was not found, the allocation will just
+	 * need to be charged to the root mem_cgroup.
+	 */
+	if (!mm)
+		return memcg;
+
+	memcg = get_mem_cgroup_from_mm(mm);
+
+	/*
+	 * set_active_memcg() returns the previous active memcg.
+	 */
+	return set_active_memcg(memcg);
+}
+
+/**
+ * sgx_encl_alloc_backing() - allocate a new backing storage page
+ * @encl:	an enclave pointer
+ * @page_index:	enclave page index
+ * @backing:	data for accessing backing storage for the page
+ *
+ * If this function is called from the kernel thread, it will set
+ * the active memcg to one of the enclaves mm's in order to ensure
+ * that shmem page allocations are charged to the enclave when they
+ * are retrieved. Upon exit, the old memcg (if it existed at all)
+ * will be restored.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno otherwise.
+ */
+int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
+			   struct sgx_backing *backing)
+{
+	struct mem_cgroup *old_memcg;
+	int ret;
+
+	old_memcg = sgx_encl_set_active_memcg(encl);
+
+	ret = sgx_encl_get_backing(encl, page_index, backing);
+
+	set_active_memcg(old_memcg);
+
+	return ret;
+}
+
+/**
+ * sgx_encl_lookup_backing() - retrieve an existing backing storage page
+ * @encl:	an enclave pointer
+ * @page_index:	enclave page index
+ * @backing:	data for accessing backing storage for the page
+ *
+ * Retrieve a backing page for loading data back into an EPC page with ELDU.
+ * It is the caller's responsibility to ensure that it is appropriate to use
+ * sgx_encl_lookup_backing() rather than sgx_encl_alloc_backing(). If lookup is
+ * not used correctly, this will cause an allocation which is not accounted for.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno otherwise.
+ */
+int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
+			   struct sgx_backing *backing)
+{
+	return sgx_encl_get_backing(encl, page_index, backing);
+}
+
 /**
  * sgx_encl_put_backing() - Unpin the backing storage
  * @backing:	data for accessing backing storage for the page
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..7816cfe8f832 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,8 +105,10 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
-			 struct sgx_backing *backing);
+int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
+			    struct sgx_backing *backing);
+int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
+			   struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 4b41efc9e367..7d41c8538795 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -310,7 +310,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_page,
 	encl->secs_child_cnt--;
 
 	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
-		ret = sgx_encl_get_backing(encl, PFN_DOWN(encl->size),
+		ret = sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
 					   &secs_backing);
 		if (ret)
 			goto out;
@@ -381,7 +381,7 @@ static void sgx_reclaim_pages(void)
 			goto skip;
 
 		page_index = PFN_DOWN(encl_page->desc - encl_page->encl->base);
-		ret = sgx_encl_get_backing(encl_page->encl, page_index, &backing[i]);
+		ret = sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
 		if (ret)
 			goto skip;
 
-- 
2.20.1

