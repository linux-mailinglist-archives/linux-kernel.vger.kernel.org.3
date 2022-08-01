Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C003586EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiHAQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiHAQfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:35:08 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765693E755
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:35:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [92.49.173.143])
        by mail.ispras.ru (Postfix) with ESMTPSA id 8F49E407624C;
        Mon,  1 Aug 2022 16:35:04 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v5 2/5] x86: Add resolve_cmdline() helper
Date:   Mon,  1 Aug 2022 19:34:58 +0300
Message-Id: <68009748361af670dffffb99b817ccb3b98bfbd1.1658843651.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1658843651.git.baskov@ispras.ru>
References: <cover.1658843651.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baskov Evgeniy <baskov@ispras.ru>

Command line needs to be combined in both compressed and uncompressed
kernel from built-in and boot command line strings, which requires
non-trivial logic depending on CONFIG_CMDLINE_BOOL and
CONFIG_CMDLINE_OVERRIDE.

Add a helper function to avoid code duplication.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

 create mode 100644 arch/x86/include/asm/shared/setup-cmdline.h

diff --git a/arch/x86/include/asm/shared/setup-cmdline.h b/arch/x86/include/asm/shared/setup-cmdline.h
new file mode 100644
index 000000000000..b8bb19e63ec2
--- /dev/null
+++ b/arch/x86/include/asm/shared/setup-cmdline.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_X86_SETUP_CMDLINE_H
+#define _ASM_X86_SETUP_CMDLINE_H
+
+#define _SETUP
+#include <asm/setup.h> /* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
+#include <linux/string.h>
+
+#ifdef CONFIG_CMDLINE_BOOL
+#define COMMAND_LINE_INIT CONFIG_CMDLINE
+#else
+#define COMMAND_LINE_INIT ""
+#endif
+
+/*
+ * command_line and boot_command_line are expected to be at most
+ * COMMAND_LINE_SIZE length. command_line needs to be initialized
+ * with COMMAND_LINE_INIT.
+ */
+
+static inline void resolve_cmdline(char *command_line,
+				   const char *boot_command_line)
+{
+#ifdef CONFIG_CMDLINE_BOOL
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		/* Append boot loader cmdline to builtin */
+		strlcat(command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	}
+#else
+	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+#endif
+}
+
+#endif /* _ASM_X86_SETUP_CMDLINE_H */
-- 
2.35.1

