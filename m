Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1966047A63A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbhLTIuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:50:17 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:60095 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234525AbhLTIuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:50:16 -0500
X-QQ-mid: bizesmtp47t1639990082t7c9zcx5
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 16:48:00 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8fNau2wZp7g+fTrH9IhYn6Y1+dWPEifzOlLtimqIkp/X2TZvQ54C
        1fHO6tJzrI9ot/SuF5APySaldEV0OTo0+RpcVCh6AFnmo9hx6AvvFxg9OVEeTH43RLGh/hr
        m3oerkYAszfxALQDDgIt1NemOywil1OYFHFDumqUkElLfpIKDL4oMmBJ1G9V+CIuSzcPTOY
        /fb2EC78DqfU/M0A8zpfF9zvgT6XQtmLTgQT7AGT11yU6Xo/i4cgyE0mtZKxoHyQjIE4duX
        uG75vPsZlMlakcj/2q6gy54+efdSIPMmOcyVJxnvt4B7JM1LizrOUDV+ZfVnvGx5EpLdiRY
        1ca1Aj7tdrCkfCwcVPgtwfcrt8i7rOmqvKfFGLYXbddQULWCYd7QAlRdhOn0g==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jcmvbkbc@gmail.com
Cc:     chris@zankel.net, rdunlap@infradead.org, wangborong@cdjrlc.com,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 16:47:56 +0800
Message-Id: <20211220084756.955307-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy should not be used because it doesn't limit the source
length. So that it will lead some potential bugs.

But the strscpy doesn't require reading memory from the src string
beyond the specified "count" bytes, and since the return value is
easier to error-check than strlcpy()'s. In addition, the implementation
is robust to the string changing out from underneath it, unlike the
current strlcpy() implementation.

Thus, replace strlcpy with strscpy.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/xtensa/kernel/setup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 8db20cfb44ab..3f1842891482 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -140,7 +140,7 @@ __tagtable(BP_TAG_FDT, parse_tag_fdt);
 
 static int __init parse_tag_cmdline(const bp_tag_t* tag)
 {
-	strlcpy(command_line, (char *)(tag->data), COMMAND_LINE_SIZE);
+	strscpy(command_line, (char *)(tag->data), COMMAND_LINE_SIZE);
 	return 0;
 }
 
@@ -230,7 +230,7 @@ void __init early_init_devtree(void *params)
 	of_scan_flat_dt(xtensa_dt_io_area, NULL);
 
 	if (!command_line[0])
-		strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+		strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 }
 
 #endif /* CONFIG_USE_OF */
@@ -260,7 +260,7 @@ void __init init_arch(bp_tag_t *bp_start)
 
 #ifdef CONFIG_CMDLINE_BOOL
 	if (!command_line[0])
-		strlcpy(command_line, default_command_line, COMMAND_LINE_SIZE);
+		strscpy(command_line, default_command_line, COMMAND_LINE_SIZE);
 #endif
 
 	/* Early hook for platforms */
@@ -289,7 +289,7 @@ void __init setup_arch(char **cmdline_p)
 
 	*cmdline_p = command_line;
 	platform_setup(cmdline_p);
-	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 
 	/* Reserve some memory regions */
 
-- 
2.34.1

