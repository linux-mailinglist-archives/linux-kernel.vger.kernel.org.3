Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76A5525AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiFTUQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbiFTUQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:16:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606E64C6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:15:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w24so2795704pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uXSwA0VZB6Kj6viZ1pio+RknHlDBNIYrHuFvQS4534=;
        b=m0Na8RynXQcTYFciNnM0ONTDVLxYrmfFLuUcIA+c+dIpYZ4o6lmEhs74xjC0zhgkgY
         evd8ymXCStFOxOWDOX+IbjWCdaVRzBZUozy38WVpd1xSNDgNh5dp3+R9jsw7Qp6CBtao
         x2CdTeAtBpe4S7ObCy/ylj4SrcKooxyhT2SaGCvneJkoAW2v54noquIqCHb/ZkcMOPIr
         2A+Y1ydfVegVG5Bn+JTU1V7qzOLGJAggK5TR4YMBmui6RxjIxZCypDNz3L/Eno/1upzx
         qeg1mAyc7i7zTAN1BzgVOSPJE1zXASinn/C8V7EfeQ9ySVfDVLFD3AtDSpx0OkbMACjQ
         mviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/uXSwA0VZB6Kj6viZ1pio+RknHlDBNIYrHuFvQS4534=;
        b=MJ1xDpyI4qO3w4loVbtOCGNOVAFjUdIXcrqdxWzYyG7EOnC55swgWWS5qUOhSRMbPd
         yFzEYCVhzXn9eQ/tjIsuqs48tGL76Gg4WG73iBEPqPi/ylurTqaR/di9y7HNxuRkathQ
         yqD+XEnPKg7phw7rJ57E9/xIltm/a9CrkhdJ+alF8Cnk4/9Oggtga73Tcwo9ts2BjGN9
         DFeI0/OaT344n2iHeiNDqsITPgfaDP38nBJtkyYezIwwI1SQS+AuMJWjIfZ1+szAFM/4
         Z07LJPMQKsrKoHs+Nx6qST82h0SzHdXDy2CVstw9C9VcEGoPE25gwXVtn2plO/THE9Pe
         K/tA==
X-Gm-Message-State: AJIora8gAFYNHGs132vF8mUrUCKKVd8P40e243clNBAfZJBjG3Aa/RjU
        RuQbGcFpfjaHgAlZPp8k2/PD9jre6oTWZQ==
X-Google-Smtp-Source: AGRyM1sAU1g7ytax5AFtdYQfP7PBW7mMd7BoA3S69gJnn8PUyTTUi5mos6/drT1yTiaqtVdKd2Tu5Q==
X-Received: by 2002:a17:902:ea12:b0:168:faa0:509b with SMTP id s18-20020a170902ea1200b00168faa0509bmr25351023plg.150.1655756151197;
        Mon, 20 Jun 2022 13:15:51 -0700 (PDT)
Received: from daolu.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p16-20020a170903249000b00163f1831ddfsm9119071plw.40.2022.06.20.13.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:15:50 -0700 (PDT)
From:   Dao Lu <daolu@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH v4] arch/riscv: add Zihintpause support
Date:   Mon, 20 Jun 2022 13:15:25 -0700
Message-Id: <20220620201530.3929352-1-daolu@rivosinc.com>
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
 Added the static branch back, cpu_relax() behavior is kept the same for
systems that do not support ZiHintPause
v3 -> v4:
 Adopted the newly added unified static keys for extensions
---
 arch/riscv/Makefile                     |  4 ++++
 arch/riscv/include/asm/hwcap.h          |  5 +++++
 arch/riscv/include/asm/vdso/processor.h | 21 ++++++++++++++++++---
 arch/riscv/kernel/cpu.c                 |  1 +
 arch/riscv/kernel/cpufeature.c          |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

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
index e48eebdd2631..dc47019a0b38 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -8,6 +8,7 @@
 #ifndef _ASM_RISCV_HWCAP_H
 #define _ASM_RISCV_HWCAP_H
 
+#include <asm/errno.h>
 #include <linux/bits.h>
 #include <uapi/asm/hwcap.h>
 
@@ -54,6 +55,7 @@ extern unsigned long elf_hwcap;
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_SVPBMT,
+	RISCV_ISA_EXT_ZIHINTPAUSE,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
@@ -64,6 +66,7 @@ enum riscv_isa_ext_id {
  */
 enum riscv_isa_ext_key {
 	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
+	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
 	RISCV_ISA_EXT_KEY_MAX,
 };
 
@@ -83,6 +86,8 @@ static __always_inline int riscv_isa_ext2key(int num)
 		return RISCV_ISA_EXT_KEY_FPU;
 	case RISCV_ISA_EXT_d:
 		return RISCV_ISA_EXT_KEY_FPU;
+	case RISCV_ISA_EXT_ZIHINTPAUSE:
+		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 134388cbaaa1..1e4f8b4aef79 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -4,15 +4,30 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/jump_label.h>
 #include <asm/barrier.h>
+#include <asm/hwcap.h>
 
 static inline void cpu_relax(void)
 {
+	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
 #ifdef __riscv_muldiv
-	int dummy;
-	/* In lieu of a halt instruction, induce a long-latency stall. */
-	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+		int dummy;
+		/* In lieu of a halt instruction, induce a long-latency stall. */
+		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
 #endif
+	} else {
+		/*
+		 * Reduce instruction retirement.
+		 * This assumes the PC changes.
+		 */
+#ifdef __riscv_zihintpause
+		__asm__ __volatile__ ("pause");
+#else
+		/* Encoding of the pause instruction */
+		__asm__ __volatile__ (".4byte 0x100000F");
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
index 1b3ec44e25f5..708df2c0bc34 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -198,6 +198,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
 			}
 #undef SET_ISA_EXT_MAP
 		}
-- 
2.25.1

