Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEAB464203
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbhK3XMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345123AbhK3XMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F0C061574;
        Tue, 30 Nov 2021 15:08:43 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wDatli8shOVzqDiC8VBFTNOfsSmKq3YpV/3+2dGcOE=;
        b=ixSPZM05YAvHaHjNhI7T4GvBtzCeCo/YrjIAAbVFpXRyfKA1VVLXS12WJcKDfyqT1ffJfx
        jjXAfpwtEE0GErIb0sK+KhBuMtgjM45rWC9bnPNROIEhMgrFqKpoPvrHFADIkXpRDHXvJh
        tv3LP8hQmxbfmb4GFziL+nElM+ZOkIZ1AZzwEHQpp8UofwTY52BnPCZ2pNG+vGGO0IBWvn
        SDowTsu7WIRus3gaC9Cm/g93fZ+Exo/E1Z0rwHoSyqIoLYB0uW9C7R8eCYscCZqFLBJCkW
        gItBDzEPjOlw8XJVTy+t8AxAsZccpHtd0fgr7mDqw72k1SyOGF96OzSR/8PKRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wDatli8shOVzqDiC8VBFTNOfsSmKq3YpV/3+2dGcOE=;
        b=0XvCkjVH2H+y3iRLQiS6ls5NjljIQvUSpJvbQwyRw6bdCkg/t2NXwGyyvJXhucJuWUnobc
        yWWICFjZSESvqHDg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] microblaze: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-8-mark.rutland@arm.com>
References: <20211129130653.2037928-8-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372065.11128.18395285019076351046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     e538c5849143a7f0aa97006cd45ce4c0c26d0744
Gitweb:        https://git.kernel.org/tip/e538c5849143a7f0aa97006cd45ce4c0c26d0744
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:49 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:44 +01:00

microblaze: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Generally this is unlikely to cause a
problem in practice, but it is somewhat unsound, and KCSAN will
legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20211129130653.2037928-8-mark.rutland@arm.com

---
 arch/microblaze/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index fc61eb0..23e8a93 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -283,7 +283,7 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
 #ifdef DEBUG_SIG
 	pr_info("do signal: %p %d\n", regs, in_syscall);
 	pr_info("do signal2: %lx %lx %ld [%lx]\n", regs->pc, regs->r1,
-			regs->r12, current_thread_info()->flags);
+			regs->r12, read_thread_flags());
 #endif
 
 	if (get_signal(&ksig)) {
