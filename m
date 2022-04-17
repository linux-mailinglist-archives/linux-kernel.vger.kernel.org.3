Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059205047E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiDQNdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:33:29 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Apr 2022 06:30:52 PDT
Received: from forward300j.mail.yandex.net (forward300j.mail.yandex.net [5.45.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B053DFE8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:30:52 -0700 (PDT)
Received: from iva5-7aaec7404f99.qloud-c.yandex.net (iva5-7aaec7404f99.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:74a5:0:640:7aae:c740])
        by forward300j.mail.yandex.net (Yandex) with ESMTP id 27FC17E4755;
        Sun, 17 Apr 2022 16:23:31 +0300 (MSK)
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by iva5-7aaec7404f99.qloud-c.yandex.net (yaback/Yandex) with ESMTP id 5s9z81sXYH-NTs08ZEu;
        Sun, 17 Apr 2022 16:23:29 +0300
X-Yandex-Fwd: 1
Authentication-Results: iva5-7aaec7404f99.qloud-c.yandex.net; dkim=pass
Received: by kernel1.search.yandex.net (Postfix, from userid 55271)
        id AA27856006C; Sun, 17 Apr 2022 16:23:29 +0300 (MSK)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, mingo@redhat.com, jpoimboe@redhat.com,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] x86/unwind/orc: recheck address range after stack info was updated V2
Date:   Sun, 17 Apr 2022 16:23:11 +0300
Message-Id: <1650201791-356270-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_stack_info() detects stack type only by begin address, so we must
check that address range in question is fully covered by detected stack

Otherwise following crash is possible:
-> unwind_next_frame
   case ORC_TYPE_REGS:
     if (!deref_stack_regs(state, sp, &state->ip, &state->sp))
     -> deref_stack_regs
       -> stack_access_ok  <- addr is ok, but addr+len-1 is not, exit with success
     *ip = READ_ONCE_NOCHECK(regs->ip); <- Here we hit stack guard fault

Original OOPS log:
BUG: stack guard page was hit at 000000000dd984a2 (stack is 00000000d1caafca..00000000613712f0)
kernel stack overflow (page fault): 0000 [#1] SMP NOPTI
CPU: 93 PID: 23787 Comm: context_switch1 Not tainted 5.4.145 #1
RIP: 0010:unwind_next_frame
Call Trace:
 <NMI>
 perf_callchain_kernel
 ..
 get_perf_callchain
 perf_callchain
 perf_prepare_sample
 perf_event_output_forward
 ...
 __perf_event_overflow
 perf_ibs_handle_irq
 ....
 perf_ibs_nmi_handler
 nmi_handle
 default_do_nmi
 do_nmi
 end_repeat_nmi

Changes since v1:
 - Do not call on_stack() twice for valid range.

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 794fdef2501a..38185aedf7d1 100644
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
-- 
2.7.4

