Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588764E350E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiCUXvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiCUXu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:50:57 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BD71903E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:49:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t129-20020a637887000000b003851a93bf4bso9343pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zR/oLtC0GUAkcb66SECoKHYkdEWkC3/rnB6c6Rd7ndg=;
        b=WZmkJflljx56j9wbepPRxYCb17aLNF10ZpXYJF50WF1LwvRiP91UXmo3rOORk+Z4BV
         BL1gU+xhgUnUW05zO8i/3yPQdVoPjnw+qRhPrZuw91KFHQFtNfkJiL3CpPOXeK3Ey3yu
         JDeun1xnCFWYCCgEDw9A6UsxXj1JeaUdI+OHPNngQOjmC4Opj+tZgHdmmZl1fMGeyUyI
         R9NQlP54wSvLtVxPqyqwgN0KKb2uxpp4DVUB59k7osJtnIgjFy7haY43Yyd2np7dlizQ
         1ZoPQ7/D6Y0ZpTGP8D4sx+zEmP1o9s+YetPkqcSCJrlacSPypN/r2r7T/ucYzLY/udKa
         JLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zR/oLtC0GUAkcb66SECoKHYkdEWkC3/rnB6c6Rd7ndg=;
        b=0FlpOOVEFw+rguU2qNHxY7W+2wS4CqjvwHMjVlCk42n5ApbKnb7KBluacur5wkEYFF
         IX0jvUxq+kJ8HQu8SaIHUzW0sXLs2Avu9qEgyg7kqGzJvsCtsrpPxj+RQ772fl4HtSC/
         YcpEWbUFzgEq22P+KPYlCm6/Qzhq+sRZLs8XHAycHZqlien5j/Li4xlRtcpN/DZF5VRM
         D2JU5ZZoig3i/R3h/Xn3zDkBHKDJGuwHyMz2E/4LfovA1zuL0NA0hm58bX5uGhCGAhCm
         BTkWUWwhmQomrXm2CN/aZcgRKIlTncGH+c+Y1z5vJT0C07FLm2hXQLqBRgttSe1FCtXP
         aVVw==
X-Gm-Message-State: AOAM533YILvhe+ibd/bNflmnr+lIfHP+Fhyq2X/m48R+L9fab/ERq2JS
        Db3dZovEXRvOkOLVeoFcr8sFwLrLHCTlQhODTi2xXEVOwV0SOIog6U8S1jLjRqwXht7myF8o81p
        Nv27VJwhT1B1vCinJ3Y2O8tr+3SE79u4Ub3GOUSLI49ltxZi9a6Ow4tRQIjy5X/Y1Od9wSc4t
X-Google-Smtp-Source: ABdhPJyaiAYmEDmaFmcPf0su7hitk/r/fdft/9II80Jr0Czi+zUbHkue2Dko842Ud6nQlWHLS+ALcPujkHy6
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:b76a:f152:cb5e:5cd2])
 (user=bgardon job=sendgmr) by 2002:a62:684:0:b0:4f7:803:d1b0 with SMTP id
 126-20020a620684000000b004f70803d1b0mr26759515pfg.10.1647906541362; Mon, 21
 Mar 2022 16:49:01 -0700 (PDT)
Date:   Mon, 21 Mar 2022 16:48:37 -0700
In-Reply-To: <20220321234844.1543161-1-bgardon@google.com>
Message-Id: <20220321234844.1543161-5-bgardon@google.com>
Mime-Version: 1.0
References: <20220321234844.1543161-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v2 04/11] KVM: selftests: Add memslot parameter to elf_load
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently elf_load loads code into memslot 0. Add a parameter to allow
loading code into any memslot. This will be useful for backing code
pages with huge pages in future commits.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../testing/selftests/kvm/include/kvm_util_base.h  |  5 +++++
 tools/testing/selftests/kvm/lib/elf.c              | 13 +++++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c         | 14 ++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 78c4407f36b4..72163ba2f878 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -122,7 +122,10 @@ uint32_t kvm_vm_reset_dirty_ring(struct kvm_vm *vm);
 int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, const vm_vaddr_t gva,
 		       size_t len);
 
+void kvm_vm_elf_load_memslot(struct kvm_vm *vm, const char *filename,
+			     uint32_t memslot);
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
+
 int kvm_memfd_alloc(size_t size, bool hugepages);
 
 void vm_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
@@ -169,6 +172,8 @@ void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+vm_vaddr_t vm_vaddr_alloc_memslot(struct kvm_vm *vm, size_t sz,
+				  vm_vaddr_t vaddr_min, uint32_t memslot);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index 13e8e3dcf984..899418e65f60 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -97,6 +97,7 @@ static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
  *
  * Input Args:
  *   filename - Path to ELF file
+ *   memslot - the memslot into which the elf should be loaded
  *
  * Output Args: None
  *
@@ -111,7 +112,8 @@ static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
  * by the image and it needs to have sufficient available physical pages, to
  * back the virtual pages used to load the image.
  */
-void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
+void kvm_vm_elf_load_memslot(struct kvm_vm *vm, const char *filename,
+			     uint32_t memslot)
 {
 	off_t offset, offset_rv;
 	Elf64_Ehdr hdr;
@@ -162,7 +164,9 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 		seg_vend |= vm->page_size - 1;
 		size_t seg_size = seg_vend - seg_vstart + 1;
 
-		vm_vaddr_t vaddr = vm_vaddr_alloc(vm, seg_size, seg_vstart);
+		vm_vaddr_t vaddr = vm_vaddr_alloc_memslot(vm, seg_size,
+							  seg_vstart,
+							  memslot);
 		TEST_ASSERT(vaddr == seg_vstart, "Unable to allocate "
 			"virtual memory for segment at requested min addr,\n"
 			"  segment idx: %u\n"
@@ -191,3 +195,8 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 		}
 	}
 }
+
+void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
+{
+	kvm_vm_elf_load_memslot(vm, filename, 0);
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9c4574381daa..09742a787546 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1336,8 +1336,7 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  *   vm - Virtual Machine
  *   sz - Size in bytes
  *   vaddr_min - Minimum starting virtual address
- *   data_memslot - Memory region slot for data pages
- *   pgd_memslot - Memory region slot for new virtual translation tables
+ *   memslot - Memory region slot for data pages
  *
  * Output Args: None
  *
@@ -1350,13 +1349,15 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  * a unique set of pages, with the minimum real allocation being at least
  * a page.
  */
-vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+vm_vaddr_t vm_vaddr_alloc_memslot(struct kvm_vm *vm, size_t sz,
+				  vm_vaddr_t vaddr_min, uint32_t memslot)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
 	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size, 0);
+					      KVM_UTIL_MIN_PFN * vm->page_size,
+					      memslot);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1377,6 +1378,11 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 	return vaddr_start;
 }
 
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return vm_vaddr_alloc_memslot(vm, sz, vaddr_min, 0);
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
-- 
2.35.1.894.gb6a874cedc-goog

