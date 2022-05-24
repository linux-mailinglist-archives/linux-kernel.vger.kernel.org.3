Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFC5327B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbiEXKef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEXKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:34:32 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E9D6EC71
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1653388471;
  x=1684924471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTO9KlSLvwJ5fB+7S3O+zA2j/+7fp0U+77neSmOoPwU=;
  b=T3EZslUqH0c1V09MbEht8LXAPbIDIrVwRokQ5O6qA8W7L54nQo2q8wqR
   fmyV+YYa19oxxl7xmRm1bd2hYc4G3KXaMwJxcarEWG/bsp1TtaozPNTEY
   R+f/pSZ1T1a9x0XIZ64qFN4LLliPhZF+s4ZWTlsPyMLxyspzVqIk5P4WV
   Q8A5NWtWuJBzaVuMM5rmYy7q8R7xhlZ8ARRwXoxRHbNoSXcgLNHLbZJbY
   RM6X9Mk41flu6q16ulE+3yhSGlksxtAPSjto+aXkTdf5ZXAcFIzRLCHk+
   L4piO17CAqBegCWIjN4cJc9nB2TfaYmQHbtOgHDZ+5eH6D+tDY5k3NW3y
   A==;
Date:   Tue, 24 May 2022 12:34:28 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-um@lists.infradead.org>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
Message-ID: <20220524103423.GA13239@axis.com>
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 11:44:37PM +0100, Johannes Berg wrote:
> On Wed, 2020-03-11 at 15:32 -0700, Patricia Alfonso wrote:
> > I'll need some time to investigate these all myself. Having just
> > gotten my first module to run about an hour ago, any more information
> > about how you got these errors would be helpful so I can try to
> > reproduce them on my own.
> 
> See the other emails, I was basically just loading random modules. In my
> case cfg80211, mac80211, mac80211-hwsim - those are definitely available
> without any (virtio) hardware requirements, so you could use them.
> 
> Note that doing a bunch of vmalloc would likely result in similar
> issues, since the module and vmalloc space is the same on UML.

Old thread, but I had a look at this the other day and I think I got it
working.  Since the entire shadow area is mapped at init, we don't need
to do any mappings later.

It works both with and without KASAN_VMALLOC.  KASAN_STACK works too
after I disabled sanitization of the stacktrace code.  All kasan kunit
tests pass and the test_kasan.ko module works too.

Delta patch against Patricia's is below.  The CONFIG_UML checks need to
be replaced with something more appropriate (new config? __weak
functions?) and the free functions should probably be hooked up to
madvise(MADV_DONTNEED) so we discard unused pages in the shadow mapping.

Note that there's a KASAN stack-out-of-bounds splat on startup when just
booting UML.  That looks like a real (17-year-old) bug, I've posted a
fix for that:

 https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/

8<-----------
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index a1bd8c07ce14..5f3a4d25d57e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -12,6 +12,7 @@ config UML
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
+	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_UID16
@@ -223,7 +224,7 @@ config UML_TIME_TRAVEL_SUPPORT
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN
-	default 0x7fff8000
+	default 0x100000000000
 	help
 	  This is the offset at which the ~2.25TB of shadow memory is
 	  mapped and used by KASAN for memory debugging. This can be any
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
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 7c3196c297f7..a32cfce53efb 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -33,7 +33,7 @@ void kasan_init(void)
 }
 
 static void (*kasan_init_ptr)(void)
-__section(.kasan_init) __used
+__section(".kasan_init") __used
 = kasan_init;
 #endif
 
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 1113cf5fea25..1f3e620188a2 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -152,7 +152,7 @@ config KASAN_STACK
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	depends on !ARCH_DISABLE_KASAN_INLINE
-	default y if CC_IS_GCC && !UML
+	default y if CC_IS_GCC
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index a4f07de21771..d8c518bd0e7d 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -295,8 +295,14 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 		return 0;
 
 	shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
-	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
 	shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
+
+	if (IS_ENABLED(CONFIG_UML)) {
+		__memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
+		return 0;
+	}
+
+	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
 	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
 
 	ret = apply_to_page_range(&init_mm, shadow_start,
@@ -466,6 +472,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 
 	if (shadow_end > shadow_start) {
 		size = shadow_end - shadow_start;
+		if (IS_ENABLED(CONFIG_UML)) {
+			__memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
+			return;
+		}
 		apply_to_existing_page_range(&init_mm,
 					     (unsigned long)shadow_start,
 					     size, kasan_depopulate_vmalloc_pte,
@@ -531,6 +541,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
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
@@ -554,6 +569,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 
 void kasan_free_module_shadow(const struct vm_struct *vm)
 {
+	if (IS_ENABLED(CONFIG_UML))
+		return;
+
 	if (vm->flags & VM_KASAN)
 		vfree(kasan_mem_to_shadow(vm->addr));
 }
