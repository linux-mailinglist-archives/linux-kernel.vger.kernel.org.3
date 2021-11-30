Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA11464201
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbhK3XML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345064AbhK3XMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:02 -0500
Date:   Tue, 30 Nov 2021 23:08:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UK2VU24hOF5/yt6POUUsHZp3e9VmjxHjAONS2e2404I=;
        b=3LlXSXOjwfEc21vd/9E9zEgrEE4bO1yBzF24tNiMAQUxnT/yWPYJvsNXTrSvtQa8BW5nzH
        KNQfSZmnvJ3Q4C9iHXKw1depU97ysrZ7uE+aWx1oln6CyXZcbBq/BPkZOuOj8f/xI0qHA1
        F0aX3R/I6nTIxGcXXWAQzfuy648fSDE7P8GsUy57WxD3HNLzrs+70TYeVMD96JQSel47wx
        7FK9+iM+wQWu/5nHKnL6fyvdDWNd07gc0QtpQax7yHQ04SeMusfdWhPqHIsT1+cM2Cr9t5
        cwz3deLNvarMgqYEDiUQoWgGwFABx1wGMNk5aetECARnTVRuTBjhyLYrshBMhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313720;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UK2VU24hOF5/yt6POUUsHZp3e9VmjxHjAONS2e2404I=;
        b=weR5wvyEgr4sEceGc90YYjFrTVfaVkF4S38mB52SsaNyOOttfOe7x9vSEVEKzZceL05SKQ
        jkoh+fSYUOOB1vBg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] openrisc: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-9-mark.rutland@arm.com>
References: <20211129130653.2037928-9-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831371954.11128.4722786129563972807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     4ea7ce0a79b9450b71b9a88f9f5adbfe2bc3f2e5
Gitweb:        https://git.kernel.org/tip/4ea7ce0a79b9450b71b9a88f9f5adbfe2bc3f2e5
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:50 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:44 +01:00

openrisc: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Generally this is unlikely to cause a
problem in practice, but it is somewhat unsound, and KCSAN will
legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Stafford Horne <shorne@gmail.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Link: https://lore.kernel.org/r/20211129130653.2037928-9-mark.rutland@arm.com

---
 arch/openrisc/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 99516c9..92c5b70 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -313,7 +313,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
