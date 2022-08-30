Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2225A5871
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 02:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiH3Abc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 20:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiH3Ab3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:31:29 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3904975CDD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 17:31:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661819486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUKknEowQ297ey9ox+7usZjOfMBuR2vI5eXDapBFL+Q=;
        b=TXOr2sYAMczVrpw1D+dvj/vjSc44jSMNKpocS2Ta4wUZsCLWg/SQbJAeAXOrtNy82GLv0/
        rb/dDiEZeR1w8O5dy0yKBD+EvwYDJ7Yw5WtI6UeojT+FpcDgswLDFTDAKkOf3ofAOYzx15
        sqGvYdEai9fp13w0gV1pKPAZte5cy64=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] lib/test_printf.c: Add ip6 tests
Date:   Mon, 29 Aug 2022 20:31:18 -0400
Message-Id: <20220830003119.1793219-2-kent.overstreet@linux.dev>
In-Reply-To: <20220830003119.1793219-1-kent.overstreet@linux.dev>
References: <20220830003119.1793219-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds missing tests for ip6 address: both bare address and
sockaddr_in6, as well as the additional flags for compressed address,
port, scope and flow.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 4bd15a593f..6a56dbf076 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -18,6 +18,7 @@
 #include <linux/dcache.h>
 #include <linux/socket.h>
 #include <linux/in.h>
+#include <linux/in6.h>
 
 #include <linux/gfp.h>
 #include <linux/mm.h>
@@ -61,6 +62,9 @@ do_test(int bufsize, const char *expect, int elen,
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d\n",
 			bufsize, fmt, ret, elen);
 		return 1;
+		pr_warn("vsnprintf(buf, %d, \"%s\", ...) returned %d, expected %d (%s != %s)\n",
+			bufsize, fmt, ret, elen, test_buffer, expect);
+		return 1;
 	}
 
 	if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {
@@ -452,6 +456,31 @@ ip4(void)
 static void __init
 ip6(void)
 {
+	struct sockaddr_in6 sa = { .sin6_family = AF_INET6 };
+
+	sa.sin6_port			= cpu_to_be16(12345);
+	sa.sin6_addr.in6_u.u6_addr16[0]	= cpu_to_be16(1);
+	sa.sin6_addr.in6_u.u6_addr16[1]	= cpu_to_be16(2);
+	sa.sin6_addr.in6_u.u6_addr16[6]	= cpu_to_be16(7);
+	sa.sin6_addr.in6_u.u6_addr16[7]	= cpu_to_be16(8);
+	sa.sin6_flowinfo		= cpu_to_be32(8008);
+	sa.sin6_scope_id		= 4004;
+
+	test("00010002000000000000000000070008",		"%pi6", &sa.sin6_addr);
+	test("00010002000000000000000000070008",		"%piS", &sa);
+	test("0001:0002:0000:0000:0000:0000:0007:0008",		"%pI6", &sa.sin6_addr);
+	test("0001:0002:0000:0000:0000:0000:0007:0008",		"%pIS", &sa);
+	test("1:2::7:8",					"%pISc", &sa);
+
+	test("[0001:0002:0000:0000:0000:0000:0007:0008]:12345",	"%pISp", &sa);
+	test("[0001:0002:0000:0000:0000:0000:0007:0008]%4004",	"%pISs", &sa);
+	test("[0001:0002:0000:0000:0000:0000:0007:0008]/8008",	"%pISf", &sa);
+
+	test("[1:2::7:8]:12345",				"%pIScp", &sa);
+	test("[1:2::7:8]%4004",					"%pIScs", &sa);
+	test("[1:2::7:8]/8008",					"%pIScf", &sa);
+
+	test("[1:2::7:8]:12345/8008%4004",			"%pIScpsf", &sa);
 }
 
 static void __init
-- 
2.36.1

