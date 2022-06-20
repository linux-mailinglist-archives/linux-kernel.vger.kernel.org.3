Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D16552816
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347498AbiFTXR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346469AbiFTXRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:17:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED5193E5;
        Mon, 20 Jun 2022 16:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 733C3B81648;
        Mon, 20 Jun 2022 23:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30992C341C4;
        Mon, 20 Jun 2022 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766810;
        bh=9VTbdq8Y3NJlRy422lvZmfminBhIB8cPZE0sibkpfZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0Bze04vMI8UvYDC1xb7N9YZJI8T5VDvIzOzoqAFF90fkBIL5m3IIGeGUqD/LVB3W
         hk50cugR5BIBMFv2CJgq/D4iopfHgT9/wqEomOvLrLmwHUK5aKTAoGoOcqcq3tR7VH
         u2mxDfnGW5EEOaNUdJH2DbT7koe5Xlz8+AccSErJFdPj1u3HlTVyeCMLz2suTQ/BPN
         mkckQY+KBOieO+D8qTGi77fiu9w+/g4kKwQD1FziXPDMsM1vL5Kx4N8qIt78LWozWy
         2cFgxMGv5IFmMNJtQJjDN6c0Vgz1XWKifVpVxAOYst9LpKv21an6mKj/s1fmmToCz7
         prjMQGuaqcNbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD74D5C05C8; Mon, 20 Jun 2022 16:13:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/5] tools/nolibc/stdio: Add format attribute to enable printf warnings
Date:   Mon, 20 Jun 2022 16:13:25 -0700
Message-Id: <20220620231328.3845126-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231325.GA3845036@paulmck-ThinkPad-P17-Gen-1>
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
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 15dedf8d0902d..a3cebc4bc3ac4 100644
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
2.31.1.189.g2e36527f23

