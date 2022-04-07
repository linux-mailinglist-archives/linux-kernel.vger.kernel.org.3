Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB04F7E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbiDGMFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbiDGMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:04:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F4C1CB6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:02:36 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZ0JY3L4zzBs2r;
        Thu,  7 Apr 2022 19:58:21 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:33 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:02:33 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <jthierry@redhat.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>, <ardb@kernel.org>,
        <masahiroy@kernel.org>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <ycote@redhat.com>
Subject: [RFC PATCH v3 05/13] objtool: arm64: Decode add/sub instructions
Date:   Thu, 7 Apr 2022 20:01:33 +0800
Message-ID: <20220407120141.43801-6-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220407120141.43801-1-chenzhongjin@huawei.com>
References: <20220407120141.43801-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <jthierry@redhat.com>

Decode aarch64 additions and substractions and create stack_ops for
instructions interacting with SP or FP.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/arch/arm64/decode.c | 91 +++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 42a9ce4aab87..84daec62006a 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -13,6 +13,15 @@
 #include <objtool/builtin.h>
 #include <arch/cfi_regs.h>
 
+#include "../../../arch/arm64/lib/insn.c"
+
+static unsigned long sign_extend(unsigned long x, int nbits)
+{
+	unsigned long sign_bit = (x >> (nbits - 1)) & 1;
+
+	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -103,6 +112,59 @@ int arch_decode_hint_reg(u8 sp_reg, int *base)
 	return -1;
 }
 
+static struct stack_op *arm_make_add_op(enum aarch64_insn_register dest,
+					enum aarch64_insn_register src,
+					int val)
+{
+	struct stack_op *op;
+
+	op = calloc(1, sizeof(*op));
+	if (!op) {
+		WARN("calloc failed");
+		return NULL;
+	}
+	op->dest.type = OP_DEST_REG;
+	op->dest.reg = dest;
+	op->src.reg = src;
+	op->src.type = val != 0 ? OP_SRC_ADD : OP_SRC_REG;
+	op->src.offset = val;
+
+	return op;
+}
+
+static int arm_decode_add_sub_imm(u32 instr, bool set_flags,
+				  unsigned long *immediate,
+				  struct list_head *ops_list)
+{
+	u32 rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, instr);
+	u32 rn = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RN, instr);
+
+	*immediate = aarch64_insn_decode_immediate(AARCH64_INSN_IMM_12, instr);
+
+	if (instr & AARCH64_INSN_LSL_12)
+		*immediate <<= 12;
+
+	if ((!set_flags && rd == AARCH64_INSN_REG_SP) ||
+	    rd == AARCH64_INSN_REG_FP ||
+	    rn == AARCH64_INSN_REG_FP ||
+	    rn == AARCH64_INSN_REG_SP) {
+		struct stack_op *op;
+		int value;
+
+		if (aarch64_insn_is_subs_imm(instr) || aarch64_insn_is_sub_imm(instr))
+			value = -*immediate;
+		else
+			value = *immediate;
+
+		op = arm_make_add_op(rd, rn, value);
+		if (!op)
+			return -1;
+		list_add_tail(&op->list, ops_list);
+	}
+
+	return 0;
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -128,6 +190,35 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	case AARCH64_INSN_CLS_UNKNOWN:
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
+	case AARCH64_INSN_CLS_DP_IMM:
+		/* Mov register to and from SP are aliases of add_imm */
+		if (aarch64_insn_is_add_imm(insn) ||
+		    aarch64_insn_is_sub_imm(insn))
+			return arm_decode_add_sub_imm(insn, false, immediate,
+						      ops_list);
+		else if (aarch64_insn_is_adds_imm(insn) ||
+			     aarch64_insn_is_subs_imm(insn))
+			return arm_decode_add_sub_imm(insn, true, immediate,
+						      ops_list);
+		break;
+	case AARCH64_INSN_CLS_DP_REG:
+		if (aarch64_insn_is_mov_reg(insn)) {
+			enum aarch64_insn_register rd;
+			enum aarch64_insn_register rm;
+
+			rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD, insn);
+			rm = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RM, insn);
+			if (rd == AARCH64_INSN_REG_FP || rm == AARCH64_INSN_REG_FP) {
+				struct stack_op *op;
+
+				op = arm_make_add_op(rd, rm, 0);
+				if (!op)
+					return -1;
+
+				list_add_tail(&op->list, ops_list);
+			}
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.17.1

