Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293B591562
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiHLSSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiHLSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:18:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31EB2D96;
        Fri, 12 Aug 2022 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660328297; x=1691864297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AnWkQgwfXjxSlD6ecPc+Y9IO3Cg2lrzVcP74b57TFtE=;
  b=QLqliKXp1OimPaGgO2ttSEoztvknyGB2p8BFQy8K9xNlaYjfitgmh1e0
   Y0PXA/TSAU4wOZzN74/NfJmYs2x4UEjekFesvbvUAZ6iI/tEgjhGyBPBf
   pLEBNoZHb0bcPpS89YGH4fTClCgA/T+Zqgs1klHVXSwLkLTAWhIvmYG5F
   1/96VurLbdDcyFQQIH3fJCjkQGfn4Jz7m7xDC4dv4MU07DigDs/f2D6aO
   JQEuXkeBKzR74vgeyO3lv468zTti0T5OObU5qVwgVyVSwtNNpaNO9UfPt
   6KqubeZ17RQ1P9T/AHfZk1fdoVchqxZUSUrtdspugjleuduW/bh59TtKG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353400360"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="353400360"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 11:18:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="665919808"
Received: from mmeng-mobl2.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.209.105.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 11:18:15 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
        linux-sgx@vger.kernel.org
Subject: [PATCH v2] x86/sgx: Improve comments for sgx_encl_lookup/alloc_backing()
Date:   Fri, 12 Aug 2022 11:18:03 -0700
Message-Id: <20220812181803.567931-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Modify the comments for sgx_encl_lookup_backing() and for
sgx_encl_alloc_backing() to indicate that they take a reference
which must be dropped with a call to sgx_encl_put_backing().
Make sgx_encl_lookup_backing() static for now, and change the
name of sgx_encl_get_backing() to __sgx_encl_get_backing() to
make it more clear that sgx_encl_get_backing() is an internal
function.

Link: https://lore.kernel.org/all/YtUs3MKLzFg+rqEV@zn.tnic/

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 21 ++++++++++++++-------
 arch/x86/kernel/cpu/sgx/encl.h |  2 --
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 19876ebfb504..325c2d59e6b4 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -12,6 +12,9 @@
 #include "encls.h"
 #include "sgx.h"
 
+static int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
+			    struct sgx_backing *backing);
+
 #define PCMDS_PER_PAGE (PAGE_SIZE / sizeof(struct sgx_pcmd))
 /*
  * 32 PCMD entries share a PCMD page. PCMD_FIRST_MASK is used to
@@ -706,7 +709,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
 }
 
 /**
- * sgx_encl_get_backing() - Pin the backing storage
+ * __sgx_encl_get_backing() - Pin the backing storage
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
@@ -718,7 +721,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
  *   0 on success,
  *   -errno otherwise.
  */
-static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+static int __sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing)
 {
 	pgoff_t page_pcmd_off = sgx_encl_get_backing_page_pcmd_offset(encl, page_index);
@@ -794,7 +797,7 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
 }
 
 /**
- * sgx_encl_alloc_backing() - allocate a new backing storage page
+ * sgx_encl_alloc_backing() - create a new backing storage page
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
@@ -802,7 +805,9 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
  * When called from ksgxd, sets the active memcg from one of the
  * mms in the enclave's mm_list prior to any backing page allocation,
  * in order to ensure that shmem page allocations are charged to the
- * enclave.
+ * enclave.  Create a backing page for loading data back into an EPC page with
+ * ELDU.  This function takes a reference on a new backing page which
+ * must be dropped with a corresponding call to sgx_encl_put_backing().
  *
  * Return:
  *   0 on success,
@@ -815,7 +820,7 @@ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
 	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
 	int ret;
 
-	ret = sgx_encl_get_backing(encl, page_index, backing);
+	ret = __sgx_encl_get_backing(encl, page_index, backing);
 
 	set_active_memcg(memcg);
 	mem_cgroup_put(encl_memcg);
@@ -833,15 +838,17 @@ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
  * It is the caller's responsibility to ensure that it is appropriate to use
  * sgx_encl_lookup_backing() rather than sgx_encl_alloc_backing(). If lookup is
  * not used correctly, this will cause an allocation which is not accounted for.
+ * This function takes a reference on an existing backing page which must be
+ * dropped with a corresponding call to sgx_encl_put_backing().
  *
  * Return:
  *   0 on success,
  *   -errno otherwise.
  */
-int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
+static int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
 			   struct sgx_backing *backing)
 {
-	return sgx_encl_get_backing(encl, page_index, backing);
+	return __sgx_encl_get_backing(encl, page_index, backing);
 }
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 332ef3568267..d731ef53f815 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -106,8 +106,6 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 bool current_is_ksgxd(void);
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
-			    struct sgx_backing *backing);
 int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
 			   struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
-- 
2.36.1

