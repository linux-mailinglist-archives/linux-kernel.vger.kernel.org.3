Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB664AC631
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbiBGQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390521AbiBGQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:35:00 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C75C0401E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:34:53 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOgET014428;
        Mon, 7 Feb 2022 17:24:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 42/42] tools/nolibc/stdlib: implement abort()
Date:   Mon,  7 Feb 2022 17:23:54 +0100
Message-Id: <20220207162354.14293-43-w@1wt.eu>
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

libgcc uses it for certain divide functions, so it must be exported. Like
for memset() we do that in its own section so that the linker can strip
it when not needed.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdlib.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index b46bebd48ba2..733105c574ee 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -23,6 +23,14 @@ static __attribute__((unused)) char itoa_buffer[21];
  * As much as possible, please keep functions alphabetically sorted.
  */
 
+/* must be exported, as it's used by libgcc for various divide functions */
+__attribute__((weak,unused,noreturn,section(".text.nolibc_abort")))
+void abort(void)
+{
+	sys_kill(sys_getpid(), SIGABRT);
+	for (;;);
+}
+
 static __attribute__((unused))
 long atol(const char *s)
 {
-- 
2.35.1

