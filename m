Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842A85A5872
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiH3Abh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiH3Aba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 20:31:30 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8423C75CCC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 17:31:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661819487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWDIc2cSTkE7bXhmvmfBPIaMU5Y6v2mHRxR3rrRGqTE=;
        b=OzgBcSvCqESLn+1z3kf9BYDH9NgZyBBAqr7lYg/zEeKbkHYN5KqLZJjqJndrn+6iJOeld1
        HdxyyNgp3SK+D0FWuXaHN/6YF2AJrRyPVj7EFn3ooi7b7OxbYRPH4sNWHgC3ymNPl+Gii3
        P6LXbktJpTZFQR++d+vBHbMh1Uv4jFA=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/2] lib/test_printf.c: Add escaped string tests
Date:   Mon, 29 Aug 2022 20:31:19 -0400
Message-Id: <20220830003119.1793219-3-kent.overstreet@linux.dev>
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

This adds missing tests for %pE, escaped strings.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 6a56dbf076..247b1adbbe 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -413,6 +413,21 @@ addr(void)
 static void __init
 escaped_str(void)
 {
+	const char buf[] = "test \f\n\r\t\v \"\\\a\e \0 end";
+	unsigned n = strlen(buf), with_embedded_nul = sizeof(buf) - 1;
+
+	/* ESCAPE_ANY_NP: */
+	test("test \\f\\n\\r\\t\\v \"\\\\a\\e ",	"%*pE",  n, buf);
+	/* ESCAPE_ANY: */
+	//test("test \\f\\n\\r\\t\\v \"\\\\a\\e end",	"%*pEa",  n, buf);
+	/* ESCAPE_SPACE: */
+	test("test \\f\\n\\r\\t\\v \"\\\x07\x1b ",	"%*pEs", n, buf);
+
+	/* ESCAPE_SPECIAL: */
+	test("test \f\n\r\t\v \\\"\\\\\\a\\e ",		"%*pEc", n, buf);
+
+	/* ESCAPE_NULL: */
+	test("test \f\n\r\t\v \"\\\a\e \\0 end",	"%*pEn", with_embedded_nul, buf);
 }
 
 static void __init
-- 
2.36.1

