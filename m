Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6E4F48E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388159AbiDEVxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbiDEKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:39:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E359B26113;
        Tue,  5 Apr 2022 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649154299; x=1680690299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPg5nLaZNJX/KaC2Pwn/Bqf00bUWJ7A8yovU01Es/BQ=;
  b=F+9RIjtUiZ7f5dDJbJGaKSX4we9dULSzYOumX204T+bTZlJbYDUJSdEL
   5gcNNXZF1M0CkRK+sX/D+TX2s4JGO4TR5fCbV3KOXf+BjnxjdO9cWaI6n
   MI8mlSVtSIksTX7Dg15vPlxc3TGDAjmXhMgSitgH5xnYNtYcy0KxBER+m
   H8iJdvgJoHtgUsl+F5TF6TDKiDRJXm79aUe5zlLpSSZ5aHhdZ7GlOW16Y
   WIcgg96URS8uAaIRAMwM+emfiKVnDdnT/InnJpY8k0iql08Q2N6FDwi8I
   98Euvf7EV1tq0Ige5uRd2gUHB0MP+w/AVQ+p2DQv62o0ps1P0cr1LfZmO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258300418"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258300418"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:24:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="569821975"
Received: from ksprzacz-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.41.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:24:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] tty: Implement lookahead to process XON/XOFF timely
Date:   Tue,  5 Apr 2022 13:24:37 +0300
Message-Id: <20220405102437.4842-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

The guards necessary for ensuring the XON/XOFF character are
processed only once were added by the previous patch. All this patch
needs to do on that front is to pass the lookahead count (that can
now be non-zero) into port->client_ops->receive_buf().

Reported-by: Gilles Buloz <gilles.buloz@kontron.com>
Tested-by: Gilles Buloz <gilles.buloz@kontron.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c        | 55 ++++++++++++++++++++++++---------
 drivers/tty/tty_buffer.c   | 62 ++++++++++++++++++++++++++++++++------
 drivers/tty/tty_port.c     | 22 ++++++++++++++
 include/linux/tty_buffer.h |  1 +
 include/linux/tty_ldisc.h  |  2 ++
 include/linux/tty_port.h   |  1 +
 6 files changed, 119 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e1b761740056..749218c6474f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1220,25 +1220,34 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		process_echoes(tty);
 }
 
+static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
+					 bool lookahead_done)
+{
+	if (!I_IXON(tty))
+		return false;
+
+	if (c == START_CHAR(tty)) {
+		if (!lookahead_done) {
+			start_tty(tty);
+			process_echoes(tty);
+		}
+		return true;
+	}
+	if (c == STOP_CHAR(tty)) {
+		if (!lookahead_done)
+			stop_tty(tty);
+		return true;
+	}
+	return false;
+}
+
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
 				       bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IXON(tty)) {
-		if (c == START_CHAR(tty)) {
-			if (!lookahead_done) {
-				start_tty(tty);
-				process_echoes(tty);
-			}
-			return;
-		}
-		if (c == STOP_CHAR(tty)) {
-			if (!lookahead_done)
-				stop_tty(tty);
-			return;
-		}
-	}
+	if (__n_tty_receive_char_special(tty, c, lookahead_done))
+		return;
 
 	if (L_ISIG(tty)) {
 		if (c == INTR_CHAR(tty)) {
@@ -1450,6 +1459,23 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 		n_tty_receive_char_flagged(tty, c, flag);
 }
 
+static void n_tty_lookahead_special(struct tty_struct *tty, const unsigned char *cp,
+				    const char *fp, int count)
+{
+	char flag = TTY_NORMAL;
+
+	if (!I_IXON(tty))
+		return;
+
+	while (count--) {
+		if (fp)
+			flag = *fp++;
+		if (likely(flag == TTY_NORMAL))
+			__n_tty_receive_char_special(tty, *cp, false);
+		cp++;
+	}
+}
+
 static void
 n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
 			   const char *fp, int count)
@@ -2405,6 +2431,7 @@ static struct tty_ldisc_ops n_tty_ops = {
 	.receive_buf     = n_tty_receive_buf,
 	.write_wakeup    = n_tty_write_wakeup,
 	.receive_buf2	 = n_tty_receive_buf2,
+	.lookahead_buf	 = n_tty_lookahead_special,
 };
 
 /**
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 38863fe8544f..11ae042c19ff 100644
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
+			 * paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
+			 * ensures they see all buffer data.
 			 */
 			smp_store_release(&b->commit, b->used);
-			/* paired w/ acquire in flush_to_ldisc(); ensures the
-			 * latest commit value can be read before the head is
-			 * advanced to the next buffer
+			/*
+			 * paired w/ acquire in flush_to_ldisc() and lookahead_bufs()
+			 * ensures the latest commit value can be read before the head
+			 * is advanced to the next buffer
 			 */
 			smp_store_release(&b->next, n);
 		} else if (change)
@@ -458,6 +463,41 @@ int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 }
 EXPORT_SYMBOL_GPL(tty_ldisc_receive_buf);
 
+static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
+{
+	head->lookahead = max(head->lookahead, head->read);
+
+	while (head) {
+		struct tty_buffer *next;
+		unsigned char *p;
+		char *f = NULL;
+		int count;
+
+		/*
+		 * paired w/ release in __tty_buffer_request_room();
+		 * ensures commit value read is not stale if the head
+		 * is advancing to the next buffer
+		 */
+		next = smp_load_acquire(&head->next);
+		/*
+		 * paired w/ release in __tty_buffer_request_room() or in
+		 * tty_buffer_flush(); ensures we see the committed buffer data
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
@@ -468,7 +508,7 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	n = port->client_ops->receive_buf(port, p, f, count, 0);
+	n = port->client_ops->receive_buf(port, p, f, count, max(head->lookahead - head->read, 0));
 	if (n > 0)
 		memset(p, 0, n);
 	return n;
@@ -495,7 +535,7 @@ static void flush_to_ldisc(struct work_struct *work)
 	while (1) {
 		struct tty_buffer *head = buf->head;
 		struct tty_buffer *next;
-		int count;
+		int count, rcvd;
 
 		/* Ldisc or user is trying to gain exclusive access */
 		if (atomic_read(&buf->priority))
@@ -518,10 +558,12 @@ static void flush_to_ldisc(struct work_struct *work)
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
index 0d41ec0e5fee..650f38d67159 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -44,6 +44,27 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 	return ret;
 }
 
+static void tty_port_default_lookahead_buf(struct tty_port *port,
+					   const unsigned char *p,
+					   const unsigned char *f, size_t count)
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
@@ -56,6 +77,7 @@ static void tty_port_default_wakeup(struct tty_port *port)
 
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
index 496f4755ea05..fc7b4ffe76c6 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -229,6 +229,8 @@ struct tty_ldisc_ops {
 	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
 				const char *fp, int count, int lookahead_count);
+	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
+				 const char *fp, int count);
 
 	struct  module *owner;
 };
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 1871a6a9cb00..bc768265bf63 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -40,6 +40,7 @@ struct tty_port_operations {
 
 struct tty_port_client_operations {
 	int (*receive_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t, size_t);
+	void (*lookahead_buf)(struct tty_port *port, const unsigned char *, const unsigned char *, size_t);
 	void (*write_wakeup)(struct tty_port *port);
 };
 
-- 
2.30.2

