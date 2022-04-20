Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E876F507DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358652AbiDTAqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358642AbiDTAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:26 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D1E17A93;
        Tue, 19 Apr 2022 17:43:41 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BFA7F1BF206;
        Wed, 20 Apr 2022 00:43:33 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 08/11] x86/ibt: Add CET_TEST module for IBT testing
Date:   Tue, 19 Apr 2022 17:42:38 -0700
Message-Id: <20220420004241.2093-9-joao@overdrivepizza.com>
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

Add a kernel module that violates IBT policy on load, triggering a
control protection fault and makes the enforcement visible.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
Tinkered-from-work-by: Alyssa Milburn <alyssa.milburn@linux.intel.com>
---
 arch/x86/Kconfig.debug     |  5 +++++
 arch/x86/kernel/Makefile   |  1 +
 arch/x86/kernel/cet_test.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/x86/kernel/cet_test.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d3a6f74a94bd..d2463dd912c1 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -279,3 +279,8 @@ endchoice
 config FRAME_POINTER
 	depends on !UNWINDER_ORC && !UNWINDER_GUESS
 	bool
+
+config X86_CET_TEST
+	depends on m
+	depends on X86_KERNEL_IBT
+	tristate "in-kernel CET testing module"
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index cb947569e9d8..a82bcd14bd40 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -149,6 +149,7 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 obj-$(CONFIG_X86_KERNEL_FINEIBT)	+= fineibt.o
+obj-$(CONFIG_X86_CET_TEST)		+= cet_test.o
 
 ###
 # 64 bit specific files
diff --git a/arch/x86/kernel/cet_test.c b/arch/x86/kernel/cet_test.c
new file mode 100644
index 000000000000..c48be8cbd0b5
--- /dev/null
+++ b/arch/x86/kernel/cet_test.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+
+static int cet_test_init(void)
+{
+	pr_info("CET test, expect faults\n");
+
+	// FIXME: use register_die_notifier
+
+	asm volatile(
+		"lea 1f(%%rip), %%rax\n"
+		"jmp *%%rax\n"
+		"nop\n"
+		"1:\n"
+		/* no endbranch */
+		"nop\n"
+		:::"rax"
+		    );
+	return 0;
+}
+
+static void cet_test_exit(void)
+{
+}
+
+module_init(cet_test_init);
+module_exit(cet_test_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

