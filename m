Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0011B5287FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbiEPPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiEPPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B448A3BA58
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652713598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MK6D+bJiFWt3b7kQJCbuCST0iXmLyf1vvMx1vsAtPqA=;
        b=ONQSwI9jqHNXUCNyX40z/LOGMz+WwKm3Vi3n671g/GAGojbJFKyMyYV2vNEvTLyaYDi1sv
        lc0gZWuKFoSFB2J1JZMlwAbwINZ9ov7Kzd8hkzSBIPqCRoL2sDqZVFvdJOv7cSE1Yq8DOp
        iTAUY19xs8en9+kQiTXNIICmNtnPHKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-HLt0MPhlNrenRqNaybuwYA-1; Mon, 16 May 2022 11:06:37 -0400
X-MC-Unique: HLt0MPhlNrenRqNaybuwYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42013858293;
        Mon, 16 May 2022 15:06:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C11E2166B25;
        Mon, 16 May 2022 15:06:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 24GF6bog021668;
        Mon, 16 May 2022 11:06:37 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 24GF6aNO021664;
        Mon, 16 May 2022 11:06:36 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 16 May 2022 11:06:36 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: fix objtool regression on x32 systems
Message-ID: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols") makes
the kernel unbootable.  The patch c087c6e7b551 ("objtool: Fix type of
reloc::addend") attempts to fix it by replacing 'int' with 'long'.

However, we may be running on a system with x32 ABI and 'long' on x32 is
32-bit, thus the patch c087c6e7b551 doesn't really change anything and we
still end up with miscompiled kernel.  This patch replaces 'long' with
'long long', so that the 64-bit kernel is correctly compiled on a x32
system.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols")
Fixes: c087c6e7b551 ("objtool: Fix type of reloc::addend")

---
 tools/objtool/check.c               |    8 ++++----
 tools/objtool/elf.c                 |    2 +-
 tools/objtool/include/objtool/elf.h |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6/tools/objtool/check.c
===================================================================
--- linux-2.6.orig/tools/objtool/check.c	2022-05-16 16:20:49.000000000 +0200
+++ linux-2.6/tools/objtool/check.c	2022-05-16 16:22:11.000000000 +0200
@@ -560,12 +560,12 @@ static int add_dead_ends(struct objtool_
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find unreachable insn at %s+0x%lx",
+				WARN("can't find unreachable insn at %s+0x%llx",
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find unreachable insn at %s+0x%lx",
+			WARN("can't find unreachable insn at %s+0x%llx",
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
@@ -595,12 +595,12 @@ reachable:
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find reachable insn at %s+0x%lx",
+				WARN("can't find reachable insn at %s+0x%llx",
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find reachable insn at %s+0x%lx",
+			WARN("can't find reachable insn at %s+0x%llx",
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
Index: linux-2.6/tools/objtool/elf.c
===================================================================
--- linux-2.6.orig/tools/objtool/elf.c	2022-05-16 16:20:49.000000000 +0200
+++ linux-2.6/tools/objtool/elf.c	2022-05-16 16:22:21.000000000 +0200
@@ -546,7 +546,7 @@ static struct section *elf_create_reloc_
 						int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, long addend)
+		  unsigned int type, struct symbol *sym, long long addend)
 {
 	struct reloc *reloc;
 
Index: linux-2.6/tools/objtool/include/objtool/elf.h
===================================================================
--- linux-2.6.orig/tools/objtool/include/objtool/elf.h	2022-05-16 16:07:54.000000000 +0200
+++ linux-2.6/tools/objtool/include/objtool/elf.h	2022-05-16 16:22:45.000000000 +0200
@@ -73,7 +73,7 @@ struct reloc {
 	struct symbol *sym;
 	unsigned long offset;
 	unsigned int type;
-	long addend;
+	long long addend;
 	int idx;
 	bool jump_table_start;
 };
@@ -135,7 +135,7 @@ struct elf *elf_open_read(const char *na
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, long addend);
+		  unsigned int type, struct symbol *sym, long long addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 			  unsigned long offset, unsigned int type,
 			  struct section *insn_sec, unsigned long insn_off);

