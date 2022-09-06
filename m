Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE23E5AE5E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239947AbiIFKud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbiIFKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:49:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E23264CC;
        Tue,  6 Sep 2022 03:48:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8C1333D51;
        Tue,  6 Sep 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662461291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXg40FtDTQekKCv07crrElZ3bycY17ctga5/37ZAiuE=;
        b=zsJoTTROoMn7ToJb08w/FhmULyJS6lXrjQ2hePviemxvzXYrjnhRpd8517I+WWSIXYE85C
        JXVUMZbKmt0AbgguQ9DkpfqUxAThn2AuR285rz2DJkoxCZCH/BBd98buMOQZxY+uEKoBUF
        a0c4lvrjPBT5R30q+fwiXLPTdNUMp4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662461291;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXg40FtDTQekKCv07crrElZ3bycY17ctga5/37ZAiuE=;
        b=/oMrtaxMJfXLXWF5nVTzTlHygLO2oVpeeG6F66smS4A1HlLVqKRSHflMVmGKaQ170vMvrZ
        eC5hXbzNXvcs5qDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A11862C142;
        Tue,  6 Sep 2022 10:48:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] tty: serial: move and cleanup vt8500_tx_empty()
Date:   Tue,  6 Sep 2022 12:48:02 +0200
Message-Id: <20220906104805.23211-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220906104805.23211-1-jslaby@suse.cz>
References: <20220906104805.23211-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make vt8500_tx_empty() more readable by introducing a new local variable
and move the function before handle_tx(). That way we can reuse it in
there too.

Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v3] this is new in v3 -- extracted as a separate change from later
         patches

 drivers/tty/serial/vt8500_serial.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 6f08136ce78a..9e2c745b4535 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -187,6 +187,13 @@ static void handle_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
+static unsigned int vt8500_tx_empty(struct uart_port *port)
+{
+	unsigned int idx = vt8500_read(port, VT8500_URFIDX) & 0x1f;
+
+	return idx < 16 ? TIOCSER_TEMT : 0;
+}
+
 static void handle_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
@@ -201,7 +208,7 @@ static void handle_tx(struct uart_port *port)
 		return;
 	}
 
-	while ((vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16) {
+	while (vt8500_tx_empty(port)) {
 		if (uart_circ_empty(xmit))
 			break;
 
@@ -260,12 +267,6 @@ static irqreturn_t vt8500_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static unsigned int vt8500_tx_empty(struct uart_port *port)
-{
-	return (vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16 ?
-						TIOCSER_TEMT : 0;
-}
-
 static unsigned int vt8500_get_mctrl(struct uart_port *port)
 {
 	unsigned int usr;
-- 
2.37.3

