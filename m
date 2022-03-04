Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902DC4CDDE6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiCDUP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiCDUPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:15:38 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D81E323A7E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:11:29 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id x3so7446777qvd.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wru3M1yMPyEFqwSTOW5mW4tskJC8ZDyyBoca3oJyRA=;
        b=G/n2GmKp91RxjtIcKoNLY3aPhTFHRvaWNSNT7e+Poso3oCfU9EFH09jY3oilnkw8g5
         IR98aMxBJmioNNveW4kY5u+tBXMIuNob15L+GTIDhOcwcTMsqaDK+ba/Ta/9EF8cnUxR
         IJs7MHMrlNMJLjBv/JYaupxcYL5KWOw/ps/jjsPN5IExdCksxTIcUzr8AtoyhEXDdgOS
         Iv5xSBvJLu+dQdg6YwgiA8cDcevodKMMDW+0VcQSM1h6k5JSoQVBBrkmRGzq8ax7Royo
         IbZ6BWtkqOcv4ebACg12b9tJSAduqWWbn8DJolDpaxw/Yyd7WqZn6rb2tQ/I+7ojiPAH
         +/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wru3M1yMPyEFqwSTOW5mW4tskJC8ZDyyBoca3oJyRA=;
        b=n1Wq1m0rsIXinLMxyuCvAk3aA4g2DAA3frQrsBLiPrFcBilae+QeydNeFOnMOb3dUh
         1RbG5O4f+XAFDaoIw1gbh36RxZvecq7117zHuspi2Q3Y3WW3aT7WA34/+9ueOFA1t0ty
         Rdc2ZHrCGJHclwj2sfWTcWeyQBuEXwniVJSLtsxYj7r5w0fy/n0s33PvAjiP+syJyC9X
         6pgjwADjqXNwqsacgOZVdwZezgFbFdDjDBS3UQyZj1MV48wCC9SO1dz10RSKltit0D77
         eIXke0m93lqzdQW4qqaR64LlWdiEnUWwuT40U+Hmleqg8vT9yq0JGoZYzGQszp2K0N9c
         P/WQ==
X-Gm-Message-State: AOAM530E0LFXLnliz3FKuIs++Pp17oIZa2KpVcyCZ/XX7Bf02X2C0gT8
        5TlSQKZpkIr6AjNvGbotRV6enu9dmHNqcA==
X-Google-Smtp-Source: ABdhPJwZyBYqJUXAuZTvlZXfoYOfmgkICsgs3Sp5Nz6XMt3sMwLXKzPOsJ8HcqSp+EhZ40MSNHpD4g==
X-Received: by 2002:ad4:44a8:0:b0:435:16c8:76bb with SMTP id n8-20020ad444a8000000b0043516c876bbmr46624qvt.117.1646424649236;
        Fri, 04 Mar 2022 12:10:49 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id 20-20020ac84e94000000b002de8f564305sm4605481qtp.1.2022.03.04.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:10:48 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH v2 6/7] RISC-V: KVM: Introduce ISA extension register
Date:   Fri,  4 Mar 2022 12:10:19 -0800
Message-Id: <20220304201020.810380-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304201020.810380-1-atishp@rivosinc.com>
References: <20220304201020.810380-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/riscv/include/uapi/asm/kvm.h |  20 ++++++
 arch/riscv/kvm/vcpu.c             | 101 ++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

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
index 388e83857ced..a3ae7042c696 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -365,6 +365,103 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
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
@@ -382,6 +479,8 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
+		return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
 
 	return -EINVAL;
 }
@@ -403,6 +502,8 @@ static int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
+		return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
 
 	return -EINVAL;
 }
-- 
2.30.2

