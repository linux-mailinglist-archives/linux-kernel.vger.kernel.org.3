Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C64C48E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbiBYP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiBYP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:29:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422B11F7679
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FyG8w47yd6ljA1G7i84WXeMP7Na2oVkPgUrhTbBisJM=; b=hYxUYqlFlG/Ekvt0EtGcXQBa3O
        TV6VDRfY+oaMiSBoyovPC1QjjtaRbe/356DnQbFqNi4v4nWJhMZnCL12PWgTtUMta/FwAqWBcsl+S
        taQQxOjErob3uFyacfrPIG05HmQtIlXdKMWGHDU6SQYyzX/RiOmpH8xgZ5h5KnyUTh2IJuM3vi/zI
        HrVDClN9sxB1L9vhsdgWhzs1G7BYF8tl+0f+u6sEX44UJY6AjsA6NK8u1kKjythnGOdjh6WBfDzl9
        ZwsGSFSvJxRtFSwg34Y6nKhipnkQ+sHZKzraagxad/rovrlgbkAAOau1Axj9XCeWjZWmeA5h6jUOd
        Y0Le8OIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNcWI-00Czdd-Ua; Fri, 25 Feb 2022 15:28:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D06D6300296;
        Fri, 25 Feb 2022 16:28:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0629200B888A; Fri, 25 Feb 2022 16:28:32 +0100 (CET)
Date:   Fri, 25 Feb 2022 16:28:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <Yhj1oFcTl2RnghBz@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224202602.3gvz5tnxvwb4maod@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224202602.3gvz5tnxvwb4maod@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:26:02PM -0800, Josh Poimboeuf wrote:

> Bricked my SPR:
> 
> [   21.602888] jump_label: Fatal kernel bug, unexpected op at sched_clock_stable+0x4/0x20 [0000000074a0db20] (eb 06 b8 01 00 != eb 0a 00 00 00)) size:2 type:0

> ffffffff81120a70 <sched_clock_stable>:
> ffffffff81120a70:       f3 0f 1e fa             endbr64
> ffffffff81120a74:       eb 06                   jmp    ffffffff81120a7c <sched_clock_stable+0xc>
> ffffffff81120a76:       b8 01 00 00 00          mov    $0x1,%eax
> ffffffff81120a7b:       c3                      retq
> ffffffff81120a7c:       f3 0f 1e fa             endbr64
> ffffffff81120a80:       31 c0                   xor    %eax,%eax
> ffffffff81120a82:       c3                      retq
> ffffffff81120a83:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
> ffffffff81120a8a:       00 00 00 00
> ffffffff81120a8e:       66 90                   xchg   %ax,%ax

This is due to you having a very old (and arguably buggy) compiler :-( I
can reproduce with gcc-8.4 and gcc-9.4, my gcc-10.3 compiler no longer
generates daft code like that, nor do any later.

That said, I can fix objtool to also re-write jumps to in-the-middle
ENDBR like this, but then I do get a bunch of:

OBJTOOL vmlinux.o
vmlinux.o: warning: objtool: displacement doesn't fit
vmlinux.o: warning: objtool: ep_insert()+0xbc5: Direct IMM jump to ENDBR; cannot fix
vmlinux.o: warning: objtool: displacement doesn't fit
vmlinux.o: warning: objtool: configfs_depend_prep()+0x76: Direct IMM jump to ENDBR; cannot fix
vmlinux.o: warning: objtool: displacement doesn't fit
vmlinux.o: warning: objtool: request_key_and_link()+0x17b: Direct IMM jump to ENDBR; cannot fix
vmlinux.o: warning: objtool: displacement doesn't fit
vmlinux.o: warning: objtool: blk_mq_poll()+0x2e0: Direct IMM jump to ENDBR; cannot fix

The alternative is only skipping endbr at +0 I suppose, lemme go try
that with the brand spanking new skip_endbr() function.

Yep,.. that seems to cure things. It noaw boats when build with old
crappy compilers too.


--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -47,6 +47,8 @@ static inline bool is_endbr(unsigned int
 	return val == gen_endbr();
 }
 
+extern void *skip_endbr(void *);
+
 extern __noendbr u64 ibt_save(void);
 extern __noendbr void ibt_restore(u64 save);
 
@@ -71,6 +73,7 @@ extern __noendbr void ibt_restore(u64 sa
 #define __noendbr
 
 static inline bool is_endbr(unsigned int val) { return false; }
+static inline void *skip_endbr(void *addr) { return addr; }
 
 static inline u64 ibt_save(void) { return 0; }
 static inline void ibt_restore(u64 save) { }
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -112,10 +112,7 @@ void __text_gen_insn(void *buf, u8 opcod
 	OPTIMIZER_HIDE_VAR(addr);
 	OPTIMIZER_HIDE_VAR(dest);
 
-#ifdef CONFIG_X86_KERNEL_IBT
-	if (is_endbr(*(u32 *)dest))
-		dest += 4;
-#endif
+	dest = skip_endbr((void *)dest);
 
 	insn->opcode = opcode;
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -620,6 +620,19 @@ __noendbr void ibt_restore(u64 save)
 	}
 }
 
+
+void *skip_endbr(void *addr)
+{
+	unsigned long size, offset;
+
+	if (is_endbr(*(unsigned int *)addr) &&
+	    kallsyms_lookup_size_offset((unsigned long)addr, &size, &offset) &&
+	    !offset)
+		addr += 4;
+
+	return addr;
+}
+
 #endif
 
 static __always_inline void setup_cet(struct cpuinfo_x86 *c)
@@ -636,7 +649,10 @@ static __always_inline void setup_cet(st
 	if (!ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
+		return;
 	}
+
+	pr_info("CET detected: Indirect Branch Tracking enabled\n");
 }
 
 __noendbr void cet_disable(void)
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -350,18 +350,12 @@ static int __bpf_arch_text_poke(void *ip
 	u8 *prog;
 	int ret;
 
-#ifdef CONFIG_X86_KERNEL_IBT
-	if (is_endbr(*(u32 *)ip))
-		ip += 4;
-#endif
+	ip = skip_endbr(ip);
 
 	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
 	if (old_addr) {
 		prog = old_insn;
-#ifdef CONFIG_X86_KERNEL_IBT
-		if (is_endbr(*(u32 *)old_addr))
-			old_addr += 4;
-#endif
+		old_addr = skip_endbr(old_addr);
 		ret = t == BPF_MOD_CALL ?
 		      emit_call(&prog, old_addr, ip) :
 		      emit_jump(&prog, old_addr, ip);
@@ -372,10 +366,7 @@ static int __bpf_arch_text_poke(void *ip
 	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
 	if (new_addr) {
 		prog = new_insn;
-#ifdef CONFIG_X86_KERNEL_IBT
-		if (is_endbr(*(u32 *)new_addr))
-			new_addr += 4;
-#endif
+		new_addr = skip_endbr(new_addr);
 		ret = t == BPF_MOD_CALL ?
 		      emit_call(&prog, new_addr, ip) :
 		      emit_jump(&prog, new_addr, ip);
