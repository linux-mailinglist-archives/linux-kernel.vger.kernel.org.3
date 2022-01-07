Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134D9487BE4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiAGSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:17:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:15966 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbiAGSRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641579430; x=1673115430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7KuoOblUfGK5uG6y7thVBk31CNJyygoqp6O5o/g/fxQ=;
  b=S5kbdIMMKO+fFFjJPWf2h7AQ2SPygACUHHO3v56TzsI/jXqYq6I0sDO7
   k/KsJg8WhfS0ykQYZ8Pruc/sFQlC4ROLzkRI1Nd0lO7n2wRxqTr+aBxrG
   s6mils3tiP5iOqSEoF3esx7xG5xe+W+J1tIn+EPzayQOgo0y6DHdEtpoo
   dcqx+2URDrNm+FGpZHda9YNdQSYnAOKSvhg0m1mvC0ni0ZuWYeB8t3Ig0
   iBklJyEV+KnQcoCkbDV1zvjmUz4LpOUdkjKC9Tl6EWG4elgmZxBgNiaaX
   srrd3JlKup3v9XNJntTZIa2xSqqBxp1cMGMfRyrHw/x8g/qKbMciCeIJi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="242864355"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="242864355"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:17:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="622009685"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.25.179])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:17:09 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
Date:   Fri,  7 Jan 2022 10:16:16 -0800
Message-Id: <20220107181618.6597-2-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220107181618.6597-1-kristen@linux.intel.com>
References: <20220107181618.6597-1-kristen@linux.intel.com>
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

The overcommit percentage value is 150, which limits the total number of
shared memory pages that may be consumed by all enclaves as backing pages
to 1.5X of EPC pages on the system.

For example, on an SGX system that has 128MB of EPC, this would
cap the amount of normal RAM that SGX consumes for its shared memory
areas at 192MB.

The SGX overcommit percent works differently than the core VM overcommit
limit. Enclaves request backing pages one page at a time, and the number
of in use backing pages that are allowed is a global resource that is
limited for all enclaves.

Introduce a pair of functions which can be used by callers when requesting
backing RAM pages. These functions are responsible for accounting the
page charges. A request may return an error if the request will cause the
counter to exceed the backing page cap.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 46 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2857a49f2335..8a7bfe0d9023 100644
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
@@ -786,6 +825,8 @@ static bool __init sgx_page_cache_init(void)
 	u64 pa, size;
 	int nid;
 	int i;
+	u64 total_epc_bytes = 0;
+	u64 available_backing_bytes;
 
 	sgx_numa_nodes = kmalloc_array(num_possible_nodes(), sizeof(*sgx_numa_nodes), GFP_KERNEL);
 	if (!sgx_numa_nodes)
@@ -830,6 +871,7 @@ static bool __init sgx_page_cache_init(void)
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
 		sgx_numa_nodes[nid].size += size;
+		total_epc_bytes += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -839,6 +881,10 @@ static bool __init sgx_page_cache_init(void)
 		return false;
 	}
 
+	available_backing_bytes = total_epc_bytes * (sgx_overcommit_percent / 100);
+
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

