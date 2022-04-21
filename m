Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C753509B98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387082AbiDUJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387050AbiDUJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EF020F67;
        Thu, 21 Apr 2022 01:58:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1669521118;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eamkAcwzbf0PxxCluRVKQtcTvXkL4zji4/cThT7JYBA=;
        b=D/MjLVo5IFNH1ROzo9B3inWtDFNWnRXEBC9/kLYFR3ifb8fLqvDP8+PmeIhHjdY8snLcKG
        GuGzdfhvvMTxXfRgyHltZ++4h3rNbmJ6kaCTSJdgoXHTS0phoxScAgHPASjz3Pz/2xSOIl
        2ZirwRYhblQmBTUIg0w+QxcaCTTNNco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eamkAcwzbf0PxxCluRVKQtcTvXkL4zji4/cThT7JYBA=;
        b=KEmYJKk45T4RvwO0E+04kFoYklnaKAt+lNDRcOVy/p78tjSxLG/zXfOd+YI6Dx8EQT4ngq
        0jXY0dxQzxRpMTAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6B0D2C141;
        Thu, 21 Apr 2022 08:58:09 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/10] serial: icom: switch vague casts to container_of
Date:   Thu, 21 Apr 2022 10:58:00 +0200
Message-Id: <20220421085808.24152-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220421085808.24152-1-jslaby@suse.cz>
References: <20220421085808.24152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In icom, there is an ICOM_PORT macro to perform upcasts from struct
uart_port to struct icom_port. It's not completely safe and it works
only because the first member of icom_port is uart_port. Nowadays, we
use container_of for such an upcast instead.

So introduce a helper (to_icom_port()) with container_of in it and
convert all the ICOM_PORT users to the new helper. Apart from the code
and type safety, it's also clear what icom_port (the variable) is.
Unlike with the old ICOM_PORT (the macro with the cast).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 196 +++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 90 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 142257809e37..42ba953c697e 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -47,9 +47,13 @@
 
 #define ICOM_DRIVER_NAME "icom"
 #define NR_PORTS	       128
-#define ICOM_PORT ((struct icom_port *)port)
 #define to_icom_adapter(d) container_of(d, struct icom_adapter, kref)
 
+static inline struct icom_port *to_icom_port(struct uart_port *port)
+{
+	return container_of(port, struct icom_port, uart_port);
+}
+
 static const struct pci_device_id icom_pci_table[] = {
 	{
 		.vendor = PCI_VENDOR_ID_IBM,
@@ -616,16 +620,17 @@ static void shutdown(struct icom_port *icom_port)
 
 static int icom_write(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned long data_count;
 	unsigned char cmdReg;
 	unsigned long offset;
 	int temp_tail = port->state->xmit.tail;
 
-	trace(ICOM_PORT, "WRITE", 0);
+	trace(icom_port, "WRITE", 0);
 
-	if (cpu_to_le16(ICOM_PORT->statStg->xmit[0].flags) &
+	if (cpu_to_le16(icom_port->statStg->xmit[0].flags) &
 	    SA_FLAGS_READY_TO_XMIT) {
-		trace(ICOM_PORT, "WRITE_FULL", 0);
+		trace(icom_port, "WRITE_FULL", 0);
 		return 0;
 	}
 
@@ -633,7 +638,7 @@ static int icom_write(struct uart_port *port)
 	while ((port->state->xmit.head != temp_tail) &&
 	       (data_count <= XMIT_BUFF_SZ)) {
 
-		ICOM_PORT->xmit_buf[data_count++] =
+		icom_port->xmit_buf[data_count++] =
 		    port->state->xmit.buf[temp_tail];
 
 		temp_tail++;
@@ -641,22 +646,22 @@ static int icom_write(struct uart_port *port)
 	}
 
 	if (data_count) {
-		ICOM_PORT->statStg->xmit[0].flags =
+		icom_port->statStg->xmit[0].flags =
 		    cpu_to_le16(SA_FLAGS_READY_TO_XMIT);
-		ICOM_PORT->statStg->xmit[0].leLength =
+		icom_port->statStg->xmit[0].leLength =
 		    cpu_to_le16(data_count);
 		offset =
-		    (unsigned long) &ICOM_PORT->statStg->xmit[0] -
-		    (unsigned long) ICOM_PORT->statStg;
-		*ICOM_PORT->xmitRestart =
-		    cpu_to_le32(ICOM_PORT->statStg_pci + offset);
-		cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+		    (unsigned long) &icom_port->statStg->xmit[0] -
+		    (unsigned long) icom_port->statStg;
+		*icom_port->xmitRestart =
+		    cpu_to_le32(icom_port->statStg_pci + offset);
+		cmdReg = readb(&icom_port->dram->CmdReg);
 		writeb(cmdReg | CMD_XMIT_RCV_ENABLE,
-		       &ICOM_PORT->dram->CmdReg);
-		writeb(START_XMIT, &ICOM_PORT->dram->StartXmitCmd);
-		trace(ICOM_PORT, "WRITE_START", data_count);
+		       &icom_port->dram->CmdReg);
+		writeb(START_XMIT, &icom_port->dram->StartXmitCmd);
+		trace(icom_port, "WRITE_START", data_count);
 		/* write flush */
-		readb(&ICOM_PORT->dram->StartXmitCmd);
+		readb(&icom_port->dram->StartXmitCmd);
 	}
 
 	return data_count;
@@ -924,11 +929,12 @@ static irqreturn_t icom_interrupt(int irq, void *dev_id)
  */
 static unsigned int icom_tx_empty(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	int ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (cpu_to_le16(ICOM_PORT->statStg->xmit[0].flags) &
+	if (cpu_to_le16(icom_port->statStg->xmit[0].flags) &
 	    SA_FLAGS_READY_TO_XMIT)
 		ret = TIOCSER_TEMT;
 	else
@@ -940,38 +946,40 @@ static unsigned int icom_tx_empty(struct uart_port *port)
 
 static void icom_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char local_osr;
 
-	trace(ICOM_PORT, "SET_MODEM", 0);
-	local_osr = readb(&ICOM_PORT->dram->osr);
+	trace(icom_port, "SET_MODEM", 0);
+	local_osr = readb(&icom_port->dram->osr);
 
 	if (mctrl & TIOCM_RTS) {
-		trace(ICOM_PORT, "RAISE_RTS", 0);
+		trace(icom_port, "RAISE_RTS", 0);
 		local_osr |= ICOM_RTS;
 	} else {
-		trace(ICOM_PORT, "LOWER_RTS", 0);
+		trace(icom_port, "LOWER_RTS", 0);
 		local_osr &= ~ICOM_RTS;
 	}
 
 	if (mctrl & TIOCM_DTR) {
-		trace(ICOM_PORT, "RAISE_DTR", 0);
+		trace(icom_port, "RAISE_DTR", 0);
 		local_osr |= ICOM_DTR;
 	} else {
-		trace(ICOM_PORT, "LOWER_DTR", 0);
+		trace(icom_port, "LOWER_DTR", 0);
 		local_osr &= ~ICOM_DTR;
 	}
 
-	writeb(local_osr, &ICOM_PORT->dram->osr);
+	writeb(local_osr, &icom_port->dram->osr);
 }
 
 static unsigned int icom_get_mctrl(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char status;
 	unsigned int result;
 
-	trace(ICOM_PORT, "GET_MODEM", 0);
+	trace(icom_port, "GET_MODEM", 0);
 
-	status = readb(&ICOM_PORT->dram->isr);
+	status = readb(&icom_port->dram->isr);
 
 	result = ((status & ICOM_DCD) ? TIOCM_CAR : 0)
 	    | ((status & ICOM_RI) ? TIOCM_RNG : 0)
@@ -982,44 +990,47 @@ static unsigned int icom_get_mctrl(struct uart_port *port)
 
 static void icom_stop_tx(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char cmdReg;
 
-	trace(ICOM_PORT, "STOP", 0);
-	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
-	writeb(cmdReg | CMD_HOLD_XMIT, &ICOM_PORT->dram->CmdReg);
+	trace(icom_port, "STOP", 0);
+	cmdReg = readb(&icom_port->dram->CmdReg);
+	writeb(cmdReg | CMD_HOLD_XMIT, &icom_port->dram->CmdReg);
 }
 
 static void icom_start_tx(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char cmdReg;
 
-	trace(ICOM_PORT, "START", 0);
-	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+	trace(icom_port, "START", 0);
+	cmdReg = readb(&icom_port->dram->CmdReg);
 	if ((cmdReg & CMD_HOLD_XMIT) == CMD_HOLD_XMIT)
 		writeb(cmdReg & ~CMD_HOLD_XMIT,
-		       &ICOM_PORT->dram->CmdReg);
+		       &icom_port->dram->CmdReg);
 
 	icom_write(port);
 }
 
 static void icom_send_xchar(struct uart_port *port, char ch)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char xdata;
 	int index;
 	unsigned long flags;
 
-	trace(ICOM_PORT, "SEND_XCHAR", ch);
+	trace(icom_port, "SEND_XCHAR", ch);
 
 	/* wait .1 sec to send char */
 	for (index = 0; index < 10; index++) {
 		spin_lock_irqsave(&port->lock, flags);
-		xdata = readb(&ICOM_PORT->dram->xchar);
+		xdata = readb(&icom_port->dram->xchar);
 		if (xdata == 0x00) {
-			trace(ICOM_PORT, "QUICK_WRITE", 0);
-			writeb(ch, &ICOM_PORT->dram->xchar);
+			trace(icom_port, "QUICK_WRITE", 0);
+			writeb(ch, &icom_port->dram->xchar);
 
 			/* flush write operation */
-			xdata = readb(&ICOM_PORT->dram->xchar);
+			xdata = readb(&icom_port->dram->xchar);
 			spin_unlock_irqrestore(&port->lock, flags);
 			break;
 		}
@@ -1030,38 +1041,41 @@ static void icom_send_xchar(struct uart_port *port, char ch)
 
 static void icom_stop_rx(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char cmdReg;
 
-	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
-	writeb(cmdReg & ~CMD_RCV_ENABLE, &ICOM_PORT->dram->CmdReg);
+	cmdReg = readb(&icom_port->dram->CmdReg);
+	writeb(cmdReg & ~CMD_RCV_ENABLE, &icom_port->dram->CmdReg);
 }
 
 static void icom_break(struct uart_port *port, int break_state)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char cmdReg;
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	trace(ICOM_PORT, "BREAK", 0);
-	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+	trace(icom_port, "BREAK", 0);
+	cmdReg = readb(&icom_port->dram->CmdReg);
 	if (break_state == -1) {
-		writeb(cmdReg | CMD_SND_BREAK, &ICOM_PORT->dram->CmdReg);
+		writeb(cmdReg | CMD_SND_BREAK, &icom_port->dram->CmdReg);
 	} else {
-		writeb(cmdReg & ~CMD_SND_BREAK, &ICOM_PORT->dram->CmdReg);
+		writeb(cmdReg & ~CMD_SND_BREAK, &icom_port->dram->CmdReg);
 	}
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int icom_open(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	int retval;
 
-	kref_get(&ICOM_PORT->adapter->kref);
-	retval = startup(ICOM_PORT);
+	kref_get(&icom_port->adapter->kref);
+	retval = startup(icom_port);
 
 	if (retval) {
-		kref_put(&ICOM_PORT->adapter->kref, icom_kref_release);
-		trace(ICOM_PORT, "STARTUP_ERROR", 0);
+		kref_put(&icom_port->adapter->kref, icom_kref_release);
+		trace(icom_port, "STARTUP_ERROR", 0);
 		return retval;
 	}
 
@@ -1070,23 +1084,25 @@ static int icom_open(struct uart_port *port)
 
 static void icom_close(struct uart_port *port)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	unsigned char cmdReg;
 
-	trace(ICOM_PORT, "CLOSE", 0);
+	trace(icom_port, "CLOSE", 0);
 
 	/* stop receiver */
-	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
-	writeb(cmdReg & ~CMD_RCV_ENABLE, &ICOM_PORT->dram->CmdReg);
+	cmdReg = readb(&icom_port->dram->CmdReg);
+	writeb(cmdReg & ~CMD_RCV_ENABLE, &icom_port->dram->CmdReg);
 
-	shutdown(ICOM_PORT);
+	shutdown(icom_port);
 
-	kref_put(&ICOM_PORT->adapter->kref, icom_kref_release);
+	kref_put(&icom_port->adapter->kref, icom_kref_release);
 }
 
 static void icom_set_termios(struct uart_port *port,
 			     struct ktermios *termios,
 			     struct ktermios *old_termios)
 {
+	struct icom_port *icom_port = to_icom_port(port);
 	int baud;
 	unsigned cflag, iflag;
 	char new_config2;
@@ -1098,7 +1114,7 @@ static void icom_set_termios(struct uart_port *port,
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	trace(ICOM_PORT, "CHANGE_SPEED", 0);
+	trace(icom_port, "CHANGE_SPEED", 0);
 
 	cflag = termios->c_cflag;
 	iflag = termios->c_iflag;
@@ -1129,12 +1145,12 @@ static void icom_set_termios(struct uart_port *port,
 	if (cflag & PARENB) {
 		/* parity bit enabled */
 		new_config2 |= ICOM_ACFG_PARITY_ENAB;
-		trace(ICOM_PORT, "PARENB", 0);
+		trace(icom_port, "PARENB", 0);
 	}
 	if (cflag & PARODD) {
 		/* odd parity */
 		new_config2 |= ICOM_ACFG_PARITY_ODD;
-		trace(ICOM_PORT, "PARODD", 0);
+		trace(icom_port, "PARODD", 0);
 	}
 
 	/* Determine divisor based on baud rate */
@@ -1154,100 +1170,100 @@ static void icom_set_termios(struct uart_port *port,
 	uart_update_timeout(port, cflag, baud);
 
 	/* CTS flow control flag and modem status interrupts */
-	tmp_byte = readb(&(ICOM_PORT->dram->HDLCConfigReg));
+	tmp_byte = readb(&(icom_port->dram->HDLCConfigReg));
 	if (cflag & CRTSCTS)
 		tmp_byte |= HDLC_HDW_FLOW;
 	else
 		tmp_byte &= ~HDLC_HDW_FLOW;
-	writeb(tmp_byte, &(ICOM_PORT->dram->HDLCConfigReg));
+	writeb(tmp_byte, &(icom_port->dram->HDLCConfigReg));
 
 	/*
 	 * Set up parity check flag
 	 */
-	ICOM_PORT->read_status_mask = SA_FLAGS_OVERRUN | SA_FL_RCV_DONE;
+	icom_port->read_status_mask = SA_FLAGS_OVERRUN | SA_FL_RCV_DONE;
 	if (iflag & INPCK)
-		ICOM_PORT->read_status_mask |=
+		icom_port->read_status_mask |=
 		    SA_FLAGS_FRAME_ERROR | SA_FLAGS_PARITY_ERROR;
 
 	if ((iflag & BRKINT) || (iflag & PARMRK))
-		ICOM_PORT->read_status_mask |= SA_FLAGS_BREAK_DET;
+		icom_port->read_status_mask |= SA_FLAGS_BREAK_DET;
 
 	/*
 	 * Characters to ignore
 	 */
-	ICOM_PORT->ignore_status_mask = 0;
+	icom_port->ignore_status_mask = 0;
 	if (iflag & IGNPAR)
-		ICOM_PORT->ignore_status_mask |=
+		icom_port->ignore_status_mask |=
 		    SA_FLAGS_PARITY_ERROR | SA_FLAGS_FRAME_ERROR;
 	if (iflag & IGNBRK) {
-		ICOM_PORT->ignore_status_mask |= SA_FLAGS_BREAK_DET;
+		icom_port->ignore_status_mask |= SA_FLAGS_BREAK_DET;
 		/*
 		 * If we're ignore parity and break indicators, ignore
 		 * overruns too.  (For real raw support).
 		 */
 		if (iflag & IGNPAR)
-			ICOM_PORT->ignore_status_mask |= SA_FLAGS_OVERRUN;
+			icom_port->ignore_status_mask |= SA_FLAGS_OVERRUN;
 	}
 
 	/*
 	 * !!! ignore all characters if CREAD is not set
 	 */
 	if ((cflag & CREAD) == 0)
-		ICOM_PORT->ignore_status_mask |= SA_FL_RCV_DONE;
+		icom_port->ignore_status_mask |= SA_FL_RCV_DONE;
 
 	/* Turn off Receiver to prepare for reset */
-	writeb(CMD_RCV_DISABLE, &ICOM_PORT->dram->CmdReg);
+	writeb(CMD_RCV_DISABLE, &icom_port->dram->CmdReg);
 
 	for (index = 0; index < 10; index++) {
-		if (readb(&ICOM_PORT->dram->PrevCmdReg) == 0x00) {
+		if (readb(&icom_port->dram->PrevCmdReg) == 0x00) {
 			break;
 		}
 	}
 
 	/* clear all current buffers of data */
 	for (rcv_buff = 0; rcv_buff < NUM_RBUFFS; rcv_buff++) {
-		ICOM_PORT->statStg->rcv[rcv_buff].flags = 0;
-		ICOM_PORT->statStg->rcv[rcv_buff].leLength = 0;
-		ICOM_PORT->statStg->rcv[rcv_buff].WorkingLength =
+		icom_port->statStg->rcv[rcv_buff].flags = 0;
+		icom_port->statStg->rcv[rcv_buff].leLength = 0;
+		icom_port->statStg->rcv[rcv_buff].WorkingLength =
 		    (unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
 	}
 
 	for (xmit_buff = 0; xmit_buff < NUM_XBUFFS; xmit_buff++) {
-		ICOM_PORT->statStg->xmit[xmit_buff].flags = 0;
+		icom_port->statStg->xmit[xmit_buff].flags = 0;
 	}
 
 	/* activate changes and start xmit and receiver here */
 	/* Enable the receiver */
-	writeb(new_config3, &(ICOM_PORT->dram->async_config3));
-	writeb(new_config2, &(ICOM_PORT->dram->async_config2));
-	tmp_byte = readb(&(ICOM_PORT->dram->HDLCConfigReg));
+	writeb(new_config3, &(icom_port->dram->async_config3));
+	writeb(new_config2, &(icom_port->dram->async_config2));
+	tmp_byte = readb(&(icom_port->dram->HDLCConfigReg));
 	tmp_byte |= HDLC_PPP_PURE_ASYNC | HDLC_FF_FILL;
-	writeb(tmp_byte, &(ICOM_PORT->dram->HDLCConfigReg));
-	writeb(0x04, &(ICOM_PORT->dram->FlagFillIdleTimer));	/* 0.5 seconds */
-	writeb(0xFF, &(ICOM_PORT->dram->ier));	/* enable modem signal interrupts */
+	writeb(tmp_byte, &(icom_port->dram->HDLCConfigReg));
+	writeb(0x04, &(icom_port->dram->FlagFillIdleTimer));	/* 0.5 seconds */
+	writeb(0xFF, &(icom_port->dram->ier));	/* enable modem signal interrupts */
 
 	/* reset processor */
-	writeb(CMD_RESTART, &ICOM_PORT->dram->CmdReg);
+	writeb(CMD_RESTART, &icom_port->dram->CmdReg);
 
 	for (index = 0; index < 10; index++) {
-		if (readb(&ICOM_PORT->dram->CmdReg) == 0x00) {
+		if (readb(&icom_port->dram->CmdReg) == 0x00) {
 			break;
 		}
 	}
 
 	/* Enable Transmitter and Receiver */
 	offset =
-	    (unsigned long) &ICOM_PORT->statStg->rcv[0] -
-	    (unsigned long) ICOM_PORT->statStg;
-	writel(ICOM_PORT->statStg_pci + offset,
-	       &ICOM_PORT->dram->RcvStatusAddr);
-	ICOM_PORT->next_rcv = 0;
-	ICOM_PORT->put_length = 0;
-	*ICOM_PORT->xmitRestart = 0;
-	writel(ICOM_PORT->xmitRestart_pci,
-	       &ICOM_PORT->dram->XmitStatusAddr);
-	trace(ICOM_PORT, "XR_ENAB", 0);
-	writeb(CMD_XMIT_RCV_ENABLE, &ICOM_PORT->dram->CmdReg);
+	    (unsigned long) &icom_port->statStg->rcv[0] -
+	    (unsigned long) icom_port->statStg;
+	writel(icom_port->statStg_pci + offset,
+	       &icom_port->dram->RcvStatusAddr);
+	icom_port->next_rcv = 0;
+	icom_port->put_length = 0;
+	*icom_port->xmitRestart = 0;
+	writel(icom_port->xmitRestart_pci,
+	       &icom_port->dram->XmitStatusAddr);
+	trace(icom_port, "XR_ENAB", 0);
+	writeb(CMD_XMIT_RCV_ENABLE, &icom_port->dram->CmdReg);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
-- 
2.36.0

