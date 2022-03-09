Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337594D29D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiCIHzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiCIHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001014864D;
        Tue,  8 Mar 2022 23:54:45 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKA1SKca088pSphus7pr9w8vqeURlCrbpnakK/vk//4=;
        b=NqY999dJwe2+Vki6y3UK/bK/BB5AT2/oHlbHVjXvLV6xSwfIBXPA4HdLKt7HIbyuOWEJ9a
        l+Hx+QHujo4yeA5RzRvDDvFN83xkJ9tuvrnW7IwRMoeeXbopqoqQ5x3XsK4+zbxnBp+K7o
        90fafpezE+cqi3nvmTgUGWjTumRmzwsc/2ajycltndBaH+w0ojF3++NWOpGOYSKa9R00B9
        JG96dM112O4KPce2uihmFnxvASTEKYVrkine5EqnAhOxSKwcBLdNCnjnDvCIi4XnHsSrO7
        3M+niYBK+gx23ZhhYL6SUHLeJWtgs+3iAZNTzIRnpp/AwTlbcaVJbYhO/oIBow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKA1SKca088pSphus7pr9w8vqeURlCrbpnakK/vk//4=;
        b=Tw0spqC1D9O5KEYlpOI7NmFEhkdGfgi11YouVOWGjTfB4iGkYz3DtqCIpoexFIrLK0E9Gs
        /GsXQxouRXFxv+AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Read the NOENDBR annotation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.586815435@infradead.org>
References: <20220308154319.586815435@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248280.16921.171251912122821380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     51727f8e4a1ae15770ac30f05a90536c4aa3b2d8
Gitweb:        https://git.kernel.org/tip/51727f8e4a1ae15770ac30f05a90536c4aa3b2d8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:38 +01:00

objtool: Read the NOENDBR annotation

Read the new NOENDBR annotation. While there, attempt to not bloat
struct instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.586815435@infradead.org
---
 tools/objtool/check.c                 | 27 ++++++++++++++++++++++++++-
 tools/objtool/include/objtool/check.h | 13 ++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index aee6246..3f28ca4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1865,6 +1865,29 @@ static int read_unwind_hints(struct objtool_file *file)
 	return 0;
 }
 
+static int read_noendbr_hints(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.noendbr");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
+		if (!insn) {
+			WARN("bad .discard.noendbr entry");
+			return -1;
+		}
+
+		insn->noendbr = 1;
+	}
+
+	return 0;
+}
+
 static int read_retpoline_hints(struct objtool_file *file)
 {
 	struct section *sec;
@@ -2098,6 +2121,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_noendbr_hints(file);
+	if (ret)
+		return ret;
+
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 6cfff07..f10d737 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -45,11 +45,18 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool dead_end, ignore, ignore_alts;
-	bool hint;
-	bool retpoline_safe;
+
+	u8 dead_end	: 1,
+	   ignore	: 1,
+	   ignore_alts	: 1,
+	   hint		: 1,
+	   retpoline_safe : 1,
+	   noendbr	: 1;
+		/* 2 bit hole */
 	s8 instr;
 	u8 visited;
+	/* u8 hole */
+
 	struct alt_group *alt_group;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
