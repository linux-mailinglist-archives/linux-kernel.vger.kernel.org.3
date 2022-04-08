Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3407C4F9457
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiDHLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiDHLm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:42:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A1818B316;
        Fri,  8 Apr 2022 04:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649418016; x=1680954016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZCuKyZTqRMzUYDPueGM7wv5KMg5AhIqt2rJ7f2R14s=;
  b=Au5WAtoJmu6Q2Mayn4hN5FMoC5OfEXVccP38hsH6qjvf8nLdOLwBix3b
   XMWUtI13Eazn4QIQwFUm90RikQgkGZWDb5JMfjLM7BHX+m18HEzkLGdv5
   kqEyrG4chP+9hKCgxjSInZsVCGwa1awbNDX24s/V51PjBRSGKzz4Ezmak
   yhFxxhneQzW9LP/3MVf74nUIBUPpd5j7p2nLyhneFE38p0VQ2CK9xdcem
   yGFxjNRNV2BdpELeYoMpw9NsQr+mA71SX/XG4EEPG2BsPMRHnOxAscHvk
   sOhD6ZGcF8mgK2x/9ddKCOJg+9bvfuyfmhrGN46TqocYAx6gCaYCZ25GB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261749134"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261749134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:40:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="571462670"
Received: from aecajiao-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 04:40:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/3] tty: Add lookahead param to receive_buf
Date:   Fri,  8 Apr 2022 14:39:53 +0300
Message-Id: <20220408113954.9749-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
References: <20220408113954.9749-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After lookahead for XON/XOFF characters is added by the next
patch, the receive side needs to ensure the flow-control
actions are not retaken later on when those same characters
get read by TTY.

Thus, pass lookahead count to receive_buf and skip
flow-control character actions if already taken for the
character in question. Lookahead count will become live after
the next patch.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/accessibility/speakup/spk_ttyio.c |  2 +-
 drivers/bluetooth/hci_ldisc.c             |  2 +-
 drivers/char/pcmcia/synclink_cs.c         |  2 +-
 drivers/input/serio/serport.c             |  4 +-
 drivers/isdn/capi/capi.c                  |  2 +-
 drivers/misc/ti-st/st_core.c              |  2 +-
 drivers/net/caif/caif_serial.c            |  4 +-
 drivers/net/can/slcan.c                   |  2 +-
 drivers/net/hamradio/6pack.c              |  4 +-
 drivers/net/hamradio/mkiss.c              |  2 +-
 drivers/net/mctp/mctp-serial.c            |  2 +-
 drivers/net/ppp/ppp_async.c               |  2 +-
 drivers/net/ppp/ppp_synctty.c             |  2 +-
 drivers/net/slip/slip.c                   |  2 +-
 drivers/tty/n_gsm.c                       |  2 +-
 drivers/tty/n_hdlc.c                      |  2 +-
 drivers/tty/n_null.c                      |  2 +-
 drivers/tty/n_tty.c                       | 51 +++++++++++++----------
 drivers/tty/serdev/serdev-ttyport.c       |  3 +-
 drivers/tty/synclink_gt.c                 |  2 +-
 drivers/tty/tty_buffer.c                  |  8 ++--
 drivers/tty/tty_io.c                      |  2 +-
 drivers/tty/tty_port.c                    |  5 ++-
 drivers/tty/vt/selection.c                |  2 +-
 include/linux/tty_flip.h                  |  2 +-
 include/linux/tty_ldisc.h                 | 20 +++++----
 include/linux/tty_port.h                  |  3 +-
 net/nfc/nci/uart.c                        |  2 +-
 sound/soc/codecs/cx20442.c                |  2 +-
 sound/soc/ti/ams-delta.c                  |  2 +-
 30 files changed, 81 insertions(+), 63 deletions(-)

diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
index 08cf8a17754b..b33536eea1d3 100644
--- a/drivers/accessibility/speakup/spk_ttyio.c
+++ b/drivers/accessibility/speakup/spk_ttyio.c
@@ -73,7 +73,7 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
 
 static int spk_ttyio_receive_buf2(struct tty_struct *tty,
 				  const unsigned char *cp,
-				  const char *fp, int count)
+				  const char *fp, int count, unsigned int lookahead_count)
 {
 	struct spk_ldisc_data *ldisc_data = tty->disc_data;
 	struct spk_synth *synth = ldisc_data->synth;
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index f537673ede17..08c329a4cdcc 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -596,7 +596,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
  * Return Value:    None
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 const char *flags, int count)
+				 const char *flags, int count, unsigned int lookahead_count)
 {
 	struct hci_uart *hu = tty->disc_data;
 
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba55a8b5..de9c151cfb12 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -501,7 +501,7 @@ static void ldisc_receive_buf(struct tty_struct *tty,
 	ld = tty_ldisc_ref(tty);
 	if (ld) {
 		if (ld->ops->receive_buf)
-			ld->ops->receive_buf(tty, data, flags, count);
+			ld->ops->receive_buf(tty, data, flags, count, 0);
 		tty_ldisc_deref(ld);
 	}
 }
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 669a728095b8..f0f19b5a2059 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -114,8 +114,8 @@ static void serport_ldisc_close(struct tty_struct *tty)
  * 'interrupt' routine.
  */
 
-static void serport_ldisc_receive(struct tty_struct *tty,
-		const unsigned char *cp, const char *fp, int count)
+static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *cp,
+				  const char *fp, int count, unsigned int lookahead_count)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
 	unsigned long flags;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index 0f00be62438d..beb4c78a7219 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -454,7 +454,7 @@ static int handle_recv_skb(struct capiminor *mp, struct sk_buff *skb)
 		skb_pull(skb, CAPIMSG_LEN(skb->data));
 		pr_debug("capi: DATA_B3_RESP %u len=%d => ldisc\n",
 			 datahandle, skb->len);
-		ld->ops->receive_buf(tty, skb->data, NULL, skb->len);
+		ld->ops->receive_buf(tty, skb->data, NULL, skb->len, 0);
 	} else {
 		printk(KERN_ERR "capi: send DATA_B3_RESP failed=%x\n",
 		       errcode);
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 7f6976a9f508..b2c96d72c0e3 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -797,7 +797,7 @@ static void st_tty_close(struct tty_struct *tty)
 }
 
 static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
-			   const char *tty_flags, int count)
+			   const char *tty_flags, int count, unsigned int lookahead_count)
 {
 #ifdef VERBOSE
 	print_hex_dump(KERN_DEBUG, ">in>", DUMP_PREFIX_NONE,
diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index 688075859ae4..cc97c436ec88 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -159,7 +159,7 @@ static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
 #endif
 
 static void ldisc_receive(struct tty_struct *tty, const u8 *data,
-			const char *flags, int count)
+			  const char *flags, int count, unsigned int lookahead_count)
 {
 	struct sk_buff *skb = NULL;
 	struct ser_device *ser;
@@ -237,7 +237,7 @@ static int handle_tx(struct ser_device *ser)
 			update_tty_status(ser);
 		} else {
 			tty_wr = len;
-			ldisc_receive(tty, skb->data, NULL, len);
+			ldisc_receive(tty, skb->data, NULL, len, 0);
 		}
 		ser->dev->stats.tx_packets++;
 		ser->dev->stats.tx_bytes += tty_wr;
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index ec294d0c5722..5e03e14c2d99 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -471,7 +471,7 @@ static void slc_setup(struct net_device *dev)
 
 static void slcan_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, const char *fp,
-			      int count)
+			      int count, unsigned int lookahead_count)
 {
 	struct slcan *sl = (struct slcan *) tty->disc_data;
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 45c3c4a1101b..6ba4b05dff78 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -426,8 +426,8 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
  * a block of 6pack data has been received, which can now be decapsulated
  * and sent on to some IP layer for further processing.
  */
-static void sixpack_receive_buf(struct tty_struct *tty,
-	const unsigned char *cp, const char *fp, int count)
+static void sixpack_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+				const char *fp, int count, unsigned int lookahead_count)
 {
 	struct sixpack *sp;
 	int count1;
diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
index c251e04ae047..498997ef429a 100644
--- a/drivers/net/hamradio/mkiss.c
+++ b/drivers/net/hamradio/mkiss.c
@@ -875,7 +875,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
  * and sent on to the AX.25 layer for further processing.
  */
 static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-	const char *fp, int count)
+			      const char *fp, int count, unsigned int lookahead_count)
 {
 	struct mkiss *ax = mkiss_get(tty);
 
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 7cd103fd34ef..f1dfab4c54cb 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -390,7 +390,7 @@ static void mctp_serial_push(struct mctp_serial *dev, unsigned char c)
 
 static void mctp_serial_tty_receive_buf(struct tty_struct *tty,
 					const unsigned char *c,
-					const char *f, int len)
+					const char *f, int len, unsigned int lookahead_count)
 {
 	struct mctp_serial *dev = tty->disc_data;
 	int i;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 15a179631903..87c205a02984 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -338,7 +338,7 @@ ppp_asynctty_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
-		  const char *cflags, int count)
+		     const char *cflags, int count, unsigned int lookahead_count)
 {
 	struct asyncppp *ap = ap_get(tty);
 	unsigned long flags;
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 18283b7b94bc..b82f4bd82b21 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -331,7 +331,7 @@ ppp_sync_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 /* May sleep, don't call from interrupt level or with interrupts disabled */
 static void
 ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
-		  const char *cflags, int count)
+		 const char *cflags, int count, unsigned int lookahead_count)
 {
 	struct syncppp *ap = sp_get(tty);
 	unsigned long flags;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 88396ff99f03..7fccf28256a8 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -686,7 +686,7 @@ static void sl_setup(struct net_device *dev)
  */
 
 static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-		const char *fp, int count)
+			     const char *fp, int count, unsigned int lookahead_count)
 {
 	struct slip *sl = tty->disc_data;
 
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index fa92f727fdf8..45f022892b28 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2500,7 +2500,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
 }
 
 static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      const char *fp, int count)
+			      const char *fp, int count, unsigned int lookahead_count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	char flags = TTY_NORMAL;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 94c1ec2dd754..2d7c94a38a92 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -379,7 +379,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
  * interpreted as one HDLC frame.
  */
 static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
-			       const char *flags, int count)
+			       const char *flags, int count, unsigned int lookahead_count)
 {
 	register struct n_hdlc *n_hdlc = tty->disc_data;
 	register struct n_hdlc_buf *buf;
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index f913b665af72..6bce76b5bb1c 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -34,7 +34,7 @@ static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
 
 static void n_null_receivebuf(struct tty_struct *tty,
 				 const unsigned char *cp, const char *fp,
-				 int cnt)
+				 int cnt, unsigned int lookahead_count)
 {
 }
 
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 90b3e06cbeb1..cbea02c662d1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1226,11 +1226,15 @@ static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
 }
 
 /* Returns true if c is consumed as flow-control character */
-static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c,
+					 bool lookahead_done)
 {
 	if (!n_tty_is_char_flow_ctrl(tty, c))
 		return false;
 
+	if (lookahead_done)
+		return true;
+
 	if (c == START_CHAR(tty)) {
 		start_tty(tty);
 		process_echoes(tty);
@@ -1241,11 +1245,12 @@ static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c
 	return true;
 }
 
-static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
+				       bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
+	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c, lookahead_done))
 		return;
 
 	if (L_ISIG(tty)) {
@@ -1400,7 +1405,8 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
+				       bool lookahead_done)
 {
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
@@ -1408,9 +1414,10 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 		c = tolower(c);
 
 	if (I_IXON(tty)) {
-		if (c == STOP_CHAR(tty))
-			stop_tty(tty);
-		else if (c == START_CHAR(tty) ||
+		if (c == STOP_CHAR(tty)) {
+			if (!lookahead_done)
+				stop_tty(tty);
+		} else if ((c == START_CHAR(tty) && !lookahead_done) ||
 			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
 			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
 			  c != SUSP_CHAR(tty))) {
@@ -1495,22 +1502,24 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
 
 static void
 n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
-			  const char *fp, int count)
+			  const char *fp, int count, unsigned int lookahead_count)
 {
+	int lookahead_thres = count - lookahead_count;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
 		if (fp)
 			flag = *fp++;
 		if (likely(flag == TTY_NORMAL))
-			n_tty_receive_char_closing(tty, *cp++);
+			n_tty_receive_char_closing(tty, *cp++, count >= lookahead_thres);
 	}
 }
 
-static void n_tty_receive_buf_standard(struct tty_struct *tty,
-		const unsigned char *cp, const char *fp, int count)
+static void n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
+				       const char *fp, int count, unsigned int lookahead_count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
+	int lookahead_thres = count - lookahead_count;
 	char flag = TTY_NORMAL;
 
 	while (count--) {
@@ -1539,14 +1548,14 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 		}
 
 		if (test_bit(c, ldata->char_map))
-			n_tty_receive_char_special(tty, c);
+			n_tty_receive_char_special(tty, c, count >= lookahead_thres);
 		else
 			n_tty_receive_char(tty, c);
 	}
 }
 
 static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			  const char *fp, int count)
+			  const char *fp, int count, unsigned int lookahead_count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
@@ -1556,9 +1565,9 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
 		n_tty_receive_buf_raw(tty, cp, fp, count);
 	else if (tty->closing && !L_EXTPROC(tty))
-		n_tty_receive_buf_closing(tty, cp, fp, count);
+		n_tty_receive_buf_closing(tty, cp, fp, count, lookahead_count);
 	else {
-		n_tty_receive_buf_standard(tty, cp, fp, count);
+		n_tty_receive_buf_standard(tty, cp, fp, count, lookahead_count);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
@@ -1612,7 +1621,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
  */
 static int
 n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
-			 const char *fp, int count, int flow)
+			 const char *fp, int count, unsigned int lookahead_count, int flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int room, n, rcvd = 0, overflow;
@@ -1654,7 +1663,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 
 		/* ignore parity errors if handling overflow */
 		if (!overflow || !fp || *fp != TTY_PARITY)
-			__receive_buf(tty, cp, fp, n);
+			__receive_buf(tty, cp, fp, n, lookahead_count);
 
 		cp += n;
 		if (fp)
@@ -1681,15 +1690,15 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 }
 
 static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
-			      const char *fp, int count)
+			      const char *fp, int count, unsigned int lookahead_count)
 {
-	n_tty_receive_buf_common(tty, cp, fp, count, 0);
+	n_tty_receive_buf_common(tty, cp, fp, count, lookahead_count, 0);
 }
 
 static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
-			      const char *fp, int count)
+			      const char *fp, int count, unsigned int lookahead_count)
 {
-	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
+	return n_tty_receive_buf_common(tty, cp, fp, count, lookahead_count, 1);
 }
 
 /**
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index d367803e2044..087e081e8e59 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -23,7 +23,8 @@ struct serport {
  */
 
 static int ttyport_receive_buf(struct tty_port *port, const unsigned char *cp,
-				const unsigned char *fp, size_t count)
+			       const unsigned char *fp, size_t count,
+			       unsigned int lookahead_count)
 {
 	struct serdev_controller *ctrl = port->client_data;
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 25c558e65ece..a669e6e13f90 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -582,7 +582,7 @@ static void ldisc_receive_buf(struct tty_struct *tty,
 	ld = tty_ldisc_ref(tty);
 	if (ld) {
 		if (ld->ops->receive_buf)
-			ld->ops->receive_buf(tty, data, flags, count);
+			ld->ops->receive_buf(tty, data, flags, count, 0);
 		tty_ldisc_deref(ld);
 	}
 }
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 646510476c30..c561110c7d4d 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -445,14 +445,14 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  * Returns: the number of bytes processed.
  */
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-			  const char *f, int count)
+			  const char *f, int count, unsigned int lookahead_count)
 {
 	if (ld->ops->receive_buf2)
-		count = ld->ops->receive_buf2(ld->tty, p, f, count);
+		count = ld->ops->receive_buf2(ld->tty, p, f, count, lookahead_count);
 	else {
 		count = min_t(int, count, ld->tty->receive_room);
 		if (count && ld->ops->receive_buf)
-			ld->ops->receive_buf(ld->tty, p, f, count);
+			ld->ops->receive_buf(ld->tty, p, f, count, lookahead_count);
 	}
 	return count;
 }
@@ -468,7 +468,7 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	n = port->client_ops->receive_buf(port, p, f, count);
+	n = port->client_ops->receive_buf(port, p, f, count, 0);
 	if (n > 0)
 		memset(p, 0, n);
 	return n;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8fec1d8648f5..cd0b74a5ceb2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2290,7 +2290,7 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 		return -EIO;
 	tty_buffer_lock_exclusive(tty->port);
 	if (ld->ops->receive_buf)
-		ld->ops->receive_buf(tty, &ch, &mbz, 1);
+		ld->ops->receive_buf(tty, &ch, &mbz, 1, 0);
 	tty_buffer_unlock_exclusive(tty->port);
 	tty_ldisc_deref(ld);
 	return 0;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 880608a65773..45cbbf338f24 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -22,7 +22,8 @@
 
 static int tty_port_default_receive_buf(struct tty_port *port,
 					const unsigned char *p,
-					const unsigned char *f, size_t count)
+					const unsigned char *f, size_t count,
+					unsigned int lookahead_count)
 {
 	int ret;
 	struct tty_struct *tty;
@@ -36,7 +37,7 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 	if (!disc)
 		return 0;
 
-	ret = tty_ldisc_receive_buf(disc, p, (char *)f, count);
+	ret = tty_ldisc_receive_buf(disc, p, (char *)f, count, lookahead_count);
 
 	tty_ldisc_deref(disc);
 
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index f7755e73696e..abc3890ecc18 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -406,7 +406,7 @@ int paste_selection(struct tty_struct *tty)
 		__set_current_state(TASK_RUNNING);
 		count = vc_sel.buf_len - pasted;
 		count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL,
-					      count);
+					      count, 0);
 		pasted += count;
 	}
 	mutex_unlock(&vc_sel.lock);
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 483d41cbcbb7..53725f6312c0 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -42,7 +42,7 @@ static inline int tty_insert_flip_string(struct tty_port *port,
 }
 
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
-		const char *f, int count);
+		const char *f, int count, unsigned int lookahead_count);
 
 void tty_buffer_lock_exclusive(struct tty_port *port);
 void tty_buffer_unlock_exclusive(struct tty_port *port);
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index e85002b56752..d81a39cff9e2 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -152,14 +152,17 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Can sleep.
  *
  * @receive_buf: [DRV] ``void ()(struct tty_struct *tty,
- *		       const unsigned char *cp, const char *fp, int count)``
+ *		       const unsigned char *cp, const char *fp, int count,
+ *		       unsigned int lookahead_count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is
  *	a pointer to the buffer of input character received by the device. @fp
  *	is a pointer to an array of flag bytes which indicate whether a
  *	character was received with a parity error, etc. @fp may be %NULL to
- *	indicate all data received is %TTY_NORMAL.
+ *	indicate all data received is %TTY_NORMAL. The number of characters is
+ *	indicated with @count and characters for which lookahead was already
+ *	performed with @lookahead_count.
  *
  * @write_wakeup: [DRV] ``void ()(struct tty_struct *tty)``
  *
@@ -176,15 +179,18 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
  *
  * @receive_buf2: [DRV] ``int ()(struct tty_struct *tty,
- *			const unsigned char *cp, const char *fp, int count)``
+ *			const unsigned char *cp, const char *fp, int count,
+ *			unsigned int lookahead_count)``
  *
  *	This function is called by the low-level tty driver to send characters
  *	received by the hardware to the line discpline for processing. @cp is a
  *	pointer to the buffer of input character received by the device.  @fp
  *	is a pointer to an array of flag bytes which indicate whether a
  *	character was received with a parity error, etc. @fp may be %NULL to
- *	indicate all data received is %TTY_NORMAL. If assigned, prefer this
- *	function for automatic flow control.
+ *	indicate all data received is %TTY_NORMAL. The number of characters is
+ *	indicated with @count and characters for which lookahead was already
+ *	performed with @lookahead_count. If assigned, prefer this function for
+ *	automatic flow control.
  *
  * @owner: module containting this ldisc (for reference counting)
  *
@@ -224,11 +230,11 @@ struct tty_ldisc_ops {
 	 * The following routines are called from below.
 	 */
 	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
-			       const char *fp, int count);
+			       const char *fp, int count, unsigned int lookahead_count);
 	void	(*write_wakeup)(struct tty_struct *tty);
 	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
-				const char *fp, int count);
+				const char *fp, int count, unsigned int lookahead_count);
 
 	struct  module *owner;
 };
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 58e9619116b7..402470962d23 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -39,7 +39,8 @@ struct tty_port_operations {
 };
 
 struct tty_port_client_operations {
-	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
+	int (*receive_buf)(struct tty_port *port, const unsigned char *,
+			   const unsigned char *, size_t, unsigned int lookahead_count);
 	void (*write_wakeup)(struct tty_port *port);
 };
 
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index cc8fa9e36159..1daa9cf7eec8 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -296,7 +296,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
  * Return Value:    None
  */
 static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
-				 const char *flags, int count)
+				 const char *flags, int count, unsigned int lookahead_count)
 {
 	struct nci_uart *nu = (void *)tty->disc_data;
 
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 1af0bf5f1e2f..ad86970ad369 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -259,7 +259,7 @@ static void v253_hangup(struct tty_struct *tty)
 
 /* Line discipline .receive_buf() */
 static void v253_receive(struct tty_struct *tty, const unsigned char *cp,
-		const char *fp, int count)
+			 const char *fp, int count, unsigned int lookahead_count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	struct cx20442_priv *cx20442;
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index b1a32545babd..fd9694377e3b 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -337,7 +337,7 @@ static void cx81801_hangup(struct tty_struct *tty)
 
 /* Line discipline .receive_buf() */
 static void cx81801_receive(struct tty_struct *tty, const unsigned char *cp,
-		const char *fp, int count)
+			    const char *fp, int count, unsigned int lookahead_count)
 {
 	struct snd_soc_component *component = tty->disc_data;
 	const unsigned char *c;
-- 
2.30.2

