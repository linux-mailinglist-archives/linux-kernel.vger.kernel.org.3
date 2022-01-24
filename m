Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1A6497944
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiAXHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:14:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58064 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiAXHOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:14:34 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D24F71F3A5;
        Mon, 24 Jan 2022 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643008472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2jHGQhYb1bp/hVAQP7G6GbfFvC58/zmtrgJPJDZ7Y0=;
        b=RRRuWmCgWoOTrdrqZd5V23PAlIts8VKuOmWrvd1JiSj6I3IpibVyDF2dbsnoViKGI4q0TY
        xTq5clbe15lqSUJtdZaHJMvfWR3aOq3H1seaKzaiqozQCD80I6572s/CX83Y9X1pM5kjcD
        ja2ViHsMsiAXPsI1TtQ3TS0UI4tHVoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643008472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2jHGQhYb1bp/hVAQP7G6GbfFvC58/zmtrgJPJDZ7Y0=;
        b=vJCiy5y8/EVbh2YC6pvUlVTbyjvkTZJJ9zVCDb8U6QXFlB2jFbTV+liJelTzlwP/Nxdw39
        uRHhSZub2aXjRGAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9AC33A3B81;
        Mon, 24 Jan 2022 07:14:32 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/11] tty: add kfifo to tty_port
Date:   Mon, 24 Jan 2022 08:14:22 +0100
Message-Id: <20220124071430.14907-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124071430.14907-1-jslaby@suse.cz>
References: <20220124071430.14907-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a kfifo inside struct tty_port. We use DECLARE_KFIFO_PTR and let
the preexisting tty_port::xmit_buf be also the buffer for the kfifo.
And handle the initialization/decomissioning along with xmit_buf, i.e.
in tty_port_alloc_xmit_buf() and tty_port_free_xmit_buf(), respectively.

This allows for kfifo use in drivers which opt-in, while others still
may use the old xmit_buf. mxser will be the first user in the next
few patches.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_port.c   | 6 +++++-
 include/linux/tty_port.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 7709ce655f44..7644834640f1 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -225,8 +225,11 @@ int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
 	/* We may sleep in get_zeroed_page() */
 	mutex_lock(&port->buf_mutex);
-	if (port->xmit_buf == NULL)
+	if (port->xmit_buf == NULL) {
 		port->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+		if (port->xmit_buf)
+			kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
+	}
 	mutex_unlock(&port->buf_mutex);
 	if (port->xmit_buf == NULL)
 		return -ENOMEM;
@@ -240,6 +243,7 @@ void tty_port_free_xmit_buf(struct tty_port *port)
 	if (port->xmit_buf != NULL) {
 		free_page((unsigned long)port->xmit_buf);
 		port->xmit_buf = NULL;
+		INIT_KFIFO(port->xmit_fifo);
 	}
 	mutex_unlock(&port->buf_mutex);
 }
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index d3ea9ed0b98e..58e9619116b7 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_TTY_PORT_H
 #define _LINUX_TTY_PORT_H
 
+#include <linux/kfifo.h>
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/tty_buffer.h>
@@ -67,6 +68,7 @@ extern const struct tty_port_client_operations tty_port_default_client_ops;
  * @mutex: locking, for open, shutdown and other port operations
  * @buf_mutex: @xmit_buf alloc lock
  * @xmit_buf: optional xmit buffer used by some drivers
+ * @xmit_fifo: optional xmit buffer used by some drivers
  * @close_delay: delay in jiffies to wait when closing the port
  * @closing_wait: delay in jiffies for output to be sent before closing
  * @drain_delay: set to zero if no pure time based drain is needed else set to
@@ -110,6 +112,7 @@ struct tty_port {
 	struct mutex		mutex;
 	struct mutex		buf_mutex;
 	unsigned char		*xmit_buf;
+	DECLARE_KFIFO_PTR(xmit_fifo, unsigned char);
 	unsigned int		close_delay;
 	unsigned int		closing_wait;
 	int			drain_delay;
-- 
2.34.1

