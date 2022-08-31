Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08F5A844A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiHaRZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHaRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:25:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A910B1DE
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso5892666wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5h3L3YOiG9CNXYHQtw/et5Sc+1r6Zl/xaASBla9taYA=;
        b=G5vxTVeX8UktfzniDjTnkLblMXMKWgBYh+R/zA8MObo5kCtHE/4HRGHqvkVm3dHKIn
         Su2cvs50mNGPLJI790jlw1So7LyZSsduFO1NSGToSMmBvB5ocNz2Ox5thy9u2n1xK65e
         DMewhEiPnTmFiGgwHol01Lc/Pi/tFjdFNeximileSt63NdPSFbfx3L218VWWD6NkQkXg
         cmMZ66qsLRAc6JeYpVXYLdeg8a4BjRWRYCyRLxKEIUwjNZjmKEM+ZAOVL0GHRLJrA8vK
         D5LM1fvMywqOpH19URp0URi/B9NDOa2UzrJyHUyu98dzsr7lbej+ThgqjmEQCuDFKa0q
         1tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5h3L3YOiG9CNXYHQtw/et5Sc+1r6Zl/xaASBla9taYA=;
        b=ZMsqPFFRki/c/W5QHNBH17GgMlw8HmWHUJl9bU7d3K21qivEziUB4QXxF93x0n8ELc
         TwkCV5e1iRd4NBt0xXxAVYFiNkDRLC9LCkXs6g880AxT0LjYdBeTLhDklFGT97Iajru6
         4pCkCsuBrg0dKvg3oHdUg8XJpgY6egXuTKlqFE/Y60K0Puy/7H4hkSx6o02E4nBVQj4Y
         5AT0UVvAzv7L8unxkowJTK5LIZW1vvb3sYfUuaJej3ADcfW0Zvo2QCTpgdZGduYtZlNA
         yNuhn2lMmT0g+EaOQahPJ9woy55abVxvVq0gHLqGkEEwqkrzWDhPD4rwM9Mb3Zmx0kCM
         o2vA==
X-Gm-Message-State: ACgBeo1SVVNaDy/kINylhPZlhDH3d0RP+o1uN6DMQ27gW7bIq8mzEt0v
        FGlmyaWUUS3sEyWzSVOXn+8MNQ==
X-Google-Smtp-Source: AA6agR7lpMuqSCKxNT4vSMdBVaSEyRIEQ+Pl2du5hdijO1YQun6REosptUuvlx9D3nXsoLSdQpx6uQ==
X-Received: by 2002:a1c:4b01:0:b0:3a5:94e8:948e with SMTP id y1-20020a1c4b01000000b003a594e8948emr2653368wma.197.1661966705440;
        Wed, 31 Aug 2022 10:25:05 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003a62400724bsm3419320wms.0.2022.08.31.10.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:25:04 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH v2 2/4] riscv: Introduce support for defining instructions
Date:   Wed, 31 Aug 2022 19:24:58 +0200
Message-Id: <20220831172500.752195-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831172500.752195-1-ajones@ventanamicro.com>
References: <20220831172500.752195-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
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

When compiling with toolchains that haven't yet been taught about
new instructions we need to encode them ourselves. Create a new file
where support for instruction definitions will evolve. We initiate
the file with a macro called INSN_R(), which implements the R-type
instruction encoding. INSN_R() will use the assembler's .insn
directive when available, which should give the assembler a chance
to do some validation. When .insn is not available we fall back to
manual encoding.

Not only should using instruction encoding macros improve readability
and maintainability of code over the alternative of inserting
instructions directly (e.g. '.word 0xc0de'), but we should also gain
potential for more optimized code after compilation because the
compiler will have control over the input and output registers used.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig                |  3 ++
 arch/riscv/include/asm/insn-def.h | 86 +++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 arch/riscv/include/asm/insn-def.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4655..f8f3b316b838 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -227,6 +227,9 @@ config RISCV_DMA_NONCOHERENT
 	select ARCH_HAS_SETUP_DMA_OPS
 	select DMA_DIRECT_REMAP
 
+config AS_HAS_INSN
+	def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
+
 source "arch/riscv/Kconfig.socs"
 source "arch/riscv/Kconfig.erratas"
 
diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
new file mode 100644
index 000000000000..2dcd1d4781bf
--- /dev/null
+++ b/arch/riscv/include/asm/insn-def.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_INSN_DEF_H
+#define __ASM_INSN_DEF_H
+
+#include <asm/asm.h>
+
+#define INSN_R_FUNC7_SHIFT		25
+#define INSN_R_RS2_SHIFT		20
+#define INSN_R_RS1_SHIFT		15
+#define INSN_R_FUNC3_SHIFT		12
+#define INSN_R_RD_SHIFT			 7
+#define INSN_R_OPCODE_SHIFT		 0
+
+#ifdef __ASSEMBLY__
+
+#ifdef CONFIG_AS_HAS_INSN
+
+	.macro insn_r, opcode, func3, func7, rd, rs1, rs2
+	.insn	r \opcode, \func3, \func7, \rd, \rs1, \rs2
+	.endm
+
+#else
+
+#include <asm/gpr-num.h>
+
+	.macro insn_r, opcode, func3, func7, rd, rs1, rs2
+	.4byte	((\opcode << INSN_R_OPCODE_SHIFT) |		\
+		 (\func3 << INSN_R_FUNC3_SHIFT) |		\
+		 (\func7 << INSN_R_FUNC7_SHIFT) |		\
+		 (.L__gpr_num_\rd << INSN_R_RD_SHIFT) |		\
+		 (.L__gpr_num_\rs1 << INSN_R_RS1_SHIFT) |	\
+		 (.L__gpr_num_\rs2 << INSN_R_RS2_SHIFT))
+	.endm
+
+#endif
+
+#define INSN_R(...)	insn_r __VA_ARGS__
+
+#else /* ! __ASSEMBLY__ */
+
+#ifdef CONFIG_AS_HAS_INSN
+
+#define INSN_R(opcode, func3, func7, rd, rs1, rs2)	\
+	".insn	r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n"
+
+#else
+
+#include <linux/stringify.h>
+#include <asm/gpr-num.h>
+
+#define DEFINE_INSN_R							\
+	__DEFINE_ASM_GPR_NUMS						\
+"	.macro insn_r, opcode, func3, func7, rd, rs1, rs2\n"		\
+"	.4byte	((\\opcode << " __stringify(INSN_R_OPCODE_SHIFT) ") |"	\
+"		 (\\func3 << " __stringify(INSN_R_FUNC3_SHIFT) ") |"	\
+"		 (\\func7 << " __stringify(INSN_R_FUNC7_SHIFT) ") |"	\
+"		 (.L__gpr_num_\\rd << " __stringify(INSN_R_RD_SHIFT) ") |"    \
+"		 (.L__gpr_num_\\rs1 << " __stringify(INSN_R_RS1_SHIFT) ") |"  \
+"		 (.L__gpr_num_\\rs2 << " __stringify(INSN_R_RS2_SHIFT) "))\n" \
+"	.endm\n"
+
+#define UNDEFINE_INSN_R							\
+"	.purgem insn_r\n"
+
+#define INSN_R(opcode, func3, func7, rd, rs1, rs2)			\
+	DEFINE_INSN_R							\
+	"insn_r " opcode ", " func3 ", " func7 ", " rd ", " rs1 ", " rs2 "\n" \
+	UNDEFINE_INSN_R
+
+#endif
+
+#endif /* ! __ASSEMBLY__ */
+
+#define OPCODE(v)	__ASM_STR(v)
+#define FUNC3(v)	__ASM_STR(v)
+#define FUNC7(v)	__ASM_STR(v)
+#define RD(v)		__ASM_STR(v)
+#define RS1(v)		__ASM_STR(v)
+#define RS2(v)		__ASM_STR(v)
+#define __REG(v)	__ASM_STR(x ## v)
+#define __RD(v)		__REG(v)
+#define __RS1(v)	__REG(v)
+#define __RS2(v)	__REG(v)
+
+#endif /* __ASM_INSN_DEF_H */
-- 
2.37.2

