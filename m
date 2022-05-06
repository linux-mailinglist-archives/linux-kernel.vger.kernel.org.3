Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877C151DB19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442469AbiEFOxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442457AbiEFOxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:53:31 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 07:49:46 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025D6AA64
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:49:46 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202205061448423c35a05e58e6309e13
        for <linux-kernel@vger.kernel.org>;
        Fri, 06 May 2022 16:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q0EwqHXJPpCpzYRXKxdWHgIMdqjF/nGRX1XKYoDpbBk=;
 b=YD8LS7SVO/VKJhGVhm3/nb3uZNPV8JX3Ga+J+f8dlFtk0WMf54AP994glHbNYUM4HiQkKr
 1eD2Vp0aOPjhqfotB/VQa5ZBb+HSxUhrtWJQDFzrzp5m4ydXhGl1AZXkaOmzpXQ5xEIY7LNp
 8aMqKnZ4vb+/AsOCQEEUULvboyGvQ=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 2/2] tty: n_gsm: fix deadlock and link starvation in outgoing data path
Date:   Fri,  6 May 2022 16:47:25 +0200
Message-Id: <20220506144725.1946-2-daniel.starke@siemens.com>
In-Reply-To: <20220506144725.1946-1-daniel.starke@siemens.com>
References: <20220506144725.1946-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The current implementation queues up new control and user packets as needed
and processes this queue down to the ldisc in the same code path.
That means that the upper and the lower layer are hard coupled in the code.
Due to this deadlocks can happen as seen below while transmitting data,
especially during ldisc congestion. Furthermore, the data channels starve
the control channel on high transmission load on the ldisc.

Introduce an additional control channel data queue to prevent timeouts and
link hangups during ldisc congestion. This is being processed before the
user channel data queue in gsm_data_kick(), i.e. with the highest priority.
Put the queue to ldisc data path into a tasklet and trigger it whenever new
data has been put into the transmission queue. Change gsm_dlci_data_sweep()
accordingly to fill up the transmission queue until TX_THRESH_HI. This
solves the locking issue, keeps latency low and provides good performance
on high data load.
Add an timer that kicks in after T1 to keep filling the transmission queue
if the link starts idling.

BUG: spinlock recursion on CPU#0, test_v24_loop/124
 lock: serial8250_ports+0x3a8/0x7500, .magic: dead4ead, .owner: test_v24_loop/124, .owner_cpu: 0
CPU: 0 PID: 124 Comm: test_v24_loop Tainted: G           O      5.18.0-rc2 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x34/0x44
 do_raw_spin_lock+0x76/0xa0
 _raw_spin_lock_irqsave+0x72/0x80
 uart_write_room+0x3b/0xc0
 gsm_data_kick+0x14b/0x240 [n_gsm]
 gsmld_write_wakeup+0x35/0x70 [n_gsm]
 tty_wakeup+0x53/0x60
 tty_port_default_wakeup+0x1b/0x30
 serial8250_tx_chars+0x12f/0x220
 serial8250_handle_irq.part.0+0xfe/0x150
 serial8250_default_handle_irq+0x48/0x80
 serial8250_interrupt+0x56/0xa0
 __handle_irq_event_percpu+0x78/0x1f0
 handle_irq_event+0x34/0x70
 handle_fasteoi_irq+0x90/0x1e0
 __common_interrupt+0x69/0x100
 common_interrupt+0x48/0xc0
 asm_common_interrupt+0x1e/0x40
RIP: 0010:__do_softirq+0x83/0x34e
Code: 2a 0a ff 0f b7 ed c7 44 24 10 0a 00 00 00 48 c7 c7 51 2a 64 82 e8 2d
e2 d5 ff 65 66 c7 05 83 af 1e 7e 00 00 fb b8 ff ff ff ff <49> c7 c2 40 61
80 82 0f bc c5 41 89 c4 41 83 c4 01 0f 84 e6 00 00
RSP: 0018:ffffc90000003f98 EFLAGS: 00000286
RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82642a51 RDI: ffffffff825bb5e7
RBP: 0000000000000200 R08: 00000008de3271a8 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000030 R14: 0000000000000000 R15: 0000000000000000
 ? __do_softirq+0x73/0x34e
 irq_exit_rcu+0xb5/0x100
 common_interrupt+0xa4/0xc0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x1e/0x40
RIP: 0010:_raw_spin_unlock_irqrestore+0x2e/0x50
Code: 00 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 85 28 36 ff
48 89 ef e8 cd 58 36 ff 80 e7 02 74 01 fb bf 01 00 00 00 <e8> 3d 97 33 ff
65 8b 05 96 23 2b 7e 85 c0 74 03 5b 5d c3 0f 1f 44
RSP: 0018:ffffc9000020fd08 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000246 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff8257fd74 RDI: 0000000000000001
RBP: ffff8880057de3a0 R08: 00000008de233000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000100 R14: 0000000000000202 R15: ffff8880057df0b8
 ? _raw_spin_unlock_irqrestore+0x23/0x50
 gsmtty_write+0x65/0x80 [n_gsm]
 n_tty_write+0x33f/0x530
 ? swake_up_all+0xe0/0xe0
 file_tty_write.constprop.0+0x1b1/0x320
 ? n_tty_flush_buffer+0xb0/0xb0
 new_sync_write+0x10c/0x190
 vfs_write+0x282/0x310
 ksys_write+0x68/0xe0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3e5e35c15c
Code: 8b 7c 24 08 89 c5 e8 c5 ff ff ff 89 ef 89 44 24 08 e8 58 bc 02 00 8b
44 24 08 48 83 c4 10 5d c3 48 63 ff b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff
ff 76 10 48 8b 15 fd fc 05 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcee77cd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffcee77cd70 RCX: 00007f3e5e35c15c
RDX: 0000000000000100 RSI: 00007ffcee77cd90 RDI: 0000000000000003
RBP: 0000000000000100 R08: 0000000000000000 R09: 7efefefefefefeff
R10: 00007f3e5e3bddeb R11: 0000000000000246 R12: 00007ffcee77ce8f
R13: 0000000000000001 R14: 000056214404e010 R15: 00007ffcee77cd90
 </TASK>

Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 701 ++++++++++++++++++++++++++++++--------------
 1 file changed, 487 insertions(+), 214 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 08fea3e7674d..b87c752c82f5 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -5,6 +5,14 @@
  *
  *	* THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
  *
+ * Outgoing path:
+ * tty -> DLCI fifo -> scheduler -> GSM MUX data queue    ---o-> ldisc
+ * control message               -> GSM MUX control queue --´
+ *
+ * Incoming path:
+ * ldisc -> gsm_queue() -o--> tty
+ *                        `-> gsm_control_response()
+ *
  * TO DO:
  *	Mostly done:	ioctls for setting modes/timing
  *	Partly done:	hooks so you can pull off frames to non tty devs
@@ -210,6 +218,9 @@ struct gsm_mux {
 	/* Events on the GSM channel */
 	wait_queue_head_t event;
 
+	/* ldisc write task */
+	struct tasklet_struct tx_tsk;
+
 	/* Bits for GSM mode decoding */
 
 	/* Framing Layer */
@@ -240,9 +251,11 @@ struct gsm_mux {
 	unsigned int tx_bytes;		/* TX data outstanding */
 #define TX_THRESH_HI		8192
 #define TX_THRESH_LO		2048
-	struct list_head tx_list;	/* Pending data packets */
+	struct list_head tx0_list;	/* Pending control packets */
+	struct list_head tx1_list;	/* Pending data packets */
 
 	/* Control messages */
+	struct timer_list kick_timer;	/* Kick TX queuing on timeout */
 	struct timer_list t2_timer;	/* Retransmit timer for commands */
 	int cretries;			/* Command retry counter */
 	struct gsm_control *pending_cmd;/* Our current pending command */
@@ -369,6 +382,8 @@ static const u8 gsm_fcs8[256] = {
 
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
 static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
+static void gsmld_write_trigger(struct gsm_mux *gsm);
+static void gsmld_write_task(unsigned long arg);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -419,6 +434,29 @@ static int gsm_read_ea(unsigned int *val, u8 c)
 	return c & EA;
 }
 
+/**
+ *	gsm_read_ea_val	-	read a value until EA
+ *	@val: variable holding value
+ *	@data: buffer of data
+ *	@clen: length of buffer
+ *
+ *	Processes an EA value. Updates the passed variable and
+ *	returns the processed data length.
+ */
+static int gsm_read_ea_val(unsigned int *val, const u8 *data, int clen)
+{
+	int len;
+
+	for (len = 0; clen > 0; len++, clen--) {
+		if (gsm_read_ea(val, *data++)) {
+			/* done */
+			len += 1;
+			break;
+		}
+	}
+	return len;
+}
+
 /**
  *	gsm_encode_modem	-	encode modem data bits
  *	@dlci: DLCI to encode from
@@ -544,94 +582,6 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
 	return olen;
 }
 
-/**
- *	gsm_send	-	send a control frame
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@cr: command/response bit seen as initiator
- *	@control:  control byte including PF bit
- *
- *	Format up and transmit a control frame. These do not go via the
- *	queueing logic as they should be transmitted ahead of data when
- *	they are needed.
- *
- *	FIXME: Lock versus data TX path
- */
-
-static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
-{
-	int len;
-	u8 cbuf[10];
-	u8 ibuf[3];
-	int ocr;
-
-	/* toggle C/R coding if not initiator */
-	ocr = cr ^ (gsm->initiator ? 0 : 1);
-
-	switch (gsm->encoding) {
-	case 0:
-		cbuf[0] = GSM0_SOF;
-		cbuf[1] = (addr << 2) | (ocr << 1) | EA;
-		cbuf[2] = control;
-		cbuf[3] = EA;	/* Length of data = 0 */
-		cbuf[4] = 0xFF - gsm_fcs_add_block(INIT_FCS, cbuf + 1, 3);
-		cbuf[5] = GSM0_SOF;
-		len = 6;
-		break;
-	case 1:
-	case 2:
-		/* Control frame + packing (but not frame stuffing) in mode 1 */
-		ibuf[0] = (addr << 2) | (ocr << 1) | EA;
-		ibuf[1] = control;
-		ibuf[2] = 0xFF - gsm_fcs_add_block(INIT_FCS, ibuf, 2);
-		/* Stuffing may double the size worst case */
-		len = gsm_stuff_frame(ibuf, cbuf + 1, 3);
-		/* Now add the SOF markers */
-		cbuf[0] = GSM1_SOF;
-		cbuf[len + 1] = GSM1_SOF;
-		/* FIXME: we can omit the lead one in many cases */
-		len += 2;
-		break;
-	default:
-		WARN_ON(1);
-		return;
-	}
-	gsmld_output(gsm, cbuf, len);
-	if (!gsm->initiator) {
-		cr = cr & gsm->initiator;
-		control = control & ~PF;
-	}
-	gsm_print_packet("-->", addr, cr, control, NULL, 0);
-}
-
-/**
- *	gsm_response	-	send a control response
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@control:  control byte including PF bit
- *
- *	Format up and transmit a link level response frame.
- */
-
-static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
-{
-	gsm_send(gsm, addr, 0, control);
-}
-
-/**
- *	gsm_command	-	send a control command
- *	@gsm: our GSM mux
- *	@addr: address for control frame
- *	@control:  control byte including PF bit
- *
- *	Format up and transmit a link level command frame.
- */
-
-static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
-{
-	gsm_send(gsm, addr, 1, control);
-}
-
 /* Data transmission */
 
 #define HDR_LEN		6	/* ADDR CTRL [LEN.2] DATA FCS */
@@ -664,61 +614,158 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 }
 
 /**
- *	gsm_data_kick		-	poke the queue
+ *	gsm_send_packet	-	sends a single packet
  *	@gsm: GSM Mux
- *	@dlci: DLCI sending the data
+ *	@msg: packet to send
  *
- *	The tty device has called us to indicate that room has appeared in
- *	the transmit queue. Ram more data into the pipe if we have any
- *	If we have been flow-stopped by a CMD_FCOFF, then we can only
- *	send messages on DLCI0 until CMD_FCON
+ *	The given packet is encoded and send out. No memory is freed.
+ *	The caller must hold the gsm tx lock.
+ */
+static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg)
+{
+	int len, ret;
+
+
+	if (gsm->encoding == 0) {
+		gsm->txframe[0] = GSM0_SOF;
+		memcpy(gsm->txframe + 1, msg->data, msg->len);
+		gsm->txframe[msg->len + 1] = GSM0_SOF;
+		len = msg->len + 2;
+	} else {
+		gsm->txframe[0] = GSM1_SOF;
+		len = gsm_stuff_frame(msg->data, gsm->txframe + 1, msg->len);
+		gsm->txframe[len + 1] = GSM1_SOF;
+		len += 2;
+	}
+
+	if (debug & 4)
+		print_hex_dump_bytes("gsm_send_packet: ", DUMP_PREFIX_OFFSET,
+				     gsm->txframe, len);
+	gsm_print_packet("-->", msg->addr, gsm->initiator, msg->ctrl, msg->data,
+			 msg->len);
+
+	ret = gsmld_output(gsm, gsm->txframe, len);
+	if (ret <= 0)
+		return ret;
+	gsm->tx_bytes -= msg->len;
+
+	return 0;
+}
+
+/**
+ *	gsm_is_ctrl_flow_msg	-	checks if control flow message
+ *	@msg: message to check
  *
- *	FIXME: lock against link layer control transmissions
+ *	Returns non zero if the given message is a flow control command of the
+ *	control channel. Zero is returned in any other case.
  */
+static int gsm_is_ctrl_flow_msg(struct gsm_msg *msg)
+{
+	int ret;
+	unsigned int cmd;
+
+	if (msg->addr > 0)
+		return 0;
+
+	ret = 0;
+	switch (msg->ctrl & ~PF) {
+	case UI:
+	case UIH:
+		cmd = 0;
+		if (gsm_read_ea_val(&cmd, msg->data + 2, msg->len - 2) < 1)
+			break;
+		switch (cmd & ~PF) {
+		case CMD_FCOFF:
+		case CMD_FCON:
+			ret = 1;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
 
-static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
+/**
+ *	gsm_data_kick	-	poke the queue
+ *	@gsm: GSM Mux
+ *
+ *	The tty device has called us to indicate that room has appeared in
+ *	the transmit queue. Ram more data into the pipe if we have any.
+ *	If we have been flow-stopped by a CMD_FCOFF, then we can only
+ *	send messages on DLCI0 until CMD_FCON. The caller must hold
+ *	the gsm tx lock.
+ */
+static int gsm_data_kick(struct gsm_mux *gsm)
 {
 	struct gsm_msg *msg, *nmsg;
-	int len;
+	struct gsm_dlci *dlci;
+	int ret;
 
-	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
-		if (gsm->constipated && msg->addr)
+	clear_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
+
+	/* Serialize control messages and control channel messages first */
+	list_for_each_entry_safe(msg, nmsg, &gsm->tx0_list, list) {
+		if (gsm->constipated && !gsm_is_ctrl_flow_msg(msg))
+			return -EAGAIN;
+		ret = gsm_send_packet(gsm, msg);
+		switch (ret) {
+		case -ENOSPC:
+			return -ENOSPC;
+		case -ENODEV:
+			/* ldisc not open */
+			gsm->tx_bytes -= msg->len;
+			list_del(&msg->list);
+			kfree(msg);
 			continue;
-		if (gsm->encoding != 0) {
-			gsm->txframe[0] = GSM1_SOF;
-			len = gsm_stuff_frame(msg->data,
-						gsm->txframe + 1, msg->len);
-			gsm->txframe[len + 1] = GSM1_SOF;
-			len += 2;
-		} else {
-			gsm->txframe[0] = GSM0_SOF;
-			memcpy(gsm->txframe + 1 , msg->data, msg->len);
-			gsm->txframe[msg->len + 1] = GSM0_SOF;
-			len = msg->len + 2;
-		}
-
-		if (debug & 4)
-			print_hex_dump_bytes("gsm_data_kick: ",
-					     DUMP_PREFIX_OFFSET,
-					     gsm->txframe, len);
-		if (gsmld_output(gsm, gsm->txframe, len) <= 0)
+		default:
+			if (ret >= 0) {
+				list_del(&msg->list);
+				kfree(msg);
+			}
 			break;
-		/* FIXME: Can eliminate one SOF in many more cases */
-		gsm->tx_bytes -= msg->len;
-
-		list_del(&msg->list);
-		kfree(msg);
+		}
+	}
 
-		if (dlci) {
-			tty_port_tty_wakeup(&dlci->port);
-		} else {
-			int i = 0;
+	if (gsm->constipated)
+		return -EAGAIN;
 
-			for (i = 0; i < NUM_DLCI; i++)
-				if (gsm->dlci[i])
-					tty_port_tty_wakeup(&gsm->dlci[i]->port);
+	/* Serialize other channels */
+	if (list_empty(&gsm->tx1_list))
+		return 0;
+	list_for_each_entry_safe(msg, nmsg, &gsm->tx1_list, list) {
+		dlci = gsm->dlci[msg->addr];
+		/* Send only messages for DLCIs with valid state */
+		if (dlci->state != DLCI_OPEN) {
+			gsm->tx_bytes -= msg->len;
+			list_del(&msg->list);
+			kfree(msg);
+			continue;
+		}
+		ret = gsm_send_packet(gsm, msg);
+		switch (ret) {
+		case -ENOSPC:
+			return -ENOSPC;
+		case -ENODEV:
+			/* ldisc not open */
+			gsm->tx_bytes -= msg->len;
+			list_del(&msg->list);
+			kfree(msg);
+			continue;
+		default:
+			if (ret >= 0) {
+				list_del(&msg->list);
+				kfree(msg);
+			}
+			break;
 		}
 	}
+
+	return 1;
 }
 
 /**
@@ -767,9 +814,22 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	msg->data = dp;
 
 	/* Add to the actual output queue */
-	list_add_tail(&msg->list, &gsm->tx_list);
+	switch (msg->ctrl & ~PF) {
+	case UI:
+	case UIH:
+		if (msg->addr > 0)
+			list_add_tail(&msg->list, &gsm->tx1_list);
+		else
+			list_add_tail(&msg->list, &gsm->tx0_list);
+		break;
+	default:
+		list_add_tail(&msg->list, &gsm->tx0_list);
+		break;
+	}
 	gsm->tx_bytes += msg->len;
-	gsm_data_kick(gsm, dlci);
+
+	gsmld_write_trigger(gsm);
+	mod_timer(&gsm->kick_timer, jiffies + 10 * gsm->t1 * HZ / 100);
 }
 
 /**
@@ -790,6 +850,112 @@ static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 	spin_unlock_irqrestore(&dlci->gsm->tx_lock, flags);
 }
 
+/**
+ *	gsm_send	-	send a control frame
+ *	@gsm: our GSM mux
+ *	@addr: address for control frame
+ *	@cr: command/response bit seen as initiator
+ *	@control:  control byte including PF bit
+ *
+ *	Format up and transmit a control frame. These should be transmitted
+ *	ahead of data when they are needed.
+ */
+static int gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
+{
+	struct gsm_msg *msg;
+	u8 *dp;
+	int ocr;
+	unsigned long flags;
+
+	msg = gsm_data_alloc(gsm, addr, 0, control);
+	if (!msg) {
+		pr_err("%s: gsm_data_alloc error", __func__);
+		return -ENOMEM;
+	}
+
+	/* toggle C/R coding if not initiator */
+	ocr = cr ^ (gsm->initiator ? 0 : 1);
+
+	msg->data -= 3;
+	dp = msg->data;
+	*dp++ = (addr << 2) | (ocr << 1) | EA;
+	*dp++ = control;
+
+	if (gsm->encoding == 0)
+		*dp++ = EA; /* Length of data = 0 */
+
+	*dp = 0xFF - gsm_fcs_add_block(INIT_FCS, msg->data, dp - msg->data);
+	msg->len = (dp - msg->data) + 1;
+
+	gsm_print_packet("Q->", addr, cr, control, NULL, 0);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	list_add_tail(&msg->list, &gsm->tx0_list);
+	gsm->tx_bytes += msg->len;
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	gsmld_write_trigger(gsm);
+
+	return 0;
+}
+
+/**
+ *	gsm_response	-	send a control response
+ *	@gsm: our GSM mux
+ *	@addr: address for control frame
+ *	@control:  control byte including PF bit
+ *
+ *	Format up and transmit a link level response frame.
+ */
+
+static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
+{
+	gsm_send(gsm, addr, 0, control);
+}
+
+/**
+ *	gsm_command	-	send a control command
+ *	@gsm: our GSM mux
+ *	@addr: address for control frame
+ *	@control:  control byte including PF bit
+ *
+ *	Format up and transmit a link level command frame.
+ */
+
+static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
+{
+	gsm_send(gsm, addr, 1, control);
+}
+
+/**
+ *	gsm_dlci_clear_queues	-	remove outstanding data for a DLCI
+ *	@gsm: mux
+ *	@dlci: clear for this DLCI
+ *
+ *	Clears the data queues for a given DLCI.
+ */
+static void gsm_dlci_clear_queues(struct gsm_mux *gsm, struct gsm_dlci *dlci)
+{
+	struct gsm_msg *msg, *nmsg;
+	int addr = dlci->addr;
+	unsigned long flags;
+
+	/* Clear DLCI write fifo first */
+	spin_lock_irqsave(&dlci->lock, flags);
+	kfifo_reset(&dlci->fifo);
+	spin_unlock_irqrestore(&dlci->lock, flags);
+
+	/* Clear data packets in MUX write queue */
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	list_for_each_entry_safe(msg, nmsg, &gsm->tx1_list, list) {
+		if (msg->addr != addr)
+			continue;
+		gsm->tx_bytes -= msg->len;
+		list_del(&msg->list);
+		kfree(msg);
+	}
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+}
+
 /**
  *	gsm_dlci_data_output	-	try and push data out of a DLCI
  *	@gsm: mux
@@ -804,43 +970,52 @@ static void gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 
 static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 {
+	u8 *dp = NULL;
 	struct gsm_msg *msg;
-	u8 *dp;
-	int len, total_size, size;
-	int h = dlci->adaption - 1;
+	int h, len, size;
 
-	total_size = 0;
-	while (1) {
-		len = kfifo_len(&dlci->fifo);
-		if (len == 0)
-			return total_size;
-
-		/* MTU/MRU count only the data bits */
-		if (len > gsm->mtu)
-			len = gsm->mtu;
-
-		size = len + h;
-
-		msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-		/* FIXME: need a timer or something to kick this so it can't
-		   get stuck with no work outstanding and no buffer free */
-		if (msg == NULL)
-			return -ENOMEM;
-		dp = msg->data;
-		switch (dlci->adaption) {
-		case 1:	/* Unstructured */
-			break;
-		case 2:	/* Unstructed with modem bits.
-		Always one byte as we never send inline break data */
-			*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
-			break;
-		}
-		WARN_ON(kfifo_out_locked(&dlci->fifo, dp , len, &dlci->lock) != len);
-		__gsm_data_queue(dlci, msg);
-		total_size += size;
+	/* for modem bits without break data */
+	h = ((dlci->adaption == 1) ? 0 : 1);
+
+	len = kfifo_len(&dlci->fifo);
+	if (len == 0)
+		return 0;
+
+	/* MTU/MRU count only the data bits but watch adaption mode */
+	if ((len + h) > gsm->mtu)
+		len = gsm->mtu - h;
+
+	size = len + h;
+
+	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	if (!msg) {
+		pr_err("%s: gsm_data_alloc error", __func__);
+		return -ENOMEM;
 	}
+	dp = msg->data;
+	switch (dlci->adaption) {
+	case 1: /* Unstructured */
+		break;
+	case 2: /* Unstructured with modem bits.
+		 * Always one byte as we never send inline break data
+		 */
+		*dp++ = (gsm_encode_modem(dlci) << 1) | EA;
+		break;
+	default:
+		pr_err("%s: unsupported adaption %d\n", __func__,
+		       dlci->adaption);
+		break;
+	}
+
+	WARN_ON(len != kfifo_out_locked(&dlci->fifo, dp, len,
+		&dlci->lock));
+
+	/* Notify upper layer about available send space. */
+	tty_port_tty_wakeup(&dlci->port);
+
+	__gsm_data_queue(dlci, msg);
 	/* Bytes of data we used up */
-	return total_size;
+	return size;
 }
 
 /**
@@ -989,32 +1164,43 @@ static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
  *	renegotiate DLCI priorities with optional stuff. Needs optimising.
  */
 
-static void gsm_dlci_data_sweep(struct gsm_mux *gsm)
+static int gsm_dlci_data_sweep(struct gsm_mux *gsm)
 {
-	int len;
 	/* Priority ordering: We should do priority with RR of the groups */
-	int i = 1;
-
-	while (i < NUM_DLCI) {
-		struct gsm_dlci *dlci;
+	int i, len, ret = 0;
+	bool sent;
+	struct gsm_dlci *dlci;
 
-		if (gsm->tx_bytes > TX_THRESH_HI)
-			break;
-		dlci = gsm->dlci[i];
-		if (dlci == NULL || dlci->constipated) {
-			i++;
-			continue;
+	while (gsm->tx_bytes < TX_THRESH_HI) {
+		for (sent = false, i = 1; i < NUM_DLCI; i++) {
+			dlci = gsm->dlci[i];
+			/* skip unused or blocked channel */
+			if (!dlci || dlci->constipated)
+				continue;
+			/* skip channels with invalid state */
+			if (dlci->state != DLCI_OPEN)
+				continue;
+			/* count the sent data per adaption */
+			if (dlci->adaption < 3 && !dlci->net)
+				len = gsm_dlci_data_output(gsm, dlci);
+			else
+				len = gsm_dlci_data_output_framed(gsm, dlci);
+			/* on error exit */
+			if (len < 0)
+				return ret;
+			if (len > 0) {
+				ret++;
+				sent = true;
+				/* The lower DLCs can starve the higher DLCs! */
+				break;
+			}
+			/* try next */
 		}
-		if (dlci->adaption < 3 && !dlci->net)
-			len = gsm_dlci_data_output(gsm, dlci);
-		else
-			len = gsm_dlci_data_output_framed(gsm, dlci);
-		if (len < 0)
+		if (!sent)
 			break;
-		/* DLCI empty - try the next */
-		if (len == 0)
-			i++;
-	}
+	};
+
+	return ret;
 }
 
 /**
@@ -1260,7 +1446,6 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	u8 buf[1];
-	unsigned long flags;
 
 	switch (command) {
 	case CMD_CLD: {
@@ -1282,9 +1467,7 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 		gsm->constipated = false;
 		gsm_control_reply(gsm, CMD_FCON, NULL, 0);
 		/* Kick the link in case it is idling */
-		spin_lock_irqsave(&gsm->tx_lock, flags);
-		gsm_data_kick(gsm, NULL);
-		spin_unlock_irqrestore(&gsm->tx_lock, flags);
+		gsmld_write_trigger(gsm);
 		break;
 	case CMD_FCOFF:
 		/* Modem wants us to STFU */
@@ -1487,7 +1670,7 @@ static int gsm_control_wait(struct gsm_mux *gsm, struct gsm_control *control)
 
 static void gsm_dlci_close(struct gsm_dlci *dlci)
 {
-	unsigned long flags;
+	struct gsm_mux *gsm = dlci->gsm;
 
 	del_timer(&dlci->t1);
 	if (debug & 8)
@@ -1497,9 +1680,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 	dlci->constipated = true;
 	if (dlci->addr != 0) {
 		tty_port_tty_hangup(&dlci->port, false);
-		spin_lock_irqsave(&dlci->lock, flags);
-		kfifo_reset(&dlci->fifo);
-		spin_unlock_irqrestore(&dlci->lock, flags);
+		gsm_dlci_clear_queues(gsm, dlci);
 		/* Ensure that gsmtty_open() can return. */
 		tty_port_set_initialized(&dlci->port, 0);
 		wake_up_interruptible(&dlci->port.open_wait);
@@ -1530,6 +1711,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	/* Send current modem state */
 	if (dlci->addr)
 		gsm_modem_update(dlci, 0);
+	gsm_dlci_data_kick(dlci);
 	wake_up(&dlci->gsm->event);
 }
 
@@ -1733,6 +1915,30 @@ static void gsm_dlci_command(struct gsm_dlci *dlci, const u8 *data, int len)
 	}
 }
 
+/**
+ *	gsm_kick_timer	-	transmit if possible
+ *	@t: timer contained in our gsm object
+ *
+ *	Transmit data from DLCIs if the queue is empty. We can't rely on
+ *	a tty wakeup except when we filled the pipe so we need to fire off
+ *	new data ourselves in other cases.
+ */
+static void gsm_kick_timer(struct timer_list *t)
+{
+	struct gsm_mux *gsm = from_timer(gsm, t, kick_timer);
+	unsigned long flags;
+	int sent = 0;
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	/* If we have nothing running then we need to fire up */
+	if (gsm->tx_bytes < TX_THRESH_LO)
+		sent = gsm_dlci_data_sweep(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
+	if (sent && debug & 4)
+		pr_info("%s TX queue stalled\n", __func__);
+}
+
 /*
  *	Allocate/Free DLCI channels
  */
@@ -2060,7 +2266,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 	} else if ((c & ISO_IEC_646_MASK) == XOFF) {
 		gsm->constipated = false;
 		/* Kick the link in case it is idling */
-		gsm_data_kick(gsm, NULL);
+		gsmld_write_trigger(gsm);
 		return;
 	}
 	if (c == GSM1_SOF) {
@@ -2188,8 +2394,13 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	}
 
 	/* Finish outstanding timers, making sure they are done */
+	del_timer_sync(&gsm->kick_timer);
 	del_timer_sync(&gsm->t2_timer);
 
+	/* Finish writing task */
+	tasklet_disable(&gsm->tx_tsk);
+	tasklet_kill(&gsm->tx_tsk);
+
 	/* Free up any link layer users and finally the control channel */
 	for (i = NUM_DLCI - 1; i >= 0; i--)
 		if (gsm->dlci[i])
@@ -2197,9 +2408,12 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
-	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
+	list_for_each_entry_safe(txq, ntxq, &gsm->tx0_list, list)
+		kfree(txq);
+	INIT_LIST_HEAD(&gsm->tx0_list);
+	list_for_each_entry_safe(txq, ntxq, &gsm->tx1_list, list)
 		kfree(txq);
-	INIT_LIST_HEAD(&gsm->tx_list);
+	INIT_LIST_HEAD(&gsm->tx1_list);
 }
 
 /**
@@ -2215,10 +2429,9 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
 
+	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
-	init_waitqueue_head(&gsm->event);
-	spin_lock_init(&gsm->control_lock);
-	spin_lock_init(&gsm->tx_lock);
+	tasklet_init(&gsm->tx_tsk, gsmld_write_task, (unsigned long)gsm);
 
 	if (gsm->encoding == 0)
 		gsm->receive = gsm0_receive;
@@ -2317,10 +2530,15 @@ static struct gsm_mux *gsm_alloc_mux(void)
 		kfree(gsm);
 		return NULL;
 	}
+	/* Initialize locks and queues */
+	init_waitqueue_head(&gsm->event);
+	spin_lock_init(&gsm->control_lock);
+	spin_lock_init(&gsm->tx_lock);
 	spin_lock_init(&gsm->lock);
 	mutex_init(&gsm->mutex);
 	kref_init(&gsm->ref);
-	INIT_LIST_HEAD(&gsm->tx_list);
+	INIT_LIST_HEAD(&gsm->tx0_list);
+	INIT_LIST_HEAD(&gsm->tx1_list);
 
 	gsm->t1 = T1;
 	gsm->t2 = T2;
@@ -2478,6 +2696,48 @@ static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len)
 	return gsm->tty->ops->write(gsm->tty, data, len);
 }
 
+
+/**
+ *	gsmld_write_trigger	-	schedule ldisc write task
+ *	@gsm: our mux
+ */
+static void gsmld_write_trigger(struct gsm_mux *gsm)
+{
+	if (!gsm || !gsm->dlci[0] || gsm->dlci[0]->dead)
+		return;
+	tasklet_schedule(&gsm->tx_tsk);
+}
+
+
+/**
+ *	gsmld_write_task	-	ldisc write task
+ *	@arg: our mux
+ *
+ *	Writes out data to the ldisc if possible. We are doing this in a task
+ *	to avoid dead-locking. This task returns if no space or data is left for
+ *	output.
+ */
+static void gsmld_write_task(unsigned long arg)
+{
+	struct gsm_mux *gsm = (struct gsm_mux *)arg;
+	unsigned long flags;
+	int i, ret;
+
+	/* All outstanding control channel and control messages and one data
+	 * frame is sent.
+	 */
+	ret = -ENODEV;
+	spin_lock_irqsave(&gsm->tx_lock, flags);
+	if (gsm->tty)
+		ret = gsm_data_kick(gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+
+	if (ret >= 0)
+		for (i = 0; i < NUM_DLCI; i++)
+			if (gsm->dlci[i])
+				tty_port_tty_wakeup(&gsm->dlci[i]->port);
+}
+
 /**
  *	gsmld_attach_gsm	-	mode set up
  *	@tty: our tty structure
@@ -2602,6 +2862,7 @@ static void gsmld_flush_buffer(struct tty_struct *tty)
 static void gsmld_close(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
+	unsigned long tx_flags;
 
 	/* The ldisc locks and closes the port before calling our close. This
 	 * means we have no way to do a proper disconnect. We will not bother
@@ -2609,7 +2870,10 @@ static void gsmld_close(struct tty_struct *tty)
 	 */
 	gsm_cleanup_mux(gsm, false);
 
+	/* Prevent write during detach */
+	spin_lock_irqsave(&gsm->tx_lock, tx_flags);
 	gsmld_detach_gsm(tty, gsm);
+	spin_unlock_irqrestore(&gsm->tx_lock, tx_flags);
 
 	gsmld_flush_buffer(tty);
 	/* Do other clean up here */
@@ -2665,16 +2929,12 @@ static int gsmld_open(struct tty_struct *tty)
 static void gsmld_write_wakeup(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	unsigned long flags;
+
+	if (!gsm)
+		return;
 
 	/* Queue poll */
-	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	spin_lock_irqsave(&gsm->tx_lock, flags);
-	gsm_data_kick(gsm, NULL);
-	if (gsm->tx_bytes < TX_THRESH_LO) {
-		gsm_dlci_data_sweep(gsm);
-	}
-	spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	gsmld_write_trigger(gsm);
 }
 
 /**
@@ -2718,11 +2978,24 @@ static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
 static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
 			   const unsigned char *buf, size_t nr)
 {
-	int space = tty_write_room(tty);
-	if (space >= nr)
-		return tty->ops->write(tty, buf, nr);
-	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-	return -ENOBUFS;
+	int space;
+	int ret;
+	struct gsm_mux *gsm = tty->disc_data;
+	unsigned long flags;
+
+	if (!gsm)
+		return -ENODEV;
+
+	space = tty_write_room(tty);
+	if (space >= nr) {
+		spin_lock_irqsave(&gsm->tx_lock, flags);
+		ret = tty->ops->write(tty, buf, nr);
+		spin_unlock_irqrestore(&gsm->tx_lock, flags);
+	} else {
+		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
+		ret = -ENOBUFS;
+	}
+	return ret;
 }
 
 /**
-- 
2.34.1

