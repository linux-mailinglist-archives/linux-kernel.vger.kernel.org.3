Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B8D537935
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiE3KjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiE3Kix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BA76B092;
        Mon, 30 May 2022 03:38:51 -0700 (PDT)
Date:   Mon, 30 May 2022 10:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653907129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYKLtWD+8AqufC/EShi41u03pMom2TKKZ//8h9CsWGk=;
        b=d74cuSKBZXL2FD49jBQR0Nfqr1V6MhOUekYq05DxOiNx+Aof69ZposIWZqE0bXwLq/Crau
        SzKnymH0XXcfsGYUos0/XjqoRFjgXpPqtL9aAOZpVip1tQM78mxpe/WLMaxIvoQy3bnbYc
        O9ANzS9LrvyDSYpFv6vEzlpZdYfdAagID5QD+b/wT9+4wTPJxvSj4TFb9HsMNMaNvtzPYn
        zg2Y+4tbLsd6WEU0LYLvu9dt48432L4uD7orpXfna++8/QWbUhob8l27MlyXSR9tia8wy8
        PeSRXu8N0n8cm7efrx80konHHZzfCFzQdE/hAPILqd0W5ovAFeyEc6VCiTOUCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653907129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYKLtWD+8AqufC/EShi41u03pMom2TKKZ//8h9CsWGk=;
        b=DtYvize89ckVZgzY4/PNeGLoGIeMv38mTDjod7kK8hrp0/0s5bQpUZLYrc59qN/r452MEo
        j2BRa9kkqZS8iNCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86: Always inline on_thread_stack() and
 current_top_of_stack()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220526105958.071435483@infradead.org>
References: <20220526105958.071435483@infradead.org>
MIME-Version: 1.0
Message-ID: <165390712869.4207.16169682719382895946.tip-bot2@tip-bot2>
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

Commit-ID:     1894a4030582472336c2873cb07911ce67e0d14e
Gitweb:        https://git.kernel.org/tip/1894a4030582472336c2873cb07911ce67e0d14e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 07 May 2022 13:37:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 May 2022 12:34:44 +02:00

x86: Always inline on_thread_stack() and current_top_of_stack()

Becaues GCC clearly lost it's marbles again...

vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to on_thread_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to on_thread_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to on_thread_stack() leaves .noinstr.text section

vmlinux.o: warning: objtool: enter_from_user_mode+0x4e: call to current_top_of_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x53: call to current_top_of_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x4e: call to current_top_of_stack() leaves .noinstr.text section
vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x4e: call to current_top_of_stack() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220526105958.071435483@infradead.org
---
 arch/x86/include/asm/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 91d0f93..356308c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -559,7 +559,7 @@ static __always_inline void native_swapgs(void)
 #endif
 }
 
-static inline unsigned long current_top_of_stack(void)
+static __always_inline unsigned long current_top_of_stack(void)
 {
 	/*
 	 *  We can't read directly from tss.sp0: sp0 on x86_32 is special in
@@ -569,7 +569,7 @@ static inline unsigned long current_top_of_stack(void)
 	return this_cpu_read_stable(cpu_current_top_of_stack);
 }
 
-static inline bool on_thread_stack(void)
+static __always_inline bool on_thread_stack(void)
 {
 	return (unsigned long)(current_top_of_stack() -
 			       current_stack_pointer) < THREAD_SIZE;
