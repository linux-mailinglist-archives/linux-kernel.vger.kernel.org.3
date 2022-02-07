Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1952D4AC5A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382226AbiBGQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389773AbiBGQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:56 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD5CFC0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:53 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOfEK014416;
        Mon, 7 Feb 2022 17:24:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 32/42] tools/nolibc: move exported functions to their own section
Date:   Mon,  7 Feb 2022 17:23:44 +0100
Message-Id: <20220207162354.14293-33-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions like raise() and memcpy() are permanently exported because
they're needed by libgcc on certain platforms. However most of the time
they are not needed and needlessly take space.

Let's move them to their own sub-section, called .text.nolibc_<function>.
This allows ld to get rid of them if unused when passed --gc-sections.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 2 +-
 tools/include/nolibc/string.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 4cc1fdf6791e..da08ff30c15a 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -314,7 +314,7 @@ int msleep(unsigned int msecs)
 }
 
 /* This one is not marked static as it's needed by libgcc for divide by zero */
-__attribute__((weak,unused))
+__attribute__((weak,unused,section(".text.nolibc_raise")))
 int raise(int signal)
 {
 	return sys_kill(sys_getpid(), signal);
diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index c550c9ba8f4c..c1661589cb3c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -69,7 +69,7 @@ void *memmove(void *dst, const void *src, size_t len)
 }
 
 /* must be exported, as it's used by libgcc on ARM */
-__attribute__((weak,unused))
+__attribute__((weak,unused,section(".text.nolibc_memcpy")))
 void *memcpy(void *dst, const void *src, size_t len)
 {
 	return _nolibc_memcpy_up(dst, src, len);
-- 
2.35.1

