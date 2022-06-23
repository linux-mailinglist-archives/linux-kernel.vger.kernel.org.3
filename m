Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2F557E98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiFWP35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:29:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778B34B90
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:29:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cf14so19314126edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LE1pCraTp8DcEIpT4Qu2iOgXxVGIQ+g+LxOeogNClfQ=;
        b=F3E+Nst+sXa2JZdRtZc9avEjwV6g9e4wk0xB4aRhWW/Se26ItykQO90DRspLEKVwA3
         1d/EVtdyjjDFNGLRQ2IIwCmOecwFB4EEBLTQkcYKQz3k69gnU6cKqICSO8v51xkq8n1F
         NJdBVIp0LjiMcPqeJ83UnUUNygqSHVMgQJEcZz1SWpWuRrNkVR81XudwP6UmhdhdiOyN
         uhTWCB/NVovsb87mjw1z7c0+PV92obYAaR+4QNFivGNbkIxyLflbfRZNA3u0WUb+OFiF
         w4V3Vn7F0hwHi/Eswa+XHddBy6h1/t8yUN/9FskxHClhKq2w23qqe1C1+MZ1hAt13XG0
         PjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LE1pCraTp8DcEIpT4Qu2iOgXxVGIQ+g+LxOeogNClfQ=;
        b=H1nFMaWDDqOs0BCYDO9Z0Ae3i2jZH5+kz/PbTGUCrf1iFL/3SpghHq5DhMQqZ7jAc1
         stPqvtglF/7xHWqZMdYG4qJzYczGOuvxW1n5VKCC8SbkBfLT3BteGpkyQ371SSCQ7ehX
         iSaDTix2pD/XNZ+V7udc287qHFK6LUkd7cp879nAHFJoucIK4+sZntdNSmlTc1waL8Wr
         7WH+qeAHRdgnYd3lLbeno2tAAhK8ho4dAVVk+XgdxIWtTOvECb3HqomX5pgk5yUj5bHI
         /3sS0F31SaTp/XBfjihggjNFMXqZ6DrGdBfoogsFN1sNfTi1orH5yJMCKBufuHOvT6TR
         QA3w==
X-Gm-Message-State: AJIora+hzF6rHSgh03C9gaTMl2/ysJcZmHLRRucCj5NF9AUrRiSLnYLY
        gJjEUBdKTLKVfzP6AnNPcDtcPg==
X-Google-Smtp-Source: AGRyM1tLfIfJK1GIEg108XChKFysbc8fly98nIwtnFW2rb7ah1bq0hQXSnB2ixzNToqasmHIgehRKg==
X-Received: by 2002:aa7:dac2:0:b0:435:76a2:4ebe with SMTP id x2-20020aa7dac2000000b0043576a24ebemr11236937eds.196.1655998192777;
        Thu, 23 Jun 2022 08:29:52 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id cq18-20020a056402221200b00435651c4a01sm14542785edb.56.2022.06.23.08.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 08:29:52 -0700 (PDT)
From:   Christoph Muellner <christoph.muellner@vrull.eu>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko.stuebner@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [RFC PATCH v2] riscv: Add Zawrs support for spinlocks
Date:   Thu, 23 Jun 2022 17:29:48 +0200
Message-Id: <20220623152948.1607295-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

The current RISC-V code uses the generic ticket lock implementation,
that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
Currently, RISC-V uses the generic implementation of these macros.
This patch introduces a RISC-V specific implementation, of these
macros, that peels off the first loop iteration and modifies the waiting
loop such, that it is possible to use the WRS.STO instruction of the Zawrs
ISA extension to stall the CPU.

The resulting implementation of smp_cond_load_*() will only work for
32-bit or 64-bit types for RV64 and 32-bit types for RV32.
This is caused by the restrictions of the LR instruction (RISC-V only
has LR.W and LR.D). Compiler assertions guard this new restriction.

This patch uses the existing RISC-V ISA extension framework
to detect the presents of Zawrs at run-time.
If available a NOP instruction will be replaced by WRS.NTO or WRS.STO.

The whole mechanism is gated by Kconfig setting, which defaults to Y.

The Zawrs specification can be found here:
https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc

Note, that the Zawrs extension is not frozen or ratified yet.
Therefore this patch is an RFC and not intended to get merged.

Changes since v1:
* Adding "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS
* Fixing type checking code in __smp_load_reserved*
* Adjustments according to the specification change

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 arch/riscv/Kconfig                   | 11 ++++
 arch/riscv/include/asm/barrier.h     | 92 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/errata_list.h | 19 +++++-
 arch/riscv/include/asm/hwcap.h       |  3 +-
 arch/riscv/kernel/cpu.c              |  1 +
 arch/riscv/kernel/cpufeature.c       | 13 ++++
 6 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 32ffef9f6e5b..9d40569237c9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -358,6 +358,17 @@ config RISCV_ISA_C
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZAWRS
+	bool "Zawrs extension support"
+	depends on !XIP_KERNEL
+	select RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the Zawrs extension
+	   (wait for reservation set) and enable its usage.
+
+	   If you don't know what to do here, say Y.
+
 config RISCV_ISA_SVPBMT
 	bool "SVPBMT extension support"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index d0e24aaa2aa0..1f9628aaa7cb 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -12,6 +12,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/errata_list.h>
+
 #define nop()		__asm__ __volatile__ ("nop")
 
 #define RISCV_FENCE(p, s) \
@@ -42,6 +44,64 @@ do {									\
 	___p1;								\
 })
 
+#if __riscv_xlen == 64
+
+#define __riscv_lrsc_word(t)						\
+	(sizeof(t) == sizeof(int) ||					\
+	 sizeof(t) == sizeof(long))
+
+#elif __riscv_xlen == 32
+
+#define __riscv_lrsc_word(t)						\
+	(sizeof(t) == sizeof(int))
+
+#else
+#error "Unexpected __riscv_xlen"
+#endif /* __riscv_xlen */
+
+#define compiletime_assert_atomic_lrsc_type(t)				\
+	compiletime_assert(__riscv_lrsc_word(t),			\
+		"Need type compatible with LR/SC instructions.")
+
+#define ___smp_load_reservedN(pfx, ptr)					\
+({									\
+	typeof(*ptr) ___p1;						\
+	__asm__ __volatile__ ("lr." pfx "	%[p], %[c]\n"		\
+			      : [p]"=&r" (___p1), [c]"+A"(*ptr));	\
+	___p1;								\
+})
+
+#define ___smp_load_reserved32(ptr)					\
+	___smp_load_reservedN("w", ptr)
+
+#define ___smp_load_reserved64(ptr)					\
+	___smp_load_reservedN("d", ptr)
+
+#define __smp_load_reserved_relaxed(ptr)				\
+({									\
+	typeof(*ptr) ___p1;						\
+	compiletime_assert_atomic_lrsc_type(*ptr);			\
+	if (sizeof(*ptr) == 4) {					\
+		___p1 = ___smp_load_reserved32(ptr);			\
+	} else {							\
+		___p1 = ___smp_load_reserved64(ptr);			\
+	}								\
+	___p1;								\
+})
+
+#define __smp_load_reserved_acquire(ptr)				\
+({									\
+	typeof(*ptr) ___p1;						\
+	compiletime_assert_atomic_lrsc_type(*ptr);			\
+	if (sizeof(*ptr) == 4) {					\
+		___p1 = ___smp_load_reserved32(ptr);			\
+	} else {							\
+		___p1 = ___smp_load_reserved64(ptr);			\
+	}								\
+	RISCV_FENCE(r,rw);						\
+	___p1;								\
+})
+
 /*
  * This is a very specific barrier: it's currently only used in two places in
  * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two
@@ -69,6 +129,38 @@ do {									\
  */
 #define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
 
+#define smp_cond_load_relaxed(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	VAL = READ_ONCE(*__PTR);					\
+	if (!cond_expr) {						\
+		for (;;) {						\
+			VAL = __smp_load_reserved_relaxed(__PTR);	\
+			if (cond_expr)					\
+				break;					\
+			ALT_WRS_STO();					\
+		}							\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define smp_cond_load_acquire(ptr, cond_expr)				\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	VAL = smp_load_acquire(__PTR);					\
+	if (!cond_expr) {						\
+		for (;;) {						\
+			VAL = __smp_load_reserved_acquire(__PTR);	\
+			if (cond_expr)					\
+				break;					\
+			ALT_WRS_STO();					\
+		}							\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 9e2888dbb5b1..e15af9986b1a 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -19,8 +19,9 @@
 #define	ERRATA_THEAD_NUMBER 1
 #endif
 
-#define	CPUFEATURE_SVPBMT 0
-#define	CPUFEATURE_NUMBER 1
+#define	CPUFEATURE_ZAWRS 0
+#define	CPUFEATURE_SVPBMT 1
+#define	CPUFEATURE_NUMBER 2
 
 #ifdef __ASSEMBLY__
 
@@ -42,6 +43,20 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+#define ZAWRS_WRS_NTO	".long 0x00d00073"
+#define ALT_WRS_NTO()							\
+asm volatile(ALTERNATIVE(						\
+	"nop\n\t",							\
+	ZAWRS_WRS_NTO "\n\t",						\
+	0, CPUFEATURE_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
+
+#define ZAWRS_WRS_STO	".long 0x01d00073"
+#define ALT_WRS_STO()							\
+asm volatile(ALTERNATIVE(						\
+	"nop\n\t",							\
+	ZAWRS_WRS_STO "\n\t",						\
+	0, CPUFEATURE_ZAWRS, CONFIG_RISCV_ISA_ZAWRS))
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 4e2486881840..c7dd8cc38bec 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,7 +51,8 @@ extern unsigned long elf_hwcap;
  * available logical extension id.
  */
 enum riscv_isa_ext_id {
-	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_ZAWRS = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_SSCOFPMF,
 	RISCV_ISA_EXT_SVPBMT,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fba9e9f46a8c..6c3a10ff5358 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -87,6 +87,7 @@ int riscv_of_parent_hartid(struct device_node *node)
  *    extensions by an underscore.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 12b05ce164bb..ce610d8a0e8d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zawrs", RISCV_ISA_EXT_ZAWRS);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -250,6 +251,14 @@ struct cpufeature_info {
 	bool (*check_func)(unsigned int stage);
 };
 
+static bool __init_or_module cpufeature_zawrs_check_func(unsigned int stage)
+{
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+		return false;
+
+	return riscv_isa_extension_available(NULL, ZAWRS);
+}
+
 static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
 {
 #ifdef CONFIG_RISCV_ISA_SVPBMT
@@ -266,6 +275,10 @@ static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
 
 static const struct cpufeature_info __initdata_or_module
 cpufeature_list[CPUFEATURE_NUMBER] = {
+	{
+		.name = "zawrs",
+		.check_func = cpufeature_zawrs_check_func
+	},
 	{
 		.name = "svpbmt",
 		.check_func = cpufeature_svpbmt_check_func
-- 
2.35.3

