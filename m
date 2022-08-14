Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89643592697
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbiHNVWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiHNVVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:44 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC66A46D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buF7wG/i3eq2IPWWvoBgGDXocR1Q8NCknRivAQ1Ll1g=;
        b=TV+NS48CapsHemM8V7WI1qIBmzG8+Tu0ipLaGkPw79t2NaUhvacla0PDb/D//mt33vW81b
        eSY8ChEqQ8nsNEFe/AhB50kxPm89F7Qp+kMqdNCTr+KkNQra8GU8ceLPO4H7p/hZdGxX3e
        SpRuxpsrWIoMYgFdNKv9YcB9QBElH7U=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 18/32] vsprintf: flags_string() no longer takes printf_spec
Date:   Sun, 14 Aug 2022 17:19:57 -0400
Message-Id: <20220814212011.1727798-19-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
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
index 8154beae12..df954902a1 100644
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
2.36.1

