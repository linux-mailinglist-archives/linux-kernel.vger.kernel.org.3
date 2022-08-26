Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4F5A220A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbiHZHgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiHZHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:36:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5E7272B7A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:36:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxX+D6dwhjNj0KAA--.45610S2;
        Fri, 26 Aug 2022 15:36:26 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
Subject: [PATCH v2 7/9] LoongArch: modules/ftrace: Initialize PLT at load time
Date:   Fri, 26 Aug 2022 15:36:24 +0800
Message-Id: <20220826073626.1716-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxX+D6dwhjNj0KAA--.45610S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGF47Jr13WF4rZFy8Gw1kGrg_yoWkJw4xpF
        yqyrn5GrWUGFn3Wa40vrn8ur1UGFZ7W342gFW3G342kw42qrn8AF10krn0kFyFqw4DWFWS
        gayfur4j9FW7Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
        0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYgAwDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To Implement ftrace trampiones through plt entry.

Tested by forcing ftrace_make_call() to use the module PLT, and then
loading up a module after setting up ftrace with:

| echo ":mod:<module-name>" > set_ftrace_filter;
| echo function > current_tracer;
| modprobe <module-name>

Since FTRACE_ADDR/FTRACE_REGS_ADDR is only defined when CONFIG_DYNAMIC_FTRACE
is selected, we wrap its use along with most of module_init_ftrace_plt() with
ifdeffery rather than using IS_ENABLED().

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h     |  4 ++
 arch/loongarch/include/asm/inst.h       |  3 +
 arch/loongarch/include/asm/module.h     |  5 +-
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/ftrace_dyn.c      | 79 +++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c            | 11 ++++
 arch/loongarch/kernel/module-sections.c | 11 ++++
 arch/loongarch/kernel/module.c          | 47 +++++++++++++++
 8 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 4a9db84f8264..ce119496c6d0 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -6,6 +6,10 @@
 #ifndef _ASM_LOONGARCH_FTRACE_H
 #define _ASM_LOONGARCH_FTRACE_H
 
+#define FTRACE_PLT_IDX		0
+#define FTRACE_REGS_PLT_IDX	1
+#define NR_FTRACE_PLTS		2
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 713b4996bfac..9e7ac91d524d 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -13,10 +13,12 @@
 
 #define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
 #define ADDR_IMMMASK_LU32ID	0x000FFFFF00000000
+#define ADDR_IMMMASK_LU12IW	0x00000000FFFFF000
 #define ADDR_IMMMASK_ADDU16ID	0x00000000FFFF0000
 
 #define ADDR_IMMSHIFT_LU52ID	52
 #define ADDR_IMMSHIFT_LU32ID	32
+#define ADDR_IMMSHIFT_LU12IW	12
 #define ADDR_IMMSHIFT_ADDU16ID	16
 
 #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
@@ -195,6 +197,7 @@ u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
 			enum loongarch_gpr rk);
 u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
 
+u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index 9f6718df1854..a12a1d213220 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -19,6 +19,9 @@ struct mod_section {
 struct mod_arch_specific {
 	struct mod_section plt;
 	struct mod_section plt_idx;
+
+	/* for CONFIG_DYNAMIC_FTRACE */
+	struct plt_entry *ftrace_trampolines;
 };
 
 struct plt_entry {
@@ -38,7 +41,7 @@ static inline struct plt_entry emit_plt_entry(unsigned long val)
 {
 	u32 lu12iw, lu32id, lu52id, jirl;
 
-	lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | LOONGARCH_GPR_T1);
+	lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
 	lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
 	lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
 	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
index 31c1c0db11a3..ecff54b81754 100644
--- a/arch/loongarch/include/asm/module.lds.h
+++ b/arch/loongarch/include/asm/module.lds.h
@@ -4,4 +4,5 @@ SECTIONS {
 	. = ALIGN(4);
 	.plt : { BYTE(0) }
 	.plt.idx : { BYTE(0) }
+	.ftrace_trampoline : { BYTE(0) }
 }
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index f538829312d7..dd37185d446e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/inst.h>
+#include <asm/module.h>
 
 static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
 			      bool validate)
@@ -72,12 +73,63 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+static inline int __get_mod(struct module **mod, unsigned long addr)
+{
+	preempt_disable();
+	*mod = __module_text_address(addr);
+	preempt_enable();
+
+	if (WARN_ON(!(*mod)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+{
+	struct plt_entry *plt = mod->arch.ftrace_trampolines;
+
+	if (addr == FTRACE_ADDR)
+		return &plt[FTRACE_PLT_IDX];
+	if (addr == FTRACE_REGS_ADDR &&
+			IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return &plt[FTRACE_REGS_PLT_IDX];
+
+	return NULL;
+}
+
+static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
+{
+	struct plt_entry *plt;
+
+	plt = get_ftrace_plt(mod, addr);
+	if (!plt) {
+		pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
+		return -EINVAL;
+	}
+
+	return (unsigned long)plt;
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long pc;
+	long offset;
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+	}
 
 	old = larch_insn_gen_nop();
 	new = larch_insn_gen_bl(pc, addr);
@@ -89,9 +141,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	unsigned long pc;
+	long offset;
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+	}
 
 	new = larch_insn_gen_nop();
 	old = larch_insn_gen_bl(pc, addr);
@@ -108,6 +173,20 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+
+		old_addr = get_plt_addr(mod, old_addr);
+	}
 
 	old = larch_insn_gen_bl(pc, old_addr);
 	new = larch_insn_gen_bl(pc, addr);
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 2d2e942eb06a..0d6bd7000ba6 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -103,6 +103,17 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 	return insn.word;
 }
 
+u32 larch_insn_gen_lu12iw(enum loongarch_gpr rd, int imm)
+{
+	union loongarch_instruction insn;
+
+	insn.reg1i20_format.opcode = lu12iw_op;
+	insn.reg1i20_format.rd = rd;
+	insn.reg1i20_format.immediate = imm;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index 6d498288977d..b75fc711f144 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
@@ -67,6 +68,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
 	unsigned int i, num_plts = 0;
+	Elf_Shdr *tramp = NULL;
 
 	/*
 	 * Find the empty .plt sections.
@@ -76,6 +78,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.plt.shdr = sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
 			mod->arch.plt_idx.shdr = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".ftrace_trampoline"))
+			tramp = sechdrs + i;
 	}
 
 	if (!mod->arch.plt.shdr) {
@@ -117,5 +121,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.plt_idx.num_entries = 0;
 	mod->arch.plt_idx.max_entries = num_plts;
 
+	if (tramp) {
+		tramp->sh_type = SHT_NOBITS;
+		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+		tramp->sh_addralign = __alignof__(struct plt_entry);
+		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
+	}
+
 	return 0;
 }
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 638427ff0d51..a4e30eea5ff8 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -10,6 +10,7 @@
 
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
@@ -17,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <asm/inst.h>
 
 static inline bool signed_imm_check(long val, unsigned int bit)
 {
@@ -373,3 +375,48 @@ void *module_alloc(unsigned long size)
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
 }
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				    const char *name)
+{
+	const Elf_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+#endif
+
+static int module_init_ftrace_plt(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				  struct module *mod)
+{
+#ifdef CONFIG_DYNAMIC_FTRACE
+	const Elf_Shdr *s;
+	struct plt_entry *ftrace_plts;
+
+	s = find_section(hdr, sechdrs, ".ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	ftrace_plts = (void *)s->sh_addr;
+
+	ftrace_plts[FTRACE_PLT_IDX] = emit_plt_entry(FTRACE_ADDR);
+
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		ftrace_plts[FTRACE_REGS_PLT_IDX] = emit_plt_entry(FTRACE_REGS_ADDR);
+
+	mod->arch.ftrace_trampolines = ftrace_plts;
+#endif
+	return 0;
+}
+
+int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mod)
+{
+	return module_init_ftrace_plt(hdr, sechdrs, mod);
+
+}
-- 
2.20.1

