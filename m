Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B850BB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449184AbiDVPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350646AbiDVPK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:10:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598D14028
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:08:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d15so11439822pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4HaIW/vxFAL44m1pOYXWPSNjY/gkA+yaMxMowC6UUM=;
        b=v0yY2R8anlaP/oXUeyvIuBz1bJ/Ft2t9uPTLDaU7VRCg2UMWEne0FaGoIMuLhAvDvu
         fyd5DEUOogCYx/7B+KeGRvTwsQktkcgPZEOqzuBFm0jkCW787d/Z5/d9YGdVTHTNfBbb
         DOhb+PyEJLMkYRR3scNH9EZzd+IXcIugnhI/n0n1a93AFt0O9XTyPCHDak7o1uAIoi5L
         cY/l85WP47swuKNjv3Xa01tCNRLu8abSXhgYjCu30drNsxyUIezsZkv+vmz6tk4cqXSZ
         2ECGtvtYty7kcVTrWFNrm4me/iVkiRjpTpXdghrFcCO6oyECxb6x9T4MyDIGVxaBK2r8
         oSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K4HaIW/vxFAL44m1pOYXWPSNjY/gkA+yaMxMowC6UUM=;
        b=HOunr23IMw1HOxymSZhImp4V7aeDCj5WVbdsQmE9ecYp/rKDlkDWjPbZzVnX43LVPg
         9j62ve1NTKIAMR9tjwkIBJ9m9+T0gjPB7N/zB0/9dKKZifl83JTV4XVF6MqJHzC7hItD
         Vo9Eai1VhZ4FKxagcm7iQZ+NUigthYQg02qUfRs25hfI3vqccQXwGKa20e3FCHeL37UR
         fZRL0m/DcaOKpBoM1e/tkdGhptlyLmsCF1zy8OJB/9GnYiXFIZmKRH0r3MnI6Ifh6uI4
         WzD+HaoKds2J4ZA9LNZ14r+OsuJPxFZk4hFWlseQ4iBsTjkrkECKIGC98tRn7DmafZM3
         aXKw==
X-Gm-Message-State: AOAM533A05SthogKiU9nAwhDDycBtylCwlJ6Y4ZCW9tJHMuYtyFGEHqE
        kMoyNoxz/xqe2Exf18F8U1he7A==
X-Google-Smtp-Source: ABdhPJx5ATBOzB5TKDH52ypXORAEGKGhYrvejRrJXxN1YQ/2irwp3TANehXl6sHyPzQ8YUMPnMaWWw==
X-Received: by 2002:a17:90b:19d7:b0:1c7:3413:87e0 with SMTP id nm23-20020a17090b19d700b001c7341387e0mr5966941pjb.132.1650640082435;
        Fri, 22 Apr 2022 08:08:02 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a030c00b001d5793b6f71sm6650605pje.13.2022.04.22.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:08:01 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     kvm@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, kvm-riscv@lists.infradead.org
Subject: [v2 PATCH] RISC-V: KVM: Introduce ISA extension register
Date:   Fri, 22 Apr 2022 08:05:19 -0700
Message-Id: <20220422150519.3818093-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no provision for vmm (qemu-kvm or kvmtool) to
query about multiple-letter ISA extensions. The config register
is only used for base single letter ISA extensions.

A new ISA extension register is added that will allow the vmm
to query about any ISA extension one at a time. It is enabled for
both single letter or multi-letter ISA extensions. The ISA extension
register is useful to if the vmm requires to retrieve/set single
extension while the config register should be used if all the base
ISA extension required to retrieve or set.

For any multi-letter ISA extensions, the new register interface
must be used.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
Changes from v1->v2:
1. Sending the patch separate from sstc series as it is unrelated.
2. Removed few redundant lines.

The kvm tool patches can be found here.

https://github.com/atishp04/kvmtool/tree/sstc_v2

---
 arch/riscv/include/uapi/asm/kvm.h | 20 +++++++
 arch/riscv/kvm/vcpu.c             | 98 +++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index f808ad1ce500..92bd469e2ba6 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -82,6 +82,23 @@ struct kvm_riscv_timer {
 	__u64 state;
 };
 
+/**
+ * ISA extension IDs specific to KVM. This is not the same as the host ISA
+ * extension IDs as that is internal to the host and should not be exposed
+ * to the guest. This should always be contiguous to keep the mapping simple
+ * in KVM implementation.
+ */
+enum KVM_RISCV_ISA_EXT_ID {
+	KVM_RISCV_ISA_EXT_A = 0,
+	KVM_RISCV_ISA_EXT_C,
+	KVM_RISCV_ISA_EXT_D,
+	KVM_RISCV_ISA_EXT_F,
+	KVM_RISCV_ISA_EXT_H,
+	KVM_RISCV_ISA_EXT_I,
+	KVM_RISCV_ISA_EXT_M,
+	KVM_RISCV_ISA_EXT_MAX,
+};
+
 /* Possible states for kvm_riscv_timer */
 #define KVM_RISCV_TIMER_STATE_OFF	0
 #define KVM_RISCV_TIMER_STATE_ON	1
@@ -123,6 +140,9 @@ struct kvm_riscv_timer {
 #define KVM_REG_RISCV_FP_D_REG(name)	\
 		(offsetof(struct __riscv_d_ext_state, name) / sizeof(__u64))
 
+/* ISA Extension registers are mapped as type 7 */
+#define KVM_REG_RISCV_ISA_EXT		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
+
 #endif
 
 #endif /* __LINUX_KVM_RISCV_H */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index aad430668bb4..93492eb292fd 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -365,6 +365,100 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/* Mapping between KVM ISA Extension ID & Host ISA extension ID */
+static unsigned long kvm_isa_ext_arr[] = {
+	RISCV_ISA_EXT_a,
+	RISCV_ISA_EXT_c,
+	RISCV_ISA_EXT_d,
+	RISCV_ISA_EXT_f,
+	RISCV_ISA_EXT_h,
+	RISCV_ISA_EXT_i,
+	RISCV_ISA_EXT_m,
+};
+
+static int kvm_riscv_vcpu_get_reg_isa_ext(struct kvm_vcpu *vcpu,
+					  const struct kvm_one_reg *reg)
+{
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    KVM_REG_RISCV_ISA_EXT);
+	unsigned long reg_val = 0;
+	unsigned long host_isa_ext;
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+		return -EINVAL;
+
+	if (reg_num >= KVM_RISCV_ISA_EXT_MAX || reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
+		return -EINVAL;
+
+	host_isa_ext = kvm_isa_ext_arr[reg_num];
+	if (__riscv_isa_extension_available(NULL, host_isa_ext))
+		reg_val = 1; /* Mark the given extension as available */
+
+	if (copy_to_user(uaddr, &reg_val, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_vcpu *vcpu,
+					  const struct kvm_one_reg *reg)
+{
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    KVM_REG_RISCV_ISA_EXT);
+	unsigned long reg_val;
+	unsigned long host_isa_ext;
+	unsigned long host_isa_ext_mask;
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
+		return -EINVAL;
+
+	if (reg_num >= KVM_RISCV_ISA_EXT_MAX || reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
+		return -EINVAL;
+
+	if (copy_from_user(&reg_val, uaddr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	host_isa_ext = kvm_isa_ext_arr[reg_num];
+	if (!__riscv_isa_extension_available(NULL, host_isa_ext))
+		return	-EOPNOTSUPP;
+
+	if (host_isa_ext >= RISCV_ISA_EXT_BASE &&
+	    host_isa_ext < RISCV_ISA_EXT_MAX) {
+		/** Multi-letter ISA extension. Currently there is no provision
+		 * to enable/disable the multi-letter ISA extensions for guests.
+		 * Return success if the request is to enable any ISA extension
+		 * that is available in the hardware.
+		 * Return -EOPNOTSUPP otherwise.
+		 */
+		if (!reg_val)
+			return -EOPNOTSUPP;
+		else
+			return 0;
+	}
+
+	/* Single letter base ISA extension */
+	if (!vcpu->arch.ran_atleast_once) {
+		host_isa_ext_mask = BIT_MASK(host_isa_ext);
+		if (!reg_val && (host_isa_ext_mask & KVM_RISCV_ISA_DISABLE_ALLOWED))
+			vcpu->arch.isa &= ~host_isa_ext_mask;
+		else
+			vcpu->arch.isa |= host_isa_ext_mask;
+		vcpu->arch.isa &= riscv_isa_extension_base(NULL);
+		vcpu->arch.isa &= KVM_RISCV_ISA_ALLOWED;
+		kvm_riscv_vcpu_fp_reset(vcpu);
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 				  const struct kvm_one_reg *reg)
 {
@@ -382,6 +476,8 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
+		return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
 
 	return -EINVAL;
 }
@@ -403,6 +499,8 @@ static int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
+		return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
 
 	return -EINVAL;
 }
-- 
2.25.1

