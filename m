Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349B534DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiEZLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347117AbiEZLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:03:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A600CEBB1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=r2eMVpFl0Aac8ZRjWQ0+nV5mtEZevDgIYgdhVMNcaMU=; b=ddtwCTdp7TmAveVJV4GZ6oZ2EW
        DZ6hSBOhETw366mfCbUmUSceZ3TcxCj1fpTmOpY8gfM1z1Y7S+noMvxjDxra8ZlPQNAXnO8XephSN
        W12Ytvs7Ypz5/b4VPlcQYIGOqsw1qL7PQHp6e4RNKcNBWBV9XXwSNKb8faWL6D7JMj58j6LdmIW5Z
        5l8lnknUq6946GsSfPeM6bj1znYJahzyHUR6jbFsSW4R7p6nYCNaOU3tG35Aoz6LISKPOeIEF+8fv
        l1RbiDQB8ecgVD4ZxgeU77SoIz3EA9AGWSngaLToKvIwOZLdPBi4gw8eFEqZk0b1HGisItOD2n9ti
        NMljld9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBGX-001sVg-Jc; Thu, 26 May 2022 11:02:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 932E030003C;
        Thu, 26 May 2022 13:02:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6DCBF2025FE5B; Thu, 26 May 2022 13:02:50 +0200 (CEST)
Message-ID: <20220526105957.817269865@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 May 2022 12:52:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: [PATCH 2/7] objtool: Extend UNWIND_HINT based ENDBR rules
References: <20220526105252.440440893@infradead.org>
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

Extend the UNWIND hint driven rules for ENDBR placement. Currently
objtool expects an ENDBR at any UNWINT_HINT_IRET_REGS that is at +0 of
an STB_GLOBAL symbol, with the expectation that this is an exception
entry point.

Extend this to also expect ENDBR at UNWIND_HINT_EMPTY at +0 for
STB_GLOBAL symbols, with the expectation that these are also machine
entry points (SYSCALL et. al.).

This guarantees all machine entry points are covered by objtool rules at
the expense of a few additional false positives:

  vmlinux.o: warning: objtool: startup_64+0x0: UNWIND_HINT_EMPTY without ENDBR
  vmlinux.o: warning: objtool: start_cpu0+0x0: UNWIND_HINT_EMPTY without ENDBR

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/head_64.S |    2 ++
 tools/objtool/check.c     |   23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -43,6 +43,7 @@ L3_START_KERNEL = pud_index(__START_KERN
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	/*
 	 * At this point the CPU runs in 64bit mode CS.L = 1 CS.D = 0,
 	 * and someone has loaded an identity mapped page table
@@ -371,6 +372,7 @@ SYM_CODE_END(secondary_startup_64)
  */
 SYM_CODE_START(start_cpu0)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	movq	initial_stack(%rip), %rsp
 	jmp	.Ljump_to_C_code
 SYM_CODE_END(start_cpu0)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1947,14 +1947,27 @@ static int read_unwind_hints(struct objt
 
 		insn->hint = true;
 
-		if (opts.ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
+		if (opts.ibt) {
 			struct symbol *sym = find_symbol_by_offset(insn->sec, insn->offset);
 
-			if (sym && sym->bind == STB_GLOBAL &&
-			    insn->type != INSN_ENDBR && !insn->noendbr) {
-				WARN_FUNC("UNWIND_HINT_IRET_REGS without ENDBR",
-					  insn->sec, insn->offset);
+			if (!sym || sym->bind != STB_GLOBAL)
+				goto no_entry;
+
+			if (hint->type == UNWIND_HINT_TYPE_CALL && !hint->sp_reg) {
+				if (insn->type != INSN_ENDBR && !insn->noendbr) {
+					WARN_FUNC("UNWIND_HINT_EMPTY without ENDBR",
+							insn->sec, insn->offset);
+				}
+			}
+
+			if (hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
+				if (insn->type != INSN_ENDBR && !insn->noendbr) {
+					WARN_FUNC("UNWIND_HINT_IRET_REGS without ENDBR",
+							insn->sec, insn->offset);
+				}
 			}
+
+no_entry:		;
 		}
 
 		if (hint->type == UNWIND_HINT_TYPE_FUNC) {


