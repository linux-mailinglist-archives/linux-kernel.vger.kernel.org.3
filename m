Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B860517F7B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiECIMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiECILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:11:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054020F6D;
        Tue,  3 May 2022 01:08:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4FA781F74A;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651565290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15tooGNI+BBIugcRnBOXnwdLyWnVLkW9CS3+fD7edxg=;
        b=FvKTjqXnjeH0EkWFVpvCZ26JsNjCWPWdv/uCfXBvo30wDiNk1yl3Zg0JEbC19QjD4piKyK
        IsObjth+vP1w5nKV93UVW71k9Y48kuNgDXLTBbtGirzB2VEs0ILCJTzcsPYVy7TD1EMdm1
        WtkOGtlXZuhQj6KQ/m5+jjHki2MsTSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651565290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15tooGNI+BBIugcRnBOXnwdLyWnVLkW9CS3+fD7edxg=;
        b=7Or1Z0e76JolPn02tdG223lguF4BEGNkBsRQ5Mv8sPnOCkTT4pIU8lMFzBMqv3hgcJBCNF
        ldQwshMv1LuFqvAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1C79C2C142;
        Tue,  3 May 2022 08:08:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/7] serial: pch: remove debug print from pop_tx
Date:   Tue,  3 May 2022 10:08:05 +0200
Message-Id: <20220503080808.28332-3-jslaby@suse.cz>
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

It makes the code overly complicated for no good reason.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/pch_uart.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 4fcb6c144b54..a90bdff60908 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -764,7 +764,7 @@ static bool pop_tx(struct eg20t_port *priv, unsigned int size)
 	struct circ_buf *xmit = &port->state->xmit;
 
 	if (uart_tx_stopped(port))
-		goto pop_tx_end;
+		return false;
 
 	while (!uart_circ_empty(xmit) && count < size) {
 		iowrite8(xmit->buf[xmit->tail], priv->membase + PCH_UART_THR);
@@ -773,10 +773,6 @@ static bool pop_tx(struct eg20t_port *priv, unsigned int size)
 		count++;
 	}
 
-pop_tx_end:
-	dev_dbg(priv->port.dev, "%d characters. Remained %d characters.(%lu)\n",
-		 count, size - count, jiffies);
-
 	return count;
 }
 
-- 
2.36.0

