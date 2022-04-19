Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B1507AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357056AbiDSUMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357547AbiDSULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EF23915B;
        Tue, 19 Apr 2022 13:08:48 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rf4ZSXcLpUXFhDAUeIcOJF0LZS002XFFa3S5R4lEIfs=;
        b=dX9sGwfSn0Fgw/wiuYmwS4kSZ8lIT65HykuDpbZX4KHPh+oFKbOpWu0NJZYdkeJBBy1Q+J
        DtSGJ3gOy7e9UAGm/OZQsP9+0Ie+d2agSXjbgPkuimjoCFJFYiOxia6oS1QsqQi+aB5whg
        QiDqR0HMN/K8evkl6C0Uo6AnqPb557KNadyxac9Vo5vvK7dLHyP8sWaZQX1Bs/uj6gUCGV
        yD1c6mqQdIYapL3S3p2mpHuxUBbFVnNeWI71bfOW4eOf4q7kC6ICMagMC2c3ZkXcAar0ED
        M8+VTaJ+VvO8Fu6iyMyCx2AHJAL3dZi+6DsE+kFPhdVc4n0P7l0aKELx8cEzeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rf4ZSXcLpUXFhDAUeIcOJF0LZS002XFFa3S5R4lEIfs=;
        b=EjAKK7/wEKKPFYBThoT4j/4ftHWc8MzRj/gbwl+C1mi7jn1bcBSqfNOA+lHDqUeuGp/r/w
        yb2WJv2RhiA5yOCg==
From:   "tip-bot2 for Dmitry Monakhov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Recheck address range after stack
 info was updated
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1650353656-956624-1-git-send-email-dmtrmonakhov@yandex-team.ru>
References: <1650353656-956624-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Message-ID: <165039892583.4207.7758088738350413608.tip-bot2@tip-bot2>
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

Commit-ID:     6c8ef58a50b5fab6e364b558143490a2014e2a4f
Gitweb:        https://git.kernel.org/tip/6c8ef58a50b5fab6e364b558143490a2014e2a4f
Author:        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
AuthorDate:    Tue, 19 Apr 2022 10:34:16 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:46 +02:00

x86/unwind/orc: Recheck address range after stack info was updated

A crash was observed in the ORC unwinder:

  BUG: stack guard page was hit at 000000000dd984a2 (stack is 00000000d1caafca..00000000613712f0)
  kernel stack overflow (page fault): 0000 [#1] SMP NOPTI
  CPU: 93 PID: 23787 Comm: context_switch1 Not tainted 5.4.145 #1
  RIP: 0010:unwind_next_frame
  Call Trace:
   <NMI>
   perf_callchain_kernel
   get_perf_callchain
   perf_callchain
   perf_prepare_sample
   perf_event_output_forward
   __perf_event_overflow
   perf_ibs_handle_irq
   perf_ibs_nmi_handler
   nmi_handle
   default_do_nmi
   do_nmi
   end_repeat_nmi

This was really two bugs:

  1) The perf IBS code passed inconsistent regs to the unwinder.

  2) The unwinder didn't handle the bad input gracefully.

Fix the latter bug.  The ORC unwinder needs to be immune against bad
inputs.  The problem is that stack_access_ok() doesn't recheck the
validity of the full range of registers after switching to the next
valid stack with get_stack_info().  Fix that.

[ jpoimboe: rewrote commit log ]

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/1650353656-956624-1-git-send-email-dmtrmonakhov@yandex-team.ru
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/unwind_orc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 794fdef..38185ae 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -339,11 +339,11 @@ static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
 	struct stack_info *info = &state->stack_info;
 	void *addr = (void *)_addr;
 
-	if (!on_stack(info, addr, len) &&
-	    (get_stack_info(addr, state->task, info, &state->stack_mask)))
-		return false;
+	if (on_stack(info, addr, len))
+		return true;
 
-	return true;
+	return !get_stack_info(addr, state->task, info, &state->stack_mask) &&
+		on_stack(info, addr, len);
 }
 
 static bool deref_stack_reg(struct unwind_state *state, unsigned long addr,
