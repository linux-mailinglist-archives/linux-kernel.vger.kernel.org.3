Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44DD537939
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiE3KjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiE3Ki4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1533E6B7CE;
        Mon, 30 May 2022 03:38:55 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYcZQb6y/XCkh2YYSGLSoheHoc4Pzjv7/7ozpxfJPoM=;
        b=XnvVP0CfJ8YSCNB5w5XDfbYNB7JJoBy4Pu0hKQBhfYXqRkJTn1kbaGowZ2jvufm2N2MM8c
        k9MC5SAXcHdiIQwbURIZEMyLvpq4/wqdYpIA0786vIcZgW9yuBKSIafAL4iOPPSgo6bIxF
        F4C3uDVeUAUzFCQPVGVZWeM924pOTE/3qEUw3ymIxYtNnLUA/kLZ+dkg3c/BFbl8AM4neR
        msVXH6OcujgAmwv+L9H9ryggLJ4vp0x9n/y43VsX269B8Z0IqefUBXr8p02jP2S7tp4mDr
        2IOTLorW+Ul9JRWckvh5NOuRTQYsrLU+yGuKKV0u2H92xLxMdLs9Oz2oH3n9FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYcZQb6y/XCkh2YYSGLSoheHoc4Pzjv7/7ozpxfJPoM=;
        b=C3LuBmTkUUQIR7wWtzvJ4Yh6tl4FvrCZsc7iHlgabT0PyNW/N7EuXAxq9pGFPWuy6n5qNX
        BJCg9FjFu3/Gc0AQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Add CONFIG_HAVE_UACCESS_VALIDATION
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d393d5e2fe73aec6e8e41d5c24f4b6fe8583f2d8.1650384225.git.jpoimboe@redhat.com>
References: <d393d5e2fe73aec6e8e41d5c24f4b6fe8583f2d8.1650384225.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165390713250.4207.16901240644447647410.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     5f3da8c08508df82823566c32f753071c8ad36af
Gitweb:        https://git.kernel.org/tip/5f3da8c08508df82823566c32f753071c8ad36af
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 19 Apr 2022 09:05:09 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:43 +02:00

objtool: Add CONFIG_HAVE_UACCESS_VALIDATION

Allow an arch specify that it has objtool uaccess validation with
CONFIG_HAVE_UACCESS_VALIDATION.  For now, doing so unconditionally
selects CONFIG_OBJTOOL.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d393d5e2fe73aec6e8e41d5c24f4b6fe8583f2d8.1650384225.git.jpoimboe@redhat.com
---
 arch/Kconfig            | 4 ++++
 arch/x86/Kconfig        | 1 +
 scripts/Makefile.build  | 2 +-
 scripts/link-vmlinux.sh | 4 +++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 904ed51..cb29540 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1050,6 +1050,10 @@ config HAVE_NOINSTR_HACK
 config HAVE_NOINSTR_VALIDATION
 	bool
 
+config HAVE_UACCESS_VALIDATION
+	bool
+	select OBJTOOL
+
 config HAVE_STACK_VALIDATION
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cf531fb..5f41f3c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -258,6 +258,7 @@ config X86
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 0640050..6a663b2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -218,7 +218,7 @@ objtool_args =								\
 	$(if $(CONFIG_SLS), --sls)					\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
-	--uaccess							\
+	$(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)		\
 	$(if $(linked-object), --link)					\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a7f6196..fd578c3 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -134,7 +134,9 @@ objtool_link()
 			objtoolopt="${objtoolopt} --static-call"
 		fi
 
-		objtoolopt="${objtoolopt} --uaccess"
+		if is_enabled CONFIG_HAVE_UACCESS_VALIDATION; then
+			objtoolopt="${objtoolopt} --uaccess"
+		fi
 	fi
 
 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
