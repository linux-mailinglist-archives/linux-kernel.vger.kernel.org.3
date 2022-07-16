Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BB3577270
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGPXRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiGPXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E7522BCC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:26 -0700 (PDT)
Message-ID: <20220716230953.205004151@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=08QH2YM/1Di8RC5cyk9vD0xjmV190+dyfUw7UHxm3Ko=;
        b=vEi4ExZA1d0vxPBYQIeE4UnGrv0F59Oknn92PiWUPmxt3YpuKRIo8vtpjSKFn4wrA4Aqlf
        TyX6xBOTPA//coSn3ZAZgH6nKAw8/u+z7JFLNjcLvJVD3pEFYrMpFhr+3cSVrjUjYJy+Yi
        qYXpS1am6E+d1mgpo3J6gkkb9RgLlpT6E6YpFkC37p2v4NTRv8l9m/LBtpKnltMnHdC/o5
        BA9jpi0o5A7lOydNKgcBqTUrH5IbuWEJkKC/POdIYhIlbu6cDgqDNLDMyAmva2X0xwcf4i
        B3l6gzQBxsCeGBrOcio9JtzAlWidomw0sDoW7vvONzhMaQmEpCZpLspNfI+oMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=08QH2YM/1Di8RC5cyk9vD0xjmV190+dyfUw7UHxm3Ko=;
        b=oAXaQqRtn8Rcp1W7qeYV1HSmc730sVKlmHSRsOvMYoyEdrbWaaMIG7/OSYExnCOSVCkmKY
        I2HlxhAihSn4muDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 09/38] objtool: Add .sym_sites section
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation for call depth tracking provide a section which collects all
all !init symbols to generate thunks for.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/vmlinux.lds.S |    7 +++++
 tools/objtool/check.c         |   55 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -297,6 +297,13 @@ SECTIONS
 		*(.call_sites)
 		__call_sites_end = .;
 	}
+
+	. = ALIGN(8);
+	.sym_sites : AT(ADDR(.sym_sites) - LOAD_OFFSET) {
+		__sym_sites = .;
+		*(.sym_sites)
+		__sym_sites_end = .;
+	}
 #endif
 
 #ifdef CONFIG_X86_KERNEL_IBT
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -941,6 +941,56 @@ static int create_direct_call_sections(s
 	return 0;
 }
 
+static int create_sym_thunk_sections(struct objtool_file *file)
+{
+	struct section *sec, *s;
+	struct symbol *sym;
+	unsigned int *loc;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".sym_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->call_list);
+		WARN("file already has .sym_sites section, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	for_each_sec(file, s) {
+		if (!s->text || s->init)
+			continue;
+
+		list_for_each_entry(sym, &s->symbol_list, list)
+			idx++;
+	}
+
+	sec = elf_create_section(file->elf, ".sym_sites", 0, sizeof(unsigned int), idx);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	for_each_sec(file, s) {
+		if (!s->text || s->init)
+			continue;
+
+		list_for_each_entry(sym, &s->symbol_list, list) {
+
+			loc = (unsigned int *)sec->data->d_buf + idx;
+			memset(loc, 0, sizeof(unsigned int));
+
+			if (elf_add_reloc_to_insn(file->elf, sec,
+						idx * sizeof(unsigned int),
+						R_X86_64_PC32,
+						s, sym->offset))
+				return -1;
+
+			idx++;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -4326,6 +4376,11 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+
+		ret = create_sym_thunk_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.mcount) {

