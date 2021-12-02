Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970FF466B18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348996AbhLBUtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhLBUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:49:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7BCC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 12:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iLJFcnGi+8Zsk2e+yliUQLXFuuM+6MVj3GsVe4Hak5Y=; b=A8lrFsisFwh9m+8OFTP4U4hlvY
        ZMBsiSKphQLkjMYhZrZttNdtUWx8oVV10XbFrvD0CZb8c5ETZyOK5aULRp6BH54aKm4YnBGrhIW1Q
        Fu7yDXMnKFMjG72lw2dcpVk8btCvl8BjmIgDsS3abeBhx8AszqHRYxBpexCSvmX+dhxBGNlB+FF71
        5eaMmHw8uP1oGFidy73bb8hrdnASYyEs4wMfmoQowke9jfIY9uf040X8nNYpFa+j4ZCnHUm/r+z0N
        uWPuz9+8+yQFVsxT5CxqIaKHKCEqgovVjbnsQ73ASXhXMhiHInYtYKmFu7xFh8oUQtlztuw53lab6
        wamljBZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mssxS-005YhE-RO; Thu, 02 Dec 2021 20:45:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4486D9810D4; Thu,  2 Dec 2021 21:45:34 +0100 (CET)
Date:   Thu, 2 Dec 2021 21:45:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: Fix pv_ops noinstr validation
Message-ID: <20211202204534.GA16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Boris reported that in one of this randconfig builds, objtool got
infinitely stuck. Turns out there's trivial list corruption in the
pv_ops tracking when a function is both in a static table and in a
code assignment.

Avoid re-adding function to the pv_ops[] lists when they're already on
it.

Fixes: db2b0c5d7b6f ("objtool: Support pv_opsindirect calls for noinstr")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Borislav Petkov <bp@alien8.de>
---
 tools/objtool/elf.c     |    1 +
 tools/objtool/objtool.c |    4 ++++
 2 files changed, 5 insertions(+)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -375,6 +375,7 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
 		memset(sym, 0, sizeof(*sym));
+		INIT_LIST_HEAD(&sym->pv_target);
 		sym->alias = sym;
 
 		sym->idx = i;
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -153,6 +153,10 @@ void objtool_pv_add(struct objtool_file
 	    !strcmp(func->name, "_paravirt_ident_64"))
 		return;
 
+	/* already added this function */
+	if (!list_empty(&func->pv_target))
+		return;
+
 	list_add(&func->pv_target, &f->pv_ops[idx].targets);
 	f->pv_ops[idx].clean = false;
 }
