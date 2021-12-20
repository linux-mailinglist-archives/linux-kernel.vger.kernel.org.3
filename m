Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3424C47A3E9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 04:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhLTD0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 22:26:45 -0500
Received: from smtpbg126.qq.com ([106.55.201.22]:42990 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233995AbhLTD0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 22:26:44 -0500
X-QQ-mid: bizesmtp38t1639970789tau23sx0
Received: from localhost.localdomain (unknown [118.121.67.96])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Dec 2021 11:26:27 +0800 (CST)
X-QQ-SSF: 01000000002000D0K000B00A0000000
X-QQ-FEAT: WGgATWfafh560fyrqOc26y4jR9QpUqCbeKlhvkrBAB3v+HIO3RE+uBsqWpNv/
        +qYkPjeI7VXJEOj+if1jePWkHYOsI7rihNugCJq5ncXvS+30INt/QyhEfWYcVnTs49TH3Xe
        GvEWh+OEs8Z6b4uUBb34g0RbT1qI62izkRgwL2c8W/g/1qj0vbOEHhODFwbMEtVUU1ZjTNz
        A/C4qLVawZ737m7KQSY72ZWCUnDLQ35R870J0OUz7zdc5vHUEU12F007shEtFT/PonnWnLm
        I+CtNavQFd0B1nPwNQDLLoVFLo71mgPuEQVegOj1T2zjO10+sGQPeGDaJTJbrN0zrwn7/Nh
        pw5y/xNLh+NSY80bhWXj8jrV+c3V37uoV3lPn82
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     wangborong@cdjrlc.com, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: use strscpy to copy strings
Date:   Mon, 20 Dec 2021 11:26:23 +0800
Message-Id: <20211220032623.634463-1-wangborong@cdjrlc.com>
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
 arch/sparc/prom/bootstr_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
index e3b731ff00f0..1c7cd258b0dc 100644
--- a/arch/sparc/prom/bootstr_32.c
+++ b/arch/sparc/prom/bootstr_32.c
@@ -52,7 +52,7 @@ prom_getbootargs(void)
 		 * V3 PROM cannot supply as with more than 128 bytes
 		 * of an argument. But a smart bootstrap loader can.
 		 */
-		strlcpy(barg_buf, *romvec->pv_v2bootargs.bootargs, sizeof(barg_buf));
+		strscpy(barg_buf, *romvec->pv_v2bootargs.bootargs, sizeof(barg_buf));
 		break;
 	default:
 		break;
-- 
2.34.1

