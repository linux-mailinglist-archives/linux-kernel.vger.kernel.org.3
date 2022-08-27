Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51145A3634
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiH0JOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiH0JOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:14:45 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9675729C96
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:14:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [95.31.169.23])
        by mail.ispras.ru (Postfix) with ESMTPSA id 188A140737D2;
        Sat, 27 Aug 2022 09:14:36 +0000 (UTC)
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Starke <daniel.starke@siemens.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] tty: n_gsm: avoid call of sleeping functions from atomic context
Date:   Sat, 27 Aug 2022 12:13:53 +0300
Message-Id: <20220827091353.30160-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826193545.20363-1-pchelkin@ispras.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reports the following problem:

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2347
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1105, name: syz-executor423
3 locks held by syz-executor423/1105:
 #0: ffff8881468b9098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x90 drivers/tty/tty_ldisc.c:266
 #1: ffff8881468b9130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: tty_write_lock drivers/tty/tty_io.c:952 [inline]
 #1: ffff8881468b9130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: do_tty_write drivers/tty/tty_io.c:975 [inline]
 #1: ffff8881468b9130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: file_tty_write.constprop.0+0x2a8/0x8e0 drivers/tty/tty_io.c:1118
 #2: ffff88801b06c398 (&gsm->tx_lock){....}-{2:2}, at: gsmld_write+0x5e/0x150 drivers/tty/n_gsm.c:2717
irq event stamp: 3482
hardirqs last  enabled at (3481): [<ffffffff81d13343>] __get_reqs_available+0x143/0x2f0 fs/aio.c:946
hardirqs last disabled at (3482): [<ffffffff87d39722>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (3482): [<ffffffff87d39722>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:159
softirqs last  enabled at (3408): [<ffffffff87e01002>] asm_call_irq_on_stack+0x12/0x20
softirqs last disabled at (3401): [<ffffffff87e01002>] asm_call_irq_on_stack+0x12/0x20
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 2 PID: 1105 Comm: syz-executor423 Not tainted 5.10.137-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x167 lib/dump_stack.c:118
 ___might_sleep.cold+0x1e8/0x22e kernel/sched/core.c:7304
 console_lock+0x19/0x80 kernel/printk/printk.c:2347
 do_con_write+0x113/0x1de0 drivers/tty/vt/vt.c:2909
 con_write+0x22/0xc0 drivers/tty/vt/vt.c:3296
 gsmld_write+0xd0/0x150 drivers/tty/n_gsm.c:2720
 do_tty_write drivers/tty/tty_io.c:1028 [inline]
 file_tty_write.constprop.0+0x502/0x8e0 drivers/tty/tty_io.c:1118
 call_write_iter include/linux/fs.h:1903 [inline]
 aio_write+0x355/0x7b0 fs/aio.c:1580
 __io_submit_one fs/aio.c:1952 [inline]
 io_submit_one+0xf45/0x1a90 fs/aio.c:1999
 __do_sys_io_submit fs/aio.c:2058 [inline]
 __se_sys_io_submit fs/aio.c:2028 [inline]
 __x64_sys_io_submit+0x18c/0x2f0 fs/aio.c:2028
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

The problem happens in the following control flow:

gsmld_write(...)
spin_lock_irqsave(&gsm->tx_lock, flags) // taken a spinlock on TX data
 con_write(...)
  do_con_write(...)
   console_lock()
    might_sleep() // -> bug

As far as console_lock() might sleep it should not be called with
spinlock held.

The patch replaces tx_lock spinlock with mutex in order to avoid the
problem.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 32dd59f96924 ("tty: n_gsm: fix race condition in gsmld_write()")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v2->v1: sorry, now adapted patch from 5.10 to upstream

 drivers/tty/n_gsm.c | 46 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index caa5c14ed57f..be62c601058d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -248,7 +248,7 @@ struct gsm_mux {
 	bool constipated;		/* Asked by remote to shut up */
 	bool has_devices;		/* Devices were registered */
 
-	spinlock_t tx_lock;
+	struct mutex tx_mutex;
 	unsigned int tx_bytes;		/* TX data outstanding */
 #define TX_THRESH_HI		8192
 #define TX_THRESH_LO		2048
@@ -680,7 +680,6 @@ static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 	struct gsm_msg *msg;
 	u8 *dp;
 	int ocr;
-	unsigned long flags;
 
 	msg = gsm_data_alloc(gsm, addr, 0, control);
 	if (!msg)
@@ -702,10 +701,10 @@ static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
 
 	gsm_print_packet("Q->", addr, cr, control, NULL, 0);
 
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	list_add_tail(&msg->list, &gsm->tx_ctrl_list);
 	gsm->tx_bytes += msg->len;
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 	gsmld_write_trigger(gsm);
 
 	return 0;
@@ -730,7 +729,7 @@ static void gsm_dlci_clear_queues(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	spin_unlock_irqrestore(&dlci->lock, flags);
 
 	/* Clear data packets in MUX write queue */
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	list_for_each_entry_safe(msg, nmsg, &gsm->tx_data_list, list) {
 		if (msg->addr != addr)
 			continue;
@@ -738,7 +737,7 @@ static void gsm_dlci_clear_queues(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 		list_del(&msg->list);
 		kfree(msg);
 	}
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 }
 
 /**
@@ -1024,10 +1023,9 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 
 static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
+	mutex_lock(&dlci->gsm->tx_mutex);
 	__gsm_data_queue(dlci, msg);
-	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
+	mutex_unlock(&dlci->gsm->tx_mutex);
 }
 
 /**
@@ -1283,13 +1281,12 @@ static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
 
 static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 {
-	unsigned long flags;
 	int sweep;
 
 	if (dlci->constipated)
 		return;
 
-	spin_lock_irqsave(&dlci->gsm->tx_lock, flags);
+	mutex_lock(&dlci->gsm->tx_mutex);
 	/* If we have nothing running then we need to fire up */
 	sweep = (dlci->gsm->tx_bytes < TX_THRESH_LO);
 	if (dlci->gsm->tx_bytes == 0) {
@@ -1300,7 +1297,7 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 	}
 	if (sweep)
 		gsm_dlci_data_sweep(dlci->gsm);
-	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
+	mutex_unlock(&dlci->gsm->tx_mutex);
 }
 
 /*
@@ -1994,14 +1991,13 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 static void gsm_kick_timer(struct timer_list *t)
 {
 	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
-	unsigned long flags;
 	int sent = 0;
 
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	/* If we have nothing running then we need to fire up */
 	if (gsm->tx_bytes < TX_THRESH_LO)
 		sent = gsm_dlci_data_sweep(gsm);
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 
 	if (sent && debug & 4)
 		pr_info("%s TX queue stalled\n", __func__);
@@ -2506,7 +2502,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
 	init_waitqueue_head(&gsm->event);
 	spin_lock_init(&gsm->control_lock);
-	spin_lock_init(&gsm->tx_lock);
+	mutex_init(&gsm->tx_mutex);
 
 	if (gsm->encoding == 0)
 		gsm->receive = gsm0_receive;
@@ -2538,6 +2534,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 			break;
 		}
 	}
+	mutex_destroy(&gsm->tx_mutex);
 	mutex_destroy(&gsm->mutex);
 	kfree(gsm->txframe);
 	kfree(gsm->buf);
@@ -2609,6 +2606,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
+	mutex_init(&gsm->tx_mutex);
 	kref_init(&gsm->ref);
 	INIT_LIST_HEAD(&gsm->tx_ctrl_list);
 	INIT_LIST_HEAD(&gsm->tx_data_list);
@@ -2636,6 +2634,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_unlock(&gsm_mux_lock);
 	if (i == MAX_MUX) {
+		mutex_destroy(&gsm->tx_mutex);
 		mutex_destroy(&gsm->mutex);
 		kfree(gsm->txframe);
 		kfree(gsm->buf);
@@ -2791,17 +2790,16 @@ static void gsmld_write_trigger(struct gsm_mux *gsm)
 static void gsmld_write_task(struct work_struct *work)
 {
 	struct gsm_mux *gsm = container_of(work, struct gsm_mux, tx_work);
-	unsigned long flags;
 	int i, ret;
 
 	/* All outstanding control channel and control messages and one data
 	 * frame is sent.
 	 */
 	ret = -ENODEV;
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	if (gsm->tty)
 		ret = gsm_data_kick(gsm);
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 
 	if (ret >= 0)
 		for (i = 0; i < NUM_DLCI; i++)
@@ -3012,7 +3010,6 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	unsigned long flags;
 	int space;
 	int ret;
 
@@ -3020,13 +3017,13 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 		return -ENODEV;
 
 	ret = -ENOBUFS;
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	space = tty_write_room(tty);
 	if (space >= nr)
 		ret = tty->ops->write(tty, buf, nr);
 	else
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 
 	return ret;
 }
@@ -3323,14 +3320,13 @@ static struct tty_ldisc_ops tty_ldisc_packet = {
 static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
 {
 	struct gsm_mux *gsm = dlci->gsm;
-	unsigned long flags;
 
 	if (dlci->state != DLCI_OPEN || dlci->adaption != 2)
 		return;
 
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	gsm_dlci_modem_output(gsm, dlci, brk);
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 }
 
 /**
-- 
2.25.1

