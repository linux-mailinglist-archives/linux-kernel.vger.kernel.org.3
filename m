Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFCC4BBE25
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiBRRQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiBRRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF944D611
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=drGG7z9wXSjoirqs/jFmcbkXc11ClO+eo/+GaDxmf4w=; b=MMSuTorFKcNO6+EtqdLBOLZvMZ
        eegfpsCBEe04o/6rJv6/QTUWS/nSRW9ap++8uSChmKh4prIQRUb/n60ndBE9cp/JCuoVjLVB65iaW
        /DPmns8GY3KuF3x9pY2zoS7TB0aT8m4gkZpY4xcQh2sPgf47JsvNLaQ33pE8Zs4k6g+GBHej9A5TP
        bbS3d0FrzG27dqgcL+VX+JBO4JSWOgbd06MOLq/ko2GgkPRoDr8pwQEnojAw+IgmTbfVn/9oidaqn
        TTPokJ+qr2LHh3aY/FbtgIMPcisABNXYCPjSdR8gXNq7Bw2HrLWmrEyE/1OCePKhH3PgeKBy/7Aws
        90oCp+Fg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBk-Qq; Fri, 18 Feb 2022 17:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6D62302A12;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 636C52B09A2B7; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.930927223@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 23/29] objtool: Read the NOENDBR annotation
References: <20220218164902.008644515@infradead.org>
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

Read the new NOENDBR annotation. While there, attempt to not bloat
struct instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                 |   27 +++++++++++++++++++++++++++
 tools/objtool/include/objtool/check.h |   13 ++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1860,6 +1860,29 @@ static int read_unwind_hints(struct objt
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
@@ -2097,6 +2120,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_noendbr_hints(file);
+	if (ret)
+		return ret;
+
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
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


