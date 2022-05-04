Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3142E51AF92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378336AbiEDUpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378325AbiEDUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:45:31 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF35131D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:41:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 70DB1407627C;
        Wed,  4 May 2022 20:41:52 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86: Parse CONFIG_CMDLINE in compressed kernel
Date:   Wed,  4 May 2022 23:41:23 +0300
Message-Id: <20220504204123.22967-3-baskov@ispras.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504204123.22967-1-baskov@ispras.ru>
References: <20220504204123.22967-1-baskov@ispras.ru>
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

cmd_line_ptr is explicitly placed in .data section since it is used
and expected to be equal to zero before .bss section is cleared.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..58723983933d 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,22 +1,46 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
+#define COMMAND_LINE_SIZE 2048
+
 static unsigned long fs;
+
 static inline void set_fs(unsigned long seg)
 {
 	fs = seg << 4;  /* shift it back */
 }
+
 typedef unsigned long addr_t;
+
 static inline char rdfs8(addr_t addr)
 {
 	return *((char *)(fs + addr));
 }
+
 #include "../cmdline.c"
+
+static unsigned long cmd_line_ptr __section(".data");
+#ifdef CONFIG_CMDLINE_BOOL
+static char builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
+#endif
+
 unsigned long get_cmd_line_ptr(void)
 {
-	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+	if (!cmd_line_ptr) {
+		cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+
+		cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+
+#ifdef CONFIG_CMDLINE_BOOL
+		if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+			strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
+			strlcat(builtin_cmdline,
+				(char *)cmd_line_ptr, COMMAND_LINE_SIZE);
+		}
 
-	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+		cmd_line_ptr = (unsigned long)builtin_cmdline;
+#endif
+	}
 
 	return cmd_line_ptr;
 }
-- 
2.36.0

