Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678A50B53B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446712AbiDVKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446706AbiDVKiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953ED6448;
        Fri, 22 Apr 2022 03:35:08 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xT+qLAoOfAcr2C66HVds9bCNQKTB8i7lZ6JommGwPcY=;
        b=KaMq2FtGcceS3TdX7M7AylXLvtUbtwZiRVcxZAFu4w2coEErr77ojB37kZa/jqc7WjmNg1
        v7eubYu+raccdPwClnqsclmOhB+O13vQQcBcjaiZX4+BoS3sjZHzeCuocjjo44Nv3t668v
        US+vCJNtndaUfI09FZx3mW9/1TbzgityWTlVWvjP0vkfluJIabYCShUhGVMkGybYZRTxc7
        p47OFNcuQxxMtVdp4bH1uIbvioOZxsHWstQWR5uTlStSm5GyJ6gNB7tossjh0H+/pisT+R
        tDak9Az8AWkNMegBndDRBQx8bDZQ9OoO0ij0Q/Do5lmXZf73aykkgaAi547h1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xT+qLAoOfAcr2C66HVds9bCNQKTB8i7lZ6JommGwPcY=;
        b=6SXAVdMH2HSHJ8lW3obbdjsXamJEoaJqHGHVenkBw5R8lpeRIjQh5DvRTO+EfSq5H6O6gt
        qnBG69BHjDnDKGDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add option to print section addresses
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2cea4d5299d53d1a4c09212a6ad7820aa46fda7a.1650300597.git.jpoimboe@redhat.com>
References: <2cea4d5299d53d1a4c09212a6ad7820aa46fda7a.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370619.4207.17860193261058344743.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     99c0beb547a3e0ec3a63edeba0960c6ddf2226b0
Gitweb:        https://git.kernel.org/tip/99c0beb547a3e0ec3a63edeba0960c6ddf2226b0
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:02 +02:00

objtool: Add option to print section addresses

To help prevent objtool users from having to do math to convert function
addresses to section addresses, and to help out with finding data
addresses reported by IBT validation, add an option to print the section
address in addition to the function address.

Normal:

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1: unreachable instruction

With '--sec-address':

  vmlinux.o: warning: objtool: fixup_exception()+0x2d1 (.text+0x76c51): unreachable instruction

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/2cea4d5299d53d1a4c09212a6ad7820aa46fda7a.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/builtin-check.c           |  1 +-
 tools/objtool/include/objtool/builtin.h |  1 +-
 tools/objtool/include/objtool/warn.h    | 31 +++++++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 8c3eed5..6acfebd 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -50,6 +50,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
 	OPT_BOOLEAN(0, "no-fp", &opts.no_fp, "skip frame pointer validation"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 44548e2..e0972fb 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -28,6 +28,7 @@ struct opts {
 	bool module;
 	bool no_fp;
 	bool no_unreachable;
+	bool sec_address;
 	bool stats;
 	bool vmlinux;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index c4bde3e..a3e79ae 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -11,30 +11,33 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <objtool/builtin.h>
 #include <objtool/elf.h>
 
 extern const char *objname;
 
 static inline char *offstr(struct section *sec, unsigned long offset)
 {
-	struct symbol *func;
-	char *name, *str;
-	unsigned long name_off;
+	bool is_text = (sec->sh.sh_flags & SHF_EXECINSTR);
+	struct symbol *sym = NULL;
+	char *str;
+	int len;
 
-	func = find_func_containing(sec, offset);
-	if (!func)
-		func = find_symbol_containing(sec, offset);
-	if (func) {
-		name = func->name;
-		name_off = offset - func->offset;
+	if (is_text)
+		sym = find_func_containing(sec, offset);
+	if (!sym)
+		sym = find_symbol_containing(sec, offset);
+
+	if (sym) {
+		str = malloc(strlen(sym->name) + strlen(sec->name) + 40);
+		len = sprintf(str, "%s+0x%lx", sym->name, offset - sym->offset);
+		if (opts.sec_address)
+			sprintf(str+len, " (%s+0x%lx)", sec->name, offset);
 	} else {
-		name = sec->name;
-		name_off = offset;
+		str = malloc(strlen(sec->name) + 20);
+		sprintf(str, "%s+0x%lx", sec->name, offset);
 	}
 
-	str = malloc(strlen(name) + 20);
-	sprintf(str, "%s+0x%lx", name, name_off);
-
 	return str;
 }
 
