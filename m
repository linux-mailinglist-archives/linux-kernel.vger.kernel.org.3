Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA451453C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356421AbiD2JWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356405AbiD2JW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:22:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7EC42DC;
        Fri, 29 Apr 2022 02:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OF6k5PLv2VCqzzZahe8Cbkn92KRWSJ1Zt5uYtTCu38Q=; b=hE8hNE3kc3bg9qa7QMSsxL5tV0
        UNdIypjbAUqso3xZLfPQqukCG+SlBrI5NWTggQc9FrUAJh3P97NyR7Rvj3bi7+YTO/gs8zxz7+2Ux
        JZbwf9dTgMpJN160hPpkNLvlYzWs1MVZIvw3wH1etdypNtCdGIIrN6xkHkQQLRN5P1Q/c85AAyhSP
        nM0vnRo5goCbb2iVwl8rDkHB79nppxFfRhIcM4fIoCwjmOixedWTH7mtWd+QVZ5YwQbRFNp5Glr8J
        RAmBT4MhgHWxNyUmI26Qcy9xc2ipUsZzmBwMoCrWave2NhzAg3cms9DgiK8jxzoJdl/DVOk/U55hq
        hfmj11AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkMmD-00CGsu-9Y; Fri, 29 Apr 2022 09:19:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7124998038F; Fri, 29 Apr 2022 11:18:59 +0200 (CEST)
Date:   Fri, 29 Apr 2022 11:18:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-toolchains@vger.kernel.org
Subject: [PATCH] linkage: Fix issue with missing symbol size
Message-ID: <20220429091859.GS2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Occasionally, typically when a function doesn't end with 'ret', an
alias on that function will have 0 size.

The difference between what GCC generates and our linkage magic, is
that GCC doesn't appear to provide .size for the alias'ed symbol at
all. And indeed, removing this directive cures the issue.

Additionally, GCC also doesn't emit .type for alias symbols either, so
also omit that.

Fixes: e0891269a8c2 ("linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()")
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/linkage.h |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -171,12 +171,9 @@
 
 /* SYM_ALIAS -- use only if you have to */
 #ifndef SYM_ALIAS
-#define SYM_ALIAS(alias, name, sym_type, linkage)			\
-	linkage(alias) ASM_NL						\
-	.set alias, name ASM_NL						\
-	.type alias sym_type ASM_NL					\
-	.set .L__sym_size_##alias, .L__sym_size_##name ASM_NL		\
-	.size alias, .L__sym_size_##alias
+#define SYM_ALIAS(alias, name, linkage)			\
+	linkage(alias) ASM_NL				\
+	.set alias, name ASM_NL
 #endif
 
 /* === code annotations === */
@@ -261,7 +258,7 @@
  */
 #ifndef SYM_FUNC_ALIAS
 #define SYM_FUNC_ALIAS(alias, name)					\
-	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_GLOBAL)
+	SYM_ALIAS(alias, name, SYM_L_GLOBAL)
 #endif
 
 /*
@@ -269,7 +266,7 @@
  */
 #ifndef SYM_FUNC_ALIAS_LOCAL
 #define SYM_FUNC_ALIAS_LOCAL(alias, name)				\
-	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_LOCAL)
+	SYM_ALIAS(alias, name, SYM_L_LOCAL)
 #endif
 
 /*
@@ -277,7 +274,7 @@
  */
 #ifndef SYM_FUNC_ALIAS_WEAK
 #define SYM_FUNC_ALIAS_WEAK(alias, name)				\
-	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_WEAK)
+	SYM_ALIAS(alias, name, SYM_L_WEAK)
 #endif
 
 /* SYM_CODE_START -- use for non-C (special) functions */

