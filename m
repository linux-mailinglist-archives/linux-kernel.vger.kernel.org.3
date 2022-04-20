Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C38507DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358633AbiDTAqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358619AbiDTAqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E0205D3;
        Tue, 19 Apr 2022 17:43:22 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 166011BF203;
        Wed, 20 Apr 2022 00:43:14 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 05/11] x86/text-patching: Support FineIBT text-patching
Date:   Tue, 19 Apr 2022 17:42:35 -0700
Message-Id: <20220420004241.2093-6-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

When patching a direct branch into text, consider that the target may have
a FineIBT hash check sequence and then sum the respective offset to the
branch target address if this is the case. This is needed to support
static calls.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
Tinkered-from-patches-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h | 92 +++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index d20ab0921480..a450761fae62 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stddef.h>
+#include <linux/uaccess.h>
 #include <asm/ptrace.h>
 
 struct paravirt_patch_site;
@@ -66,6 +67,12 @@ extern void text_poke_finish(void);
 #define JMP8_INSN_SIZE		2
 #define JMP8_INSN_OPCODE	0xEB
 
+#define SUB_INSN_SIZE     7
+#define SUB_INSN_OPCODE   0x41
+
+#define JE_INSN_SIZE      2
+#define JE_INSN_OPCODE    0x74
+
 #define DISP32_SIZE		4
 
 static __always_inline int text_opcode_size(u8 opcode)
@@ -96,6 +103,83 @@ union text_poke_insn {
 	} __attribute__((packed));
 };
 
+#ifdef CONFIG_X86_KERNEL_FINEIBT
+#define FINEIBT_FIXUP 18
+// AFTER_FINEIBT = FINEIBT_FIXUP - ENDBR_LEN - XOR_LEN - JMP LEN
+#define AFTER_FINEIBT FINEIBT_FIXUP - ENDBR_INSN_SIZE - 3 - 2
+
+/// XXX: THIS IS *NOT* PROPERLY TESTED!
+/// I did stumble on any scenario where this was needed while testing FineIBT,
+/// Yet, I'm keeping this here for concept/future reference. - If we can't fix
+/// the displacement, then the branch will always stumble on the FineIBT hash
+/// check. To prevent that, patch the FineIBT hash check with nops.
+static __always_inline
+void bypass_fineibt_sequence(void *insn) {
+	static const char code[14] = { 0x4d, 0x31, 0xdb, 0xeb, AFTER_FINEIBT,
+		BYTES_NOP8, BYTES_NOP1 };
+	if (unlikely(system_state == SYSTEM_BOOTING)) {
+		text_poke_early(insn + 4, code, 14);
+		text_poke_early(insn + 11, code, 14);
+	}
+
+	text_poke_bp(insn + 4, code, 14, NULL);
+	text_poke_bp(insn + 11, code, 14, NULL);
+}
+
+// Identify if the target address is a FineIBT instruction sequence, which
+// should be:
+// endbr
+// sub $hash, %r11d
+// je 1f
+// call fineibt_handler (this will eventually be replaced with ud2)
+// 1:
+static __always_inline
+bool __is_fineibt_sequence(const void *addr) {
+	union text_poke_insn text;
+	u32 insn;
+
+	// the sequence starts with an endbr
+	if (get_kernel_nofault(insn, addr) || !(is_endbr(insn)))
+		return false;
+
+	// then followed by a sub
+	if (get_kernel_nofault(text, addr+4) || text.opcode != SUB_INSN_OPCODE)
+		return false;
+
+	// followed by a je
+	if (get_kernel_nofault(text, addr+11) || text.opcode != JE_INSN_OPCODE)
+		return false;
+
+	// and finished with a call (which eventually will be an ud2)
+	if (get_kernel_nofault(text, addr+13) ||
+			text.opcode != CALL_INSN_OPCODE)
+		return false;
+
+	return true;
+}
+
+// Verify if the branch target is a FineIBT sequence. If yes, fix the target
+// to point right after the sequence, preventing crashes.
+static __always_inline
+void *__text_fix_fineibt_branch_target(const void *addr, void *dest, int size) {
+	bool fineibt;
+	s32 disp;
+	fineibt = __is_fineibt_sequence(dest);
+	if (!fineibt)
+		return dest;
+
+	disp = (long) dest - (long) (addr + size) + FINEIBT_FIXUP;
+
+	// if fineibt-fixed displacement doesn't fit as an operand,
+	// remove fineibt hash check from target.
+	if (size == 2 && ((disp >> 31) != (disp >> 7))) {
+		bypass_fineibt_sequence(dest);
+		return dest;
+	}
+	return dest + FINEIBT_FIXUP;
+}
+#endif
+
 static __always_inline
 void __text_gen_insn(void *buf, u8 opcode, const void *addr, const void *dest, int size)
 {
@@ -115,7 +199,13 @@ void __text_gen_insn(void *buf, u8 opcode, const void *addr, const void *dest, i
 	insn->opcode = opcode;
 
 	if (size > 1) {
-		insn->disp = (long)dest - (long)(addr + size);
+#ifdef CONFIG_X86_KERNEL_FINEIBT
+		void *fineibt_dest = __text_fix_fineibt_branch_target(addr,
+				(void *) dest, size);
+		insn->disp = (long) fineibt_dest - (long) (addr + size);
+#else
+		insn->disp = (long) dest - (long) (addr + size);
+#endif
 		if (size == 2) {
 			/*
 			 * Ensure that for JMP8 the displacement
-- 
2.35.1

