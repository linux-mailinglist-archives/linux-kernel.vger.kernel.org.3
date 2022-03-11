Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A54D63F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349284AbiCKOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbiCKOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:42:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F91A2737;
        Fri, 11 Mar 2022 06:40:57 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:40:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647009655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHll+TQ7r83xKSwcS7SmbWIwQwNrl/62wJEj3uh21hg=;
        b=HVakd5zFfUrIFKlEkNIgxjMbi2qdHgpnfiHKd+oA5NTbMcEi8z1aCaE/pOpQ6fL/AQwh4b
        fK/2iN4/S2X9P6ZsogpSpmfkucBMS/5SuX76XX3pt8k+FemgZ1WHkE61Q0OY2ll2NpV+1J
        58wCjqdlyAmRe4cTsSJPaonkuWK6AtaeQn1fKZE5/c3IKcvvXVuQmKBN+pFrizNsw3OqTN
        /xjziXxSlsY2mRYR0Z0HUEjUY61bl/r+wu8qG8HuNVX576Po9LmS7265DIQ0jc4x/iQrZx
        2ZbXXDds3XxSrKv+cg6hP7Jhn3erGnnSqX5ld80ouBVzK78QzixaYzeDk+GnTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647009655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHll+TQ7r83xKSwcS7SmbWIwQwNrl/62wJEj3uh21hg=;
        b=wm5y/282KVgFCydrvQA+bkPpmMddXYbjw7bSFOLzeLEv70MA0aKBIiFr58hW54EGxiUXeB
        Q37Kot0qVzbY/sBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,bpf: Fix bpf_arch_text_poke()
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YionV0%2bv%2fcUBiOh0@hirez.programming.kicks-ass.net>
References: <YionV0%2bv%2fcUBiOh0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164700965461.16921.7171901216645910235.tip-bot2@tip-bot2>
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

Commit-ID:     9e1db76f44de4d9439e48c9ef61e5d457395202b
Gitweb:        https://git.kernel.org/tip/9e1db76f44de4d9439e48c9ef61e5d457395202b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Mar 2022 10:44:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Mar 2022 13:05:08 +01:00

x86,bpf: Fix bpf_arch_text_poke()

Alexei reported that BPF direct trampolines are no longer working with
IBT=y builds.

Ensure that bpf_arch_text_poke() can find the NOP callsite emitted by
emit_prologue().

Fixes: 2f6f7bf13ab6 ("x86/ibt,bpf: Add ENDBR instructions to prologue and trampoline")
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/YionV0%2bv%2fcUBiOh0@hirez.programming.kicks-ass.net
---
 arch/x86/net/bpf_jit_comp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 159b79f..f071c03 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -395,6 +395,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		/* BPF poking in modules is not supported */
 		return -EINVAL;
 
+	/*
+	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
+	 * with an ENDBR instruction.
+	 */
+	if (is_endbr(*(u32 *)ip))
+		ip += ENDBR_INSN_SIZE;
+
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr, true);
 }
 
