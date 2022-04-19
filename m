Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E3506604
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349437AbiDSHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiDSHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:37:59 -0400
Received: from outback3o.mail.yandex.net (outback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::503])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296DA22535
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:35:15 -0700 (PDT)
Received: from myt5-5423fe16b941.qloud-c.yandex.net (myt5-5423fe16b941.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2507:0:640:5423:fe16])
        by outback3o.mail.yandex.net (Yandex) with ESMTP id B4CF91D1375A;
        Tue, 19 Apr 2022 10:35:11 +0300 (MSK)
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by myt5-5423fe16b941.qloud-c.yandex.net (yaback/Yandex) with ESMTP id oGfduu1KhX-ZAre6LNW;
        Tue, 19 Apr 2022 10:35:10 +0300
X-Yandex-Fwd: 1
Authentication-Results: myt5-5423fe16b941.qloud-c.yandex.net; dkim=pass
Received: by kernel1.search.yandex.net (Postfix, from userid 55271)
        id 58D75560029; Tue, 19 Apr 2022 10:35:10 +0300 (MSK)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, mingo@redhat.com, jpoimboe@redhat.com,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH v3] x86/unwind/orc: Recheck address range after stack info was updated
Date:   Tue, 19 Apr 2022 10:34:16 +0300
Message-Id: <1650353656-956624-1-git-send-email-dmtrmonakhov@yandex-team.ru>
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

Otherwise crash is possible in case of other bug in IBS handling code which
is passing invalid regs to the unwinder.

Original OOPS log:
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

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---

Changelog:
 v1->v2: Do not call on_stack() twice for valid range
 v2->v3: Update commit message accrording to Josh's comments

 arch/x86/kernel/unwind_orc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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

