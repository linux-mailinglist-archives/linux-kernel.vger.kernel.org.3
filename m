Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9115F492CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbiARR5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:57:37 -0500
Received: from mga04.intel.com ([192.55.52.120]:60602 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237399AbiARR5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642528656; x=1674064656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUEhQp/Bhz91i14GuG7PQ/1XFqOlWPMSWAHs73BvPvM=;
  b=QCRiC1vtrAHL3E8ZNrFS/IPQs+WXd+BxFvwObZL729PxhrYMPcGxNp28
   Va3pc+dvPoXPROCu0QjugGUbYIc57v4dSOjNs5KmjMn+YncFRdBWpi3LS
   maMbulBjGQC0XdIgcBleILWQ0tATOgWl37jrzdwygkJemXDRTKONeU5BW
   9/jX2W1E5/Zlyhf0OkDT7w96Z7hy8gK5gq5wxTqSoUuPDqKofTAYXKnED
   D1Vlupnx63rtNK5TC6J8gyiqUwpNg6eYue4AOmPK+qNT8BpvejMfFDALI
   pFJGStHqErJsasvVhbMBvqE2/LtFyA8TkHJoKwq454fAS0fmvdF1FfSqc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243700438"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="243700438"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:57:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="625588004"
Received: from bjann-mobl2.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.251.29.174])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:57:35 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v3 1/2] x86/sgx: Add accounting for tracking overcommit
Date:   Tue, 18 Jan 2022 09:57:16 -0800
Message-Id: <20220118175717.6922-2-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220118175717.6922-1-kristen@linux.intel.com>
References: <20220118175717.6922-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system runs out of enclave memory, SGX can reclaim EPC pages
by swapping to normal RAM. This normal RAM is allocated via a
per-enclave shared memory area. The shared memory area is not mapped
into the enclave or the task mapping it, which makes its memory use
opaque (including to the OOM killer). Having lots of hard to find
memory around is problematic, especially when there is no limit.

Introduce a global counter that can be used to limit the number of pages
that enclaves are able to consume for backing storage.  This parameter
is a percentage value that is used in conjunction with the number of
EPC pages in the system to set a cap on the amount of backing RAM that
can be consumed.

The default for this value is 150, which limits the total number of
shared memory pages that may be consumed by all enclaves as backing
pages to 1.5X of EPC pages on the system. For example, on an SGX
system that has 128MB of EPC, this default would cap the amount of
normal RAM that SGX consumes for its shared memory areas at 192MB.
The value of 1.5x the number of EPC pages was chosen because it should
handle the most common case of a few enclaves that don't need much
overcommit without any impact to user space. In the less common case
where there are many enclaves, or a few large enclaves which need
a lot of overcommit due to large EPC memory requirements, the
reclaimer may fail to allocate a backing page for swapping if the
limit has been reached. In this case, the page will not be able
to allocate any new EPC pages. Any ioctl or call to add new EPC
pages will get -ENOMEM, so for example, new enclaves will fail to
load, and new EPC pages will not be able to be added.

The SGX overcommit_percent works differently than the core VM overcommit
limit. Enclaves request backing pages one page at a time, and the number
of in use backing pages that are allowed is a global resource that is
limited for all enclaves.

Introduce a pair of functions which can be used by callers when requesting
backing RAM pages. These functions are responsible for accounting the
page charges. A request may return an error if the request will cause the
counter to exceed the backing page cap.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/main.c | 45 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2857a49f2335..261e3702aef9 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -43,6 +43,45 @@ static struct sgx_numa_node *sgx_numa_nodes;
 
 static LIST_HEAD(sgx_dirty_page_list);
 
+/*
+ * Limits the amount of normal RAM that SGX can consume for EPC
+ * overcommit to the total EPC pages * sgx_overcommit_percent / 100
+ */
+static int sgx_overcommit_percent = 150;
+
+/* The number of pages that can be allocated globally for backing storage. */
+static atomic_long_t sgx_nr_available_backing_pages;
+
+/**
+ * sgx_charge_mem() - charge for a page used for backing storage
+ *
+ * Backing storage usage is capped by the sgx_nr_available_backing_pages.
+ * If the backing storage usage is over the overcommit limit,
+ * return an error.
+ *
+ * Return:
+ * 0:		The page requested does not exceed the limit
+ * -ENOMEM:	The page requested exceeds the overcommit limit
+ */
+int sgx_charge_mem(void)
+{
+	if (!atomic_long_add_unless(&sgx_nr_available_backing_pages, -1, 0))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/**
+ * sgx_uncharge_mem() - uncharge a page previously used for backing storage
+ *
+ * When backing storage is no longer in use, increment the
+ * sgx_nr_available_backing_pages counter.
+ */
+void sgx_uncharge_mem(void)
+{
+	atomic_long_inc(&sgx_nr_available_backing_pages);
+}
+
 /*
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
  * from the input list, and made available for the page allocator. SECS pages
@@ -783,6 +822,8 @@ static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
 static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
+	u64 available_backing_bytes;
+	u64 total_epc_bytes = 0;
 	u64 pa, size;
 	int nid;
 	int i;
@@ -830,6 +871,7 @@ static bool __init sgx_page_cache_init(void)
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
 		sgx_numa_nodes[nid].size += size;
+		total_epc_bytes += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -839,6 +881,9 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	available_backing_bytes = total_epc_bytes * (sgx_overcommit_percent / 100);
+	atomic_long_set(&sgx_nr_available_backing_pages, available_backing_bytes >> PAGE_SHIFT);
+
 	return true;
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0f17def9fe6f..3507a9983fc1 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -89,6 +89,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+int sgx_charge_mem(void);
+void sgx_uncharge_mem(void);
 
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
-- 
2.20.1

