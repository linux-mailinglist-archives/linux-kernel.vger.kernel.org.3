Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578EF5A3019
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbiHZTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344617AbiHZTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:36:41 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E8D2E8A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:36:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [95.31.169.23])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7A66E40D403D;
        Fri, 26 Aug 2022 19:36:33 +0000 (UTC)
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Starke <daniel.starke@siemens.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: [PATCH] tty: n_gsm: avoid call of sleeping functions from atomic context
Date:   Fri, 26 Aug 2022 22:35:45 +0300
Message-Id: <20220826193545.20363-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.25.1
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
 drivers/tty/n_gsm.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cb5ed4155a8d..475bd756f52e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -235,7 +235,7 @@ struct gsm_mux {
 	int old_c_iflag;		/* termios c_iflag value before attach */
 	bool constipated;		/* Asked by remote to shut up */
 
-	spinlock_t tx_lock;
+	struct mutex tx_mutex;
 	unsigned int tx_bytes;		/* TX data outstanding */
 #define TX_THRESH_HI		8192
 #define TX_THRESH_LO		2048
@@ -825,10 +825,9 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 
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
@@ -1019,13 +1018,12 @@ static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
 
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
@@ -1036,7 +1034,7 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 	}
 	if (sweep)
 		gsm_dlci_data_sweep(dlci->gsm);
-	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
+	mutex_unlock(&dlci->gsm->tx_mutex);
 }
 
 /*
@@ -1258,7 +1256,6 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	u8 buf[1];
-	unsigned long flags;
 
 	switch (command) {
 	case CMD_CLD: {
@@ -1280,9 +1277,9 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm->constipated = false;
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
-		spin_lock_irqsave(&gsm->tx_lock, flags);
+		mutex_lock(&gsm->tx_mutex);
 		gsm_data_kick(gsm, NULL);
-		spin_unlock_irqrestore(&gsm->tx_lock, flags);
+		mutex_unlock(&gsm->tx_mutex);
 		break;
 	case CMD_FCOFF:
 		/* Modem wants us to STFU */
@@ -2203,7 +2200,7 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
 	init_waitqueue_head(&gsm->event);
 	spin_lock_init(&gsm->control_lock);
-	spin_lock_init(&gsm->tx_lock);
+	mutex_init(&gsm->tx_mutex);
 
 	if (gsm->encoding == 0)
 		gsm->receive = gsm0_receive;
@@ -2234,6 +2231,7 @@ static void gsm_free_mux(struct gsm_mux *gsm)
 		}
 	}
 	mutex_destroy(&gsm->mutex);
+	mutex_destroy(&gsm->tx_mutex);
 	kfree(gsm->txframe);
 	kfree(gsm->buf);
 	kfree(gsm);
@@ -2304,6 +2302,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	}
 	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
+	mutex_init(&gsm->tx_mutex);
 	kref_init(&gsm->ref);
 	INIT_LIST_HEAD(&gsm->tx_list);
 
@@ -2331,6 +2330,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	spin_unlock(&gsm_mux_lock);
 	if (i == MAX_MUX) {
 		mutex_destroy(&gsm->mutex);
+		mutex_destroy(&gsm->tx_mutex);
 		kfree(gsm->txframe);
 		kfree(gsm->buf);
 		kfree(gsm);
@@ -2654,16 +2654,15 @@ static int gsmld_open(struct tty_struct *tty)
 static void gsmld_write_wakeup(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	unsigned long flags;
 
 	/* Queue poll */
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	spin_lock_irqsave(&gsm->tx_lock, flags);
+	mutex_lock(&gsm->tx_mutex);
 	gsm_data_kick(gsm, NULL);
 	if (gsm->tx_bytes < TX_THRESH_LO) {
 		gsm_dlci_data_sweep(gsm);
 	}
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	mutex_unlock(&gsm->tx_mutex);
 }
 
 /**
@@ -2706,7 +2705,6 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	unsigned long flags;
 	int space;
 	int ret;
 
@@ -2714,14 +2712,13 @@ static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
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
-
+	mutex_unlock(&gsm->tx_mutex);
 	return ret;
 }
 
-- 
2.25.1

