Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11022569D69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiGGI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiGGI0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:26:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C410FDBD;
        Thu,  7 Jul 2022 01:26:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72C642213C;
        Thu,  7 Jul 2022 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657182359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PCuKHeU5exD2FIlmfFaDt+TsqPR87bfc3vKJfUNaeA=;
        b=UNZXuSF7ZM2fMhSnj85pgd1wEoKBd9UVXC9eUZ8utbyY7RyBQPb2hYV3YYcFpFGH4Lu6w/
        eDPExIImtWhcQz4GMERH8Wf6LSv3FE9jUEsezlXNMvQEXzct15TNe1YYss27qtfGNGcvdE
        FLfeFMkCyTVnlnud3TFzszS3cXU4JhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657182359;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PCuKHeU5exD2FIlmfFaDt+TsqPR87bfc3vKJfUNaeA=;
        b=Lo88QHUFGsgpxLqYMFPza8Msrk1jlPzxDlf6HFeBLM65DLhcLwvsy6Lmchs8w+DZvuoCq/
        ZNuaazAKuiuFMYDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 377DD2C142;
        Thu,  7 Jul 2022 08:25:59 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?=E4=B8=80=E5=8F=AA=E7=8B=97?= <chennbnbnb@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hillf Danton <hdanton@sina.com>
Subject: [PATCH 2/2] tty: use new tty_insert_flip_string_and_push_buffer() in pty_write()
Date:   Thu,  7 Jul 2022 10:25:58 +0200
Message-Id: <20220707082558.9250-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707082558.9250-1-jslaby@suse.cz>
References: <20220707082558.9250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race in pty_write(). pty_write() can be called in parallel
with e.g. ioctl(TIOCSTI) or ioctl(TCXONC) which also inserts chars to
the buffer. Provided, tty_flip_buffer_push() in pty_write() is called
outside the lock, it can commit inconsistent tail. This can lead to out
of bounds writes and other issues. See the Link below.

To fix this, we have to introduce a new helper called
tty_insert_flip_string_and_push_buffer(). It does both
tty_insert_flip_string() and tty_flip_buffer_commit() under the port
lock. It also calls queue_work(), but outside the lock. See
71a174b39f10 (pty: do tty_flip_buffer_push without port->lock in
pty_write) for the reasons.

Keep the helper internal-only (in drivers' tty.h). It is not intended to
be used widely.

Link: https://seclists.org/oss-sec/2022/q2/155
Fixes: 71a174b39f10 (pty: do tty_flip_buffer_push without port->lock in pty_write)
Cc: 一只狗 <chennbnbnb@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/pty.c        | 14 ++------------
 drivers/tty/tty.h        |  3 +++
 drivers/tty/tty_buffer.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 74bfabe5b453..752dab3356d7 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -111,21 +111,11 @@ static void pty_unthrottle(struct tty_struct *tty)
 static int pty_write(struct tty_struct *tty, const unsigned char *buf, int c)
 {
 	struct tty_struct *to = tty->link;
-	unsigned long flags;
 
-	if (tty->flow.stopped)
+	if (tty->flow.stopped || !c)
 		return 0;
 
-	if (c > 0) {
-		spin_lock_irqsave(&to->port->lock, flags);
-		/* Stuff the data into the input queue of the other end */
-		c = tty_insert_flip_string(to->port, buf, c);
-		spin_unlock_irqrestore(&to->port->lock, flags);
-		/* And shovel */
-		if (c)
-			tty_flip_buffer_push(to->port);
-	}
-	return c;
+	return tty_insert_flip_string_and_push_buffer(to->port, buf, c);
 }
 
 /**
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index b710c5ef89ab..f310a8274df1 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -111,4 +111,7 @@ static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
 
 ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 
+int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
+		const unsigned char *chars, size_t cnt);
+
 #endif
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ea630ceda009..9fdecc795b6b 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -601,6 +601,37 @@ void tty_flip_buffer_push(struct tty_port *port)
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
+/**
+ * tty_insert_flip_string_and_push_buffer - add characters to the tty buffer and
+ *	push
+ * @port: tty port
+ * @chars: characters
+ * @size: size
+ *
+ * The function combines tty_insert_flip_string() and tty_flip_buffer_push()
+ * with the exception of properly holding the @port->lock.
+ *
+ * To be used only internally (by pty currently).
+ *
+ * Returns: the number added.
+ */
+int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
+		const unsigned char *chars, size_t size)
+{
+	struct tty_bufhead *buf = &port->buf;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	size = tty_insert_flip_string(port, chars, size);
+	if (size)
+		tty_flip_buffer_commit(buf->tail);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	queue_work(system_unbound_wq, &buf->work);
+
+	return size;
+}
+
 /**
  * tty_buffer_init		-	prepare a tty buffer structure
  * @port: tty port to initialise
-- 
2.36.1

