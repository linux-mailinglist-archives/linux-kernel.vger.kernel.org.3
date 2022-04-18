Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F7A505CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346665AbiDRQyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346563AbiDRQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAE7C32EFB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTCVITAKKtT6N+NddgrcMOHAiaBY96wu9WoL+d9zWOY=;
        b=CJjaF2IveZASyzqcIvER20tzHm6Fa/aFeHvGPUV6KL4WLYlOS7stZUmZ+ywrpniBhVq9At
        zGFF9KZIUN8wSIMY6C/MICB2tTaRYfO6MFClDfH0LkXNmKnMWCGxRUxE2X3wkOYgcZL46p
        hKoOot5C53EpzK4Xn5t+1EtEgt09Nag=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-ktr8J5deNOylv8AIyrVk8Q-1; Mon, 18 Apr 2022 12:51:16 -0400
X-MC-Unique: ktr8J5deNOylv8AIyrVk8Q-1
Received: by mail-qv1-f71.google.com with SMTP id e10-20020a0562140d8a00b00443c3595342so12578584qve.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTCVITAKKtT6N+NddgrcMOHAiaBY96wu9WoL+d9zWOY=;
        b=QBD9BOtarMZ+P4bCjfPIkoXC8tdjrEOQY4Q3pGYvuihQeUkGpUZQ/W1mmcb6/oMt/a
         w+DvYI/7YZbunOLvsM79HJY6oeLJOpJkRfqP9eWtV9m2LVRFZxFBnLdGLh75/zszNkyl
         mQ+kTycoYmMYq3iKvcfmAS9kTfL/QpZ9F3GUc26aMJQRy4K0VkNR2dVPgSTv/MN3aE4z
         gYzkTXLrf3eLD3IGlqcZnelTFoX6qMJJ548NM5d8978kpl9PsDK1eVsDFSCgPp8Jx5Gm
         guC73sfC8bPbtLFwjN6Z/0pC+P4hnSUNpP+ET6V/vNkqYQcWD46q5X9OjDPF7AZT4cEE
         YqAA==
X-Gm-Message-State: AOAM533Sh0wNjjgwxX4AoDQSmCqVFC2VV4IZ0vfocDTQQ63AFd2OeXcD
        dr6W/WoD8dwTGZa2oH6o/nF5aFUkP1woCm/OgmtpGHCiQQU+zb4i93h616e7JElGcGHhlEkEjjr
        z9yy6O4BuS/QVSuf2r4IBV+Qo
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr6907486qkb.443.1650300675662;
        Mon, 18 Apr 2022 09:51:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi4372uUi3iMUh+JmZIfqcTe4cdvzVUtI6fBEr7GxKDJRYwtqZDQxhqW9x/t1/KeArMEo0/g==
X-Received: by 2002:a37:6412:0:b0:69e:68cf:d889 with SMTP id y18-20020a376412000000b0069e68cfd889mr6907475qkb.443.1650300675308;
        Mon, 18 Apr 2022 09:51:15 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:51:14 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 15/25] objtool: Rework ibt and extricate from stack validation
Date:   Mon, 18 Apr 2022 09:50:34 -0700
Message-Id: <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extricate ibt from validate_branch() so they can be executed (or ported)
independently from each other.

While shuffling code around, simplify and improve the ibt logic:

- Ignore an explicit list of known sections which reference functions
  for reasons other than indirect branching to them.  This helps prevent
  unnnecesary sealing.

- Warn on missing !ENDBR for all other sections, not just .data and
  .rodata.  This finds additional warnings, because there are sections
  other than .[ro]data which reference function pointers.  For example,
  the ksymtab sections which are used for exporting symbols.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 280 ++++++++++++++++++++++--------------------
 1 file changed, 147 insertions(+), 133 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8dc6035fabd2..0059b592195e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3183,114 +3183,6 @@ static struct instruction *next_insn_to_validate(struct objtool_file *file,
 	return next_insn_same_sec(file, insn);
 }
 
-static struct instruction *
-validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
-{
-	struct instruction *dest;
-	struct section *sec;
-	unsigned long off;
-
-	sec = reloc->sym->sec;
-	off = reloc->sym->offset;
-
-	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
-	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
-		off += arch_dest_reloc_offset(reloc->addend);
-	else
-		off += reloc->addend;
-
-	dest = find_insn(file, sec, off);
-	if (!dest)
-		return NULL;
-
-	if (dest->type == INSN_ENDBR) {
-		if (!list_empty(&dest->call_node))
-			list_del_init(&dest->call_node);
-
-		return NULL;
-	}
-
-	if (reloc->sym->static_call_tramp)
-		return NULL;
-
-	return dest;
-}
-
-static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
-			 struct instruction *dest)
-{
-	WARN_FUNC("%srelocation to !ENDBR: %s", sec, offset, msg,
-		  offstr(dest->sec, dest->offset));
-}
-
-static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
-			      struct instruction *dest)
-{
-	if (dest->func && dest->func == insn->func) {
-		/*
-		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
-		 *
-		 * There is no sane way to annotate _THIS_IP_ since the compiler treats the
-		 * relocation as a constant and is happy to fold in offsets, skewing any
-		 * annotation we do, leading to vast amounts of false-positives.
-		 *
-		 * There's also compiler generated _THIS_IP_ through KCOV and
-		 * such which we have no hope of annotating.
-		 *
-		 * As such, blanket accept self-references without issue.
-		 */
-		return;
-	}
-
-	if (dest->noendbr)
-		return;
-
-	warn_noendbr("", insn->sec, insn->offset, dest);
-}
-
-static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
-{
-	struct instruction *dest;
-	struct reloc *reloc;
-
-	switch (insn->type) {
-	case INSN_CALL:
-	case INSN_CALL_DYNAMIC:
-	case INSN_JUMP_CONDITIONAL:
-	case INSN_JUMP_UNCONDITIONAL:
-	case INSN_JUMP_DYNAMIC:
-	case INSN_JUMP_DYNAMIC_CONDITIONAL:
-	case INSN_RETURN:
-		/*
-		 * We're looking for code references setting up indirect code
-		 * flow. As such, ignore direct code flow and the actual
-		 * dynamic branches.
-		 */
-		return;
-
-	case INSN_NOP:
-		/*
-		 * handle_group_alt() will create INSN_NOP instruction that
-		 * don't belong to any section, ignore all NOP since they won't
-		 * carry a (useful) relocation anyway.
-		 */
-		return;
-
-	default:
-		break;
-	}
-
-	for (reloc = insn_reloc(file, insn);
-	     reloc;
-	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					      reloc->offset + 1,
-					      (insn->offset + insn->len) - (reloc->offset + 1))) {
-		dest = validate_ibt_reloc(file, reloc);
-		if (dest)
-			validate_ibt_dest(file, insn, dest);
-	}
-}
-
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3500,9 +3392,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 		}
 
-		if (opts.ibt)
-			validate_ibt_insn(file, insn);
-
 		if (insn->dead_end)
 			return 0;
 
@@ -3788,48 +3677,173 @@ static int validate_functions(struct objtool_file *file)
 	return warnings;
 }
 
-static int validate_ibt(struct objtool_file *file)
+static void mark_endbr_used(struct instruction *insn)
 {
-	struct section *sec;
+	if (!list_empty(&insn->call_node))
+		list_del_init(&insn->call_node);
+}
+
+static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+{
+	struct instruction *dest;
 	struct reloc *reloc;
+	unsigned long off;
+	int warnings = 0;
 
-	for_each_sec(file, sec) {
-		bool is_data;
+	/*
+	 * Looking for function pointer load relocations.  Ignore
+	 * direct/indirect branches:
+	 */
+	switch (insn->type) {
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+	case INSN_JUMP_DYNAMIC:
+	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+	case INSN_RETURN:
+	case INSN_NOP:
+		return 0;
+	default:
+		break;
+	}
 
-		/* already done in validate_branch() */
-		if (sec->sh.sh_flags & SHF_EXECINSTR)
-			continue;
+	for (reloc = insn_reloc(file, insn);
+	     reloc;
+	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					      reloc->offset + 1,
+					      (insn->offset + insn->len) - (reloc->offset + 1))) {
 
-		if (!sec->reloc)
+		/*
+		 * static_call_update() references the trampoline, which
+		 * doesn't have (or need) ENDBR.  Skip warning in that case.
+		 */
+		if (reloc->sym->static_call_tramp)
 			continue;
 
-		if (!strncmp(sec->name, ".orc", 4))
+		off = reloc->sym->offset;
+		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+			off += arch_dest_reloc_offset(reloc->addend);
+		else
+			off += reloc->addend;
+
+		dest = find_insn(file, reloc->sym->sec, off);
+		if (!dest)
 			continue;
 
-		if (!strncmp(sec->name, ".discard", 8))
+		if (dest->type == INSN_ENDBR) {
+			mark_endbr_used(dest);
 			continue;
+		}
 
-		if (!strncmp(sec->name, ".debug", 6))
+		if (dest->func && dest->func == insn->func) {
+			/*
+			 * Anything from->to self is either _THIS_IP_ or
+			 * IRET-to-self.
+			 *
+			 * There is no sane way to annotate _THIS_IP_ since the
+			 * compiler treats the relocation as a constant and is
+			 * happy to fold in offsets, skewing any annotation we
+			 * do, leading to vast amounts of false-positives.
+			 *
+			 * There's also compiler generated _THIS_IP_ through
+			 * KCOV and such which we have no hope of annotating.
+			 *
+			 * As such, blanket accept self-references without
+			 * issue.
+			 */
 			continue;
+		}
 
-		if (!strcmp(sec->name, "_error_injection_whitelist"))
+		if (dest->noendbr)
 			continue;
 
-		if (!strcmp(sec->name, "_kprobe_blacklist"))
+		WARN_FUNC("relocation to !ENDBR: %s",
+			  insn->sec, insn->offset,
+			  offstr(dest->sec, dest->offset));
+
+		warnings++;
+	}
+
+	return warnings;
+}
+
+static int validate_ibt_data_reloc(struct objtool_file *file,
+				   struct reloc *reloc)
+{
+	struct instruction *dest;
+
+	dest = find_insn(file, reloc->sym->sec,
+			 reloc->sym->offset + reloc->addend);
+	if (!dest)
+		return 0;
+
+	if (dest->type == INSN_ENDBR) {
+		mark_endbr_used(dest);
+		return 0;
+	}
+
+	if (dest->noendbr)
+		return 0;
+
+	WARN_FUNC("data relocation to !ENDBR: %s",
+		  reloc->sec->base, reloc->offset,
+		  offstr(dest->sec, dest->offset));
+
+	return 1;
+}
+
+/*
+ * Validate IBT rules and remove used ENDBR instructions from the seal list.
+ * Unused ENDBR instructions will be annotated for sealing (i.e., replaced with
+ * NOPs) later, in create_ibt_endbr_seal_sections().
+ */
+static int validate_ibt(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn)
+		warnings += validate_ibt_insn(file, insn);
+
+	for_each_sec(file, sec) {
+
+		/* Already done by validate_ibt_insn() */
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
 			continue;
 
-		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
+		if (!sec->reloc)
+			continue;
 
-		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
-			struct instruction *dest;
+		/*
+		 * These sections can reference text addresses, but not with
+		 * the intent to indirect branch to them.
+		 */
+		if (!strncmp(sec->name, ".discard", 8)			||
+		    !strncmp(sec->name, ".debug", 6)			||
+		    !strcmp(sec->name, ".altinstructions")		||
+		    !strcmp(sec->name, ".ibt_endbr_seal")		||
+		    !strcmp(sec->name, ".orc_unwind_ip")		||
+		    !strcmp(sec->name, ".parainstructions")		||
+		    !strcmp(sec->name, ".retpoline_sites")		||
+		    !strcmp(sec->name, ".smp_locks")			||
+		    !strcmp(sec->name, ".static_call_sites")		||
+		    !strcmp(sec->name, "_error_injection_whitelist")	||
+		    !strcmp(sec->name, "_kprobe_blacklist")		||
+		    !strcmp(sec->name, "__bug_table")			||
+		    !strcmp(sec->name, "__ex_table")			||
+		    !strcmp(sec->name, "__jump_table")			||
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    !strcmp(sec->name, "__tracepoints"))
+			continue;
 
-			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr)
-				warn_noendbr("data ", sec, reloc->offset, dest);
-		}
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
+			warnings += validate_ibt_data_reloc(file, reloc);
 	}
 
-	return 0;
+	return warnings;
 }
 
 static int validate_reachable_instructions(struct objtool_file *file)
@@ -3900,7 +3914,7 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	if (opts.stackval || opts.orc || opts.uaccess || opts.ibt || opts.sls) {
+	if (opts.stackval || opts.orc || opts.uaccess || opts.sls) {
 		ret = validate_functions(file);
 		if (ret < 0)
 			goto out;
-- 
2.34.1

