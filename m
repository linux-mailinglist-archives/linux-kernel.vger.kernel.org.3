Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243D507DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345375AbiDTAqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358642AbiDTAqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:32 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2356205C5;
        Tue, 19 Apr 2022 17:43:47 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3106F1BF207;
        Wed, 20 Apr 2022 00:43:38 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 09/11] x86/FineIBT: Add FINEIBT_TEST module
Date:   Tue, 19 Apr 2022 17:42:39 -0700
Message-Id: <20220420004241.2093-10-joao@overdrivepizza.com>
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

Adds a module that on load will call a function directly ensuring that
FineIBT fixes for module relocations are working as expected. Next the
module invokes another function indirectly, with a wrong hash into R11,
causing a violation to be triggered (and the __fineibt_handler to be
invoked).

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
---
 arch/x86/Kconfig.debug         |  5 +++++
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/fineibt_test.c | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 arch/x86/kernel/fineibt_test.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d2463dd912c1..4a5617c2470d 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -284,3 +284,8 @@ config X86_CET_TEST
 	depends on m
 	depends on X86_KERNEL_IBT
 	tristate "in-kernel CET testing module"
+
+config X86_FINEIBT_TEST
+	depends on m
+	depends on X86_KERNEL_FINEIBT
+	tristate "in-kernel FineIBT testing module"
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index a82bcd14bd40..5d7f39f3d909 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 obj-$(CONFIG_X86_KERNEL_FINEIBT)	+= fineibt.o
 obj-$(CONFIG_X86_CET_TEST)		+= cet_test.o
+obj-$(CONFIG_X86_FINEIBT_TEST)		+= fineibt_test.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/fineibt_test.c b/arch/x86/kernel/fineibt_test.c
new file mode 100644
index 000000000000..c8cbff6208f8
--- /dev/null
+++ b/arch/x86/kernel/fineibt_test.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+
+void __fineibt_debug(void);
+
+void fineibt_foo(void) {
+  pr_info("FineIBT: dmesg should show a FineIBT violation message.\n");
+}
+
+void fineibt_bar(void) {
+  pr_info("FineIBT: this first one should run smoothly.\n");
+}
+
+static int fineibt_test_init(void)
+{
+  pr_info("FineIBT test\n");
+
+  __fineibt_debug();
+
+  asm volatile(
+    "call fineibt_bar\n"
+    "lea fineibt_foo(%%rip), %%rax\n"
+    "mov $0xdeadbeef, %%r11\n"
+    "call *%%rax\n"
+    /* this should trigger the handler because the hash is wrong */
+    ::: "rax"
+  );
+  return 0;
+}
+
+static void fineibt_test_exit(void)
+{
+}
+
+module_init(fineibt_test_init);
+module_exit(fineibt_test_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

