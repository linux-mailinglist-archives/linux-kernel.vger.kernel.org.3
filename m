Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C453DB05
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbiFEJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350999AbiFEJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:31:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252814E3BC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:31:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=An5K4t8/JdfG/wuC6rRXcEQ46ihUKjCegVdlZJ3R0C0=;
        b=zJCxrwivhCyv15u4Oxh8fb53JeIGruFlAlwnVIZqKsgK9u/4+1CG2ehZGJPuronNbYadPX
        SaEIF9KUCrEYChvEgZXiEi6CcVGiCY4hdserrSIaxjZFTst+Q0uXNbTnjY4VD4ZjABrJTr
        TDmHLvnnJemDD4NUL7KUGPdvMcrIyO/uMJ5T+LptnYtk8BtB+z0+kh9jiQioXFjCyU53vk
        oKDpzkSxdd6/rdJzkv8nSxDlJs3o/EOw34DwXLvF6x8wjVX5tp3s2QcFtg82OAHDS0nFfX
        DtHF1G76v637PlYSwv2iYaxfPOlMHgRceMs8rYRZQxAxf/W2Vu7mADEW1c6nnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=An5K4t8/JdfG/wuC6rRXcEQ46ihUKjCegVdlZJ3R0C0=;
        b=ZJG43wDsHkXE6AwB7RRhtSO4sSYjZb9MVZ9uZqdeb3cQaPyU2OIAlgtumRrcegxeKaAsAg
        GdEz03k2O6faVDDw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442138274.152751.10575033225299242453.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:31:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2022-=
06-05

up to:  0c9782e204d3: x86/sgx: Set active memcg prior to shmem allocation


A single fix for x86/SGX to prevent that memory which is allocated for an
SGX enclave is accounted to the wrong memory control group.


Thanks,

	tglx

------------------>
Kristen Carlson Accardi (1):
      x86/sgx: Set active memcg prior to shmem allocation


 arch/x86/kernel/cpu/sgx/encl.c | 105 +++++++++++++++++++++++++++++++++++++++=
+-
 arch/x86/kernel/cpu/sgx/encl.h |   7 ++-
 arch/x86/kernel/cpu/sgx/main.c |   9 +++-
 3 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 3c24e6124d95..19876ebfb504 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -152,7 +152,7 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_pag=
e,
=20
 	page_pcmd_off =3D sgx_encl_get_backing_page_pcmd_offset(encl, page_index);
=20
-	ret =3D sgx_encl_get_backing(encl, page_index, &b);
+	ret =3D sgx_encl_lookup_backing(encl, page_index, &b);
 	if (ret)
 		return ret;
=20
@@ -718,7 +718,7 @@ static struct page *sgx_encl_get_backing_page(struct sgx_=
encl *encl,
  *   0 on success,
  *   -errno otherwise.
  */
-int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
+static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_in=
dex,
 			 struct sgx_backing *backing)
 {
 	pgoff_t page_pcmd_off =3D sgx_encl_get_backing_page_pcmd_offset(encl, page_=
index);
@@ -743,6 +743,107 @@ int sgx_encl_get_backing(struct sgx_encl *encl, unsigne=
d long page_index,
 	return 0;
 }
=20
+/*
+ * When called from ksgxd, returns the mem_cgroup of a struct mm stored
+ * in the enclave's mm_list. When not called from ksgxd, just returns
+ * the mem_cgroup of the current task.
+ */
+static struct mem_cgroup *sgx_encl_get_mem_cgroup(struct sgx_encl *encl)
+{
+	struct mem_cgroup *memcg =3D NULL;
+	struct sgx_encl_mm *encl_mm;
+	int idx;
+
+	/*
+	 * If called from normal task context, return the mem_cgroup
+	 * of the current task's mm. The remainder of the handling is for
+	 * ksgxd.
+	 */
+	if (!current_is_ksgxd())
+		return get_mem_cgroup_from_mm(current->mm);
+
+	/*
+	 * Search the enclave's mm_list to find an mm associated with
+	 * this enclave to charge the allocation to.
+	 */
+	idx =3D srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(encl_mm, &encl->mm_list, list) {
+		if (!mmget_not_zero(encl_mm->mm))
+			continue;
+
+		memcg =3D get_mem_cgroup_from_mm(encl_mm->mm);
+
+		mmput_async(encl_mm->mm);
+
+		break;
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	/*
+	 * In the rare case that there isn't an mm associated with
+	 * the enclave, set memcg to the current active mem_cgroup.
+	 * This will be the root mem_cgroup if there is no active
+	 * mem_cgroup.
+	 */
+	if (!memcg)
+		return get_mem_cgroup_from_mm(NULL);
+
+	return memcg;
+}
+
+/**
+ * sgx_encl_alloc_backing() - allocate a new backing storage page
+ * @encl:	an enclave pointer
+ * @page_index:	enclave page index
+ * @backing:	data for accessing backing storage for the page
+ *
+ * When called from ksgxd, sets the active memcg from one of the
+ * mms in the enclave's mm_list prior to any backing page allocation,
+ * in order to ensure that shmem page allocations are charged to the
+ * enclave.
+ *
+ * Return:
+ *   0 on success,
+ *   -errno otherwise.
+ */
+int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
+			   struct sgx_backing *backing)
+{
+	struct mem_cgroup *encl_memcg =3D sgx_encl_get_mem_cgroup(encl);
+	struct mem_cgroup *memcg =3D set_active_memcg(encl_memcg);
+	int ret;
+
+	ret =3D sgx_encl_get_backing(encl, page_index, backing);
+
+	set_active_memcg(memcg);
+	mem_cgroup_put(encl_memcg);
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
+ * sgx_encl_lookup_backing() rather than sgx_encl_alloc_backing(). If lookup=
 is
+ * not used correctly, this will cause an allocation which is not accounted =
for.
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
index d44e7372151f..332ef3568267 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -103,10 +103,13 @@ static inline int sgx_encl_find(struct mm_struct *mm, u=
nsigned long addr,
 int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 		     unsigned long end, unsigned long vm_flags);
=20
+bool current_is_ksgxd(void);
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
-			 struct sgx_backing *backing);
+int sgx_encl_lookup_backing(struct sgx_encl *encl, unsigned long page_index,
+			    struct sgx_backing *backing);
+int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
+			   struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ab4ec54bbdd9..a78652d43e61 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -313,7 +313,7 @@ static void sgx_reclaimer_write(struct sgx_epc_page *epc_=
page,
 	sgx_encl_put_backing(backing);
=20
 	if (!encl->secs_child_cnt && test_bit(SGX_ENCL_INITIALIZED, &encl->flags)) {
-		ret =3D sgx_encl_get_backing(encl, PFN_DOWN(encl->size),
+		ret =3D sgx_encl_alloc_backing(encl, PFN_DOWN(encl->size),
 					   &secs_backing);
 		if (ret)
 			goto out;
@@ -384,7 +384,7 @@ static void sgx_reclaim_pages(void)
 		page_index =3D PFN_DOWN(encl_page->desc - encl_page->encl->base);
=20
 		mutex_lock(&encl_page->encl->lock);
-		ret =3D sgx_encl_get_backing(encl_page->encl, page_index, &backing[i]);
+		ret =3D sgx_encl_alloc_backing(encl_page->encl, page_index, &backing[i]);
 		if (ret) {
 			mutex_unlock(&encl_page->encl->lock);
 			goto skip;
@@ -475,6 +475,11 @@ static bool __init sgx_page_reclaimer_init(void)
 	return true;
 }
=20
+bool current_is_ksgxd(void)
+{
+	return current =3D=3D ksgxd_tsk;
+}
+
 static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 {
 	struct sgx_numa_node *node =3D &sgx_numa_nodes[nid];

