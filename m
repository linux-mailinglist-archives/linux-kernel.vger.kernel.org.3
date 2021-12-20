Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6A47A640
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhLTIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:50:29 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:35625 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238055AbhLTIu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:50:27 -0500
X-QQ-mid: bizesmtp49t1639990218tch2rppa
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 16:50:16 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: kdcyy7TwLBI8ssJiqQJra7hOsuSpfNxhauOhml6W9DnUPMOmriFf+ZXyEewfq
        fIYXFUEc/e0B2FekdsLejMfpePzK6uvwUVokFyJQjzHvPzGZ4B/ANx8rWiyHP/mi1p3udxG
        tBH+yiSFirmVFGpWruC+3S7xs7S2/qvkT4DhKSUUA4xTnOYhO0W+Wp8iMJF6Ds2ASfkfKwC
        5pgTvBv072ryFZRkIzmukIkXtSVuu2Z7sHvR3PIcjihpD52vSpXRuooiwYNvz78HHTkJcax
        dgZ10ywFvw3ndKwdgk/z3Mgmkqd97WvTksyGK4G3LjwI/XQU8TlF/akHUTH0EoPlyV54cIp
        Hz/dUT/qs5QMvJByHbT+GbqMw7M12UtPmIS7ZnDXir4CSKLhLpljZIVbPGOyA==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     bcain@codeaurora.org
Cc:     wangborong@cdjrlc.com, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 16:50:13 +0800
Message-Id: <20211220085013.959126-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
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
 arch/hexagon/kernel/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 1880d9beaf2b..621674e86232 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -66,9 +66,9 @@ void __init setup_arch(char **cmdline_p)
 		on_simulator = 0;
 
 	if (p[0] != '\0')
-		strlcpy(boot_command_line, p, COMMAND_LINE_SIZE);
+		strscpy(boot_command_line, p, COMMAND_LINE_SIZE);
 	else
-		strlcpy(boot_command_line, default_command_line,
+		strscpy(boot_command_line, default_command_line,
 			COMMAND_LINE_SIZE);
 
 	/*
@@ -76,7 +76,7 @@ void __init setup_arch(char **cmdline_p)
 	 * are both picked up by the init code. If no reason to
 	 * make them different, pass the same pointer back.
 	 */
-	strlcpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
+	strscpy(cmd_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	parse_early_param();
-- 
2.34.1

