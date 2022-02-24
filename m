Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC44C2F45
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiBXPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiBXPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91826144F40
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=drGG7z9wXSjoirqs/jFmcbkXc11ClO+eo/+GaDxmf4w=; b=b0Wx4r9GCxn8hyO1lVFi4L76b6
        S8bPCLORwEm9cnQaZUCQWXDdg6mpG7B4rd6AHYx7W1wdUtH48tSn6hCjqXUaOK6/rOor1jbKsbVAt
        YXwevUeYIxTxbyPtXt5iGqatguyLq5KD1IAIwl9Xl2vRBwlL29RdD4+DDLeGZz2P7LAf/iAsCfDKS
        e575i/RG9cmQvWDGF3Ec67SXO7etTeuhUNRy/lXU4DBnEPIj0LCs+/KqQWIfSroTa02Q77cZ5Q/3D
        Dct+YkrJe6i0h48RzxfmCdURCwzI37SiKgySq7O4/BaT/Cil/rYypgjYKN5c5ry8aUSK82d9NxHn2
        +Y7ATpYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs3-00CeM4-Vg; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49DE6302D49;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 988822B3547A5; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151323.840354003@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 31/39] objtool: Read the NOENDBR annotation
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


