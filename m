Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978F1561396
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiF3Hsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiF3Hso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:48:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495451A3A2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:48:43 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id bk18-20020a17090b081200b001ec747bb1f7so1045890pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tzg5dQ9vZO3m0+NWOVCNYlSDqeapswna3O58WtrOJtc=;
        b=ruFBz9lptWGuhm0SxR8bcK6/CuMDxiuXvNyGx9jxQOs/0T+pDUmpOiV10Jf+IxbPdK
         bpi2YwJ6ybgJQyKlUV17PXnsZXoH6z/iy1BxCVWqK3vrtH25fAEusel4P5beQTQ6oFyW
         on6xFfVFIjROyP21m2yeXJUWcDPFRnW4eDLoop3hwg/1Eg3D3WeLhS6YMs+rkXsNIA1r
         yCn7c1H/szzPB461V8smq/hgtjTiHQutcFcKdjneFs85orjzDpgMrKLAvm2acVwbvuXB
         qiO9rM7na7fpXnYEJfH6dF1PEfxdAPJgRQKY+bByYDvKBk0+iO/02bUKa1ZovMwgYC90
         HCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tzg5dQ9vZO3m0+NWOVCNYlSDqeapswna3O58WtrOJtc=;
        b=ezflL9Yys9c4nKuLeBOY7Fvqzbvw3KmPono3X7+YlTxEW0Li5Y+ZYWgywr6IkbtnAh
         RF5tnc+Rs/Wa8zfebJGrFAe5vu+7B7yFitk3Pu6a6qvJF1/XKxw6bLiJ0Zkqr21LyyMA
         uSDmWgOpMmoVwFgSQEX34aTrheTcPSJ+2dG6X2Z6oPj0xCQt7iHp6qiYqrKDZOCz8t5D
         57FKFJKB6MHSk/TTVnyS7fNrzP7Odely5Mqd42pQAmsJ0ACar+B1i7LkVTixLJ6q1wG9
         RVEmeDuMdDGg3R2gYFA+eiGEhr2SkoMAUke+C06yqGnOVVYRz/bjQQ25TpvL7IeZPaxC
         V4pg==
X-Gm-Message-State: AJIora+jG7RjfCvjQDWZEaMoyx09VNOeW76guSKfCBJjiYAnk//J2lBr
        lkopyMKk72gm+9rABbm2IIIw3kcDcoS/CA==
X-Google-Smtp-Source: AGRyM1vRcs/8PnLak8Y7WE1MoiAexzQjKH0Ue0GKuSview2nk1wKZmlM39tyGN3IejbsZlBHZqfp6/uTrUXrYA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:46ca:b0:1ec:9a27:f706 with SMTP
 id jx10-20020a17090b46ca00b001ec9a27f706mr8992091pjb.12.1656575322888; Thu,
 30 Jun 2022 00:48:42 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:47:57 +0800
In-Reply-To: <20220630074757.2739000-1-davidgow@google.com>
Message-Id: <20220630074757.2739000-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220630074757.2739000-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 2/2] UML: add support for KASAN under x86_64
From:   David Gow <davidgow@google.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Make KASAN run on User Mode Linux on x86_64.

The UML-specific KASAN initializer uses mmap to map the ~16TB of shadow
memory to the location defined by KASAN_SHADOW_OFFSET.  kasan_init()
utilizes constructors to initialize KASAN before main().

The location of the KASAN shadow memory, starting at
KASAN_SHADOW_OFFSET, can be configured using the KASAN_SHADOW_OFFSET
option. The default location of this offset is 0x100000000000, which
keeps it out-of-the-way even on UML setups with more "physical" memory.

For low-memory setups, 0x7fff8000 can be used instead, which fits in an
immediate and is therefore faster, as suggested by Dmitry Vyukov. There
is usually enough free space at this location; however, it is a config
option so that it can be easily changed if needed.

Note that, unlike KASAN on other architectures, vmalloc allocations
still use the shadow memory allocated upfront, rather than allocating
and free-ing it per-vmalloc allocation.

If another architecture chooses to go down the same path, we should
replace the checks for CONFIG_UML with something more generic, such
as:
- A CONFIG_KASAN_NO_SHADOW_ALLOC option, which architectures could set
- or, a way of having architecture-specific versions of these vmalloc
  and module shadow memory allocation options.

Also note that, while UML supports both KASAN in inline mode
(CONFIG_KASAN_INLINE) and static linking (CONFIG_STATIC_LINK), it does
not support both at the same time.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Co-developed-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
This is v3 of the KASAN/UML port. It should be ready to go.

Note that this will fail to build if UML is linked statically due to:
https://lore.kernel.org/all/20220526185402.955870-1-davidgow@google.com/


Changes since v2:
https://lore.kernel.org/lkml/20220527185600.1236769-2-davidgow@google.com/
- Don't define CONFIG_KASAN in USER_CFLAGS, given we dont' use it.
  (Thanks Johannes)
- Update patch descriptions and comments given we allocate shadow memory based
  on the size of the virtual address space, not the "physical" memory
  used by UML.
  - This was changed between the original RFC and v1, with
    KASAN_SHADOW_SIZE's definition being updated.
  - References to UML using 18TB of space and the shadow memory taking
    2.25TB were updated. (Thanks Johannes)
  - A mention of physical memory in a comment was updated. (Thanks
    Andrey)
- Move some discussion of how the vmalloc() handling could be made more
  generic from a comment to the commit description. (Thanks Andrey)

Changes since RFC v3:
https://lore.kernel.org/all/20220526010111.755166-1-davidgow@google.com/
- No longer print "KernelAddressSanitizer initialized" (Johannes)
- Document the reason for the CONFIG_UML checks in shadow.c (Dmitry)
- Support static builds via kasan_arch_is_ready() (Dmitry)
- Get rid of a redundant call to kasam_mem_to_shadow() (Dmitry)
- Use PAGE_ALIGN and the new PAGE_ALIGN_DOWN macros (Dmitry)
- Reinstate missing arch/um/include/asm/kasan.h file (Johannes)

Changes since v1:
https://lore.kernel.org/all/20200226004608.8128-1-trishalfonso@google.com/
- Include several fixes from Vincent Whitchurch:
https://lore.kernel.org/all/20220525111756.GA15955@axis.com/
- Support for KASAN_VMALLOC, by changing the way
  kasan_{populate,release}_vmalloc work to update existing shadow
  memory, rather than allocating anything new.
- A similar fix for modules' shadow memory.
- Support for KASAN_STACK
  - This requires the bugfix here:
https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
  - Plus a couple of files excluded from KASAN.
- Revert the default shadow offset to 0x100000000000
  - This was breaking when mem=1G for me, at least.
- A few minor fixes to linker sections and scripts.
  - I've added one to dyn.lds.S on top of the ones Vincent added.

---
 arch/um/Kconfig                  | 15 +++++++++++++
 arch/um/include/asm/common.lds.S |  2 ++
 arch/um/include/asm/kasan.h      | 37 ++++++++++++++++++++++++++++++++
 arch/um/kernel/Makefile          |  3 +++
 arch/um/kernel/dyn.lds.S         |  6 +++++-
 arch/um/kernel/mem.c             | 19 ++++++++++++++++
 arch/um/os-Linux/mem.c           | 22 +++++++++++++++++++
 arch/um/os-Linux/user_syms.c     |  4 ++--
 arch/x86/um/Makefile             |  3 ++-
 arch/x86/um/vdso/Makefile        |  3 +++
 mm/kasan/shadow.c                | 29 +++++++++++++++++++++++--
 11 files changed, 137 insertions(+), 6 deletions(-)
 create mode 100644 arch/um/include/asm/kasan.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 8062a0c08952..289c9dc226d6 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -12,6 +12,8 @@ config UML
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_KASAN if X86_64
+	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_UID16
@@ -220,6 +222,19 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config KASAN_SHADOW_OFFSET
+	hex
+	depends on KASAN
+	default 0x100000000000
+	help
+	  This is the offset at which the ~16TB of shadow memory is
+	  mapped and used by KASAN for memory debugging. This can be any
+	  address that has at least KASAN_SHADOW_SIZE (total address space divided
+	  by 8) amount of space so that the KASAN shadow memory does not conflict
+	  with anything. The default is 0x100000000000, which works even if mem is
+	  set to a large value. On low-memory systems, try 0x7fff8000, as it fits
+	  into the immediate of most instructions, improving performance.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index eca6c452a41b..fd481ac371de 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -83,6 +83,8 @@
   }
   .init_array : {
 	__init_array_start = .;
+	*(.kasan_init)
+	*(.init_array.*)
 	*(.init_array)
 	__init_array_end = .;
   }
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
new file mode 100644
index 000000000000..0d6547f4ec85
--- /dev/null
+++ b/arch/um/include/asm/kasan.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_KASAN_H
+#define __ASM_UM_KASAN_H
+
+#include <linux/init.h>
+#include <linux/const.h>
+
+#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
+
+/* used in kasan_mem_to_shadow to divide by 8 */
+#define KASAN_SHADOW_SCALE_SHIFT 3
+
+#ifdef CONFIG_X86_64
+#define KASAN_HOST_USER_SPACE_END_ADDR 0x00007fffffffffffUL
+/* KASAN_SHADOW_SIZE is the size of total address space divided by 8 */
+#define KASAN_SHADOW_SIZE ((KASAN_HOST_USER_SPACE_END_ADDR + 1) >> \
+			KASAN_SHADOW_SCALE_SHIFT)
+#else
+#error "KASAN_SHADOW_SIZE is not defined for this sub-architecture"
+#endif /* CONFIG_X86_64 */
+
+#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
+#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
+
+#ifdef CONFIG_KASAN
+void kasan_init(void);
+void kasan_map_memory(void *start, unsigned long len);
+extern int kasan_um_is_ready;
+
+#ifdef CONFIG_STATIC_LINK
+#define kasan_arch_is_ready() (kasan_um_is_ready)
+#endif
+#else
+static inline void kasan_init(void) { }
+#endif /* CONFIG_KASAN */
+
+#endif /* __ASM_UM_KASAN_H */
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 1c2d4b29a3d4..a089217e2f0e 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
 
+KASAN_SANITIZE_stacktrace.o := n
+KASAN_SANITIZE_sysrq.o := n
+
 USER_OBJS := config.o
 
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index 2f2a8ce92f1e..2b7fc5b54164 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -109,7 +109,11 @@ SECTIONS
      be empty, which isn't pretty.  */
   . = ALIGN(32 / 8);
   .preinit_array     : { *(.preinit_array) }
-  .init_array     : { *(.init_array) }
+  .init_array     : {
+    *(.kasan_init)
+    *(.init_array.*)
+    *(.init_array)
+  }
   .fini_array     : { *(.fini_array) }
   .data           : {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 15295c3237a0..276a1f0b91f1 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -18,6 +18,25 @@
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <linux/sched/task.h>
+
+#ifdef CONFIG_KASAN
+int kasan_um_is_ready;
+void kasan_init(void)
+{
+	/*
+	 * kasan_map_memory will map all of the required address space and
+	 * the host machine will allocate physical memory as necessary.
+	 */
+	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
+	init_task.kasan_depth = 0;
+	kasan_um_is_ready = true;
+}
+
+static void (*kasan_init_ptr)(void)
+__section(".kasan_init") __used
+= kasan_init;
+#endif
 
 /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
 unsigned long *empty_zero_page = NULL;
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 3c1b77474d2d..8530b2e08604 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -17,6 +17,28 @@
 #include <init.h>
 #include <os.h>
 
+/*
+ * kasan_map_memory - maps memory from @start with a size of @len.
+ * The allocated memory is filled with zeroes upon success.
+ * @start: the start address of the memory to be mapped
+ * @len: the length of the memory to be mapped
+ *
+ * This function is used to map shadow memory for KASAN in uml
+ */
+void kasan_map_memory(void *start, size_t len)
+{
+	if (mmap(start,
+		 len,
+		 PROT_READ|PROT_WRITE,
+		 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
+		 -1,
+		 0) == MAP_FAILED) {
+		os_info("Couldn't allocate shadow memory: %s\n.",
+			strerror(errno));
+		exit(1);
+	}
+}
+
 /* Set by make_tempfile() during early boot. */
 static char *tempdir = NULL;
 
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 715594fe5719..cb667c9225ab 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
 #ifndef __x86_64__
 extern void *memcpy(void *, const void *, size_t);
 EXPORT_SYMBOL(memcpy);
-#endif
-
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
+#endif
+
 EXPORT_SYMBOL(printf);
 
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ba5789c35809..f778e37494ba 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -28,7 +28,8 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
+	../lib/memmove_64.o ../lib/memset_64.o
 
 endif
 
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 5943387e3f35..8c0396fd0e6f 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,6 +3,9 @@
 # Building vDSO images for x86.
 #
 
+# do not instrument on vdso because KASAN is not compatible with user mode
+KASAN_SANITIZE			:= n
+
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT                := n
 
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index a4f07de21771..7a7fc76e99a8 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -295,9 +295,22 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 		return 0;
 
 	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
-	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
 	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
-	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
+
+	/*
+	 * User Mode Linux maps enough shadow memory for all of virtual memory
+	 * at boot, so doesn't need to allocate more on vmalloc, just clear it.
+	 *
+         * The remaining CONFIG_UML checks in this file exist for the same
+         * reason.
+	 */
+	if (IS_ENABLED(CONFIG_UML)) {
+		__memset((void *)shadow_start, KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
+		return 0;
+	}
+
+	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
+	shadow_end = PAGE_ALIGN(shadow_end);
 
 	ret = apply_to_page_range(&init_mm, shadow_start,
 				  shadow_end - shadow_start,
@@ -466,6 +479,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 
 	if (shadow_end > shadow_start) {
 		size = shadow_end - shadow_start;
+		if (IS_ENABLED(CONFIG_UML)) {
+			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
+			return;
+		}
 		apply_to_existing_page_range(&init_mm,
 					     (unsigned long)shadow_start,
 					     size, kasan_depopulate_vmalloc_pte,
@@ -531,6 +548,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
 		return -EINVAL;
 
+	if (IS_ENABLED(CONFIG_UML)) {
+		__memset((void *)shadow_start, KASAN_SHADOW_INIT, shadow_size);
+		return 0;
+	}
+
 	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
 			shadow_start + shadow_size,
 			GFP_KERNEL,
@@ -554,6 +576,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 
 void kasan_free_module_shadow(const struct vm_struct *vm)
 {
+	if (IS_ENABLED(CONFIG_UML))
+		return;
+
 	if (vm->flags & VM_KASAN)
 		vfree(kasan_mem_to_shadow(vm->addr));
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

