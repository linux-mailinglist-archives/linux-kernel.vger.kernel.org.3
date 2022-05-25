Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE04533A74
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbiEYKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiEYKKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:10:22 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27BC90CE1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:10:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id B461240755EB;
        Wed, 25 May 2022 10:10:19 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] x86/boot: Use resolve_cmdline() in compressed kernel
Date:   Wed, 25 May 2022 13:10:12 +0300
Message-Id: <a2e035e2f3927900864255d593bbab1611b19895.1653471377.git.baskov@ispras.ru>
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

CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE were ignored during
options lookup in compressed kernel, including earlyprintk option,
so it was impossible to get earlyprintk messages from that stage
of boot process via command line provided at compile time.
Being able to enable earlyprintk via compile-time option might
be desirable for booting on systems with broken UEFI command line
arguments via EFISTUB.

Use a common helper function to handle CONFIG_CMDLINE_* in compressed
kernel.

Place command_line_init explicitly in '.data' section since it is
used before '.bss' section is zeroed and it is expected to be equal
to zero.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..77a758146531 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -12,6 +12,15 @@ static inline char rdfs8(addr_t addr)
 	return *((char *)(fs + addr));
 }
 #include "../cmdline.c"
+
+static char command_line[COMMAND_LINE_SIZE] __section(".data") = COMMAND_LINE_INIT;
+static bool command_line_init __section(".data");
+
+/*
+ * This always returns runtime command line and does not account for built-in
+ * command line, so this should not be used for cmdline parsing.
+ * Use get_cmdline() instead.
+ */
 unsigned long get_cmd_line_ptr(void)
 {
 	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
@@ -20,11 +29,22 @@ unsigned long get_cmd_line_ptr(void)
 
 	return cmd_line_ptr;
 }
+
+static inline unsigned long get_cmdline(void)
+{
+	if (!command_line_init) {
+		resolve_cmdline(command_line, (char *)get_cmd_line_ptr());
+		command_line_init = 1;
+	}
+
+	return (unsigned long)command_line;
+}
+
 int cmdline_find_option(const char *option, char *buffer, int bufsize)
 {
-	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, bufsize);
+	return __cmdline_find_option(get_cmdline(), option, buffer, bufsize);
 }
 int cmdline_find_option_bool(const char *option)
 {
-	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
+	return __cmdline_find_option_bool(get_cmdline(), option);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 4910bf230d7b..e30159dc81b4 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -26,6 +26,7 @@
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/shared/setup-cmdline.h>
 
 #include "tdx.h"
 
-- 
2.36.1

