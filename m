Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A85AB39C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiIBObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiIBO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EB71581AB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PsjEG4knouG+JCTeWWUmbwqU2xySdGfCmOMQNnMDy2Q=; b=Qp0mGFPB5LdN/pvzWYro8eZiFO
        XbgukPSiOl0q748pBt3ft2uufZuUlM1flnG0aeMXGUW7ytO5p3fzrGUthTKCFoffSLynfCCdge9Ic
        BV79/DDm+L7JuJ2BRknNrkveODlgdGCOvxcpQwiGwG3oUG8kLtx9nyswqJolT+VVNJhKchML++ZpZ
        Ne2Xgteamj/DhtICsa+h8tD4BdCaMLXMxrokswI0ui9Gf6fPT3BLXSODHFAxnIXF4N6w8GtSSWfWq
        V5KetR9+Ze/YgG3A3B3qEvonpxxz5ZzgnNK1i9u2NXo+SL8bhG8lABpAWkyAJW/IWu+NW7VWuZws3
        EAjLMQTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77P-0074UO-8H; Fri, 02 Sep 2022 13:53:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C9C7302D59;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5DA2C2B8EFB54; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130951.029167377@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:10 +0200
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
Subject: [PATCH v2 45/59] x86/modules: Add call patching
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

As for the builtins create call thunks and patch the call sites to call the
thunk on Intel SKL CPUs for retbleed mitigation.

Note, that module init functions are ignored for sake of simplicity because
loading modules is not something which is done in high frequent loops and
the attacker has not really a handle on when this happens in order to
launch a matching attack. The depth tracking will still work for calls into
the builtins and because the call is not accounted it will underflow faster
and overstuff, but that's mitigated by the saturating counter and the side
effect is only temporary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative.h |    5 +++++
 arch/x86/kernel/callthunks.c       |   19 +++++++++++++++++++
 arch/x86/kernel/module.c           |   20 +++++++++++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -89,8 +89,13 @@ struct callthunk_sites {
 
 #ifdef CONFIG_CALL_THUNKS
 extern void callthunks_patch_builtin_calls(void);
+extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
+					  struct module *mod);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
+static __always_inline void
+callthunks_patch_module_calls(struct callthunk_sites *sites,
+			      struct module *mod) {}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -249,3 +249,22 @@ void __init callthunks_patch_builtin_cal
 	thunks_initialized = true;
 	mutex_unlock(&text_mutex);
 }
+
+#ifdef CONFIG_MODULES
+void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
+					    struct module *mod)
+{
+	struct core_text ct = {
+		.base = (unsigned long)mod->core_layout.base,
+		.end  = (unsigned long)mod->core_layout.base + mod->core_layout.size,
+		.name = mod->name,
+	};
+
+	if (!thunks_initialized)
+		return;
+
+	mutex_lock(&text_mutex);
+	callthunks_setup(cs, &ct);
+	mutex_unlock(&text_mutex);
+}
+#endif /* CONFIG_MODULES */
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -254,7 +254,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
+		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
+		*calls = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -274,6 +275,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			retpolines = s;
 		if (!strcmp(".return_sites", secstrings + s->sh_name))
 			returns = s;
+		if (!strcmp(".call_sites", secstrings + s->sh_name))
+			calls = s;
 		if (!strcmp(".ibt_endbr_seal", secstrings + s->sh_name))
 			ibt_endbr = s;
 	}
@@ -299,6 +302,21 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+	if (calls || para) {
+		struct callthunk_sites cs = {};
+
+		if (calls) {
+			cs.call_start = (void *)calls->sh_addr;
+			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
+		}
+
+		if (para) {
+			cs.pv_start = (void *)para->sh_addr;
+			cs.pv_end = (void *)para->sh_addr + para->sh_size;
+		}
+
+		callthunks_patch_module_calls(&cs, me);
+	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);


