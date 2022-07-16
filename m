Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814AD577246
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiGPXTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiGPXSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2598423154
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:53 -0700 (PDT)
Message-ID: <20220716230954.154789166@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fAsRDApUg+1Ko3/u4aoL7mwcacsPjnB0bRdIcawL54c=;
        b=tFpPBn4JCge0ux/DTYO5dVsvHAbEr5C7zz8bCLioXN8B8M7G8AApeAe872zx4SzBv3B6X5
        awBQ9bf9yBJDdsunt3dOqBNV+YkuvbTNEP+uXm2UjOMacqJIuvrf/AHWt5gMZc/jNrl5mn
        x3z0MP2zK0oZllv2QNMc8O7O1Q9BF+mWL495j8Va90fa+GN+l7tIrWDhK7RMUXHBlI6Hho
        U0B47I+j6tFhb15F+6RACSiskOL68Urwz1PopzxPKIDXPJInQ3cm9NcJozMwpcaab4Nqbh
        43ztgy/6W+UxO/BbbYx5aluDNcgyunUvKr/2g66UaKXzyqSu7aViwKV5aDo2LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=fAsRDApUg+1Ko3/u4aoL7mwcacsPjnB0bRdIcawL54c=;
        b=aSvxwZElkNaqXEtHzZykl/J5ozSUlmktVINaEkR3IGdeaq3KzFTtJEDt58HPSzPspHGpzb
        rZzN8oTEYfk+peAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 25/38] x86/modules: Add call thunk patching
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:50 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/alternative.h |    7 +++++
 arch/x86/kernel/callthunks.c       |   49 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/module.c           |   29 +++++++++++++++++++++
 include/linux/module.h             |    4 +++
 4 files changed, 88 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -90,8 +90,15 @@ struct callthunk_sites {
 
 #ifdef CONFIG_CALL_THUNKS
 extern void callthunks_patch_builtin_calls(void);
+extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
+					  struct module *mod);
+extern void callthunks_module_free(struct module *mod);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
+static __always_inline void
+callthunks_patch_module_calls(struct callthunk_sites *sites,
+			      struct module *mod) {}
+static __always_inline void callthunks_module_free(struct module *mod) { }
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -329,6 +329,20 @@ static __init_or_module void callthunk_a
 	area->tmem->is_rx = true;
 }
 
+static __init_or_module int callthunk_set_modname(struct module_layout *layout)
+{
+#ifdef CONFIG_MODULES
+	struct module *mod = layout->mtn.mod;
+
+	if (mod) {
+		mod->callthunk_name = kasprintf(GFP_KERNEL, "callthunk:%s", mod->name);
+		if (!mod->callthunk_name)
+			return -ENOMEM;
+	}
+#endif
+	return 0;
+}
+
 static __init_or_module int callthunks_setup(struct callthunk_sites *cs,
 					     struct module_layout *layout)
 {
@@ -404,6 +418,10 @@ static __init_or_module int callthunks_s
 		callthunk_area_set_rx(area);
 	sync_core();
 
+	ret = callthunk_set_modname(layout);
+	if (ret)
+		goto fail;
+
 	layout->base = thunk;
 	layout->size = text_size;
 	layout->text_size = text_size;
@@ -457,3 +475,34 @@ void __init callthunks_patch_builtin_cal
 	callthunks_init(&cs);
 	mutex_unlock(&text_mutex);
 }
+
+#ifdef CONFIG_MODULES
+void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
+					    struct module *mod)
+{
+	struct module_layout *layout = &mod->thunk_layout;
+
+	if (!thunks_initialized)
+		return;
+
+	layout->mtn.mod = mod;
+	mutex_lock(&text_mutex);
+	WARN_ON_ONCE(callthunks_setup(cs, layout));
+	mutex_unlock(&text_mutex);
+}
+
+void callthunks_module_free(struct module *mod)
+{
+	struct module_layout *layout = &mod->thunk_layout;
+	struct thunk_mem_area *area = layout->arch_data;
+
+	if (!thunks_initialized || !area)
+		return;
+
+	prdbg("Free %s\n", layout_getname(layout));
+	layout->arch_data = NULL;
+	mutex_lock(&text_mutex);
+	callthunk_free(area, true);
+	mutex_unlock(&text_mutex);
+}
+#endif /* CONFIG_MODULES */
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -196,7 +196,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL;
+		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
+		*syms = NULL, *calls = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -216,6 +217,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 			retpolines = s;
 		if (!strcmp(".return_sites", secstrings + s->sh_name))
 			returns = s;
+		if (!strcmp(".sym_sites", secstrings + s->sh_name))
+			syms = s;
+		if (!strcmp(".call_sites", secstrings + s->sh_name))
+			calls = s;
 		if (!strcmp(".ibt_endbr_seal", secstrings + s->sh_name))
 			ibt_endbr = s;
 	}
@@ -241,10 +246,31 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+	if (calls || syms || para) {
+		struct callthunk_sites cs = {};
+
+		if (syms) {
+			cs.syms_start = (void *)syms->sh_addr;
+			cs.syms_end = (void *)syms->sh_addr + syms->sh_size;
+		}
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
 	}
+
 	if (locks && text) {
 		void *lseg = (void *)locks->sh_addr;
 		void *tseg = (void *)text->sh_addr;
@@ -266,4 +292,5 @@ int module_finalize(const Elf_Ehdr *hdr,
 void module_arch_cleanup(struct module *mod)
 {
 	alternatives_smp_module_del(mod);
+	callthunks_module_free(mod);
 }
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -525,6 +525,10 @@ struct module {
 	struct pi_entry **printk_index_start;
 #endif
 
+#ifdef CONFIG_CALL_THUNKS
+	char *callthunk_name;
+#endif
+
 #ifdef CONFIG_MODULE_UNLOAD
 	/* What modules depend on me? */
 	struct list_head source_list;

