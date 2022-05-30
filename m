Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187E537930
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiE3Kiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiE3Kiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D7D6B020;
        Mon, 30 May 2022 03:38:50 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnzHGAnhOyq2k09aaH0EESq2qgJyhDeir+FLHc2J8To=;
        b=r8LDmN4TrWj7KiVPzXDuBSvMtpKxriYtsnG0nCoYQQIYl6y85CFFb9g1fjcrz97+6rwTS8
        TQ0MLgwQR9PhVLJIp3xtQqqOCpnAZrE5pjx8X6uFSRl7q+0NymbM332qQFIR28wwyERwWT
        aBe1ZysQGCbWVZDPTT4g09C9yFEuMKUQqeZRbSypxkM/QQMFqLiHw+5vU88l60rcq4RSsT
        brz+Nbm9UJk8MeU+tdVekrmE64/4y78Y+wOVESUcrf70qK0sSk8O0bI8BCXnXAGMR68Zef
        1h4E2yiRhOa+0fZjgGvFQ2u4e7S/hJiS6fCehAIRFAhTLtHy9JePdVxNR4gjgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rnzHGAnhOyq2k09aaH0EESq2qgJyhDeir+FLHc2J8To=;
        b=9Tb8qO3eEK/6INM3DhLY9XuV1dKKynFSBjbuMbM02ZkPhhnjria51iKoXARUK9E/3t4b6N
        8ZE4Um6J9ZuyhCDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/extable: Annotate ex_handler_msr_mce() as a
 dead end
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520192729.23969-1-bp@alien8.de>
References: <20220520192729.23969-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165390712655.4207.8607067039695969119.tip-bot2@tip-bot2>
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

Commit-ID:     2028a255f4df3af9e759f01f958d3237f825f256
Gitweb:        https://git.kernel.org/tip/2028a255f4df3af9e759f01f958d3237f825f256
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 20 May 2022 21:27:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:45 +02:00

x86/extable: Annotate ex_handler_msr_mce() as a dead end

Fix

  vmlinux.o: warning: objtool: fixup_exception+0x2d6: unreachable instruction

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220520192729.23969-1-bp@alien8.de
---
 arch/x86/include/asm/extable.h | 8 ++++++--
 tools/objtool/check.c          | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index 155c991..eeed395 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -42,9 +42,13 @@ extern int ex_get_fixup_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
 #ifdef CONFIG_X86_MCE
-extern void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
+extern void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr);
 #else
-static inline void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr) { }
+static inline void __noreturn ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
+{
+	for (;;)
+		cpu_relax();
+}
 #endif
 
 #if defined(CONFIG_BPF_JIT) && defined(CONFIG_X86_64)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7a187da..864bb9d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -187,6 +187,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__invalid_creds",
 		"cpu_startup_entry",
 		"__ubsan_handle_builtin_unreachable",
+		"ex_handler_msr_mce",
 	};
 
 	if (!func)
