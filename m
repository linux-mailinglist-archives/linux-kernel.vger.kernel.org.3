Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65426507B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357712AbiDSUmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357702AbiDSUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:42:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957A41981
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7J6l86YgmhW+adRF5XGzfa7mk02W/0pkDVJc+asyeGs=; b=EbY4OFP1CCZ6LayJc0a09lOaCV
        BJxDmmvDg2RSYgW4QfpxycVWoNCrrDSpusxELsk/I7EOaEycpBIC+VPSx607kYb+b+R96Byw/2ltX
        nVBcdnpPxrgWRi6jMk2wjLaSyIoVvlxD6NGw0BJ0aVtaJsis62t5cueIDtan6Gn2onh4Tfb4DWLlg
        9Lajao7cbxVrsbWmKlX2cLGQjZcI8TkzaxCJ2buQz3o1esFNfsg17OqGCNhkq01fEyZGnwxf1HDSv
        Z+/4tXzlS1NoRuh5/xsMyq59nvegwrXO7RKUyhu7TmfEuij11lkGVfPpwRa6bT5AcCq+NPfdxhLOA
        EzW1MNcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngudM-003UC2-O8; Tue, 19 Apr 2022 20:39:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A86A430031E;
        Tue, 19 Apr 2022 22:39:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 75C302B526F01; Tue, 19 Apr 2022 22:39:34 +0200 (CEST)
Message-ID: <20220419203807.596871927@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 19 Apr 2022 22:32:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
Subject: [PATCH 1/2] objtool: Fix type of reloc::addend
References: <20220419203254.034493341@infradead.org>
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

Elf{32,64}_Rela::r_addend is of type: Elf{32,64}_Sword, that means
that our reloc::addend needs to be long or face tuncation issues when
we do elf_rebuild_reloc_section():

  - 107:  48 b8 00 00 00 00 00 00 00 00   movabs $0x0,%rax        109: R_X86_64_64        level4_kernel_pgt+0x80000067
  + 107:  48 b8 00 00 00 00 00 00 00 00   movabs $0x0,%rax        109: R_X86_64_64        level4_kernel_pgt-0x7fffff99

Fixes: 627fce14809b ("objtool: Add ORC unwind table generation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c               |    8 ++++----
 tools/objtool/elf.c                 |    2 +-
 tools/objtool/include/objtool/elf.h |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -560,12 +560,12 @@ static int add_dead_ends(struct objtool_
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
@@ -595,12 +595,12 @@ static int add_dead_ends(struct objtool_
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
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -546,7 +546,7 @@ static struct section *elf_create_reloc_
 						int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, int addend)
+		  unsigned int type, struct symbol *sym, long addend)
 {
 	struct reloc *reloc;
 
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
@@ -135,7 +135,7 @@ struct elf *elf_open_read(const char *na
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, int addend);
+		  unsigned int type, struct symbol *sym, long addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 			  unsigned long offset, unsigned int type,
 			  struct section *insn_sec, unsigned long insn_off);


