Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C9C5AB3A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiIBOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbiIBO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32601140CD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WG6G46Ua3WkaooMqyaY9G1V2PL1FK78RAajcxW19yWA=; b=Gv0FHzx9E3AunEp04b4luzhZS7
        EVld5MobGXBeGMwpBn6R096leV+mMQ1IY5CXZuSN8Jf83TmSYR1D5ckkv0MfLguf+gC4r1to0aoLp
        cKYqBF0kOF7hA7isc1wLsFjU+t3HorPPih6yI4hFIj2Lt20XXjvG+SQ8AZxazudJJH3m4OYcI++wK
        vNBin//nusv8mRmOTv0+k8i2EBdnLQ19SBiDpoIk0T5tLylv3hqeVPBgvuoUEic1mbogkagdK7194
        Q+b1Ldg0PJyX4IOrv3dZg5VniK5brdoJIIhi2y9oiUppRBpAr7F/iwqukzd2gpMUczH7qKm3dmc8D
        y/F5EHwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77O-008g8e-9U; Fri, 02 Sep 2022 13:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4346C302DA6;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B08522B8EFB61; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130951.959811186@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:19 +0200
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
Subject: [PATCH v2 54/59] x86/orc: Make it callthunk aware
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

From: Peter Zijlstra <peterz@infradead.org>

Callthunks addresses on the stack would confuse the ORC unwinder. Handle
them correctly and tell ORC to proceed further down the stack.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h |    5 +++++
 arch/x86/kernel/callthunks.c       |   13 +++++++++++++
 arch/x86/kernel/unwind_orc.c       |   21 ++++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -92,6 +92,7 @@ extern void callthunks_patch_builtin_cal
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
+extern bool is_callthunk(void *addr);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -101,6 +102,10 @@ static __always_inline void *callthunks_
 {
 	return dest;
 }
+static __always_inline bool is_callthunk(void *addr)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -292,6 +292,19 @@ void *callthunks_translate_call_dest(voi
 	return target ? : dest;
 }
 
+bool is_callthunk(void *addr)
+{
+	unsigned int tmpl_size = SKL_TMPL_SIZE;
+	void *tmpl = skl_call_thunk_template;
+	unsigned long dest;
+
+	dest = roundup((unsigned long)addr, CONFIG_FUNCTION_ALIGNMENT);
+	if (!thunks_initialized || skip_addr((void *)dest))
+		return false;
+
+	return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
+}
+
 #ifdef CONFIG_MODULES
 void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
 					    struct module *mod)
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -131,6 +131,21 @@ static struct orc_entry null_orc_entry =
 	.type = UNWIND_HINT_TYPE_CALL
 };
 
+#ifdef CONFIG_CALL_THUNKS
+static struct orc_entry *orc_callthunk_find(unsigned long ip)
+{
+	if (!is_callthunk((void *)ip))
+		return NULL;
+
+	return &null_orc_entry;
+}
+#else
+static struct orc_entry *orc_callthunk_find(unsigned long ip)
+{
+	return NULL;
+}
+#endif
+
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
 	.type		= UNWIND_HINT_TYPE_CALL,
@@ -184,7 +199,11 @@ static struct orc_entry *orc_find(unsign
 	if (orc)
 		return orc;
 
-	return orc_ftrace_find(ip);
+	orc =  orc_ftrace_find(ip);
+	if (orc)
+		return orc;
+
+	return orc_callthunk_find(ip);
 }
 
 #ifdef CONFIG_MODULES


