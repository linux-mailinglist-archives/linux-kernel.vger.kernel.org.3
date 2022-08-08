Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D51A58C1C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbiHHCn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbiHHClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EB25C7
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3nTy8qXUtiWwK0lkpgZkPPlVZYKOkb4CQCRiIBiqF8c=; b=VpQZmaPYMFsBUjC6WvDtekZH8C
        YSsZlzM2D3V9e5i+s/PW6VUHKYAy5S5ZYmgoaq58YZ/AqAUWR9+HWO0vrNCM5kVN+QTO5/4+6+KEY
        njEi1j9hXxBLU+joDPx7kB/pA+AnacjOw2jj8fi8GCb0GUiBpNtupvXXhZ0Y+2h81iS9p6KnMGIsl
        XBEN8qhvnDmh6TwB032v14BUyWiQLA0wbRiL0pVewLKkcgAZfbcxM4rKBeezyao1m01tyvV70DN7l
        W848IvKJ0rqI5j1AUExjUKhSkEcQGfpXXKdj/uL34ppYhmepBoHHpC+Q/hoI0Ux61r4/yQZj/MEh8
        R/y1HUKw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVRz-2u; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 18/32] vsprintf: flags_string() no longer takes printf_spec
Date:   Mon,  8 Aug 2022 03:41:14 +0100
Message-Id: <20220808024128.3219082-19-willy@infradead.org>
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

We're attempting to consolidate printf_spec and format string handling
in the top level vpr_buf(), this changes time_and_date() to not
take printf_spec.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/vsprintf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 784f7cb64926..38d16aa79e56 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1917,12 +1917,12 @@ void format_page_flags(struct printbuf *out, unsigned long flags)
 
 static noinline_for_stack
 void flags_string(struct printbuf *out, void *flags_ptr,
-		  struct printf_spec spec, const char *fmt)
+		  const char *fmt)
 {
 	unsigned long flags;
 	const struct trace_print_flags *names;
 
-	if (check_pointer_spec(out, flags_ptr, spec))
+	if (check_pointer(out, flags_ptr))
 		return;
 
 	switch (fmt[1]) {
@@ -1937,7 +1937,7 @@ void flags_string(struct printbuf *out, void *flags_ptr,
 		names = gfpflag_names;
 		break;
 	default:
-		return error_string_spec(out, "(%pG?)", spec);
+		return error_string(out, "(%pG?)");
 	}
 
 	return format_flags(out, flags, names);
@@ -2310,7 +2310,8 @@ void pointer(struct printbuf *out, const char *fmt,
 #endif
 
 	case 'G':
-		return flags_string(out, ptr, spec, fmt);
+		flags_string(out, ptr, fmt);
+		return do_width_precision(out, prev_pos, spec);
 	case 'O':
 		return device_node_string(out, ptr, spec, fmt + 1);
 	case 'f':
-- 
2.35.1

