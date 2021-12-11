Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A314713E6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 14:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhLKNFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 08:05:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54040 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhLKNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:05:11 -0500
Date:   Sat, 11 Dec 2021 13:05:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639227910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEMqlwSCdC+q4mXEJtMLLIu+hK3M652sYNwJVu932dk=;
        b=uPQjTNITEHglrTbV4aGP0M5N8348Xg3aIpbHmyzJ2YuaIDTrTY/AXW8zPPK8Ry0kDjV2QR
        y1kq1pKl+330wwuycLIYT+tZ4ghoDalDar2cjH/0xVuGVHmm+NTpbzjB4qWRAhPDjNB/PD
        SLmPxSazO3R9F3FsFVebaxULjkoaD0X4gyo4iVfZ0Etitnt4VBUYImEdp9E24hNN7S+roJ
        4b/uk9C836p2d7ealB74EC97VWyaK/wRUZ/zNCQQQuQlRHwFSlpTUXgKsWuUtgYLrC00b2
        DhuKLmQgXorOVXXlyVsngiZpKSHAz6akErHk4/tGeSR9b91RvQmO4nscOpH+7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639227910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEMqlwSCdC+q4mXEJtMLLIu+hK3M652sYNwJVu932dk=;
        b=o+0esEv4GWSBsYFsbPmS4n3kOFCoUE0KPXZoB16j5qIuijFpDMcqxa+cXdOcm6j6KJ+TnT
        84JHFw7i0l6pBTAQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/arm_arch_timer: Force
 inlining of erratum_set_next_event_generic()
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117113532.3895208-1-maz@kernel.org>
References: <20211117113532.3895208-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163922790908.23020.1803145048354391304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     1edb7e74a7d3d64dc4e69e7059b4eea526d19a10
Gitweb:        https://git.kernel.org/tip/1edb7e74a7d3d64dc4e69e7059b4eea526d19a10
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 17 Nov 2021 11:35:32 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 Dec 2021 17:47:00 +01:00

clocksource/drivers/arm_arch_timer: Force inlining of erratum_set_next_event_generic()

With some specific kernel configuration and Clang, the kernel fails
to like with something like:

ld.lld: error: undefined symbol: __compiletime_assert_200
>>> referenced by arch_timer.h:156 (./arch/arm64/include/asm/arch_timer.h:156)
>>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a

ld.lld: error: undefined symbol: __compiletime_assert_197
>>> referenced by arch_timer.h:133 (./arch/arm64/include/asm/arch_timer.h:133)
>>>               clocksource/arm_arch_timer.o:(erratum_set_next_event_generic) in archive drivers/built-in.a
make: *** [Makefile:1161: vmlinux] Error 1

These are due to the BUILD_BUG() macros contained in the low-level
accessors (arch_timer_reg_{write,read}_cp15) being emitted, as the
access type wasn't known at compile time.

Fix this by making erratum_set_next_event_generic() __force_inline,
resulting in the 'access' parameter to be resolved at compile time,
similarly to what is already done for set_next_event().

Fixes: 4775bc63f880 ("Add build-time guards for unhandled register accesses")
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20211117113532.3895208-1-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a04eac..1ecd52f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -394,8 +394,13 @@ EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
 
 static atomic_t timer_unstable_counter_workaround_in_use = ATOMIC_INIT(0);
 
-static void erratum_set_next_event_generic(const int access, unsigned long evt,
-						struct clock_event_device *clk)
+/*
+ * Force the inlining of this function so that the register accesses
+ * can be themselves correctly inlined.
+ */
+static __always_inline
+void erratum_set_next_event_generic(const int access, unsigned long evt,
+				    struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 	u64 cval;
