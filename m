Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D02507AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356907AbiDSULV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356679AbiDSULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58600387AE;
        Tue, 19 Apr 2022 13:08:33 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtOky4L7e/WCxICYIDFlZBxh8q1/lNGsavbBhYAasb8=;
        b=t78sSDRpxWaacSKZFhAOlVSpQARZ0dtSyhYz1Lyo21Gyw+BcQ7W0NzQluJRSbUdm7qfLvP
        oE4/hOF151HHbI4ibknkj8MYf02GNfQdOfVOLYU+DaTNgrmtt7jyVi/QNLuuOlKBKLIYUv
        XfL97aBTjMTjSkzn47xWJQKAbsmtjrwtXnhCzk1k8ClGD6jgdjS7laPYhMA/BK64c0lod0
        5vSHwbgumIPG7GboqJKftZ4QEOTUifAgjjDOedMUb88GRbRnMt5fp0Iexh4nBZ+1IliUKM
        KIKwWu3nSiEtBKotenHn47G+MWm7AtkV7ztsWxkH3nUWs0C0MYjZZEg3A2dSkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qtOky4L7e/WCxICYIDFlZBxh8q1/lNGsavbBhYAasb8=;
        b=PUDNJCXx+pxqmZ/Pszenzm/KoJijehf2CPtry6BIG+LKRayI6VnWxHxFFJxlcw7QlnA9Tb
        RZqEWwy++ELDN2Dw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix function fallthrough detection for vmlinux
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b434cff98eca3a60dcc64c620d7d5d405a0f441c.1649718562.git.jpoimboe@redhat.com>
References: <b434cff98eca3a60dcc64c620d7d5d405a0f441c.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891044.4207.14725257477811071935.tip-bot2@tip-bot2>
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

Commit-ID:     08feafe8d1958febf3a9733a3d1564d8fc23340e
Gitweb:        https://git.kernel.org/tip/08feafe8d1958febf3a9733a3d1564d8fc23340e
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 11 Apr 2022 16:10:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:53 +02:00

objtool: Fix function fallthrough detection for vmlinux

Objtool's function fallthrough detection only works on C objects.
The distinction between C and assembly objects no longer makes sense
with objtool running on vmlinux.o.

Now that copy_user_64.S has been fixed up, and an objtool sibling call
detection bug has been fixed, the asm code is in "compliance" and this
hack is no longer needed.  Remove it.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/b434cff98eca3a60dcc64c620d7d5d405a0f441c.1649718562.git.jpoimboe@redhat.com
---
 tools/objtool/check.c                   | 2 +-
 tools/objtool/include/objtool/objtool.h | 2 +-
 tools/objtool/objtool.c                 | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0f5d3de..5f10653 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3310,7 +3310,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
-		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
+		if (func && insn->func && func != insn->func->pfunc) {
 			WARN("%s() falls through to next function %s()",
 			     func->name, insn->func->name);
 			return 1;
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 7a5c13a..a6e72d9 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -27,7 +27,7 @@ struct objtool_file {
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	struct list_head endbr_list;
-	bool ignore_unreachables, c_file, hints, rodata;
+	bool ignore_unreachables, hints, rodata;
 
 	unsigned int nr_endbr;
 	unsigned int nr_endbr_int;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index b09946f..843ff3c 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -129,7 +129,6 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	INIT_LIST_HEAD(&file.endbr_list);
-	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
 
