Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481555A52D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiH2RLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiH2RLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:11:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDEB67459
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:11:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l16-20020a170902f69000b00175138bcd25so65921plg.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=DjSpUEd4vF4lOtP0B99mET3glfEYpz5arg2nPAewBOU=;
        b=dbslTdjbaCy+F+LzP2tdEdjdbHXFFIR9slvTIDv3G6gdLS8Qx074F0vFDwHlu3al4c
         A434GfDVx+TxN4m0G5IjSxevmn0DuZUadZ9rw3Y5icqBrmUSAVSufMrMYkQXMKC0b5n5
         ZYxZlrAXGNXMnM/LsEwEPxa5hrbYCgKgeJHhc+8PXU+zzj4crGvHR0tQo4V2sGnLQhHq
         udJom4hoMCj13IDh89VngNXEDoagGF85oXzRbQ4ijVTNZRO4QnpYS783ZiYe0w5svsDT
         ysB2X/wirzxvzXpYf1izcVDqMZm5medbG2Y80uoHLoi4s11tyHOdAn4Tnd93KtgVdd63
         Bohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=DjSpUEd4vF4lOtP0B99mET3glfEYpz5arg2nPAewBOU=;
        b=ZuEJr6QhDLyfEusGnsQ5qqNI5JtDyl5UMZGFMfy4Yu8bQKV4hRe9ndxAOIzTD24pRv
         JcmcBLiJ+Tk/F1BZ4Ei7GwZy9I1h1nBRBfeKyIYpsNIqpfmtDRVoDe+T8pKPBD2KNGph
         VQrcbkI9cKFV60x9+7eds6TrPsAhdI2rn0iwrMwSEWKSIQ781rSOTXHgKpwx2ubt5vQz
         i6mNKtTZ3BrGJTArqGUjSrxJ0oNWHLMlW+aZE/EL6H2p3jkcv8rIJ6isaBulOqUD3kZX
         uDDosc7hvy4f8I7vWcUVkyGZGzxSbd1dtzQS/275VdLplyM7QZFwyLtMSSgXg0M6AU8C
         znTg==
X-Gm-Message-State: ACgBeo1OEQla1Wd/Qw7HjXG5ZfZBSzj6+TfEjR+kaP8HnDXHKbQiBvCe
        kicFFJ4TWPjRDRviYmzbL2qfQkn+CYk=
X-Google-Smtp-Source: AA6agR4t3eAZwrotYfOGWZoVzAPy8mVfbIrrH8RjKkVrjJizM8PQCYVxyMvRapKjxvgGRdCoqyB8Ze3Acc8=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:cddb:77a7:c55e:a7a2])
 (user=pgonda job=sendgmr) by 2002:a17:90b:1e08:b0:1f5:1f0d:3736 with SMTP id
 pg8-20020a17090b1e0800b001f51f0d3736mr19635518pjb.58.1661793059938; Mon, 29
 Aug 2022 10:10:59 -0700 (PDT)
Date:   Mon, 29 Aug 2022 10:10:18 -0700
In-Reply-To: <20220829171021.701198-1-pgonda@google.com>
Message-Id: <20220829171021.701198-6-pgonda@google.com>
Mime-Version: 1.0
References: <20220829171021.701198-1-pgonda@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [V4 5/8] KVM: selftests: add support for encrypted vm_vaddr_* allocations
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, Peter Gonda <pgonda@google.com>
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

From: Michael Roth <michael.roth@amd.com>

The default policy for whether to handle allocations as encrypted or
shared pages is currently determined by vm_phy_pages_alloc(), which in
turn uses the policy defined by vm->memcrypt.enc_by_default.

Test programs may wish to allocate shared vaddrs for things like
sharing memory with the guest. Since enc_by_default will be true in the
case of SEV guests (since it's required in order to have the initial
ELF binary and page table become part of the initial guest payload), an
interface is needed to explicitly request shared pages.

Implement this by splitting the common code out from vm_vaddr_alloc()
and introducing a new vm_vaddr_alloc_shared().

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index dda8467d1434..489e8c833e5f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -392,6 +392,7 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index de13be62d52d..ffdf39a5b12d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1273,12 +1273,13 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 }
 
 /*
- * VM Virtual Address Allocate
+ * VM Virtual Address Allocate Shared/Encrypted
  *
  * Input Args:
  *   vm - Virtual Machine
  *   sz - Size in bytes
  *   vaddr_min - Minimum starting virtual address
+ *   encrypt - Whether the region should be handled as encrypted
  *
  * Output Args: None
  *
@@ -1291,13 +1292,15 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
  * a unique set of pages, with the minimum real allocation being at least
  * a page.
  */
-vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+static vm_vaddr_t
+_vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min, bool encrypt)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size, 0);
+	vm_paddr_t paddr = _vm_phy_pages_alloc(vm, pages,
+					       KVM_UTIL_MIN_PFN * vm->page_size,
+					       0, encrypt);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1318,6 +1321,16 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
 	return vaddr_start;
 }
 
+vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min, vm->memcrypt.enc_by_default);
+}
+
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min)
+{
+	return _vm_vaddr_alloc(vm, sz, vaddr_min, false);
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
-- 
2.37.2.672.g94769d06f0-goog

