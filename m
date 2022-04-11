Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE8C4FB865
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbiDKJyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbiDKJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:52:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10FC41FA8;
        Mon, 11 Apr 2022 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649670567; x=1681206567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zb4raDUJRv6DOh9amAmxGDM7LuPbzCoLgt0HLNpLITA=;
  b=mYkhvr7pDtw1na4O0rUHAaiIduNb8IGYle8QnE0C+vkvCT2gjr8LlFWT
   pBjktOurYLtkARgkG8Yr6oRPQJ8uUUra+hIGCFL5PJ/hCqQscfDhnB61s
   X5mtCbdGU8EaIeNNV3fmHQSIx7hVUr9dzof6rV7vSHdX7VuBd8AyfZibM
   wH0766E1w6QStJzav8cCgVTYXnrglWaZX/MTJIyOWgC5yLalpZqAm1L1o
   Sq76zF+hgj9AKZA+kqnpZQ6HrmWvN2uE8xCOhpFXrKbmjUqVNNvv65eDx
   TZmpxxZPu3TXKw6UhfV6inmoMQXc3FhFfNQMSLzUXQ+D2yNA6QS4yr4ZS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242014230"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242014230"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572053832"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 4/5] tty: Implement lookahead to process XON/XOFF timely
Date:   Mon, 11 Apr 2022 12:48:58 +0300
Message-Id: <20220411094859.10894-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 drivers/tty/n_tty.c        | 18 +++++++++++
 drivers/tty/tty_buffer.c   | 61 +++++++++++++++++++++++++++++++-------
 drivers/tty/tty_port.c     | 21 +++++++++++++
 include/linux/tty_buffer.h |  1 +
 include/linux/tty_ldisc.h  | 11 +++++++
 include/linux/tty_port.h   |  2 ++
 6 files changed, 104 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 708cc85ac43d..fede29ed8daf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1465,6 +1465,23 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 		n_tty_receive_char_flagged(tty, c, flag);
 }
 
+static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned char *cp,
+				      const unsigned char *fp, unsigned int count)
+{
+	unsigned char flag = TTY_NORMAL;
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
@@ -2420,6 +2437,7 @@ static struct tty_ldisc_ops n_tty_ops = {
 	.receive_buf     = n_tty_receive_buf,
 	.write_wakeup    = n_tty_write_wakeup,
 	.receive_buf2	 = n_tty_receive_buf2,
+	.lookahead_buf	 = n_tty_lookahead_flow_ctrl,
 };
 
 /**
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c561110c7d4d..48600bbd40e3 100644
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
@@ -468,7 +507,7 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 	if (~head->flags & TTYB_NORMAL)
 		f = flag_buf_ptr(head, head->read);
 
-	n = port->client_ops->receive_buf(port, p, f, count, 0);
+	n = port->client_ops->receive_buf(port, p, f, count, max(head->lookahead - head->read, 0));
 	if (n > 0)
 		memset(p, 0, n);
 	return n;
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
index 45cbbf338f24..47fb8088612a 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -44,6 +44,26 @@ static int tty_port_default_receive_buf(struct tty_port *port,
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
@@ -56,6 +76,7 @@ static void tty_port_default_wakeup(struct tty_port *port)
 
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
index d81a39cff9e2..1b181a8cfd95 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -192,6 +192,15 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	performed with @lookahead_count. If assigned, prefer this function for
  *	automatic flow control.
  *
+ * @lookahead_buf: [DRV] ``void ()(struct tty_struct *tty,
+ *			const unsigned char *cp, const char *fp, int count)
+ *
+ *	This function is called by the low-level tty driver for characters
+ *	not eaten by receive_buf or receive_buf2. It is useful for processing
+ *	high-priority characters such as software flow-control characters that
+ *	could otherwise get stuck into the intermediate buffer until tty has
+ *	room to receive them.
+ *
  * @owner: module containting this ldisc (for reference counting)
  *
  * This structure defines the interface between the tty line discipline
@@ -235,6 +244,8 @@ struct tty_ldisc_ops {
 	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
 				const char *fp, int count, unsigned int lookahead_count);
+	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
+				 const unsigned char *fp, unsigned int count);
 
 	struct  module *owner;
 };
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 402470962d23..7a27cb949c4e 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -41,6 +41,8 @@ struct tty_port_operations {
 struct tty_port_client_operations {
 	int (*receive_buf)(struct tty_port *port, const unsigned char *,
 			   const unsigned char *, size_t, unsigned int lookahead_count);
+	void (*lookahead_buf)(struct tty_port *port, const unsigned char *cp,
+			      const unsigned char *fp, unsigned int count);
 	void (*write_wakeup)(struct tty_port *port);
 };
 
-- 
2.30.2

