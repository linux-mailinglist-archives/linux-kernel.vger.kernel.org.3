Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD90B506144
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiDSAtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiDSApR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294C929CA5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 877066141B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A82CC34119;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=ZESxgMtm/TynkTOd56b8EQARVEB7blDLPa29zdfArME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YqTnWb1+Dfzn4jhUUOdP+dmpo5ZnI00hmkENba8B0hXdsO9Vl1ZOjrdrBgCktsR9d
         FgH94pRGQ6PS9xktgI/4BHrzXtRpd9OF74hrhYMbpWRyMscmO93JulGRPyQuY9zpM7
         nFFEHA9VSpk49DrQtxwirZmkfUAmLC/FVlTzakq1Fra1W1hF0jZ1vBrFTbyMBovnT5
         RqyE8Pw4LcjUCoB0P+tcrwc46gstGuEMn1fkNDtySJKC3641M4qyoXg/lTl0ULfIvq
         7ZgpTiWk+e60LhtZVxNHySh7FX0fElmMuUWo0dWAajDrBINVrPf6zNeaEMy/8nyrpn
         WFlKye6Qy3VQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51C9E5C322C; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 41/61] tools/nolibc: also mention how to build by just setting the include path
Date:   Mon, 18 Apr 2022 17:42:05 -0700
Message-Id: <20220419004225.3952530-41-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

Now that a few basic include files are provided, some simple portable
programs may build, which will save them from having to surround their
includes with #ifndef NOLIBC. This patch mentions how to proceed, and
enumerates the list of files that are covered.

A comprehensive list of required include files is available here:

  https://en.cppreference.com/w/c/header

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

