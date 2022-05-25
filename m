Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACA7533A76
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiEYKKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiEYKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:10:21 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B392D2C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:10:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1466A40755E9;
        Wed, 25 May 2022 10:10:19 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] x86/setup: Use resolve_cmdline() in setup.c
Date:   Wed, 25 May 2022 13:10:11 +0300
Message-Id: <91ebe4b17ee6b77e0800be9689eb7c7a2514a0ef.1653471377.git.baskov@ispras.ru>
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

Use a common helper function for command line resolving in
arch/x86/kernel/setup.c for code unification.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 249981bf3d8a..880465e26da2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -47,6 +47,7 @@
 #include <asm/pci-direct.h>
 #include <asm/prom.h>
 #include <asm/proto.h>
+#include <asm/shared/setup-cmdline.h>
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
@@ -164,10 +165,7 @@ unsigned long saved_video_mode;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char __initdata command_line[COMMAND_LINE_SIZE];
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
+static char command_line[COMMAND_LINE_SIZE] __initdata = COMMAND_LINE_INIT;
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
@@ -901,20 +899,8 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
-	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	resolve_cmdline(command_line, boot_command_line);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
 	/*
-- 
2.36.1

