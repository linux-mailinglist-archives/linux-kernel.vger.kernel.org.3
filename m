Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAC50FB47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349059AbiDZKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349285AbiDZKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:45:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C123201A3;
        Tue, 26 Apr 2022 03:35:42 -0700 (PDT)
Date:   Tue, 26 Apr 2022 10:35:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650969340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnEoxcZPIV50wEqSslZb+Yzb5QH9TDtGA2PniSIhmC0=;
        b=qj/GTbIM6pbxbMlgvvJzAczc/iCVR6V4n3/ExGLghXx9gQOXnW44XtzAc9kSjlU6n0mSws
        9WImxviXTHdXzAoCCpK3rYAA/O7J8+CZ8rPhnQXJg+UDhUL/ZHcXjnxo0VZA9nenh9vsXQ
        yFfz/JZPrFaKS7p5bv3xvjMV3l4stF5eXbQbulgNHvJzJ4NB3ZviHaQ2RsBNsqKZOkEa4r
        0CGz9mBA0seU97WDgFMTSDiXefu8S2vlHx81jGY2P4RHapDOUw7sodyU4s+iUdsy9uoH5J
        GTZ4nGJ+qKv+j97V52K7GRsXLWU/k9oJXe+YRIndGrfDjusXJt6pTyme9oTNLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650969340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnEoxcZPIV50wEqSslZb+Yzb5QH9TDtGA2PniSIhmC0=;
        b=YDy8mOXxkRf3jAakcO7jsd3rgJqhLpee95HjjhVqUXfaaD08Vzxl7gr8NMIBFrcFYbS75F
        DJLK0RHJIXhC8YBg==
From:   "tip-bot2 for Shida Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] bug: Have __warn() prototype defined unconditionally
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shida Zhang <zhangshida@kylinos.cn>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220426032007.510245-1-starzhangzsd@gmail.com>
References: <20220426032007.510245-1-starzhangzsd@gmail.com>
MIME-Version: 1.0
Message-ID: <165096933899.4207.3847577381859492159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1fa568e26f001e951b634d62ef3accdc80a87c7b
Gitweb:        https://git.kernel.org/tip/1fa568e26f001e951b634d62ef3accdc80a=
87c7b
Author:        Shida Zhang <zhangshida@kylinos.cn>
AuthorDate:    Tue, 26 Apr 2022 11:20:07 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Apr 2022 10:59:57 +02:00

bug: Have __warn() prototype defined unconditionally

The __warn() prototype is declared in CONFIG_BUG scope but the function
definition in panic.c is unconditional. The IBT enablement started using
it unconditionally but a CONFIG_X86_KERNEL_IBT=3Dy, CONFIG_BUG=3Dn .config
will trigger a

  arch/x86/kernel/traps.c: In function =E2=80=98__exc_control_protection=E2=
=80=99:
  arch/x86/kernel/traps.c:249:17: error: implicit declaration of function \
  	  =E2=80=98__warn=E2=80=99; did you mean =E2=80=98pr_warn=E2=80=99? [-Werr=
or=3Dimplicit-function-declaration]

Pull up the declarations so that they're unconditionally visible too.

  [ bp: Rewrite commit message. ]

Fixes: 991625f3dd2c ("x86/ibt: Add IBT feature, MSR and #CP handling")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220426032007.510245-1-starzhangzsd@gmail.com
---
 include/asm-generic/bug.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index edb0e2a..ba1f860 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -21,6 +21,12 @@
 #include <linux/panic.h>
 #include <linux/printk.h>
=20
+struct warn_args;
+struct pt_regs;
+
+void __warn(const char *file, int line, void *caller, unsigned taint,
+	    struct pt_regs *regs, struct warn_args *args);
+
 #ifdef CONFIG_BUG
=20
 #ifdef CONFIG_GENERIC_BUG
@@ -110,11 +116,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt=
, ...);
 #endif
=20
 /* used internally by panic.c */
-struct warn_args;
-struct pt_regs;
-
-void __warn(const char *file, int line, void *caller, unsigned taint,
-	    struct pt_regs *regs, struct warn_args *args);
=20
 #ifndef WARN_ON
 #define WARN_ON(condition) ({						\
