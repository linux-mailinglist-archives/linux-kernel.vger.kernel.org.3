Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8874D5AD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346600AbiCKFxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346577AbiCKFwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:35 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FEBF47FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x10-20020a170902a38a00b00151e09a4e15so3992260pla.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=WkJAS1hr239djJaFPKwZtnJzvkK6HzdcpNTsPKjbQqU=;
        b=pWGPPiqmaibkK8ArhRRP8yjhw/vIinIgDvtfkzKntiIgF5mixGMzT5jH7BYmJ/PlHA
         b3rHdeXdqAlhJB1C/3NBLDUqac2Wy8mfjNiNRX8mnZh6No3tPmBTFKczo6d9LHLwsXzH
         iJWRMPIdLJ4/egJNxgwfYlXU8e/eBVp9nY18LGNSaODrmCi7OwYniLF7x+g31bUpaOV/
         XzvNqCFf2mTnds7cjqVWLrnWUJKVTo0ttDroJXzuomXhfd8DtCWGVosgDlXGcR56pwHO
         jpp4tl3fFfYi2dYsg00jfEnzoIgDlnmLKk3b9qu0vUMPfEbt1uS5ltUMzZ+f+WbiT54J
         1Rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=WkJAS1hr239djJaFPKwZtnJzvkK6HzdcpNTsPKjbQqU=;
        b=b/3Z+hRRMgNioaCCRdlG6l57jBT77CsqfHo0TuBzxD04xdlPPE/nZNWZEXI3cylh0H
         j8U7KNynDxO2qbNoh+2uCIdEKm47K5OqmVTDaz2z85v2TYVEvFd+PfPYogi/lS0kD1QT
         kTPrIhQpxQOlzXZ7QemLbYsn3uX+sWPghF5T2zL2nuJxYIlVs0AST2ccQ+8eAW8moWnG
         +LVqi1mZ1hBDyDp0ZY70igy9QNy642pWXQx3gvsZVYM3VIU54F6lczm+zim5wCci4Md9
         39OFUcAWqbRPWOAc5zxQOAkx0b7s1clxtQ7vxt1Mruc8lO/7P/6NfPeIEI9nB/oWX0+Y
         Qz5Q==
X-Gm-Message-State: AOAM531PO5V6BAuueoLjO/kTusJCI0LzBcMKAKtNoPAqqiJeW7EQpD5U
        lXncA5ocjlNdLao2p8W/exKZePRhExn9BTT0Qa0T7nmF1jPsoNWKOS7WNmgK2yNRRbDW7R4C4wQ
        S8bFnO+oCc0MIHS4IeaFMsXcBeqGAl+tYCTUkMMbgfH6e3lsAkhoSpIintHetFAiOJIsnQw==
X-Google-Smtp-Source: ABdhPJylMCdWfDYHbNdm8XSD3y4fYTR/jC+pweC9vNcCCoxLZhZZebrXAEdKNMhP/GKscmfosKU6ghkqMkY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1354:b0:4c9:1e96:d15c with SMTP id
 k20-20020a056a00135400b004c91e96d15cmr8442831pfu.30.1646977885980; Thu, 10
 Mar 2022 21:51:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:23 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-13-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 012/105] KVM: selftests: Add vcpu_get() to retrieve and
 assert on vCPU existence
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 56 ++++++-------------
 .../selftests/kvm/lib/kvm_util_internal.h     |  2 +-
 .../selftests/kvm/lib/s390x/processor.c       |  5 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  6 +-
 4 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 52fefa51071a..d45f2ec7b13e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -553,23 +553,7 @@ kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 	return &region->region;
 }
 
-/*
- * VCPU Find
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args: None
- *
- * Return:
- *   Pointer to VCPU structure
- *
- * Locates a vcpu structure that describes the VCPU specified by vcpuid and
- * returns a pointer to it.  Returns NULL if the VM doesn't contain a VCPU
- * for the specified vcpuid.
- */
-struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid)
+static struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid)
 {
 	struct vcpu *vcpu;
 
@@ -581,6 +565,14 @@ struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid)
 	return NULL;
 }
 
+struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+
+	TEST_ASSERT(vcpu, "vCPU %d does not exist", vcpuid);
+	return vcpu;
+}
+
 /*
  * VM VCPU Remove
  *
@@ -1530,8 +1522,7 @@ void vm_create_irqchip(struct kvm_vm *vm)
  */
 struct kvm_run *vcpu_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	return vcpu->state;
 }
@@ -1572,11 +1563,9 @@ int _vcpu_run(struct kvm_vm *vm, uint32_t vcpuid)
 
 void vcpu_run_complete_io(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int ret;
 
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
 	vcpu->state->immediate_exit = 1;
 	ret = __vcpu_run(vm, vcpuid);
 	vcpu->state->immediate_exit = 0;
@@ -1618,14 +1607,9 @@ struct kvm_reg_list *vcpu_get_reg_list(struct kvm_vm *vm, uint32_t vcpuid)
 int __vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid,
 		 unsigned long cmd, void *arg)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-	int ret;
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
-	TEST_ASSERT(vcpu != NULL, "vcpu not found, vcpuid: %u", vcpuid);
-
-	ret = ioctl(vcpu->fd, cmd, arg);
-
-	return ret;
+	return ioctl(vcpu->fd, cmd, arg);
 }
 
 void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
@@ -1638,15 +1622,11 @@ void _vcpu_ioctl(struct kvm_vm *vm, uint32_t vcpuid, unsigned long cmd,
 
 void *vcpu_map_dirty_ring(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu;
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 	uint32_t size = vm->dirty_ring_size;
 
 	TEST_ASSERT(size > 0, "Should enable dirty ring first");
 
-	vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu, "Cannot find vcpu %u", vcpuid);
-
 	if (!vcpu->dirty_gfns) {
 		void *addr;
 
@@ -1802,9 +1782,7 @@ int kvm_device_access(int dev_fd, uint32_t group, uint64_t attr,
 int _vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			  uint64_t attr)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu, "nonexistent vcpu id: %d", vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	return _kvm_device_check_attr(vcpu->fd, group, attr);
 }
@@ -1821,9 +1799,7 @@ int vcpu_has_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 int _vcpu_access_device_attr(struct kvm_vm *vm, uint32_t vcpuid, uint32_t group,
 			     uint64_t attr, void *val, bool write)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	TEST_ASSERT(vcpu, "nonexistent vcpu id: %d", vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	return _kvm_device_access(vcpu->fd, group, attr, val, write);
 }
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index a03febc24ba6..0c7c44499129 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -69,7 +69,7 @@ struct kvm_vm {
 	uint32_t dirty_ring_size;
 };
 
-struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid);
+struct vcpu *vcpu_get(struct kvm_vm *vm, uint32_t vcpuid);
 
 /*
  * Virtual Translation Tables Dump
diff --git a/tools/testing/selftests/kvm/lib/s390x/processor.c b/tools/testing/selftests/kvm/lib/s390x/processor.c
index f87c7137598e..7cc1051c4b71 100644
--- a/tools/testing/selftests/kvm/lib/s390x/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390x/processor.c
@@ -208,10 +208,7 @@ void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
 
 void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
-
-	if (!vcpu)
-		return;
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 
 	fprintf(stream, "%*spstate: psw: 0x%.16llx:0x%.16llx\n",
 		indent, "", vcpu->state->psw_mask, vcpu->state->psw_addr);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index fb05bed7ec1e..4065fc4daada 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -841,7 +841,7 @@ uint64_t kvm_get_feature_msr(uint64_t msr_index)
  */
 struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 	struct kvm_cpuid2 *cpuid;
 	int max_ent;
 	int rc = -1;
@@ -1039,7 +1039,7 @@ static int vcpu_save_xsave_state(struct kvm_vm *vm, struct vcpu *vcpu,
 
 struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 	struct kvm_msr_list *list;
 	struct kvm_x86_state *state;
 	int nmsrs, r, i;
@@ -1122,7 +1122,7 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 
 void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *state)
 {
-	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	struct vcpu *vcpu = vcpu_get(vm, vcpuid);
 	int r;
 
 	r = ioctl(vcpu->fd, KVM_SET_SREGS, &state->sregs);
-- 
2.35.1.723.g4982287a31-goog

