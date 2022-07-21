Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6265C57C682
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiGUIid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiGUIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:37:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A997E812;
        Thu, 21 Jul 2022 01:37:51 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658392670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M9gIqSV4hjHfdUMYTilRInbmrvaHU97+h4ofA7PWZGE=;
        b=jBOnZaqWpbn5QTu0atjFWKNdTNgdnJYLBUi/EFhYsgl6dDuc/ThXvDGqRlB1LrplIdy2NA
        RneIUQKNwRuCdXOufhMAFNT2I2rJCPNqF0rmUFQYq3Vnak+TVUcCVjxXd5voECzuVHhirJ
        FU/5kXk2RJVmkdp4LwfqNF8IX0hFf7ptbKNeT0ea0ihhei9jpSymadQ2pIKGdfChv/XDrn
        o3Cjig9xOf4HBj3KAyf8tJxSUKjVch/G/dIhI906+zM86hIsWB9mP1Ds4+7Ys7QtFAvyQg
        h8hlEPwDVdOftn0XpwJI8SFlX7iXNNdbba0LfufRAom+1Xvz4BVPZrGd2iJtlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658392670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M9gIqSV4hjHfdUMYTilRInbmrvaHU97+h4ofA7PWZGE=;
        b=yD7v2N9RWVozduzAeNILJh5+dXfcAS2+8SasjMuk1s+s2jtwziyQr52AdoLyU1H+e/KsHq
        bSmS1hDEgKK56HCA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/alternative: Report missing return thunk details
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <165839266889.15455.1541522243333291529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     65cdf0d623bedf0e069bb64ed52e8bb20105e2ba
Gitweb:        https://git.kernel.org/tip/65cdf0d623bedf0e069bb64ed52e8bb20105e2ba
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 13 Jul 2022 14:38:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Jul 2022 19:24:53 +02:00

x86/alternative: Report missing return thunk details

Debugging missing return thunks is easier if we can see where they're
happening.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net/
---
 arch/x86/kernel/alternative.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d685853..62f6b8b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -555,7 +555,9 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 			dest = addr + insn.length + insn.immediate.value;
 
 		if (__static_call_fixup(addr, op, dest) ||
-		    WARN_ON_ONCE(dest != &__x86_return_thunk))
+		    WARN_ONCE(dest != &__x86_return_thunk,
+			      "missing return thunk: %pS-%pS: %*ph",
+			      addr, dest, 5, addr))
 			continue;
 
 		DPRINTK("return thunk at: %pS (%px) len: %d to: %pS",
