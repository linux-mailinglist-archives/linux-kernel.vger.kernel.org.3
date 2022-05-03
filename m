Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F2A517F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiECIME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiECILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:11:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E375220F70;
        Tue,  3 May 2022 01:08:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 94E341F74C;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fwxlm4QS9N1jUYAf2KLEFq0L/ki30rlKwdaL1HhKYww=;
        b=za21kgqPy9XmQwuNXsO3Q7exIeVWorWsM3azhtRrKI6s4WtHU6ycjfmHLHwJv6WaxoLBD5
        4M1LK/3SYk9FedPkho5ZVz11fFTc+h1jMlayQA/nT3MfZl8uhJOQKAPfL1/Xhy4HEtlI6+
        gYTiwXlIeEM1rpSeN0hb8WYZiv/i4Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fwxlm4QS9N1jUYAf2KLEFq0L/ki30rlKwdaL1HhKYww=;
        b=fJXcVXP6wrFSgU0GKSNSOfaE1dqboCjgyA4mZhri6XkyMyqQgbNziZR+KqgHTT29TVoAru
        s3/8HWs85Q5viIAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 62FDA2C143;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/7] serial: pch: remove xmit circ_buf size double check
Date:   Tue,  3 May 2022 10:08:06 +0200
Message-Id: <20220503080808.28332-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220503080808.28332-1-jslaby@suse.cz>
References: <20220503080613.27601-1-jslaby@suse.cz>
 <20220503080808.28332-1-jslaby@suse.cz>
MIME-Version: 1.0
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

One is in handle_tx() (as "min(xmit->head - xmit->tail, fifo_size))",
another one in pop_tx() (as uart_circ_empty(xmit)). So keep only the
latter.

This makes the code simpler and size variable is not needed now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pch_uart.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index a90bdff60908..ae1d6b641253 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -839,9 +839,7 @@ static int dma_handle_rx(struct eg20t_port *priv)
 static unsigned int handle_tx(struct eg20t_port *priv)
 {
 	struct uart_port *port = &priv->port;
-	struct circ_buf *xmit = &port->state->xmit;
 	int fifo_size;
-	int size;
 	int tx_empty;
 
 	if (!priv->start_tx) {
@@ -862,10 +860,7 @@ static unsigned int handle_tx(struct eg20t_port *priv)
 		fifo_size--;
 	}
 
-	size = min(xmit->head - xmit->tail, fifo_size);
-	if (size < 0)
-		size = fifo_size;
-	if (size && pop_tx(priv, size))
+	if (fifo_size && pop_tx(priv, fifo_size))
 		tx_empty = 0;
 
 	priv->tx_empty = tx_empty;
-- 
2.36.0

