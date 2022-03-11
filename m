Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112A4D5AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346653AbiCKFzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346642AbiCKFw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:52:59 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E469F119D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s5-20020a637705000000b00380cf1d3eb0so3046038pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4OiYQktq5yEzPJAbdBKcckIwJ6abmucl44DuReqop+0=;
        b=WdWsCSRzfmAIMp1rwbN2/Jq0MNgU8dpqEvL4t7v2Nx4psSpYvqdwnXRRlGNGG/I6yM
         ivZx4AWJHTT3StoJ9XP75JgN+FvghBolnXZnv+t5B1amcvTLNxaPdYZk2refWqa3A3H9
         lJGVLZcpzJ4jQzpceo8FA+cAhwFmJajLyHLZG+zaBHZIDX+P1oHBgaYX3n7HIqPGVFF0
         Dc7H6vaPMNF/TWsiLMDy+Rq8fzgvcBo6d3benpmJsJ99xqsR2ShsMV1ka+3bV14mtxZW
         +aJ/5wKDuVvLiXbxjSSQeLTlDb2nhT+CNhVPNPBMOA1LQEPtOtYbkNJItPPpqeB7D5br
         eqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4OiYQktq5yEzPJAbdBKcckIwJ6abmucl44DuReqop+0=;
        b=pdC6su8STpo1HzkIVJTXkXfk8mZ//9NhvQ1221bAiX00pRSYplVTmgruta8elfsfVK
         Q7+cYB23fWukOz6muiBA03igd+61vW0p/mkrU6pjbdGsPTqy92uzX0fk+9qC63suOeF5
         YbODcu1a3w1suJ+1WXWwweLM+7gngtJJf7fOlL2fGeoLUFQLkVLmYzSqHLUn+VFvggs9
         Dmi5rZwGLhCHUAIczy7iywEQ5de4XrdFlATQkSF+7NTpHS3eWVhavfS+J/yK/EF4M4al
         /kp9noB7FopQOlFlkY9J7cv9jcDlzF+aBL3e8m47zY5zVFeInGWqzgT6w8V7TSPfuypU
         oxAA==
X-Gm-Message-State: AOAM533A9/33OEADVQ9bK0tE7rR3puSwsUWxT05wDFV4oMNIJJGxN4A/
        H3pGTEDv+qqfR83c2rvd/2V5h7EFoFjH2whG7sDy800itiWrN8dibIEmFlW2stc/iAtvKTQtdTk
        a9VSxo5bq7ywufJGJ+SzfgBtsnhFSU5y1L6wdqs88Bpa3dSzP/YlG4xraBM+ZKazuAeagrw==
X-Google-Smtp-Source: ABdhPJyx7+g8TL0KjCAgdQonMYEaIpQwxOPM3iaUbRldwOH7lfTq/FGBvq/8SwGQhxlRp/3WOO4Qrvwb418=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:dad2:b0:151:f895:9c31 with SMTP id
 q18-20020a170902dad200b00151f8959c31mr8916964plx.93.1646977916778; Thu, 10
 Mar 2022 21:51:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:41 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-31-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 030/105] KVM: selftests: Return the created vCPU from vm_vcpu_add()
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
 .../selftests/kvm/include/kvm_util_base.h     |  2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index bf9fe3b17705..c64e99b9b6b3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -313,7 +313,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
-void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7ce12a163483..fa880874c8d5 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -413,8 +413,7 @@ struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm)
 {
 	kvm_vm_restart(vm);
 
-	vm_vcpu_add(vm, 0);
-	return vcpu_get(vm, 0);
+	return vm_vcpu_add(vm, 0);
 }
 
 /*
@@ -1058,33 +1057,23 @@ static int vcpu_mmap_sz(void)
 }
 
 /*
- * VM VCPU Add
- *
- * Input Args:
- *   vm - Virtual Machine
- *   vcpuid - VCPU ID
- *
- * Output Args: None
- *
- * Return: None
- *
- * Adds a virtual CPU to the VM specified by vm with the ID given by vcpuid.
- * No additional VCPU setup is done.
+ * Adds a virtual CPU to the VM specified by vm with the ID given by vcpu_id.
+ * No additional vCPU setup is done.  Returns the vCPU.
  */
-void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
+struct kvm_vcpu *vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 {
 	struct kvm_vcpu *vcpu;
 
 	/* Confirm a vcpu with the specified id doesn't already exist. */
-	TEST_ASSERT(!vcpu_find(vm, vcpuid), "vCPU%d already exists\n", vcpuid);
+	TEST_ASSERT(!vcpu_find(vm, vcpu_id), "vCPU%d already exists\n", vcpu_id);
 
 	/* Allocate and initialize new vcpu structure. */
 	vcpu = calloc(1, sizeof(*vcpu));
 	TEST_ASSERT(vcpu != NULL, "Insufficient Memory");
 
 	vcpu->vm = vm;
-	vcpu->id = vcpuid;
-	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpuid);
+	vcpu->id = vcpu_id;
+	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
 	TEST_ASSERT(vcpu->fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, vcpu->fd));
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
@@ -1093,10 +1082,12 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	vcpu->run = (struct kvm_run *) mmap(NULL, vcpu_mmap_sz(),
 		PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd, 0);
 	TEST_ASSERT(vcpu->run != MAP_FAILED, "mmap vcpu_state failed, "
-		"vcpu id: %u errno: %i", vcpuid, errno);
+		"vcpu id: %u errno: %i", vcpu_id, errno);
 
 	/* Add to linked-list of VCPUs. */
 	list_add(&vcpu->list, &vm->vcpus);
+
+	return vcpu;
 }
 
 /*
-- 
2.35.1.723.g4982287a31-goog

