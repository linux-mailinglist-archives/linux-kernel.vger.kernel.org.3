Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDB472909
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244650AbhLMKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:17:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhLMJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:11 -0500
Date:   Mon, 13 Dec 2021 09:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWdsaLSeXlA+ZzvF+NH+Nm3/l93+gfST9lecwA2pKXY=;
        b=ZypMHu5t3qNjdmS8dGev4DFQ4ob6L18HH6pBrCWINUez/wNiygafNLEM+IiFPX/AJnNlGK
        CMPJVRuiC6qUEavxjvbMqxIko8RwLDMXiiFDNwuZJ0o2plAmYpAATBTxJQQy0U052oOSWP
        Pfe6ePSi4BNnlOjIvH1pEiYE0mcezwu5SqHh/VxQCpUewyWlfBOvThf0I4z57jyr2mhpCN
        mD/D6/R0PvaPdNK5VOv2MpikWn0s58SKGqJnfn3zY/XRZaAOh2bUgPsUEPOmoep2AnoHZ5
        AdfFmy1b7vnkX+kMNtY+OtbTzQK/yw0S9FZs40GktT2Y651lSLfFEw90wfcuww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IWdsaLSeXlA+ZzvF+NH+Nm3/l93+gfST9lecwA2pKXY=;
        b=4A54Z0tl22GeZn7/Wc/G/gOumDSLy9/eILcy2hXsrKttxUN74k5DOutn8rZaXVY8/hQDW5
        zp7R7NEeHhU0WeBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Remove .fixup handling
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101326.261496792@infradead.org>
References: <20211110101326.261496792@infradead.org>
MIME-Version: 1.0
Message-ID: <163938900761.23020.15655979994685554721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     82a8954acd93ae95d6252fb93a3d210c8f71b093
Gitweb:        https://git.kernel.org/tip/82a8954acd93ae95d6252fb93a3d210c8f71b093
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:51 +01:00

objtool: Remove .fixup handling

The .fixup has gone the way of the Dodo, that test will always be
false.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101326.261496792@infradead.org
---
 tools/objtool/check.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e28172f..9fd8149 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3310,14 +3310,10 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 		return true;
 
 	/*
-	 * Ignore any unused exceptions.  This can happen when a whitelisted
-	 * function has an exception table entry.
-	 *
-	 * Also ignore alternative replacement instructions.  This can happen
+	 * Ignore alternative replacement instructions.  This can happen
 	 * when a whitelisted function uses one of the ALTERNATIVE macros.
 	 */
-	if (!strcmp(insn->sec->name, ".fixup") ||
-	    !strcmp(insn->sec->name, ".altinstr_replacement") ||
+	if (!strcmp(insn->sec->name, ".altinstr_replacement") ||
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
