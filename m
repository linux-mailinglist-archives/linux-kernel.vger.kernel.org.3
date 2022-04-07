Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C604F7E95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiDGME4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiDGMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:04:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B8C1C86
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:02:35 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KZ0MP16DHzgYSS;
        Thu,  7 Apr 2022 20:00:49 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
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
Subject: [RFC PATCH v3 09/13] objtool: arm64: Decode LDR instructions
Date:   Thu, 7 Apr 2022 20:01:37 +0800
Message-ID: <20220407120141.43801-10-chenzhongjin@huawei.com>
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

Load literal instructions can generate constants inside code sections.
Record the locations of the constants in order to be able to remove
their corresponding "struct instruction".

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 tools/objtool/arch/arm64/decode.c    | 86 ++++++++++++++++++++++++++++
 tools/objtool/arch/x86/decode.c      |  5 ++
 tools/objtool/check.c                |  3 +
 tools/objtool/include/objtool/arch.h |  3 +
 4 files changed, 97 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 4a868945dcfb..b62addece734 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -22,6 +22,73 @@ static unsigned long sign_extend(unsigned long x, int nbits)
 	return ((~0UL + (sign_bit ^ 1)) << nbits) | x;
 }
 
+struct insn_loc {
+	const struct section *sec;
+	unsigned long offset;
+	struct hlist_node hnode;
+	bool delete;
+};
+
+DEFINE_HASHTABLE(invalid_insns, 16);
+
+static int record_invalid_insn(const struct section *sec,
+			       unsigned long offset,
+			       bool delete)
+{
+	struct insn_loc *loc;
+	struct hlist_head *l;
+
+	l = &invalid_insns[hash_min(offset, HASH_BITS(invalid_insns))];
+	if (!hlist_empty(l)) {
+		loc = hlist_entry(l->first, struct insn_loc, hnode);
+		loc->delete |= delete;
+		return 0;
+	}
+
+	loc = malloc(sizeof(*loc));
+	if (!loc) {
+		WARN("malloc failed");
+		return -1;
+	}
+
+	loc->sec = sec;
+	loc->offset = offset;
+	loc->delete = delete;
+
+	hash_add(invalid_insns, &loc->hnode, loc->offset);
+
+	return 0;
+}
+
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	struct hlist_node *tmp;
+	struct insn_loc *loc;
+	unsigned int bkt;
+	int res = 0;
+
+	hash_for_each_safe(invalid_insns, bkt, tmp, loc, hnode) {
+		struct instruction *insn;
+
+		insn = find_insn(file, (struct section *) loc->sec, loc->offset);
+		if (insn) {
+			if (loc->delete) {
+				list_del(&insn->list);
+				hash_del(&insn->hash);
+				free(insn);
+			} else {
+				WARN_FUNC("can't decode instruction", insn->sec, insn->offset);
+				insn->ignore = true;
+			}
+		}
+
+		hash_del(&loc->hnode);
+		free(loc);
+	}
+
+	return res;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -389,6 +456,25 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		if (ret <= 0)
 			return ret;
 
+		if (aarch64_insn_is_ldr_lit(insn)) {
+			long pc_offset;
+
+			pc_offset = insn & GENMASK(23, 5);
+			/* Sign extend and multiply by 4 */
+			pc_offset = (pc_offset << (64 - 23));
+			pc_offset = ((pc_offset >> (64 - 23)) >> 5) << 2;
+
+			if (record_invalid_insn(sec, offset + pc_offset, true))
+				return -1;
+
+			/* 64-bit literal */
+			if (insn & BIT(30)) {
+				if (record_invalid_insn(sec,
+							offset + pc_offset + 4,
+							true))
+					return -1;
+			}
+		}
 		break;
 	}
 	default:
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 943cb41cddf7..c116b6a58898 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -693,6 +693,11 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	return 0;
 }
 
+int arch_post_process_instructions(struct objtool_file *file)
+{
+	return 0;
+}
+
 void arch_initial_func_cfi_state(struct cfi_init_state *state)
 {
 	int i;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6de5085e3e5a..b2135da41f48 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -436,6 +436,9 @@ static int decode_instructions(struct objtool_file *file)
 	if (stats)
 		printf("nr_insns: %lu\n", nr_insns);
 
+	if (arch_post_process_instructions(file))
+		return -1;
+
 	return 0;
 
 err:
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 9b19cc304195..ccd76ce1c92b 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -67,6 +67,7 @@ struct stack_op {
 	struct list_head list;
 };
 
+struct objtool_file;
 struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
@@ -77,6 +78,8 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
 
+int arch_post_process_instructions(struct objtool_file *file);
+
 bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
-- 
2.17.1

