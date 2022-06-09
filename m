Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF34C54436B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiFIF5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiFIF5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:57:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862222ED51;
        Wed,  8 Jun 2022 22:57:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y187so20933875pgd.3;
        Wed, 08 Jun 2022 22:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0j00m2X6T/5xgVeW9xL8vXTopWoHv2mPnZPACxJ5WY=;
        b=J39mbzfcia1l9D7OkCj+IaO3AyqpA4/LeiM/EJO406vRR7GxJwvy0l3y+/hyNB2CIx
         h0YV4k/b9J48rasqWq19wINl6Kdvg1j5kDQ0Ka7VyjYWWIxhq61ZdJv3qwSHNIewtFt1
         VF0yUcwCCkEJ6p67siJgXSn4oGvBx18duiWqE/R/Izw4/6fZBZUS2V/K2hVsl+TwM8Ob
         pW/t/nje5WMUvZBuf/f+xXWTYI+yFD9L7YXM9XFXeFahB6QNKZ2to1yTzzG3B6mgDD9X
         +u5nnUHeMPQrPd1fpvbrf6/WBWnuCMWk4OE1CwnedYVLCBrDxcCdgQxm164zZWppaBLL
         51uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j0j00m2X6T/5xgVeW9xL8vXTopWoHv2mPnZPACxJ5WY=;
        b=1OoR8HS9IOoS/13ws7F1hZQmXqHalGn6yuwgEqHcotXpux6TLjsKBqAcxhW5PNIKcq
         hljMpCAmKPVXMz2Lge4ZDPH9ekYPAWZvLi9yq3J8wsZuMeR4aI2Gk4CUfRhHtp/zOWwF
         ICyZkybNlVeIvAsc4BsXQii0IjhP6n0T8gmxG1TxRWvG4gI6RAiYzpDExd8T6/bH6KxW
         2zIqFy+Wtmh4K+hV4UdC4mmWdLduPm5JL5NJNqjje/kpU5Ra0Dv+txp/smNXg2/Z4RGy
         JbSu7QB6xsL2A08VeHQjBOdjhce43CZ7Jpw6bwNNflh2tA1S8m/RywI6fYSUBtwYAxIW
         yRew==
X-Gm-Message-State: AOAM530tbNGOBioSta82wHv09IXK8Jmpvz3r+ymIEvgH8WleX2ztvrr2
        mmcfvlXJWj72mhP+GC2IjdU=
X-Google-Smtp-Source: ABdhPJya6Cw087uKEn1CsL1DAZ7XBeHzMf0yQwQaALff2Px+Vif9g2eX9TG+jhVAKzCgHkcvqoQJaA==
X-Received: by 2002:a05:6a00:a8b:b0:4e1:52db:9e5c with SMTP id b11-20020a056a000a8b00b004e152db9e5cmr104582134pfl.38.1654754226844;
        Wed, 08 Jun 2022 22:57:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902a51600b001677841e9c2sm7936189plq.119.2022.06.08.22.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:57:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, oleksandr@natalenko.name, willy@infradead.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH] mm/ksm: provide global_force to see maximum potential merging
Date:   Thu,  9 Jun 2022 05:56:58 +0000
Message-Id: <20220609055658.703472-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Up to now, KSM is apparently useful to save memory not just for VM but for
normal applications. But upper application developers might not know much
about KSM or whether they should use madvise(xxx, MERGEABLE) while there
indeed exist a lot of same pages in their apps. Some application developers
urgently need the kernel to provide an interface of KSM debugging mode to
see the maximum potential merging of the whole system, so the patch is.

We provide global_force at /sys/kernel/mm/ksm/. We can turn it on/off
simply by:

echo 1 > /sys/kernel/mm/ksm/global_force
echo 0 > /sys/kernel/mm/ksm/global_force

Also, we can change the sysfs boot time defaults of global_force supported
by passing the parameter ``ksm_global_force=true`` to kernel cmdline.

With this patch, we can use it together with'/proc/<pid>/ksm_merging_pages'
to explore the maximum potential of KSM merging of all the running
applications in service-developping or debugging environments. Setting it
to 1 is not recommended in service-online environments. Note: if an app is
started before setting global_force to 1, it may need to be restart to let
the affect effective.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/admin-guide/mm/ksm.rst |  19 +++++
 include/linux/ksm.h                  |  40 ++++++++++
 mm/ksm.c                             | 108 ++++++++++++++++++++++-----
 mm/memory.c                          |   4 +
 mm/mmap.c                            |   7 ++
 5 files changed, 158 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index b244f0202a03..bea571d29b58 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -157,6 +157,17 @@ stable_node_chains_prune_millisecs
         scan. It's a noop if not a single KSM page hit the
         ``max_page_sharing`` yet.
 
+global_force
+        specifies whether to force all anonymous and eligible pages to
+        be scanned in KSM. When set to 1, the ksmd will consume more cpu
+        performance because more pages needs to be scanned suddenly, so
+        setting it to 1 is not recommended in service-online environments.
+        we can use it together with ``/proc/<pid>/ksm_merging_pages`` to
+        explore the maximum potential of KSM merging of all the running
+        applications in service-developping or debugging environments.
+        Note: if an app is started before setting global_force to 1, it
+        may need to be restart to let the affect effective.
+
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/ksm/``:
 
 pages_shared
@@ -202,6 +213,14 @@ ksm_swpin_copy
 	note that KSM page might be copied when swapping in because do_swap_page()
 	cannot do all the locking needed to reconstitute a cross-anon_vma KSM page.
 
+Boot parameter
+==============
+
+You can change the sysfs boot time defaults of global_force supported by
+passing the parameter ``ksm_global_force=true`` to kernel cmdline, where
+all anonymous pagess of memory will be scanned by ksm daemon after kernel
+start up, and you will see that the value of ``global_force`` is 1.
+
 --
 Izik Eidus,
 Hugh Dickins, 17 Nov 2009
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 0b4f17418f64..3081097f3879 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -19,6 +19,9 @@ struct stable_node;
 struct mem_cgroup;
 
 #ifdef CONFIG_KSM
+
+extern bool ksm_global_force __read_mostly;
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
@@ -37,6 +40,32 @@ static inline void ksm_exit(struct mm_struct *mm)
 		__ksm_exit(mm);
 }
 
+static inline int ksm_enter_vma(struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	if (!ksm_global_force)
+		return 0;
+
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		return  __ksm_enter(vma->vm_mm);
+
+	return 0;
+}
+
+/*
+ * When mm_fault happens, check whether ksm_global_force is set to true,
+ * if yes, make this mm enter KSM.
+ */
+static inline vm_fault_t ksm_enter_mm_fault(struct mm_struct *mm)
+{
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		if (ksm_global_force)
+			if (__ksm_enter(mm))
+				return VM_FAULT_OOM;
+	return 0;
+}
+
 /*
  * When do_swap_page() first faults in from swap what used to be a KSM page,
  * no problem, it will be assigned to this vma's anon_vma; but thereafter,
@@ -65,6 +94,17 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+static inline vm_fault_t ksm_enter_mm_fault(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline int ksm_enter_vma(struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+
 #ifdef CONFIG_MMU
 static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
diff --git a/mm/ksm.c b/mm/ksm.c
index e19deb7871c1..069f1eba93df 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -277,6 +277,9 @@ static unsigned int zero_checksum __read_mostly;
 /* Whether to merge empty (zeroed) pages with actual zero pages */
 static bool ksm_use_zero_pages __read_mostly;
 
+/* Whether to force all mm to be scanned in KSM */
+bool ksm_global_force __read_mostly;
+
 #ifdef CONFIG_NUMA
 /* Zeroed when merging across nodes is not allowed */
 static unsigned int ksm_merge_across_nodes = 1;
@@ -334,6 +337,43 @@ static void __init ksm_slab_free(void)
 	mm_slot_cache = NULL;
 }
 
+static inline bool vma_eligible_for_ksm(struct vm_area_struct *vma,
+					unsigned long vm_flags)
+{
+	/*
+	 * Be somewhat over-protective for now!
+	 */
+	if (vm_flags & (VM_SHARED  | VM_MAYSHARE   |
+			VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
+			VM_HUGETLB | VM_MIXEDMAP))
+		return false;	/* just ignore the advice */
+
+	if (vma_is_dax(vma))
+		return false;
+
+#ifdef VM_SAO
+	if (*vm_flags & VM_SAO)
+		return false;
+#endif
+#ifdef VM_SPARC_ADI
+	if (*vm_flags & VM_SPARC_ADI)
+		return false;
+#endif
+
+	return true;
+}
+
+static inline bool vma_is_scannable(struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_MERGEABLE) && !ksm_global_force)
+		return false;
+
+	if (!vma_eligible_for_ksm(vma, vma->vm_flags))
+		return false;
+
+	return true;
+}
+
 static __always_inline bool is_stable_node_chain(struct stable_node *chain)
 {
 	return chain->rmap_hlist_len == STABLE_NODE_CHAIN;
@@ -523,7 +563,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma || !vma_is_scannable(vma) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
@@ -990,7 +1030,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
-			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+			if (!vma_is_scannable(vma) || !vma->anon_vma)
 				continue;
 			err = unmerge_ksm_pages(vma,
 						vma->vm_start, vma->vm_end);
@@ -2300,7 +2340,7 @@ static struct rmap_item *scan_get_next_rmap_item(struct page **page)
 		goto no_vmas;
 
 	for_each_vma(vmi, vma) {
-		if (!(vma->vm_flags & VM_MERGEABLE))
+		if (!vma_is_scannable(vma))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
@@ -2450,26 +2490,12 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 
 	switch (advice) {
 	case MADV_MERGEABLE:
-		/*
-		 * Be somewhat over-protective for now!
-		 */
-		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
-				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_MIXEDMAP))
+		if (*vm_flags & VM_MERGEABLE)
 			return 0;		/* just ignore the advice */
 
-		if (vma_is_dax(vma))
+		if (!vma_eligible_for_ksm(vma, *vm_flags))
 			return 0;
 
-#ifdef VM_SAO
-		if (*vm_flags & VM_SAO)
-			return 0;
-#endif
-#ifdef VM_SPARC_ADI
-		if (*vm_flags & VM_SPARC_ADI)
-			return 0;
-#endif
-
 		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
 			err = __ksm_enter(mm);
 			if (err)
@@ -2508,7 +2534,6 @@ int __ksm_enter(struct mm_struct *mm)
 
 	/* Check ksm_run too?  Would need tighter locking */
 	needs_wakeup = list_empty(&ksm_mm_head.mm_list);
-
 	spin_lock(&ksm_mmlist_lock);
 	insert_to_mm_slots_hash(mm, mm_slot);
 	/*
@@ -2943,6 +2968,48 @@ static ssize_t run_store(struct kobject *kobj, struct kobj_attribute *attr,
 }
 KSM_ATTR(run);
 
+static ssize_t global_force_show(struct kobject *kobj, struct kobj_attribute *attr,
+				 char *buf)
+{
+	return sprintf(buf, "%d\n", ksm_global_force);
+}
+
+static ssize_t global_force_store(struct kobject *kobj, struct kobj_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int err;
+	unsigned long value;
+
+	err = kstrtoul(buf, 10, &value);
+	if (err || value > UINT_MAX)
+		return -EINVAL;
+	if (value > 1)
+		return -EINVAL;
+
+	ksm_global_force = value;
+
+	return count;
+}
+KSM_ATTR(global_force);
+
+/* used for boot cmdline */
+static int __init setup_ksm_global_force(char *str)
+{
+	int ret = 0;
+
+	if (!str)
+		goto out;
+	if (!strcmp(str, "true")) {
+		ksm_global_force = true;
+		ret = 1;
+	}
+out:
+	if (!ret)
+		pr_warn("ksm_global_force= cannot parse, ignored\n");
+	return ret;
+}
+__setup("ksm_global_force=", setup_ksm_global_force);
+
 #ifdef CONFIG_NUMA
 static ssize_t merge_across_nodes_show(struct kobject *kobj,
 				       struct kobj_attribute *attr, char *buf)
@@ -3153,6 +3220,7 @@ static struct attribute *ksm_attrs[] = {
 	&sleep_millisecs_attr.attr,
 	&pages_to_scan_attr.attr,
 	&run_attr.attr,
+	&global_force_attr.attr,
 	&pages_shared_attr.attr,
 	&pages_sharing_attr.attr,
 	&pages_unshared_attr.attr,
diff --git a/mm/memory.c b/mm/memory.c
index be724238a9d3..b13c5a4fc399 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4989,6 +4989,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	p4d_t *p4d;
 	vm_fault_t ret;
 
+	ret = ksm_enter_mm_fault(mm);
+	if (ret)
+		return VM_FAULT_OOM;
+
 	pgd = pgd_offset(mm, address);
 	p4d = p4d_alloc(mm, pgd, address);
 	if (!p4d)
diff --git a/mm/mmap.c b/mm/mmap.c
index 5599c36283dd..36bb15bf9877 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -46,6 +46,7 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/ksm.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1140,6 +1141,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (err)
 		return NULL;
 	khugepaged_enter_vma(res, vm_flags);
+	ksm_enter_vma(res);
 	return res;
 }
 
@@ -2052,6 +2054,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
+	ksm_enter_vma(vma);
 	mas_destroy(&mas);
 	return error;
 }
@@ -2134,6 +2137,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
+	ksm_enter_vma(vma);
 	mas_destroy(&mas);
 	return error;
 }
@@ -2645,6 +2649,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma &&
 	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
 		khugepaged_enter_vma(vma, vm_flags);
+		ksm_enter_vma(vma);
 		goto expanded;
 	}
 
@@ -2761,6 +2766,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * call covers the non-merge case.
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
+	ksm_enter_vma(vma);
 
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
@@ -3068,6 +3074,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 			anon_vma_unlock_write(vma->anon_vma);
 		}
 		khugepaged_enter_vma(vma, flags);
+		ksm_enter_vma(vma);
 		goto out;
 	}
 
-- 
2.25.1

