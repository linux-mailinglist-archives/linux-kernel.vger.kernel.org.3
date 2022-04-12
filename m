Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293E4FEAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiDLXlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiDLXk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:40:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796AA27F0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:22:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so4561043pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Q8lLev6N12MvRZQeJIVjHKCYHiMNXXO00KaDZ37Jj0=;
        b=VE8ZrZBlAIUKtnYnjghBydboro8hA++0wK/OOZa/t/N0RfqUQKv5DrCKZ/S2wZbfwy
         Obmk8AjvD6LBFnu0RrdOdjXOblcfEqfjydTpuANIsFErq6SgxC7Jc+SqwmS7+3M7XRpB
         /qYM3kCrn6bIbYpHC8vNpu2pYU144KtnieESM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Q8lLev6N12MvRZQeJIVjHKCYHiMNXXO00KaDZ37Jj0=;
        b=wzUk5NiKH9G4GL2Dw6DRDqMqKsQ64C+TdLPuC8tmQatwX/0piW3xTDWof0a8pzWTkQ
         TpupFu77iJ/fWUqLJPDfMNQVeaLlAudE/r85MOW6uRUDxl/U/pbfH1VTalJZatw6uts9
         U2yXtgMMyqRLZDq+/LPd0qgCH0y94EtLYXdMo0YSq96lqzB7bRigARuSdpZieBN2Nfor
         9dvKfmWMXLmyElgrmlA2eiRVnkWE76Ylzo0JkNciHIIwOfwC8uAnaVSrXQQsCdIn5RuN
         5cXD1PffpzhWoTDy2VBmzJerACOiu2H+o7O7f0HEpcCNIHZFcjSJt7BjPqGQ8YieS7Z5
         HUAw==
X-Gm-Message-State: AOAM530udmFlSqpbOKhVKVEKc89txT7wzjadSAorJ/vB3KwozvO2aPO1
        DBvy07KMKU0wPBfWGVyg7Wt/Cw==
X-Google-Smtp-Source: ABdhPJxwi/Sk/DhfApb4UX8/Ij1YPg8ZOzcHvFlUE1zRjUu9VsToH9IHcKcECLjYhisX7PXtQ5vhug==
X-Received: by 2002:a17:902:a510:b0:156:6cf9:9a7c with SMTP id s16-20020a170902a51000b001566cf99a7cmr40612543plq.151.1649805749905;
        Tue, 12 Apr 2022 16:22:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090a591700b001ca00b46cf9sm590435pji.18.2022.04.12.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 16:22:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] lkdtm: Move crashtype definitions into each category
Date:   Tue, 12 Apr 2022 16:22:26 -0700
Message-Id: <20220412232226.4014907-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38166; h=from:subject; bh=yGdicch7Q/qrxSOSlKzuxu0Hp/93j8O5lc9Pi6fzTzU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiVgmyZAKvFf7Fy8RRPGXfpmQoXsps77aQjlPDVBEW 2WaBf7eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYlYJsgAKCRCJcvTf3G3AJtFZD/ 9NIEde1y4gdFApbhs1Bn687AyXUsAHnDhfA1HcQ4pgCY/BAxO88+T7vL0+ako9TDrH38XyVrhrK9mW P1pBbkwXhztNwqqsjLJ9ly8r70ts6z6Y7+o9t+xft/bMWX4p7cdy8DSicOkq3V5xv0JBuHIyDv5pPP HN7t5ykA5z6IUYokl+bM7eH0nsWK/oDOQ7AVAgcwZG4FG82CmX2WObkg6tjDfpfZ/f7Hbuis0hS20I x2VknbhTG4M1J1h50Zd8i6is0JTqZj0AjXlXTiUWU2M1e9yZYHvQMNRC0GR91HckL+kdvMsAEiJ2ZQ 199fRmDnHVD3lQcM9ApAKGsyXl1iwiQgOJz5Yj8HlXASJ+IcPtgi697NKeoqMt3PqPIUN7+xSIfD4o IagQBXWR9RRnEwnPYTkyWPNb8ADjrnFcXnYS7QBLZD6aYYITlj49Ge783pBnSSZ90TXcCsJ9ROqNFG KA9oV4C8EwdUVW/F+rxY1MjQmMwfE12J6lCNGVSOHhJfHXpFF6hO59zvkY3cC6RxzY/jL1R05cyMSy S8jFCeFo/lc3TdGUx/my0DLFK+0+aW+n0XgQ7locR64n6pn1ffmYv0sScgUeZzTLZ1uWuHsNSda0AZ 19acYhfbxiBoA9XWk54flbpArPOJUI4e//+NaAyVfB26EW8KY1/TQQqtvmkw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's long been annoying that to add a new LKDTM test one had to update
lkdtm.h and core.c to get it "registered". Switch to a per-category
list and update the crashtype walking code in core.c to handle it.

This also means that all the lkdtm_* tests themselves can be static now.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Greg, please don't take this yet, it depends on the rest of my lkdtm
series that I'll send you a -next pull request for soon.
---
 drivers/misc/lkdtm/bugs.c      |  86 +++++++++++++-------
 drivers/misc/lkdtm/cfi.c       |  11 ++-
 drivers/misc/lkdtm/core.c      | 138 ++++++++-------------------------
 drivers/misc/lkdtm/fortify.c   |  17 +++-
 drivers/misc/lkdtm/heap.c      |  41 +++++++---
 drivers/misc/lkdtm/lkdtm.h     | 134 ++++++++------------------------
 drivers/misc/lkdtm/perms.c     |  47 +++++++----
 drivers/misc/lkdtm/powerpc.c   |  11 ++-
 drivers/misc/lkdtm/refcount.c  |  65 +++++++++++-----
 drivers/misc/lkdtm/stackleak.c |  11 ++-
 drivers/misc/lkdtm/usercopy.c  |  32 ++++++--
 11 files changed, 301 insertions(+), 292 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 8cb342c562af..009239ad1d8a 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -68,40 +68,40 @@ void __init lkdtm_bugs_init(int *recur_param)
 		recur_count = *recur_param;
 }
 
-void lkdtm_PANIC(void)
+static void lkdtm_PANIC(void)
 {
 	panic("dumptest");
 }
 
-void lkdtm_BUG(void)
+static void lkdtm_BUG(void)
 {
 	BUG();
 }
 
 static int warn_counter;
 
-void lkdtm_WARNING(void)
+static void lkdtm_WARNING(void)
 {
 	WARN_ON(++warn_counter);
 }
 
-void lkdtm_WARNING_MESSAGE(void)
+static void lkdtm_WARNING_MESSAGE(void)
 {
 	WARN(1, "Warning message trigger count: %d\n", ++warn_counter);
 }
 
-void lkdtm_EXCEPTION(void)
+static void lkdtm_EXCEPTION(void)
 {
 	*((volatile int *) 0) = 0;
 }
 
-void lkdtm_LOOP(void)
+static void lkdtm_LOOP(void)
 {
 	for (;;)
 		;
 }
 
-void lkdtm_EXHAUST_STACK(void)
+static void lkdtm_EXHAUST_STACK(void)
 {
 	pr_info("Calling function with %lu frame size to depth %d ...\n",
 		REC_STACK_SIZE, recur_count);
@@ -115,7 +115,7 @@ static noinline void __lkdtm_CORRUPT_STACK(void *stack)
 }
 
 /* This should trip the stack canary, not corrupt the return address. */
-noinline void lkdtm_CORRUPT_STACK(void)
+static noinline void lkdtm_CORRUPT_STACK(void)
 {
 	/* Use default char array length that triggers stack protection. */
 	char data[8] __aligned(sizeof(void *));
@@ -125,7 +125,7 @@ noinline void lkdtm_CORRUPT_STACK(void)
 }
 
 /* Same as above but will only get a canary with -fstack-protector-strong */
-noinline void lkdtm_CORRUPT_STACK_STRONG(void)
+static noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 {
 	union {
 		unsigned short shorts[4];
@@ -139,7 +139,7 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 static pid_t stack_pid;
 static unsigned long stack_addr;
 
-void lkdtm_REPORT_STACK(void)
+static void lkdtm_REPORT_STACK(void)
 {
 	volatile uintptr_t magic;
 	pid_t pid = task_pid_nr(current);
@@ -222,7 +222,7 @@ static noinline void __lkdtm_REPORT_STACK_CANARY(void *stack)
 	}
 }
 
-void lkdtm_REPORT_STACK_CANARY(void)
+static void lkdtm_REPORT_STACK_CANARY(void)
 {
 	/* Use default char array length that triggers stack protection. */
 	char data[8] __aligned(sizeof(void *)) = { };
@@ -230,7 +230,7 @@ void lkdtm_REPORT_STACK_CANARY(void)
 	__lkdtm_REPORT_STACK_CANARY((void *)&data);
 }
 
-void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
+static void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
 	u32 *p;
@@ -245,21 +245,21 @@ void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 		pr_err("XFAIL: arch has CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS\n");
 }
 
-void lkdtm_SOFTLOCKUP(void)
+static void lkdtm_SOFTLOCKUP(void)
 {
 	preempt_disable();
 	for (;;)
 		cpu_relax();
 }
 
-void lkdtm_HARDLOCKUP(void)
+static void lkdtm_HARDLOCKUP(void)
 {
 	local_irq_disable();
 	for (;;)
 		cpu_relax();
 }
 
-void lkdtm_SPINLOCKUP(void)
+static void lkdtm_SPINLOCKUP(void)
 {
 	/* Must be called twice to trigger. */
 	spin_lock(&lock_me_up);
@@ -267,7 +267,7 @@ void lkdtm_SPINLOCKUP(void)
 	__release(&lock_me_up);
 }
 
-void lkdtm_HUNG_TASK(void)
+static void lkdtm_HUNG_TASK(void)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule();
@@ -276,7 +276,7 @@ void lkdtm_HUNG_TASK(void)
 volatile unsigned int huge = INT_MAX - 2;
 volatile unsigned int ignored;
 
-void lkdtm_OVERFLOW_SIGNED(void)
+static void lkdtm_OVERFLOW_SIGNED(void)
 {
 	int value;
 
@@ -291,7 +291,7 @@ void lkdtm_OVERFLOW_SIGNED(void)
 }
 
 
-void lkdtm_OVERFLOW_UNSIGNED(void)
+static void lkdtm_OVERFLOW_UNSIGNED(void)
 {
 	unsigned int value;
 
@@ -319,7 +319,7 @@ struct array_bounds {
 	int three;
 };
 
-void lkdtm_ARRAY_BOUNDS(void)
+static void lkdtm_ARRAY_BOUNDS(void)
 {
 	struct array_bounds_flex_array *not_checked;
 	struct array_bounds *checked;
@@ -357,7 +357,7 @@ void lkdtm_ARRAY_BOUNDS(void)
 		pr_expected_config(CONFIG_UBSAN_BOUNDS);
 }
 
-void lkdtm_CORRUPT_LIST_ADD(void)
+static void lkdtm_CORRUPT_LIST_ADD(void)
 {
 	/*
 	 * Initially, an empty list via LIST_HEAD:
@@ -397,7 +397,7 @@ void lkdtm_CORRUPT_LIST_ADD(void)
 	}
 }
 
-void lkdtm_CORRUPT_LIST_DEL(void)
+static void lkdtm_CORRUPT_LIST_DEL(void)
 {
 	LIST_HEAD(test_head);
 	struct lkdtm_list item;
@@ -425,7 +425,7 @@ void lkdtm_CORRUPT_LIST_DEL(void)
 }
 
 /* Test that VMAP_STACK is actually allocating with a leading guard page */
-void lkdtm_STACK_GUARD_PAGE_LEADING(void)
+static void lkdtm_STACK_GUARD_PAGE_LEADING(void)
 {
 	const unsigned char *stack = task_stack_page(current);
 	const unsigned char *ptr = stack - 1;
@@ -439,7 +439,7 @@ void lkdtm_STACK_GUARD_PAGE_LEADING(void)
 }
 
 /* Test that VMAP_STACK is actually allocating with a trailing guard page */
-void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
+static void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 {
 	const unsigned char *stack = task_stack_page(current);
 	const unsigned char *ptr = stack + THREAD_SIZE;
@@ -452,7 +452,7 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 	pr_err("FAIL: accessed page after stack! (byte: %x)\n", byte);
 }
 
-void lkdtm_UNSET_SMEP(void)
+static void lkdtm_UNSET_SMEP(void)
 {
 #if IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_UML)
 #define MOV_CR4_DEPTH	64
@@ -518,7 +518,7 @@ void lkdtm_UNSET_SMEP(void)
 #endif
 }
 
-void lkdtm_DOUBLE_FAULT(void)
+static void lkdtm_DOUBLE_FAULT(void)
 {
 #if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
 	/*
@@ -566,7 +566,7 @@ static noinline void change_pac_parameters(void)
 }
 #endif
 
-noinline void lkdtm_CORRUPT_PAC(void)
+static noinline void lkdtm_CORRUPT_PAC(void)
 {
 #ifdef CONFIG_ARM64
 #define CORRUPT_PAC_ITERATE	10
@@ -594,3 +594,37 @@ noinline void lkdtm_CORRUPT_PAC(void)
 	pr_err("XFAIL: this test is arm64-only\n");
 #endif
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(PANIC),
+	CRASHTYPE(BUG),
+	CRASHTYPE(WARNING),
+	CRASHTYPE(WARNING_MESSAGE),
+	CRASHTYPE(EXCEPTION),
+	CRASHTYPE(LOOP),
+	CRASHTYPE(EXHAUST_STACK),
+	CRASHTYPE(CORRUPT_STACK),
+	CRASHTYPE(CORRUPT_STACK_STRONG),
+	CRASHTYPE(REPORT_STACK),
+	CRASHTYPE(REPORT_STACK_CANARY),
+	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
+	CRASHTYPE(SOFTLOCKUP),
+	CRASHTYPE(HARDLOCKUP),
+	CRASHTYPE(SPINLOCKUP),
+	CRASHTYPE(HUNG_TASK),
+	CRASHTYPE(OVERFLOW_SIGNED),
+	CRASHTYPE(OVERFLOW_UNSIGNED),
+	CRASHTYPE(ARRAY_BOUNDS),
+	CRASHTYPE(CORRUPT_LIST_ADD),
+	CRASHTYPE(CORRUPT_LIST_DEL),
+	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
+	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
+	CRASHTYPE(UNSET_SMEP),
+	CRASHTYPE(DOUBLE_FAULT),
+	CRASHTYPE(CORRUPT_PAC),
+};
+
+struct crashtype_category bugs_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index c9aeddef1044..e88f778be0d5 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -22,7 +22,7 @@ static noinline int lkdtm_increment_int(int *counter)
 /*
  * This tries to call an indirect function with a mismatched prototype.
  */
-void lkdtm_CFI_FORWARD_PROTO(void)
+static void lkdtm_CFI_FORWARD_PROTO(void)
 {
 	/*
 	 * Matches lkdtm_increment_void()'s prototype, but not
@@ -41,3 +41,12 @@ void lkdtm_CFI_FORWARD_PROTO(void)
 	pr_err("FAIL: survived mismatched prototype function call!\n");
 	pr_expected_config(CONFIG_CFI_CLANG);
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(CFI_FORWARD_PROTO),
+};
+
+struct crashtype_category cfi_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index e2228b6fc09b..b4712ff196b4 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -86,109 +86,21 @@ static struct crashpoint crashpoints[] = {
 #endif
 };
 
-
-/* Crash types. */
-struct crashtype {
-	const char *name;
-	void (*func)(void);
-};
-
-#define CRASHTYPE(_name)			\
-	{					\
-		.name = __stringify(_name),	\
-		.func = lkdtm_ ## _name,	\
-	}
-
-/* Define the possible types of crashes that can be triggered. */
-static const struct crashtype crashtypes[] = {
-	CRASHTYPE(PANIC),
-	CRASHTYPE(BUG),
-	CRASHTYPE(WARNING),
-	CRASHTYPE(WARNING_MESSAGE),
-	CRASHTYPE(EXCEPTION),
-	CRASHTYPE(LOOP),
-	CRASHTYPE(EXHAUST_STACK),
-	CRASHTYPE(CORRUPT_STACK),
-	CRASHTYPE(CORRUPT_STACK_STRONG),
-	CRASHTYPE(REPORT_STACK),
-	CRASHTYPE(REPORT_STACK_CANARY),
-	CRASHTYPE(CORRUPT_LIST_ADD),
-	CRASHTYPE(CORRUPT_LIST_DEL),
-	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
-	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
-	CRASHTYPE(UNSET_SMEP),
-	CRASHTYPE(CORRUPT_PAC),
-	CRASHTYPE(UNALIGNED_LOAD_STORE_WRITE),
-	CRASHTYPE(SLAB_LINEAR_OVERFLOW),
-	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
-	CRASHTYPE(WRITE_AFTER_FREE),
-	CRASHTYPE(READ_AFTER_FREE),
-	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
-	CRASHTYPE(READ_BUDDY_AFTER_FREE),
-	CRASHTYPE(SLAB_INIT_ON_ALLOC),
-	CRASHTYPE(BUDDY_INIT_ON_ALLOC),
-	CRASHTYPE(SLAB_FREE_DOUBLE),
-	CRASHTYPE(SLAB_FREE_CROSS),
-	CRASHTYPE(SLAB_FREE_PAGE),
-	CRASHTYPE(SOFTLOCKUP),
-	CRASHTYPE(HARDLOCKUP),
-	CRASHTYPE(SPINLOCKUP),
-	CRASHTYPE(HUNG_TASK),
-	CRASHTYPE(OVERFLOW_SIGNED),
-	CRASHTYPE(OVERFLOW_UNSIGNED),
-	CRASHTYPE(ARRAY_BOUNDS),
-	CRASHTYPE(EXEC_DATA),
-	CRASHTYPE(EXEC_STACK),
-	CRASHTYPE(EXEC_KMALLOC),
-	CRASHTYPE(EXEC_VMALLOC),
-	CRASHTYPE(EXEC_RODATA),
-	CRASHTYPE(EXEC_USERSPACE),
-	CRASHTYPE(EXEC_NULL),
-	CRASHTYPE(ACCESS_USERSPACE),
-	CRASHTYPE(ACCESS_NULL),
-	CRASHTYPE(WRITE_RO),
-	CRASHTYPE(WRITE_RO_AFTER_INIT),
-	CRASHTYPE(WRITE_KERN),
-	CRASHTYPE(WRITE_OPD),
-	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
-	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
-	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_OVERFLOW),
-	CRASHTYPE(REFCOUNT_ADD_NOT_ZERO_OVERFLOW),
-	CRASHTYPE(REFCOUNT_DEC_ZERO),
-	CRASHTYPE(REFCOUNT_DEC_NEGATIVE),
-	CRASHTYPE(REFCOUNT_DEC_AND_TEST_NEGATIVE),
-	CRASHTYPE(REFCOUNT_SUB_AND_TEST_NEGATIVE),
-	CRASHTYPE(REFCOUNT_INC_ZERO),
-	CRASHTYPE(REFCOUNT_ADD_ZERO),
-	CRASHTYPE(REFCOUNT_INC_SATURATED),
-	CRASHTYPE(REFCOUNT_DEC_SATURATED),
-	CRASHTYPE(REFCOUNT_ADD_SATURATED),
-	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_SATURATED),
-	CRASHTYPE(REFCOUNT_ADD_NOT_ZERO_SATURATED),
-	CRASHTYPE(REFCOUNT_DEC_AND_TEST_SATURATED),
-	CRASHTYPE(REFCOUNT_SUB_AND_TEST_SATURATED),
-	CRASHTYPE(REFCOUNT_TIMING),
-	CRASHTYPE(ATOMIC_TIMING),
-	CRASHTYPE(USERCOPY_HEAP_SIZE_TO),
-	CRASHTYPE(USERCOPY_HEAP_SIZE_FROM),
-	CRASHTYPE(USERCOPY_HEAP_WHITELIST_TO),
-	CRASHTYPE(USERCOPY_HEAP_WHITELIST_FROM),
-	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
-	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
-	CRASHTYPE(USERCOPY_STACK_BEYOND),
-	CRASHTYPE(USERCOPY_KERNEL),
-	CRASHTYPE(STACKLEAK_ERASING),
-	CRASHTYPE(CFI_FORWARD_PROTO),
-	CRASHTYPE(FORTIFIED_OBJECT),
-	CRASHTYPE(FORTIFIED_SUBOBJECT),
-	CRASHTYPE(FORTIFIED_STRSCPY),
-	CRASHTYPE(DOUBLE_FAULT),
+/* List of possible types for crashes that can be triggered. */
+static const struct crashtype_category *crashtype_categories[] = {
+	&bugs_crashtypes,
+	&heap_crashtypes,
+	&perms_crashtypes,
+	&refcount_crashtypes,
+	&usercopy_crashtypes,
+	&stackleak_crashtypes,
+	&cfi_crashtypes,
+	&fortify_crashtypes,
 #ifdef CONFIG_PPC_64S_HASH_MMU
-	CRASHTYPE(PPC_SLB_MULTIHIT),
+	&powerpc_crashtypes,
 #endif
 };
 
-
 /* Global kprobe entry and crashtype. */
 static struct kprobe *lkdtm_kprobe;
 static struct crashpoint *lkdtm_crashpoint;
@@ -223,11 +135,16 @@ char *lkdtm_kernel_info;
 /* Return the crashtype number or NULL if the name is invalid */
 static const struct crashtype *find_crashtype(const char *name)
 {
-	int i;
+	int cat, idx;
+
+	for (cat = 0; cat < ARRAY_SIZE(crashtype_categories); cat++) {
+		for (idx = 0; idx < crashtype_categories[cat]->len; idx++) {
+			struct crashtype *crashtype;
 
-	for (i = 0; i < ARRAY_SIZE(crashtypes); i++) {
-		if (!strcmp(name, crashtypes[i].name))
-			return &crashtypes[i];
+			crashtype = &crashtype_categories[cat]->crashtypes[idx];
+			if (!strcmp(name, crashtype->name))
+				return crashtype;
+		}
 	}
 
 	return NULL;
@@ -347,17 +264,24 @@ static ssize_t lkdtm_debugfs_entry(struct file *f,
 static ssize_t lkdtm_debugfs_read(struct file *f, char __user *user_buf,
 		size_t count, loff_t *off)
 {
+	int n, cat, idx;
+	ssize_t out;
 	char *buf;
-	int i, n, out;
 
 	buf = (char *)__get_free_page(GFP_KERNEL);
 	if (buf == NULL)
 		return -ENOMEM;
 
 	n = scnprintf(buf, PAGE_SIZE, "Available crash types:\n");
-	for (i = 0; i < ARRAY_SIZE(crashtypes); i++) {
-		n += scnprintf(buf + n, PAGE_SIZE - n, "%s\n",
-			      crashtypes[i].name);
+
+	for (cat = 0; cat < ARRAY_SIZE(crashtype_categories); cat++) {
+		for (idx = 0; idx < crashtype_categories[cat]->len; idx++) {
+			struct crashtype *crashtype;
+
+			crashtype = &crashtype_categories[cat]->crashtypes[idx];
+			n += scnprintf(buf + n, PAGE_SIZE - n, "%s\n",
+				      crashtype->name);
+		}
 	}
 	buf[n] = '\0';
 
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index ab33bb5e2e7a..080293fa3c52 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -10,7 +10,7 @@
 
 static volatile int fortify_scratch_space;
 
-void lkdtm_FORTIFIED_OBJECT(void)
+static void lkdtm_FORTIFIED_OBJECT(void)
 {
 	struct target {
 		char a[10];
@@ -31,7 +31,7 @@ void lkdtm_FORTIFIED_OBJECT(void)
 	pr_expected_config(CONFIG_FORTIFY_SOURCE);
 }
 
-void lkdtm_FORTIFIED_SUBOBJECT(void)
+static void lkdtm_FORTIFIED_SUBOBJECT(void)
 {
 	struct target {
 		char a[10];
@@ -67,7 +67,7 @@ void lkdtm_FORTIFIED_SUBOBJECT(void)
  * strscpy and generate a panic because there is a write overflow (i.e. src
  * length is greater than dst length).
  */
-void lkdtm_FORTIFIED_STRSCPY(void)
+static void lkdtm_FORTIFIED_STRSCPY(void)
 {
 	char *src;
 	char dst[5];
@@ -134,3 +134,14 @@ void lkdtm_FORTIFIED_STRSCPY(void)
 
 	kfree(src);
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(FORTIFIED_OBJECT),
+	CRASHTYPE(FORTIFIED_SUBOBJECT),
+	CRASHTYPE(FORTIFIED_STRSCPY),
+};
+
+struct crashtype_category fortify_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index b4ac726a548f..5d3b92cd23bd 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -26,7 +26,7 @@ static volatile int __offset = 1;
  * This should always be caught because there is an unconditional unmapped
  * page after vmap allocations.
  */
-void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
+static void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
 {
 	char *one, *two;
 
@@ -48,7 +48,7 @@ void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
  * This should get caught by either memory tagging, KASan, or by using
  * CONFIG_SLUB_DEBUG=y and slub_debug=ZF (or CONFIG_SLUB_DEBUG_ON=y).
  */
-void lkdtm_SLAB_LINEAR_OVERFLOW(void)
+static void lkdtm_SLAB_LINEAR_OVERFLOW(void)
 {
 	size_t len = 1020;
 	u32 *data = kmalloc(len, GFP_KERNEL);
@@ -60,7 +60,7 @@ void lkdtm_SLAB_LINEAR_OVERFLOW(void)
 	kfree(data);
 }
 
-void lkdtm_WRITE_AFTER_FREE(void)
+static void lkdtm_WRITE_AFTER_FREE(void)
 {
 	int *base, *again;
 	size_t len = 1024;
@@ -86,7 +86,7 @@ void lkdtm_WRITE_AFTER_FREE(void)
 		pr_info("Hmm, didn't get the same memory range.\n");
 }
 
-void lkdtm_READ_AFTER_FREE(void)
+static void lkdtm_READ_AFTER_FREE(void)
 {
 	int *base, *val, saw;
 	size_t len = 1024;
@@ -130,7 +130,7 @@ void lkdtm_READ_AFTER_FREE(void)
 	kfree(val);
 }
 
-void lkdtm_WRITE_BUDDY_AFTER_FREE(void)
+static void lkdtm_WRITE_BUDDY_AFTER_FREE(void)
 {
 	unsigned long p = __get_free_page(GFP_KERNEL);
 	if (!p) {
@@ -150,7 +150,7 @@ void lkdtm_WRITE_BUDDY_AFTER_FREE(void)
 	schedule();
 }
 
-void lkdtm_READ_BUDDY_AFTER_FREE(void)
+static void lkdtm_READ_BUDDY_AFTER_FREE(void)
 {
 	unsigned long p = __get_free_page(GFP_KERNEL);
 	int saw, *val;
@@ -187,7 +187,7 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void)
 	kfree(val);
 }
 
-void lkdtm_SLAB_INIT_ON_ALLOC(void)
+static void lkdtm_SLAB_INIT_ON_ALLOC(void)
 {
 	u8 *first;
 	u8 *val;
@@ -219,7 +219,7 @@ void lkdtm_SLAB_INIT_ON_ALLOC(void)
 	kfree(val);
 }
 
-void lkdtm_BUDDY_INIT_ON_ALLOC(void)
+static void lkdtm_BUDDY_INIT_ON_ALLOC(void)
 {
 	u8 *first;
 	u8 *val;
@@ -252,7 +252,7 @@ void lkdtm_BUDDY_INIT_ON_ALLOC(void)
 	free_page((unsigned long)val);
 }
 
-void lkdtm_SLAB_FREE_DOUBLE(void)
+static void lkdtm_SLAB_FREE_DOUBLE(void)
 {
 	int *val;
 
@@ -269,7 +269,7 @@ void lkdtm_SLAB_FREE_DOUBLE(void)
 	kmem_cache_free(double_free_cache, val);
 }
 
-void lkdtm_SLAB_FREE_CROSS(void)
+static void lkdtm_SLAB_FREE_CROSS(void)
 {
 	int *val;
 
@@ -285,7 +285,7 @@ void lkdtm_SLAB_FREE_CROSS(void)
 	kmem_cache_free(b_cache, val);
 }
 
-void lkdtm_SLAB_FREE_PAGE(void)
+static void lkdtm_SLAB_FREE_PAGE(void)
 {
 	unsigned long p = __get_free_page(GFP_KERNEL);
 
@@ -319,3 +319,22 @@ void __exit lkdtm_heap_exit(void)
 	kmem_cache_destroy(a_cache);
 	kmem_cache_destroy(b_cache);
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(SLAB_LINEAR_OVERFLOW),
+	CRASHTYPE(VMALLOC_LINEAR_OVERFLOW),
+	CRASHTYPE(WRITE_AFTER_FREE),
+	CRASHTYPE(READ_AFTER_FREE),
+	CRASHTYPE(WRITE_BUDDY_AFTER_FREE),
+	CRASHTYPE(READ_BUDDY_AFTER_FREE),
+	CRASHTYPE(SLAB_INIT_ON_ALLOC),
+	CRASHTYPE(BUDDY_INIT_ON_ALLOC),
+	CRASHTYPE(SLAB_FREE_DOUBLE),
+	CRASHTYPE(SLAB_FREE_CROSS),
+	CRASHTYPE(SLAB_FREE_PAGE),
+};
+
+struct crashtype_category heap_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 90f87b193c1e..015e0484026b 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -57,114 +57,44 @@ do {								\
 #define pr_expected_config_param(kconfig, param) pr_expected_config(kconfig)
 #endif
 
-/* bugs.c */
+/* Crash types. */
+struct crashtype {
+	const char *name;
+	void (*func)(void);
+};
+
+#define CRASHTYPE(_name)			\
+	{					\
+		.name = __stringify(_name),	\
+		.func = lkdtm_ ## _name,	\
+	}
+
+/* Category's collection of crashtypes. */
+struct crashtype_category {
+	struct crashtype *crashtypes;
+	size_t len;
+};
+
+/* Each category's crashtypes list. */
+extern struct crashtype_category bugs_crashtypes;
+extern struct crashtype_category heap_crashtypes;
+extern struct crashtype_category perms_crashtypes;
+extern struct crashtype_category refcount_crashtypes;
+extern struct crashtype_category usercopy_crashtypes;
+extern struct crashtype_category stackleak_crashtypes;
+extern struct crashtype_category cfi_crashtypes;
+extern struct crashtype_category fortify_crashtypes;
+extern struct crashtype_category powerpc_crashtypes;
+
+/* Each category's init/exit routines. */
 void __init lkdtm_bugs_init(int *recur_param);
-void lkdtm_PANIC(void);
-void lkdtm_BUG(void);
-void lkdtm_WARNING(void);
-void lkdtm_WARNING_MESSAGE(void);
-void lkdtm_EXCEPTION(void);
-void lkdtm_LOOP(void);
-void lkdtm_EXHAUST_STACK(void);
-void lkdtm_CORRUPT_STACK(void);
-void lkdtm_CORRUPT_STACK_STRONG(void);
-void lkdtm_REPORT_STACK(void);
-void lkdtm_REPORT_STACK_CANARY(void);
-void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
-void lkdtm_SOFTLOCKUP(void);
-void lkdtm_HARDLOCKUP(void);
-void lkdtm_SPINLOCKUP(void);
-void lkdtm_HUNG_TASK(void);
-void lkdtm_OVERFLOW_SIGNED(void);
-void lkdtm_OVERFLOW_UNSIGNED(void);
-void lkdtm_ARRAY_BOUNDS(void);
-void lkdtm_CORRUPT_LIST_ADD(void);
-void lkdtm_CORRUPT_LIST_DEL(void);
-void lkdtm_STACK_GUARD_PAGE_LEADING(void);
-void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
-void lkdtm_UNSET_SMEP(void);
-void lkdtm_DOUBLE_FAULT(void);
-void lkdtm_CORRUPT_PAC(void);
-
-/* heap.c */
 void __init lkdtm_heap_init(void);
 void __exit lkdtm_heap_exit(void);
-void lkdtm_VMALLOC_LINEAR_OVERFLOW(void);
-void lkdtm_SLAB_LINEAR_OVERFLOW(void);
-void lkdtm_WRITE_AFTER_FREE(void);
-void lkdtm_READ_AFTER_FREE(void);
-void lkdtm_WRITE_BUDDY_AFTER_FREE(void);
-void lkdtm_READ_BUDDY_AFTER_FREE(void);
-void lkdtm_SLAB_INIT_ON_ALLOC(void);
-void lkdtm_BUDDY_INIT_ON_ALLOC(void);
-void lkdtm_SLAB_FREE_DOUBLE(void);
-void lkdtm_SLAB_FREE_CROSS(void);
-void lkdtm_SLAB_FREE_PAGE(void);
-
-/* perms.c */
 void __init lkdtm_perms_init(void);
-void lkdtm_WRITE_RO(void);
-void lkdtm_WRITE_RO_AFTER_INIT(void);
-void lkdtm_WRITE_KERN(void);
-void lkdtm_WRITE_OPD(void);
-void lkdtm_EXEC_DATA(void);
-void lkdtm_EXEC_STACK(void);
-void lkdtm_EXEC_KMALLOC(void);
-void lkdtm_EXEC_VMALLOC(void);
-void lkdtm_EXEC_RODATA(void);
-void lkdtm_EXEC_USERSPACE(void);
-void lkdtm_EXEC_NULL(void);
-void lkdtm_ACCESS_USERSPACE(void);
-void lkdtm_ACCESS_NULL(void);
-
-/* refcount.c */
-void lkdtm_REFCOUNT_INC_OVERFLOW(void);
-void lkdtm_REFCOUNT_ADD_OVERFLOW(void);
-void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void);
-void lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW(void);
-void lkdtm_REFCOUNT_DEC_ZERO(void);
-void lkdtm_REFCOUNT_DEC_NEGATIVE(void);
-void lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE(void);
-void lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE(void);
-void lkdtm_REFCOUNT_INC_ZERO(void);
-void lkdtm_REFCOUNT_ADD_ZERO(void);
-void lkdtm_REFCOUNT_INC_SATURATED(void);
-void lkdtm_REFCOUNT_DEC_SATURATED(void);
-void lkdtm_REFCOUNT_ADD_SATURATED(void);
-void lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED(void);
-void lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED(void);
-void lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED(void);
-void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void);
-void lkdtm_REFCOUNT_TIMING(void);
-void lkdtm_ATOMIC_TIMING(void);
-
-/* rodata.c */
-void lkdtm_rodata_do_nothing(void);
-
-/* usercopy.c */
 void __init lkdtm_usercopy_init(void);
 void __exit lkdtm_usercopy_exit(void);
-void lkdtm_USERCOPY_HEAP_SIZE_TO(void);
-void lkdtm_USERCOPY_HEAP_SIZE_FROM(void);
-void lkdtm_USERCOPY_HEAP_WHITELIST_TO(void);
-void lkdtm_USERCOPY_HEAP_WHITELIST_FROM(void);
-void lkdtm_USERCOPY_STACK_FRAME_TO(void);
-void lkdtm_USERCOPY_STACK_FRAME_FROM(void);
-void lkdtm_USERCOPY_STACK_BEYOND(void);
-void lkdtm_USERCOPY_KERNEL(void);
-
-/* stackleak.c */
-void lkdtm_STACKLEAK_ERASING(void);
-
-/* cfi.c */
-void lkdtm_CFI_FORWARD_PROTO(void);
 
-/* fortify.c */
-void lkdtm_FORTIFIED_OBJECT(void);
-void lkdtm_FORTIFIED_SUBOBJECT(void);
-void lkdtm_FORTIFIED_STRSCPY(void);
-
-/* powerpc.c */
-void lkdtm_PPC_SLB_MULTIHIT(void);
+/* Special declaration for function-in-rodata. */
+void lkdtm_rodata_do_nothing(void);
 
 #endif
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2c6aba3ff32b..b93404d65650 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -103,7 +103,7 @@ static void execute_user_location(void *dst)
 	pr_err("FAIL: func returned\n");
 }
 
-void lkdtm_WRITE_RO(void)
+static void lkdtm_WRITE_RO(void)
 {
 	/* Explicitly cast away "const" for the test and make volatile. */
 	volatile unsigned long *ptr = (unsigned long *)&rodata;
@@ -113,7 +113,7 @@ void lkdtm_WRITE_RO(void)
 	pr_err("FAIL: survived bad write\n");
 }
 
-void lkdtm_WRITE_RO_AFTER_INIT(void)
+static void lkdtm_WRITE_RO_AFTER_INIT(void)
 {
 	volatile unsigned long *ptr = &ro_after_init;
 
@@ -132,7 +132,7 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 	pr_err("FAIL: survived bad write\n");
 }
 
-void lkdtm_WRITE_KERN(void)
+static void lkdtm_WRITE_KERN(void)
 {
 	size_t size;
 	volatile unsigned char *ptr;
@@ -149,7 +149,7 @@ void lkdtm_WRITE_KERN(void)
 	do_overwritten();
 }
 
-void lkdtm_WRITE_OPD(void)
+static void lkdtm_WRITE_OPD(void)
 {
 	size_t size = sizeof(func_desc_t);
 	void (*func)(void) = do_nothing;
@@ -166,38 +166,38 @@ void lkdtm_WRITE_OPD(void)
 	func();
 }
 
-void lkdtm_EXEC_DATA(void)
+static void lkdtm_EXEC_DATA(void)
 {
 	execute_location(data_area, CODE_WRITE);
 }
 
-void lkdtm_EXEC_STACK(void)
+static void lkdtm_EXEC_STACK(void)
 {
 	u8 stack_area[EXEC_SIZE];
 	execute_location(stack_area, CODE_WRITE);
 }
 
-void lkdtm_EXEC_KMALLOC(void)
+static void lkdtm_EXEC_KMALLOC(void)
 {
 	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
 	execute_location(kmalloc_area, CODE_WRITE);
 	kfree(kmalloc_area);
 }
 
-void lkdtm_EXEC_VMALLOC(void)
+static void lkdtm_EXEC_VMALLOC(void)
 {
 	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
 	execute_location(vmalloc_area, CODE_WRITE);
 	vfree(vmalloc_area);
 }
 
-void lkdtm_EXEC_RODATA(void)
+static void lkdtm_EXEC_RODATA(void)
 {
 	execute_location(dereference_function_descriptor(lkdtm_rodata_do_nothing),
 			 CODE_AS_IS);
 }
 
-void lkdtm_EXEC_USERSPACE(void)
+static void lkdtm_EXEC_USERSPACE(void)
 {
 	unsigned long user_addr;
 
@@ -212,12 +212,12 @@ void lkdtm_EXEC_USERSPACE(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
-void lkdtm_EXEC_NULL(void)
+static void lkdtm_EXEC_NULL(void)
 {
 	execute_location(NULL, CODE_AS_IS);
 }
 
-void lkdtm_ACCESS_USERSPACE(void)
+static void lkdtm_ACCESS_USERSPACE(void)
 {
 	unsigned long user_addr, tmp = 0;
 	unsigned long *ptr;
@@ -250,7 +250,7 @@ void lkdtm_ACCESS_USERSPACE(void)
 	vm_munmap(user_addr, PAGE_SIZE);
 }
 
-void lkdtm_ACCESS_NULL(void)
+static void lkdtm_ACCESS_NULL(void)
 {
 	unsigned long tmp;
 	volatile unsigned long *ptr = (unsigned long *)NULL;
@@ -270,3 +270,24 @@ void __init lkdtm_perms_init(void)
 	/* Make sure we can write to __ro_after_init values during __init */
 	ro_after_init |= 0xAA;
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(WRITE_RO),
+	CRASHTYPE(WRITE_RO_AFTER_INIT),
+	CRASHTYPE(WRITE_KERN),
+	CRASHTYPE(WRITE_OPD),
+	CRASHTYPE(EXEC_DATA),
+	CRASHTYPE(EXEC_STACK),
+	CRASHTYPE(EXEC_KMALLOC),
+	CRASHTYPE(EXEC_VMALLOC),
+	CRASHTYPE(EXEC_RODATA),
+	CRASHTYPE(EXEC_USERSPACE),
+	CRASHTYPE(EXEC_NULL),
+	CRASHTYPE(ACCESS_USERSPACE),
+	CRASHTYPE(ACCESS_NULL),
+};
+
+struct crashtype_category perms_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/powerpc.c b/drivers/misc/lkdtm/powerpc.c
index 077c9f9ed8d0..be385449911a 100644
--- a/drivers/misc/lkdtm/powerpc.c
+++ b/drivers/misc/lkdtm/powerpc.c
@@ -100,7 +100,7 @@ static void insert_dup_slb_entry_0(void)
 	preempt_enable();
 }
 
-void lkdtm_PPC_SLB_MULTIHIT(void)
+static void lkdtm_PPC_SLB_MULTIHIT(void)
 {
 	if (!radix_enabled()) {
 		pr_info("Injecting SLB multihit errors\n");
@@ -118,3 +118,12 @@ void lkdtm_PPC_SLB_MULTIHIT(void)
 		pr_err("XFAIL: This test is for ppc64 and with hash mode MMU only\n");
 	}
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(PPC_SLB_MULTIHIT),
+};
+
+struct crashtype_category powerpc_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index de7c5ab528d9..5cd488f54cfa 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -24,7 +24,7 @@ static void overflow_check(refcount_t *ref)
  * A refcount_inc() above the maximum value of the refcount implementation,
  * should at least saturate, and at most also WARN.
  */
-void lkdtm_REFCOUNT_INC_OVERFLOW(void)
+static void lkdtm_REFCOUNT_INC_OVERFLOW(void)
 {
 	refcount_t over = REFCOUNT_INIT(REFCOUNT_MAX - 1);
 
@@ -40,7 +40,7 @@ void lkdtm_REFCOUNT_INC_OVERFLOW(void)
 }
 
 /* refcount_add() should behave just like refcount_inc() above. */
-void lkdtm_REFCOUNT_ADD_OVERFLOW(void)
+static void lkdtm_REFCOUNT_ADD_OVERFLOW(void)
 {
 	refcount_t over = REFCOUNT_INIT(REFCOUNT_MAX - 1);
 
@@ -58,7 +58,7 @@ void lkdtm_REFCOUNT_ADD_OVERFLOW(void)
 }
 
 /* refcount_inc_not_zero() should behave just like refcount_inc() above. */
-void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void)
+static void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void)
 {
 	refcount_t over = REFCOUNT_INIT(REFCOUNT_MAX);
 
@@ -70,7 +70,7 @@ void lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW(void)
 }
 
 /* refcount_add_not_zero() should behave just like refcount_inc() above. */
-void lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW(void)
+static void lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW(void)
 {
 	refcount_t over = REFCOUNT_INIT(REFCOUNT_MAX);
 
@@ -103,7 +103,7 @@ static void check_zero(refcount_t *ref)
  * zero it should either saturate (when inc-from-zero isn't protected)
  * or stay at zero (when inc-from-zero is protected) and should WARN for both.
  */
-void lkdtm_REFCOUNT_DEC_ZERO(void)
+static void lkdtm_REFCOUNT_DEC_ZERO(void)
 {
 	refcount_t zero = REFCOUNT_INIT(2);
 
@@ -142,7 +142,7 @@ static void check_negative(refcount_t *ref, int start)
 }
 
 /* A refcount_dec() going negative should saturate and may WARN. */
-void lkdtm_REFCOUNT_DEC_NEGATIVE(void)
+static void lkdtm_REFCOUNT_DEC_NEGATIVE(void)
 {
 	refcount_t neg = REFCOUNT_INIT(0);
 
@@ -156,7 +156,7 @@ void lkdtm_REFCOUNT_DEC_NEGATIVE(void)
  * A refcount_dec_and_test() should act like refcount_dec() above when
  * going negative.
  */
-void lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE(void)
+static void lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE(void)
 {
 	refcount_t neg = REFCOUNT_INIT(0);
 
@@ -171,7 +171,7 @@ void lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE(void)
  * A refcount_sub_and_test() should act like refcount_dec_and_test()
  * above when going negative.
  */
-void lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE(void)
+static void lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE(void)
 {
 	refcount_t neg = REFCOUNT_INIT(3);
 
@@ -203,7 +203,7 @@ static void check_from_zero(refcount_t *ref)
 /*
  * A refcount_inc() from zero should pin to zero or saturate and may WARN.
  */
-void lkdtm_REFCOUNT_INC_ZERO(void)
+static void lkdtm_REFCOUNT_INC_ZERO(void)
 {
 	refcount_t zero = REFCOUNT_INIT(0);
 
@@ -228,7 +228,7 @@ void lkdtm_REFCOUNT_INC_ZERO(void)
  * A refcount_add() should act like refcount_inc() above when starting
  * at zero.
  */
-void lkdtm_REFCOUNT_ADD_ZERO(void)
+static void lkdtm_REFCOUNT_ADD_ZERO(void)
 {
 	refcount_t zero = REFCOUNT_INIT(0);
 
@@ -267,7 +267,7 @@ static void check_saturated(refcount_t *ref)
  * A refcount_inc() from a saturated value should at most warn about
  * being saturated already.
  */
-void lkdtm_REFCOUNT_INC_SATURATED(void)
+static void lkdtm_REFCOUNT_INC_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -278,7 +278,7 @@ void lkdtm_REFCOUNT_INC_SATURATED(void)
 }
 
 /* Should act like refcount_inc() above from saturated. */
-void lkdtm_REFCOUNT_DEC_SATURATED(void)
+static void lkdtm_REFCOUNT_DEC_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -289,7 +289,7 @@ void lkdtm_REFCOUNT_DEC_SATURATED(void)
 }
 
 /* Should act like refcount_inc() above from saturated. */
-void lkdtm_REFCOUNT_ADD_SATURATED(void)
+static void lkdtm_REFCOUNT_ADD_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -300,7 +300,7 @@ void lkdtm_REFCOUNT_ADD_SATURATED(void)
 }
 
 /* Should act like refcount_inc() above from saturated. */
-void lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED(void)
+static void lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -312,7 +312,7 @@ void lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED(void)
 }
 
 /* Should act like refcount_inc() above from saturated. */
-void lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED(void)
+static void lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -324,7 +324,7 @@ void lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED(void)
 }
 
 /* Should act like refcount_inc() above from saturated. */
-void lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED(void)
+static void lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -336,7 +336,7 @@ void lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED(void)
 }
 
 /* Should act like refcount_inc() above from saturated. */
-void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void)
+static void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void)
 {
 	refcount_t sat = REFCOUNT_INIT(REFCOUNT_SATURATED);
 
@@ -348,7 +348,7 @@ void lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED(void)
 }
 
 /* Used to time the existing atomic_t when used for reference counting */
-void lkdtm_ATOMIC_TIMING(void)
+static void lkdtm_ATOMIC_TIMING(void)
 {
 	unsigned int i;
 	atomic_t count = ATOMIC_INIT(1);
@@ -373,7 +373,7 @@ void lkdtm_ATOMIC_TIMING(void)
  *    cd /sys/kernel/debug/provoke-crash
  *    perf stat -B -- cat <(echo REFCOUNT_TIMING) > DIRECT
  */
-void lkdtm_REFCOUNT_TIMING(void)
+static void lkdtm_REFCOUNT_TIMING(void)
 {
 	unsigned int i;
 	refcount_t count = REFCOUNT_INIT(1);
@@ -390,3 +390,30 @@ void lkdtm_REFCOUNT_TIMING(void)
 	else
 		pr_info("refcount timing: done\n");
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
+	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
+	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_OVERFLOW),
+	CRASHTYPE(REFCOUNT_ADD_NOT_ZERO_OVERFLOW),
+	CRASHTYPE(REFCOUNT_DEC_ZERO),
+	CRASHTYPE(REFCOUNT_DEC_NEGATIVE),
+	CRASHTYPE(REFCOUNT_DEC_AND_TEST_NEGATIVE),
+	CRASHTYPE(REFCOUNT_SUB_AND_TEST_NEGATIVE),
+	CRASHTYPE(REFCOUNT_INC_ZERO),
+	CRASHTYPE(REFCOUNT_ADD_ZERO),
+	CRASHTYPE(REFCOUNT_INC_SATURATED),
+	CRASHTYPE(REFCOUNT_DEC_SATURATED),
+	CRASHTYPE(REFCOUNT_ADD_SATURATED),
+	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_SATURATED),
+	CRASHTYPE(REFCOUNT_ADD_NOT_ZERO_SATURATED),
+	CRASHTYPE(REFCOUNT_DEC_AND_TEST_SATURATED),
+	CRASHTYPE(REFCOUNT_SUB_AND_TEST_SATURATED),
+	CRASHTYPE(ATOMIC_TIMING),
+	CRASHTYPE(REFCOUNT_TIMING),
+};
+
+struct crashtype_category refcount_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 00db21ff115e..210c84dfe1d2 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -11,7 +11,7 @@
 #include "lkdtm.h"
 #include <linux/stackleak.h>
 
-void lkdtm_STACKLEAK_ERASING(void)
+static void lkdtm_STACKLEAK_ERASING(void)
 {
 	unsigned long *sp, left, found, i;
 	const unsigned long check_depth =
@@ -80,3 +80,12 @@ void lkdtm_STACKLEAK_ERASING(void)
 		pr_info("OK: the rest of the thread stack is properly erased\n");
 	}
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(STACKLEAK_ERASING),
+};
+
+struct crashtype_category stackleak_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 3fead5efe523..7852b9fc7c47 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -272,42 +272,42 @@ static void do_usercopy_heap_whitelist(bool to_user)
 }
 
 /* Callable tests. */
-void lkdtm_USERCOPY_HEAP_SIZE_TO(void)
+static void lkdtm_USERCOPY_HEAP_SIZE_TO(void)
 {
 	do_usercopy_heap_size(true);
 }
 
-void lkdtm_USERCOPY_HEAP_SIZE_FROM(void)
+static void lkdtm_USERCOPY_HEAP_SIZE_FROM(void)
 {
 	do_usercopy_heap_size(false);
 }
 
-void lkdtm_USERCOPY_HEAP_WHITELIST_TO(void)
+static void lkdtm_USERCOPY_HEAP_WHITELIST_TO(void)
 {
 	do_usercopy_heap_whitelist(true);
 }
 
-void lkdtm_USERCOPY_HEAP_WHITELIST_FROM(void)
+static void lkdtm_USERCOPY_HEAP_WHITELIST_FROM(void)
 {
 	do_usercopy_heap_whitelist(false);
 }
 
-void lkdtm_USERCOPY_STACK_FRAME_TO(void)
+static void lkdtm_USERCOPY_STACK_FRAME_TO(void)
 {
 	do_usercopy_stack(true, true);
 }
 
-void lkdtm_USERCOPY_STACK_FRAME_FROM(void)
+static void lkdtm_USERCOPY_STACK_FRAME_FROM(void)
 {
 	do_usercopy_stack(false, true);
 }
 
-void lkdtm_USERCOPY_STACK_BEYOND(void)
+static void lkdtm_USERCOPY_STACK_BEYOND(void)
 {
 	do_usercopy_stack(true, false);
 }
 
-void lkdtm_USERCOPY_KERNEL(void)
+static void lkdtm_USERCOPY_KERNEL(void)
 {
 	unsigned long user_addr;
 
@@ -356,3 +356,19 @@ void __exit lkdtm_usercopy_exit(void)
 {
 	kmem_cache_destroy(whitelist_cache);
 }
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(USERCOPY_HEAP_SIZE_TO),
+	CRASHTYPE(USERCOPY_HEAP_SIZE_FROM),
+	CRASHTYPE(USERCOPY_HEAP_WHITELIST_TO),
+	CRASHTYPE(USERCOPY_HEAP_WHITELIST_FROM),
+	CRASHTYPE(USERCOPY_STACK_FRAME_TO),
+	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
+	CRASHTYPE(USERCOPY_STACK_BEYOND),
+	CRASHTYPE(USERCOPY_KERNEL),
+};
+
+struct crashtype_category usercopy_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
-- 
2.32.0

