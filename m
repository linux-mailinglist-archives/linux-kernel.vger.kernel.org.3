Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22C5522E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbiEKIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiEKIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024C2FE52
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x52so1346577pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=CNcmhvwD3MIc3ZF4wDh+JNST4g3yed3GkIbTz0xMpAM=;
        b=UmNqaGT3mFMRhnwCYlyTXysoWEtZ9BqkFF/06pf0pJGYPLbs8ck752Y3MC1HwFrn0H
         ik2ZHFXfIEK1XPvZXcKTV3JeOo+TNE3AsgA8C4ugJqTJNFmaK4T5yCjln+9bx1gEF5fv
         lbZPJ8C60NC4Mo2RsBLwixQ0G9eQLm+HYgflqYCZxdwBeLaXxdO4PUXqH5jXKMXwjaWC
         UOD4V/5fd+LfazcG6uuCI67YVCbiGLzhRHvkwPAhXbBKdKonvGQqaWe2O2iyLbr7bMjE
         p+hlZSkiCQwrGIisKemcEaQpLsHBrKafUAncEzv9O8vWnhF77PE4QwKR1TwAZESCPAMD
         NTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CNcmhvwD3MIc3ZF4wDh+JNST4g3yed3GkIbTz0xMpAM=;
        b=Vk2RsapN/WVSj8pxne2RhgTRXyxxaT6F/1grr+aeQN0q7dJjXIoUEEaV1nZhlIwrCK
         BfuDO1gyWWXbChCZQi6WMDMGd1rgiLzmwtbdXgOdR1cxHlkxS0joAlQlafKDQb4+IwQk
         AT3NqQjTzIdU2DIfSNDfFJWz6DWbxyunUr1uZVB7QeZdHiRDeVqCh7fV8/iIQCVMtkWm
         808DCHuszjIaghYEU5y+tpXyRHoiBKukQMGbY8B4CbMrsLAJIYjtJswB9TSbXE7ov1vN
         mqLxpp32fNW6uiyq7akV4W4QBoXiP5bpyXIxUjB/fP+A8FGy/WQi+QsMocmk3dLVwhx/
         Gj0w==
X-Gm-Message-State: AOAM530t60+PuDqg05GuOhMxTW1KC+Fd8IVPIRAa09mCAU85rL8o4h4b
        fKpuPfYLcnsLlO9/I9RGbsNicQ==
X-Google-Smtp-Source: ABdhPJx0UeFG4yjq9tUcou7zoqQkI5qhd4fok9z2NTAu6A0LqYB7M0mYqan+bac+lsNQPdt+0XUneQ==
X-Received: by 2002:a05:6a00:13aa:b0:50e:f00:9e1d with SMTP id t42-20020a056a0013aa00b0050e0f009e1dmr24311637pfg.38.1652257897380;
        Wed, 11 May 2022 01:31:37 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:37 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 05/16] riscv: Add has_vector/riscv_vsize to save vector features.
Date:   Wed, 11 May 2022 08:31:15 +0000
Message-Id: <221f72a2ee62cd5350edb5d6a7e8ebb17a7bc321.1652257230.git.greentime.hu@sifive.com>
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

This patch is used to detect vector support status of CPU and use
riscv_vsize to save the size of all the vector registers. It assumes
all harts has the same capabilities in SMP system.

[guoren@linux.alibaba.com: add has_vector checking]
Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/vector.h | 14 +++++
 arch/riscv/kernel/cpufeature.c  | 17 ++++++
 arch/riscv/kernel/riscv_ksyms.c |  6 +++
 arch/riscv/kernel/vector.S      | 93 +++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)
 create mode 100644 arch/riscv/include/asm/vector.h
 create mode 100644 arch/riscv/kernel/vector.S

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
new file mode 100644
index 000000000000..16304b0c6a6f
--- /dev/null
+++ b/arch/riscv/include/asm/vector.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#ifndef __ASM_RISCV_VECTOR_H
+#define __ASM_RISCV_VECTOR_H
+
+#include <linux/types.h>
+
+void rvv_enable(void);
+void rvv_disable(void);
+
+#endif /* ! __ASM_RISCV_VECTOR_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 92a8fd6bd3ed..f2dec6cb60ed 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -24,6 +24,11 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 #ifdef CONFIG_FPU
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
+#ifdef CONFIG_VECTOR
+#include <asm/vector.h>
+__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_vector);
+unsigned long riscv_vsize __read_mostly;
+#endif
 
 /**
  * riscv_isa_extension_base() - Get base extension word
@@ -76,7 +81,9 @@ void __init riscv_fill_hwcap(void)
 	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
 	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+#ifdef CONFIG_VECTOR
 	isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
+#endif
 
 	elf_hwcap = 0;
 
@@ -237,4 +244,14 @@ void __init riscv_fill_hwcap(void)
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
 		static_branch_enable(&cpu_hwcap_fpu);
 #endif
+
+#ifdef CONFIG_VECTOR
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+		static_branch_enable(&cpu_hwcap_vector);
+		/* There are 32 vector registers with vlenb length. */
+		rvv_enable();
+		riscv_vsize = csr_read(CSR_VLENB) * 32;
+		rvv_disable();
+	}
+#endif
 }
diff --git a/arch/riscv/kernel/riscv_ksyms.c b/arch/riscv/kernel/riscv_ksyms.c
index 5ab1c7e1a6ed..3489d2a20ca3 100644
--- a/arch/riscv/kernel/riscv_ksyms.c
+++ b/arch/riscv/kernel/riscv_ksyms.c
@@ -15,3 +15,9 @@ EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
+
+#ifdef CONFIG_VECTOR
+#include <asm/vector.h>
+EXPORT_SYMBOL(rvv_enable);
+EXPORT_SYMBOL(rvv_disable);
+#endif
diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
new file mode 100644
index 000000000000..9f7dc70c4443
--- /dev/null
+++ b/arch/riscv/kernel/vector.S
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2019 Alibaba Group Holding Limited
+ *
+ *   This program is free software; you can redistribute it and/or
+ *   modify it under the terms of the GNU General Public License
+ *   as published by the Free Software Foundation, version 2.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/asm-offsets.h>
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
+ENTRY(__vstate_save)
+	li      status, SR_VS
+	csrs    CSR_STATUS, status
+
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
+	REG_S   x_vstart, RISCV_V_STATE_VSTART(vstatep)
+	REG_S   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
+	REG_S   x_vl, RISCV_V_STATE_VL(vstatep)
+	REG_S   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
+
+	csrc	CSR_STATUS, status
+	ret
+ENDPROC(__vstate_save)
+
+ENTRY(__vstate_restore)
+	li      status, SR_VS
+	csrs    CSR_STATUS, status
+
+	vsetvli incr, x0, e8, m8, ta, ma
+	vle8.v   v0, (datap)
+	add     datap, datap, incr
+	vle8.v   v8, (datap)
+	add     datap, datap, incr
+	vle8.v   v16, (datap)
+	add     datap, datap, incr
+	vle8.v   v24, (datap)
+
+	REG_L   x_vstart, RISCV_V_STATE_VSTART(vstatep)
+	REG_L   x_vtype, RISCV_V_STATE_VTYPE(vstatep)
+	REG_L   x_vl, RISCV_V_STATE_VL(vstatep)
+	REG_L   x_vcsr, RISCV_V_STATE_VCSR(vstatep)
+	vsetvl  x0, x_vl, x_vtype
+	csrw    CSR_VSTART, x_vstart
+	csrw    CSR_VCSR, x_vcsr
+
+	csrc	CSR_STATUS, status
+	ret
+ENDPROC(__vstate_restore)
+
+ENTRY(rvv_enable)
+	li      status, SR_VS
+	csrs    CSR_STATUS, status
+	ret
+ENDPROC(rvv_enable)
+
+ENTRY(rvv_disable)
+	li      status, SR_VS
+	csrc	CSR_STATUS, status
+	ret
+ENDPROC(rvv_disable)
-- 
2.17.1

