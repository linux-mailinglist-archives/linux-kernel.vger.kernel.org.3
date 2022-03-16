Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3034DADCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346529AbiCPJxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347642AbiCPJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:53:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C711B65490
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:51:55 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJQW60q9hzfYvd;
        Wed, 16 Mar 2022 17:50:26 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 17:51:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 17:51:53 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rostedt@goodmis.org>, <mark.rutland@arm.com>,
        <bobo.shaobowang@huawei.com>, <zengshun.wu@outlook.com>
Subject: [RFC PATCH -next v2 1/4] arm64: introduce aarch64_insn_gen_load_literal
Date:   Wed, 16 Mar 2022 18:01:29 +0800
Message-ID: <20220316100132.244849-2-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng Jian <cj.chengjian@huawei.com>

This introduces helper to generate ldr(literal) instructions.

	LDR <Xt>, <label>

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 arch/arm64/include/asm/insn.h |  6 +++++
 arch/arm64/lib/insn.c         | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 6b776c8667b2..95b3562843c2 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -458,6 +458,9 @@ u32 aarch64_insn_gen_hint(enum aarch64_insn_hint_cr_op op);
 u32 aarch64_insn_gen_nop(void);
 u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 				enum aarch64_insn_branch_type type);
+u32 aarch64_insn_gen_load_literal(enum aarch64_insn_register reg,
+				  enum aarch64_insn_variant variant,
+				  long offset);
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
@@ -544,6 +547,9 @@ u32 aarch64_insn_gen_prefetch(enum aarch64_insn_register base,
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
+s32 aarch64_insn_get_ldr_lit_offset(u32 insn);
+u32 aarch64_insn_set_ldr_lit_offset(u32 insn, u32 offset);
+
 s32 aarch64_insn_adrp_get_offset(u32 insn);
 u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset);
 
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index fccfe363e567..9ac5fb4e76e8 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -17,6 +17,7 @@
 #include <asm/kprobes.h>
 
 #define AARCH64_INSN_SF_BIT	BIT(31)
+#define AARCH64_INSN_OPC_BIT	BIT(30)
 #define AARCH64_INSN_N_BIT	BIT(22)
 #define AARCH64_INSN_LSL_12	BIT(22)
 
@@ -473,6 +474,54 @@ u32 aarch64_insn_gen_branch_reg(enum aarch64_insn_register reg,
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn, reg);
 }
 
+s32 aarch64_insn_get_ldr_lit_offset(u32 insn)
+{
+	s32 imm;
+
+	if (aarch64_insn_is_ldr_lit(insn)) {
+		imm = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_19, insn);
+		return (imm << 13) >> 11;
+	}
+
+	/* Unhandled instruction */
+	BUG();
+}
+
+u32 aarch64_insn_set_ldr_lit_offset(u32 insn, u32 offset)
+{
+	if (aarch64_insn_is_ldr_lit(insn))
+		return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_19, insn,
+						     offset >> 2);
+	/* Unhandled instruction */
+	BUG();
+}
+
+u32 aarch64_insn_gen_load_literal(enum aarch64_insn_register reg,
+				  enum aarch64_insn_variant variant,
+				  long offset)
+{
+	u32 insn;
+
+	insn = aarch64_insn_get_ldr_lit_value();
+
+	switch (variant) {
+	case AARCH64_INSN_VARIANT_32BIT:
+		/* 32-bit ops == 00 */
+		break;
+	case AARCH64_INSN_VARIANT_64BIT:
+		/* 64-bit opc == 01 */
+		insn |= AARCH64_INSN_OPC_BIT;
+		break;
+	default:
+		pr_err("%s: unknown variant encoding %d\n", __func__, variant);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
+
+	return aarch64_insn_set_ldr_lit_offset(insn, offset);
+}
+
 u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register base,
 				    enum aarch64_insn_register offset,
-- 
2.25.1

