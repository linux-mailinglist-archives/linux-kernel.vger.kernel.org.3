Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D24EA882
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 09:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiC2Hbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiC2HbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:31:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD4321E29
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:29:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso1917699pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rXr5EFnwcPfvG4wwHcp5gBTd13vVk723LJlXrxEIl0=;
        b=JUEfuj4EGIOyLkV/IXA9H+MaweDOMgrZPy7qZw8Pyng5lrFo1g12sEgAvyyDoeI+/Z
         YPk2gGUnDX7efP5RkgRPk4mRgN8A2gGZmlzNHpPC9HvA2qQU9wBS+bdi8sfIjs/DsP/w
         xSUYVR13TsKBRnGeCYKcLnwTjvV48fHV5QJ2MB0uRDjihOxUpVGbWsPNpSJkZPwie9pO
         j41Itpr2BFG30RoEPPqklTH4OzYeRSKIMIrDTeaSALBCOyv8omF7HVz6pZOdi8H157h0
         qA2PW3g5DT19eO2KsOy7Dh0jldHhgbiK/7Oq0zHx0pAh1DUrUhFFRjOB4Y4XYBt2n5Ms
         /f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rXr5EFnwcPfvG4wwHcp5gBTd13vVk723LJlXrxEIl0=;
        b=BN3OhtDsm3gzQtBnkbTgGqw5i/hr8Uz7GIsXPuarELrLwBWUX3qDamDkYw3AzFmazB
         61KpxEixJaW4DYu3NsMd5LjgwwQL+LVHxxJKVDOxPQPyYlFUGUMLc80l+ITzFX/k5TIY
         Dva6m7NlSYlTx/6itsvlw7WjJFjdHeTIv3bbcg/r+U8YsD51/oDIUPqPjo+B6ioeVa9b
         opYxawWEPm9qaR9AkT/B9aRIsSS/Tntlceh0SKdO/6FbFXpWohWQ2IyeSDUPWlD+RgSX
         DbcVzvXFBfKirl6CgIkGXqi9lBqXUuEaj16EuxVx1iellnMkwswR74Qa6xahtY4HESOD
         orYA==
X-Gm-Message-State: AOAM532DALdPmPhXNSycrDvcH1aXm71WMO2sYJI3nl8+LM8rlwTjVS5p
        WpwChGSrqqU5WXoKtqcAJedR2A==
X-Google-Smtp-Source: ABdhPJyQsJ0ZlUOLuEkiaRQqfOzbwaJd1hT2x05o7Ql9dQ+kWwo1Qx58V2AZp5og6pJtenzmq+sD/A==
X-Received: by 2002:a17:902:9a98:b0:155:f634:5f37 with SMTP id w24-20020a1709029a9800b00155f6345f37mr14193551plp.86.1648538982243;
        Tue, 29 Mar 2022 00:29:42 -0700 (PDT)
Received: from localhost.localdomain ([122.171.166.231])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm19440564pfh.177.2022.03.29.00.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:29:41 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 3/3] KVM: selftests: riscv: Improve unexpected guest trap handling
Date:   Tue, 29 Mar 2022 12:59:11 +0530
Message-Id: <20220329072911.1692766-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329072911.1692766-1-apatel@ventanamicro.com>
References: <20220329072911.1692766-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we simply hang using "while (1) ;" upon any unexpected
guest traps because the default guest trap handler is guest_hang().

The above approach is not useful to anyone because KVM selftests
users will only see a hung application upon any unexpected guest
trap.

This patch improves unexpected guest trap handling for KVM RISC-V
selftests by doing the following:
1) Return to host user-space
2) Dump VCPU registers
3) Die using TEST_ASSERT(0, ...)

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/include/riscv/processor.h   |  8 +++--
 .../selftests/kvm/lib/riscv/processor.c       |  9 +++---
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 31 +++++++++++++------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index eca5c622efd2..4fcfd1c0389d 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -119,10 +119,12 @@ static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id,
 #define SATP_ASID_SHIFT				44
 #define SATP_ASID_MASK				_AC(0xFFFF, UL)
 
-#define SBI_EXT_EXPERIMENTAL_START	0x08000000
-#define SBI_EXT_EXPERIMENTAL_END	0x08FFFFFF
+#define SBI_EXT_EXPERIMENTAL_START		0x08000000
+#define SBI_EXT_EXPERIMENTAL_END		0x08FFFFFF
 
-#define KVM_RISCV_SELFTESTS_SBI_EXT	SBI_EXT_EXPERIMENTAL_END
+#define KVM_RISCV_SELFTESTS_SBI_EXT		SBI_EXT_EXPERIMENTAL_END
+#define KVM_RISCV_SELFTESTS_SBI_UCALL		0
+#define KVM_RISCV_SELFTESTS_SBI_UNEXP		1
 
 struct sbiret {
 	long error;
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 3961487a4870..56e4705f7744 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -268,10 +268,11 @@ void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
 		core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
 }
 
-static void __aligned(16) guest_hang(void)
+static void __aligned(16) guest_unexp_trap(void)
 {
-	while (1)
-		;
+	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT,
+		  KVM_RISCV_SELFTESTS_SBI_UNEXP,
+		  0, 0, 0, 0, 0, 0);
 }
 
 void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
@@ -310,7 +311,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 
 	/* Setup default exception vector of guest */
 	set_reg(vm, vcpuid, RISCV_CSR_REG(stvec),
-		(unsigned long)guest_hang);
+		(unsigned long)guest_unexp_trap);
 }
 
 void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index 9e42d8248fa6..8550f424d093 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -60,8 +60,9 @@ void ucall(uint64_t cmd, int nargs, ...)
 		uc.args[i] = va_arg(va, uint64_t);
 	va_end(va);
 
-	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT, 0, (vm_vaddr_t)&uc,
-		  0, 0, 0, 0, 0);
+	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT,
+		  KVM_RISCV_SELFTESTS_SBI_UCALL,
+		  (vm_vaddr_t)&uc, 0, 0, 0, 0, 0);
 }
 
 uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
@@ -73,14 +74,24 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
 		memset(uc, 0, sizeof(*uc));
 
 	if (run->exit_reason == KVM_EXIT_RISCV_SBI &&
-	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT &&
-	    run->riscv_sbi.function_id == 0) {
-		memcpy(&ucall, addr_gva2hva(vm, run->riscv_sbi.args[0]),
-			sizeof(ucall));
-
-		vcpu_run_complete_io(vm, vcpu_id);
-		if (uc)
-			memcpy(uc, &ucall, sizeof(ucall));
+	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT) {
+		switch (run->riscv_sbi.function_id) {
+		case KVM_RISCV_SELFTESTS_SBI_UCALL:
+			memcpy(&ucall, addr_gva2hva(vm,
+			       run->riscv_sbi.args[0]), sizeof(ucall));
+
+			vcpu_run_complete_io(vm, vcpu_id);
+			if (uc)
+				memcpy(uc, &ucall, sizeof(ucall));
+
+			break;
+		case KVM_RISCV_SELFTESTS_SBI_UNEXP:
+			vcpu_dump(stderr, vm, vcpu_id, 2);
+			TEST_ASSERT(0, "Unexpected trap taken by guest");
+			break;
+		default:
+			break;
+		}
 	}
 
 	return ucall.cmd;
-- 
2.25.1

