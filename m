Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A6B507DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358605AbiDTAp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358601AbiDTApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:45:55 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ADA27CF5;
        Tue, 19 Apr 2022 17:43:09 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 74EAF1BF203;
        Wed, 20 Apr 2022 00:43:02 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 03/11] objtool: Support FineIBT offset fixes
Date:   Tue, 19 Apr 2022 17:42:33 -0700
Message-Id: <20220420004241.2093-4-joao@overdrivepizza.com>
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

Direct branches can't go into FineIBT hash check operations. Identify
these in the binary and correct the branch offset to skip it. If the
offset correction cannot be placed because the operand is too small for
the jump, patch the FineIBT hash check operation with nops.

This patch is a re-spin of Peter Zijlstra's objtool support from the IBT
series V2.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
Tinkered-from-patches-by: Peter Zijlstra <peterz@infradead.org>
---
 scripts/link-vmlinux.sh                       |   8 +
 tools/objtool/arch/x86/decode.c               | 175 +++++++++++++----
 tools/objtool/arch/x86/include/arch/special.h |   2 +
 tools/objtool/builtin-check.c                 |   3 +-
 tools/objtool/check.c                         | 183 +++++++++++++++++-
 tools/objtool/include/objtool/arch.h          |   3 +
 tools/objtool/include/objtool/builtin.h       |   2 +-
 7 files changed, 332 insertions(+), 44 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f44504a644..2d657c0232ee 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -126,6 +126,10 @@ objtool_link()
 		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
 			objtoolopt="${objtoolopt} --mcount"
 		fi
+
+		if is_enabled CONFIG_X86_KERNEL_FINEIBT; then
+			objtoolopt="${objtoolopt} --fineibt"
+		fi
 	fi
 
 	if is_enabled CONFIG_VMLINUX_VALIDATION; then
@@ -152,6 +156,9 @@ objtool_link()
 		if is_enabled CONFIG_SLS; then
 			objtoolopt="${objtoolopt} --sls"
 		fi
+		if is_enabled CONFIG_X86_KERNEL_FINEIBT; then
+			objtoolopt="${objtoolopt} --fineibt"
+		fi
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
@@ -175,6 +182,7 @@ vmlinux_link()
 	shift
 
 	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
+  #if is_enabled CONFIG_LTO_CLANG; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
 		libs=
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 943cb41cddf7..766a234faa03 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -22,6 +22,7 @@
 #include <objtool/endianness.h>
 #include <objtool/builtin.h>
 #include <arch/elf.h>
+#include <arch/special.h>
 
 static int is_x86_64(const struct elf *elf)
 {
@@ -241,54 +242,61 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		 *     011 SBB    111 CMP
 		 */
 
-		/* 64bit only */
-		if (!rex_w)
-			break;
+		/* %rsp target */
+		if (rm_is_reg(CFI_SP)) {
 
-		/* %rsp target only */
-		if (!rm_is_reg(CFI_SP))
-			break;
+			/* 64 bit only */
+			if (!rex_w)
+				break;
 
-		imm = insn.immediate.value;
-		if (op1 & 2) { /* sign extend */
-			if (op1 & 1) { /* imm32 */
-				imm <<= 32;
-				imm = (s64)imm >> 32;
-			} else { /* imm8 */
-				imm <<= 56;
-				imm = (s64)imm >> 56;
+			imm = insn.immediate.value;
+			if (op1 & 2) { /* sign extend */
+				if (op1 & 1) { /* imm32 */
+					imm <<= 32;
+					imm = (s64)imm >> 32;
+				} else { /* imm8 */
+					imm <<= 56;
+					imm = (s64)imm >> 56;
+				}
 			}
-		}
 
-		switch (modrm_reg & 7) {
-		case 5:
-			imm = -imm;
-			/* fallthrough */
-		case 0:
-			/* add/sub imm, %rsp */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_SP;
-				op->src.offset = imm;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
-			}
-			break;
+			switch (modrm_reg & 7) {
+			case 5:
+				imm = -imm;
+				/* fallthrough */
+			case 0:
+				/* add/sub imm, %rsp */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_ADD;
+					op->src.reg = CFI_SP;
+					op->src.offset = imm;
+					op->dest.type = OP_DEST_REG;
+					op->dest.reg = CFI_SP;
+				}
+				break;
 
-		case 4:
-			/* and imm, %rsp */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_AND;
-				op->src.reg = CFI_SP;
-				op->src.offset = insn.immediate.value;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
+			case 4:
+				/* and imm, %rsp */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_AND;
+					op->src.reg = CFI_SP;
+					op->src.offset = insn.immediate.value;
+					op->dest.type = OP_DEST_REG;
+					op->dest.reg = CFI_SP;
+				}
+				break;
+
+			default:
+				/* WARN ? */
+				break;
 			}
-			break;
+		}
 
-		default:
-			/* WARN ? */
-			break;
+		if (rm_is_reg(CFI_R11)) {
+			if (op1 == 0x81) {
+				*type = INSN_SUB_R11;
+				break;
+			}
 		}
 
 		break;
@@ -729,6 +737,91 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+const char *arch_bypass_fineibt()
+{
+	// FineIBT skip is:
+	// xor r11, r11 (to destroy any hash contents in r11 and prevent reuse)
+	// jmp (jump to the beginning of function and skip whatever)
+
+	// AFTER_FINEIBT = FineIBT len - endbr len - xor len - jmp len
+#define AFTER_FINEIBT FINEIBT_FIXUP - 4 - 3 - 2
+	static const char bytes[7] = { 0x4d, 0x31, 0xdb, 0xeb,
+		AFTER_FINEIBT , BYTES_NOP2};
+	return bytes;
+}
+
+const char *arch_mod_immediate(struct instruction *insn, unsigned long target)
+{
+	struct section *sec = insn->sec;
+	Elf_Data *data = sec->data;
+	unsigned char op1, op2;
+	static char bytes[16];
+	struct insn x86_insn;
+	int ret, disp;
+
+	disp = (long)(target - (insn->offset + insn->len));
+
+	if (data->d_type != ELF_T_BYTE || data->d_off) {
+		WARN("unexpected data for section: %s", sec->name);
+		return NULL;
+	}
+
+	ret = insn_decode(&x86_insn, data->d_buf + insn->offset, insn->len,
+			INSN_MODE_64);
+	if (ret < 0) {
+		WARN("can't decode instruction at %s:0x%lx", sec->name,
+				insn->offset);
+		return NULL;
+	}
+
+	op1 = x86_insn.opcode.bytes[0];
+	op2 = x86_insn.opcode.bytes[1];
+
+	switch (op1) {
+		case 0x0f: /* escape */
+			switch (op2) {
+				case 0x80 ... 0x8f: /* jcc.d32 */
+					if (insn->len != 6)
+						return NULL;
+					bytes[0] = op1;
+					bytes[1] = op2;
+					*(int *)&bytes[2] = disp;
+					break;
+
+				default:
+					return NULL;
+			}
+			break;
+
+		case 0x70 ... 0x7f: /* jcc.d8 */
+		case 0xeb: /* jmp.d8 */
+			if (insn->len != 2)
+				return NULL;
+
+			if (disp >> 7 != disp >> 31) {
+				WARN("Jump displacement doesn't fit");
+				return NULL;
+			}
+
+			bytes[0] = op1;
+			bytes[1] = disp & 0xff;
+			break;
+
+		case 0xe8: /* call */
+		case 0xe9: /* jmp.d32 */
+			if (insn->len != 5)
+				return NULL;
+			bytes[0] = op1;
+			*(int *)&bytes[1] = disp;
+			break;
+
+		default:
+			return NULL;
+	}
+
+	return bytes;
+}
+
 #define BYTE_RET	0xC3
 
 const char *arch_ret_insn(int len)
diff --git a/tools/objtool/arch/x86/include/arch/special.h b/tools/objtool/arch/x86/include/arch/special.h
index f2918f789a0a..f36525ecc7ec 100644
--- a/tools/objtool/arch/x86/include/arch/special.h
+++ b/tools/objtool/arch/x86/include/arch/special.h
@@ -18,4 +18,6 @@
 #define ALT_ORIG_LEN_OFFSET	10
 #define ALT_NEW_LEN_OFFSET	11
 
+#define FINEIBT_FIXUP 18
+
 #endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index fc6975ab8b06..2b3813726605 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -21,7 +21,7 @@
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
      lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-     ibt;
+     ibt, fineibt;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -49,6 +49,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
 	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
+	OPT_BOOLEAN(0, "fineibt", &fineibt, "fix FineIBT direct calls"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bd0c2c828940..e5b85ad40454 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -8,6 +8,7 @@
 #include <sys/mman.h>
 
 #include <arch/elf.h>
+#include <arch/special.h>
 #include <objtool/builtin.h>
 #include <objtool/cfi.h>
 #include <objtool/arch.h>
@@ -27,7 +28,7 @@ struct alternative {
 	bool skip_orig;
 };
 
-static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
+static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache, nr_fineibt;
 
 static struct cfi_init_state initial_func_cfi;
 static struct cfi_state init_cfi;
@@ -1211,6 +1212,173 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	annotate_call_site(file, insn, sibling);
 }
 
+static bool is_fineibt_sequence(struct objtool_file *file,
+		struct section *dest_sec, unsigned long dest_off) {
+
+	struct instruction *insn;
+
+	insn = find_insn(file, dest_sec, dest_off);
+	if (insn->type != INSN_ENDBR)
+		return false;
+
+	insn = find_insn(file, dest_sec, dest_off+4);
+	arch_decode_instruction(file, dest_sec, dest_off+4,
+			dest_sec->sh.sh_size - (dest_off+4),
+			&insn->len, &insn->type, &insn->immediate,
+			&insn->stack_ops);
+	if (insn->type != INSN_SUB_R11)
+		return false;
+
+	insn = find_insn(file, dest_sec, dest_off+11);
+	arch_decode_instruction(file, dest_sec, dest_off+11,
+			dest_sec->sh.sh_size - (dest_off+11),
+			&insn->len, &insn->type, &insn->immediate,
+			&insn->stack_ops);
+	if (insn->type != INSN_JUMP_CONDITIONAL)
+		return false;
+
+	// XXX: when call __fineibt_handler is replaced by ud2, check it here.
+	return true;
+}
+
+static bool nopout_jmp_target(struct objtool_file *file,
+		struct instruction *jmp) {
+	struct instruction *tgt = jmp->jump_dest;
+	const char *op = arch_bypass_fineibt();
+
+	if (is_fineibt_sequence(file, tgt->sec, tgt->offset)) {
+		tgt = next_insn_same_func(file, tgt);
+		elf_write_insn(file->elf, tgt->sec, tgt->offset, 7, op);
+		return true;
+	}
+	return false;
+}
+
+static void fix_fineibt_call(struct objtool_file *file,
+		struct instruction *insn) {
+
+	unsigned long dest_off;
+	struct instruction *target = NULL;
+	struct reloc *reloc = insn_reloc(file, insn);
+	const char *op = NULL;
+
+	if (!reloc) {
+		dest_off = arch_jump_destination(insn);
+		target = find_insn(file, insn->sec,
+				dest_off);
+
+	} else if (reloc->sym->retpoline_thunk) {
+		return;
+
+	} else {
+		dest_off = reloc->sym->offset +
+			arch_dest_reloc_offset(reloc->addend);
+		target = find_insn(file, reloc->sym->sec, dest_off);
+	}
+
+	if (target && target->type == INSN_ENDBR
+			&& is_fineibt_sequence(file, target->sec, dest_off)) {
+		if (reloc) {
+			reloc->addend += FINEIBT_FIXUP;
+			elf_write_reloc(file->elf, reloc);
+		} else {
+			op = arch_mod_immediate(insn, dest_off + FINEIBT_FIXUP);
+			if (op) {
+				elf_write_insn(file->elf, insn->sec,
+						insn->offset, insn->len, op);
+			} else {
+				WARN_FUNC("Can't fix direct call to FineIBT",
+						insn->sec, insn->offset);
+				return;
+			}
+		}
+	}
+}
+
+static void fix_fineibt_jump(struct objtool_file *file,
+		struct instruction *insn) {
+
+	unsigned long dest_off;
+	struct section *dest_sec;
+	struct reloc *reloc = insn_reloc(file, insn);
+	const char *op = NULL;
+
+	if (!reloc) {
+		dest_sec = insn->sec;
+		dest_off = arch_jump_destination(insn);
+
+	} else if (reloc->sym->type == STT_SECTION) {
+		dest_sec = reloc->sym->sec;
+		dest_off = arch_dest_reloc_offset(reloc->addend);
+
+	} else if (reloc->sym->retpoline_thunk) {
+		return;
+
+	} else if (insn->func || reloc->sym->sec->idx) {
+		dest_sec = reloc->sym->sec;
+		dest_off = reloc->sym->offset +
+			arch_dest_reloc_offset(reloc->addend);
+	} else {
+		return;
+	}
+
+	insn->jump_dest = find_insn(file, dest_sec, dest_off);
+	if (!insn->jump_dest) {
+		if (!vmlinux && insn->func) {
+			dest_sec = insn->func->sec;
+			dest_off = insn->func->offset;
+		} else if (!strcmp(insn->sec->name, ".altinstr_replacement")) {
+			/* XXX: corner case unclear if fineibt-relevant */
+			return;
+		}
+	}
+
+	if  (insn->jump_dest->type == INSN_ENDBR &&
+			is_fineibt_sequence(file, insn->jump_dest->sec,
+				dest_off)) {
+		if (reloc) {
+			reloc->addend += FINEIBT_FIXUP;
+			elf_write_reloc(file->elf, reloc);
+			return;
+		}
+		op = arch_mod_immediate(insn, dest_off + FINEIBT_FIXUP);
+		if (op) {
+			elf_write_insn(file->elf, insn->sec, insn->offset,
+					insn->len, op);
+			return;
+		}
+		if (nopout_jmp_target(file, insn)) {
+			WARN_FUNC("Can't fix direct jump to FineIBT",
+					insn->sec, insn->offset);
+			return;
+		} else {
+			WARN_FUNC("Can't fix direct jump to FineIBT",
+					insn->sec, insn->offset);
+			return;
+		}
+	}
+}
+
+static bool fix_fineibt_branches(struct objtool_file *file) {
+	struct instruction *insn;
+	struct section *sec;
+
+	for_each_sec(file, sec) {
+		if (!sec->text) {
+			continue;
+		}
+
+		sec_for_each_insn(file, sec, insn) {
+			if (insn->type == INSN_CALL) {
+				fix_fineibt_call(file, insn);
+			} else if (is_static_jump(insn)) {
+				fix_fineibt_jump(file, insn);
+			}
+		}
+	}
+	return 0;
+}
+
 static void add_retpoline_call(struct objtool_file *file, struct instruction *insn)
 {
 	/*
@@ -3859,6 +4027,11 @@ int check(struct objtool_file *file)
 		return 1;
 	}
 
+	if (fineibt && !ibt) {
+		fprintf(stderr, "--fineibt requires: --ibt\n");
+		return 1;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3945,11 +4118,19 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (fineibt) {
+		ret = fix_fineibt_branches(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
 		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
 		printf("nr_cfi_cache: %ld\n", nr_cfi_cache);
+		if (fineibt) printf("nr_fineibt_entries: %ld\n", nr_fineibt);
 	}
 
 out:
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 9b19cc304195..9c12770ccd13 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -28,6 +28,7 @@ enum insn_type {
 	INSN_CLD,
 	INSN_TRAP,
 	INSN_ENDBR,
+	INSN_SUB_R11,
 	INSN_OTHER,
 };
 
@@ -85,6 +86,8 @@ unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
+const char *arch_mod_immediate(struct instruction *insn, unsigned long target);
+const char *arch_bypass_fineibt(void);
 
 int arch_decode_hint_reg(u8 sp_reg, int *base);
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index c39dbfaef6dc..801eaeae1627 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -10,7 +10,7 @@
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
 	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-	    ibt;
+	    ibt, fineibt;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
-- 
2.35.1

