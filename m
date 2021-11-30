Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4E46420A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbhK3XMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345139AbhK3XMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:05 -0500
Date:   Tue, 30 Nov 2021 23:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0TAaCRNCxdrNpngO4hR3CYSAEwEUoxiXoxaVXFMzHs=;
        b=XlfwQ6pIF/Zr8X9VG27OiXswquPAdJNi2fqPcQjhkCxbv64FWt2acTjqUuDvaBtpjQLyN/
        0MPQ0+vWj44in03xjhE/LYAXi1YNteB++VBqjA3qwDVqJhAlqUieB9XyV2zyb/5SPPPomf
        +Y46FgMZH0z6g6vaEAWW/YrfVbRSWPfAD9UbpeZYWF84Dy1G4cW7SUUg8dX9msrLnDfRtL
        O00cdSlVFuQ7zLTHitcUmipOLtIl+MJiyUscP9oCLIeLCn7nyo/8H8sLjsp0JSFxaBmoBN
        EwZs+jFdz52GeKqWuvzdiYnrn3GrT6XN0psU5ZQTBHgSg3VZGniJuaBQZwKjYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z0TAaCRNCxdrNpngO4hR3CYSAEwEUoxiXoxaVXFMzHs=;
        b=ifLaVbhncpx2P+4TnBApdQt37R3z9LP8idiwsZU4VTSpSGIGjC0SXcvzfJDXz2LwA01a3M
        QVzzqHU7foCCmUAw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] alpha: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-5-mark.rutland@arm.com>
References: <20211129130653.2037928-5-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372363.11128.3292360009651130124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     7fb2b24bb5c5876a3205cb5b9a580f81e8c9f744
Gitweb:        https://git.kernel.org/tip/7fb2b24bb5c5876a3205cb5b9a580f81e8c9f744
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:46 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:43 +01:00

alpha: Snapshot thread flags

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
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Link: https://lore.kernel.org/r/20211129130653.2037928-5-mark.rutland@arm.com

---
 arch/alpha/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index bc077ba..d8ed71d 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -535,6 +535,6 @@ do_work_pending(struct pt_regs *regs, unsigned long thread_flags,
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 }
