Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02C9587220
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiHAUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiHAULf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:11:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856C3DBEF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:11:31 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s6-20020a170902ea0600b0016d5c8c4164so7753599plg.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RP6k09T3C4qU6kR1blA5gxroyQ7SeDyZZ1/aOJHsDp4=;
        b=L6ysXk3jkHKIWYJL/qfBvVgVxcib4sZfl1E57evcm7GrJnQCTHyr+C9cSuKeB6AJuc
         VfGXfnr+BdHB2bvn4lGVBIvvATyGFYsom07pVuWQliQriJx1VivU+PhAQeUXO2WKP8A8
         SdqWuh6Yj4nGoBWtf8lOCA0UUkVphqrye0jJIhG8tobSo2yZk3npya7xvi0VC6BAxj3g
         aXXMbfwUjEY/H5yBuSBsa+pfuymUknaN8kTMBPXOlva1XGu0OQ9Awsf/n6YTA8XWZm3I
         DOpb59+KvwrGsww7AFZYcCnLUXS4DqTUoZW0M78dX/aoiQBun2aQ5o1esrizb6oVlA+r
         +2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RP6k09T3C4qU6kR1blA5gxroyQ7SeDyZZ1/aOJHsDp4=;
        b=aEqABnA+vLot2bTDVs4DxybDkMbwaNYMelQpzrgRuYfTrugRKgHg7dMKuPmay1TXr+
         V5RTNjH7PLD9p1iLo6WSvMArb7Gv/jP00UfUUaEuMQxwfMk0iQ/rfAyRpd5UBXwn3wJ1
         cOy/Zd69uN6wl5knnjTqEx5EO2zzUPStWRLRWwWSAKjEHlxVapSMyyinajkWtSm0b/aY
         PcMpKWG30A2KbWAYrTxRWiQ4Uz5MwoctYtoMsU87zvnezXAos4Ai0iqGFitS2pQWTWbx
         ZCbhiNtQbqbkqNsIIGHgsVhp8L4YlUCI42XKpRAGffhWxcJjqvQ/e/sdFB3/ydCWpbuT
         U4eQ==
X-Gm-Message-State: AJIora95Uihaor+SBPHE3jayMqNFw01+ZY8oJXuDiQKf7RPpCSS38R/d
        r7utg/WH/uueEFBjM/u/naxfVkku0jM=
X-Google-Smtp-Source: AA6agR5CycIv52XGs1jSFNys43a7RT/XftGYjLrmpRkWNv2WUbR8bG4qz0tOjZQ5+oVA/LFT3LhqDAjwIQ0=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:6be2:f99c:e23c:fa12])
 (user=pgonda job=sendgmr) by 2002:a05:6a00:124c:b0:52b:26b6:2ab4 with SMTP id
 u12-20020a056a00124c00b0052b26b62ab4mr17950244pfi.85.1659384689871; Mon, 01
 Aug 2022 13:11:29 -0700 (PDT)
Date:   Mon,  1 Aug 2022 13:11:07 -0700
In-Reply-To: <20220801201109.825284-1-pgonda@google.com>
Message-Id: <20220801201109.825284-10-pgonda@google.com>
Mime-Version: 1.0
References: <20220801201109.825284-1-pgonda@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [V2 09/11] KVM: selftests: Make ucall work with encrypted guests
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for encrypted, SEV, guests in the ucall framework. If
encryption is enabled set up a pool of ucall structs in the guests'
shared memory region. This was suggested in the thread on "[RFC PATCH
00/10] KVM: selftests: Add support for test-selectable ucall
implementations". Using a listed as suggested there doesn't work well
because the list is setup using HVAs not GVAs so use a bitmap + array
solution instead to get the same pool result.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |   3 +
 .../selftests/kvm/include/ucall_common.h      |  14 +--
 .../testing/selftests/kvm/lib/ucall_common.c  | 112 +++++++++++++++++-
 3 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 8ce9e5be70a3..ad4abc6be1ab 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -102,6 +102,9 @@ struct kvm_vm {
 	int stats_fd;
 	struct kvm_stats_header stats_header;
 	struct kvm_stats_desc *stats_desc;
+
+	bool use_ucall_list;
+	struct list_head ucall_list;
 };
 
 
diff --git a/tools/testing/selftests/kvm/include/ucall_common.h b/tools/testing/selftests/kvm/include/ucall_common.h
index c1bc8e33ef3f..a96220ac6024 100644
--- a/tools/testing/selftests/kvm/include/ucall_common.h
+++ b/tools/testing/selftests/kvm/include/ucall_common.h
@@ -22,6 +22,10 @@ enum {
 struct ucall {
 	uint64_t cmd;
 	uint64_t args[UCALL_MAX_ARGS];
+
+	/* For encrypted guests. */
+	uint64_t idx;
+	struct ucall *hva;
 };
 
 void ucall_arch_init(struct kvm_vm *vm, void *arg);
@@ -32,15 +36,9 @@ uint64_t ucall_arch_get_ucall(struct kvm_vcpu *vcpu);
 void ucall(uint64_t cmd, int nargs, ...);
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc);
 
-static inline void ucall_init(struct kvm_vm *vm, void *arg)
-{
-	ucall_arch_init(vm, arg);
-}
+void ucall_init(struct kvm_vm *vm, void *arg);
 
-static inline void ucall_uninit(struct kvm_vm *vm)
-{
-	ucall_arch_uninit(vm);
-}
+void ucall_uninit(struct kvm_vm *vm);
 
 #define GUEST_SYNC_ARGS(stage, arg1, arg2, arg3, arg4)	\
 				ucall(UCALL_SYNC, 6, "hello", stage, arg1, arg2, arg3, arg4)
diff --git a/tools/testing/selftests/kvm/lib/ucall_common.c b/tools/testing/selftests/kvm/lib/ucall_common.c
index a060252bab40..feb0173179ec 100644
--- a/tools/testing/selftests/kvm/lib/ucall_common.c
+++ b/tools/testing/selftests/kvm/lib/ucall_common.c
@@ -1,22 +1,122 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include "kvm_util.h"
+#include "linux/types.h"
+#include "linux/bitmap.h"
+#include "linux/atomic.h"
+
+struct ucall_header {
+	DECLARE_BITMAP(in_use, KVM_MAX_VCPUS);
+	struct ucall ucalls[KVM_MAX_VCPUS];
+};
+
+static bool use_ucall_list;
+static struct ucall_header *ucall_hdr;
+
+void ucall_init(struct kvm_vm *vm, void *arg)
+{
+	struct ucall *uc;
+	struct ucall_header *hdr;
+	vm_vaddr_t vaddr;
+	int i;
+
+	use_ucall_list = vm->use_ucall_list;
+	sync_global_to_guest(vm, use_ucall_list);
+	if (!use_ucall_list)
+		goto out;
+
+	TEST_ASSERT(!ucall_hdr,
+		    "Only a single encrypted guest at a time for ucalls.");
+	vaddr = vm_vaddr_alloc_shared(vm, sizeof(*hdr), vm->page_size);
+	hdr = (struct ucall_header *)addr_gva2hva(vm, vaddr);
+	memset(hdr, 0, sizeof(*hdr));
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		uc = &hdr->ucalls[i];
+		uc->hva = uc;
+		uc->idx = i;
+	}
+
+	ucall_hdr = (struct ucall_header *)vaddr;
+	sync_global_to_guest(vm, ucall_hdr);
+
+out:
+	ucall_arch_init(vm, arg);
+}
+
+void ucall_uninit(struct kvm_vm *vm)
+{
+	use_ucall_list = false;
+	ucall_hdr = NULL;
+
+	ucall_arch_uninit(vm);
+}
+
+static struct ucall *ucall_alloc(void)
+{
+	struct ucall *uc = NULL;
+	int i;
+
+	if (!use_ucall_list)
+		goto out;
+
+	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
+		if (atomic_test_and_set_bit(i, ucall_hdr->in_use))
+			continue;
+
+		uc = &ucall_hdr->ucalls[i];
+	}
+
+out:
+	return uc;
+}
+
+static void ucall_free(struct ucall *uc)
+{
+	if (!use_ucall_list)
+		return;
+
+	clear_bit(uc->idx, ucall_hdr->in_use);
+}
+
+static vm_vaddr_t get_ucall_addr(struct ucall *uc)
+{
+	if (use_ucall_list)
+		return (vm_vaddr_t)uc->hva;
+
+	return (vm_vaddr_t)uc;
+}
 
 void ucall(uint64_t cmd, int nargs, ...)
 {
-	struct ucall uc = {
-		.cmd = cmd,
-	};
+	struct ucall *uc;
+	struct ucall tmp;
 	va_list va;
 	int i;
 
+	uc = ucall_alloc();
+	if (!uc)
+		uc = &tmp;
+
+	uc->cmd = cmd;
+
 	nargs = min(nargs, UCALL_MAX_ARGS);
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
-		uc.args[i] = va_arg(va, uint64_t);
+		uc->args[i] = va_arg(va, uint64_t);
 	va_end(va);
 
-	ucall_arch_do_ucall((vm_vaddr_t)&uc);
+	ucall_arch_do_ucall(get_ucall_addr(uc));
+
+	ucall_free(uc);
+}
+
+static void *get_ucall_hva(struct kvm_vm *vm, uint64_t uc)
+{
+	if (vm->use_ucall_list)
+		return (void *)uc;
+
+	return addr_gva2hva(vm, uc);
 }
 
 uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
@@ -27,7 +127,7 @@ uint64_t get_ucall(struct kvm_vcpu *vcpu, struct ucall *uc)
 	if (!uc)
 		uc = &ucall;
 
-	addr = addr_gva2hva(vcpu->vm, ucall_arch_get_ucall(vcpu));
+	addr = get_ucall_hva(vcpu->vm, ucall_arch_get_ucall(vcpu));
 	if (addr) {
 		memcpy(uc, addr, sizeof(*uc));
 		vcpu_run_complete_io(vcpu);
-- 
2.37.1.455.g008518b4e5-goog

