Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B647D7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbhLVTf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:35:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLVTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:35:25 -0500
Date:   Wed, 22 Dec 2021 20:35:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640201724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkPNWOADgnC36BjgHUX/l07Xpal9174kWfL7noL/iQ0=;
        b=z9hToS1fSJQDmIizgg5c68gAfttWbhc5y5zulXIGTv8C7Acknp6zBqymzPubJ9pUJ0Kp0D
        Xn7EmWhswAbPklw3UKW/y0lCvTw6uhQvT0UVAm5QNBVtNwWg1lOjTv8HK2JG7iM+cegmyA
        EckIq8MoBmUwa1D6n5UOTTHuV4pXzDewlN7Rd/gT4EtCeMn+9TazFiJxgYM1ZmUtrbj+1S
        Ip/Bpiwve8C43kQL5JjvXEhKlqTvH7Lm2sJSKOJ42m4xOxJK4WwywWqJtJltakEiOS38p5
        uaSFGrFgYyE+gspkv/t5w/jI7zgZi9zeJ55bNl8Fg/LPdtwlEAMEz8gM/UoPNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640201724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rkPNWOADgnC36BjgHUX/l07Xpal9174kWfL7noL/iQ0=;
        b=dSvyKK+j1I4mP2azSbbXHkXrmQQicRdPLVkeTnEpT/E5u0f8k+iXACOGacRsVzgaRhRrC9
        my6n42wjB2HqsbBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Clark Williams <williams@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Pavel Machek <pavel@denx.de>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH RT] net: Add missing xmit_lock_owner hunks.
Message-ID: <YcN9+vGl7GXAZwJH@linutronix.de>
References: <163977665182.1250088.11049848941535534253@puck.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <163977665182.1250088.11049848941535534253@puck.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch
	net: move xmit_recursion to per-task variable on -RT

lost a few hunks during its rebase.

Add the `xmit_lock_owner' accessor/wrapper.

Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7b34ce34114ac..ce19befe4d87d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3882,17 +3882,17 @@ static inline u32 netif_msg_init(int debug_value, int default_msg_enable_bits)
 #ifdef CONFIG_PREEMPT_RT_FULL
 static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
 {
-	txq->xmit_lock_owner = current;
+	WRITE_ONCE(txq->xmit_lock_owner, current);
 }
 
 static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = NULL;
+	WRITE_ONCE(txq->xmit_lock_owner, NULL);
 }
 
 static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != NULL)
+	if (READ_ONCE(txq->xmit_lock_owner) != NULL)
 		return true;
 	return false;
 }
@@ -3901,17 +3901,19 @@ static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
 
 static inline void netdev_queue_set_owner(struct netdev_queue *txq, int cpu)
 {
-	txq->xmit_lock_owner = cpu;
+	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	WRITE_ONCE(txq->xmit_lock_owner, cpu);
 }
 
 static inline void netdev_queue_clear_owner(struct netdev_queue *txq)
 {
-	txq->xmit_lock_owner = -1;
+	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+	WRITE_ONCE(txq->xmit_lock_owner, -1);
 }
 
 static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
 {
-	if (txq->xmit_lock_owner != -1)
+	if (READ_ONCE(txq->xmit_lock_owner != -1))
 		return true;
 	return false;
 }
@@ -3920,8 +3922,7 @@ static inline bool netdev_queue_has_owner(struct netdev_queue *txq)
 static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, cpu);
+	netdev_queue_set_owner(txq, cpu);
 }
 
 static inline bool __netif_tx_acquire(struct netdev_queue *txq)
@@ -3938,8 +3939,7 @@ static inline void __netif_tx_release(struct netdev_queue *txq)
 static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
+	netdev_queue_set_owner(txq, smp_processor_id());
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
@@ -3947,23 +3947,20 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 	bool ok = spin_trylock(&txq->_xmit_lock);
 
 	if (likely(ok)) {
-		/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-		WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
+		netdev_queue_set_owner(txq, smp_processor_id());
 	}
 	return ok;
 }
 
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, -1);
+	netdev_queue_clear_owner(txq);
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
-	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
-	WRITE_ONCE(txq->xmit_lock_owner, -1);
+	netdev_queue_clear_owner(txq);
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
-- 
2.34.1

