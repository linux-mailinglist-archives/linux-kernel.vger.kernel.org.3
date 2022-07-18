Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15B0578AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbiGRTcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiGRTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:32:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58532DA8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:30:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658172645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zg846UmHDyn+fF8KQnQE/negOeDttmNi/h5I5gQnZfQ=;
        b=Xk7gezm4qoF7+Rf0+sUqP1rBbSnHXHQwaxtjpC4srMegUHj2HVenrccEOe5/xkwf75slE0
        SbcgCfcjooMDIdqOIOpJv5CjHZhC4a6Jdk1Wuj8PKgIv+Zk8eN5620XH5JWyLfssVQ6cJX
        vPnsMUen5zFmCbsTOU5eQdIgViz/iRiebzWTCG1Vj25M3633HpYctpPh2qcDVZ0Jwc1G+5
        UNC8xTTv8EjgsUj3TPMJ0TVQuFPBATgBOyo0IlALRvZFEmrgzujnEc30MYQJc/GO0HS9EA
        EhIXsArC1ktl+89l85KR+8TcIyzqKlE9QH5+//WYjcBxVUEeG2Icsfqx6wGIsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658172645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zg846UmHDyn+fF8KQnQE/negOeDttmNi/h5I5gQnZfQ=;
        b=zzUlDIM3lbgnarZB5H8mriDmvPTB3/PMvCzo+1mYYvvz3xn9QkC9SNakJg+Q3ICj67jm+1
        x/AO/DTRmYgaigCw==
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
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
In-Reply-To: <87wncauslw.ffs@tglx>
References: <20220716230344.239749011@linutronix.de> <87wncauslw.ffs@tglx>
Date:   Mon, 18 Jul 2022 21:30:45 +0200
Message-ID: <87tu7euska.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18 2022 at 21:29, Thomas Gleixner wrote:
>> The implementation falls back to the allocated thunks when padding is not
>> available. I'll send out the GCC patch and the required kernel patch as a
>> reply to this series after polishing it a bit.
>
> Here it goes. GCC hackery first.

And the kernel counterpart.

---
Subject: x06/callthunks: Put thunks into compiler provided padding area
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 15 Jul 2022 16:12:47 +0200

      - NOT FOR INCLUSION -

Let the compiler add a 16 byte padding in front of each function entry
point and put the call depth accounting there. That avoids calling out
into the module area and reduces ITLB pressure.

Not-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/Kconfig             |   14 ++++++
 arch/x86/Makefile            |    4 +
 arch/x86/kernel/callthunks.c |   99 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 115 insertions(+), 2 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2440,6 +2440,9 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
+config CC_HAS_PADDING
+	def_bool $(cc-option,-mforce-function-padding)
+
 config HAVE_CALL_THUNKS
 	def_bool y
 	depends on RETHUNK && OBJTOOL
@@ -2512,6 +2515,17 @@ config CALL_DEPTH_TRACKING
 	  of this option is marginal as the call depth tracking is using
 	  run-time generated call thunks and call patching.
 
+config CALL_THUNKS_IN_PADDING
+	bool "Put call depth into padding area before function"
+	depends on CALL_DEPTH_TRACKING && CC_HAS_PADDING
+	default n
+	help
+	  Put the call depth accounting into a padding area before the
+	  function entry. This padding area is generated by the
+	  compiler. This increases text size by ~5%. For non affected
+	  systems this space is unused. On affected SKL systems this
+	  results in a significant performance gain.
+
 config CALL_THUNKS_DEBUG
 	bool "Enable call thunks and call depth tracking debugging"
 	depends on CALL_DEPTH_TRACKING
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -197,6 +197,10 @@ ifdef CONFIG_SLS
   KBUILD_CFLAGS += -mharden-sls=all
 endif
 
+ifdef CONFIG_CALL_THUNKS_IN_PADDING
+  KBUILD_CFLAGS += -mforce-function-padding
+endif
+
 KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
 
 ifdef CONFIG_LTO_CLANG
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -92,6 +92,7 @@ struct thunk_mem {
 
 struct thunk_mem_area {
 	struct thunk_mem	*tmem;
+	unsigned long		*dests;
 	unsigned long		start;
 	unsigned long		nthunks;
 };
@@ -181,6 +182,16 @@ static __init_or_module void callthunk_f
 	      tmem->base + area->start * callthunk_desc.thunk_size,
 	      area->start, area->nthunks);
 
+	/* Remove thunks in the padding area */
+	for (i = 0; area->dests && i < area->nthunks; i++) {
+		void *dest = (void *)area->dests[i];
+
+		if (!dest)
+			continue;
+		pr_info("Remove %px at index %u\n", dest, i);
+		btree_remove64(&call_thunks, (unsigned long)dest);
+	}
+
 	/* Jump starts right after the template */
 	thunk = tmem->base + area->start * callthunk_desc.thunk_size;
 	tp = thunk + callthunk_desc.template_size;
@@ -204,6 +215,7 @@ static __init_or_module void callthunk_f
 		size = area->nthunks * callthunk_desc.thunk_size;
 		text_poke_set_locked(thunk, 0xcc, size);
 	}
+	vfree(area->dests);
 	kfree(area);
 }
 
@@ -289,7 +301,8 @@ patch_paravirt_call_sites(struct paravir
 		patch_call(p->instr, layout);
 }
 
-static struct thunk_mem_area *callthunks_alloc(unsigned int nthunks)
+static struct thunk_mem_area *callthunks_alloc(unsigned int nthunks,
+					       bool module)
 {
 	struct thunk_mem_area *area;
 	unsigned int size, mapsize;
@@ -299,6 +312,13 @@ static struct thunk_mem_area *callthunks
 	if (!area)
 		return NULL;
 
+	if (module) {
+		area->dests = vzalloc(nthunks * sizeof(unsigned long));
+		if (!area->dests)
+			goto free_area;
+		pr_info("Allocated dests array: %px\n", area->dests);
+	}
+
 	list_for_each_entry(tmem, &thunk_mem_list, list) {
 		unsigned long start;
 
@@ -340,6 +360,7 @@ static struct thunk_mem_area *callthunks
 free_tmem:
 	kfree(tmem);
 free_area:
+	vfree(area->dests);
 	kfree(area);
 	return NULL;
 }
@@ -372,6 +393,73 @@ static __init_or_module int callthunk_se
 	return 0;
 }
 
+int setup_padding_thunks(s32 *start, s32 *end, struct thunk_mem_area *area,
+			 struct module_layout *layout)
+{
+	int nthunks = 0, idx = 0;
+	s32 *s;
+
+	if (callthunk_desc.template_size > 16)
+		return 0;
+
+	for (s = start; s < end; s++) {
+		void *thunk, *tp, *dest = (void *)s + *s;
+		unsigned long key = (unsigned long)dest;
+		int fail, i;
+		u8 opcode;
+
+		if (is_inittext(layout, dest)) {
+			prdbg("Ignoring init dest: %pS %px\n", dest, dest);
+			return 0;
+		}
+
+		/* Multiple symbols can have the same location. */
+		if (btree_lookup64(&call_thunks, key)) {
+			prdbg("Ignoring duplicate dest: %pS %px\n", dest, dest);
+			continue;
+		}
+
+		thunk = tp = dest - 16;
+		prdbg("Probing dest: %pS %px at %px\n", dest, dest, tp);
+		pagefault_disable();
+		fail = 0;
+		for (i = 0; !fail && i < 16; i++) {
+			if (get_kernel_nofault(opcode, tp + i)) {
+				fail = 1;
+			} else if (opcode != 0xcc) {
+				fail = 2;
+			}
+		}
+		pagefault_enable();
+		switch (fail) {
+		case 1:
+			prdbg("Faulted for dest: %pS %px\n", dest, dest);
+			nthunks++;
+			continue;
+		case 2:
+			prdbg("No padding for dest: %pS %px\n", dest, dest);
+			nthunks++;
+			continue;
+		}
+
+		prdbg("Thunk for dest: %pS %px at %px\n", dest, dest, tp);
+		memcpy(tp, callthunk_desc.template, callthunk_desc.template_size);
+		tp += callthunk_desc.template_size;
+		memcpy(tp, x86_nops[6], 6);
+
+		if (area->dests) {
+			pr_info("Insert %px at index %d\n", dest, idx);
+			area->dests[idx++] = key;
+		}
+
+		fail = btree_insert64(&call_thunks, key, (void *)thunk, GFP_KERNEL);
+		if (fail)
+			return fail;
+	}
+	prdbg("%d external thunks required\n", nthunks);
+	return 0;
+}
+
 static __init_or_module int callthunks_setup(struct callthunk_sites *cs,
 					     struct module_layout *layout)
 {
@@ -394,7 +482,7 @@ static __init_or_module int callthunks_s
 	if (!nthunks)
 		goto patch;
 
-	area = callthunks_alloc(nthunks);
+	area = callthunks_alloc(nthunks, !!layout->mtn.mod);
 	if (!area)
 		return -ENOMEM;
 
@@ -420,6 +508,13 @@ static __init_or_module int callthunks_s
 		prdbg("Using thunk vbuf %px\n", vbuf);
 	}
 
+	if (IS_ENABLED(CONFIG_CALL_THUNKS_IN_PADDING)) {
+		ret = setup_padding_thunks(cs->syms_start, cs->syms_end,
+					   area, layout);
+		if (ret < 0)
+			goto fail;
+	}
+
 	for (s = cs->syms_start; s < cs->syms_end; s++) {
 		void *dest = (void *)s + *s;
 
