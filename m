Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC97599D55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349181AbiHSODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349211AbiHSOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:02:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F1100F14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so8981851ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CdNbn84TYwncfTBJxPnu/xlRdTtMM/NuV6HASL/Mh8E=;
        b=lCh+9pdG34gjrDI076GzFZVpx4/E/qseWgm+HgMbNq2MJQd10BIiZcZdGdBHg2oLKZ
         ISmjzidGOhYrdfOo6qHCZfYXuFcgY6XL2uMjXhIvjRYQY5iPjSyiQjXeGii7ikG5o7ht
         Z+tDTkMiBnbcfOGQ6iKUSxpBiEenHq0FTDRv3NZmCDv8q8vsrcM4JDnwTemeUHM3KcNi
         56JMnKkv5L8w+1zEEjRpK9FEwGf6FmiaNHSG0AWQvK/SVPoGwCRzSbNZoBwVE9ch40IE
         O9focsaqJKTW1OZ7+nztPgHJMcBAVe516VIg0e+d3kZDVylLrPMggLO0DHkaj7fcbJpk
         +heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CdNbn84TYwncfTBJxPnu/xlRdTtMM/NuV6HASL/Mh8E=;
        b=wA8xtFZ8sYxrgGrWmwrmJJsWOrLOiXbP0MwHpFdDwrWl1DZVrteHl/XYbfCQIJoJg7
         0zVueZ/qIxWA4eCI4VVJ6TFca6v7qaTO+kjsCzbkdTEH1nTYtPZYI5EZPhUeBCczQy2Z
         ZY50OvGIU/49pCRl28wsNGkLwvqhmjIji0zLvLjAUecTNWkQZlxJH/dFZlhVAkUMNGUE
         XGiPIp+t84wFT98l92M3sWFN56jAO93QOq+ScbS0m4TtQGFvmJn12nQu1q/Kt15+jcAP
         5vOIqKVRRZO8DSMxoIZGGihbdId98coepW/6H2pznQwFfqSQ/wZWEFpSu1Mv2HUvwv0I
         HRZw==
X-Gm-Message-State: ACgBeo1ZvAKt7qDeJGMXIXFaLTFiQcSLAIpntwBfEQG+fOlbxSPp3pQy
        WGpLB95xKnA2mETT0PaFDcbYBA==
X-Google-Smtp-Source: AA6agR7kgjM4XbdNJobWB0KnpsIFG/X1o3vSDdu6NBsYc6JLV3lBrWSwPSJXqdHEA4IO0NWpQIhINQ==
X-Received: by 2002:a17:906:93e8:b0:730:9e5c:b45a with SMTP id yl8-20020a17090693e800b007309e5cb45amr4819450ejb.530.1660917775017;
        Fri, 19 Aug 2022 07:02:55 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7cfd1000000b0043ba7df7a42sm3147053edy.26.2022.08.19.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:02:54 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH 2/4] riscv: Introduce support for defining instructions
Date:   Fri, 19 Aug 2022 16:02:48 +0200
Message-Id: <20220819140250.3892995-3-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819140250.3892995-1-ajones@ventanamicro.com>
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
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
---
 arch/riscv/Kconfig                |  3 ++
 arch/riscv/include/asm/insn-def.h | 82 +++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
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
index 000000000000..4cd0208068dd
--- /dev/null
+++ b/arch/riscv/include/asm/insn-def.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_INSN_DEF_H
+#define __ASM_INSN_DEF_H
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
+        .endm
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
+"	.4byte  ((\\opcode << " __stringify(INSN_R_OPCODE_SHIFT) ") |"	\
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
+#define __REG(v)	__ASM_STR(x ## v)
+#define RD(v)		__REG(v)
+#define RS1(v)		__REG(v)
+#define RS2(v)		__REG(v)
+
+#endif /* __ASM_INSN_DEF_H */
-- 
2.37.1

