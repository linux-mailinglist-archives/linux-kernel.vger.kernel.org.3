Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAE05AAC17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiIBKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiIBKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:09:04 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FD9EC6E86
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:09:02 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2s31hFjz8APAA--.65103S5;
        Fri, 02 Sep 2022 18:08:58 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] LoongArch: Add support for kernel address space layout randomization (KASLR)
Date:   Fri,  2 Sep 2022 18:08:55 +0800
Message-Id: <1662113335-14282-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Dx_2s31hFjz8APAA--.65103S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyxJr1kJF15uw13CF4fAFb_yoW3WFy7pF
        ZrAw4DGr4xAr1xGrsrX34Dury5Cws7G347WFZrK348ZFsFqF18Zaykur9FqFy8t39Yqr4a
        vFZ8JFy29w4UAaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4DMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUYbI
        D7UUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for relocating the kernel to a random address.

Entropy is derived from the banner, which will change every build and
random_get_entropy() which should provide additional runtime entropy.

The kernel is relocated by up to RANDOMIZE_BASE_MAX_OFFSET bytes from
its link address. Because relocation happens so early in the kernel boot,
the amount of physical memory has not yet been determined. This means
the only way to limit relocation within the available memory is via
Kconfig. Limit the maximum value of RANDOMIZE_BASE_MAX_OFFSET to
256M(0x10000000) because our memory layout has many holes.

KERNELOFFSET (kaslr_offset) is added to vmcoreinfo in the future, for
crash --kaslr support.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/Kconfig            |  22 ++++++
 arch/loongarch/include/asm/page.h |   6 ++
 arch/loongarch/kernel/relocate.c  | 114 ++++++++++++++++++++++++++++++
 arch/loongarch/kernel/setup.c     |   3 +
 4 files changed, 145 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 271221d6036d..e2588ab281bc 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -449,6 +449,28 @@ config RELOCATION_TABLE_SIZE
 
 	  If unsure, leave at the default value.
 
+config RANDOMIZE_BASE
+	bool "Randomize the address of the kernel image (KASLR)"
+	depends on RELOCATABLE
+	help
+	   Randomizes the physical and virtual address at which the
+	   kernel image is loaded, as a security feature that
+	   deters exploit attempts relying on knowledge of the location
+	   of kernel internals.
+
+	   The kernel will be offset by up to RANDOMIZE_BASE_MAX_OFFSET.
+
+	   If unsure, say N.
+
+config RANDOMIZE_BASE_MAX_OFFSET
+	hex "Maximum KASLR offset" if EXPERT
+	depends on RANDOMIZE_BASE
+	range 0x0 0x10000000 if 64BIT
+	default "0x01000000"
+	help
+	  When KASLR is active, this provides the maximum offset that will
+	  be applied to the kernel image.
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 53f284a96182..6dda0d6271ca 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -106,6 +106,12 @@ extern int __virt_addr_valid(volatile void *kaddr);
 	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
 	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+extern unsigned long __kaslr_offset;
+static inline unsigned long kaslr_offset(void)
+{
+	return __kaslr_offset;
+}
+
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 492c833322a4..58e28b8f5d12 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -11,9 +11,11 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/start_kernel.h>
+#include <linux/of_fdt.h>
 #include <linux/printk.h>
 #include <linux/panic_notifier.h>
 #include <asm/bootinfo.h>
+#include <asm/early_ioremap.h>
 #include <asm/inst.h>
 #include <asm/sections.h>
 
@@ -146,6 +148,70 @@ static void __init relocate_got_table(long offset)
 		*got += offset;
 }
 
+#ifdef CONFIG_RANDOMIZE_BASE
+
+static inline __init unsigned long rotate_xor(unsigned long hash,
+					      const void *area, size_t size)
+{
+	size_t i;
+	unsigned long *ptr = (unsigned long *)area;
+
+	for (i = 0; i < size / sizeof(hash); i++) {
+		/* Rotate by odd number of bits and XOR. */
+		hash = (hash << ((sizeof(hash) * 8) - 7)) | (hash >> 7);
+		hash ^= ptr[i];
+	}
+
+	return hash;
+}
+
+static inline __init unsigned long get_random_boot(void)
+{
+	unsigned long entropy = random_get_entropy();
+	unsigned long hash = 0;
+
+	/* Attempt to create a simple but unpredictable starting entropy. */
+	hash = rotate_xor(hash, linux_banner, strlen(linux_banner));
+
+	/* Add in any runtime entropy we can get */
+	hash = rotate_xor(hash, &entropy, sizeof(entropy));
+
+	return hash;
+}
+
+static inline __init bool kaslr_disabled(void)
+{
+	char *str;
+
+	str = strstr(boot_command_line, "nokaslr");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return true;
+
+	return false;
+}
+
+/* Choose a new address for the kernel */
+static inline void __init *determine_relocation_address(void)
+{
+	unsigned long kernel_length;
+	void *dest = _text;
+	unsigned long offset;
+
+	if (kaslr_disabled())
+		return dest;
+
+	kernel_length = (long)_end - (long)_text;
+
+	offset = get_random_boot() << 16;
+	offset &= (CONFIG_RANDOMIZE_BASE_MAX_OFFSET - 1);
+	if (offset < kernel_length)
+		offset += ALIGN(kernel_length, 0xffff);
+
+	return RELOCATED(dest);
+}
+
+#else
+
 /*
  * Choose a new address for the kernel, for now we'll hard
  * code the destination.
@@ -155,6 +221,8 @@ static inline void __init *determine_relocation_address(void)
 	return (void *)(CACHE_BASE + 0x02000000);
 }
 
+#endif
+
 static inline int __init relocation_addr_valid(void *loc_new)
 {
 	if ((unsigned long)loc_new & 0x0000ffff) {
@@ -168,6 +236,13 @@ static inline int __init relocation_addr_valid(void *loc_new)
 	return 1;
 }
 
+static inline void __init update_kaslr_offset(unsigned long *addr, long offset)
+{
+	unsigned long *new_addr = (unsigned long *)RELOCATED(addr);
+
+	*new_addr = (unsigned long)offset;
+}
+
 void *__init relocate_kernel(void)
 {
 	void *loc_new;
@@ -177,6 +252,9 @@ void *__init relocate_kernel(void)
 	/* Default to original kernel entry point */
 	void *kernel_entry = start_kernel;
 
+	/* Boot command line was passed in FDT */
+	early_init_dt_scan(early_ioremap(fw_arg1, SZ_64K));
+
 	kernel_length = (long)(_end) - (long)(_text);
 
 	loc_new = determine_relocation_address();
@@ -208,7 +286,43 @@ void *__init relocate_kernel(void)
 
 		/* Return the new kernel's entry point */
 		kernel_entry = RELOCATED(start_kernel);
+
+		/* Error may occur before, so keep it at last */
+		update_kaslr_offset(&__kaslr_offset, offset);
 	}
 out:
 	return kernel_entry;
 }
+
+/*
+ * Show relocation information on panic.
+ */
+static void show_kernel_relocation(const char *level)
+{
+	if (__kaslr_offset > 0) {
+		printk(level);
+		pr_cont("Kernel relocated offset @ 0x%lx\n", __kaslr_offset);
+		pr_cont(" .text @ 0x%lx\n", (unsigned long)&_text);
+		pr_cont(" .data @ 0x%lx\n", (unsigned long)&_sdata);
+		pr_cont(" .bss  @ 0x%lx\n", (unsigned long)&__bss_start);
+	}
+}
+
+static int kernel_location_notifier_fn(struct notifier_block *self,
+				       unsigned long v, void *p)
+{
+	show_kernel_relocation(KERN_EMERG);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block kernel_location_notifier = {
+	.notifier_call = kernel_location_notifier_fn
+};
+
+static int __init register_kernel_offset_dumper(void)
+{
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &kernel_location_notifier);
+	return 0;
+}
+__initcall(register_kernel_offset_dumper);
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 058c232c11e8..a176d7973ac7 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -73,6 +73,9 @@ static struct resource code_resource = { .name = "Kernel code", };
 static struct resource data_resource = { .name = "Kernel data", };
 static struct resource bss_resource  = { .name = "Kernel bss", };
 
+unsigned long __kaslr_offset __ro_after_init;
+EXPORT_SYMBOL(__kaslr_offset);
+
 const char *get_system_type(void)
 {
 	return "generic-loongson-machine";
-- 
2.36.1

