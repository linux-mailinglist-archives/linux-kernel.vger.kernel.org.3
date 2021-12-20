Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65E547A5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbhLTIR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:17:57 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:30871 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231406AbhLTIR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:17:56 -0500
X-QQ-mid: bizesmtp50t1639988262tvk1z43j
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 16:17:40 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: xoS364mEyr0ncuboHM9m7loKAPQJFzQty1PSKk5qn/G3DApA3q1+EbdTHpgpr
        305N4cZmVXyestbkOPLM+Ru0nWaxFCMEI5kCK/SM22/7AQU+RW6NGTafx7frDLNYslkgetJ
        Im8ypvINB28J30dZzGiWgL1FpGYWWjxlBM58WsVHPlfd4WOeNk5ZwPzk/Nzax8OijpHk8Io
        XwB7SNnMzxz4IzC6uyRe2s5/JslH/ciDSfl4aAOm2R/zmCCmKQusoZs01w8DitV90CxVZu9
        vTDGRtShPLcH2EIrDch2hE7gSlpsSZakJMU8GTrSVAyvrLueVaT+mkw25hmLHrgnnW/5Rfj
        xLTWYczDKkbEDyG1Ju7Oxa/BRyuMJOJ9a74cOOdIMWyX9sdomA=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     viro@zeniv.linux.org.uk, wangborong@cdjrlc.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 16:17:29 +0800
Message-Id: <20211220081729.918843-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
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
 arch/sparc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 48abee4eee29..6546ca9d4d3f 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -636,7 +636,7 @@ void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	boot_flags_init(*cmdline_p);
-- 
2.34.1

