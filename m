Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5143C51D759
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391669AbiEFMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389887AbiEFMPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:15:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 342E25A087
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:11:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B80CA14BF;
        Fri,  6 May 2022 05:11:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF0CE3F7F5;
        Fri,  6 May 2022 05:11:57 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     alex.popov@linux.com, mark.rutland@arm.com
Subject: [PATCH] lkdtm/stackleak: fix CONFIG_GCC_PLUGIN_STACKLEAK=n
Date:   Fri,  6 May 2022 13:11:45 +0100
Message-Id: <20220506121145.1162908-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent rework broke building LKDTM when CONFIG_GCC_PLUGIN_STACKLEAK=n.
This patch fixes that breakage.

Prior to recent stackleak rework, the LKDTM STACKLEAK_ERASING code could
be built when the kernel was not built with stackleak support, and would
run a test that would almost certainly fail (or pass by sheer cosmic
coincidence), e.g.

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: checking unused part of the thread stack (15560 bytes)...
| lkdtm: FAIL: the erased part is not found (checked 15560 bytes)
| lkdtm: FAIL: the thread stack is NOT properly erased!
| lkdtm: This is probably expected, since this kernel (5.18.0-rc2 aarch64) was built *without* CONFIG_GCC_PLUGIN_STACKLEAK=y

The recent rework to the test made it more accurate by using helpers
which are only defined when CONFIG_GCC_PLUGIN_STACKLEAK=y, and so when
building LKDTM when CONFIG_GCC_PLUGIN_STACKLEAK=n, we get a build
failure:

| drivers/misc/lkdtm/stackleak.c: In function 'check_stackleak_irqoff':
| drivers/misc/lkdtm/stackleak.c:30:46: error: implicit declaration of function 'stackleak_task_low_bound' [-Werror=implicit-function-declaration]
|    30 |         const unsigned long task_stack_low = stackleak_task_low_bound(current);
|       |                                              ^~~~~~~~~~~~~~~~~~~~~~~~
| drivers/misc/lkdtm/stackleak.c:31:47: error: implicit declaration of function 'stackleak_task_high_bound'; did you mean 'stackleak_task_init'? [-Werror=implicit-function-declaration]
|    31 |         const unsigned long task_stack_high = stackleak_task_high_bound(current);
|       |                                               ^~~~~~~~~~~~~~~~~~~~~~~~~
|       |                                               stackleak_task_init
| drivers/misc/lkdtm/stackleak.c:33:48: error: 'struct task_struct' has no member named 'lowest_stack'
|    33 |         const unsigned long lowest_sp = current->lowest_stack;
|       |                                                ^~
| drivers/misc/lkdtm/stackleak.c:74:23: error: implicit declaration of function 'stackleak_find_top_of_poison' [-Werror=implicit-function-declaration]
|    74 |         poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);
|       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

This patch fixes the issue by not compiling the body of the test when
CONFIG_GCC_PLUGIN_STACKLEAK=n, and replacing this with an unconditional
XFAIL message. This means the pr_expected_config() in
check_stackleak_irqoff() is redundant, and so it is removed.

Where an architecture does not support stackleak, the test will log:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)

Where an architectures does support stackleak, but this has not been
compiled in, the test will log:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: XFAIL: stackleak is not enabled (CONFIG_GCC_PLUGIN_STACKLEAK=n)

Where stackleak has been compiled in, the test behaves as usual:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: stackleak stack usage:
|   high offset: 336 bytes
|   current:     688 bytes
|   lowest:      1232 bytes
|   tracked:     1232 bytes
|   untracked:   672 bytes
|   poisoned:    14136 bytes
|   low offset:  8 bytes
| lkdtm: OK: the rest of the thread stack is properly erased

Fixes: f4cfacd92972cc44 ("lkdtm/stackleak: rework boundary management")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/stackleak.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 52800583fd051..82369c6f889e2 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -11,6 +11,7 @@
 #include "lkdtm.h"
 #include <linux/stackleak.h>
 
+#if defined(CONFIG_GCC_PLUGIN_STACKLEAK)
 /*
  * Check that stackleak tracks the lowest stack pointer and erases the stack
  * below this as expected.
@@ -109,7 +110,6 @@ static void noinstr check_stackleak_irqoff(void)
 out:
 	if (test_failed) {
 		pr_err("FAIL: the thread stack is NOT properly erased!\n");
-		pr_expected_config(CONFIG_GCC_PLUGIN_STACKLEAK);
 	} else {
 		pr_info("OK: the rest of the thread stack is properly erased\n");
 	}
@@ -123,3 +123,13 @@ void lkdtm_STACKLEAK_ERASING(void)
 	check_stackleak_irqoff();
 	local_irq_restore(flags);
 }
+#else /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
+void lkdtm_STACKLEAK_ERASING(void)
+{
+	if (IS_ENABLED(CONFIG_HAVE_ARCH_STACKLEAK)) {
+		pr_err("XFAIL: stackleak is not enabled (CONFIG_GCC_PLUGIN_STACKLEAK=n)\n");
+	} else {
+		pr_err("XFAIL: stackleak is not supported on this arch (HAVE_ARCH_STACKLEAK=n)\n");
+	}
+}
+#endif /* defined(CONFIG_GCC_PLUGIN_STACKLEAK) */
-- 
2.30.2

