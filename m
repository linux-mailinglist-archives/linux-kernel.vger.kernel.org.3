Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8704B467482
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379758AbhLCKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379738AbhLCKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:08:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF60C06173E;
        Fri,  3 Dec 2021 02:04:47 -0800 (PST)
Date:   Fri, 03 Dec 2021 10:04:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638525885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qB0YgACl6GqKRsQYZB69SiEN4qAv5+34fsVCnVr5eU=;
        b=W22sfpdUPaFr+9GHFqWXE8e7Ia9g8NO9FmiixXynRJN4iX7URVqerX6uGkzLQkeyN39OlU
        y5A3f+j66CZLRkyUN+9utTdEigqY2PQM6AfUMQjM1a4CnXvKOXW7ogT7/DLYMVkUfai/AL
        RW5t7cApJM3tRTs96wJNsNCy+rMqFsF6TzwANVV5JgaD4ADfvbLconzPuD8Lflb6IFqdEo
        3ZdFC+VFIQOcuvthQyAHnBDX0ZabXaiS+i4VrBrV2ShmDSud4fQcscggEgb4+fH8irj+sZ
        hdDtJYtSzrrlagRYOrNQX8Fw6NAuuYhKKN1ET3eJ09qflK9ymiR9k6Yl1W8Wfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638525885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qB0YgACl6GqKRsQYZB69SiEN4qAv5+34fsVCnVr5eU=;
        b=qULKMZIs2ukkrrOW4tBGTAKjrHFng8ggnyQi+OE20KU8z47wKevPm5EPaDncXuTQTOnnv7
        esc0TOvXBjMJylAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Fix pv_ops noinstr validation
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211202204534.GA16608@worktop.programming.kicks-ass.net>
References: <20211202204534.GA16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163852588454.11128.16369385038253612673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     988f01683c7f2bf9f8fe2bae1cf4010fcd1baaf5
Gitweb:        https://git.kernel.org/tip/988f01683c7f2bf9f8fe2bae1cf4010fcd1baaf5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 02 Dec 2021 21:45:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 03 Dec 2021 09:11:42 +01:00

objtool: Fix pv_ops noinstr validation

Boris reported that in one of his randconfig builds, objtool got
infinitely stuck. Turns out there's trivial list corruption in the
pv_ops tracking when a function is both in a static table and in a code
assignment.

Avoid re-adding function to the pv_ops[] lists when they're already on
it.

Fixes: db2b0c5d7b6f ("objtool: Support pv_opsindirect calls for noinstr")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20211202204534.GA16608@worktop.programming.kicks-ass.net
---
 tools/objtool/elf.c     | 1 +
 tools/objtool/objtool.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 81a4c54..4b384c9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -375,6 +375,7 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
 		memset(sym, 0, sizeof(*sym));
+		INIT_LIST_HEAD(&sym->pv_target);
 		sym->alias = sym;
 
 		sym->idx = i;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index c90c708..bdf699f 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -153,6 +153,10 @@ void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
 	    !strcmp(func->name, "_paravirt_ident_64"))
 		return;
 
+	/* already added this function */
+	if (!list_empty(&func->pv_target))
+		return;
+
 	list_add(&func->pv_target, &f->pv_ops[idx].targets);
 	f->pv_ops[idx].clean = false;
 }
