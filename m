Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83EB4C2F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiBXPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiBXPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:40 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2515E6FB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TkAGJ7zvVcxFDw+ALEkg770IMxdVbOyeQIIT2lBeroM=; b=Mah+icSYuh56wZ1diahoCaU3Ml
        tQovF73+2jaUDzIllGpqicGbkt1WYVT6X1L+5Z5h/dRZ9fIpQDS027PG1S50LFvR4PveJ7AG5zY5E
        IFYHSmEgXkK0W+Hc/0EYDb379saGjlyXE029Q3Gln8mksqotkoqGFsF7yRSEF9PPDXP8jLLCv18HB
        YHU/OxLXVCxq9I8MiFF5+6LrpHvaJrupJEH2FloM4Aoh4jAL5db3LCGgh+sJ/OtgN0iw+mvEwH3l6
        K6Rytsw1kdo+JaIK7vjj2xr1PQOJ89fC4EROOIRSIp9yxXlwaYS3/VwXSLTTWE9cRKTRjThWGqx2H
        h9lmncUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-00CeM6-Jc; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52007302DA2;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B36862B3547B1; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151324.198359442@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 37/39] x86/ibt: Finish --ibt-fix-direct on module loading
References: <20220224145138.952963315@infradead.org>
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

Since modules are not fully linked objects, per construction, the
LTO-like objtool pass cannot fix up the direct calls to external
symbols.

Have the module loader finish the job.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/module.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -24,6 +24,7 @@
 #include <asm/page.h>
 #include <asm/setup.h>
 #include <asm/unwind.h>
+#include <asm/ibt.h>
 
 #if 0
 #define DEBUGP(fmt, ...)				\
@@ -128,6 +129,33 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
+
+static inline void ibt_fix_direct(void *loc, u64 *val)
+{
+#ifdef CONFIG_X86_KERNEL_IBT
+	const void *addr = (void *)(4 + *val);
+	union text_poke_insn text;
+	u32 insn;
+
+	if (get_kernel_nofault(insn, addr))
+		return;
+
+	if (!is_endbr(insn))
+		return;
+
+	/* validate jmp.d32/call @ loc */
+	if (WARN_ONCE(get_kernel_nofault(text, loc-1) ||
+		      (text.opcode != CALL_INSN_OPCODE &&
+		       text.opcode != JMP32_INSN_OPCODE),
+		      "Unexpected code at: %pS\n", loc))
+		return;
+
+	DEBUGP("ibt_fix_direct: %pS\n", addr);
+
+	*val += 4;
+#endif
+}
+
 static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
@@ -139,6 +167,7 @@ static int __apply_relocate_add(Elf64_Sh
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	void *loc;
+	int type;
 	u64 val;
 
 	DEBUGP("Applying relocate section %u to %u\n",
@@ -153,13 +182,14 @@ static int __apply_relocate_add(Elf64_Sh
 		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rel[i].r_info);
 
+		type = ELF64_R_TYPE(rel[i].r_info);
+
 		DEBUGP("type %d st_value %Lx r_addend %Lx loc %Lx\n",
-		       (int)ELF64_R_TYPE(rel[i].r_info),
-		       sym->st_value, rel[i].r_addend, (u64)loc);
+		       type, sym->st_value, rel[i].r_addend, (u64)loc);
 
 		val = sym->st_value + rel[i].r_addend;
 
-		switch (ELF64_R_TYPE(rel[i].r_info)) {
+		switch (type) {
 		case R_X86_64_NONE:
 			break;
 		case R_X86_64_64:
@@ -185,6 +215,10 @@ static int __apply_relocate_add(Elf64_Sh
 		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
+
+			if (type == R_X86_64_PLT32)
+				ibt_fix_direct(loc, &val);
+
 			val -= (u64)loc;
 			write(loc, &val, 4);
 #if 0


