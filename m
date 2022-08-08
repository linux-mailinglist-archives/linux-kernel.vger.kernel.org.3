Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F06058C1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiHHCml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiHHCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D6B2195
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a3gw8T2wmTsMaOixEBYK8gncqlwLvCu6/33p0qCLa04=; b=bnqPuJaktKpPDB2PsSxP8w75YI
        Kmaoz5QEXu7/3vSjhh9wcJmljO7wjGgkCCs+tmtwvj1aQPhrPP8SsH9BGV2e6cIANJKzo/ZjvJPLN
        3CiUpRrXWYd1j+tXC6EPGp29kbBOJY2CiRneABJXeR/wYfhvT1PaWXVcHuVmNmKxP7KQiaQtAQckn
        QiGJPajg6oCE+lDTqXuNh4pJsHDTYMmtUPxD/q+gkI+rXOqxLQLjt4O2RUvctZabO0nZ5/rS2iKBK
        /tOEIF29Bkbznx0TzBa8dh9/n3QJw8pJJOr6Wrr/xKrdb/Ma1hCsyqxfYxofxn821CaqY+uTlDNY2
        62r6pa1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshx-00DVRl-I8; Mon, 08 Aug 2022 02:41:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 11/32] test_printf: Drop requirement that sprintf not write past nul
Date:   Mon,  8 Aug 2022 03:41:07 +0100
Message-Id: <20220808024128.3219082-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

The current test code checks that sprintf never writes past the
terminating nul. This is a rather strange requirement, completely
separate from writing past the end of the buffer, which of course we
can't do: writing anywhere to the buffer passed to snprintf, within size
of course, should be perfectly fine.

Since this check has no documentation as to where it comes from or what
depends on it, and it's getting in the way of further refactoring
(printf_spec handling is right now scattered massively throughout the
code, and we'd like to consolidate it) - delete it.

Also, many current pretty-printers building up their output on the
stack, and then copy it to the actual output buffer - by eliminating
this requirement we can kill those extra buffers.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 4bd15a593fbd..da91301eae50 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -84,12 +84,6 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
-		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
-			bufsize, fmt);
-		return 1;
-	}
-
 	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
 		return 1;
-- 
2.35.1

