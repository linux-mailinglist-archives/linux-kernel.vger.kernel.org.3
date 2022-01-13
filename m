Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A64A4C07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380412AbiAaQ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:28:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42044 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380358AbiAaQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC544614BE;
        Mon, 31 Jan 2022 16:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C48CC340ED;
        Mon, 31 Jan 2022 16:28:38 +0000 (UTC)
X-Mailbox-Line: From 9f0ed270b80b0209ff781027712c0c46e3f085d6 Mon Sep 17 00:00:00 2001
From:   Clark Williams <williams@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 13 Jan 2022 17:12:15 -0600
Subject: [RFC PATCH PREEMPT_RT 4.19 STABLE] net: Fix compiler warnings on 4.19 PREEMPT_RT with xmit_lock_owner
Message-Id: <20220131162838.1C48CC340ED@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 11 has started complaining about the PREEMPT_RT changes to 2fd949365fe6628fb2
which change the xmit_lock_owner from an integer to a pointer to struct
task_struct. These changes are from the patch:

	     net: move xmit_recursion to per-task variable on -RT

The below patch is ugly but fixes the compiler warnings.

I'd be happy to entertain a better/cleaner solution

Signed-off-by: Clark Williams <williams@redhat.com>
---
 include/linux/netdevice.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7b34ce34114a..fa2a52d24218 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3921,7 +3921,11 @@ static inline void __netif_tx_lock(struct netdev_queue *txq, int cpu)
 {
 	spin_lock(&txq->_xmit_lock);
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	WRITE_ONCE(txq->xmit_lock_owner, current);
+#else
 	WRITE_ONCE(txq->xmit_lock_owner, cpu);
+#endif
 }
 
 static inline bool __netif_tx_acquire(struct netdev_queue *txq)
@@ -3939,7 +3943,11 @@ static inline void __netif_tx_lock_bh(struct netdev_queue *txq)
 {
 	spin_lock_bh(&txq->_xmit_lock);
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	WRITE_ONCE(txq->xmit_lock_owner, current);
+#else
 	WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
+#endif
 }
 
 static inline bool __netif_tx_trylock(struct netdev_queue *txq)
@@ -3948,7 +3956,11 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 
 	if (likely(ok)) {
 		/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+#ifdef CONFIG_PREEMPT_RT_FULL
+		WRITE_ONCE(txq->xmit_lock_owner, current);
+#else
 		WRITE_ONCE(txq->xmit_lock_owner, smp_processor_id());
+#endif
 	}
 	return ok;
 }
@@ -3956,14 +3968,22 @@ static inline bool __netif_tx_trylock(struct netdev_queue *txq)
 static inline void __netif_tx_unlock(struct netdev_queue *txq)
 {
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	WRITE_ONCE(txq->xmit_lock_owner, NULL);
+#else
 	WRITE_ONCE(txq->xmit_lock_owner, -1);
+#endif
 	spin_unlock(&txq->_xmit_lock);
 }
 
 static inline void __netif_tx_unlock_bh(struct netdev_queue *txq)
 {
 	/* Pairs with READ_ONCE() in __dev_queue_xmit() */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	WRITE_ONCE(txq->xmit_lock_owner, NULL);
+#else
 	WRITE_ONCE(txq->xmit_lock_owner, -1);
+#endif
 	spin_unlock_bh(&txq->_xmit_lock);
 }
 
-- 
2.34.1

