Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98346420E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbhK3XMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbhK3XMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:08 -0500
Date:   Tue, 30 Nov 2021 23:08:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS/z7NtcSww4iuLgP+VHLpWLXlDeJKuPKqN2dRt5YJM=;
        b=qqFWBGJKDv3bVfQYAaWBWWw/8snUVesHqib14Q0NNYgOK+Ro0ZlE62EvmMsYkSceH/HwTt
        dff3IxgU7mEzgTH5466lDIL0rU/5Fth/UuBPKpEBWbUnzR3fmMISBY+sQRLeuI1Wi4BtML
        DjGts3Ggzp5LvKN8P4JJGsQS3Gd3OzKUPj0kD8nx8x2LL1ZJZRii94PhXPlajpVutxI1CQ
        G+9N5bEmyYN0hwQvYwcEA6SNasAuisYfNI5fjpSrSNg+vbWBRYly4DbJbLZxm0Ov3Mz0iI
        KyYe+zBIcf858WC30ahfeBOkPS+FFVa5v3rGytkoRvPl8zPedMRi7pdYL2CM9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS/z7NtcSww4iuLgP+VHLpWLXlDeJKuPKqN2dRt5YJM=;
        b=M1SuX+yj4oWGvnNaoT0HMAti698k9Qrpg1yDzfgBPF/F8oBcrlRNZNgxsma4hQkPTWCHv2
        NOv7PX/tstBIpFDw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-3-mark.rutland@arm.com>
References: <20211129130653.2037928-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372562.11128.2664068146848964404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     6ce895128b3bff738fe8d9dd74747a03e319e466
Gitweb:        https://git.kernel.org/tip/6ce895128b3bff738fe8d9dd74747a03e319e466
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:44 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:43 +01:00

entry: Snapshot thread flags

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
Link: https://lore.kernel.org/r/20211129130653.2037928-3-mark.rutland@arm.com

---
 include/linux/entry-kvm.h | 2 +-
 kernel/entry/common.c     | 4 ++--
 kernel/entry/kvm.c        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0d7865a..07c878d 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -75,7 +75,7 @@ static inline void xfer_to_guest_mode_prepare(void)
  */
 static inline bool __xfer_to_guest_mode_work_pending(void)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = read_thread_flags();
 
 	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d5..bad7136 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -187,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		/* Check if any of the above work has queued a deferred wakeup */
 		tick_nohz_user_enter_prepare();
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = read_thread_flags();
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
@@ -196,7 +196,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = read_thread_flags();
 
 	lockdep_assert_irqs_disabled();
 
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 49972ee..96d476e 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -26,7 +26,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ret)
 			return ret;
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = read_thread_flags();
 	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
 	return 0;
 }
@@ -43,7 +43,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	 * disabled in the inner loop before going into guest mode. No need
 	 * to disable interrupts here.
 	 */
-	ti_work = READ_ONCE(current_thread_info()->flags);
+	ti_work = read_thread_flags();
 	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
 		return 0;
 
