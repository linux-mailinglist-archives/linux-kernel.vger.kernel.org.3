Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B74D9975
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347811AbiCOKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347438AbiCOKqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:46:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE6517E7;
        Tue, 15 Mar 2022 03:44:20 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlOx9SWUx1Hhq0QlJPBVYJg1CPjfdT4ygF4ZCKmUCbo=;
        b=Ly+a37HeNZWjMbG756DlUv7hSmCh6828Culpd5llsr6k1LpSszQEwYAURFloYPB4gLNTxA
        dbpr/oeZLBTl5iHfE6ou9+J/rTJZsZqW7AW7m6AN68J6rG0I1Fcr5V9Ss27L0mvaq9dH6m
        jNN42ovki7UqNw/8RUxte3Oaeb5QBabXJVec/41T3VmBGG/mGMlErJ10xiMxPLd4GOu3+g
        fBdqXosrb9WA4G9DQXue5INS3WLHvIyl6IQ+7pbSI6tzOgcY1FIHHIEj0Rl1CZUEGY76JK
        Zh3RqagBhF1bzIMfjQXgli9IzDSd4LOVM/Lp9x0IkqcwGw4yKqGkjL3NZeL7nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlOx9SWUx1Hhq0QlJPBVYJg1CPjfdT4ygF4ZCKmUCbo=;
        b=V6I4ZFwR5oA4oxYwC58ykR21mFjvjGy2f1CKeiivyO4rAk8bL0sfXdRA9CTcZq3txopp/4
        2LQypuI4b/6FWECw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-11-fenghua.yu@intel.com>
References: <20220207230254.3342514-11-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164734105799.16921.15931261118051615591.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     227a06553fe6c785f23d76eece3bb10e2db5059c
Gitweb:        https://git.kernel.org/tip/227a06553fe6c785f23d76eece3bb10e2db5059c
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:53 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:30 +01:00

tools/objtool: Check for use of the ENQCMD instruction in the kernel

The ENQCMD instruction implicitly accesses the PASID_MSR to fill in the
pasid field of the descriptor being submitted to an accelerator. But
there is no precise (and stable across kernel changes) point at which
the PASID_MSR is updated from the value for one task to the next.

Kernel code that uses accelerators must always use the ENQCMDS instruction
which does not access the PASID_MSR.

Check for use of the ENQCMD instruction in the kernel and warn on its
usage.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220207230254.3342514-11-fenghua.yu@intel.com
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c10ef78..479e769 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -112,7 +112,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2,
+	unsigned char op1, op2, op3,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -139,6 +139,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
+	op3 = insn.opcode.bytes[2];
 
 	if (insn.rex_prefix.nbytes) {
 		rex = insn.rex_prefix.bytes[0];
@@ -491,6 +492,14 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x38 && op3 == 0xf8) {
+			if (insn.prefixes.nbytes == 1 &&
+			    insn.prefixes.bytes[0] == 0xf2) {
+				/* ENQCMD cannot be used in the kernel. */
+				WARN("ENQCMD instruction at %s:%lx", sec->name,
+				     offset);
+			}
+
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
