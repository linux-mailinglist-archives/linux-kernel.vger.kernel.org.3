Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8CE50B590
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446868AbiDVKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446657AbiDVKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:53:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFC052B27
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wFQUfjiPHZnqxP126pqF+VGxShtY5rmGdalhBuAkoT8=; b=HAeEwNrbJ+4/2lMEnr0sjlWnOF
        psR4t35/cLkOhlhHhkc8Jj9l0aUbgMl3SOJCcLhbjWzR9P5QlqNHnlpJN60tlLHgAMaqmu+N7yDxi
        9NOsUbwqs+ND/CqNSdO4goYhEYNIaCp75GMlJtYquV9nrgM+n63cLE9V+phgVtaEhiJ6SIObw92DR
        93FIaNuey27JNJm1iFvVsSb1MPMS1/WYD3SmFsVJ1M0CeEOaRHrg9jrqJ71rJbG4kvVQ+rgQ26jBX
        tW1jg6CcjGnfezXEmGEIWiDQi56aZOTwhIl1aM8180XLHeNFsJfUvS0V8Ls5dU7U8L39UArCrTI3a
        dDqVWnNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhqs3-005zx4-D0; Fri, 22 Apr 2022 10:50:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BAC898618A; Fri, 22 Apr 2022 12:50:37 +0200 (CEST)
Date:   Fri, 22 Apr 2022 12:50:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] objtool: Rework ibt and extricate from stack
 validation
Message-ID: <20220422105037.GV2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2204201755580.1205@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2204201755580.1205@pobox.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 07:25:16PM +0200, Miroslav Benes wrote:
> A nit and it was there even before this patch...
> 
> > -static struct instruction *
> > -validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> > -{
> > -	struct instruction *dest;
> > -	struct section *sec;
> > -	unsigned long off;
> > -
> > -	sec = reloc->sym->sec;
> > -	off = reloc->sym->offset;
> > -
> > -	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
> > -	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
> > -		off += arch_dest_reloc_offset(reloc->addend);
> 
> here...
> 
> > +static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> > +{
> 
> ...
> > +		off = reloc->sym->offset;
> > +		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> > +			off += arch_dest_reloc_offset(reloc->addend);
> > +		else
> > +			off += reloc->addend;
> 
> it looks kind of strange to have arch_dest_reloc_offset() and still 
> reference arch-specific relocation types here. On the other hand it seems 
> difficult to achieve complete arch-agnostic code, so take it just as a 
> note and maybe someone porting objtool to a different architecture will 
> split the code, make it all arch-independent and all will be nice and 
> shiny.

Something like so perhaps? Seems to build and boot x86_64-defconfig.

---
 tools/objtool/arch/x86/decode.c      |  9 +++++++--
 tools/objtool/check.c                | 18 +++++++-----------
 tools/objtool/include/objtool/arch.h |  2 +-
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 8b990a52aada..775e1963ecfc 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -63,9 +63,14 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
-unsigned long arch_dest_reloc_offset(int addend)
+unsigned long arch_dest_reloc_offset(struct reloc *reloc)
 {
-	return addend + 4;
+	unsigned long offset = reloc->sym->offset + reloc->addend;
+
+	if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		offset += 4;
+
+	return offset;
 }
 
 unsigned long arch_jump_destination(struct instruction *insn)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2063f9fea1a2..5752013dd6e8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1295,7 +1295,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			dest_off = arch_jump_destination(insn);
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
-			dest_off = arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc);
 		} else if (reloc->sym->retpoline_thunk) {
 			add_retpoline_call(file, insn);
 			continue;
@@ -1308,8 +1308,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc);
 		} else {
 			/* non-func asm code jumping to another file */
 			continue;
@@ -1413,7 +1412,7 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (reloc->sym->type == STT_SECTION) {
-			dest_off = arch_dest_reloc_offset(reloc->addend);
+			dest_off = arch_dest_reloc_offset(reloc);
 			dest = find_call_destination(reloc->sym->sec, dest_off);
 			if (!dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
@@ -3031,6 +3030,7 @@ static inline const char *call_dest_name(struct instruction *insn)
 static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 {
 	struct symbol *target;
+	unsigned long offset;
 	struct reloc *rel;
 	int idx;
 
@@ -3038,7 +3038,8 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	if (!rel || strcmp(rel->sym->name, "pv_ops"))
 		return false;
 
-	idx = (arch_dest_reloc_offset(rel->addend) / sizeof(void *));
+	offset = arch_dest_reloc_offset(rel) - rel->sym->offset;
+	idx = offset / sizeof(void *);
 
 	if (file->pv_ops[idx].clean)
 		return true;
@@ -3709,12 +3710,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 		if (reloc->sym->static_call_tramp)
 			continue;
 
-		off = reloc->sym->offset;
-		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
-			off += arch_dest_reloc_offset(reloc->addend);
-		else
-			off += reloc->addend;
-
+		off = arch_dest_reloc_offset(reloc);
 		dest = find_insn(file, reloc->sym->sec, off);
 		if (!dest)
 			continue;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 9b19cc304195..57562eaa0967 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -81,7 +81,7 @@ bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
 
-unsigned long arch_dest_reloc_offset(int addend);
+unsigned long arch_dest_reloc_offset(struct reloc *reloc);
 
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
