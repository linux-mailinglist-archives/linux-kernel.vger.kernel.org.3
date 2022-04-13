Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED30500285
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiDMXXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiDMXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16D4323BF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1498SmuR6dXVDwcCXccoABHA14ZfP4NbQRKlblxZUE8=;
        b=NWIlRqslFoSjQkWeQLQqoPdUEzYWhhL0bhRMOPQlNe+k4tvXWOSgEzB1FhA45oQYfm4bZo
        xT6jXMTMjghksGbSQCC9acHndXW81k8BUO2HSybBPJ03TFhypQ5uPesQG4aUNjKZPmRX3D
        jF+xoE3uIsvTYhf9o/Qz27VNkPwzjP4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-eMtUgswPNB2D_v3ikpw_OQ-1; Wed, 13 Apr 2022 19:20:14 -0400
X-MC-Unique: eMtUgswPNB2D_v3ikpw_OQ-1
Received: by mail-qk1-f199.google.com with SMTP id l68-20020a378947000000b0067df0c430d8so2155275qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1498SmuR6dXVDwcCXccoABHA14ZfP4NbQRKlblxZUE8=;
        b=FYWH3IBSlhl8t10d7Cn7phHCLdOM55bC0JMCeTKtenbAJxi/cWFSbjW/edQROTF0TX
         Oglp7lmxvD1EWgckZk1sXxEKSMOsPSs+sg1zWGb/0V+vjK2hFBEur/+iJdCot9K6f+RP
         xahN4CUhXJQF+p2UgpMbr6a5NmRIsgiV6njv8hgYuHGyl5bR6NFI6gftW1SFF1kCj0I9
         eYY/clFM/wazVACIdjfjc4CQhTXBGLmUXLmJbqvL03pkq35SE0IYTRigdAlWi+vgrtCF
         IzBxCgPyM73vnAyOTD+qzu4yA/1Nglz5xDtKNdqZe2Fn8aqgBoNCMShSQDkGUl/pjCzQ
         CmSg==
X-Gm-Message-State: AOAM532bFC5AGD9ni6AZWs1ybCxH7Ju2zhVlrw5SALSg85DFmAYXYyrm
        X603S+eJHPhq/7G+eCID6MY6R4P2BrcIYgzlhJDIRPhrPfJ66EKxrq+ED3xp4SWCMPdkQK7hvY0
        hIfi+u1k6JNiRellWyF7dfqwj
X-Received: by 2002:a05:622a:1f0c:b0:2ed:1211:364 with SMTP id ca12-20020a05622a1f0c00b002ed12110364mr8963158qtb.390.1649892013294;
        Wed, 13 Apr 2022 16:20:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHHULL64mNi2ZC2/GeA9LWKnn81plj+ysbuIU1b3kMkC+vGB7l+2HTZxadeCnUO9GKcyV/3w==
X-Received: by 2002:a05:622a:1f0c:b0:2ed:1211:364 with SMTP id ca12-20020a05622a1f0c00b002ed12110364mr8963145qtb.390.1649892012967;
        Wed, 13 Apr 2022 16:20:12 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:12 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 10/18] objtool: Extricate ibt from stack validation
Date:   Wed, 13 Apr 2022 16:19:45 -0700
Message-Id: <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extricate ibt from validate_branch() in preparation for making stack
validation optional.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 253 ++++++++++++++++++++----------------------
 1 file changed, 120 insertions(+), 133 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bb25937b2d1c..1b1e7a4ae18b 100644
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
-		  offstr(dest->sec, dest->offset, false));
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
 
@@ -3788,48 +3677,146 @@ static int validate_functions(struct objtool_file *file)
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
-			continue;
+		off = reloc->sym->offset;
+		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+			off += arch_dest_reloc_offset(reloc->addend);
+		else
+			off += reloc->addend;
 
-		if (!strncmp(sec->name, ".discard", 8))
+		dest = find_insn(file, reloc->sym->sec, off);
+		if (!dest)
 			continue;
 
-		if (!strncmp(sec->name, ".debug", 6))
+		if (dest->type == INSN_ENDBR) {
+			mark_endbr_used(dest);
 			continue;
+		}
 
-		if (!strcmp(sec->name, "_error_injection_whitelist"))
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
 
-		if (!strcmp(sec->name, "_kprobe_blacklist"))
+		if (dest->noendbr)
 			continue;
 
-		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
+		WARN_FUNC("relocation to !ENDBR: %s",
+			  insn->sec, insn->offset,
+			  offstr(dest->sec, dest->offset, false));
 
-		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
-			struct instruction *dest;
+		warnings++;
+	}
 
-			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr)
-				warn_noendbr("data ", sec, reloc->offset, dest);
-		}
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
 	}
 
-	return 0;
+	if (dest->noendbr)
+		return 0;
+
+	WARN_FUNC("data relocation to !ENDBR: %s",
+	     reloc->sec->base, reloc->offset,
+	     offstr(dest->sec, dest->offset, false));
+
+	return 1;
+}
+
+
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
+		if (!strstr(sec->name, ".data") && !strstr(sec->name, ".rodata"))
+			continue;
+
+		if (!sec->reloc)
+			continue;
+
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
+			warnings += validate_ibt_data_reloc(file, reloc);
+	}
+
+	return warnings;
 }
 
 static int validate_reachable_instructions(struct objtool_file *file)
-- 
2.34.1

