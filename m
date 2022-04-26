Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42A75100EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351733AbiDZOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351715AbiDZOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:53:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC540E41;
        Tue, 26 Apr 2022 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650984593; x=1682520593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zQ2ULawNW1Pz8OmvaxG7+96rSNZ30t1pZ+yOPcDwHkE=;
  b=dsSlsU/DcpXXVnWIog1CqcPCSIZGn/KjGxP0vNoy/BlaXmZ45jkHp4j1
   JbI28+oEB76nrMHcpb1RlV7e7Atd0b9HqKFotvd+Z61gBGc44cfdHdUaa
   7zhQFGdcEpGtuspedFzsmBWlfVP3jf2wmNw+8zjeWORXeEW4OAG+7MXkY
   H7OejTeLoLb2NTRvr8UK1OFQY1PDnfj2yVFzSH3OVMR+Uu3H7PkammrNn
   FdV9Enz2WDZGlCHjrrUGTYezyrbt48Zym5ERpcvO7sd2zbxqw0kFYlLOF
   bdYwdc8dJYarij7qA02KgDspBJ/VIR9V/MyhMB37Zip92Uv2f+eYFeWOJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="352040426"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="352040426"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="579932990"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:50 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 2/3] tty: Implement lookahead to process XON/XOFF timely
Date:   Tue, 26 Apr 2022 17:49:34 +0300
Message-Id: <20220426144935.54893-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
References: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tty is not read from, XON/XOFF may get stuck into an
intermediate buffer. As those characters are there to do software
flow-control, it is not very useful. In the case where neither end
reads from ttys, the receiving ends might not be able receive the
XOFF characters and just keep sending more data to the opposite
direction. This problem is almost guaranteed to occur with DMA
which sends data in large chunks.

If TTY is slow to process characters, that is, eats less than given
amount in receive_buf, invoke lookahead for the rest of the chars
to process potential XON/XOFF characters.

We need to keep track of how many characters have been processed by the
lookahead to avoid processing the flow control char again on the normal
path. Bookkeeping occurs parallel on two layers (tty_buffer and n_tty)
to avoid passing the lookahead_count through the whole callchain.

When a flow-control char is processed, two things must occur:
  a) it must not be treated as normal char
  b) if not yet processed, flow-control actions need to be taken
The return value of n_tty_receive_char_flow_ctrl() tells caller a), and
b) is kept internal to n_tty_receive_char_flow_ctrl().

Reported-by: Gilles Buloz <gilles.buloz@kontron.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c        | 90 +++++++++++++++++++++++++++++++-------
 drivers/tty/tty_buffer.c   | 59 +++++++++++++++++++++----
 drivers/tty/tty_port.c     | 21 +++++++++
 include/linux/tty_buffer.h |  1 +
 include/linux/tty_ldisc.h  | 13 ++++++
 include/linux/tty_port.h   |  2 +
 6 files changed, 161 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 640c9e871044..917b5970b2e0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -118,6 +118,9 @@ struct n_tty_data {
 	size_t read_tail;
 	size_t line_start;
 
+	/* # of chars looked ahead (to find software flow control chars) */
+	size_t lookahead_count;
+
 	/* protected by output lock */
 	unsigned int column;
 	unsigned int canon_column;
@@ -333,6 +336,8 @@ static void reset_buffer_flags(struct n_tty_data *ldata)
 	ldata->erasing = 0;
 	bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 	ldata->push = 0;
+
+	ldata->lookahead_count = 0;
 }
 
 static void n_tty_packet_mode_flush(struct tty_struct *tty)
@@ -1225,12 +1230,30 @@ static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
 	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
 }
 
-/* Returns true if c is consumed as flow-control character */
-static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+/**
+ * n_tty_receive_char_flow_ctrl - receive flow control chars
+ * @tty: terminal device
+ * @c: character
+ * @lookahead_done: lookahead has processed this character already
+ *
+ * Receive and process flow control character actions.
+ *
+ * In case lookahead for flow control chars already handled the character in
+ * advance to the normal receive, the actions are skipped during normal
+ * receive.
+ *
+ * Returns true if c is consumed as flow-control character, the character
+ * must not be treated as normal character.
+ */
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
@@ -1242,11 +1265,12 @@ static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c
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
@@ -1401,7 +1425,8 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
+				       bool lookahead_done)
 {
 	if (I_ISTRIP(tty))
 		c &= 0x7f;
@@ -1409,9 +1434,12 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 		c = tolower(c);
 
 	if (I_IXON(tty)) {
-		if (c == STOP_CHAR(tty))
-			stop_tty(tty);
-		else if (c == START_CHAR(tty) ||
+		if (c == STOP_CHAR(tty)) {
+			if (!lookahead_done)
+				stop_tty(tty);
+		} else if (c == START_CHAR(tty) && lookahead_done) {
+			return;
+		} else if (c == START_CHAR(tty) ||
 			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
 			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
 			  c != SUSP_CHAR(tty))) {
@@ -1457,6 +1485,26 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 		n_tty_receive_char_flagged(tty, c, flag);
 }
 
+static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned char *cp,
+				      const unsigned char *fp, unsigned int count)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	unsigned char flag = TTY_NORMAL;
+
+	ldata->lookahead_count += count;
+
+	if (!I_IXON(tty))
+		return;
+
+	while (count--) {
+		if (fp)
+			flag = *fp++;
+		if (likely(flag == TTY_NORMAL))
+			n_tty_receive_char_flow_ctrl(tty, *cp, false);
+		cp++;
+	}
+}
+
 static void
 n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
 			   const char *fp, int count)
@@ -1496,7 +1544,7 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const unsigned char *cp,
 
 static void
 n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
-			  const char *fp, int count)
+			  const char *fp, int count, bool lookahead_done)
 {
 	char flag = TTY_NORMAL;
 
@@ -1504,12 +1552,12 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 		if (fp)
 			flag = *fp++;
 		if (likely(flag == TTY_NORMAL))
-			n_tty_receive_char_closing(tty, *cp++);
+			n_tty_receive_char_closing(tty, *cp++, lookahead_done);
 	}
 }
 
 static void n_tty_receive_buf_standard(struct tty_struct *tty,
-		const unsigned char *cp, const char *fp, int count)
+		const unsigned char *cp, const char *fp, int count, bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
@@ -1540,7 +1588,7 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 		}
 
 		if (test_bit(c, ldata->char_map))
-			n_tty_receive_char_special(tty, c);
+			n_tty_receive_char_special(tty, c, lookahead_done);
 		else
 			n_tty_receive_char(tty, c);
 	}
@@ -1551,21 +1599,30 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
+	size_t la_count = min_t(size_t, ldata->lookahead_count, count);
 
 	if (ldata->real_raw)
 		n_tty_receive_buf_real_raw(tty, cp, fp, count);
 	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
 		n_tty_receive_buf_raw(tty, cp, fp, count);
-	else if (tty->closing && !L_EXTPROC(tty))
-		n_tty_receive_buf_closing(tty, cp, fp, count);
-	else {
-		n_tty_receive_buf_standard(tty, cp, fp, count);
+	else if (tty->closing && !L_EXTPROC(tty)) {
+		if (la_count > 0)
+			n_tty_receive_buf_closing(tty, cp, fp, la_count, true);
+		if (count > la_count)
+			n_tty_receive_buf_closing(tty, cp, fp, count - la_count, false);
+	} else {
+		if (la_count > 0)
+			n_tty_receive_buf_standard(tty, cp, fp, la_count, true);
+		if (count > la_count)
+			n_tty_receive_buf_standard(tty, cp, fp, count - la_count, false);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
 			tty->ops->flush_chars(tty);
 	}
 
+	ldata->lookahead_count -= la_count;
+
 	if (ldata->icanon && !L_EXTPROC(tty))
 		return;
 
@@ -2446,6 +2503,7 @@ static struct tty_ldisc_ops n_tty_ops = {
 	.receive_buf     = n_tty_receive_buf,
 	.write_wakeup    = n_tty_write_wakeup,
 	.receive_buf2	 = n_tty_receive_buf2,
+	.lookahead_buf	 = n_tty_lookahead_flow_ctrl,
 };
 
 /**
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 646510476c30..e237f2a022dc 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -5,6 +5,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/minmax.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
@@ -104,6 +105,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 	p->size = size;
 	p->next = NULL;
 	p->commit = 0;
+	p->lookahead = 0;
 	p->read = 0;
 	p->flags = 0;
 }
@@ -233,6 +235,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 		buf->head = next;
 	}
 	buf->head->read = buf->head->commit;
+	buf->head->lookahead = buf->head->read;
 
 	if (ld && ld->ops->flush_buffer)
 		ld->ops->flush_buffer(tty);
@@ -275,13 +278,15 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 		if (n != NULL) {
 			n->flags = flags;
 			buf->tail = n;
-			/* paired w/ acquire in flush_to_ldisc(); ensures
-			 * flush_to_ldisc() sees buffer data.
+			/*
+			 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
+			 * ensures they see all buffer data.
 			 */
 			smp_store_release(&b->commit, b->used);
-			/* paired w/ acquire in flush_to_ldisc(); ensures the
-			 * latest commit value can be read before the head is
-			 * advanced to the next buffer
+			/*
+			 * Paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
+			 * ensures the latest commit value can be read before the head
+			 * is advanced to the next buffer.
 			 */
 			smp_store_release(&b->next, n);
 		} else if (change)
@@ -458,6 +463,40 @@ int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 }
 EXPORT_SYMBOL_GPL(tty_ldisc_receive_buf);
 
+static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
+{
+	head->lookahead = max(head->lookahead, head->read);
+
+	while (head) {
+		struct tty_buffer *next;
+		unsigned char *p, *f = NULL;
+		unsigned int count;
+
+		/*
+		 * Paired w/ release in __tty_buffer_request_room();
+		 * ensures commit value read is not stale if the head
+		 * is advancing to the next buffer.
+		 */
+		next = smp_load_acquire(&head->next);
+		/*
+		 * Paired w/ release in __tty_buffer_request_room() or in
+		 * tty_buffer_flush(); ensures we see the committed buffer data.
+		 */
+		count = smp_load_acquire(&head->commit) - head->lookahead;
+		if (!count) {
+			head = next;
+			continue;
+		}
+
+		p = char_buf_ptr(head, head->lookahead);
+		if (~head->flags & TTYB_NORMAL)
+			f = flag_buf_ptr(head, head->lookahead);
+
+		port->client_ops->lookahead_buf(port, p, f, count);
+		head->lookahead += count;
+	}
+}
+
 static int
 receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 {
@@ -495,7 +534,7 @@ static void flush_to_ldisc(struct work_struct *work)
 	while (1) {
 		struct tty_buffer *head = buf->head;
 		struct tty_buffer *next;
-		int count;
+		int count, rcvd;
 
 		/* Ldisc or user is trying to gain exclusive access */
 		if (atomic_read(&buf->priority))
@@ -518,10 +557,12 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}
 
-		count = receive_buf(port, head, count);
-		if (!count)
+		rcvd = receive_buf(port, head, count);
+		head->read += rcvd;
+		if (rcvd < count)
+			lookahead_bufs(port, head);
+		if (!rcvd)
 			break;
-		head->read += count;
 
 		if (need_resched())
 			cond_resched();
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 880608a65773..dce08a6d7b5e 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -43,6 +43,26 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 	return ret;
 }
 
+static void tty_port_default_lookahead_buf(struct tty_port *port, const unsigned char *p,
+					   const unsigned char *f, unsigned int count)
+{
+	struct tty_struct *tty;
+	struct tty_ldisc *disc;
+
+	tty = READ_ONCE(port->itty);
+	if (!tty)
+		return;
+
+	disc = tty_ldisc_ref(tty);
+	if (!disc)
+		return;
+
+	if (disc->ops->lookahead_buf)
+		disc->ops->lookahead_buf(disc->tty, p, f, count);
+
+	tty_ldisc_deref(disc);
+}
+
 static void tty_port_default_wakeup(struct tty_port *port)
 {
 	struct tty_struct *tty = tty_port_tty_get(port);
@@ -55,6 +75,7 @@ static void tty_port_default_wakeup(struct tty_port *port)
 
 const struct tty_port_client_operations tty_port_default_client_ops = {
 	.receive_buf = tty_port_default_receive_buf,
+	.lookahead_buf = tty_port_default_lookahead_buf,
 	.write_wakeup = tty_port_default_wakeup,
 };
 EXPORT_SYMBOL_GPL(tty_port_default_client_ops);
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 3b9d77604291..1796648c2907 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -15,6 +15,7 @@ struct tty_buffer {
 	int used;
 	int size;
 	int commit;
+	int lookahead;		/* Lazy update on recv, can become less than "read" */
 	int read;
 	int flags;
 	/* Data points here */
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index e85002b56752..bf8143fbcff3 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -186,6 +186,17 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	indicate all data received is %TTY_NORMAL. If assigned, prefer this
  *	function for automatic flow control.
  *
+ * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
+ *			const unsigned char *cp, const char *fp, int count)
+ *
+ *	This function is called by the low-level tty driver for characters
+ *	not eaten by receive_buf or receive_buf2. It is useful for processing
+ *	high-priority characters such as software flow-control characters that
+ *	could otherwise get stuck into the intermediate buffer until tty has
+ *	room to receive them. Ldisc must be able to handle later a receive_buf
+ *	or receive_buf2 call for the same characters (e.g. by skipping the
+ *	actions for high-priority characters already handled by lookahead_buf).
+ *
  * @owner: module containting this ldisc (for reference counting)
  *
  * This structure defines the interface between the tty line discipline
@@ -229,6 +240,8 @@ struct tty_ldisc_ops {
 	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
 				const char *fp, int count);
+	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
+				 const unsigned char *fp, unsigned int count);
 
 	struct  module *owner;
 };
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 58e9619116b7..fa3c3bdaa234 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -40,6 +40,8 @@ struct tty_port_operations {
 
 struct tty_port_client_operations {
 	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
+	void (*lookahead_buf)(struct tty_port *port, const unsigned char *cp,
+			      const unsigned char *fp, unsigned int count);
 	void (*write_wakeup)(struct tty_port *port);
 };
 
-- 
2.30.2

