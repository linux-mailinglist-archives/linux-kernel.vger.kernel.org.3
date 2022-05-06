Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB551DB93
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442689AbiEFPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbiEFPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:12:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738A76D186;
        Fri,  6 May 2022 08:09:02 -0700 (PDT)
Date:   Fri, 06 May 2022 15:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651849740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/qm1Bgbdk5jyG9MGcq9sDGLukQ9iArUnuXSvy4egIc=;
        b=m+Qo+sBTPmjaGhb60phEr1893lTkuNvKMQPAFBWm6TJL8yAs3mcM8WWtfWDLY5Gqx4Ekhu
        crPkhjHPlNuiqkxq5sbfP6pH8pUHs0wvh6DWstpR9FmOhO++wH9lrUf1W6bU8SnZ0du/Fl
        Wf9dCTncffObBQkQjEuTa59RvbDN3c5joVsbsDxqSoFx/zrVRLWie3TTjwerIcWf5/EEu1
        N1pg/eJ+ZQS0sLQqWh0WVDo4JcCEmaYfRD903Hsy62mIHl9gUczc1/BtsHCN7BgcXb/1kz
        2nq7NgM2vpTxm6PIS3LXdwiGHb4Uw8HvKUchSAqb1345o2p84Cj8c+cODeUe7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651849740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/qm1Bgbdk5jyG9MGcq9sDGLukQ9iArUnuXSvy4egIc=;
        b=Idx+gpsAKxtbuSf+OATzFnsUzpu/J/U2nj9ZQDUuiq5GIo/CJu+Zy2hQ0tCbnp2qZ/jMjr
        FQq3FD0YHtONTdCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] linkage: Fix issue with missing symbol size
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.437480085@infradead.org>
References: <20220506121631.437480085@infradead.org>
MIME-Version: 1.0
Message-ID: <165184973961.4207.4733734646878690141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     3ff5f7840979aa36d47a6a00694826c78d63bf3c
Gitweb:        https://git.kernel.org/tip/3ff5f7840979aa36d47a6a00694826c78d63bf3c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 May 2022 14:14:36 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 May 2022 15:59:39 +02:00

linkage: Fix issue with missing symbol size

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220506121631.437480085@infradead.org
---
 include/linux/linkage.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index acb1ad2..1feab61 100644
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
