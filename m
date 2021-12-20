Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEABA47A5E0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhLTITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:19:34 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:19826 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231147AbhLTITd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:19:33 -0500
X-QQ-mid: bizesmtp32t1639988363t3g0gigw
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 16:19:21 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: ZHPL5yNEtlkMlEtAlTXCD7MKTuPb3NRc04hFy/80o+vxDMQpLJApBCyyEtGCm
        FoYMjhUBkLP6D7MS9EdNS2JJ1d7Sp3Or/8YIQad+VCh+mFtvRf8Z6c7/0Nh8+7xjjE67AFr
        vBSy9Sb7Qt0Dgnaeafsq36uLbPFSCnnmrH8aVSGtNbwVuKCXfs0fdHjrNN89/empO1f45wT
        +ziL6crExfexa/K+5DBucDOGYzYoyoGqrMYuWsatWkdq2vdabbzHu/Ip0bKjOT/S8jVxQvG
        pkEOTGY13DPHXbcETULKFipVRZiYG85qYTIrgsrSEQz3l3F4RHVh2imfAz58jwFJFZ4pEhJ
        Yhp5g9Vj2jCE3t4Py+iYkzgfIT9oQryVin1elCQg5L6M2EBsKo=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     viro@zeniv.linux.org.uk, wangborong@cdjrlc.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 16:19:17 +0800
Message-Id: <20211220081917.922068-1-wangborong@cdjrlc.com>
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
 arch/sparc/kernel/setup_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index c8e0dd99f370..c3fd44b7fd1a 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -120,7 +120,7 @@ static struct console prom_early_console = {
 	.index =	-1,
 };
 
-/* 
+/*
  * Process kernel command line switches that are specific to the
  * SPARC or that require special low-level processing.
  */
@@ -302,7 +302,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strlcpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
+	strscpy(boot_command_line, *cmdline_p, COMMAND_LINE_SIZE);
 	parse_early_param();
 
 	boot_flags_init(*cmdline_p);
-- 
2.34.1

