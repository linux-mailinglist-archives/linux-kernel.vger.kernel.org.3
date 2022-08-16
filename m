Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97861595B67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiHPMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbiHPMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C55052DF9;
        Tue, 16 Aug 2022 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651128; x=1692187128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n+5QK8ChqVPwcnYu7FKcYERFrhWb2h1TLXZC0gXgFGc=;
  b=IcGmS8su1k+FeUxD3YnBKuksbLNhe2z7FOtesPyPeU1IeMg4hcXlO0oa
   nHBlWbHa78E7nc804y12notANkz0bPr6nQ+0pfevQUslHA4VR8kdPv93h
   Zo1N7s6omEMlSh0mHfjy8Vj5VDaENLHBcTFqTE/f5Gfp/8WBO4KcgHZf3
   0PIEoqr/EhDjVXAwC8S63coyFBCK1j3hs1M3tFytpIgZ0zBxkOZWBGAAu
   HOEN+ySXLmLeD30ykuKiTifVwaH65zMhaYBj33nakdeoM0Vt5pgtdqOKR
   /4y6Mlm3reFCC/zuRH/TUwYjXMH4YeqVlg0lOwz9KpVF/aZzY7W37QFQd
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="353942385"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="353942385"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080932"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:58:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 7/8] usb: serial: Make ->set_termios() old ktermios const
Date:   Tue, 16 Aug 2022 14:57:38 +0300
Message-Id: <20220816115739.10928-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be no reason to adjust old ktermios which is going to get
discarded anyway.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/usb/serial/ark3116.c          |  2 +-
 drivers/usb/serial/belkin_sa.c        |  6 ++++--
 drivers/usb/serial/ch341.c            |  5 +++--
 drivers/usb/serial/cp210x.c           | 13 ++++++++-----
 drivers/usb/serial/cypress_m8.c       |  6 ++++--
 drivers/usb/serial/digi_acceleport.c  |  6 ++++--
 drivers/usb/serial/f81232.c           |  3 ++-
 drivers/usb/serial/f81534.c           |  4 ++--
 drivers/usb/serial/ftdi_sio.c         |  6 ++++--
 drivers/usb/serial/io_edgeport.c      |  7 ++++---
 drivers/usb/serial/io_ti.c            |  8 +++++---
 drivers/usb/serial/ir-usb.c           |  6 ++++--
 drivers/usb/serial/iuu_phoenix.c      |  3 ++-
 drivers/usb/serial/keyspan.c          |  3 ++-
 drivers/usb/serial/keyspan_pda.c      |  3 ++-
 drivers/usb/serial/kl5kusb105.c       |  5 +++--
 drivers/usb/serial/kobil_sct.c        |  6 ++++--
 drivers/usb/serial/mct_u232.c         |  5 +++--
 drivers/usb/serial/mos7720.c          |  5 +++--
 drivers/usb/serial/mos7840.c          |  5 +++--
 drivers/usb/serial/mxuport.c          |  4 ++--
 drivers/usb/serial/oti6858.c          |  6 ++++--
 drivers/usb/serial/pl2303.c           |  3 ++-
 drivers/usb/serial/quatech2.c         |  4 ++--
 drivers/usb/serial/spcp8x5.c          |  3 ++-
 drivers/usb/serial/ssu100.c           |  4 ++--
 drivers/usb/serial/ti_usb_3410_5052.c |  6 ++++--
 drivers/usb/serial/upd78f0730.c       |  4 ++--
 drivers/usb/serial/whiteheat.c        |  6 ++++--
 drivers/usb/serial/xr_serial.c        | 20 ++++++++++++--------
 include/linux/usb/serial.h            |  4 ++--
 31 files changed, 105 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 39eaa7b97c40..9452291f1703 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -189,7 +189,7 @@ static void ark3116_port_remove(struct usb_serial_port *port)
 
 static void ark3116_set_termios(struct tty_struct *tty,
 				struct usb_serial_port *port,
-				struct ktermios *old_termios)
+				const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	struct ark3116_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 8107e4b5b03b..9331a562dac0 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -44,7 +44,8 @@ static void belkin_sa_close(struct usb_serial_port *port);
 static void belkin_sa_read_int_callback(struct urb *urb);
 static void belkin_sa_process_read_urb(struct urb *urb);
 static void belkin_sa_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios * old);
+				  struct usb_serial_port *port,
+				  const struct ktermios *old_termios);
 static void belkin_sa_break_ctl(struct tty_struct *tty, int break_state);
 static int  belkin_sa_tiocmget(struct tty_struct *tty);
 static int  belkin_sa_tiocmset(struct tty_struct *tty,
@@ -273,7 +274,8 @@ static void belkin_sa_process_read_urb(struct urb *urb)
 }
 
 static void belkin_sa_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				  struct usb_serial_port *port,
+				  const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	struct belkin_sa_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 2798fca71261..5731d69fcf18 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -103,7 +103,7 @@ struct ch341_private {
 
 static void ch341_set_termios(struct tty_struct *tty,
 			      struct usb_serial_port *port,
-			      struct ktermios *old_termios);
+			      const struct ktermios *old_termios);
 
 static int ch341_control_out(struct usb_device *dev, u8 request,
 			     u16 value, u16 index)
@@ -470,7 +470,8 @@ static int ch341_open(struct tty_struct *tty, struct usb_serial_port *port)
  * tty->termios contains the new setting to be used.
  */
 static void ch341_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			      struct usb_serial_port *port,
+			      const struct ktermios *old_termios)
 {
 	struct ch341_private *priv = usb_get_serial_port_data(port);
 	unsigned baud_rate;
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c374620a486f..bb39d40974cf 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -31,9 +31,9 @@
 static int cp210x_open(struct tty_struct *tty, struct usb_serial_port *);
 static void cp210x_close(struct usb_serial_port *);
 static void cp210x_change_speed(struct tty_struct *, struct usb_serial_port *,
-							struct ktermios *);
+				const struct ktermios *);
 static void cp210x_set_termios(struct tty_struct *, struct usb_serial_port *,
-							struct ktermios*);
+			       const struct ktermios *);
 static bool cp210x_tx_empty(struct usb_serial_port *port);
 static int cp210x_tiocmget(struct tty_struct *);
 static int cp210x_tiocmset(struct tty_struct *, unsigned int, unsigned int);
@@ -1039,7 +1039,8 @@ static speed_t cp210x_get_actual_rate(speed_t baud)
  * otherwise.
  */
 static void cp210x_change_speed(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
@@ -1121,7 +1122,8 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 }
 
 static void cp210x_set_flow_control(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				    struct usb_serial_port *port,
+				    const struct ktermios *old_termios)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
 	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
@@ -1231,7 +1233,8 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 }
 
 static void cp210x_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+		               struct usb_serial_port *port,
+		               const struct ktermios *old_termios)
 {
 	struct cp210x_serial_private *priv = usb_get_serial_data(port->serial);
 	u16 bits;
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 5fbcc155e8f5..1e0c028c5ec9 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -125,7 +125,8 @@ static void cypress_send(struct usb_serial_port *port);
 static unsigned int cypress_write_room(struct tty_struct *tty);
 static void cypress_earthmate_init_termios(struct tty_struct *tty);
 static void cypress_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios);
 static int  cypress_tiocmget(struct tty_struct *tty);
 static int  cypress_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
@@ -859,7 +860,8 @@ static void cypress_earthmate_init_termios(struct tty_struct *tty)
 }
 
 static void cypress_set_termios(struct tty_struct *tty,
-	struct usb_serial_port *port, struct ktermios *old_termios)
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios)
 {
 	struct cypress_private *priv = usb_get_serial_port_data(port);
 	struct device *dev = &port->dev;
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index af65eb863d70..45d688e9b93f 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -215,7 +215,8 @@ static int digi_transmit_idle(struct usb_serial_port *port,
 static void digi_rx_throttle(struct tty_struct *tty);
 static void digi_rx_unthrottle(struct tty_struct *tty);
 static void digi_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios);
+			     struct usb_serial_port *port,
+			     const struct ktermios *old_termios);
 static void digi_break_ctl(struct tty_struct *tty, int break_state);
 static int digi_tiocmget(struct tty_struct *tty);
 static int digi_tiocmset(struct tty_struct *tty, unsigned int set,
@@ -649,7 +650,8 @@ static void digi_rx_unthrottle(struct tty_struct *tty)
 
 
 static void digi_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			     struct usb_serial_port *port,
+			     const struct ktermios *old_termios)
 {
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	struct device *dev = &port->dev;
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index d9f20256a6a8..2dd58cd9f0cc 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -603,7 +603,8 @@ static int f81232_port_disable(struct usb_serial_port *port)
 }
 
 static void f81232_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			       struct usb_serial_port *port,
+			       const struct ktermios *old_termios)
 {
 	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index d789c1ec87b3..ddfcd72eb0ae 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -944,8 +944,8 @@ static int f81534_calc_num_ports(struct usb_serial *serial,
 }
 
 static void f81534_set_termios(struct tty_struct *tty,
-				struct usb_serial_port *port,
-				struct ktermios *old_termios)
+			       struct usb_serial_port *port,
+			       const struct ktermios *old_termios)
 {
 	u8 new_lcr = 0;
 	int status;
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d5a3986dfee7..3173316cb06b 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1087,7 +1087,8 @@ static void ftdi_process_read_urb(struct urb *urb);
 static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
 						void *dest, size_t size);
 static void ftdi_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+			     struct usb_serial_port *port,
+			     const struct ktermios *old_termios);
 static int  ftdi_tiocmget(struct tty_struct *tty);
 static int  ftdi_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
@@ -2638,7 +2639,8 @@ static bool ftdi_tx_empty(struct usb_serial_port *port)
  * WARNING: set_termios calls this with old_termios in kernel space
  */
 static void ftdi_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+		             struct usb_serial_port *port,
+		             const struct ktermios *old_termios)
 {
 	struct usb_device *dev = port->serial->dev;
 	struct device *ddev = &port->dev;
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index ffa622539a25..3a4c0febf335 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -281,7 +281,7 @@ static int  send_iosp_ext_cmd(struct edgeport_port *edge_port, __u8 command,
 static int  calc_baud_rate_divisor(struct device *dev, int baud_rate, int *divisor);
 static void change_port_settings(struct tty_struct *tty,
 				struct edgeport_port *edge_port,
-				struct ktermios *old_termios);
+				const struct ktermios *old_termios);
 static int  send_cmd_write_uart_register(struct edgeport_port *edge_port,
 				__u8 regNum, __u8 regValue);
 static int  write_cmd_usb(struct edgeport_port *edge_port,
@@ -1441,7 +1441,8 @@ static void edge_unthrottle(struct tty_struct *tty)
  * the termios structure
  *****************************************************************************/
 static void edge_set_termios(struct tty_struct *tty,
-	struct usb_serial_port *port, struct ktermios *old_termios)
+			     struct usb_serial_port *port,
+			     const struct ktermios *old_termios)
 {
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 
@@ -2325,7 +2326,7 @@ static int send_cmd_write_uart_register(struct edgeport_port *edge_port,
  *****************************************************************************/
 
 static void change_port_settings(struct tty_struct *tty,
-	struct edgeport_port *edge_port, struct ktermios *old_termios)
+	struct edgeport_port *edge_port, const struct ktermios *old_termios)
 {
 	struct device *dev = &edge_port->port->dev;
 	struct edgeport_serial *edge_serial =
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index feba2a8d1233..bc3c24ea42c1 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -221,7 +221,8 @@ static void stop_read(struct edgeport_port *edge_port);
 static int restart_read(struct edgeport_port *edge_port);
 
 static void edge_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios);
+			     struct usb_serial_port *port,
+			     const struct ktermios *old_termios);
 static void edge_send(struct usb_serial_port *port, struct tty_struct *tty);
 
 static int do_download_mode(struct edgeport_serial *serial,
@@ -2210,7 +2211,7 @@ static int restart_read(struct edgeport_port *edge_port)
 }
 
 static void change_port_settings(struct tty_struct *tty,
-		struct edgeport_port *edge_port, struct ktermios *old_termios)
+		struct edgeport_port *edge_port, const struct ktermios *old_termios)
 {
 	struct device *dev = &edge_port->port->dev;
 	struct ump_uart_config *config;
@@ -2351,7 +2352,8 @@ static void change_port_settings(struct tty_struct *tty,
 }
 
 static void edge_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			     struct usb_serial_port *port,
+			     const struct ktermios *old_termios)
 {
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 
diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 7b44dbea95cd..82f108134e6f 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -51,7 +51,8 @@ static unsigned int ir_write_room(struct tty_struct *tty);
 static void ir_write_bulk_callback(struct urb *urb);
 static void ir_process_read_urb(struct urb *urb);
 static void ir_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios);
+			   struct usb_serial_port *port,
+			   const struct ktermios *old_termios);
 
 /* Not that this lot means you can only have one per system */
 static u8 ir_baud;
@@ -376,7 +377,8 @@ static void ir_process_read_urb(struct urb *urb)
 }
 
 static void ir_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			   struct usb_serial_port *port,
+			   const struct ktermios *old_termios)
 {
 	struct usb_device *udev = port->serial->dev;
 	unsigned char *transfer_buffer;
diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 0be3b5e1eaf3..77cba71bcccb 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -879,7 +879,8 @@ static int iuu_uart_baud(struct usb_serial_port *port, u32 baud_base,
 }
 
 static void iuu_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			    struct usb_serial_port *port,
+			    const struct ktermios *old_termios)
 {
 	const u32 supported_mask = CMSPAR|PARENB|PARODD;
 	struct iuu_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 1cfcd805f286..2966e0c4941e 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -616,7 +616,8 @@ static void keyspan_break_ctl(struct tty_struct *tty, int break_state)
 
 
 static void keyspan_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios)
 {
 	int				baud_rate, device_port;
 	struct keyspan_port_private 	*p_priv;
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 3e7628becdcd..6fd15cd9e1eb 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -321,7 +321,8 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 }
 
 static void keyspan_pda_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				    struct usb_serial_port *port,
+				    const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	speed_t speed;
diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index edcc57bd9b5e..394b3189e003 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -56,7 +56,8 @@ static void klsi_105_port_remove(struct usb_serial_port *port);
 static int  klsi_105_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void klsi_105_close(struct usb_serial_port *port);
 static void klsi_105_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+				 struct usb_serial_port *port,
+				 const struct ktermios *old_termios);
 static int  klsi_105_tiocmget(struct tty_struct *tty);
 static void klsi_105_process_read_urb(struct urb *urb);
 static int klsi_105_prepare_write_buffer(struct usb_serial_port *port,
@@ -366,7 +367,7 @@ static void klsi_105_process_read_urb(struct urb *urb)
 
 static void klsi_105_set_termios(struct tty_struct *tty,
 				 struct usb_serial_port *port,
-				 struct ktermios *old_termios)
+				 const struct ktermios *old_termios)
 {
 	struct klsi_105_private *priv = usb_get_serial_port_data(port);
 	struct device *dev = &port->dev;
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 4ed8b8b0a361..5e775f68fcb8 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -62,7 +62,8 @@ static int  kobil_tiocmset(struct tty_struct *tty,
 static void kobil_read_int_callback(struct urb *urb);
 static void kobil_write_int_callback(struct urb *urb);
 static void kobil_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+			      struct usb_serial_port *port,
+			      const struct ktermios *old);
 static void kobil_init_termios(struct tty_struct *tty);
 
 static const struct usb_device_id id_table[] = {
@@ -474,7 +475,8 @@ static int kobil_tiocmset(struct tty_struct *tty,
 }
 
 static void kobil_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old)
+			      struct usb_serial_port *port,
+			      const struct ktermios *old)
 {
 	struct kobil_private *priv;
 	int result;
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index ecd5b921e374..d3852feb81a4 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -45,7 +45,8 @@ static void mct_u232_close(struct usb_serial_port *port);
 static void mct_u232_dtr_rts(struct usb_serial_port *port, int on);
 static void mct_u232_read_int_callback(struct urb *urb);
 static void mct_u232_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+				 struct usb_serial_port *port,
+				 const struct ktermios *old_termios);
 static void mct_u232_break_ctl(struct tty_struct *tty, int break_state);
 static int  mct_u232_tiocmget(struct tty_struct *tty);
 static int  mct_u232_tiocmset(struct tty_struct *tty,
@@ -593,7 +594,7 @@ static void mct_u232_read_int_callback(struct urb *urb)
 
 static void mct_u232_set_termios(struct tty_struct *tty,
 				 struct usb_serial_port *port,
-				 struct ktermios *old_termios)
+				 const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 23ccbba716c7..1d1f85fabc28 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1356,7 +1356,7 @@ static int send_cmd_write_baud_rate(struct moschip_port *mos7720_port,
  */
 static void change_port_settings(struct tty_struct *tty,
 				 struct moschip_port *mos7720_port,
-				 struct ktermios *old_termios)
+				 const struct ktermios *old_termios)
 {
 	struct usb_serial_port *port;
 	struct usb_serial *serial;
@@ -1494,7 +1494,8 @@ static void change_port_settings(struct tty_struct *tty,
  *	termios structure.
  */
 static void mos7720_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios)
 {
 	int status;
 	struct moschip_port *mos7720_port;
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 925067a7978d..6b12bb4648b8 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1188,7 +1188,8 @@ static int mos7840_send_cmd_write_baud_rate(struct moschip_port *mos7840_port,
  *****************************************************************************/
 
 static void mos7840_change_port_settings(struct tty_struct *tty,
-	struct moschip_port *mos7840_port, struct ktermios *old_termios)
+					 struct moschip_port *mos7840_port,
+					 const struct ktermios *old_termios)
 {
 	struct usb_serial_port *port = mos7840_port->port;
 	int baud;
@@ -1330,7 +1331,7 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 
 static void mos7840_set_termios(struct tty_struct *tty,
 				struct usb_serial_port *port,
-				struct ktermios *old_termios)
+				const struct ktermios *old_termios)
 {
 	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
 	int status;
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index eb45a9b0005c..faa0eedfe245 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -760,7 +760,7 @@ static int mxuport_tiocmget(struct tty_struct *tty)
 }
 
 static int mxuport_set_termios_flow(struct tty_struct *tty,
-				    struct ktermios *old_termios,
+				    const struct ktermios *old_termios,
 				    struct usb_serial_port *port,
 				    struct usb_serial *serial)
 {
@@ -834,7 +834,7 @@ static int mxuport_set_termios_flow(struct tty_struct *tty,
 
 static void mxuport_set_termios(struct tty_struct *tty,
 				struct usb_serial_port *port,
-				struct ktermios *old_termios)
+				const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	u8 *buf;
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index a5caedbe72e2..6365cfe5402c 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -119,7 +119,8 @@ struct oti6858_control_pkt {
 static int oti6858_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void oti6858_close(struct usb_serial_port *port);
 static void oti6858_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios);
 static void oti6858_init_termios(struct tty_struct *tty);
 static void oti6858_read_int_callback(struct urb *urb);
 static void oti6858_read_bulk_callback(struct urb *urb);
@@ -395,7 +396,8 @@ static void oti6858_init_termios(struct tty_struct *tty)
 }
 
 static void oti6858_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios)
 {
 	struct oti6858_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 40b1ab3d284d..8949c1891164 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -789,7 +789,8 @@ static bool pl2303_enable_xonxoff(struct tty_struct *tty, const struct pl2303_ty
 }
 
 static void pl2303_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			       struct usb_serial_port *port,
+			       const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 36b1e064e51f..6fca40ace83a 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -261,8 +261,8 @@ static int qt2_calc_num_ports(struct usb_serial *serial,
 }
 
 static void qt2_set_termios(struct tty_struct *tty,
-			    struct usb_serial_port *port,
-			    struct ktermios *old_termios)
+		            struct usb_serial_port *port,
+		            const struct ktermios *old_termios)
 {
 	struct usb_device *dev = port->serial->dev;
 	struct qt2_port_private *port_priv;
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 7039dc918827..09a972a838ee 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -283,7 +283,8 @@ static void spcp8x5_init_termios(struct tty_struct *tty)
 }
 
 static void spcp8x5_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				struct usb_serial_port *port,
+				const struct ktermios *old_termios)
 {
 	struct usb_serial *serial = port->serial;
 	struct spcp8x5_private *priv = usb_get_serial_port_data(port);
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 181e302136a5..1e1888b66305 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -214,8 +214,8 @@ out:	kfree(data);
 
 
 static void ssu100_set_termios(struct tty_struct *tty,
-			       struct usb_serial_port *port,
-			       struct ktermios *old_termios)
+		               struct usb_serial_port *port,
+		               const struct ktermios *old_termios)
 {
 	struct usb_device *dev = port->serial->dev;
 	struct ktermios *termios = &tty->termios;
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 18c0bd853392..b99f78224846 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -314,7 +314,8 @@ static bool ti_tx_empty(struct usb_serial_port *port);
 static void ti_throttle(struct tty_struct *tty);
 static void ti_unthrottle(struct tty_struct *tty);
 static void ti_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios);
+			   struct usb_serial_port *port,
+			   const struct ktermios *old_termios);
 static int ti_tiocmget(struct tty_struct *tty);
 static int ti_tiocmset(struct tty_struct *tty,
 		unsigned int set, unsigned int clear);
@@ -892,7 +893,8 @@ static void ti_unthrottle(struct tty_struct *tty)
 }
 
 static void ti_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			   struct usb_serial_port *port,
+			   const struct ktermios *old_termios)
 {
 	struct ti_port *tport = usb_get_serial_port_data(port);
 	struct ti_uart_config *config;
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 63d4a784ae45..c47439bd90fa 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -296,8 +296,8 @@ static speed_t upd78f0730_get_baud_rate(struct tty_struct *tty)
 }
 
 static void upd78f0730_set_termios(struct tty_struct *tty,
-				struct usb_serial_port *port,
-				struct ktermios *old_termios)
+				   struct usb_serial_port *port,
+				   const struct ktermios *old_termios)
 {
 	struct device *dev = &port->dev;
 	struct upd78f0730_line_control request;
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 332fb92ae575..7f82d40753ee 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -82,7 +82,8 @@ static void whiteheat_close(struct usb_serial_port *port);
 static void whiteheat_get_serial(struct tty_struct *tty,
 			struct serial_struct *ss);
 static void whiteheat_set_termios(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+				  struct usb_serial_port *port,
+				  const struct ktermios *old_termios);
 static int  whiteheat_tiocmget(struct tty_struct *tty);
 static int  whiteheat_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
@@ -442,7 +443,8 @@ static void whiteheat_get_serial(struct tty_struct *tty, struct serial_struct *s
 
 
 static void whiteheat_set_termios(struct tty_struct *tty,
-	struct usb_serial_port *port, struct ktermios *old_termios)
+				  struct usb_serial_port *port,
+				  const struct ktermios *old_termios)
 {
 	firm_setup_port(tty);
 }
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 6853cd56d8dc..f3811e060a44 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -104,7 +104,8 @@ static int xr21v141x_uart_enable(struct usb_serial_port *port);
 static int xr21v141x_uart_disable(struct usb_serial_port *port);
 static int xr21v141x_fifo_reset(struct usb_serial_port *port);
 static void xr21v141x_set_line_settings(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios);
+					struct usb_serial_port *port,
+					const struct ktermios *old_termios);
 
 struct xr_type {
 	int reg_width;
@@ -133,8 +134,8 @@ struct xr_type {
 	int (*disable)(struct usb_serial_port *port);
 	int (*fifo_reset)(struct usb_serial_port *port);
 	void (*set_line_settings)(struct tty_struct *tty,
-			struct usb_serial_port *port,
-			struct ktermios *old_termios);
+				  struct usb_serial_port *port,
+				  const struct ktermios *old_termios);
 };
 
 enum xr_type_id {
@@ -622,8 +623,8 @@ static int xr21v141x_set_baudrate(struct tty_struct *tty, struct usb_serial_port
 }
 
 static void xr_set_flow_mode(struct tty_struct *tty,
-			     struct usb_serial_port *port,
-			     struct ktermios *old_termios)
+		             struct usb_serial_port *port,
+		             const struct ktermios *old_termios)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
@@ -674,7 +675,8 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 }
 
 static void xr21v141x_set_line_settings(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				        struct usb_serial_port *port,
+				        const struct ktermios *old_termios)
 {
 	struct ktermios *termios = &tty->termios;
 	u8 bits = 0;
@@ -732,7 +734,8 @@ static void xr21v141x_set_line_settings(struct tty_struct *tty,
 }
 
 static void xr_cdc_set_line_coding(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+				   struct usb_serial_port *port,
+				   const struct ktermios *old_termios)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 	struct usb_host_interface *alt = port->serial->interface->cur_altsetting;
@@ -809,7 +812,8 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
 }
 
 static void xr_set_termios(struct tty_struct *tty,
-		struct usb_serial_port *port, struct ktermios *old_termios)
+			   struct usb_serial_port *port,
+			   const struct ktermios *old_termios)
 {
 	struct xr_data *data = usb_get_serial_port_data(port);
 
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 8ea319f89e1f..f7bfedb740f5 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -276,8 +276,8 @@ struct usb_serial_driver {
 		      unsigned int cmd, unsigned long arg);
 	void (*get_serial)(struct tty_struct *tty, struct serial_struct *ss);
 	int  (*set_serial)(struct tty_struct *tty, struct serial_struct *ss);
-	void (*set_termios)(struct tty_struct *tty,
-			struct usb_serial_port *port, struct ktermios *old);
+	void (*set_termios)(struct tty_struct *tty, struct usb_serial_port *port,
+			    const struct ktermios *old);
 	void (*break_ctl)(struct tty_struct *tty, int break_state);
 	unsigned int (*chars_in_buffer)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, long timeout);
-- 
2.30.2

