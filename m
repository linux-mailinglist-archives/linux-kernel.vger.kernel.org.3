Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F25AAC18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiIBKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiIBKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:09:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CA319F1B4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:09:02 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2s31hFjz8APAA--.65103S4;
        Fri, 02 Sep 2022 18:08:57 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] LoongArch: Add support for kernel relocation
Date:   Fri,  2 Sep 2022 18:08:54 +0800
Message-Id: <1662113335-14282-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Dx_2s31hFjz8APAA--.65103S4
X-Coremail-Antispam: 1UD129KBjvAXoWfGry8CFWfWFW3Gr4ftr4Dtwb_yoW8JF4rAo
        W8ZF95Kw18Wr4UCr45A3s8Kay5Xrs2krWUZrWIyw43WFnrA3W7WrykK3WYyry3Gw4kKrW8
        u343XwsxAas7JFn3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUO87k0a2IF6w4kM7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
        1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b2
        F4iUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/loongarch/kernel/relocate.c contains the functions necessary to
relocate the kernel elsewhere in memory

The kernel makes a copy of itself at the new address. It uses the
relocation table inserted by the relocs tool to fix symbol references
within the new image.

If copy/relocation is successful then the entry point of the new kernel
is returned, otherwise fall back to starting the kernel in place.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig              |  29 ++++
 arch/loongarch/Makefile             |   7 +
 arch/loongarch/Makefile.postlink    |  33 +++++
 arch/loongarch/kernel/Makefile      |   2 +
 arch/loongarch/kernel/head.S        |  17 +++
 arch/loongarch/kernel/relocate.c    | 214 ++++++++++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S |  25 ++++
 7 files changed, 327 insertions(+)
 create mode 100644 arch/loongarch/Makefile.postlink
 create mode 100644 arch/loongarch/kernel/relocate.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 0721b4b2207a..271221d6036d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -47,6 +47,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_NUMA_BALANCING
+	select SYS_SUPPORTS_RELOCATABLE
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_QUEUED_RWLOCKS
@@ -207,6 +208,11 @@ config SCHED_OMIT_FRAME_POINTER
 config AS_HAS_EXPLICIT_RELOCS
 	def_bool $(as-instr,x:pcalau12i \$t0$(comma)%pc_hi20(x))
 
+config SYS_SUPPORTS_RELOCATABLE
+	bool
+	help
+	  Selected if the platform supports relocating the kernel.
+
 menu "Kernel type and options"
 
 source "kernel/Kconfig.hz"
@@ -420,6 +426,29 @@ config ARCH_IOREMAP
 	  protection support. However, you can enable LoongArch DMW-based
 	  ioremap() for better performance.
 
+config RELOCATABLE
+	bool "Relocatable kernel"
+	depends on SYS_SUPPORTS_RELOCATABLE
+	help
+	  This builds a kernel image that retains relocation information
+	  so it can be loaded someplace besides the default 1MB.
+
+config RELOCATION_TABLE_SIZE
+	hex "Relocation table size"
+	depends on RELOCATABLE
+	range 0x0 0x01000000
+	default "0x00100000"
+	help
+	  A table of relocation data will be appended to the kernel binary
+	  and parsed at boot to fix up the relocated kernel.
+
+	  This option allows the amount of space reserved for the table to be
+	  adjusted, although the default of 1Mb should be ok in most cases.
+
+	  The build will fail and a valid size suggested if this is too small.
+
+	  If unsure, leave at the default value.
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 92c4a52c4c3e..01773114960e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -62,12 +62,19 @@ KBUILD_AFLAGS_MODULE		+= -Wa,-mla-global-with-abs
 KBUILD_CFLAGS_MODULE		+= -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
 endif
 
+ifeq ($(CONFIG_RELOCATABLE),y)
+LDFLAGS_vmlinux			+= --emit-relocs
+endif
+
 cflags-y += -ffreestanding
 cflags-y += $(call cc-option, -mno-check-zero-division)
 
 load-y		= 0x9000000000200000
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
 
+archscripts: scripts_basic
+	$(Q)$(MAKE) $(build)=arch/loongarch/boot/tools relocs
+
 drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
 
 KBUILD_AFLAGS	+= $(cflags-y)
diff --git a/arch/loongarch/Makefile.postlink b/arch/loongarch/Makefile.postlink
new file mode 100644
index 000000000000..2b3576d26cb6
--- /dev/null
+++ b/arch/loongarch/Makefile.postlink
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Insert relocations into vmlinux
+
+PHONY := __archpost
+__archpost:
+
+-include include/config/auto.conf
+include scripts/Kbuild.include
+
+CMD_RELOCS = arch/loongarch/boot/tools/relocs --keep
+quiet_cmd_relocs = RELOCS  $@
+      cmd_relocs = $(CMD_RELOCS) $@
+
+# `@true` prevents complaint when there is nothing to be done
+
+vmlinux: FORCE
+	@true
+ifeq ($(CONFIG_RELOCATABLE),y)
+	$(call if_changed,relocs)
+endif
+
+%.ko: FORCE
+	@true
+
+clean:
+	@true
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 7225916dd378..2998b7d4555d 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 obj-$(CONFIG_MODULES)		+= module.o module-sections.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 
+obj-$(CONFIG_RELOCATABLE)	+= relocate.o
+
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
 obj-$(CONFIG_SMP)		+= smp.o
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index eb3f641d5915..74b83e357d49 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -79,8 +79,25 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	PTR_ADD		sp, sp, tp
 	set_saved_sp	sp, t0, t1
 	PTR_ADDI	sp, sp, -4 * SZREG	# init stack pointer
+#ifdef CONFIG_RELOCATABLE
+	/* Copy kernel and apply the relocations */
+	bl		relocate_kernel
 
+	/* Repoint the sp into the new kernel image */
+	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
+	PTR_ADD		sp, sp, tp
+	set_saved_sp	sp, t0, t1
+	PTR_ADDI	sp, sp, -4 * SZREG      # init stack pointer
+
+	/*
+	 * relocate_kernel returns the entry point either
+	 * in the relocated kernel or the original if for
+	 * some reason relocation failed.
+	 */
+	jr		a0
+#else
 	bl		start_kernel
+#endif
 
 SYM_CODE_END(kernel_entry)
 
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
new file mode 100644
index 000000000000..492c833322a4
--- /dev/null
+++ b/arch/loongarch/kernel/relocate.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Support for Kernel relocation at boot time
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 2015, Imagination Technologies Ltd.
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/start_kernel.h>
+#include <linux/printk.h>
+#include <linux/panic_notifier.h>
+#include <asm/bootinfo.h>
+#include <asm/inst.h>
+#include <asm/sections.h>
+
+#define RELOCATED(x) ((void *)((long)x + offset))
+
+extern u32 __start_relocation[];	/* Start relocation table */
+extern u32 __stop_relocation[];		/* End relocation table */
+
+extern long __start___ex_table[];	/* Start exception table */
+extern long __stop___ex_table[];	/* End exception table */
+
+extern long __start_got[];		/* Start GOT table */
+extern long __stop_got[];		/* End GOT table */
+
+static void __init apply_r_loongarch_64_rel(u32 *loc_new, long offset)
+{
+	*(u64 *)loc_new += offset;
+}
+
+/*
+ * The details about la.abs r1, imm64
+ *
+ * lu12i.w $r1, 0
+ * ori     $r1, $r1, 0
+ * lu32i.d $r1, 0
+ * lu52i.d $r1, $r1, 0
+ *
+ * LoongArch use lu12i.w, ori, lu32i.d, lu52i.d to load a 64bit imm.
+ * lu12i.w load bit31~bit12, ori load bit11~bit0,
+ * lu32i.d load bit51~bit32, lu52i.d load bit63~bit52
+ */
+
+static void __init apply_r_loongarch_la_rel(u32 *loc_new, long offset)
+{
+	unsigned long long dest;
+	union loongarch_instruction *ori, *lu12iw, *lu32id, *lu52id;
+
+	ori = (union loongarch_instruction *)&loc_new[1];
+	lu12iw = (union loongarch_instruction *)&loc_new[0];
+	lu32id = (union loongarch_instruction *)&loc_new[2];
+	lu52id = (union loongarch_instruction *)&loc_new[3];
+
+	dest = ori->reg2i12_format.immediate & 0xfff;
+	dest |= (lu12iw->reg1i20_format.immediate & 0xfffff) << 12;
+	dest |= ((u64)lu32id->reg1i20_format.immediate & 0xfffff) << 32;
+	dest |= ((u64)lu52id->reg2i12_format.immediate & 0xfff) << 52;
+	dest += offset;
+
+	ori->reg2i12_format.immediate = dest & 0xfff;
+	lu12iw->reg1i20_format.immediate = (dest >> 12) & 0xfffff;
+	lu32id->reg1i20_format.immediate = (dest >> 32) & 0xfffff;
+	lu52id->reg2i12_format.immediate = (dest >> 52) & 0xfff;
+}
+
+static int __init reloc_handler(u32 type, u32 *loc_new, long offset)
+{
+	switch (type) {
+	case 1:
+		apply_r_loongarch_64_rel(loc_new, offset);
+		break;
+	case 2:
+		apply_r_loongarch_la_rel(loc_new, offset);
+		break;
+	default:
+		pr_err("Unhandled relocation type %d\n", type);
+		return -ENOEXEC;
+	}
+
+	return 0;
+
+}
+
+static int __init do_relocations(void *kbase_new, long offset, u32 *rstart, u32 *rend)
+{
+	u32 *r;
+	u32 *loc_new;
+	int type;
+	int res;
+
+	/* r->offset is relative to _stext instead of _text */
+	kbase_new = (void *)((u64)kbase_new + (u64)_stext - (u64)_text);
+
+	for (r = rstart; r < rend; r++) {
+		/* Sentinel for last relocation */
+		if (*r == 0)
+			break;
+
+		type = (*r >> 28) & 0xf;
+		loc_new = (void *)(kbase_new + ((*r & 0x0fffffff) << 2));
+
+		res = reloc_handler(type, loc_new, offset);
+		if (res)
+			return res;
+
+	}
+
+	return 0;
+}
+
+/*
+ * The exception table is filled in by the relocs tool after vmlinux is linked.
+ * It must be relocated separately since there will not be any relocation
+ * information for it filled in by the linker.
+ */
+static void __init relocate_exception_table(long offset)
+{
+#ifdef CONFIG_BUILDTIME_TABLE_SORT
+	unsigned long *etable_start, *etable_end, *e;
+
+	etable_start = RELOCATED((unsigned long)__start___ex_table
+			- (unsigned long)_text + VMLINUX_LOAD_ADDRESS);
+	etable_end = RELOCATED((unsigned long)__stop___ex_table
+			- (unsigned long)_text + VMLINUX_LOAD_ADDRESS);
+
+	for (e = etable_start; e < etable_end; e++)
+		*e += offset;
+#endif
+}
+
+static void __init relocate_got_table(long offset)
+{
+	unsigned long *got_start, *got_end, *got;
+
+	got_start = RELOCATED((unsigned long)__start_got
+			- (unsigned long)_text + VMLINUX_LOAD_ADDRESS);
+	got_end = RELOCATED((unsigned long)__stop_got
+			- (unsigned long)_text + VMLINUX_LOAD_ADDRESS);
+
+	for (got = got_start + 1; got < got_end; got++)
+		*got += offset;
+}
+
+/*
+ * Choose a new address for the kernel, for now we'll hard
+ * code the destination.
+ */
+static inline void __init *determine_relocation_address(void)
+{
+	return (void *)(CACHE_BASE + 0x02000000);
+}
+
+static inline int __init relocation_addr_valid(void *loc_new)
+{
+	if ((unsigned long)loc_new & 0x0000ffff) {
+		/* Inappropriately aligned new location */
+		return 0;
+	}
+	if ((unsigned long)loc_new < (unsigned long)_end) {
+		/* New location overlaps original kernel */
+		return 0;
+	}
+	return 1;
+}
+
+void *__init relocate_kernel(void)
+{
+	void *loc_new;
+	unsigned long kernel_length;
+	long offset = 0;
+	int res = 1;
+	/* Default to original kernel entry point */
+	void *kernel_entry = start_kernel;
+
+	kernel_length = (long)(_end) - (long)(_text);
+
+	loc_new = determine_relocation_address();
+
+	/* Sanity check relocation address */
+	if (relocation_addr_valid(loc_new))
+		offset = (unsigned long)loc_new - (unsigned long)(_text);
+
+	if (offset) {
+		/* Copy the kernel to it's new location */
+		memcpy(loc_new, _text, kernel_length);
+
+		/* Sync the caches ready for execution of new kernel */
+		__asm__ __volatile__ (
+			"ibar 0 \t\n"
+			"dbar 0 \t\n");
+
+		/* Perform relocations on the new kernel */
+		res = do_relocations(loc_new, offset, __start_relocation,
+			       __stop_relocation);
+		if (res < 0)
+			goto out;
+
+		relocate_exception_table(offset);
+		relocate_got_table(offset);
+
+		/* The current thread is now within the relocated image */
+		__current_thread_info = RELOCATED(__current_thread_info);
+
+		/* Return the new kernel's entry point */
+		kernel_entry = RELOCATED(start_kernel);
+	}
+out:
+	return kernel_entry;
+}
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index e5890bec2bf6..512bf699c877 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -55,6 +55,12 @@ SECTIONS
 
 	EXCEPTION_TABLE(16)
 
+	.got : {
+		__start_got = .;
+		*(.got)		/* Global offset table */
+		__stop_got = .;
+	}
+
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	__init_begin = .;
 	__inittext_begin = .;
@@ -80,6 +86,25 @@ SECTIONS
 
 	.rela.dyn : ALIGN(8) { *(.rela.dyn) *(.rela*) }
 
+#ifdef CONFIG_RELOCATABLE
+	. = ALIGN(4);
+	.data.reloc : {
+		__start_relocation = .;
+		/*
+		 * Space for relocation table
+		 * This needs to be filled so that the
+		 * relocs tool can overwrite the content.
+		 * An invalid value is left at the start of the
+		 * section to abort relocation if the table
+		 * has not been filled in.
+		*/
+		LONG(0xFFFFFFFF);
+		FILL(0);
+		. += CONFIG_RELOCATION_TABLE_SIZE - 4;
+		__stop_relocation = .;
+	}
+#endif
+
 	.init.bss : {
 		*(.init.bss)
 	}
-- 
2.36.1

