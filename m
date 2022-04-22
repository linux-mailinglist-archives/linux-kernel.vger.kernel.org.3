Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663950B50E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446629AbiDVKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446606AbiDVKaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414F54F8D;
        Fri, 22 Apr 2022 03:28:01 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NPhGkqiIRSiKEgZ/x9p1hdB7pLgPeewg3bgoeGfczc=;
        b=OhPtiXr7DVBbBWFaLoMvDR76SvEwFFpiMBrb8Z9h1Ad4cKO3beLfD8b6/EQxKo+rKVR0M8
        DMEg3bAO6f/eg1zBZWuz7RxX+CO4me47+c35am8pAoaWNW9/52K2+FUtLyCJSRfnf4wCPD
        jNKVO/fy9FtxCclkrDGsgPY7an0bzOI8KKf0jzxoWsktKZffz4GEcMEv4wMVZN9/TEsLST
        N0LynCXdezZcHx0qbYsJFxr5noIDPQ2z2RP1ROprJ8+tIwoJdarO3QH4HdIJ4Y73llHvYz
        kRv7sEigh1hUyM7hpDPP1uejNvfAtIrRlRV3BimLNu1tAHzkzY11NtTtji7vYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4NPhGkqiIRSiKEgZ/x9p1hdB7pLgPeewg3bgoeGfczc=;
        b=LCl6rgMa+6ZAoGVHGDccIdNLdfkIoOKy0VNtvm9a6HCYSnG6DA6YzP4RT/7Hnc5Q17frG/
        s79fNB7d6rLBddAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix type of reloc::addend
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220419203807.596871927@infradead.org>
References: <20220419203807.596871927@infradead.org>
MIME-Version: 1.0
Message-ID: <165062327903.4207.5493412767018613140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c087c6e7b551b7f208c0b852304f044954cf2bb3
Gitweb:        https://git.kernel.org/tip/c087c6e7b551b7f208c0b852304f044954cf2bb3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 17 Apr 2022 17:03:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:13:55 +02:00

objtool: Fix type of reloc::addend

Elf{32,64}_Rela::r_addend is of type: Elf{32,64}_Sword, that means
that our reloc::addend needs to be long or face tuncation issues when
we do elf_rebuild_reloc_section():

  - 107:  48 b8 00 00 00 00 00 00 00 00   movabs $0x0,%rax        109: R_X86_64_64        level4_kernel_pgt+0x80000067
  + 107:  48 b8 00 00 00 00 00 00 00 00   movabs $0x0,%rax        109: R_X86_64_64        level4_kernel_pgt-0x7fffff99

Fixes: 627fce14809b ("objtool: Add ORC unwind table generation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20220419203807.596871927@infradead.org
---
 tools/objtool/check.c               | 8 ++++----
 tools/objtool/elf.c                 | 2 +-
 tools/objtool/include/objtool/elf.h | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f10653..3f67854 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -559,12 +559,12 @@ static int add_dead_ends(struct objtool_file *file)
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find unreachable insn at %s+0x%x",
+				WARN("can't find unreachable insn at %s+0x%lx",
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find unreachable insn at %s+0x%x",
+			WARN("can't find unreachable insn at %s+0x%lx",
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
@@ -594,12 +594,12 @@ reachable:
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find reachable insn at %s+0x%x",
+				WARN("can't find reachable insn at %s+0x%lx",
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find reachable insn at %s+0x%x",
+			WARN("can't find reachable insn at %s+0x%lx",
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d7b99a7..0cfe84a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -546,7 +546,7 @@ static struct section *elf_create_reloc_section(struct elf *elf,
 						int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, int addend)
+		  unsigned int type, struct symbol *sym, long addend)
 {
 	struct reloc *reloc;
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 22ba7e2..9b36802 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -73,7 +73,7 @@ struct reloc {
 	struct symbol *sym;
 	unsigned long offset;
 	unsigned int type;
-	int addend;
+	long addend;
 	int idx;
 	bool jump_table_start;
 };
@@ -135,7 +135,7 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, int addend);
+		  unsigned int type, struct symbol *sym, long addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 			  unsigned long offset, unsigned int type,
 			  struct section *insn_sec, unsigned long insn_off);
