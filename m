Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611D4C4C33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbiBYReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiBYReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:34:21 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C63139116
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:33:48 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t14so2302547pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toTbBOD7f2PmkGndW1qkGlCEgn4CdobY5uDy/cy5NAE=;
        b=nTpTtZ6GqoykxQez7jGzNazzVSEjA3hRmzuOvp6Rm6lcvWFnPk6YwpyLQqOaOfM/an
         2Ect1WyMljS2tvmmaSi0oxVPSx80Xdn3/OEr91JN9sylaMKUr3mFDVCuc0SIxyiw4745
         lX272c7+sctHq1QXAmnTmU8nsl3/69Ve8ATaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toTbBOD7f2PmkGndW1qkGlCEgn4CdobY5uDy/cy5NAE=;
        b=T4+LhBhecLeB0FlBp3NBI1q3xVN/pijdtArwY08s/yEC5CwfgUxuzp0q1uXZc2VrCT
         XQe1Fo5dNaE4xfRbmtG64UqIJlkp4hBpJ4/BeF+2RfGV54tLgVK7wI/YanziM2E8UBsc
         DsGSWBmzvv/nkTwm9RHvk3WcPsSmlqmwS6jWWotgn1wpKp2s5WKPRdRadtinfcFPWQkO
         Kgb2DsvVPz589o4+poDCj8NYl+UavPV76YGY9teoipC7bBBJl6D6HqK1HHgVRgkNpK2H
         gKjWLxI9hTkMMbkMEpPf3gqIiRLruIh/YzBvGrj+/Nk1zBI3A7DMKXzOanqrb6qfTkds
         UWTA==
X-Gm-Message-State: AOAM5327qPPQ+HzLW4VIpVjmh/ZQHoc19/lmELUUoPm98spXVA+Wt5vk
        +sdRlC/lOhJjVtM6L9wA3Bpyhw==
X-Google-Smtp-Source: ABdhPJzgY2gr9dyjYiVhYPibWI6tyQMGRgFvIgbCjGZmflYsg9KFVd1wpHVozFe0C4B5LIKLvbR2Pg==
X-Received: by 2002:a63:d1e:0:b0:372:c1cd:9e16 with SMTP id c30-20020a630d1e000000b00372c1cd9e16mr6917970pgl.421.1645810428205;
        Fri, 25 Feb 2022 09:33:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d32-20020a631d60000000b003650a9d8f9asm3188379pgm.33.2022.02.25.09.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:33:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] usercopy: Check valid lifetime via stack depth
Date:   Fri, 25 Feb 2022 09:33:45 -0800
Message-Id: <20220225173345.3358109-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6650; h=from:subject; bh=cBT9LfVn4HmKRYh2PcXE/8zQz02Mqq30WHMb1xRpsC8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiGRL4hCGRtyMVNaUuGOXYOQcJfOPMdMFCLw6RqyF4 bSK+p6CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhkS+AAKCRCJcvTf3G3AJgiXD/ 9oJAEUhwjjt38fSq/6oFUuGmXix51DHDuPiCQ/O+vtMyBt7Pika1A2AA7aICzbV+JrhaJovM25jLOs ec+SE2h408yHdgsZJTjqhhbUcqZJsVoYWQ6CekV7ZUpqVznkapWGjsiuAeUwpf080muqYbkCUizVD5 d8a+rdIbQiu6x2v102k55/DBqUWPhKQPA31tR9giHixwsTGTIqULFf+cQP4Yn68bmDFGBfiVf6h1Iu KmAvII7sF+CqSPWMG4ITorgRlp4x+dhbQ/QddX9VAdfHQwf/5IgNqYZtAkgSv4+xWwnyWdrcLWQBwK bWwCfcDxRa3vVRqHF6NIPKZ41wzZM6H54opS11bDEp3Kbpdx9Uw0GHjSsmVHJPK9tOVsREZS8KVa31 MjZori9jAT4lqcojRrcaXKaQdTfS3hhA+MJrrOSqmjmFULHKe1NIS1I9xWtpqEstr6+EJ+aKDAy4D3 aH1unqUg4B4lDNeJPZJijllFqLhgRLjjeyj9WWP5O1GIOyk7pKkabuZMVcWVESXE+ApTltYk1Xu86X ewfw6nwTVWYzlj7otcUTknrHPj39m+T9bDQuuf11GiLEk84C2D+ch4tWKKrrvXLfm795vwqc45FA8o hXXNk6rWAdmCmwF9ty1CmJYsXfesFaBYSAS5SWfZTjPYpKV/GTu/8RasyJDQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
is not available (i.e. everything except x86 with FRAME_POINTER), check
a stack object as being at least "current depth valid", in the sense
that any object within the stack region but not between start-of-stack
and current_stack_pointer should be considered unavailable (i.e. its
lifetime is from a call no longer present on the stack).

Introduce ARCH_HAS_CURRENT_STACK_POINTER to track which architectures
have actually implemented the common global register alias.

Additionally report usercopy bounds checking failures with an offset
from current_stack_pointer, which may assist with diagnosing failures.

The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
(once slightly adjusted in a separate patch) will pass again with
this fixed.

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220216201449.2087956-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220224060342.1855457-1-keescook@chromium.org
v3:
 - simplify bounds check (David)
 - add missed Kconfig declaration
---
 arch/arm/Kconfig     |  1 +
 arch/arm64/Kconfig   |  1 +
 arch/powerpc/Kconfig |  1 +
 arch/s390/Kconfig    |  1 +
 arch/sh/Kconfig      |  1 +
 arch/x86/Kconfig     |  1 +
 mm/Kconfig           |  9 +++++++++
 mm/usercopy.c        | 23 +++++++++++++++++++++--
 8 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c97cb40eebb..a7a09eef1852 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
 	select ARCH_HAS_ELF_RANDOMIZE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index f2b5a4abef21..b8ab790555c8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -18,6 +18,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b779603978e1..7e7387bd7d53 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -108,6 +108,7 @@ config PPC
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX		if STRICT_KERNEL_RWX
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index be9f39fd06df..4845ab549dd1 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -60,6 +60,7 @@ config S390
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 2474a04ceac4..1c2b53bf3093 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -7,6 +7,7 @@ config SUPERH
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..90494fba3620 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -69,6 +69,7 @@ config X86
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..c349599601f8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -744,6 +744,15 @@ config IDLE_PAGE_TRACKING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
+config ARCH_HAS_CURRENT_STACK_POINTER
+	bool
+	help
+	  In support of HARDENED_USERCOPY performing stack variable lifetime
+	  checking, an architecture-agnostic way to find the stack pointer
+	  is needed. Once an architecture defines an unsigned long global
+	  register alias named "current_stack_pointer", this config can be
+	  selected.
+
 config ARCH_HAS_PTE_DEVMAP
 	bool
 
diff --git a/mm/usercopy.c b/mm/usercopy.c
index d0d268135d96..5d34c40c16c2 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -29,7 +29,7 @@
  * Returns:
  *	NOT_STACK: not at all on the stack
  *	GOOD_FRAME: fully within a valid stack frame
- *	GOOD_STACK: fully on the stack (when can't do frame-checking)
+ *	GOOD_STACK: within the current stack (when can't frame-check exactly)
  *	BAD_STACK: error condition (invalid stack position or bad stack frame)
  */
 static noinline int check_stack_object(const void *obj, unsigned long len)
@@ -55,6 +55,17 @@ static noinline int check_stack_object(const void *obj, unsigned long len)
 	if (ret)
 		return ret;
 
+	/* Finally, check stack depth if possible. */
+#ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
+	if (IS_ENABLED(CONFIG_STACK_GROWSUP)) {
+		if ((void *)current_stack_pointer < obj + len)
+			return BAD_STACK;
+	} else {
+		if (obj < (void *)current_stack_pointer)
+			return BAD_STACK;
+	}
+#endif
+
 	return GOOD_STACK;
 }
 
@@ -280,7 +291,15 @@ void __check_object_size(const void *ptr, unsigned long n, bool to_user)
 		 */
 		return;
 	default:
-		usercopy_abort("process stack", NULL, to_user, 0, n);
+		usercopy_abort("process stack", NULL, to_user,
+#ifdef CONFIG_ARCH_HAS_CURRENT_STACK_POINTER
+			IS_ENABLED(CONFIG_STACK_GROWSUP) ?
+				ptr - (void *)current_stack_pointer :
+				(void *)current_stack_pointer - ptr,
+#else
+			0,
+#endif
+			n);
 	}
 
 	/* Check for bad heap object. */
-- 
2.30.2

