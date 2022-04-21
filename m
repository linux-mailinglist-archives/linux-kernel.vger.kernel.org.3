Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E845509B92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387105AbiDUJBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387051AbiDUJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088D20F69;
        Thu, 21 Apr 2022 01:58:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A245F2112B;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650531490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tX4FIPjspRNKvmJcN4nbqlZRBTlBuDWjQeEK0htQ+hs=;
        b=bPN0So1ssONHMblVOBZCj2jYI+yccx8VdCiDnktgo/fx2AP9sM36l9fr2XYoUe4FMBS0Uv
        xz6dVX2AOxW1vPM/COYLh5h3VNR7LdUd0FU/8LgcykURlojgpun576LrXA9teGkbFpg6PI
        Fq9JJapAoDjbSZfPIenIQ46jYfpNW+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650531490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tX4FIPjspRNKvmJcN4nbqlZRBTlBuDWjQeEK0htQ+hs=;
        b=sg3jZFFeysW1GH3fXeBrwbMM376jkJTcfv+XgPC7OkAMzxmc1F/lq8ENT9sUQawMRGIwi9
        4cuH8e2QltIBicBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6A8982C141;
        Thu, 21 Apr 2022 08:58:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/10] serial: icom: use proper __le types and functions
Date:   Thu, 21 Apr 2022 10:58:02 +0200
Message-Id: <20220421085808.24152-5-jslaby@suse.cz>
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

There is a lot of sparse warnings:
  .../icom.c:228:30: warning: cast from restricted __le16
  .../icom.c:232:66: warning: incorrect type in assignment (different base types)
  .../icom.c:232:66:    expected unsigned int [usertype] leBuffer
  .../icom.c:232:66:    got restricted __le32 [usertype]
  .../icom.c:237:30: warning: cast from restricted __le16
  ...
  .../icom.c:1228:22: warning: cast from restricted __le16

And they are correct. So sort them all out by using proper __leXX and
uXX types and the right direction of conversion: le16_to_cpu() instead
of cpu_to_le16(), where appropriate.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/icom.c | 31 ++++++++++++++-----------------
 drivers/tty/serial/icom.h | 30 +++++++++++++++---------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index fa284f9cbdb0..e1f9d42180ff 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -224,7 +224,7 @@ static int get_port_memory(struct icom_port *icom_port)
 		if (index < (NUM_XBUFFS - 1)) {
 			memset(&icom_port->statStg->xmit[index], 0, sizeof(struct xmit_status_area));
 			icom_port->statStg->xmit[index].leLengthASD =
-			    (unsigned short int) cpu_to_le16(XMIT_BUFF_SZ);
+			    cpu_to_le16(XMIT_BUFF_SZ);
 			trace(icom_port, "FOD_ADDR", stgAddr);
 			trace(icom_port, "FOD_XBUFF",
 			      (unsigned long) icom_port->xmit_buf);
@@ -233,7 +233,7 @@ static int get_port_memory(struct icom_port *icom_port)
 		} else if (index == (NUM_XBUFFS - 1)) {
 			memset(&icom_port->statStg->xmit[index], 0, sizeof(struct xmit_status_area));
 			icom_port->statStg->xmit[index].leLengthASD =
-			    (unsigned short int) cpu_to_le16(XMIT_BUFF_SZ);
+			    cpu_to_le16(XMIT_BUFF_SZ);
 			trace(icom_port, "FOD_XBUFF",
 			      (unsigned long) icom_port->xmit_buf);
 			icom_port->statStg->xmit[index].leBuffer =
@@ -251,7 +251,7 @@ static int get_port_memory(struct icom_port *icom_port)
 		stgAddr = stgAddr + sizeof(icom_port->statStg->rcv[0]);
 		icom_port->statStg->rcv[index].leLength = 0;
 		icom_port->statStg->rcv[index].WorkingLength =
-		    (unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
+		    cpu_to_le16(RCV_BUFF_SZ);
 		if (index < (NUM_RBUFFS - 1) ) {
 			offset = stgAddr - (unsigned long) icom_port->statStg;
 			icom_port->statStg->rcv[index].leNext =
@@ -627,7 +627,7 @@ static int icom_write(struct uart_port *port)
 
 	trace(icom_port, "WRITE", 0);
 
-	if (cpu_to_le16(icom_port->statStg->xmit[0].flags) &
+	if (le16_to_cpu(icom_port->statStg->xmit[0].flags) &
 	    SA_FLAGS_READY_TO_XMIT) {
 		trace(icom_port, "WRITE_FULL", 0);
 		return 0;
@@ -699,8 +699,7 @@ static inline void check_modem_status(struct icom_port *icom_port)
 
 static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 {
-	unsigned short int count;
-	int i;
+	u16 count, i;
 
 	if (port_int_reg & (INT_XMIT_COMPLETED)) {
 		trace(icom_port, "XMIT_COMPLETE", 0);
@@ -709,8 +708,7 @@ static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 		icom_port->statStg->xmit[0].flags &=
 			cpu_to_le16(~SA_FLAGS_READY_TO_XMIT);
 
-		count = (unsigned short int)
-			cpu_to_le16(icom_port->statStg->xmit[0].leLength);
+		count = le16_to_cpu(icom_port->statStg->xmit[0].leLength);
 		icom_port->uart_port.icount.tx += count;
 
 		for (i=0; i<count &&
@@ -732,7 +730,7 @@ static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 {
 	short int count, rcv_buff;
 	struct tty_port *port = &icom_port->uart_port.state->port;
-	unsigned short int status;
+	u16 status;
 	struct uart_icount *icount;
 	unsigned long offset;
 	unsigned char flag;
@@ -740,19 +738,18 @@ static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 	trace(icom_port, "RCV_COMPLETE", 0);
 	rcv_buff = icom_port->next_rcv;
 
-	status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
+	status = le16_to_cpu(icom_port->statStg->rcv[rcv_buff].flags);
 	while (status & SA_FL_RCV_DONE) {
 		int first = -1;
 
 		trace(icom_port, "FID_STATUS", status);
-		count = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].leLength);
+		count = le16_to_cpu(icom_port->statStg->rcv[rcv_buff].leLength);
 
 		trace(icom_port, "RCV_COUNT", count);
 
 		trace(icom_port, "REAL_COUNT", count);
 
-		offset =
-			cpu_to_le32(icom_port->statStg->rcv[rcv_buff].leBuffer) -
+		offset = le32_to_cpu(icom_port->statStg->rcv[rcv_buff].leBuffer) -
 			icom_port->recv_buf_pci;
 
 		/* Block copy all but the last byte as this may have status */
@@ -822,13 +819,13 @@ static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
 		icom_port->statStg->rcv[rcv_buff].flags = 0;
 		icom_port->statStg->rcv[rcv_buff].leLength = 0;
 		icom_port->statStg->rcv[rcv_buff].WorkingLength =
-			(unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
+			cpu_to_le16(RCV_BUFF_SZ);
 
 		rcv_buff++;
 		if (rcv_buff == NUM_RBUFFS)
 			rcv_buff = 0;
 
-		status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
+		status = le16_to_cpu(icom_port->statStg->rcv[rcv_buff].flags);
 	}
 	icom_port->next_rcv = rcv_buff;
 
@@ -933,7 +930,7 @@ static unsigned int icom_tx_empty(struct uart_port *port)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	if (cpu_to_le16(icom_port->statStg->xmit[0].flags) &
+	if (le16_to_cpu(icom_port->statStg->xmit[0].flags) &
 	    SA_FLAGS_READY_TO_XMIT)
 		ret = TIOCSER_TEMT;
 	else
@@ -1224,7 +1221,7 @@ static void icom_set_termios(struct uart_port *port,
 		icom_port->statStg->rcv[rcv_buff].flags = 0;
 		icom_port->statStg->rcv[rcv_buff].leLength = 0;
 		icom_port->statStg->rcv[rcv_buff].WorkingLength =
-		    (unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
+		    cpu_to_le16(RCV_BUFF_SZ);
 	}
 
 	for (xmit_buff = 0; xmit_buff < NUM_XBUFFS; xmit_buff++) {
diff --git a/drivers/tty/serial/icom.h b/drivers/tty/serial/icom.h
index 26e3aa7b01e2..62d5ba81dcfc 100644
--- a/drivers/tty/serial/icom.h
+++ b/drivers/tty/serial/icom.h
@@ -171,13 +171,13 @@ struct statusArea {
 	/* Transmit Status Area                       */
     /**********************************************/
 	struct xmit_status_area{
-		u32 leNext;	/* Next entry in Little Endian on Adapter */
-		u32 leNextASD;
-		u32 leBuffer;	/* Buffer for entry in LE for Adapter */
-		u16 leLengthASD;
-		u16 leOffsetASD;
-		u16 leLength;	/* Length of data in segment */
-		u16 flags;
+		__le32 leNext;	/* Next entry in Little Endian on Adapter */
+		__le32 leNextASD;
+		__le32 leBuffer;	/* Buffer for entry in LE for Adapter */
+		__le16 leLengthASD;
+		__le16 leOffsetASD;
+		__le16 leLength;	/* Length of data in segment */
+		__le16 flags;
 #define SA_FLAGS_DONE           0x0080	/* Done with Segment */
 #define SA_FLAGS_CONTINUED      0x8000	/* More Segments */
 #define SA_FLAGS_IDLE           0x4000	/* Mark IDLE after frm */
@@ -189,13 +189,13 @@ struct statusArea {
 	/* Receive Status Area                        */
     /**********************************************/
 	struct {
-		u32 leNext;	/* Next entry in Little Endian on Adapter */
-		u32 leNextASD;
-		u32 leBuffer;	/* Buffer for entry in LE for Adapter */
-		u16 WorkingLength;	/* size of segment */
-		u16 reserv01;
-		u16 leLength;	/* Length of data in segment */
-		u16 flags;
+		__le32 leNext;	/* Next entry in Little Endian on Adapter */
+		__le32 leNextASD;
+		__le32 leBuffer;	/* Buffer for entry in LE for Adapter */
+		__le16 WorkingLength;	/* size of segment */
+		__le16 reserv01;
+		__le16 leLength;	/* Length of data in segment */
+		__le16 flags;
 #define SA_FL_RCV_DONE           0x0010	/* Data ready */
 #define SA_FLAGS_OVERRUN         0x0040
 #define SA_FLAGS_PARITY_ERROR    0x0080
@@ -227,7 +227,7 @@ struct icom_port {
 	int port;
 	struct statusArea *statStg;
 	dma_addr_t statStg_pci;
-	u32 *xmitRestart;
+	__le32 *xmitRestart;
 	dma_addr_t xmitRestart_pci;
 	unsigned char *xmit_buf;
 	dma_addr_t xmit_buf_pci;
-- 
2.36.0

