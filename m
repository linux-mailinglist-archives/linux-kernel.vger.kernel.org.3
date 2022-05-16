Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF38528BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbiEPRZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbiEPRZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:25:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B29657D;
        Mon, 16 May 2022 10:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652721939; x=1684257939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SVGBrfvOhfyhUyrT6VhTTGEb7uUF3RhVTjcTNWbzSt4=;
  b=bELsbu06NckSjrTt/v1l6v30getKS5BZ4nyR9dcOeBf62hBqaaAeVEof
   +oBem//DYSiun6Cdvxx55ONtXejtrfAnlKfoigbXSQPTt1TTu5rP/Pxee
   1mGruwILgHWgeNW88CQV+aByTTx3rmGE3nnSM83Zm3R3jn2iEszc78ac2
   SxX4jjbgH43v0B30b7o/5uj/cgbmnw7Wd6srAYtqDSbJMVR4FFcszrQeE
   wT6iMg8kziUQFYgxHLBOeIOiUACk7BAB/Ix6hosA/qp60St7dt8XGWJRy
   h6qKXWMivbHW0W/A56c5e8udkVUjAtJ/AO0YXKu+ohDXlifDqyNFyzIKo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251422080"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="251422080"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:25:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="568434221"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.164.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 10:25:37 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [RFC PATCH] x86/sgx: Set active memcg prior to shmem allocation
Date:   Mon, 16 May 2022 10:25:22 -0700
Message-Id: <20220516172523.5113-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/kernel/cpu/sgx/encl.c | 89 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
 arch/x86/kernel/cpu/sgx/main.c |  4 +-
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 001808e3901c..fa017bc4f99e 100644
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
@@ -601,6 +601,91 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 	return 0;
 }
 
+static struct mem_cgroup * sgx_encl_set_active_memcg(struct sgx_encl *encl)
+{
+	struct mm_struct *mm = current->mm;
+	struct sgx_encl_mm *encl_mm;
+	struct mem_cgroup *memcg;
+	int idx;
+
+	memcg = get_mem_cgroup_from_mm(mm);
+
+	if (mm)
+		return memcg;
+
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
+	if (!mm)
+		return memcg;
+
+	memcg = get_mem_cgroup_from_mm(mm);
+
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

