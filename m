Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22924533A73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiEYKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbiEYKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:10:21 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D02A91599
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:10:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 66B1240755CB;
        Wed, 25 May 2022 10:10:18 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] x86: Add resolve_cmdline() helper
Date:   Wed, 25 May 2022 13:10:10 +0300
Message-Id: <7eb917aeb1fa9f044f90ec33c8bf33bb6aee62a5.1653471377.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653471377.git.baskov@ispras.ru>
References: <cover.1653471377.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command line needs to be combined in both compressed and uncompressed
kernel from built-in and boot command line strings, which requires
non-trivial logic depending on CONFIG_CMDLINE_BOOL and
CONFIG_CMDLINE_OVERRIDE.

Add a helper function to avoid code duplication.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

 create mode 100644 arch/x86/include/asm/shared/setup-cmdline.h

diff --git a/arch/x86/include/asm/shared/setup-cmdline.h b/arch/x86/include/asm/shared/setup-cmdline.h
new file mode 100644
index 000000000000..9822e5af4925
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
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+#endif
+}
+
+#endif /* _ASM_X86_SETUP_CMDLINE_H */
-- 
2.36.1

