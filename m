Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716854D36D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbiFOVOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346733AbiFOVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:14:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB92555346
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:14:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t2so11448496pld.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEvwh7jjqTyDCAEI1ndR/NudME1iPoWlHRWFbB9YcWY=;
        b=uOYK2DWfIE8/d63Ydv45JX8+RWnFlEjlJxAceq0s6Z2cHw7w1+kWfA9aCAe56SRsuF
         IF08W4wtTzF8kh0PLjzTw9uTtwc+MNV1yh0QSEgXwx5WNxbcAdZJRpO9tE+qI1Sb0wrr
         3puGEq39WsZBy2OC8oG+SxxlHT1LPkbguT+euJ5nK3a1A7ZhknBNCeFjsJAYLC4rN+Ws
         NQiyc/zW63G6PW5smPZMM0hUPMsx93ZOGVvRMPN06aj5z5eAsS94LO/mf6dzUhbuS+RQ
         WZP1z4USNBpX0vwnoenbkJ82eHkzRBSOqB1LifjA3Hz5AvfgAM4BVjVWzOi7MBpK1D0p
         ERrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEvwh7jjqTyDCAEI1ndR/NudME1iPoWlHRWFbB9YcWY=;
        b=Ru0g3UjeTopg2De7tNlZn5WIjQSu8WlhYcSnqTCOqq6i6iYlYRtWXk9yrYSWkCE3Bv
         iVtQ+wIsEOc1N0AhJukSNaG6SvJK1HW2uAhxxGBtgo4xsqU2Mul5At+jt5mMBjiJpujO
         4ro0OEivkYbrfAZAn78FXyX2V8dNmome//mMt4eUBcPee0IF8pyl9kY5PPq1YU2yHuCR
         n6b8NZ5xbZ0MGP4mu7KYjCA0PA2HtF+dsZw/rWRoNPPAMNt7XYP3UQfeauTHq81s8KDV
         XMHJoPDPAhH9z5bCtjVGy2II92cd2lOU3DhbWP/eesrNR++UnTgNvlPhFHG7MNV5cjpo
         dtEA==
X-Gm-Message-State: AJIora/UT2SweDJ7FFD0dY4T56E6dQMfswia4hnHO0QTDRUwQSKef+12
        J32I48+k+p7BvyMp3dgpl2YfNLx92iXIQNbm
X-Google-Smtp-Source: AGRyM1v/q92BC+qegV0/rkeLooRV8EBVLRvekTsozRMiC5yWuNZQ7aLA0O84ZVeMYaOXigOk42ZyMg==
X-Received: by 2002:a17:90a:ba81:b0:1e8:36f2:5b36 with SMTP id t1-20020a17090aba8100b001e836f25b36mr12306903pjr.5.1655327658976;
        Wed, 15 Jun 2022 14:14:18 -0700 (PDT)
Received: from daolu.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id ix18-20020a170902f81200b0016362da9a03sm54409plb.245.2022.06.15.14.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:14:18 -0700 (PDT)
From:   Dao Lu <daolu@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Wei Fu <wefu@redhat.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Rob Herring <robh@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH v3] arch/riscv: add Zihintpause support
Date:   Wed, 15 Jun 2022 14:14:10 -0700
Message-Id: <20220615211415.3111271-1-daolu@rivosinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for the ZiHintPause extension.

The PAUSE instruction is a HINT that indicates the current hart’s rate
of instruction retirement should be temporarily reduced or paused.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dao Lu <daolu@rivosinc.com>
---

v1 -> v2:
 Remove the usage of static branch, use PAUSE if toolchain supports it
v2 -> v3:
 Added the static branch back, cpu_relax() behavior is unchanged if either the
system or the toolchain does not support ZiHintPause
---
 arch/riscv/Makefile                     |  4 ++++
 arch/riscv/include/asm/hwcap.h          |  1 +
 arch/riscv/include/asm/vdso/processor.h | 19 ++++++++++++++++---
 arch/riscv/kernel/cpu.c                 |  1 +
 arch/riscv/kernel/cpufeature.c          |  8 ++++++++
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 34cf8a598617..6ddacc6f44b9 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -56,6 +56,10 @@ riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zicsr_zifencei)
 riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
 
+# Check if the toolchain supports Zihintpause extension
+toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
+riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
+
 KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 4e2486881840..f24f4f8c9144 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -53,6 +53,7 @@ extern unsigned long elf_hwcap;
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_SVPBMT,
+	RISCV_ISA_EXT_ZIHINTPAUSE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 134388cbaaa1..314ec17c40d8 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -4,15 +4,28 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/jump_label.h>
 #include <asm/barrier.h>
+#include <asm/hwcap.h>
 
+extern struct static_key_false riscv_pause_available;
 static inline void cpu_relax(void)
 {
+	if (!static_branch_likely(&riscv_pause_available)) {
 #ifdef __riscv_muldiv
-	int dummy;
-	/* In lieu of a halt instruction, induce a long-latency stall. */
-	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+		int dummy;
+		/* In lieu of a halt instruction, induce a long-latency stall. */
+		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
 #endif
+#ifdef __riscv_zihintpause
+	} else {
+		/*
+		 * Reduce instruction retirement.
+		 * This assumes the PC changes.
+		 */
+		__asm__ __volatile__ ("pause");
+#endif
+	}
 	barrier();
 }
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fba9e9f46a8c..a123e92b14dd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
 static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a6f62a6d1edd..78c284c487e8 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -30,6 +30,8 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 #ifdef CONFIG_FPU
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
+DEFINE_STATIC_KEY_FALSE(riscv_pause_available);
+EXPORT_SYMBOL_GPL(riscv_pause_available);
 
 /**
  * riscv_isa_extension_base() - Get base extension word
@@ -199,6 +201,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -219,6 +222,11 @@ void __init riscv_fill_hwcap(void)
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
+#ifdef __riscv_zihintpause
+	if (__riscv_isa_extension_available(riscv_isa, RISCV_ISA_EXT_ZIHINTPAUSE))
+		static_branch_enable(&riscv_pause_available);
+#endif
+
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.25.1

