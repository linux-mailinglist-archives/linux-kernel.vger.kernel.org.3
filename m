Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77345AB387
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiIBOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiIBO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC11158193
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PRFezF+A6ZMXdXkPHYzuMdhPUJWoNiZcQ9+a8pisS0c=; b=Bq53KEbQq8MsTK3OPz2qEIJ0fG
        bDB/hSgHLUSwToEmKrJ/xQxg4jO5KCbHKjME+WgEbGHSR3vVEbjVZujSaj/NGbEf5MqRSc97SXIKG
        an55pvmqAqpnQ9NZAyw0JSBoUhlaWA6SAvBkIGqqoJcDf2LWv3DAsa1xGg1Y9H6nsZaG1+L5VcDWs
        eYgivt53bktCDhHT8t2vzB4Ozyhhf9IugTYNe+p58mPA9DZ9EoD4zGJa158knik9XHcz8ZLhdtIZb
        k8DrRcakv2cyAhAVfqFShqfood7Z2mQS6+TTt8xNfzGkQx0SZYKVz5PjYgbjjJFyPMr2JAV7m49N/
        SKXSp62A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77O-0074UC-Df; Fri, 02 Sep 2022 13:53:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3319230241E;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1399E2B8EF7FA; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.102327457@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:01 +0200
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
Subject: [PATCH v2 36/59] ftrace: Add HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
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

From: Peter Zijlstra (Intel) <peterz@infradead.org>

x86 will shortly start using -fpatchable-function-entry for purposes
other than ftrace, make sure the __patchable_function_entry section
isn't merged in the mcount_loc section.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/vmlinux.lds.h |   11 ++++++++++-
 kernel/trace/Kconfig              |    6 ++++++
 tools/objtool/check.c             |    3 ++-
 3 files changed, 18 insertions(+), 2 deletions(-)

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -159,6 +159,14 @@
 #define MEM_DISCARD(sec) *(.mem##sec)
 #endif
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+#define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
+#define PATCHABLE_DISCARDS
+#else
+#define KEEP_PATCHABLE
+#define PATCHABLE_DISCARDS	*(__patchable_function_entries)
+#endif
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 /*
  * The ftrace call sites are logged to a section whose name depends on the
@@ -177,7 +185,7 @@
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
-			KEEP(*(__patchable_function_entries))	\
+			KEEP_PATCHABLE				\
 			__stop_mcount_loc = .;			\
 			ftrace_stub_graph = ftrace_stub;	\
 			ftrace_ops_list_func = arch_ftrace_ops_list_func;
@@ -1029,6 +1037,7 @@
 
 #define COMMON_DISCARDS							\
 	SANITIZER_DISCARDS						\
+	PATCHABLE_DISCARDS						\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -51,6 +51,12 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	 This allows for use of regs_get_kernel_argument() and
 	 kernel_stack_pointer().
 
+config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
+	bool
+	help
+	  If the architecture generates __patchable_function_entries sections
+	  but does not want them included in the ftrace locations.
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4196,7 +4196,8 @@ static int validate_ibt(struct objtool_f
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__mcount_loc"))
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)


