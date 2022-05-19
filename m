Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228152DFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbiESV5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbiESV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:57:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B9344F7;
        Thu, 19 May 2022 14:57:21 -0700 (PDT)
Date:   Thu, 19 May 2022 21:57:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652997439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO1FCVu2SSWFKfQv3OY+okyx3D1MuO6JJgRpCWOkx9U=;
        b=gOyA2MXP4CIqultoE9yRaO2bKsUQxCAlSZhINnwfaCCBbHS/Xo/S/3hkC3oOfEF8A1lWnm
        jWwkI9i+zhVWYrMFKFfCeKWLeTWjZbyP9dIjfuXvWtKdxY4xhfOxyCD3yNBQ/ksph4pqCS
        0HvP77B1t62uuRMlHc2Tt/zkvF5ueQ23ycY13FOuXrh+4oDgojf7XxJ8ZNzFxvBQm3myF6
        st+YIh4Q412W3a0+aGGExkONsLl58VAL7bMyTCpT6Ar6JeCfqY9/PKNumta0hZ5kH5goRj
        uReFpSjUineywXdBC25MwYQaUO5c7INKzJdH1ylJHfOZEnaIYI9vp5EuRAEFNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652997439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FO1FCVu2SSWFKfQv3OY+okyx3D1MuO6JJgRpCWOkx9U=;
        b=543SGOF5P24Fm5/a29dOsVlioqY7OLEp60AJ8CZVL2LwMzdJV9jz7w166071/8bq26CtWk
        azM5q9RUg8cSonBw==
From:   "tip-bot2 for Mikulas Patocka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix objtool regression on x32 systems
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Calpine=2ELRH=2E2=2E02=2E2205161041260=2E1155?=
 =?utf-8?q?6=40file01=2Eintranet=2Eprod=2Eint=2Erdu2=2Eredhat=2Ecom=3E?=
References: =?utf-8?q?=3Calpine=2ELRH=2E2=2E02=2E2205161041260=2E11556?=
 =?utf-8?q?=40file01=2Eintranet=2Eprod=2Eint=2Erdu2=2Eredhat=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165299743863.4207.12548831745699348927.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c1d2d643378ce89358f65caf9748a6f044086919
Gitweb:        https://git.kernel.org/tip/c1d2d643378ce89358f65caf9748a6f044086919
Author:        Mikulas Patocka <mpatocka@redhat.com>
AuthorDate:    Mon, 16 May 2022 11:06:36 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 May 2022 23:46:12 +02:00

objtool: Fix objtool regression on x32 systems

Commit c087c6e7b551 ("objtool: Fix type of reloc::addend") failed to
appreciate cross building from ILP32 hosts, where 'int' == 'long' and
the issue persists.

As such, use s64/int64_t/Elf64_Sxword for this field and suffer the
pain that is ISO C99 printf formats for it.

Fixes: c087c6e7b551 ("objtool: Fix type of reloc::addend")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
[peterz: reword changelog, s/long long/s64/]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com
---
 tools/objtool/check.c               |  9 +++++----
 tools/objtool/elf.c                 |  2 +-
 tools/objtool/include/objtool/elf.h |  4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ca5b746..8a0971a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -5,6 +5,7 @@
 
 #include <string.h>
 #include <stdlib.h>
+#include <inttypes.h>
 #include <sys/mman.h>
 
 #include <arch/elf.h>
@@ -560,12 +561,12 @@ static int add_dead_ends(struct objtool_file *file)
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find unreachable insn at %s+0x%lx",
+				WARN("can't find unreachable insn at %s+0x%" PRIx64,
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find unreachable insn at %s+0x%lx",
+			WARN("can't find unreachable insn at %s+0x%" PRIx64,
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
@@ -595,12 +596,12 @@ reachable:
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find reachable insn at %s+0x%lx",
+				WARN("can't find reachable insn at %s+0x%" PRIx64,
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find reachable insn at %s+0x%lx",
+			WARN("can't find reachable insn at %s+0x%" PRIx64,
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 22c2a07..e84cf15 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -547,7 +547,7 @@ static struct section *elf_create_reloc_section(struct elf *elf,
 						int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, long addend)
+		  unsigned int type, struct symbol *sym, s64 addend)
 {
 	struct reloc *reloc;
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9b36802..82e57eb 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -73,7 +73,7 @@ struct reloc {
 	struct symbol *sym;
 	unsigned long offset;
 	unsigned int type;
-	long addend;
+	s64 addend;
 	int idx;
 	bool jump_table_start;
 };
@@ -135,7 +135,7 @@ struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, long addend);
+		  unsigned int type, struct symbol *sym, s64 addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 			  unsigned long offset, unsigned int type,
 			  struct section *insn_sec, unsigned long insn_off);
