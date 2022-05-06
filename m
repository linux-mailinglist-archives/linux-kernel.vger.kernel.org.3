Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674E751D779
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391769AbiEFMYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiEFMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:24:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F2C19009
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=DbI3NROzKgqky3q1EnQYQDCliSlXuhU9e8/qWo7OJHQ=; b=EdxRPWBW4RXtOVEqFsqqfyfIBL
        j5GX/5b82kjuEXEAT8ID/WHRkaIljtbzopgoLtMuGchE+Tdv971kEffQPNjE60PKBFMNO8um9ffTN
        mF0zXBur9qGZrbSZLxtgCwpBcvuUO/VopWZEBfUWqU+lwFssgV3aRebzugpTQ2w6WwB9xXD5DrFcT
        BvvsX7uQPa+4LW6J5L1twWjl9XFtQ9N+k3cEQHhxAIyIMeWASUa9LmTJGUrWhqN1rohVSmg+ixa6J
        923xLQIzfZjkSqPdg4U7QrOiztb7rQH7dc7VHNN6t7FaRNsx18nmG+lQNR5iQoxIKAYyZ0baTqcoE
        lfRs0o/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmwwU-00BfTY-AG; Fri, 06 May 2022 12:20:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 428E3300B80;
        Fri,  6 May 2022 14:20:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F20452026BB46; Fri,  6 May 2022 14:20:15 +0200 (CEST)
Message-ID: <20220506121631.437480085@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 06 May 2022 14:14:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, mark.rutland@arm.com
Subject: [PATCH 5/6] linkage: Fix issue with missing symbol size
References: <20220506121431.563656641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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


