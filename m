Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADE4F7C17
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbiDGJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiDGJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:48:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A425ADB2F6;
        Thu,  7 Apr 2022 02:46:45 -0700 (PDT)
Date:   Thu, 07 Apr 2022 09:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649324804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qmO+AT3WH/Nl5H+CjWNrTteEZ5FjNU1A4267TZ3/ME=;
        b=lO0eqWVfB9tO/G6pUx0X4KEb4dM1Yeveodu/aSd8Xeo7rMG93RkuXp16j4qEYstplfxnz2
        IEmqGbMdg4Ces6fN/x8PJtSf+iZF/5oHdfxokHGQ5C1LVWrbIkkvClzX/krOXRCgywhg5l
        x1jPJgvtIhHvP21vqrd7pi3qXUNdnGlz1NFVRpTQsXwPUc7dbriAjgvZGJrbmtkckGGOwD
        YrfgqYGXX0ugOLlWdCJcElGHV+AZyEOh6vH2oaJV4NCICOdZNDvzF7+qkmZOBLAZfoeu0f
        Xs2WSQycQbg6YCzVBvLr/QdtCgGpu8TpTyYYDKYugfArZ/pOdSZfrmDRJxMtXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649324804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qmO+AT3WH/Nl5H+CjWNrTteEZ5FjNU1A4267TZ3/ME=;
        b=91DZvu2pVqvyWTNVLl6zZg3Mz9TBgmm4IyUd2khkEp5oXTr+0pvnzoH5njHRPMJfG2sZUw
        xOxEypiBZk/cOsCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,bpf: Avoid IBT objtool warning
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
References: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164932480297.389.17131131751153589148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     be8a096521ca1a252bf078b347f96ce94582612e
Gitweb:        https://git.kernel.org/tip/be8a096521ca1a252bf078b347f96ce94582612e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 28 Mar 2022 13:13:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Apr 2022 11:27:02 +02:00

x86,bpf: Avoid IBT objtool warning

Clang can inline emit_indirect_jump() and then folds constants, which
results in:

  | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x6a4: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
  | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x67d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
  | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x386: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
  | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x35d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20

Suppress the optimization such that it must emit a code reference to
the __x86_indirect_thunk_array[] base.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lkml.kernel.org/r/20220405075531.GB30877@worktop.programming.kicks-ass.net
---
 arch/x86/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8fe35ed..16b6efa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -412,6 +412,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		OPTIMIZER_HIDE_VAR(reg);
 		emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else
 #endif
