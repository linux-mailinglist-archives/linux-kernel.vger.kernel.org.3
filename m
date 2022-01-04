Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E64848D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiADTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiADTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:49:32 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16766C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 11:49:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p1-20020a17090a680100b001b1ea621b81so24726743pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 11:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WOQR0x45o+OfHKeVBsrSlnY9CdZeeg7PtH18n9vnXnA=;
        b=k/AbiCi4StdZmLssmcQK+rCb4X/Hqs2gTzjBmkOQMTeqtLHfDrV3AAiSd8hSHuUTWs
         emZpIPCULImD9YxOwuy5RvwTKIByBiS+tq8asWxB6OPXEkTQStwqWxCthkTWXjzy/46D
         rcZ+KYa0Ji8HWO1vBmnBjaRsmIuH3yqNgg4B4/LLjGoj/jkVVGu8aBu0Frred9rh3TVN
         NGj7wvh9AmkJ2YJBByCwRhP7+6JLxpCgMRK7rSu4NW+6MTUrFyOxuwK6S1TJKkQjhmSo
         frpHj02qS7QAHQtgx0CyDXWUZ9BotrtoG/Wo+o2ZuMx9mgyWDbqSmglIHnOlrilzQ9Gf
         zxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WOQR0x45o+OfHKeVBsrSlnY9CdZeeg7PtH18n9vnXnA=;
        b=jzWoO9/mPIaWfK1DqTA8SdJoC8MOCaKv0L1QkfZcIb+PLb+99LxFjYtd802aBpgpM4
         21/wdLebEN5bo8hC0xovXSB5QFuT/WUBP7SrDz7gL/l+GNJE2bxQNVIdsXol8n1uGvK+
         TaFFVgCWm/flX6mXWX1R+9iRqMH5Nic3ZgjxFezwfVvDzfdvFP+pQdemJGizbz1lam+p
         YKccJQKAlrwM9jRg+4mEFXbPyyzRkE0GmRHQrPd7NUg3UgbQ6AgbIrBWbwNP1h0NkwMR
         T8rHUNqCRVozMY8oYvqdLxcJH2+R6/eGlh0gOQpCK/Pog9aPlH0Sl1op32fFte/KP5D7
         3nfA==
X-Gm-Message-State: AOAM533UpjoqhDYEKH1GWHew3BWdyIsIN7jzxu8x/7bL+qqKZc1y3cye
        My1XMsdVTYuq4fZc5j1pNh3yyo+Mi00Q
X-Google-Smtp-Source: ABdhPJy4tj6cLKOVUVB+3uN6Lxc2oi/1CUIrrNriLYLr8YFh0+FHYTCblyAJ5u5+6dJa85R0lc9Otvmgzcan
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90b:3e83:: with SMTP id
 rj3mr60585465pjb.132.1641325771561; Tue, 04 Jan 2022 11:49:31 -0800 (PST)
Date:   Tue,  4 Jan 2022 19:49:09 +0000
In-Reply-To: <20220104194918.373612-1-rananta@google.com>
Message-Id: <20220104194918.373612-3-rananta@google.com>
Mime-Version: 1.0
References: <20220104194918.373612-1-rananta@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [RFC PATCH v3 02/11] KVM: arm64: Factor out firmware register
 handling from psci.c
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common hypercall firmware register handing is currently employed
by psci.c. Since the upcoming patches add more of these registers,
it's better to move the generic handling to hypercall.c for a
cleaner presentation.

While we are at it, collect all the firmware registers under
fw_reg_ids[] to help implement kvm_arm_get_fw_num_regs() and
kvm_arm_copy_fw_reg_indices() in a generic way.

No functional change intended.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/guest.c       |   2 +-
 arch/arm64/kvm/hypercalls.c  | 170 +++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/psci.c        | 166 ----------------------------------
 include/kvm/arm_hypercalls.h |   7 ++
 include/kvm/arm_psci.h       |   7 --
 5 files changed, 178 insertions(+), 174 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index e116c7767730..8238e52d890d 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -18,7 +18,7 @@
 #include <linux/string.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
-#include <kvm/arm_psci.h>
+#include <kvm/arm_hypercalls.h>
 #include <asm/cputype.h>
 #include <linux/uaccess.h>
 #include <asm/fpsimd.h>
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 30da78f72b3b..3c2fcf31ad3d 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -146,3 +146,173 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	smccc_set_retval(vcpu, val[0], val[1], val[2], val[3]);
 	return 1;
 }
+
+static const u64 kvm_arm_fw_reg_ids[] = {
+	KVM_REG_ARM_PSCI_VERSION,
+	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1,
+	KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2,
+};
+
+int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
+{
+	return ARRAY_SIZE(kvm_arm_fw_reg_ids);
+}
+
+int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(kvm_arm_fw_reg_ids); i++) {
+		if (put_user(kvm_arm_fw_reg_ids[i], uindices++))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define KVM_REG_FEATURE_LEVEL_WIDTH	4
+#define KVM_REG_FEATURE_LEVEL_MASK	(BIT(KVM_REG_FEATURE_LEVEL_WIDTH) - 1)
+
+/*
+ * Convert the workaround level into an easy-to-compare number, where higher
+ * values mean better protection.
+ */
+static int get_kernel_wa_level(u64 regid)
+{
+	switch (regid) {
+	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
+		switch (arm64_get_spectre_v2_state()) {
+		case SPECTRE_VULNERABLE:
+			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
+		case SPECTRE_MITIGATED:
+			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL;
+		case SPECTRE_UNAFFECTED:
+			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED;
+		}
+		return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
+	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
+		switch (arm64_get_spectre_v4_state()) {
+		case SPECTRE_MITIGATED:
+			/*
+			 * As for the hypercall discovery, we pretend we
+			 * don't have any FW mitigation if SSBS is there at
+			 * all times.
+			 */
+			if (cpus_have_final_cap(ARM64_SSBS))
+				return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
+			fallthrough;
+		case SPECTRE_UNAFFECTED:
+			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
+		case SPECTRE_VULNERABLE:
+			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	void __user *uaddr = (void __user *)(long)reg->addr;
+	u64 val;
+
+	switch (reg->id) {
+	case KVM_REG_ARM_PSCI_VERSION:
+		val = kvm_psci_version(vcpu, vcpu->kvm);
+		break;
+	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
+	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
+		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	void __user *uaddr = (void __user *)(long)reg->addr;
+	u64 val;
+	int wa_level;
+
+	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
+		return -EFAULT;
+
+	switch (reg->id) {
+	case KVM_REG_ARM_PSCI_VERSION:
+	{
+		bool wants_02;
+
+		wants_02 = test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features);
+
+		switch (val) {
+		case KVM_ARM_PSCI_0_1:
+			if (wants_02)
+				return -EINVAL;
+			vcpu->kvm->arch.psci_version = val;
+			return 0;
+		case KVM_ARM_PSCI_0_2:
+		case KVM_ARM_PSCI_1_0:
+			if (!wants_02)
+				return -EINVAL;
+			vcpu->kvm->arch.psci_version = val;
+			return 0;
+		}
+		break;
+	}
+
+	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
+		if (val & ~KVM_REG_FEATURE_LEVEL_MASK)
+			return -EINVAL;
+
+		if (get_kernel_wa_level(reg->id) < val)
+			return -EINVAL;
+
+		return 0;
+
+	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
+		if (val & ~(KVM_REG_FEATURE_LEVEL_MASK |
+			    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED))
+			return -EINVAL;
+
+		/* The enabled bit must not be set unless the level is AVAIL. */
+		if ((val & KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED) &&
+		    (val & KVM_REG_FEATURE_LEVEL_MASK) != KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL)
+			return -EINVAL;
+
+		/*
+		 * Map all the possible incoming states to the only two we
+		 * really want to deal with.
+		 */
+		switch (val & KVM_REG_FEATURE_LEVEL_MASK) {
+		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL:
+		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN:
+			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
+			break;
+		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
+		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
+			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		/*
+		 * We can deal with NOT_AVAIL on NOT_REQUIRED, but not the
+		 * other way around.
+		 */
+		if (get_kernel_wa_level(reg->id) < wa_level)
+			return -EINVAL;
+
+		return 0;
+	default:
+		return -ENOENT;
+	}
+
+	return -EINVAL;
+}
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 74c47d420253..6c8323ae32f2 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -403,169 +403,3 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	};
 }
-
-int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
-{
-	return 3;		/* PSCI version and two workaround registers */
-}
-
-int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
-{
-	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices++))
-		return -EFAULT;
-
-	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1, uindices++))
-		return -EFAULT;
-
-	if (put_user(KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2, uindices++))
-		return -EFAULT;
-
-	return 0;
-}
-
-#define KVM_REG_FEATURE_LEVEL_WIDTH	4
-#define KVM_REG_FEATURE_LEVEL_MASK	(BIT(KVM_REG_FEATURE_LEVEL_WIDTH) - 1)
-
-/*
- * Convert the workaround level into an easy-to-compare number, where higher
- * values mean better protection.
- */
-static int get_kernel_wa_level(u64 regid)
-{
-	switch (regid) {
-	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
-		switch (arm64_get_spectre_v2_state()) {
-		case SPECTRE_VULNERABLE:
-			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
-		case SPECTRE_MITIGATED:
-			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL;
-		case SPECTRE_UNAFFECTED:
-			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED;
-		}
-		return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL;
-	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
-		switch (arm64_get_spectre_v4_state()) {
-		case SPECTRE_MITIGATED:
-			/*
-			 * As for the hypercall discovery, we pretend we
-			 * don't have any FW mitigation if SSBS is there at
-			 * all times.
-			 */
-			if (cpus_have_final_cap(ARM64_SSBS))
-				return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
-			fallthrough;
-		case SPECTRE_UNAFFECTED:
-			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
-		case SPECTRE_VULNERABLE:
-			return KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
-		}
-	}
-
-	return -EINVAL;
-}
-
-int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	void __user *uaddr = (void __user *)(long)reg->addr;
-	u64 val;
-
-	switch (reg->id) {
-	case KVM_REG_ARM_PSCI_VERSION:
-		val = kvm_psci_version(vcpu, vcpu->kvm);
-		break;
-	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
-	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
-		val = get_kernel_wa_level(reg->id) & KVM_REG_FEATURE_LEVEL_MASK;
-		break;
-	default:
-		return -ENOENT;
-	}
-
-	if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
-		return -EFAULT;
-
-	return 0;
-}
-
-int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
-{
-	void __user *uaddr = (void __user *)(long)reg->addr;
-	u64 val;
-	int wa_level;
-
-	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
-		return -EFAULT;
-
-	switch (reg->id) {
-	case KVM_REG_ARM_PSCI_VERSION:
-	{
-		bool wants_02;
-
-		wants_02 = test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features);
-
-		switch (val) {
-		case KVM_ARM_PSCI_0_1:
-			if (wants_02)
-				return -EINVAL;
-			vcpu->kvm->arch.psci_version = val;
-			return 0;
-		case KVM_ARM_PSCI_0_2:
-		case KVM_ARM_PSCI_1_0:
-			if (!wants_02)
-				return -EINVAL;
-			vcpu->kvm->arch.psci_version = val;
-			return 0;
-		}
-		break;
-	}
-
-	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
-		if (val & ~KVM_REG_FEATURE_LEVEL_MASK)
-			return -EINVAL;
-
-		if (get_kernel_wa_level(reg->id) < val)
-			return -EINVAL;
-
-		return 0;
-
-	case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2:
-		if (val & ~(KVM_REG_FEATURE_LEVEL_MASK |
-			    KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED))
-			return -EINVAL;
-
-		/* The enabled bit must not be set unless the level is AVAIL. */
-		if ((val & KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED) &&
-		    (val & KVM_REG_FEATURE_LEVEL_MASK) != KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL)
-			return -EINVAL;
-
-		/*
-		 * Map all the possible incoming states to the only two we
-		 * really want to deal with.
-		 */
-		switch (val & KVM_REG_FEATURE_LEVEL_MASK) {
-		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL:
-		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN:
-			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL;
-			break;
-		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL:
-		case KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
-			wa_level = KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED;
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		/*
-		 * We can deal with NOT_AVAIL on NOT_REQUIRED, but not the
-		 * other way around.
-		 */
-		if (get_kernel_wa_level(reg->id) < wa_level)
-			return -EINVAL;
-
-		return 0;
-	default:
-		return -ENOENT;
-	}
-
-	return -EINVAL;
-}
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 0e2509d27910..5d38628a8d04 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -40,4 +40,11 @@ static inline void smccc_set_retval(struct kvm_vcpu *vcpu,
 	vcpu_set_reg(vcpu, 3, a3);
 }
 
+struct kvm_one_reg;
+
+int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+
 #endif
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 5b58bd2fe088..080c2d0bd6e7 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -42,11 +42,4 @@ static inline int kvm_psci_version(struct kvm_vcpu *vcpu, struct kvm *kvm)
 
 int kvm_psci_call(struct kvm_vcpu *vcpu);
 
-struct kvm_one_reg;
-
-int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
-int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
-int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
-int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
-
 #endif /* __KVM_ARM_PSCI_H__ */
-- 
2.34.1.448.ga2b2bfdf31-goog

