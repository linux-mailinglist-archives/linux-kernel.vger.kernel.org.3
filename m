Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB15AB3B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiIBOdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiIBOas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:30:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288714D3F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VtHSfWHBCM/dkewK26y+PcMV0oq6+DiYrWTtkB689iQ=; b=Ycygkh2jN7m1q17HxTbE+bSJD5
        d0nMCb3gQG4Kb408oFfp3kF6NGqMcXaxIcF7E4S7cCmHsKzost2zxuq0AH/KyNfDAiCneJi+lo2Ul
        9L9U6/qs0SPPQMsv0/HoACJF3CXUPEh/c1MeWPzCI3ztxPNUuorOk4YuHI1KP4/SauR14o4aRxKX/
        Ge8NTyhbMvjCI0Vp1Ovvx8VmkgKWCwyrOp1hzmh6D1vyUBxpibD41WaM2XtesOqveimS+LNpAfBOU
        nQuq2w6W6Rv57Bs4wMedkujSY9+3PVVeSSPeTCFCEVBlOvEJIauA54/dMgEbnW1b2aPmP5RNzHUHy
        IFnW7D8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77N-0074TJ-JZ; Fri, 02 Sep 2022 13:53:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26CD9301D17;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD4CB2B8EF7F2; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.268856815@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:53 +0200
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
Subject: [PATCH v2 28/59] objtool: Allow !PC relative relocations
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

Objtool doesn't currently much like per-cpu usage in alternatives:

arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xf: unsupported relocation in alternatives section
  f:   65 c7 04 25 00 00 00 00 00 00 00 80     movl   $0x80000000,%gs:0x0      13: R_X86_64_32S        __x86_call_depth

Since the R_X86_64_32S relocation is location invariant (it's
computation doesn't include P - the address of the location itself),
it can be trivially allowed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c       |   42 +++++++++++++++++++++++++++++-----
 tools/objtool/check.c                 |    6 +---
 tools/objtool/include/objtool/arch.h  |    6 ++--
 tools/objtool/include/objtool/check.h |   17 +++++++------
 4 files changed, 51 insertions(+), 20 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -73,6 +73,30 @@ unsigned long arch_jump_destination(stru
 	return insn->offset + insn->len + insn->immediate;
 }
 
+bool arch_pc_relative_reloc(struct reloc *reloc)
+{
+	/*
+	 * All relocation types where P (the address of the target)
+	 * is included in the computation.
+	 */
+	switch (reloc->type) {
+	case R_X86_64_PC8:
+	case R_X86_64_PC16:
+	case R_X86_64_PC32:
+	case R_X86_64_PC64:
+
+	case R_X86_64_PLT32:
+	case R_X86_64_GOTPC32:
+	case R_X86_64_GOTPCREL:
+		return true;
+
+	default:
+		break;
+	}
+
+	return false;
+}
+
 #define ADD_OP(op) \
 	if (!(op = calloc(1, sizeof(*op)))) \
 		return -1; \
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1622,7 +1620,7 @@ static int handle_group_alt(struct objto
 		 * accordingly.
 		 */
 		alt_reloc = insn_reloc(file, insn);
-		if (alt_reloc &&
+		if (alt_reloc && arch_pc_relative_reloc(alt_reloc) &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -93,4 +91,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 int arch_rewrite_retpolines(struct objtool_file *file);
 
+bool arch_pc_relative_reloc(struct reloc *reloc);
+
 #endif /* _ARCH_H */


