Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D6D522E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiEKIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243757AbiEKIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8B45AD2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq10so1618121pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=IfVlsTAB7z7hMED1dtN6CVJwv02w28SofuIEv8aID38=;
        b=kUs4ehPZnLd+O9p/4BDnqDQkhpIAMDEyA3RjEu3KkBthrdUXYk8CxXqNH7d8xkX/Yr
         ycUya5FVQWnls35kL/H2nCa75zyIIiiiPWMsM4F1ojH73CSRqpcSAQcyu1SovzA120Pp
         bxishhAnO2SGaOVKFoK06QGwPo21zEeff2Pmj9dBM5VL1Zf2c1VMFI6I0m9DeRHCwdXe
         Ho8BWK1v5eFKmYOsIWa/mQKIRTzaKm74kKqb67TQdiNDBaGZSxOYF/Rpv0aK/3GMGajg
         uw7Aek8LfV6LslvTF+Y+js8dWC9iRY+bo59HTZVOsHF6HnXYF+9Rhu8hW2OtqHtr/6SL
         bdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IfVlsTAB7z7hMED1dtN6CVJwv02w28SofuIEv8aID38=;
        b=zS/ziJRW9uqlWNKiv9BYJerHj1NL1Obg+dnv3kmC7h3jj8L74zXELrOR+hKx5qxxXv
         otcihqWAlzUwl4ireObYGv6FItISydsTh/T/sP95WtiDPdzA/QsCyWU4YGFC36+316bB
         H5ti21dczbCwP7qI8S7ppC5Bxqy0bV1tuDpkF9Ho38DNsJYGQ++FSpAsdqyHoKG9Z0Hn
         WNTOV9jp3SpqlAVf2KbzwUUZk6uLnzMBM/XHCyerA42eu/BKzT/oqPzMdZTwPX9KKAwJ
         xeHdraX/Nu6TazNxrhPt0adv6AFk0Xdh3n+CmXf3/fn8xAxJSVbiHyFlgwmtrUmsWR7N
         tb/w==
X-Gm-Message-State: AOAM533JuKfFFeaw8HX9PmDyDQEH73iZ2Fv2OgrJvETPvv9OGcPHfIL2
        CCC0IxnuUHmaXgJhWdEV/5fDJw==
X-Google-Smtp-Source: ABdhPJzLwaHw233DeREMXjw0n96HLjA5QQn/j6XYIJ3JJyY2e/6KchzzZmtlRy4PV1ArPmPG1p0FKw==
X-Received: by 2002:a17:902:e886:b0:15e:8ba0:b749 with SMTP id w6-20020a170902e88600b0015e8ba0b749mr24627356plg.95.1652257916206;
        Wed, 11 May 2022 01:31:56 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:55 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 16/16] riscv: KVM: Add vector lazy save/restore support
Date:   Wed, 11 May 2022 08:31:26 +0000
Message-Id: <8174f9e04cbb55b8bdeceeb0ca6ff2bdd748290c.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

This patch adds vector context save/restore for guest VCPUs. To reduce the
impact on KVM performance, the implementation imitates the FP context
switch mechanism to lazily store and restore the vector context only when
the kernel enters/exits the in-kernel run loop and not during the KVM
world switch.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/kvm_host.h        |   2 +
 arch/riscv/include/asm/kvm_vcpu_vector.h |  65 +++++++++
 arch/riscv/include/uapi/asm/kvm.h        |   6 +
 arch/riscv/kernel/asm-offsets.c          |   7 +
 arch/riscv/kvm/Makefile                  |   1 +
 arch/riscv/kvm/vcpu.c                    |  30 ++++
 arch/riscv/kvm/vcpu_switch.S             |  69 +++++++++
 arch/riscv/kvm/vcpu_vector.c             | 173 +++++++++++++++++++++++
 8 files changed, 353 insertions(+)
 create mode 100644 arch/riscv/include/asm/kvm_vcpu_vector.h
 create mode 100644 arch/riscv/kvm/vcpu_vector.c

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index cd4bbcecb0fb..60fb3de61f5c 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -14,6 +14,7 @@
 #include <linux/kvm_types.h>
 #include <asm/csr.h>
 #include <asm/kvm_vcpu_fp.h>
+#include <asm/kvm_vcpu_vector.h>
 #include <asm/kvm_vcpu_timer.h>
 
 #define KVM_MAX_VCPUS			\
@@ -122,6 +123,7 @@ struct kvm_cpu_context {
 	unsigned long sstatus;
 	unsigned long hstatus;
 	union __riscv_fp_state fp;
+	struct __riscv_v_state vector;
 };
 
 struct kvm_vcpu_csr {
diff --git a/arch/riscv/include/asm/kvm_vcpu_vector.h b/arch/riscv/include/asm/kvm_vcpu_vector.h
new file mode 100644
index 000000000000..1dcc1b2e05bb
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_vcpu_vector.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 SiFive
+ *
+ * Authors:
+ *     Atish Patra <atish.patra@wdc.com>
+ *     Anup Patel <anup.patel@wdc.com>
+ *     Vincent Chen <vincent.chen@sifive.com>
+ *     Greentime Hu <greentime.hu@sifive.com>
+ */
+
+#ifndef __KVM_VCPU_RISCV_VECTOR_H
+#define __KVM_VCPU_RISCV_VECTOR_H
+
+#include <linux/types.h>
+
+struct kvm_cpu_context;
+
+#ifdef CONFIG_VECTOR
+void __kvm_riscv_vector_save(struct kvm_cpu_context *context);
+void __kvm_riscv_vector_restore(struct kvm_cpu_context *context);
+void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu);
+void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
+				      unsigned long isa);
+void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
+					 unsigned long isa);
+void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx);
+void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx);
+void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu);
+#else
+static inline void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
+{
+}
+
+static inline void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
+						    unsigned long isa)
+{
+}
+
+static inline void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
+						       unsigned long isa)
+{
+}
+
+static inline void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
+{
+}
+
+static inline void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
+{
+}
+
+static inline void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
+{
+}
+#endif
+
+int kvm_riscv_vcpu_get_reg_vector(struct kvm_vcpu *vcpu,
+				  const struct kvm_one_reg *reg,
+				  unsigned long rtype);
+int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
+				  const struct kvm_one_reg *reg,
+				  unsigned long rtype);
+#endif
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index f808ad1ce500..b16e2f72eeee 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -123,6 +123,12 @@ struct kvm_riscv_timer {
 #define KVM_REG_RISCV_FP_D_REG(name)	\
 		(offsetof(struct __riscv_d_ext_state, name) / sizeof(__u64))
 
+/* V extension registers are mapped as type 7 */
+#define KVM_REG_RISCV_VECTOR		(0x07 << KVM_REG_RISCV_TYPE_SHIFT)
+#define KVM_REG_RISCV_VECTOR_CSR_REG(name)	\
+		(offsetof(struct __riscv_v_state, name) / sizeof(unsigned long))
+#define KVM_REG_RISCV_VECTOR_REG(n)	\
+		((n) + sizeof(struct __riscv_v_state) / sizeof(unsigned long))
 #endif
 
 #endif /* __LINUX_KVM_RISCV_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 80316ef7bb78..2540b9146072 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -278,6 +278,13 @@ void asm_offsets(void)
 	OFFSET(KVM_ARCH_FP_D_F31, kvm_cpu_context, fp.d.f[31]);
 	OFFSET(KVM_ARCH_FP_D_FCSR, kvm_cpu_context, fp.d.fcsr);
 
+	/* V extension */
+
+	OFFSET(KVM_ARCH_VECTOR_VSTART, kvm_cpu_context, vector.vstart);
+	OFFSET(KVM_ARCH_VECTOR_VL, kvm_cpu_context, vector.vl);
+	OFFSET(KVM_ARCH_VECTOR_VTYPE, kvm_cpu_context, vector.vtype);
+	OFFSET(KVM_ARCH_VECTOR_VCSR, kvm_cpu_context, vector.vcsr);
+	OFFSET(KVM_ARCH_VECTOR_DATAP, kvm_cpu_context, vector.datap);
 	/*
 	 * THREAD_{F,X}* might be larger than a S-type offset can handle, but
 	 * these are used in performance-sensitive assembly so we can't resort
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index e5c56182f48f..acf39cd87fbb 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -17,6 +17,7 @@ kvm-y += mmu.o
 kvm-y += vcpu.o
 kvm-y += vcpu_exit.o
 kvm-y += vcpu_fp.o
+kvm-y += vcpu_vector.o
 kvm-y += vcpu_switch.o
 kvm-y += vcpu_sbi.o
 kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index c0a3be86d613..c3e941dffcd4 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -19,6 +19,7 @@
 #include <linux/kvm_host.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
+#include <asm/switch_to.h>
 
 const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
 	KVM_GENERIC_VCPU_STATS(),
@@ -74,6 +75,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_riscv_vcpu_fp_reset(vcpu);
 
+	kvm_riscv_vcpu_vector_reset(vcpu);
+
 	kvm_riscv_vcpu_timer_reset(vcpu);
 
 	WRITE_ONCE(vcpu->arch.irqs_pending, 0);
@@ -110,6 +113,15 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	cntx->hstatus |= HSTATUS_SPVP;
 	cntx->hstatus |= HSTATUS_SPV;
 
+	if (has_vector()) {
+		cntx->vector.datap = kmalloc(riscv_vsize, GFP_KERNEL);
+		if (!cntx->vector.datap)
+			return -ENOMEM;
+		vcpu->arch.host_context.vector.datap = kzalloc(riscv_vsize, GFP_KERNEL);
+		if (!vcpu->arch.host_context.vector.datap)
+			return -ENOMEM;
+	}
+
 	/* By default, make CY, TM, and IR counters accessible in VU mode */
 	reset_csr->scounteren = 0x7;
 
@@ -140,6 +152,9 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 	/* Free unused pages pre-allocated for Stage2 page table mappings */
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+
+	/* Free vector context space for host and guest kernel */
+	kvm_riscv_vcpu_free_vector_context(vcpu);
 }
 
 int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
@@ -383,6 +398,9 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_VECTOR)
+		return kvm_riscv_vcpu_set_reg_vector(vcpu, reg,
+						 KVM_REG_RISCV_VECTOR);
 
 	return -EINVAL;
 }
@@ -404,6 +422,9 @@ static int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
 	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
 		return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
 						 KVM_REG_RISCV_FP_D);
+	else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_VECTOR)
+		return kvm_riscv_vcpu_get_reg_vector(vcpu, reg,
+						 KVM_REG_RISCV_VECTOR);
 
 	return -EINVAL;
 }
@@ -643,6 +664,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	kvm_riscv_vcpu_host_fp_save(&vcpu->arch.host_context);
 	kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
 					vcpu->arch.isa);
+	kvm_riscv_vcpu_host_vector_save(&vcpu->arch.host_context);
+	kvm_riscv_vcpu_guest_vector_restore(&vcpu->arch.guest_context,
+					    vcpu->arch.isa);
 
 	vcpu->cpu = cpu;
 }
@@ -657,6 +681,12 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 				     vcpu->arch.isa);
 	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
 
+	kvm_riscv_vcpu_guest_vector_save(&vcpu->arch.guest_context,
+					 vcpu->arch.isa);
+	kvm_riscv_vcpu_host_vector_restore(&vcpu->arch.host_context);
+
+	csr_write(CSR_HGATP, 0);
+
 	csr->vsstatus = csr_read(CSR_VSSTATUS);
 	csr->vsie = csr_read(CSR_VSIE);
 	csr->vstvec = csr_read(CSR_VSTVEC);
diff --git a/arch/riscv/kvm/vcpu_switch.S b/arch/riscv/kvm/vcpu_switch.S
index d74df8eb4d71..730dc9b8c644 100644
--- a/arch/riscv/kvm/vcpu_switch.S
+++ b/arch/riscv/kvm/vcpu_switch.S
@@ -406,3 +406,72 @@ __kvm_riscv_fp_d_restore:
 	csrw CSR_SSTATUS, t2
 	ret
 #endif
+
+#ifdef CONFIG_VECTOR
+
+#define vstatep  a0
+#define datap    a1
+#define x_vstart t0
+#define x_vtype  t1
+#define x_vl     t2
+#define x_vcsr   t3
+#define incr     t4
+#define status   t5
+
+ENTRY(__kvm_riscv_vector_save)
+	li      status, SR_VS
+	csrs    CSR_STATUS, status
+
+	li	a2, KVM_ARCH_VECTOR_DATAP
+	add	datap, a0, a2
+	ld	datap, (datap)
+	csrr    x_vstart, CSR_VSTART
+	csrr    x_vtype, CSR_VTYPE
+	csrr    x_vl, CSR_VL
+	csrr    x_vcsr, CSR_VCSR
+	vsetvli incr, x0, e8, m8, ta, ma
+	vse8.v   v0, (datap)
+	add     datap, datap, incr
+	vse8.v   v8, (datap)
+	add     datap, datap, incr
+	vse8.v   v16, (datap)
+	add     datap, datap, incr
+	vse8.v   v24, (datap)
+
+	REG_S   x_vstart, KVM_ARCH_VECTOR_VSTART(vstatep)
+	REG_S   x_vtype, KVM_ARCH_VECTOR_VTYPE(vstatep)
+	REG_S   x_vl, KVM_ARCH_VECTOR_VL(vstatep)
+	REG_S   x_vcsr, KVM_ARCH_VECTOR_VCSR(vstatep)
+
+	csrc	CSR_STATUS, status
+	ret
+ENDPROC(__kvm_riscv_vector_save)
+
+ENTRY(__kvm_riscv_vector_restore)
+	li      status, SR_VS
+	csrs    CSR_STATUS, status
+
+	li	a2, KVM_ARCH_VECTOR_DATAP
+	add	datap, a0, a2
+	ld	datap, (datap)
+	vsetvli incr, x0, e8, m8, ta, ma
+	vle8.v   v0, (datap)
+	add     datap, datap, incr
+	vle8.v   v8, (datap)
+	add     datap, datap, incr
+	vle8.v   v16, (datap)
+	add     datap, datap, incr
+	vle8.v   v24, (datap)
+
+	REG_L   x_vstart, KVM_ARCH_VECTOR_VSTART(vstatep)
+	REG_L   x_vtype, KVM_ARCH_VECTOR_VTYPE(vstatep)
+	REG_L   x_vl, KVM_ARCH_VECTOR_VL(vstatep)
+	REG_L   x_vcsr, KVM_ARCH_VECTOR_VCSR(vstatep)
+	vsetvl  x0, x_vl, x_vtype
+	csrw    CSR_VSTART, x_vstart
+	csrw    CSR_VCSR, x_vcsr
+
+	csrc	CSR_STATUS, status
+	ret
+ENDPROC(__kvm_riscv_vector_restore)
+#endif
diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
new file mode 100644
index 000000000000..37bf4ffd47dd
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 SiFive
+ *
+ * Authors:
+ *     Atish Patra <atish.patra@wdc.com>
+ *     Anup Patel <anup.patel@wdc.com>
+ *     Vincent Chen <vincent.chen@sifive.com>
+ *     Greentime Hu <greentime.hu@sifive.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <linux/uaccess.h>
+#include <asm/hwcap.h>
+
+#ifdef CONFIG_VECTOR
+extern unsigned long riscv_vsize;
+void kvm_riscv_vcpu_vector_reset(struct kvm_vcpu *vcpu)
+{
+	unsigned long isa = vcpu->arch.isa;
+	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
+
+	cntx->sstatus &= ~SR_VS;
+	if (riscv_isa_extension_available(&isa, v))
+		cntx->sstatus |= SR_VS_INITIAL;
+	else
+		cntx->sstatus |= SR_VS_OFF;
+
+	memset(cntx->vector.datap, 0, riscv_vsize);
+}
+
+static void kvm_riscv_vcpu_vector_clean(struct kvm_cpu_context *cntx)
+{
+	cntx->sstatus &= ~SR_VS;
+	cntx->sstatus |= SR_VS_CLEAN;
+}
+
+void kvm_riscv_vcpu_guest_vector_save(struct kvm_cpu_context *cntx,
+				      unsigned long isa)
+{
+	if ((cntx->sstatus & SR_VS) == SR_VS_DIRTY) {
+		if (riscv_isa_extension_available(&isa, v))
+			__kvm_riscv_vector_save(cntx);
+		kvm_riscv_vcpu_vector_clean(cntx);
+	}
+}
+
+void kvm_riscv_vcpu_guest_vector_restore(struct kvm_cpu_context *cntx,
+					 unsigned long isa)
+{
+	if ((cntx->sstatus & SR_VS) != SR_VS_OFF) {
+		if (riscv_isa_extension_available(&isa, v))
+			__kvm_riscv_vector_restore(cntx);
+		kvm_riscv_vcpu_vector_clean(cntx);
+	}
+}
+
+void kvm_riscv_vcpu_host_vector_save(struct kvm_cpu_context *cntx)
+{
+	/* No need to check host sstatus as it can be modified outside */
+	__kvm_riscv_vector_save(cntx);
+}
+
+void kvm_riscv_vcpu_host_vector_restore(struct kvm_cpu_context *cntx)
+{
+	__kvm_riscv_vector_restore(cntx);
+}
+
+void kvm_riscv_vcpu_free_vector_context(struct kvm_vcpu *vcpu)
+{
+	kfree(vcpu->arch.guest_reset_context.vector.datap);
+	kfree(vcpu->arch.host_context.vector.datap);
+}
+#else
+#define riscv_vsize (0)
+#endif
+
+static void *kvm_riscv_vcpu_vreg_addr(struct kvm_vcpu *vcpu,
+				      unsigned long reg_num,
+				      size_t reg_size)
+{
+	struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
+	void *reg_val;
+	size_t vlenb = riscv_vsize / 32;
+
+	if (reg_num < KVM_REG_RISCV_VECTOR_REG(0)) {
+		if (reg_size != sizeof(unsigned long))
+			return NULL;
+		switch (reg_num) {
+		case KVM_REG_RISCV_VECTOR_CSR_REG(vstart):
+			reg_val = &cntx->vector.vstart;
+			break;
+		case KVM_REG_RISCV_VECTOR_CSR_REG(vl):
+			reg_val = &cntx->vector.vl;
+			break;
+		case KVM_REG_RISCV_VECTOR_CSR_REG(vtype):
+			reg_val = &cntx->vector.vtype;
+			break;
+		case KVM_REG_RISCV_VECTOR_CSR_REG(vcsr):
+			reg_val = &cntx->vector.vcsr;
+			break;
+		case KVM_REG_RISCV_VECTOR_CSR_REG(datap):
+		default:
+			return NULL;
+		}
+	} else if (reg_num <= KVM_REG_RISCV_VECTOR_REG(31)) {
+		if (reg_size != vlenb)
+			return NULL;
+		reg_val = cntx->vector.datap
+			  + (reg_num - KVM_REG_RISCV_VECTOR_REG(0)) * vlenb;
+	} else {
+		return NULL;
+	}
+
+	return reg_val;
+}
+
+int kvm_riscv_vcpu_get_reg_vector(struct kvm_vcpu *vcpu,
+				  const struct kvm_one_reg *reg,
+				  unsigned long rtype)
+{
+	unsigned long isa = vcpu->arch.isa;
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    rtype);
+	void *reg_val;
+	size_t reg_size = KVM_REG_SIZE(reg->id);
+
+	if ((rtype == KVM_REG_RISCV_VECTOR) &&
+	    riscv_isa_extension_available(&isa, v)) {
+		reg_val = kvm_riscv_vcpu_vreg_addr(vcpu, reg_num, reg_size);
+	}
+
+	if (!reg_val)
+		return -EINVAL;
+
+	if (copy_to_user(uaddr, reg_val, reg_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
+				  const struct kvm_one_reg *reg,
+				  unsigned long rtype)
+{
+	unsigned long isa = vcpu->arch.isa;
+	unsigned long __user *uaddr =
+			(unsigned long __user *)(unsigned long)reg->addr;
+	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
+					    KVM_REG_SIZE_MASK |
+					    rtype);
+	void *reg_val = NULL;
+	size_t reg_size = KVM_REG_SIZE(reg->id);
+
+	if ((rtype == KVM_REG_RISCV_VECTOR) &&
+	    riscv_isa_extension_available(&isa, v)) {
+		reg_val = kvm_riscv_vcpu_vreg_addr(vcpu, reg_num, reg_size);
+	}
+
+	if (!reg_val)
+		return -EINVAL;
+
+	if (copy_from_user(reg_val, uaddr, reg_size))
+		return -EFAULT;
+
+	return 0;
+}
-- 
2.17.1

