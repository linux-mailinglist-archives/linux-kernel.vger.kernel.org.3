Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C244846420D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbhK3XMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345149AbhK3XMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ECBC061746;
        Tue, 30 Nov 2021 15:08:45 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:08:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlSaZ1o5Oh7OBMQP6eABWCzfLliSVnYWt1mS4xnPW3g=;
        b=kh6T/xXzQiEJ0pFw1jexc0uSL0/mDhdag7YUJs6uJaYFzF3akyiClCEP/iFTrafllVuHqj
        fS8yY5pF5qJCOz0Y9j3I090Q7b3mF8h7SlnQFEdCxusHcCXTXJIq/ms65qb/pcRr9yyhDT
        NbmVZm3M7gWDH0IR0Zu4vDPtDN18ks2OrpQ39NKG2T0KoN1Nq9Lzmk65ETFri0L0XBtHrl
        9Gn3Nq60cFNuZcDb/pFkvcpoy7hmpnjwIaUpoG0EeylKuOEIcJOT4g9qYy3pOb+k0XCjp5
        v83t6RVrZZv4o/R5bsTLUR4J0n3MHrrAF2+yQfmt+4TBINapIszofxrjat445A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlSaZ1o5Oh7OBMQP6eABWCzfLliSVnYWt1mS4xnPW3g=;
        b=gW+qSrbc6dD4jvr6dWvzamSFMlfQ5s3KUUBWV0zYXd9zXKHq4sUyqV/TBGESW+QcjV/pI4
        XrjMsyL+AEHfKWBg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] ARM: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-6-mark.rutland@arm.com>
References: <20211129130653.2037928-6-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372264.11128.12612593154825298183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     050e22bfc4f450d342dbb7eaea470858ad567bce
Gitweb:        https://git.kernel.org/tip/050e22bfc4f450d342dbb7eaea470858ad567bce
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:47 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:43 +01:00

ARM: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Generally this is unlikely to cause a
problem in practice, but it is somewhat unsound, and KCSAN will
legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Link: https://lore.kernel.org/r/20211129130653.2037928-6-mark.rutland@arm.com

---
 arch/arm/kernel/signal.c | 2 +-
 arch/arm/mm/alignment.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a41e27a..c532a60 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -631,7 +631,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index ea81e89..adbb381 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -990,7 +990,7 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		 * there is no work pending for this thread.
 		 */
 		raw_local_irq_disable();
-		if (!(current_thread_info()->flags & _TIF_WORK_MASK))
+		if (!(read_thread_flags() & _TIF_WORK_MASK))
 			set_cr(cr_no_alignment);
 	}
 
