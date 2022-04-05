Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1774F354D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 15:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356871AbiDEKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbiDEIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676E17A9B;
        Tue,  5 Apr 2022 01:29:39 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVp4aRHgsclhL8EJ9iZFPn/4+bvKhNrDLh1shDagL2c=;
        b=zMlfh/PxrJOZ8vGaMmjA4p2/ZaPgx5r3H0AbHeZgRL4TIdsXUpNL+jY6SyJ07jSg/j2y/u
        88x2iZ9oRzVP10AEyJ5biBeq8J2fusLom50Rk0fuRJaf1f8gWnUICBqsrlQK4E65H6xuW8
        XLGg6mH+me+vOvEfct+IcRNicAQtnWHe1SbmPnNhzBAzIEEqqukCpyr5wpRKOCGlvD3XEC
        qidd4D5Us92VNhSDN4oif6qwp8vQhfxzQhfw+U3jYpj+5u3hCxLLFjxTKy6ZvXr7KKJbiV
        pLGFqNnfXgr6sbLdpFmS19fFTt1BkdFK2OrKn3hPHGftJc83ZAzl43y1+VyEwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVp4aRHgsclhL8EJ9iZFPn/4+bvKhNrDLh1shDagL2c=;
        b=yaKJS7IpU3azwEtJ/GCcjVDTMoQMwXqhXPoCYVFBp11Ife3vzblPjEQ4gomMOEZmX9CK7d
        pVzumFGcjVOvjDBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Fix SLS validation for kcov tail-call replacement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220323230712.GA8939@worktop.programming.kicks-ass.net>
References: <20220323230712.GA8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164914737698.389.9382250857229759152.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7a53f408902d913cd541b4f8ad7dbcd4961f5b82
Gitweb:        https://git.kernel.org/tip/7a53f408902d913cd541b4f8ad7dbcd4961f5b82
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 23 Mar 2022 23:35:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:40 +02:00

objtool: Fix SLS validation for kcov tail-call replacement

Since not all compilers have a function attribute to disable KCOV
instrumentation, objtool can rewrite KCOV instrumentation in noinstr
functions as per commit:

  f56dae88a81f ("objtool: Handle __sanitize_cov*() tail calls")

However, this has subtle interaction with the SLS validation from
commit:

  1cc1e4c8aab4 ("objtool: Add straight-line-speculation validation")

In that when a tail-call instrucion is replaced with a RET an
additional INT3 instruction is also written, but is not represented in
the decoded instruction stream.

This then leads to false positive missing INT3 objtool warnings in
noinstr code.

Instead of adding additional struct instruction objects, mark the RET
instruction with retpoline_safe to suppress the warning (since we know
there really is an INT3).

Fixes: 1cc1e4c8aab4 ("objtool: Add straight-line-speculation validation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220323230712.GA8939@worktop.programming.kicks-ass.net
---
 tools/objtool/check.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b848e1d..bd0c2c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1155,6 +1155,17 @@ static void annotate_call_site(struct objtool_file *file,
 			               : arch_nop_insn(insn->len));
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+
+		if (sibling) {
+			/*
+			 * We've replaced the tail-call JMP insn by two new
+			 * insn: RET; INT3, except we only have a single struct
+			 * insn here. Mark it retpoline_safe to avoid the SLS
+			 * warning, instead of adding another insn.
+			 */
+			insn->retpoline_safe = true;
+		}
+
 		return;
 	}
 
