Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E251BD4B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355933AbiEEKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355849AbiEEKg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:36:28 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D61F61B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:32:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6816A40755F6;
        Thu,  5 May 2022 10:32:44 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86: Parse CONFIG_CMDLINE in compressed kernel
Date:   Thu,  5 May 2022 13:32:24 +0300
Message-Id: <20220505103224.21667-3-baskov@ispras.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505103224.21667-1-baskov@ispras.ru>
References: <20220505103224.21667-1-baskov@ispras.ru>
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

CONFIG_CMDLINE, CONFIG_CMDLINE_BOOL, and CONFIG_CMDLINE_OVERRIDE were
ignored during options lookup in compressed kernel.

Parse CONFIG_CMDLINE-related options correctly in compressed kernel
code.

cmd_line_ptr_init is explicitly placed in .data section since it is
used and expected to be equal to zero before .bss section is cleared.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..261f53ad395a 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
+#define COMMAND_LINE_SIZE 2048
+
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
 {
@@ -12,12 +14,32 @@ static inline char rdfs8(addr_t addr)
 	return *((char *)(fs + addr));
 }
 #include "../cmdline.c"
+
+#ifdef CONFIG_CMDLINE_BOOL
+static char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+static bool builtin_cmdline_init __section(".data");
+#endif
+
 unsigned long get_cmd_line_ptr(void)
 {
 	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
-
 	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
 
+#ifdef CONFIG_CMDLINE_BOOL
+	if (!builtin_cmdline_init) {
+		if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+			strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(builtin_cmdline,
+				(char *)cmd_line_ptr,
+				COMMAND_LINE_SIZE);
+		}
+
+		builtin_cmdline_init = 1;
+	}
+
+	cmd_line_ptr = (unsigned long)builtin_cmdline;
+#endif
+
 	return cmd_line_ptr;
 }
 int cmdline_find_option(const char *option, char *buffer, int bufsize)
-- 
2.36.0

