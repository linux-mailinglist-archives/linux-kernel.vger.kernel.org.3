Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE84CD46D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiCDMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiCDMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:45:47 -0500
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00A18DA8A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:44:59 -0800 (PST)
Received: from localhost.localdomain ([106.133.34.209])
        by smtp.orange.fr with ESMTPA
        id Q7IYngFiVeKJJQ7IincR3J; Fri, 04 Mar 2022 13:44:57 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Fri, 04 Mar 2022 13:44:57 +0100
X-ME-IP: 106.133.34.209
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
Date:   Fri,  4 Mar 2022 21:44:16 +0900
Message-Id: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with -Wtype-limits (activated for example with make
W=2), GENMASK_INPUT_CHECK() will generate some warnings if invoked
with an unsigned integer and zero.

For example, this:

| #include <linux/bits.h>
| u32 foo(u32 bar)
| { return GENMASK(bar, 0); }

would yield:

| In file included from ./include/linux/bits.h:22,
|                  from ./foo.c:1:
| foo.c: In function 'foo':
| ./include/linux/bits.h:25:36: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
|    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
|       |                                    ^
| ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
|    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|       |                                                              ^
| ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
|    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
|       |                 ^~~~~~~~~~~~~~
| ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
|    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|       |          ^~~~~~~~~~~~~~~~~~~
| foo.c:16:10: note: in expansion of macro 'GENMASK'
|    16 | { return GENMASK(bar, 0); }
|       |          ^~~~~~~
| ./include/linux/bits.h:25:48: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
|    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
|       |                                                ^
| ./include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
|    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
|       |                                                              ^
| ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
|    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
|       |          ^~~~~~~~~~~~~~~~~~~
| foo.c:16:10: note: in expansion of macro 'GENMASK'
|    16 | { return GENMASK(bar, 0); }
|       |          ^~~~~~~

This pattern is harmless but because it occurs in header files
(example find_first_bit() from linux/find.h [1]) and because of the
include hell, the macro GENMASK_INPUT_CHECK() is accountable for 31%
(164714/532484) of all warnings when compiling all modules at W=2
level.

Reference (using gcc 11.2 and linux v5.17-rc6):

| $ make allyesconfig
| $ sed -i '/CONFIG_WERROR/d' .config
| $ make W=2 -j8 2> kernel_w2.log > /dev/null
| $ grep "\./include/linux/bits\.h:.*: warning" kernel_w2\.log | wc -l
| 164714
| $ grep ": warning: " kernel_w2.log | wc -l
| 532484

This heavily pollutes the output of make W=2 and make it painful to
find other relevant issues.

In this patch, we silent this warning by:

  * replacing the comparison > by and logical and && in the first
    argument of __builtin_choose_expr().

  * casting the high bit of the mask to a signed integer in the second
    argument of __builtin_choose_expr().

By doing so, 31% of W=2 warnings get removed.

[1] https://elixir.bootlin.com/linux/v5.17-rc6/source/include/linux/find.h#L119

Fixes: 295bcca84916 ("linux/bits.h: add compile time sanity check of
GENMASK inputs")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/bits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 87d112650dfb..542e9a8985b1 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -22,7 +22,7 @@
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
 	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__is_constexpr((l) > (h)), (l) > (h), 0)))
+		__is_constexpr((h)) && __is_constexpr((l)), (l) > (int)(h), 0)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.34.1

