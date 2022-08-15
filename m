Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8F592D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbiHOKAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHOJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:59:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295301C925;
        Mon, 15 Aug 2022 02:59:55 -0700 (PDT)
Date:   Mon, 15 Aug 2022 09:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660557593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YcBUGkPx3cH/NvA+TkTcMHErs+1CHPFnwBGurxjWnkQ=;
        b=VckFzlKpSOZ+j9cB3OAd2hM96/iNnqhp5ExClXPWWtVI/C6DgN/ChOiT7VtuQ2UsowDa5Z
        asbRAsyWSk/JMw7kTa/XhS88OZtNTiO0/7TtcsqLWmxbrglZuLTQjUqDx+Ky7VRnMgGEw3
        MJIv9fTAcSdeXXbyiNpmJMdGOUgvzzUJaKzS1pMKolK9Fs9e6cvCTy7Oqm15zkatOqurUr
        lXEIbODS8O3pidSMuKZ3da3VQGzkiH4m5T8L5LUdg3nY91/pPO9/oMSufQzN8zjRNCNdsW
        L/znuB3Dth4vYlIX2ljrY1tCqJjSDDL1ao1ZG92KJTSX1xES+kHcda8IkUiGOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660557593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YcBUGkPx3cH/NvA+TkTcMHErs+1CHPFnwBGurxjWnkQ=;
        b=0yIHA3rfzf9uA64BNBCI85zgB68F7Clwhk/nZlOxnhzPTnEGYmCuUm91kBIXuzgtxMRcF+
        ORcy5L3imQQEcsBQ==
From:   "tip-bot2 for Kristen Carlson Accardi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Improve comments for sgx_encl_lookup/alloc_backing()
Cc:     Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166055759122.401.9256958583708582242.tip-bot2@tip-bot2>
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

Commit-ID:     ee56a283988d739c25d2d00ffb22707cb487ab47
Gitweb:        https://git.kernel.org/tip/ee56a283988d739c25d2d00ffb22707cb487ab47
Author:        Kristen Carlson Accardi <kristen.c.accardi@intel.com>
AuthorDate:    Fri, 12 Aug 2022 11:18:03 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Aug 2022 11:51:49 +02:00

x86/sgx: Improve comments for sgx_encl_lookup/alloc_backing()

Modify the comments for sgx_encl_lookup_backing() and for
sgx_encl_alloc_backing() to indicate that they take a reference
which must be dropped with a call to sgx_encl_put_backing().
Make sgx_encl_lookup_backing() static for now, and change the
name of sgx_encl_get_backing() to __sgx_encl_get_backing() to
make it more clear that sgx_encl_get_backing() is an internal
function.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/all/YtUs3MKLzFg+rqEV@zn.tnic/
---
 arch/x86/kernel/cpu/sgx/encl.c | 21 ++++++++++++++-------
 arch/x86/kernel/cpu/sgx/encl.h |  2 --
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 24c1bb8..f40d642 100644
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
@@ -914,7 +917,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
 }
 
 /**
- * sgx_encl_get_backing() - Pin the backing storage
+ * __sgx_encl_get_backing() - Pin the backing storage
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
@@ -926,7 +929,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_encl *encl,
  *   0 on success,
  *   -errno otherwise.
  */
-static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+static int __sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing)
 {
 	pgoff_t page_pcmd_off = sgx_encl_get_backing_page_pcmd_offset(encl, page_index);
@@ -1001,7 +1004,7 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
 }
 
 /**
- * sgx_encl_alloc_backing() - allocate a new backing storage page
+ * sgx_encl_alloc_backing() - create a new backing storage page
  * @encl:	an enclave pointer
  * @page_index:	enclave page index
  * @backing:	data for accessing backing storage for the page
@@ -1009,7 +1012,9 @@ static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
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
@@ -1022,7 +1027,7 @@ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
 	struct mem_cgroup *memcg = set_active_memcg(encl_memcg);
 	int ret;
 
-	ret = sgx_encl_get_backing(encl, page_index, backing);
+	ret = __sgx_encl_get_backing(encl, page_index, backing);
 
 	set_active_memcg(memcg);
 	mem_cgroup_put(encl_memcg);
@@ -1040,15 +1045,17 @@ int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
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
index a65a952..f94ff14 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -107,8 +107,6 @@ bool current_is_ksgxd(void);
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
 const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
-int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
-			    struct sgx_backing *backing);
 int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
 			   struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
