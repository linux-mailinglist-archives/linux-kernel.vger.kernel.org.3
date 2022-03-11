Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055E34D5B18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiCKF7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346714AbiCKFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:54:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE82F1EAC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:17 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id t12-20020a17090a448c00b001b9cbac9c43so4615832pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dT/eOvE+WRX23Q5t+kOORFXcbEma/L7+oPwtuT8Wl1k=;
        b=Ypg8JDkxFk3q2+eigzxvEb8qG8c+Su567Vz0MTkMvceU0QnQXvqi56CiExZxo88Nty
         +yE3ubHh+W09IWhZ6pqoLxEWM8y58JWC+7wv7L/CP4oY8SsAwu6Mbg1QsZSri7aGoYUS
         5/V54butK3A+xjRiibV/A1VP4I9AIsRRQvIjdTZDNKQs3dtzOu5zxyO22M2sSKpeKZMO
         v7GxMsKqtS0No3REMFU/z2OD51K1Vk4VLHqvUrMvFBr7SDZpKExCrBAn7FJOgqVqvBXY
         W8x7Ck7CVRGj62xjpg1lMqjAYswBKtBcp0DEBbXCz7XhB2Phrs0mbGw3Y2tzizlimUNP
         dhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dT/eOvE+WRX23Q5t+kOORFXcbEma/L7+oPwtuT8Wl1k=;
        b=PJ9H1IsAnsGzfRusdxVILwCX5VM4UfshEyaZ6RL/9rv9b5JXTreYQpcQzaEA2QskhJ
         j73l1xtdlQm9V4PD6GJTwADRQdcHK9Hu1I/sWBh5sRW4rjIoUl5CFNIweBe0GJ03ujyZ
         zIo2oLr/ZtP6UpQS1JyrwhUbUM59SyIOTVnbGAp4ltUB8hPKUbcfp+MhIAyoG/JW7znV
         Vc1OkogtSTo1dvWZrvqrrZ8s0I2keM6XqG47gW/CNcpfYVQGPQYuGM6qtYOcuEHdlev7
         lgn+DvGyO1DZNuKgNGSFP3oKeP+8OhoEEqGkpC+zwfwEzpKqsuOjI/IGjVqeiGRAfXz6
         GwzQ==
X-Gm-Message-State: AOAM533fdWgnDenYL8MWahNDiUJTTAwGkn/65Mr+D0MmLE+juGFJ5psn
        zP7qBvj6uKg/hVDxtrOnbyuzTnTOQr9DcOqBVfuguVQDJgSljnb2phc8cAcYFJARoqsnUePWjzt
        uWWA3Ifn9XLNTTziTzZFm9DhgbGSpvHPUgBKUnaxxl4i8+IGDydom5kP2rJ5Erx34ZdPCXQ==
X-Google-Smtp-Source: ABdhPJwMvY5G7stWPNnlBP0tdatZSWEU54XnWgMGviSbOSjFJTPkGBwNcqHvCSlHiQKojBVguoBRrMrzCtI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:7793:0:b0:4f6:27a8:ae6d with SMTP id
 s141-20020a627793000000b004f627a8ae6dmr8700532pfc.65.1646977996447; Thu, 10
 Mar 2022 21:53:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:28 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-78-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 077/105] KVM: selftests: Move vm_is_unrestricted_guest()
 to x86-64
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
 .../selftests/kvm/include/kvm_util_base.h     |  7 ----
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 33 -------------------
 .../selftests/kvm/lib/x86_64/processor.c      | 21 ++++++++++++
 4 files changed, 22 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e1e25ec09158..042c39e474da 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -647,8 +647,6 @@ struct kvm_vcpu *vm_recreate_with_one_vcpu(struct kvm_vm *vm);
  */
 void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code);
 
-bool vm_is_unrestricted_guest(struct kvm_vm *vm);
-
 unsigned int vm_get_page_size(struct kvm_vm *vm);
 unsigned int vm_get_page_shift(struct kvm_vm *vm);
 unsigned long vm_compute_max_gfn(struct kvm_vm *vm);
@@ -675,11 +673,6 @@ struct kvm_userspace_memory_region *
 kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 				 uint64_t end);
 
-struct kvm_dirty_log *
-allocate_kvm_dirty_log(struct kvm_userspace_memory_region *region);
-
-int vm_create_device(struct kvm_vm *vm, struct kvm_create_device *cd);
-
 #define sync_global_to_guest(vm, g) ({				\
 	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
 	memcpy(_p, &(g), sizeof(g));				\
diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index b20de7919411..d67cb5d7fded 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -430,6 +430,7 @@ static inline void vcpu_set_msr(struct kvm_vm *vm, uint32_t vcpuid,
 uint32_t kvm_get_cpuid_max_basic(void);
 uint32_t kvm_get_cpuid_max_extended(void);
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
+bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 
 struct ex_regs {
 	uint64_t rax, rcx, rdx, rbx;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fa880874c8d5..23de0335f22b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1936,39 +1936,6 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva)
 	return addr_gpa2hva(vm, addr_gva2gpa(vm, gva));
 }
 
-/*
- * Is Unrestricted Guest
- *
- * Input Args:
- *   vm - Virtual Machine
- *
- * Output Args: None
- *
- * Return: True if the unrestricted guest is set to 'Y', otherwise return false.
- *
- * Check if the unrestricted guest flag is enabled.
- */
-bool vm_is_unrestricted_guest(struct kvm_vm *vm)
-{
-	char val = 'N';
-	size_t count;
-	FILE *f;
-
-	if (vm == NULL) {
-		/* Ensure that the KVM vendor-specific module is loaded. */
-		close(open_kvm_dev_path_or_exit());
-	}
-
-	f = fopen("/sys/module/kvm_intel/parameters/unrestricted_guest", "r");
-	if (f) {
-		count = fread(&val, sizeof(char), 1, f);
-		TEST_ASSERT(count == 1, "Unable to read from param file.");
-		fclose(f);
-	}
-
-	return val == 'Y';
-}
-
 unsigned int vm_get_page_size(struct kvm_vm *vm)
 {
 	return vm->page_size;
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 289a73262f8c..ea7f1703e51e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1440,3 +1440,24 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 done:
 	return min(max_gfn, ht_gfn - 1);
 }
+
+/* Returns true if kvm_intel was loaded with unrestricted_guest=1. */
+bool vm_is_unrestricted_guest(struct kvm_vm *vm)
+{
+	char val = 'N';
+	size_t count;
+	FILE *f;
+
+	/* Ensure that a KVM vendor-specific module is loaded. */
+	if (vm == NULL)
+		close(open_kvm_dev_path_or_exit());
+
+	f = fopen("/sys/module/kvm_intel/parameters/unrestricted_guest", "r");
+	if (f) {
+		count = fread(&val, sizeof(char), 1, f);
+		TEST_ASSERT(count == 1, "Unable to read from param file.");
+		fclose(f);
+	}
+
+	return val == 'Y';
+}
-- 
2.35.1.723.g4982287a31-goog

