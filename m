Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3907D4AC58E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347961AbiBGQ3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389692AbiBGQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:08 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BFDCC0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:07 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOg9S014427;
        Mon, 7 Feb 2022 17:24:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 41/42] tools/nolibc: also mention how to build by just setting the include path
Date:   Mon,  7 Feb 2022 17:23:53 +0100
Message-Id: <20220207162354.14293-42-w@1wt.eu>
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

Now that a few basic include files are provided, some simple portable
programs may build, which will save them from having to surround their
includes with #ifndef NOLIBC. This patch mentions how to proceed, and
enumerates the list of files that are covered.

A comprehensive list of required include files is available here:

  https://en.cppreference.com/w/c/header

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 561dcdb83cee..b2bc48d3cfe4 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -57,22 +57,32 @@
  * having to specify anything.
  *
  * Finally some very common libc-level functions are provided. It is the case
- * for a few functions usually found in string.h, ctype.h, or stdlib.h. Nothing
- * is currently provided regarding stdio emulation.
+ * for a few functions usually found in string.h, ctype.h, or stdlib.h.
  *
- * The macro NOLIBC is always defined, so that it is possible for a program to
- * check this macro to know if it is being built against and decide to disable
- * some features or simply not to include some standard libc files.
- *
- * Ideally this file should be split in multiple files for easier long term
- * maintenance, but provided as a single file as it is now, it's quite
- * convenient to use. Maybe some variations involving a set of includes at the
- * top could work.
+ * The nolibc.h file is only a convenient entry point which includes all other
+ * files. It also defines the NOLIBC macro, so that it is possible for a
+ * program to check this macro to know if it is being built against and decide
+ * to disable some features or simply not to include some standard libc files.
  *
  * A simple static executable may be built this way :
  *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
  *            -static -include nolibc.h -o hello hello.c -lgcc
  *
+ * Simple programs meant to be reasonably portable to various libc and using
+ * only a few common includes, may also be built by simply making the include
+ * path point to the nolibc directory:
+ *      $ gcc -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+ *            -I../nolibc -o hello hello.c -lgcc
+ *
+ * The available standard (but limited) include files are:
+ *   ctype.h, errno.h, signal.h, stdio.h, stdlib.h, string.h, time.h
+ *
+ * In addition, the following ones are expected to be provided by the compiler:
+ *   float.h, stdarg.h, stddef.h
+ *
+ * The following ones which are part to the C standard are not provided:
+ *   assert.h, locale.h, math.h, setjmp.h, limits.h
+ *
  * A very useful calling convention table may be found here :
  *      http://man7.org/linux/man-pages/man2/syscall.2.html
  *
-- 
2.35.1

