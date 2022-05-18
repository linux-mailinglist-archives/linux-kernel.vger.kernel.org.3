Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775C352BC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiERNaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiERN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0164C1A359B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652880542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WcMQ1jNwCWloTdpOHWUHdU6u3lkdhIdHHgvKjDKaJhQ=;
        b=BkiNZUDvd5+Uvr6ZB6TLe1z7GEKJmTAENtFTijTBYOnkH1WyL9Djy8yIrJWHquqYSlJMfP
        Tw5qNGrersurt4DZygF3PXhXGGYZal+KWrGjNcrhECPsPKOOQxoG/Cb3XnnsxODShpc+NF
        tc5BYKtdASqU7Ou8LHQ8KIh+6Pf4acA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-PWzgkEwWPLmtbfnu11grTA-1; Wed, 18 May 2022 09:28:58 -0400
X-MC-Unique: PWzgkEwWPLmtbfnu11grTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CFFD18E0044;
        Wed, 18 May 2022 13:28:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 723CF400E118;
        Wed, 18 May 2022 13:28:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 24IDSwo0014628;
        Wed, 18 May 2022 09:28:58 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 24IDSvJx014624;
        Wed, 18 May 2022 09:28:58 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 18 May 2022 09:28:57 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] objtool: fix objtool regression on x32 systems
In-Reply-To: <20220516212517.GP76023@worktop.programming.kicks-ass.net>
Message-ID: <alpine.LRH.2.02.2205180813200.22292@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com> <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net> <alpine.LRH.2.02.2205161145070.30905@file01.intranet.prod.int.rdu2.redhat.com>
 <20220516212517.GP76023@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 May 2022, Peter Zijlstra wrote:

> On Mon, May 16, 2022 at 11:56:21AM -0400, Mikulas Patocka wrote:
> > 
> > With this patch, the compiled kernel works. With kernels 5.17 or older, it 
> > also works. I bisected it and the breakage is caused by the commit 
> > 4abff6d48dbc.
> 
> Sure; but it works doesn't mean there aren't more latent issues. ILP32
> hosted (cross) builds just aren't a thing I've ever considered. If we
> really want to go support that then we should at least audit the whole
> thing.
> 
> A quick look seems to suggest at least all the 'offset' fields should be
> u64 or something. The only reason that works is because -mcmodel=kernel
> keeps everything in the 2G range to make s32 immediates work. But it
> isn't right.

There are many 'offset' variables and its hard to determine which should 
be 64-bit. Would it be possible to commit this patch, so that kernel 5.18 
can be compiled on x32 distributions? And you can do code refactoring in 
the next merge window.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>

The patch 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols") makes
the kernel unbootable.  The patch c087c6e7b551 ("objtool: Fix type of
reloc::addend") attempts to fix it by replacing 'int' with 'long'.

However, we may be running on a system with x32 ABI and 'long' on x32 is
32-bit, thus the patch c087c6e7b551 doesn't really change anything and we
still end up with miscompiled kernel.  This patch replaces 'long' with
's64', so that the 64-bit kernel is correctly compiled on a x32 system.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols")
Fixes: c087c6e7b551 ("objtool: Fix type of reloc::addend")

---
 tools/objtool/check.c               |    9 +++++----
 tools/objtool/elf.c                 |    2 +-
 tools/objtool/include/objtool/elf.h |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

Index: linux-2.6/tools/objtool/check.c
===================================================================
--- linux-2.6.orig/tools/objtool/check.c	2022-05-18 13:51:22.000000000 +0200
+++ linux-2.6/tools/objtool/check.c	2022-05-18 13:52:37.000000000 +0200
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <sys/mman.h>
+#include <inttypes.h>
 
 #include <arch/elf.h>
 #include <objtool/builtin.h>
@@ -560,12 +561,12 @@ static int add_dead_ends(struct objtool_
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find unreachable insn at %s+0x%lx",
+				WARN("can't find unreachable insn at %s+0x%"PRIx64,
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find unreachable insn at %s+0x%lx",
+			WARN("can't find unreachable insn at %s+0x%"PRIx64,
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
@@ -595,12 +596,12 @@ reachable:
 		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
-				WARN("can't find reachable insn at %s+0x%lx",
+				WARN("can't find reachable insn at %s+0x%"PRIx64,
 				     reloc->sym->sec->name, reloc->addend);
 				return -1;
 			}
 		} else {
-			WARN("can't find reachable insn at %s+0x%lx",
+			WARN("can't find reachable insn at %s+0x%"PRIx64,
 			     reloc->sym->sec->name, reloc->addend);
 			return -1;
 		}
Index: linux-2.6/tools/objtool/elf.c
===================================================================
--- linux-2.6.orig/tools/objtool/elf.c	2022-05-18 13:51:22.000000000 +0200
+++ linux-2.6/tools/objtool/elf.c	2022-05-18 13:51:22.000000000 +0200
@@ -546,7 +546,7 @@ static struct section *elf_create_reloc_
 						int reltype);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, long addend)
+		  unsigned int type, struct symbol *sym, s64 addend)
 {
 	struct reloc *reloc;
 
Index: linux-2.6/tools/objtool/include/objtool/elf.h
===================================================================
--- linux-2.6.orig/tools/objtool/include/objtool/elf.h	2022-05-18 13:51:22.000000000 +0200
+++ linux-2.6/tools/objtool/include/objtool/elf.h	2022-05-18 13:51:22.000000000 +0200
@@ -73,7 +73,7 @@ struct reloc {
 	struct symbol *sym;
 	unsigned long offset;
 	unsigned int type;
-	long addend;
+	s64 addend;
 	int idx;
 	bool jump_table_start;
 };
@@ -135,7 +135,7 @@ struct elf *elf_open_read(const char *na
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
 int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
-		  unsigned int type, struct symbol *sym, long addend);
+		  unsigned int type, struct symbol *sym, s64 addend);
 int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
 			  unsigned long offset, unsigned int type,
 			  struct section *insn_sec, unsigned long insn_off);

