Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F36587206
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiHAULW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiHAULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:11:16 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032221A04F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:11:15 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g4-20020a17090a3c8400b001f383212a2fso4378199pjc.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1CPIOlz7fFueyiLdzVT360fZW6dG3KGjzqYbqbPMw7E=;
        b=HkPIxQzWE0J7udpyTMPhvQIZifkjMbB6HetWpRJnUR0gGEWisdPLz/CkVJ+qo6W7NO
         VdX6yqau6dzrsScY5p+TdgT0j/v1zV/teJpfCWjtVo+boBJ0loIC98TQbGDDL/5JVVX1
         X7MfHQ0oBM/RWGUFh7JqhrolflDjp5RoMWFQbUqZuIGAh3QprCC0TLzkeEXTGgqCJtCo
         9MaAvNmptOBavPEz7OGOHUXpbAnIWpBWMTd/xsZUMl5YoniqREELbVDIeB/DIUe9Qifg
         vnmYGdSQokxw9ULflf8pv7d3TlchuvhxCwwVBHygDietf+e/EVgBASjN1MGup3k0o0Gl
         S0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1CPIOlz7fFueyiLdzVT360fZW6dG3KGjzqYbqbPMw7E=;
        b=ytyEWcvwB4SpwwJfTxkPS7v4SGFIaYw9kFvEwLXIbNhOmTc9Pic72NwgW9ZCVL13HK
         D1xntfW3u8nnnlw6/OQtu+4WnIli84X/7OnCb0tlPYrb2ls9FiDxg6IqDYlXf9/fQYL3
         f4kPSfwPSGn/sc1sAv0prJGw2kJ7i/bEVDcDNrabwjVx8uEkiHJd3Rb+06iV6NbebMH1
         9AZ9FfQexJJXFjTlUcZ/JcDWmVI9OiSntJIYaTAOvzq3tvH/N99dA+edLhFUmtFoSyOA
         DTLf6ExuVvC1RBffziVEDexXa0fXFJKaytIfJUyMIp4hxveRz1s32KockEHAB22ENNFz
         3jFQ==
X-Gm-Message-State: AJIora9Rp+iu37Y7CA6ngrxhCyhHx3BiPhxRF8q5+DKTp5cX5x6shti5
        UdV5eGwBWPJprwwciBnCINwnlYueGRU=
X-Google-Smtp-Source: AGRyM1tAVYm46a71Sf9MuG0rFto0djL+RqRn3npyTnW20ASvchkJXlUV99TJAUvtkmNwb/TzBi8oRdmVicY=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:6be2:f99c:e23c:fa12])
 (user=pgonda job=sendgmr) by 2002:a63:d315:0:b0:41a:d15a:b1b7 with SMTP id
 b21-20020a63d315000000b0041ad15ab1b7mr14882806pgg.275.1659384674588; Mon, 01
 Aug 2022 13:11:14 -0700 (PDT)
Date:   Mon,  1 Aug 2022 13:10:59 -0700
In-Reply-To: <20220801201109.825284-1-pgonda@google.com>
Message-Id: <20220801201109.825284-2-pgonda@google.com>
Mime-Version: 1.0
References: <20220801201109.825284-1-pgonda@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [V2 01/11] KVM: selftests: move vm_phy_pages_alloc() earlier in file
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Roth <michael.roth@amd.com>

Subsequent patches will break some of this code out into file-local
helper functions, which will be used by functions like vm_vaddr_alloc(),
which currently are defined earlier in the file, so a forward
declaration would be needed.

Instead, move it earlier in the file, just above vm_vaddr_alloc() and
and friends, which are the main users.

Reviewed-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 145 ++++++++++-----------
 1 file changed, 72 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9889fe0d8919..cb3a5f8a53b7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1089,6 +1089,78 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	return vcpu;
 }
 
+/*
+ * Physical Contiguous Page Allocator
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   num - number of pages
+ *   paddr_min - Physical address minimum
+ *   memslot - Memory region to allocate page from
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Starting physical address
+ *
+ * Within the VM specified by vm, locates a range of available physical
+ * pages at or above paddr_min. If found, the pages are marked as in use
+ * and their base address is returned. A TEST_ASSERT failure occurs if
+ * not enough pages are available at or above paddr_min.
+ */
+vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+			      vm_paddr_t paddr_min, uint32_t memslot)
+{
+	struct userspace_mem_region *region;
+	sparsebit_idx_t pg, base;
+
+	TEST_ASSERT(num > 0, "Must allocate at least one page");
+
+	TEST_ASSERT((paddr_min % vm->page_size) == 0,
+		"Min physical address not divisible by page size.\n paddr_min: 0x%lx page_size: 0x%x",
+		paddr_min, vm->page_size);
+
+	region = memslot2region(vm, memslot);
+	base = pg = paddr_min >> vm->page_shift;
+
+	do {
+		for (; pg < base + num; ++pg) {
+			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
+				break;
+			}
+		}
+	} while (pg && pg != base + num);
+
+	if (pg == 0) {
+		fprintf(stderr,
+			"No guest physical page available, paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
+			paddr_min, vm->page_size, memslot);
+		fputs("---- vm dump ----\n", stderr);
+		vm_dump(stderr, vm, 2);
+		abort();
+	}
+
+	for (pg = base; pg < base + num; ++pg)
+		sparsebit_clear(region->unused_phy_pages, pg);
+
+	return base * vm->page_size;
+}
+
+vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
+			     uint32_t memslot)
+{
+	return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
+}
+
+/* Arbitrary minimum physical address used for virtual translation tables. */
+#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
+
+vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
+{
+	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+}
+
 /*
  * VM Virtual Address Unused Gap
  *
@@ -1735,79 +1807,6 @@ const char *exit_reason_str(unsigned int exit_reason)
 	return "Unknown";
 }
 
-/*
- * Physical Contiguous Page Allocator
- *
- * Input Args:
- *   vm - Virtual Machine
- *   num - number of pages
- *   paddr_min - Physical address minimum
- *   memslot - Memory region to allocate page from
- *
- * Output Args: None
- *
- * Return:
- *   Starting physical address
- *
- * Within the VM specified by vm, locates a range of available physical
- * pages at or above paddr_min. If found, the pages are marked as in use
- * and their base address is returned. A TEST_ASSERT failure occurs if
- * not enough pages are available at or above paddr_min.
- */
-vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
-			      vm_paddr_t paddr_min, uint32_t memslot)
-{
-	struct userspace_mem_region *region;
-	sparsebit_idx_t pg, base;
-
-	TEST_ASSERT(num > 0, "Must allocate at least one page");
-
-	TEST_ASSERT((paddr_min % vm->page_size) == 0, "Min physical address "
-		"not divisible by page size.\n"
-		"  paddr_min: 0x%lx page_size: 0x%x",
-		paddr_min, vm->page_size);
-
-	region = memslot2region(vm, memslot);
-	base = pg = paddr_min >> vm->page_shift;
-
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
-			}
-		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"paddr_min: 0x%lx page_size: 0x%x memslot: %u\n",
-			paddr_min, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
-	}
-
-	for (pg = base; pg < base + num; ++pg)
-		sparsebit_clear(region->unused_phy_pages, pg);
-
-	return base * vm->page_size;
-}
-
-vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
-			     uint32_t memslot)
-{
-	return vm_phy_pages_alloc(vm, 1, paddr_min, memslot);
-}
-
-/* Arbitrary minimum physical address used for virtual translation tables. */
-#define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
-
-vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
-{
-	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
-}
-
 /*
  * Address Guest Virtual to Host Virtual
  *
-- 
2.37.1.455.g008518b4e5-goog

