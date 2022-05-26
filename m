Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945235352E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348577AbiEZRzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348417AbiEZRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:54:35 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF52AF1C7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o18-20020a63fb12000000b003fb22d1c6a0so957609pgh.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gbi/sedZET/zdh3Sj6stt7i603Maf3FW/BMVimtE9Dk=;
        b=RNAY/9X/J49yUlxi8AKv1KkXRYKZgi2PVinBAREd+jVpM+5cwAOYppy0mI01VfqmuD
         XaGRYp2JTW2yv3ibXEtx3Hff3uMup4mbPnEKt7nr6eHxB78t9CC40BM1PjdTsj0Xuqpm
         fv3EHLNgYDiFhZ6bAY5qung9sKodPn/4VzOYBuK6JufQFVu+BDvYYtxmOtfQaGhC+u4s
         NHCWNQHN5ZYGWcEgPSyEt8kMmczP2vHVUMOBo1geViZYNayZ0kn8mz1J1at6LWIMyY0H
         ve4Ypnk5M5fknwtsx24lQb5SEgIVvrpDrxL5uwCh5+fAOWovFBnQHVZrzzSPFWkH8bMA
         cuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gbi/sedZET/zdh3Sj6stt7i603Maf3FW/BMVimtE9Dk=;
        b=3hC4c2GIAePSxFGTdfpKRPe2zBcMLMIqnwyY4SpjqzS4xLW3aJpIaEbWcL5hp+cmaG
         IwLhksGak8/3eLkRE574DosvDnaZNZksTHT439q/KGAVCOn0LvdsZ9b+ADRILqcqFVqK
         NeMd/JRcBCMU9hYfqRRC4A9Aip66VCFWDWj7WhV86qpg+5xmw23evX0o5NKheO9eSy06
         r7VeVyqHqQWEkOfx3j9HbM3bVeCXM2Lxq6tm7l3B1ihpIVmgEUGKXXJZEHY6HqQaTuQZ
         E/0CafHHVYCFlJrPSD/tf27sw/ptqxMEBe9yRz5bkUn9+AwZX1ZE4RcWlpcJaz1h+3+O
         iNEQ==
X-Gm-Message-State: AOAM531EkGmXM3uB0mT/PK56AbhoB3M+v7gbxgNLnPaSSxRu75si3vUq
        CsDZ5GlbfTAzTz1Kp+RwMhNXi75QZHIC
X-Google-Smtp-Source: ABdhPJxIwN1/7gxgK2uJEkp1UJVizd20EAW3Jwz+1LpuZ9Fz7N2mp3FRBVeQ8fWCXijwEYhaEYArtzfJllV+
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:aa7:8b57:0:b0:518:7003:e28e with SMTP id
 i23-20020aa78b57000000b005187003e28emr32272726pfd.28.1653587666160; Thu, 26
 May 2022 10:54:26 -0700 (PDT)
Date:   Thu, 26 May 2022 17:54:06 +0000
In-Reply-To: <20220526175408.399718-1-bgardon@google.com>
Message-Id: <20220526175408.399718-10-bgardon@google.com>
Mime-Version: 1.0
References: <20220526175408.399718-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v8 09/11] KVM: selftests: Factor out calculation of pages
 needed for a VM
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the calculation of the number of pages needed for a VM to
make it easier to separate creating the VM and adding vCPUs.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  4 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 59 ++++++++++++++-----
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 035168cec451..3c9898c59ea1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -312,6 +312,10 @@ vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot);
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
 
+uint64_t vm_pages_needed(enum vm_guest_mode mode, uint32_t nr_vcpus,
+			 uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+			 uint32_t num_percpu_pages);
+
 /*
  * Create a VM with reasonable defaults
  *
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 200d3bb803e0..385f249c2dc5 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -377,7 +377,7 @@ struct kvm_vm *vm_create_without_vcpus(enum vm_guest_mode mode, uint64_t pages)
 }
 
 /*
- * VM Create with customized parameters
+ * Get the number of pages needed for a VM
  *
  * Input Args:
  *   mode - VM Mode (e.g. VM_MODE_P52V48_4K)
@@ -385,27 +385,17 @@ struct kvm_vm *vm_create_without_vcpus(enum vm_guest_mode mode, uint64_t pages)
  *   slot0_mem_pages - Slot0 physical memory size
  *   extra_mem_pages - Non-slot0 physical memory total size
  *   num_percpu_pages - Per-cpu physical memory pages
- *   guest_code - Guest entry point
- *   vcpuids - VCPU IDs
  *
  * Output Args: None
  *
  * Return:
- *   Pointer to opaque structure that describes the created VM.
- *
- * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K),
- * with customized slot0 memory size, at least 512 pages currently.
- * extra_mem_pages is only used to calculate the maximum page table size,
- * no real memory allocation for non-slot0 memory in this function.
+ *   The number of pages needed for the VM.
  */
-struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
-				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
-				    uint32_t num_percpu_pages, void *guest_code,
-				    uint32_t vcpuids[])
+uint64_t vm_pages_needed(enum vm_guest_mode mode, uint32_t nr_vcpus,
+			 uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+			 uint32_t num_percpu_pages)
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
-	struct kvm_vm *vm;
-	int i;
 
 	/* Force slot0 memory size not small than DEFAULT_GUEST_PHY_PAGES */
 	if (slot0_mem_pages < DEFAULT_GUEST_PHY_PAGES)
@@ -421,11 +411,48 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
 	extra_pg_pages = (slot0_mem_pages + extra_mem_pages + vcpu_pages) / PTES_PER_MIN_PAGE * 2;
 	pages = slot0_mem_pages + vcpu_pages + extra_pg_pages;
 
+	pages = vm_adjust_num_guest_pages(mode, pages);
+
+	return pages;
+}
+
+/*
+ * VM Create with customized parameters
+ *
+ * Input Args:
+ *   mode - VM Mode (e.g. VM_MODE_P52V48_4K)
+ *   nr_vcpus - VCPU count
+ *   slot0_mem_pages - Slot0 physical memory size
+ *   extra_mem_pages - Non-slot0 physical memory total size
+ *   num_percpu_pages - Per-cpu physical memory pages
+ *   guest_code - Guest entry point
+ *   vcpuids - VCPU IDs
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to opaque structure that describes the created VM.
+ *
+ * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K),
+ * with customized slot0 memory size, at least 512 pages currently.
+ * extra_mem_pages is only used to calculate the maximum page table size,
+ * no real memory allocation for non-slot0 memory in this function.
+ */
+struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
+				    uint64_t slot0_mem_pages, uint64_t extra_mem_pages,
+				    uint32_t num_percpu_pages, void *guest_code,
+				    uint32_t vcpuids[])
+{
+	uint64_t pages;
+	struct kvm_vm *vm;
+	int i;
+
 	TEST_ASSERT(nr_vcpus <= kvm_check_cap(KVM_CAP_MAX_VCPUS),
 		    "nr_vcpus = %d too large for host, max-vcpus = %d",
 		    nr_vcpus, kvm_check_cap(KVM_CAP_MAX_VCPUS));
 
-	pages = vm_adjust_num_guest_pages(mode, pages);
+	pages = vm_pages_needed(mode, nr_vcpus, slot0_mem_pages,
+				extra_mem_pages, num_percpu_pages);
 
 	vm = vm_create_without_vcpus(mode, pages);
 
-- 
2.36.1.124.g0e6072fb45-goog

