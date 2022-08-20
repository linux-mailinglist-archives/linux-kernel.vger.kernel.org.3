Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0598659B067
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiHTUZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiHTUZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:25:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E88F27CEC
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TNcLUG25D61wsd+8AYGkA+nwMhh+5ggO2Q1NQOH9X3o=; b=axpdxv1ZCZbm8Si5Ve9f9bLhtW
        jjSE2yum/9uv+RAQkOEq4MIP9V5yb8J55pATLNFjrfLPFkXHEBpNhSNTe7XVn4hSoQGWrd6h1Lm8m
        0r08gfDY5F9vPPIXXfsDJUTCv329BnH51/CvBrbqnyoJLQUhKzmPSqycGsJj51Kwuhe0uQ+uHiwzn
        o6UwYRkkcJIfJR1iGEmYrtdJP4j36cE9n3w5/MYGgCyhX2SKXn/T5vxZIORXbS/orJmuheV+QyLOE
        0E8gk+0JsdYR5J9v5UR/Z6aEA1bI8RkjZ3irPYX6bt5ne4qaZx7EJV0AkwUqwoT3Dsuo3+rzyq6KA
        h9Efgyrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPV1y-006TGP-F5;
        Sat, 20 Aug 2022 20:25:18 +0000
Date:   Sat, 20 Aug 2022 21:25:18 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tomoyo: use vsnprintf() properly
Message-ID: <YwFDLhioFG5Mlwws@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idiomatic way to find how much space sprintf output would take is
	len = snprintf(NULL, 0, ...) + 1;
Once upon a time there'd been libc implementations that blew chunks
on that and somebody had come up with the following "cute" trick:
	len = snprintf((char *) &len, 1, ...) + 1;
for doing the same.  However, that's unidiomatic, harder to follow
*and* any such libc implementation would violate both C99 and POSIX
(since 2001).
	IOW, this kludge is best buried along with such libc implementations,
nevermind getting cargo-culted into newer code.  Our vsnprintf() does not
suffer that braindamage, TYVM.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/tomoyo/audit.c  | 2 +-
 security/tomoyo/common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/tomoyo/audit.c b/security/tomoyo/audit.c
index 023bedd9dfa3..7cf8fdbb29bf 100644
--- a/security/tomoyo/audit.c
+++ b/security/tomoyo/audit.c
@@ -423,7 +423,7 @@ void tomoyo_write_log(struct tomoyo_request_info *r, const char *fmt, ...)
 	int len;
 
 	va_start(args, fmt);
-	len = vsnprintf((char *) &len, 1, fmt, args) + 1;
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
 	va_end(args);
 	va_start(args, fmt);
 	tomoyo_write_log2(r, len, fmt, args);
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index ff17abc96e5c..f4cd9b58b205 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2057,7 +2057,7 @@ int tomoyo_supervisor(struct tomoyo_request_info *r, const char *fmt, ...)
 	bool quota_exceeded = false;
 
 	va_start(args, fmt);
-	len = vsnprintf((char *) &len, 1, fmt, args) + 1;
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
 	va_end(args);
 	/* Write /sys/kernel/security/tomoyo/audit. */
 	va_start(args, fmt);
-- 
2.30.2

