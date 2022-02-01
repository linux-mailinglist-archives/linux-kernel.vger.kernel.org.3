Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2428B4A5877
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiBAIYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiBAIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:24:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8F4C06173E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:24:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id k25so51272756ejp.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+b47qbaWpdYZN1v9p/s3UrPnbfSBgqc+qjFPZYSPg0=;
        b=QdDeIW90ozVxbtAs28LtZP1SR1njpEwqySsxBFUYrwcKkO/9ik8SD7e63/ORdLuKN6
         HyI3LupM10HaQJNfSiNGnwUgMsJjBe6rmEY71RUCVouSgN2Ww0ih1X5/il7CocKD9jmG
         e5UutqWNP6FOjWmhNqdxTTF5IP65/y2m8Y7DezBkqTOkFj0jP2DTWUAHUNLzCaqt0i7s
         UjBVdk5uVAxkNDd3LrfDYJwUdzSiJbvQ8ICYedqx1BtTCqJrVx2FgSPFfgzmM8UPEfvd
         0QPBGawu4zge1Rk2p7MyHEyooujXJtLlCTeJIQsuvkJSwOX5TavDG/J9JFJUOqdhbPrb
         gLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+b47qbaWpdYZN1v9p/s3UrPnbfSBgqc+qjFPZYSPg0=;
        b=EQIb8WoCvWBemXp/cLTRVQZ+IL473EwOCR7O6+dIf+rV20suVbh07gSMSTFM8FEQJB
         t7mj0AJ7Ie8hEDoMpj4u3619bA6bHK0TrpjOGlYJ2Df+qiL8Bsx34eKv2T3fiHKvS90D
         l35ZcG16rQTTxQAGom2OeTzTYcXMGR3j2kyQc+wppD+nYH5QmrszpCkDX+vW1//95xxB
         pNNbcLOfUO31nULiMYJiq52RhB1imCAPyWf3vQTgC1aoXY4Pquq7/mkXle+p/ThIBeye
         6e+/nM8XgafVXFpRFbNzJO7Fz42AOM6jiUlBdo7lvSTnhjuEfKEMA0awl6mVRaG7dLi6
         FoBA==
X-Gm-Message-State: AOAM533THbojhgMiG4+KJrK2Smdm/NiQqYlbHyswKHb/G3lm7jTtwWMH
        xXdzm+unNl6e0H2kjVLxaMS9Lw==
X-Google-Smtp-Source: ABdhPJyt0wfNRFp/hPqRprYBU3q50Km0sidGpnOTXlGuTS40cAb2L7ml6sR8ZEkCU0opyyQARlSJ+g==
X-Received: by 2002:a17:907:6293:: with SMTP id nd19mr19620284ejc.64.1643703844251;
        Tue, 01 Feb 2022 00:24:04 -0800 (PST)
Received: from localhost.localdomain ([122.179.76.38])
        by smtp.gmail.com with ESMTPSA id w8sm14312133ejq.220.2022.02.01.00.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:24:03 -0800 (PST)
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
Subject: [PATCH 5/6] RISC-V: KVM: Add common kvm_riscv_vcpu_wfi() function
Date:   Tue,  1 Feb 2022 13:52:26 +0530
Message-Id: <20220201082227.361967-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201082227.361967-1-apatel@ventanamicro.com>
References: <20220201082227.361967-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wait for interrupt (WFI) instruction emulation can share the VCPU
halt logic with SBI HSM suspend emulation so this patch adds a common
kvm_riscv_vcpu_wfi() function for this purpose.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/kvm_host.h |  1 +
 arch/riscv/kvm/vcpu_exit.c        | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 99ef6a120617..78da839657e5 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -228,6 +228,7 @@ void kvm_riscv_stage2_vmid_update(struct kvm_vcpu *vcpu);
 
 void __kvm_riscv_unpriv_trap(void);
 
+void kvm_riscv_vcpu_wfi(struct kvm_vcpu *vcpu);
 unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
 					 bool read_insn,
 					 unsigned long guest_addr,
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 571f319e995a..aa8af129e4bb 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -144,12 +144,7 @@ static int system_opcode_insn(struct kvm_vcpu *vcpu,
 {
 	if ((insn & INSN_MASK_WFI) == INSN_MATCH_WFI) {
 		vcpu->stat.wfi_exit_stat++;
-		if (!kvm_arch_vcpu_runnable(vcpu)) {
-			srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
-			kvm_vcpu_halt(vcpu);
-			vcpu->arch.srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
-			kvm_clear_request(KVM_REQ_UNHALT, vcpu);
-		}
+		kvm_riscv_vcpu_wfi(vcpu);
 		vcpu->arch.guest_context.sepc += INSN_LEN(insn);
 		return 1;
 	}
@@ -453,6 +448,21 @@ static int stage2_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	return 1;
 }
 
+/**
+ * kvm_riscv_vcpu_wfi -- Emulate wait for interrupt (WFI) behaviour
+ *
+ * @vcpu: The VCPU pointer
+ */
+void kvm_riscv_vcpu_wfi(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_arch_vcpu_runnable(vcpu)) {
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->arch.srcu_idx);
+		kvm_vcpu_halt(vcpu);
+		vcpu->arch.srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
+	}
+}
+
 /**
  * kvm_riscv_vcpu_unpriv_read -- Read machine word from Guest memory
  *
-- 
2.25.1

