Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8746B5AB38B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiIBOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiIBO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B975168A26
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YUhA2B9hWTAdbvtvLfAUCL48qsFF8kF9euAYgBwVN7c=; b=F1sdS6J0B07JaNau9gs7zg9nAa
        JFqYigGC2sVpUTdJG0Ry7PoQlkHW5sSmWOwYlDjzxi0d0ZM6ucwdxaOGxu5ED0CyjXB1eFdseUDqN
        jwYnJJAj/nI/+x1Nn/1VIPrh3UMEkX7GGDXBG01mgtwTMBVmqY6RCMX/1y2nfHXvPnIECNItRa0ai
        pYFOHwxuBnSyFVrowORsKnxV/Pfj5qX8j1TjDhEXp7dTB7qw+DNU+KCzRAEgHisdvG+FcsW8y+KXb
        yEr7fHD9l8gWsNkHiG0DwPEbdj52ujSMHBOrxSeGgjq57exmwfsJS4w1PQL9B1AH467E0chEIDvyn
        ZEur5Odg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-0074T1-6d; Fri, 02 Sep 2022 13:53:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00E8430069C;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3F8F32B077D23; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130947.190618587@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 08/59] x86/build: Ensure proper function alignment
References: <20220902130625.217071627@infradead.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

The Intel Architectures Optimization Reference Manual explains that
functions should be aligned at 16 bytes because for a lot of (Intel)
uarchs the I-fetch width is 16 bytes. The AMD Software Optimization
Guide (for recent chips) mentions a 32 byte I-fetch window but a 16
byte decode window.

Follow this advice and align functions to 16 bytes to optimize
instruction delivery to decode and reduce front-end bottlenecks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig.cpu              |    6 ++++++
 arch/x86/Makefile                 |    4 ++++
 arch/x86/include/asm/linkage.h    |    7 ++++---
 include/asm-generic/vmlinux.lds.h |    7 ++++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -517,3 +517,9 @@ config CPU_SUP_VORTEX_32
 	  makes the kernel a tiny bit smaller.
 
 	  If unsure, say N.
+
+# Defined here so it is defined for UM too
+config FUNCTION_ALIGNMENT
+	int
+	default 16 if X86_64 || X86_ALIGNMENT_16
+	default 8
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -84,6 +84,10 @@ else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
 
+ifneq ($(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B),y)
+KBUILD_CFLAGS += -falign-functions=$(CONFIG_FUNCTION_ALIGNMENT)
+endif
+
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
         UTS_MACHINE := i386
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -14,9 +14,10 @@
 
 #ifdef __ASSEMBLY__
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
-#define __ALIGN		.p2align 4, 0x90
-#define __ALIGN_STR	__stringify(__ALIGN)
+#if CONFIG_FUNCTION_ALIGNMENT == 16
+#define __ALIGN			.p2align 4, 0x90
+#define __ALIGN_STR		__stringify(__ALIGN)
+#define FUNCTION_ALIGNMENT	16
 #endif
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -82,7 +82,12 @@
 #endif
 
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
-#define ALIGN_FUNCTION()  . = ALIGN(8)
+#ifndef CONFIG_FUNCTION_ALIGNMENT
+#define __FUNCTION_ALIGNMENT	8
+#else
+#define __FUNCTION_ALIGNMENT	CONFIG_FUNCTION_ALIGNMENT
+#endif
+#define ALIGN_FUNCTION()  . = ALIGN(__FUNCTION_ALIGNMENT)
 
 /*
  * LD_DEAD_CODE_DATA_ELIMINATION option enables -fdata-sections, which


