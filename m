Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867C5AB379
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiIBO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiIBO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198DF145C40
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3pHERFsmuK61/aX42Un1sPpA4i778m0NUaKcblu/jsE=; b=MiQrGmnSSmUN+m3AY8XVrIIMxA
        Ij4T3rSxtjKMDZBHu+f20DFMXl61hxKfBVmxDXHQ1yqV0hvL6YL6tM9eHnGYvW4S564sPN5gD0K5+
        HGfmoRt7l9LXJx8RN+LpCVbQbAfDOCKoT68U2FP7lpcJfzANHAjiHhRO46G4IXIM9qqC1R8jyNV5b
        799JT+RF1RFpU+ZU6gCUc0Dj2jgrhsqzMZASKaipMxT+Zufr8oeI3oVBtyYsjldqBZ+rcdZTU5icv
        lcbC/ePpgr2rY7I8DXLE0ozcUhWTYwrTOr8JM6xrU3CJvSdApR5wpFS1UuBsjW0yOY7tDYIG2n2+U
        uNySeT+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77N-0074TK-KB; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26CE7301D1E;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C4A3F2B8EF7F1; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.166343269@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:52 +0200
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
Subject: [PATCH v2 27/59] x86/softirq: Move softirq pending next to current task
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

Another hot variable which is strict per CPU and benefits from
being in the same cache line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/current.h |    1 +
 arch/x86/include/asm/hardirq.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -19,6 +19,7 @@ struct pcpu_hot {
 			int			cpu_number;
 			unsigned long		top_of_stack;
 			void			*hardirq_stack_ptr;
+			u16			softirq_pending;
 #ifdef CONFIG_X86_64
 			bool			hardirq_stack_inuse;
 #else
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -3,9 +3,9 @@
 #define _ASM_X86_HARDIRQ_H
 
 #include <linux/threads.h>
+#include <asm/current.h>
 
 typedef struct {
-	u16	     __softirq_pending;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
@@ -60,6 +60,7 @@ extern u64 arch_irq_stat_cpu(unsigned in
 extern u64 arch_irq_stat(void);
 #define arch_irq_stat		arch_irq_stat
 
+#define local_softirq_pending_ref       pcpu_hot.softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 static inline void kvm_set_cpu_l1tf_flush_l1d(void)


