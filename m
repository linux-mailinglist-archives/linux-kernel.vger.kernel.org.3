Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE6522E71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiEKId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiEKIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEF4130E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:51 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q76so1168640pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=p1pBW1G0xf+nuHQeCYtlJM/ltXiGJIWoD7vDEEsgp4w=;
        b=WDIcU8bjpBGvAlkTDqgBOmYbiNsSiBNbDZF3wLdzgCr6ACi1CJQw5lvUk4mVQ3jZPG
         zqch3k0NX6mq72w13vNYULGE9N43XVtl22wqzxEY7sWjF1DweqWQzYfyb4JuNTyD06Ce
         nszmu2H6sdp+CzvOEl2G8xJB6TV5B9vrP1Xv9B8xaFVrbxJ/8psDZA8wz9Gu7+YCkjg4
         i9P/bxF99NpWssE77t5A5M+KLIo7j4QsVaiIMZ5etgZyqKC28D1JfjSzjcTJYchsQwWe
         gqbSjpTODDEILDVh9tnAwH3ubh1hKeKDnNKyZ110Axd4MCVREtpyvImghTPUWjly/UrS
         G5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p1pBW1G0xf+nuHQeCYtlJM/ltXiGJIWoD7vDEEsgp4w=;
        b=eKPCKUpa2YnOpY+tNDzEDIoIaiiI1NoJLUnzkUlk1IB7i1jrW2oYW/KgxfdiCd3B33
         /4Z+y5GrfpZsempL8cIllS91ndMCxZ5oEoFBbKg0IS2wInrwmDCeqo7yLn+JmB9iSrb+
         oylqnUrScxz8uPbHQIfhHczZCk2V0iydmy532tXKKw3TfTJNfNmULJZTZpRgrWGaLtVI
         SLIKMJTGWlPmOQ5tzIvFc8Gk/Ah0ySgaC0fXO2TqlmLfQJD2fXKu6VhYfFqvAsYhH40U
         OsRSQy4FW3EFzm0+Gwz6jt6pvUVL6S7IXx80OhalOCA4mEGGbLoGTI5mXapNThUHNSqE
         gLDw==
X-Gm-Message-State: AOAM531u23d+XY3ICF5c9ex8tI+MPfadlWHdeChzbJZpkmhPGqdMXopO
        XNouPLB9T/B1RynEmgUYAGwpxw==
X-Google-Smtp-Source: ABdhPJyDvWf/WS9fKbB9NiiG/YzFYnTHR8XFEkmyHpLk0Zno8zCPZD4WsMMxgDoffXFPgK1E6als1g==
X-Received: by 2002:a63:8948:0:b0:3da:ec12:1b1c with SMTP id v69-20020a638948000000b003daec121b1cmr5526407pgd.598.1652257910737;
        Wed, 11 May 2022 01:31:50 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:50 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 13/16] riscv: Add vector extension XOR implementation
Date:   Wed, 11 May 2022 08:31:23 +0000
Message-Id: <a6ee089f36a53bcec364c52fdf5bcb49108ca27a.1652257230.git.greentime.hu@sifive.com>
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

This patch adds support for vector optimized XOR and it is tested in
qemu.

Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/xor.h | 82 ++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/Makefile      |  1 +
 arch/riscv/lib/xor.S         | 81 +++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/lib/xor.S

diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.h
new file mode 100644
index 000000000000..d1f2eeb14afb
--- /dev/null
+++ b/arch/riscv/include/asm/xor.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SiFive
+ */
+
+#include <linux/hardirq.h>
+#include <asm-generic/xor.h>
+#ifdef CONFIG_VECTOR
+#include <asm/vector.h>
+#include <asm/switch_to.h>
+
+void xor_regs_2_(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2);
+void xor_regs_3_(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2,
+		 const unsigned long * __restrict p3);
+void xor_regs_4_(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2,
+		 const unsigned long * __restrict p3,
+		 const unsigned long * __restrict p4);
+void xor_regs_5_(unsigned long bytes, unsigned long * __restrict p1,
+		 const unsigned long * __restrict p2,
+		 const unsigned long * __restrict p3,
+		 const unsigned long * __restrict p4,
+		 const unsigned long * __restrict p5);
+
+static void xor_rvv_2(unsigned long bytes, unsigned long * __restrict p1,
+		      const unsigned long * __restrict p2)
+{
+	kernel_rvv_begin();
+	xor_regs_2_(bytes, p1, p2);
+	kernel_rvv_end();
+}
+
+static void xor_rvv_3(unsigned long bytes, unsigned long * __restrict p1,
+		      const unsigned long * __restrict p2,
+		      const unsigned long * __restrict p3)
+{
+	kernel_rvv_begin();
+	xor_regs_3_(bytes, p1, p2, p3);
+	kernel_rvv_end();
+}
+
+static void xor_rvv_4(unsigned long bytes, unsigned long * __restrict p1,
+		      const unsigned long * __restrict p2,
+		      const unsigned long * __restrict p3,
+		      const unsigned long * __restrict p4)
+{
+	kernel_rvv_begin();
+	xor_regs_4_(bytes, p1, p2, p3, p4);
+	kernel_rvv_end();
+}
+
+static void xor_rvv_5(unsigned long bytes, unsigned long * __restrict p1,
+		      const unsigned long * __restrict p2,
+		      const unsigned long * __restrict p3,
+		      const unsigned long * __restrict p4,
+		      const unsigned long * __restrict p5)
+{
+	kernel_rvv_begin();
+	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
+	kernel_rvv_end();
+}
+
+static struct xor_block_template xor_block_rvv = {
+	.name = "rvv",
+	.do_2 = xor_rvv_2,
+	.do_3 = xor_rvv_3,
+	.do_4 = xor_rvv_4,
+	.do_5 = xor_rvv_5
+};
+
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES           \
+	do {        \
+		xor_speed(&xor_block_8regs);    \
+		xor_speed(&xor_block_32regs);    \
+		if (has_vector()) { \
+			xor_speed(&xor_block_rvv);\
+		} \
+	} while (0)
+#endif
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 25d5c9664e57..acd87ac86d24 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -7,3 +7,4 @@ lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+lib-$(CONFIG_VECTOR)	+= xor.o
diff --git a/arch/riscv/lib/xor.S b/arch/riscv/lib/xor.S
new file mode 100644
index 000000000000..3bc059e18171
--- /dev/null
+++ b/arch/riscv/lib/xor.S
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 SiFive
+ */
+#include <linux/linkage.h>
+#include <asm-generic/export.h>
+#include <asm/asm.h>
+
+ENTRY(xor_regs_2_)
+	vsetvli a3, a0, e8, m8, ta, ma
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a3
+	vxor.vv v16, v0, v8
+	add a2, a2, a3
+	vse8.v v16, (a1)
+	add a1, a1, a3
+	bnez a0, xor_regs_2_
+	ret
+END(xor_regs_2_)
+EXPORT_SYMBOL(xor_regs_2_)
+
+ENTRY(xor_regs_3_)
+	vsetvli a4, a0, e8, m8, ta, ma
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a4
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a4
+	vxor.vv v16, v0, v16
+	add a3, a3, a4
+	vse8.v v16, (a1)
+	add a1, a1, a4
+	bnez a0, xor_regs_3_
+	ret
+END(xor_regs_3_)
+EXPORT_SYMBOL(xor_regs_3_)
+
+ENTRY(xor_regs_4_)
+	vsetvli a5, a0, e8, m8, ta, ma
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a5
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a5
+	vxor.vv v0, v0, v16
+	vle8.v v24, (a4)
+	add a3, a3, a5
+	vxor.vv v16, v0, v24
+	add a4, a4, a5
+	vse8.v v16, (a1)
+	add a1, a1, a5
+	bnez a0, xor_regs_4_
+	ret
+END(xor_regs_4_)
+EXPORT_SYMBOL(xor_regs_4_)
+
+ENTRY(xor_regs_5_)
+	vsetvli a6, a0, e8, m8, ta, ma
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a6
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a6
+	vxor.vv v0, v0, v16
+	vle8.v v24, (a4)
+	add a3, a3, a6
+	vxor.vv v0, v0, v24
+	vle8.v v8, (a5)
+	add a4, a4, a6
+	vxor.vv v16, v0, v8
+	add a5, a5, a6
+	vse8.v v16, (a1)
+	add a1, a1, a6
+	bnez a0, xor_regs_5_
+	ret
+END(xor_regs_5_)
+EXPORT_SYMBOL(xor_regs_5_)
-- 
2.17.1

