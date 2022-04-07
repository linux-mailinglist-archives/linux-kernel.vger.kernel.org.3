Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA34F722E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiDGCnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbiDGCmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:42:36 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDD191405
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:40:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id CDBC24076B21;
        Thu,  7 Apr 2022 02:40:29 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Parse CONFIG_CMDLINE in compressed kernel
Date:   Thu,  7 Apr 2022 05:40:14 +0300
Message-Id: <20220407024014.6916-1-baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
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

CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE was ignored
during options lookup in compressed kernel, including
earlyprintk option, so it was impossible to get earlyprintk
messages from that stage of boot process via command line
provided at compile time. Being able to enable earlyprintk
via compile-time option might be desirable for booting
on systems with broken UEFI command line arguments via EFISTUB.

Parse CONFIG_CMDLINE-related options correctly in compressed
kernel code.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..dd8cbbe61dff 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -22,9 +22,49 @@ unsigned long get_cmd_line_ptr(void)
 }
 int cmdline_find_option(const char *option, char *buffer, int bufsize)
 {
-	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, bufsize);
+	int len = -1;
+	unsigned long cmdline_ptr;
+
+	/*
+	 * First try command line string provided by user,
+	 * then try command line string configured at comple time.
+	 * Skip first step if CONFIG_CMDLINE_OVERRIDE is enabled
+	 * and parse only compile time command line.
+	 */
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		cmdline_ptr = get_cmd_line_ptr();
+		len = __cmdline_find_option(cmdline_ptr, option,
+					    buffer, bufsize);
+	}
+
+#ifdef CONFIG_CMDLINE_BOOL
+	if (len < 0) {
+		cmdline_ptr = (unsigned long)CONFIG_CMDLINE;
+		len = __cmdline_find_option(cmdline_ptr, option,
+					    buffer, bufsize);
+	}
+#endif
+
+	return len;
 }
 int cmdline_find_option_bool(const char *option)
 {
-	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
+	int len = -1;
+	unsigned long cmdline_ptr;
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
+		cmdline_ptr = get_cmd_line_ptr();
+		len = __cmdline_find_option_bool(cmdline_ptr, option);
+	}
+
+
+#ifdef CONFIG_CMDLINE_BOOL
+	if (len < 0) {
+		cmdline_ptr = (unsigned long)CONFIG_CMDLINE;
+		len = __cmdline_find_option_bool(cmdline_ptr, option);
+	}
+#endif
+
+	return len;
 }
-- 
2.35.1

