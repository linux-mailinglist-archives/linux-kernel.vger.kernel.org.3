Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5967D4D991C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbiCOKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347224AbiCOKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678C2F028;
        Tue, 15 Mar 2022 03:43:45 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syG+zqh4Q+3vlw+qKBz98+af1fOexGGxDC8UCaFHYcQ=;
        b=lAeH6VWQyN6PLvVfZVc89hm/mb3ZGQYHrJ1HfOB6R7OeS2az93Bs+eIQQHoXME7EF0FhRI
        HSY8t051FPLmEiLkk8l9TuuzOyaZ5a3hpSSE7zY+T4MWu4ocTeSrXiVtcJOjx5pUKeGjVq
        0052mr9/82FyjLwtDUa1xrCkYEEdYaBjGXE6pAe3Mf0LGG9THaYQyFDVnmD+5ITSgm/48m
        dXRXrv54Oe/NZKxXyOSkvs5RTU4nyrpRbtsnmzjLcTG+2g3j++QZHJvWlgO5hlyPnlUJg6
        hBnxmGwT5VMREOMyg2ua/X1GTNBt04XNqL1pdlUjGEIzFiBG2jFcQTKvox9JgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syG+zqh4Q+3vlw+qKBz98+af1fOexGGxDC8UCaFHYcQ=;
        b=275fFMT8+OFPgj54EOXLaHV+AyRzUOAcIzeg/wGKvk4v8jaQnVj+xDXtaXn/C2SSoAdxWl
        aNM5SHlMIq3nywCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Annotate idtentry_df()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
References: <Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164734102342.16921.2650710011277528758.tip-bot2@tip-bot2>
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

Commit-ID:     3515899bef545fc5b5f6b865e080bfe4c9a92a41
Gitweb:        https://git.kernel.org/tip/3515899bef545fc5b5f6b865e080bfe4c9a92a41
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Mar 2022 18:07:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:45 +01:00

x86: Annotate idtentry_df()

Without CONFIG_X86_ESPFIX64 exc_double_fault() is noreturn and objtool
is clever enough to figure that out.

vmlinux.o: warning: objtool: asm_exc_double_fault()+0x22: unreachable instruction

0000000000001260 <asm_exc_double_fault>:
1260:       f3 0f 1e fa             endbr64
1264:       90                      nop
1265:       90                      nop
1266:       90                      nop
1267:       e8 84 03 00 00          call   15f0 <paranoid_entry>
126c:       48 89 e7                mov    %rsp,%rdi
126f:       48 8b 74 24 78          mov    0x78(%rsp),%rsi
1274:       48 c7 44 24 78 ff ff ff ff      movq   $0xffffffffffffffff,0x78(%rsp)
127d:       e8 00 00 00 00          call   1282 <asm_exc_double_fault+0x22> 127e: R_X86_64_PLT32    exc_double_fault-0x4
1282:       e9 09 04 00 00          jmp    1690 <paranoid_exit>

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yi9gOW9f1GGwwUD6@hirez.programming.kicks-ass.net
---
 arch/x86/entry/entry_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6e53991..4faac48 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -551,6 +551,9 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
+	/* For some configurations \cfunc ends up being a noreturn. */
+	REACHABLE
+
 	jmp	paranoid_exit
 
 _ASM_NOKPROBE(\asmsym)
