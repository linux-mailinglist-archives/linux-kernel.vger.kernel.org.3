Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B074C65DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiB1Jnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiB1Jne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:43:34 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016CD11A16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:52 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id y7so12660734oih.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XFrpl5446IcZeaBBGAxYAn+iPFCIWeU+jYaFG83Q4F0=;
        b=nUz5oGOGwkjD8q6eoZBh47WhGFMt1M5X6sBLyUZp+npRx62JpWftYvp9Dlw8SW7sUg
         9nBeX7Bzu0Hz8ZHQQpo11h6qZR/9MMJJKKmDsR9FS81MAfPMyIQjqw98famYPaOPzuKR
         LfTPILFeIaPXrVz9lOvp859fJd/UXITHlTxHwiZxuBkfRSBpJAy+HKg8mamyrSPRJd1L
         bedTqDDUI15n7Qw0RMA/XmPUtfx1AMfdxW8stkZXdwaXZCdsSc34yU0PORw5SEZEKHzA
         fXuIukIKVOxQF/DrgZzIKHruFqGsAkKGqwJkhc/Nfgg1iKIpJo1hNBr6jWM/qSaSdk5k
         q5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XFrpl5446IcZeaBBGAxYAn+iPFCIWeU+jYaFG83Q4F0=;
        b=UMw9ULQgIvNcpykuESYGlk225GFlJeTUQLt3TcKXjnyvKmQ6ceCm/XYkENZ3raywuZ
         Qkcdx8DiflT0NApgPM+nfZLdHp4/VQTSiSxoWTiBau3tTz22RdF8kF1ADy0M7tjAf511
         ijcKSm/QaQ97vONFSQ+CA6FFNUpZNNRhB6R08Wf8f61G27344BmSRmy1Rfp+NmouLEdK
         I8urNVJtG7xxE8uMQtlpVAIfM4lvc4vftygm8esujCDrvsleCt7Zs2z/DorofNnvwpuc
         cSO9vAxflDmLEQFzKozdsn8/fE70iUnDi7sQQex7LXX3HRMpniOSCxmpcOXROvss742s
         zM1Q==
X-Gm-Message-State: AOAM533Pux/aa10wXL2e5tB+LO73xLoZtLTbMfOSL0F23uGINEKZ4+au
        9myZ2U1gW1uK2PJ2yTgfkqak7EkjjC1gRQ==
X-Google-Smtp-Source: ABdhPJwZNoOfJ9C7fZHdiBbbvjhrpJyYh2oOGF92RPVfvPs8hhXN43YR6nQQoPTOVwhyYo/QuY3ZeA==
X-Received: by 2002:aca:ba83:0:b0:2d4:13f1:8530 with SMTP id k125-20020acaba83000000b002d413f18530mr7607779oif.169.1646041370972;
        Mon, 28 Feb 2022 01:42:50 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm5936852oib.19.2022.02.28.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 01:42:50 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        kvm-riscv@lists.infradead.org, Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 5/6] RISC-V: KVM: Introduce ISA extension register
Date:   Mon, 28 Feb 2022 01:42:32 -0800
Message-Id: <20220228094234.3773153-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228094234.3773153-1-atishp@rivosinc.com>
References: <20220228094234.3773153-1-atishp@rivosinc.com>
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
index aa9f5a5c57d8..e01678aa2a55 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -83,6 +83,23 @@ struct kvm_riscv_timer {
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
@@ -124,6 +141,9 @@ struct kvm_riscv_timer {
 #define KVM_REG_RISCV_FP_D_REG(name)	\
 		(offsetof(struct __riscv_d_ext_state, name) / sizeof(__u64))
 
+/* ISA Extension registers are mapped as type 7 */
+#define KVM_REG_RISCV_ISA_EXT		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
+
 #endif
 
 #endif /* __LINUX_KVM_RISCV_H */
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 7a07dba504f8..c314c40be313 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -364,6 +364,103 @@ static int kvm_riscv_vcpu_set_reg_csr(struct kvm_vcpu *vcpu,
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
+		host_isa_ext_mask = reg_val ? (1 << host_isa_ext) : ~(1 << host_isa_ext);
+		if (!reg_val)
+			vcpu->arch.isa &= host_isa_ext_mask;
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
@@ -381,6 +478,8 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
+		return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
 
 	return -EINVAL;
 }
@@ -402,6 +501,8 @@ static int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
+		return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
 
 	return -EINVAL;
 }
-- 
2.30.2

