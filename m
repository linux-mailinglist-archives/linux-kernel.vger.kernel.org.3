Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032E652DB16
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbiESRV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242539AbiESRVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:21:50 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C647EA205D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:21:49 -0700 (PDT)
Received: from integral2.. (unknown [180.242.99.67])
        by gnuweeb.org (Postfix) with ESMTPSA id 6CFA17E46C;
        Thu, 19 May 2022 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1652980909;
        bh=U+32yynyQuIUhRnsYtaxv6b9DYu44J416tkLENqnFlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EW60Ay+9+/uG7TipPtUBtVq+c9U3PA8bNcrfVDF6vIT/QTXkb6KGnF5RgyOJgoaBC
         HaJ+nuWxSScNhZjpRK9Ufmo6f/DvfJ8qvlj1zoV5qtfnXh6+mojxEqxSWoiS7Fnuud
         swCOWOfBMDFFJOI+EiGz/vMK7JJsneHIDFTt3paUfce64yiTbV39x9WuW+9nHfb0ya
         uq1JW9EEliKT9HfLg7cuOBzt8sW4rqSu3oS4o9oUqL7bxNZrnNR9XdQKKja2SRoIX8
         iVVnZiSxlfqsKsDFW66E/G0wRHZPPyQj5N/j7q8E/1g8JUO84kXlKmTRqYMw0HyjA2
         rx/sPmqALsbEg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Facebook Kernel Team <kernel-team@fb.com>
Subject: [PATCH v1 2/2] tools/nolibc/stdio: Add format attribute to enable printf warnings
Date:   Fri, 20 May 2022 00:21:16 +0700
Message-Id: <20220519172116.283687-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
References: <20220519172116.283687-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

When we use printf and fprintf functions from the nolibc, we don't
get any warning from the compiler if we have the wrong arguments.
For example, the following calls will compile silently:
```
  printf("%s %s\n", "aaa");
  fprintf(stdout, "%s %s\n", "xxx", 1);
```
(Note the wrong arguments).

Those calls are undefined behavior. The compiler can help us warn
about the above mistakes by adding a `printf` format attribute to
those functions declaration. This patch adds it, and now it yields
these warnings for those mistakes:
```
  warning: format `%s` expects a matching `char *` argument [-Wformat=]
  warning: format `%s` expects argument of type `char *`, but argument 4 has type `int` [-Wformat=]
```

  [ ammarfaizi2: Simplify the attribute placement. ]

Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/stdio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 15dedf8d0902..a3cebc4bc3ac 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -273,7 +273,7 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 	return written;
 }
 
-static __attribute__((unused))
+static __attribute__((unused, format(printf, 2, 3)))
 int fprintf(FILE *stream, const char *fmt, ...)
 {
 	va_list args;
@@ -285,7 +285,7 @@ int fprintf(FILE *stream, const char *fmt, ...)
 	return ret;
 }
 
-static __attribute__((unused))
+static __attribute__((unused, format(printf, 1, 2)))
 int printf(const char *fmt, ...)
 {
 	va_list args;
-- 
Ammar Faizi

