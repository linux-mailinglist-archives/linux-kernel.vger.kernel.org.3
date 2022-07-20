Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD1C57BEE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiGTTzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGTTzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95D9BCB2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7098061B68
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1767C3411E;
        Wed, 20 Jul 2022 19:55:08 +0000 (UTC)
Date:   Wed, 20 Jul 2022 15:55:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] lkdtm: Keep the rodata test from causing retbleed WARNINGS
Message-ID: <20220720155507.4f904a58@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The rodata test checks if executable code in the .rodata section will not
execute. But this also means that fix ups that the return hook code does
will not be able to change this code at boot up, and this causes a
warning.

By removing the RETHOOK_CFLAGS from the compilation of the rodata function
makes it hidden from objtool and it will not add its return hook into the
.returns section. This keeps the fix up code from trying and failing on
modifying the rodata return call.

Link: https://lore.kernel.org/all/20220720125736.48164a14@gandalf.local.home/

Fixes: ee88d363d1561 ("x86,static_call: Use alternative RET encoding")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

 [ Note, my tests are still running with this, but it passed the test that
   caused the failure, so I decided to post this now. ]

 arch/x86/Makefile           | 1 +
 drivers/misc/lkdtm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f40dad30d50..2dd61d8594f4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -25,6 +25,7 @@ endif
 ifdef CONFIG_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
+export RETHUNK_CFLAGS
 endif
 
 export RETPOLINE_CFLAGS
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74ac185..fd96ac1617f7 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -16,7 +16,7 @@ lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
-CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.35.1

